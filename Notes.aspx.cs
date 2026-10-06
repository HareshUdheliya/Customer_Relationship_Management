using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Notes : System.Web.UI.Page
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
            txtTitle.Text = "";
            txtNoteText.Text = "";

            ViewState["id"] = null;
            lblFormTitle.Text = "Add New Note";
            btnSave.Text = "<i class='bx bx-save me-1'></i>Save Note";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);

            string query = "select n.*, c.FullName as CustomerName from Notes n left join Customers c on n.CustomerId = c.Id";

            if (search != "")
                query += " where n.Title like '%" + search + "%' or n.NoteText like '%" + search + "%' or c.FullName like '%" + search + "%' or n.CreatedBy like '%" + search + "%'";

            query += " order by n.Id desc";

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
            da = new SqlDataAdapter("select * from Notes where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                setDropdown(ddlCustomerId, row["CustomerId"].ToString());
                txtTitle.Text = row["Title"].ToString();
                txtNoteText.Text = row["NoteText"].ToString();
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
            if (txtTitle.Text.Trim() == "")
            {
                showMsg("Note Title is required.", "warning");
                return false;
            }
            if (txtNoteText.Text.Trim() == "")
            {
                showMsg("Note is required.", "warning");
                return false;
            }

            return true;
        }

        void insertData()
        {
            string query = "insert into Notes (CustomerId, Title, NoteText, CreatedBy) values ("
                + ddlCustomerId.SelectedValue + ", "
                + "'" + fix(txtTitle.Text) + "'" + ", "
                + "'" + fix(txtNoteText.Text) + "'" + ", "
                + "'" + fix(Session["UserName"].ToString()) + "'"
                + ")";

            runQuery(query);
            logActivity("Added note: " + txtTitle.Text);
        }

        void updateData()
        {
            string query = "update Notes set "
                + "CustomerId=" + ddlCustomerId.SelectedValue + ", "
                + "Title='" + fix(txtTitle.Text) + "'" + ", "
                + "NoteText='" + fix(txtNoteText.Text) + "'"
                + " where Id = " + ViewState["id"];

            runQuery(query);
            logActivity("Updated note: " + txtTitle.Text);
        }

        void deleteData(int id)
        {
            runQuery("delete from Notes where Id = " + id);
            logActivity("Deleted note ID " + id);

            if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                fieldClear();

            fillGrid();
            showMsg("Note deleted successfully.", "success");
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
                    showMsg("Note added successfully.", "success");
                }
                else
                {
                    updateData();
                    showMsg("Note updated successfully.", "success");
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
                    lblFormTitle.Text = "Edit Note (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update Note";
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
