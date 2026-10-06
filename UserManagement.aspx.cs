using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class UserManagement : System.Web.UI.Page
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
            ddlRole.SelectedIndex = 0;
            txtPassword.Text = "";

            ViewState["id"] = null;
            lblFormTitle.Text = "Add New User";
            btnSave.Text = "<i class='bx bx-save me-1'></i>Save User";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);

            string query = "select u.Id, u.FullName, u.Email, u.Phone, u.Role from Users u";

            if (search != "")
                query += " where u.FullName like '%" + search + "%' or u.Email like '%" + search + "%' or u.Phone like '%" + search + "%' or u.Role like '%" + search + "%'";

            query += " order by u.Id desc";

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
            da = new SqlDataAdapter("select * from Users where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtFullName.Text = row["FullName"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"].ToString();
                setDropdown(ddlRole, row["Role"].ToString());
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
            if (txtEmail.Text.Trim() == "")
            {
                showMsg("Email is required.", "warning");
                return false;
            }
            if (ViewState["id"] == null && txtPassword.Text == "")
            {
                showMsg("Password is required.", "warning");
                return false;
            }
            string checkQuery = "select count(*) from Users where Email = '" + fix(txtEmail.Text) + "'";
            if (ViewState["id"] != null)
                checkQuery += " and Id <> " + ViewState["id"];
            if (getCount(checkQuery) > 0)
            {
                showMsg("This email is already used by another record.", "warning");
                return false;
            }

            return true;
        }

        void insertData()
        {
            string query = "insert into Users (FullName, Email, Phone, Role, Password) values ("
                + "'" + fix(txtFullName.Text) + "'" + ", "
                + "'" + fix(txtEmail.Text) + "'" + ", "
                + "'" + fix(txtPhone.Text) + "'" + ", "
                + "'" + fix(ddlRole.SelectedValue) + "'" + ", "
                + "'" + fix(txtPassword.Text) + "'"
                + ")";

            runQuery(query);
            logActivity("Added user: " + txtFullName.Text);
        }

        void updateData()
        {
            string pwdPart = "";
            if (txtPassword.Text != "")
                pwdPart = ", Password='" + fix(txtPassword.Text) + "'";

            string query = "update Users set "
                + "FullName='" + fix(txtFullName.Text) + "'" + ", "
                + "Email='" + fix(txtEmail.Text) + "'" + ", "
                + "Phone='" + fix(txtPhone.Text) + "'" + ", "
                + "Role='" + fix(ddlRole.SelectedValue) + "'" + pwdPart
                + " where Id = " + ViewState["id"];

            runQuery(query);
            logActivity("Updated user: " + txtFullName.Text);
        }

        void deleteData(int id)
        {
            if (Session["UserId"].ToString() == id.ToString())
            {
                showMsg("You cannot delete your own account while logged in.", "warning");
                return;
            }

            runQuery("delete from Users where Id = " + id);
            logActivity("Deleted user ID " + id);

            if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                fieldClear();

            fillGrid();
            showMsg("User deleted successfully.", "success");
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
                    showMsg("User added successfully.", "success");
                }
                else
                {
                    updateData();
                    showMsg("User updated successfully.", "success");
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
                    lblFormTitle.Text = "Edit User (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update User";
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
