using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Followups : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillDropdowns();
                fillGrid();
            }
        }

        // ---------------------------------------------------------------
        // Small helper methods
        // ---------------------------------------------------------------

        // makes text safe for a simple query (handles single quote like O'Brien)
        string fix(string s)
        {
            return s.Trim().Replace("'", "''");
        }

        // runs insert / update / delete query
        void runQuery(string query)
        {
            con = new SqlConnection(conStr);
            cmd = new SqlCommand(query, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        // returns single number from a query like select count(*)
        int getCount(string query)
        {
            con = new SqlConnection(conStr);
            cmd = new SqlCommand(query, con);
            con.Open();
            int n = Convert.ToInt32(cmd.ExecuteScalar());
            con.Close();
            return n;
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

        void setDropdown(DropDownList ddl, string value)
        {
            ddl.ClearSelection();
            ListItem item = ddl.Items.FindByValue(value);
            if (item != null) item.Selected = true;
        }

        // ---------------------------------------------------------------
        // Fill dropdowns / grid / form
        // ---------------------------------------------------------------

        void fillDropdowns()
        {
            con = new SqlConnection(conStr);
            da = new SqlDataAdapter("select Id, FullName from Customers order by FullName", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlCustomerId.DataSource = ds;
            ddlCustomerId.DataTextField = "FullName";
            ddlCustomerId.DataValueField = "Id";
            ddlCustomerId.DataBind();
            ddlCustomerId.Items.Insert(0, new ListItem("-- Select Customer --", "0"));

        }

        void fieldClear()
        {
            ddlCustomerId.SelectedIndex = 0;
            txtFollowupDate.Text = "";
            ddlMode.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            txtRemarks.Text = "";

            ViewState["id"] = null;
            lblFormTitle.Text = "Add New Follow-Up";
            btnSave.Text = "<i class='bx bx-save me-1'></i>Save Follow-Up";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);

            string query = "select f.*, c.FullName as CustomerName from Followups f left join Customers c on f.CustomerId = c.Id";

            if (search != "")
                query += " where c.FullName like '%" + search + "%' or f.Mode like '%" + search + "%' or f.Status like '%" + search + "%' or f.Remarks like '%" + search + "%'";

            query += " order by f.Id desc";

            con = new SqlConnection(conStr);
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            gv.DataSource = ds;
            gv.DataBind();

            litTotal.Text = ds.Tables[0].Rows.Count.ToString();
        }

        void fillData(int id)
        {
            con = new SqlConnection(conStr);
            da = new SqlDataAdapter("select * from Followups where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                setDropdown(ddlCustomerId, row["CustomerId"].ToString());
                if (row["FollowupDate"] != DBNull.Value) txtFollowupDate.Text = Convert.ToDateTime(row["FollowupDate"]).ToString("yyyy-MM-dd");
                setDropdown(ddlMode, row["Mode"].ToString());
                setDropdown(ddlStatus, row["Status"].ToString());
                txtRemarks.Text = row["Remarks"].ToString();
            }
        }

        // ---------------------------------------------------------------
        // Validation + Insert + Update + Delete
        // ---------------------------------------------------------------

        bool validateForm()
        {
            if (ddlCustomerId.SelectedValue == "0")
            {
                showMsg("Please select Customer.", "warning");
                return false;
            }
            if (txtFollowupDate.Text.Trim() == "")
            {
                showMsg("Follow-Up Date is required.", "warning");
                return false;
            }

            return true;
        }

        void insertData()
        {
            string query = "insert into Followups (CustomerId, FollowupDate, Mode, Status, Remarks) values ("
                + ddlCustomerId.SelectedValue + ", "
                + "'" + fix(txtFollowupDate.Text) + "'" + ", "
                + "'" + fix(ddlMode.SelectedValue) + "'" + ", "
                + "'" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + "'" + fix(txtRemarks.Text) + "'"
                + ")";

            runQuery(query);
            logActivity("Added follow-up: " + "customer ID " + ddlCustomerId.SelectedValue);
        }

        void updateData()
        {
            string query = "update Followups set "
                + "CustomerId=" + ddlCustomerId.SelectedValue + ", "
                + "FollowupDate='" + fix(txtFollowupDate.Text) + "'" + ", "
                + "Mode='" + fix(ddlMode.SelectedValue) + "'" + ", "
                + "Status='" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + "Remarks='" + fix(txtRemarks.Text) + "'"
                + " where Id = " + ViewState["id"];

            runQuery(query);
            logActivity("Updated follow-up: " + "customer ID " + ddlCustomerId.SelectedValue);
        }

        void deleteData(int id)
        {
            runQuery("delete from Followups where Id = " + id);
            logActivity("Deleted follow-up ID " + id);

            if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                fieldClear();

            fillGrid();
            showMsg("Follow-Up deleted successfully.", "success");
        }

        // ---------------------------------------------------------------
        // Button events
        // ---------------------------------------------------------------

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (!validateForm())
                    return;

                if (ViewState["id"] == null)
                {
                    insertData();
                    showMsg("Follow-Up added successfully.", "success");
                }
                else
                {
                    updateData();
                    showMsg("Follow-Up updated successfully.", "success");
                }

                fieldClear();
                fillGrid();
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            fieldClear();
            litMsg.Text = "";
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            fillGrid();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            fillGrid();
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(e.CommandArgument);

                if (e.CommandName == "cmd_edt")
                {
                    ViewState["id"] = id;
                    fillData(id);
                    lblFormTitle.Text = "Edit Follow-Up (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update Follow-Up";
                    litMsg.Text = "";
                }
                else if (e.CommandName == "cmd_dlt")
                {
                    deleteData(id);
                }
                else if (e.CommandName == "cmd_done")
                {
                    runQuery("update Followups set Status = 'Done' where Id = " + id + "");
                    logActivity("Completed follow-up ID " + id);
                    fillGrid();
                    showMsg("Follow-up marked as done.", "success");
                }
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }
    }
}
