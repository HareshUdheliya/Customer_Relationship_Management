using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Employees : System.Web.UI.Page
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

            string role = "user";
            if (Session["Role"] != null) role = Session["Role"].ToString();
            if (role.ToLower() != "admin")
            {
                Response.Redirect("UserDashboard.aspx");
                return;
            }
            if (!IsPostBack)
            {
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

        void fieldClear()
        {
            txtFullName.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            ddlDepartment.SelectedIndex = 0;
            txtDesignation.Text = "";
            txtSalary.Text = "";
            txtJoinDate.Text = "";
            ddlStatus.SelectedIndex = 0;

            ViewState["id"] = null;
            lblFormTitle.Text = "Add New Employee";
            btnSave.Text = "<i class='bx bx-save me-1'></i>Save Employee";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);

            string query = "select e.* from Employees e";

            if (search != "")
                query += " where e.FullName like '%" + search + "%' or e.Email like '%" + search + "%' or e.Phone like '%" + search + "%' or e.Department like '%" + search + "%' or e.Designation like '%" + search + "%'";

            query += " order by e.Id desc";

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
            da = new SqlDataAdapter("select * from Employees where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtFullName.Text = row["FullName"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"].ToString();
                setDropdown(ddlDepartment, row["Department"].ToString());
                txtDesignation.Text = row["Designation"].ToString();
                txtSalary.Text = row["Salary"].ToString();
                if (row["JoinDate"] != DBNull.Value) txtJoinDate.Text = Convert.ToDateTime(row["JoinDate"]).ToString("yyyy-MM-dd");
                setDropdown(ddlStatus, row["Status"].ToString());
            }
        }

        // ---------------------------------------------------------------
        // Validation + Insert + Update + Delete
        // ---------------------------------------------------------------

        bool validateForm()
        {
            if (txtFullName.Text.Trim() == "")
            {
                showMsg("Full Name is required.", "warning");
                return false;
            }
            if (!isNum(txtSalary.Text))
            {
                showMsg("Salary (Rs.) must be a valid number.", "warning");
                return false;
            }
            if (txtJoinDate.Text.Trim() == "")
            {
                showMsg("Joining Date is required.", "warning");
                return false;
            }

            return true;
        }

        void insertData()
        {
            string query = "insert into Employees (FullName, Email, Phone, Department, Designation, Salary, JoinDate, Status) values ("
                + "'" + fix(txtFullName.Text) + "'" + ", "
                + "'" + fix(txtEmail.Text) + "'" + ", "
                + "'" + fix(txtPhone.Text) + "'" + ", "
                + "'" + fix(ddlDepartment.SelectedValue) + "'" + ", "
                + "'" + fix(txtDesignation.Text) + "'" + ", "
                + num(txtSalary.Text) + ", "
                + "'" + fix(txtJoinDate.Text) + "'" + ", "
                + "'" + fix(ddlStatus.SelectedValue) + "'"
                + ")";

            runQuery(query);
            logActivity("Added employee: " + txtFullName.Text);
        }

        void updateData()
        {
            string query = "update Employees set "
                + "FullName='" + fix(txtFullName.Text) + "'" + ", "
                + "Email='" + fix(txtEmail.Text) + "'" + ", "
                + "Phone='" + fix(txtPhone.Text) + "'" + ", "
                + "Department='" + fix(ddlDepartment.SelectedValue) + "'" + ", "
                + "Designation='" + fix(txtDesignation.Text) + "'" + ", "
                + "Salary=" + num(txtSalary.Text) + ", "
                + "JoinDate='" + fix(txtJoinDate.Text) + "'" + ", "
                + "Status='" + fix(ddlStatus.SelectedValue) + "'"
                + " where Id = " + ViewState["id"];

            runQuery(query);
            logActivity("Updated employee: " + txtFullName.Text);
        }

        void deleteData(int id)
        {
            runQuery("delete from Employees where Id = " + id);
            logActivity("Deleted employee ID " + id);

            if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                fieldClear();

            fillGrid();
            showMsg("Employee deleted successfully.", "success");
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
                    showMsg("Employee added successfully.", "success");
                }
                else
                {
                    updateData();
                    showMsg("Employee updated successfully.", "success");
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
                    lblFormTitle.Text = "Edit Employee (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update Employee";
                    litMsg.Text = "";
                }
                else if (e.CommandName == "cmd_dlt")
                {
                    deleteData(id);
                }
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }
    }
}
