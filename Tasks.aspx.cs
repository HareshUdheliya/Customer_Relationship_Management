using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Tasks : System.Web.UI.Page
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
            txtTitle.Text = "";
            txtDueDate.Text = "";
            ddlPriority.SelectedIndex = 0;
            ddlStatus.SelectedIndex = 0;
            ddlAssignedTo.SelectedIndex = 0;
            txtDescription.Text = "";

            ViewState["id"] = null;
            lblFormTitle.Text = "Add New Task";
            btnSave.Text = "<i class='bx bx-save me-1'></i>Save Task";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);

            string query = "select t.*, u.FullName as AssignedName from Tasks t left join Users u on t.AssignedTo = u.Id";

            if (search != "")
                query += " where t.Title like '%" + search + "%' or t.Description like '%" + search + "%' or t.Priority like '%" + search + "%' or t.Status like '%" + search + "%' or u.FullName like '%" + search + "%'";

            query += " order by t.Id desc";

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
            da = new SqlDataAdapter("select * from Tasks where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtTitle.Text = row["Title"].ToString();
                if (row["DueDate"] != DBNull.Value) txtDueDate.Text = Convert.ToDateTime(row["DueDate"]).ToString("yyyy-MM-dd");
                setDropdown(ddlPriority, row["Priority"].ToString());
                setDropdown(ddlStatus, row["Status"].ToString());
                setDropdown(ddlAssignedTo, row["AssignedTo"].ToString());
                txtDescription.Text = row["Description"].ToString();
            }
        }

        // ---------------------------------------------------------------
        // Validation + Insert + Update + Delete
        // ---------------------------------------------------------------

        bool validateForm()
        {
            if (txtTitle.Text.Trim() == "")
            {
                showMsg("Task Title is required.", "warning");
                return false;
            }
            if (txtDueDate.Text.Trim() == "")
            {
                showMsg("Due Date is required.", "warning");
                return false;
            }

            return true;
        }

        void insertData()
        {
            string query = "insert into Tasks (Title, DueDate, Priority, Status, AssignedTo, Description) values ("
                + "'" + fix(txtTitle.Text) + "'" + ", "
                + "'" + fix(txtDueDate.Text) + "'" + ", "
                + "'" + fix(ddlPriority.SelectedValue) + "'" + ", "
                + "'" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + ddlAssignedTo.SelectedValue + ", "
                + "'" + fix(txtDescription.Text) + "'"
                + ")";

            runQuery(query);
            logActivity("Added task: " + txtTitle.Text);
        }

        void updateData()
        {
            string query = "update Tasks set "
                + "Title='" + fix(txtTitle.Text) + "'" + ", "
                + "DueDate='" + fix(txtDueDate.Text) + "'" + ", "
                + "Priority='" + fix(ddlPriority.SelectedValue) + "'" + ", "
                + "Status='" + fix(ddlStatus.SelectedValue) + "'" + ", "
                + "AssignedTo=" + ddlAssignedTo.SelectedValue + ", "
                + "Description='" + fix(txtDescription.Text) + "'"
                + " where Id = " + ViewState["id"];

            runQuery(query);
            logActivity("Updated task: " + txtTitle.Text);
        }

        void deleteData(int id)
        {
            runQuery("delete from Tasks where Id = " + id);
            logActivity("Deleted task ID " + id);

            if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                fieldClear();

            fillGrid();
            showMsg("Task deleted successfully.", "success");
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
                    showMsg("Task added successfully.", "success");
                }
                else
                {
                    updateData();
                    showMsg("Task updated successfully.", "success");
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
                    lblFormTitle.Text = "Edit Task (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update Task";
                    litMsg.Text = "";
                }
                else if (e.CommandName == "cmd_dlt")
                {
                    deleteData(id);
                }
                else if (e.CommandName == "cmd_done")
                {
                    runQuery("update Tasks set Status = 'Completed' where Id = " + id + "");
                    logActivity("Completed task ID " + id);
                    fillGrid();
                    showMsg("Task marked as completed.", "success");
                }
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }
    }
}
