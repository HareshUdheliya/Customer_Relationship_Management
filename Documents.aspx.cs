using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Documents : System.Web.UI.Page
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

        string fix(string s)
        {
            return s.Trim().Replace("'", "''");
        }

        void runQuery(string query)
        {
            con = new SqlConnection(conStr);
            cmd = new SqlCommand(query, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
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

        bool isAdmin()
        {
            if (Session["Role"] == null) return false;
            return Session["Role"].ToString().ToLower() == "admin";
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

        // normal user can open only documents of his own customers
        bool canAccess(int id)
        {
            if (isAdmin()) return true;
            string uid = Session["UserId"].ToString();
            int n = getCount("select count(*) from Documents d where d.Id = " + id + " and d.CustomerId in (select Id from Customers where AssignedTo = " + uid + ")");
            return n > 0;
        }

        // folder where files are saved (Uploads folder in the project)
        string uploadFolder()
        {
            string folder = Server.MapPath("~/Uploads/");
            if (!Directory.Exists(folder))
                Directory.CreateDirectory(folder);
            return folder;
        }

        void fillDropdowns()
        {
            string sql = "select Id, FullName from Customers order by FullName";
            if (!isAdmin())
                sql = "select Id, FullName from Customers where AssignedTo = " + Session["UserId"].ToString() + " order by FullName";

            con = new SqlConnection(conStr);
            da = new SqlDataAdapter(sql, con);
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
            ddlDocType.SelectedIndex = 0;
            txtDocName.Text = "";

            ViewState["id"] = null;
            lblFormTitle.Text = "Upload New Document";
            btnSave.Text = "<i class='bx bx-upload me-1'></i>Upload Document";
        }

        void fillGrid()
        {
            string search = fix(txtSearch.Text);
            string uid = Session["UserId"].ToString();

            string query = "select d.*, c.FullName as CustomerName, "
                + "cast(d.FileSize / 1024 as varchar(20)) + ' KB' as FileSizeText "
                + "from Documents d left join Customers c on d.CustomerId = c.Id";

            string where = "";
            if (!isAdmin())
                where = "(d.CustomerId in (select Id from Customers where AssignedTo = " + uid + "))";

            if (search != "")
            {
                if (where != "")
                    where += " and ";
                where += "(d.DocName like '%" + search + "%' or c.FullName like '%" + search + "%' or d.DocType like '%" + search + "%')";
            }

            if (where != "")
                query += " where " + where;

            query += " order by d.Id desc";

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
            da = new SqlDataAdapter("select * from Documents where Id = " + id, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                txtDocName.Text = row["DocName"].ToString();

                ddlCustomerId.ClearSelection();
                ListItem a = ddlCustomerId.Items.FindByValue(row["CustomerId"].ToString());
                if (a != null) a.Selected = true;

                ddlDocType.ClearSelection();
                ListItem b = ddlDocType.Items.FindByValue(row["DocType"].ToString());
                if (b != null) b.Selected = true;
            }
        }

        // saves the uploaded file and returns the new file name (empty if no file)
        string saveFile(out long size)
        {
            size = 0;

            if (!fuFile.HasFile)
                return "";

            string ext = Path.GetExtension(fuFile.FileName).ToLower();
            string allowed = ".pdf .doc .docx .xls .xlsx .ppt .pptx .txt .csv .png .jpg .jpeg";

            if (!allowed.Contains(ext))
                return "BAD";

            string newName = DateTime.Now.ToString("yyyyMMddHHmmss") + "_" + Path.GetFileName(fuFile.FileName).Replace(" ", "_");
            fuFile.SaveAs(uploadFolder() + newName);
            size = fuFile.PostedFile.ContentLength;
            return newName;
        }

        void deleteFileFromDisk(string fileName)
        {
            string path = uploadFolder() + fileName;
            if (File.Exists(path))
                File.Delete(path);
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (ddlCustomerId.SelectedValue == "0")
                {
                    showMsg("Please select customer.", "warning");
                    return;
                }

                if (txtDocName.Text.Trim() == "")
                {
                    showMsg("Document name is required.", "warning");
                    return;
                }

                string user = Session["UserName"].ToString();
                long size;

                if (ViewState["id"] == null)
                {
                    // INSERT
                    if (!fuFile.HasFile)
                    {
                        showMsg("Please choose a file to upload.", "warning");
                        return;
                    }

                    string fileName = saveFile(out size);
                    if (fileName == "BAD")
                    {
                        showMsg("This file type is not allowed.", "danger");
                        return;
                    }

                    runQuery("insert into Documents (CustomerId, DocName, DocType, FilePath, FileSize, UploadedBy) values ("
                        + ddlCustomerId.SelectedValue + ", '" + fix(txtDocName.Text) + "', '" + fix(ddlDocType.SelectedValue)
                        + "', '" + fix(fileName) + "', " + size + ", '" + fix(user) + "')");

                    logActivity("Uploaded document: " + txtDocName.Text);
                    showMsg("Document uploaded successfully.", "success");
                }
                else
                {
                    // UPDATE
                    string query = "update Documents set CustomerId = " + ddlCustomerId.SelectedValue
                        + ", DocName = '" + fix(txtDocName.Text) + "', DocType = '" + fix(ddlDocType.SelectedValue) + "'";

                    if (fuFile.HasFile)
                    {
                        string fileName = saveFile(out size);
                        if (fileName == "BAD")
                        {
                            showMsg("This file type is not allowed.", "danger");
                            return;
                        }

                        // remove the old file from disk
                        con = new SqlConnection(conStr);
                        da = new SqlDataAdapter("select FilePath from Documents where Id = " + ViewState["id"], con);
                        ds = new DataSet();
                        da.Fill(ds);
                        if (ds.Tables[0].Rows.Count > 0)
                            deleteFileFromDisk(ds.Tables[0].Rows[0]["FilePath"].ToString());

                        query += ", FilePath = '" + fix(fileName) + "', FileSize = " + size;
                    }

                    query += " where Id = " + ViewState["id"];
                    runQuery(query);

                    logActivity("Updated document: " + txtDocName.Text);
                    showMsg("Document updated successfully.", "success");
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

                if (!canAccess(id))
                {
                    showMsg("You can only manage your own records.", "warning");
                    return;
                }

                if (e.CommandName == "cmd_edt")
                {
                    ViewState["id"] = id;
                    fillData(id);
                    lblFormTitle.Text = "Edit Document (ID " + id + ")";
                    btnSave.Text = "<i class='bx bx-save me-1'></i>Update Document";
                    litMsg.Text = "";
                }
                else if (e.CommandName == "cmd_dlt")
                {
                    con = new SqlConnection(conStr);
                    da = new SqlDataAdapter("select FilePath from Documents where Id = " + id, con);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                        deleteFileFromDisk(ds.Tables[0].Rows[0]["FilePath"].ToString());

                    runQuery("delete from Documents where Id = " + id);
                    logActivity("Deleted document ID " + id);

                    if (ViewState["id"] != null && ViewState["id"].ToString() == id.ToString())
                        fieldClear();

                    fillGrid();
                    showMsg("Document deleted successfully.", "success");
                }
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }
    }
}