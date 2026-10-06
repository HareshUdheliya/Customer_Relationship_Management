using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Leads : System.Web.UI.Page
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

        string num(string s)
        {
            if (s.Trim() == "") return "0";
            return s.Trim();
        }

        bool isNum(string s)
        {
            decimal d;
            if (s.Trim() == "") return true;
            return decimal.TryParse(s.Trim(), System.Globalization.NumberStyles.AllowDecimalPoint, System.Globalization.CultureInfo.InvariantCulture, out d);
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
            da = new SqlDataAdapter("select Id, FullName from Users order by FullName", con);
            ds = new DataSet();
            da.Fill(ds);
            ddlAssignedTo.DataSource = ds;
            ddlAssignedTo.DataTextField = "FullName";
            ddlAssignedTo.DataValueField = "Id";
            ddlAssignedTo.DataBind();
            ddlAssignedTo.Items.Insert(0, new ListItem("-- Unassigned --", "0"));

        }

        void fieldClear()
        {
            txtLeadName.Text = "";
            txtCompany.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlSource.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            txtValue.Text = "";
            ddlAssignedTo.SelectedIndex = 0;

            ViewState["id"] = null;
            lblFormTitle.Text = "Add New Lead";
            btnSave.Text = "<i class='bx bx-save me-1'></i>Save Lead";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);

            string query = "select l.*, u.FullName as AssignedName from Leads l left join Users u on l.AssignedTo = u.Id";

            if (search != "")
                query += " where l.LeadName like '%" + search + "%' or l.Company like '%" + search + "%' or l.Email like '%" + search + "%' or l.Phone like '%" + search + "%' or l.Source like '%" + search + "%' or l.Status like '%" + search + "%'";

            query += " order by l.Id desc";

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
            da = new SqlDataAdapter("select * from Leads where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtLeadName.Text = row["LeadName"].ToString();
                txtCompany.Text = row["Company"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"].ToString();
                setDropdown(ddlSource, row["Source"].ToString());
                setDropdown(ddlStatus, row["Status"].ToString());
                txtValue.Text = row["Value"].ToString();
                setDropdown(ddlAssignedTo, row["AssignedTo"].ToString());
            }
        }

        // ---------------------------------------------------------------
        // Validation + Insert + Update + Delete
        // ---------------------------------------------------------------

        bool validateForm()
        {
            if (txtLeadName.Text.Trim() == "")
            {
                showMsg("Lead Name is required.", "warning");
                return false;
            }
            if (!isNum(txtValue.Text))
            {
                showMsg("Expected Value (Rs.) must be a valid number.", "warning");
                return false;
            }

            return true;
        }

        void insertData()
        {
            string query = "insert into Leads (LeadName, Company, Email, Phone, Source, Status, Value, AssignedTo) values ("
                + "'" + fix(txtLeadName.Text) + "'" + ", "
                + "'" + fix(txtCompany.Text) + "'" + ", "
                + "'" + fix(txtEmail.Text) + "'" + ", "
                + "'" + fix(txtPhone.Text) + "'" + ", "
                + "'" + fix(ddlSource.SelectedValue) + "'" + ", "
                + "'" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + num(txtValue.Text) + ", "
                + ddlAssignedTo.SelectedValue
                + ")";

            runQuery(query);
            logActivity("Added lead: " + txtLeadName.Text);
        }

        void updateData()
        {
            string query = "update Leads set "
                + "LeadName='" + fix(txtLeadName.Text) + "'" + ", "
                + "Company='" + fix(txtCompany.Text) + "'" + ", "
                + "Email='" + fix(txtEmail.Text) + "'" + ", "
                + "Phone='" + fix(txtPhone.Text) + "'" + ", "
                + "Source='" + fix(ddlSource.SelectedValue) + "'" + ", "
                + "Status='" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + "Value=" + num(txtValue.Text) + ", "
                + "AssignedTo=" + ddlAssignedTo.SelectedValue
                + " where Id = " + ViewState["id"];

            runQuery(query);
            logActivity("Updated lead: " + txtLeadName.Text);
        }

        void deleteData(int id)
        {
            runQuery("delete from Leads where Id = " + id);
            logActivity("Deleted lead ID " + id);

            if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                fieldClear();

            fillGrid();
            showMsg("Lead deleted successfully.", "success");
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
                    showMsg("Lead added successfully.", "success");
                }
                else
                {
                    updateData();
                    showMsg("Lead updated successfully.", "success");
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
                    lblFormTitle.Text = "Edit Lead (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update Lead";
                    litMsg.Text = "";
                }
                else if (e.CommandName == "cmd_dlt")
                {
                    deleteData(id);
                }
                else if (e.CommandName == "cmd_convert")
                {
                    runQuery("insert into Customers (FullName, Company, Email, Phone, City, Status, AssignedTo) select LeadName, Company, Email, Phone, '', 'Active', AssignedTo from Leads where Id = " + id + "");
                    runQuery("update Leads set Status = 'Won' where Id = " + id + "");
                    logActivity("Converted lead to customer, lead ID " + id);
                    fillGrid();
                    showMsg("Lead converted to customer successfully.", "success");
                }
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }
    }
}
