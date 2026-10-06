using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Customers : System.Web.UI.Page
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
            txtFullName.Text = "";
            txtCompany.Text = "";
            txtEmail.Text = "";
            txtPhone.Text = "";
            txtCity.Text = "";
            ddlStatus.SelectedIndex = 0;
            ddlAssignedTo.SelectedIndex = 0;

            ViewState["id"] = null;
            lblFormTitle.Text = "Add New Customer";
            btnSave.Text = "<i class='bx bx-save me-1'></i>Save Customer";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);

            string query = "select c.*, u.FullName as AssignedName from Customers c left join Users u on c.AssignedTo = u.Id";

            if (search != "")
                query += " where c.FullName like '%" + search + "%' or c.Company like '%" + search + "%' or c.Email like '%" + search + "%' or c.Phone like '%" + search + "%' or c.City like '%" + search + "%'";

            query += " order by c.Id desc";

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
            da = new SqlDataAdapter("select * from Customers where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtFullName.Text = row["FullName"].ToString();
                txtCompany.Text = row["Company"].ToString();
                txtEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"].ToString();
                txtCity.Text = row["City"].ToString();
                setDropdown(ddlStatus, row["Status"].ToString());
                setDropdown(ddlAssignedTo, row["AssignedTo"].ToString());
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

            return true;
        }

        void insertData()
        {
            string query = "insert into Customers (FullName, Company, Email, Phone, City, Status, AssignedTo) values ("
                + "'" + fix(txtFullName.Text) + "'" + ", "
                + "'" + fix(txtCompany.Text) + "'" + ", "
                + "'" + fix(txtEmail.Text) + "'" + ", "
                + "'" + fix(txtPhone.Text) + "'" + ", "
                + "'" + fix(txtCity.Text) + "'" + ", "
                + "'" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + ddlAssignedTo.SelectedValue
                + ")";

            runQuery(query);
            logActivity("Added customer: " + txtFullName.Text);
        }

        void updateData()
        {
            string query = "update Customers set "
                + "FullName='" + fix(txtFullName.Text) + "'" + ", "
                + "Company='" + fix(txtCompany.Text) + "'" + ", "
                + "Email='" + fix(txtEmail.Text) + "'" + ", "
                + "Phone='" + fix(txtPhone.Text) + "'" + ", "
                + "City='" + fix(txtCity.Text) + "'" + ", "
                + "Status='" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + "AssignedTo=" + ddlAssignedTo.SelectedValue
                + " where Id = " + ViewState["id"];

            runQuery(query);
            logActivity("Updated customer: " + txtFullName.Text);
        }

        void deleteData(int id)
        {
            // remove everything that belongs to this customer first
            runQuery("delete from Followups where CustomerId = " + id);
            runQuery("delete from Notes where CustomerId = " + id);
            runQuery("delete from Documents where CustomerId = " + id);
            runQuery("delete from Customers where Id = " + id);
            logActivity("Deleted customer ID " + id);

            if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                fieldClear();

            fillGrid();
            showMsg("Customer deleted successfully.", "success");
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
                    showMsg("Customer added successfully.", "success");
                }
                else
                {
                    updateData();
                    showMsg("Customer updated successfully.", "success");
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
                    lblFormTitle.Text = "Edit Customer (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update Customer";
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
