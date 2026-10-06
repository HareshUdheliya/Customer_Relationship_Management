using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class ActivityLog : System.Web.UI.Page
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
                fillGrid();
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

        void fillGrid()
        {
            string search = fix(txtSearch.Text);
            string query = "select * from ActivityLog";

            if (search != "")
                query += " where UserName like '%" + search + "%' or Action like '%" + search + "%'";

            query += " order by Id desc";

            con = new SqlConnection(conStr);
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            gv.DataSource = ds;
            gv.DataBind();

            litTotal.Text = ds.Tables[0].Rows.Count.ToString();
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

        protected void btnClear_Click(object sender, EventArgs e)
        {
            runQuery("delete from ActivityLog");
            fillGrid();
            litMsg.Text = "<div class='alert alert-success'>Activity log cleared.</div>";
        }

        protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_dlt")
            {
                runQuery("delete from ActivityLog where Id = " + Convert.ToInt32(e.CommandArgument));
                fillGrid();
            }
        }
    }
}
