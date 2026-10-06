using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CRM_PROJECT
{
    public partial class UserDashboard : System.Web.UI.Page
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
                string userId = Session["UserId"].ToString();
                litUserName.Text = Server.HtmlEncode(Session["UserName"].ToString());

                litLeads.Text = getCount("select count(*) from Leads where AssignedTo = " + userId).ToString();
                litTasks.Text = getCount("select count(*) from Tasks where Status <> 'Completed' and AssignedTo = " + userId).ToString();
                litCustomers.Text = getCount("select count(*) from Customers where AssignedTo = " + userId).ToString();
                litFollowups.Text = getCount("select count(*) from Followups where Status = 'Pending'").ToString();

                con = new SqlConnection(conStr);
                da = new SqlDataAdapter("select top 8 * from Tasks where AssignedTo = " + userId + " and Status <> 'Completed' order by DueDate", con);
                ds = new DataSet();
                da.Fill(ds);
                gvTasks.DataSource = ds;
                gvTasks.DataBind();
            }
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
    }
}
