using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class CustomerDetails : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

        int custId;   // id of the customer shown on this page (comes from the address bar ?id=5)

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // read ?id= from the address bar, if wrong go back to customers list
            if (!int.TryParse(Request.QueryString["id"], out custId))
            {
                Response.Redirect("Customers.aspx");
                return;
            }

            // normal user can open only his own customer
            if (!isAdmin())
            {
                string uid = Session["UserId"].ToString();
                int n = getCount("select count(*) from Customers where Id = " + custId + " and AssignedTo = " + uid);
                if (n == 0)
                {
                    Response.Redirect("Customers.aspx");
                    return;
                }
            }

            if (!IsPostBack)
            {
                if (!loadCustomer())
                {
                    Response.Redirect("Customers.aspx");
                    return;
                }
                loadAll();
            }
        }

        // ---------------------------------------------------------------
        // helper methods
        // ---------------------------------------------------------------

        string fix(string s)
        {
            return s.Trim().Replace("'", "''");
        }

        bool isAdmin()
        {
            if (Session["Role"] == null) return false;
            return Session["Role"].ToString().ToLower() == "admin";
        }

        void runQuery(string query)
        {
            con = new SqlConnection(conStr);
            cmd = new SqlCommand(query, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        int getCount(string query)
        {
            con = new SqlConnection(conStr);
            cmd = new SqlCommand(query, con);
            con.Open();
            int n = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();
            return n;
        }

        DataSet getData(string query)
        {
            con = new SqlConnection(conStr);
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        void showMsg(string msg, string type)
        {
            litMsg.Text = "<div class='alert alert-" + type + " alert-dismissible' role='alert'>" + msg
                + "<button type='button' class='btn-close' data-bs-dismiss='alert'></button></div>";
        }

        void logActivity(string text)
        {
            string user = "System";
            if (Session["UserName"] != null) user = Session["UserName"].ToString();
            runQuery("insert into ActivityLog (UserName, Action) values ('" + fix(user) + "', '" + fix(text) + "')");
        }

        // one line of the details box
        string infoRow(string icon, string label, string value)
        {
            if (value.Trim() == "") value = "-";
            return "<div class='crm-info-row'><i class='bx " + icon + "'></i><div><small>" + label + "</small><div>"
                + Server.HtmlEncode(value) + "</div></div></div>";
        }

        // ---------------------------------------------------------------
        // load data
        // ---------------------------------------------------------------

        bool loadCustomer()
        {
            DataSet d = getData("select c.*, u.FullName as OwnerName from Customers c left join Users u on c.AssignedTo = u.Id where c.Id = " + custId);

            if (d.Tables[0].Rows.Count == 0)
                return false;

            DataRow row = d.Tables[0].Rows[0];
            string name = row["FullName"].ToString();
            string status = row["Status"].ToString();

            litName.Text = Server.HtmlEncode(name);
            litCompany.Text = Server.HtmlEncode(row["Company"].ToString() == "" ? "No company" : row["Company"].ToString());
            litAvatar.Text = name.Substring(0, 1).ToUpper();
            litStatus.Text = "<span class='badge st-" + status.Replace(" ", "") + "'>" + Server.HtmlEncode(status) + "</span>";

            string owner = row["OwnerName"].ToString();
            if (owner == "") owner = "Unassigned";

            litInfo.Text = infoRow("bx-envelope", "Email", row["Email"].ToString())
                + infoRow("bx-phone", "Phone", row["Phone"].ToString())
                + infoRow("bx-map", "City", row["City"].ToString())
                + infoRow("bx-user-check", "Account Owner", owner)
                + infoRow("bx-time", "Customer Since", Convert.ToDateTime(row["CreatedDate"]).ToString("dd MMM yyyy"));

            return true;
        }

        void loadAll()
        {
            gvFollowups.DataSource = getData("select * from Followups where CustomerId = " + custId + " order by FollowupDate desc");
            gvFollowups.DataBind();

            gvNotes.DataSource = getData("select * from Notes where CustomerId = " + custId + " order by Id desc");
            gvNotes.DataBind();

            gvDocs.DataSource = getData("select * from Documents where CustomerId = " + custId + " order by Id desc");
            gvDocs.DataBind();

            litPending.Text = getCount("select count(*) from Followups where Status = 'Pending' and CustomerId = " + custId).ToString();
            litNotes.Text = getCount("select count(*) from Notes where CustomerId = " + custId).ToString();
            litDocs.Text = getCount("select count(*) from Documents where CustomerId = " + custId).ToString();
        }

        // ---------------------------------------------------------------
        // button events
        // ---------------------------------------------------------------

        protected void btnAddFollowup_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtFDate.Text == "")
                {
                    showMsg("Please select follow-up date.", "warning");
                    return;
                }

                runQuery("insert into Followups (CustomerId, FollowupDate, Mode, Status, Remarks) values ("
                    + custId + ", '" + fix(txtFDate.Text) + "', '" + fix(ddlFMode.SelectedValue) + "', 'Pending', '" + fix(txtFRemarks.Text) + "')");

                logActivity("Added follow-up for customer ID " + custId);

                txtFDate.Text = "";
                txtFRemarks.Text = "";
                ddlFMode.SelectedIndex = 0;

                loadAll();
                showMsg("Follow-up added successfully.", "success");
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }

        protected void btnAddNote_Click(object sender, EventArgs e)
        {
            try
            {
                if (txtNTitle.Text.Trim() == "" || txtNText.Text.Trim() == "")
                {
                    showMsg("Note title and note text are required.", "warning");
                    return;
                }

                runQuery("insert into Notes (CustomerId, Title, NoteText, CreatedBy) values ("
                    + custId + ", '" + fix(txtNTitle.Text) + "', '" + fix(txtNText.Text) + "', '" + fix(Session["UserName"].ToString()) + "')");

                logActivity("Added note for customer ID " + custId);

                txtNTitle.Text = "";
                txtNText.Text = "";

                loadAll();
                showMsg("Note added successfully.", "success");
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }

        protected void gvFollowups_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);

                // "and CustomerId = custId" makes sure only this customer's record can be changed
                if (e.CommandName == "f_done")
                {
                    runQuery("update Followups set Status = 'Done' where Id = " + id + " and CustomerId = " + custId);
                    logActivity("Completed follow-up ID " + id);
                    showMsg("Follow-up marked as done.", "success");
                }
                else if (e.CommandName == "f_del")
                {
                    runQuery("delete from Followups where Id = " + id + " and CustomerId = " + custId);
                    logActivity("Deleted follow-up ID " + id);
                    showMsg("Follow-up deleted.", "success");
                }

                loadAll();
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }

        protected void gvNotes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "n_del")
                {
                    runQuery("delete from Notes where Id = " + id + " and CustomerId = " + custId);
                    logActivity("Deleted note ID " + id);
                    showMsg("Note deleted.", "success");
                }

                loadAll();
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }
    }
}