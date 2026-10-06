using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CRM_PROJECT
{
    public partial class Default : System.Web.UI.Page
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
                litName.Text = Server.HtmlEncode(Session["UserName"].ToString());
                loadCounts();
                loadLeadBars();
                loadGrids();
                loadActivity();
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

        DataSet getData(string query)
        {
            con = new SqlConnection(conStr);
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        void loadCounts()
        {
            litLeads.Text = getCount("select count(*) from Leads").ToString();
            litCustomers.Text = getCount("select count(*) from Customers").ToString();
            litTasks.Text = getCount("select count(*) from Tasks where Status <> 'Completed'").ToString();
            litFollowups.Text = getCount("select count(*) from Followups where Status = 'Pending'").ToString();
        }

        void loadLeadBars()
        {
            int total = getCount("select count(*) from Leads");
            string[] names = { "New", "Contacted", "Qualified", "Proposal", "Won", "Lost" };
            string[] colors = { "", "orange", "", "orange", "green", "red" };
            string html = "";

            for (int i = 0; i < names.Length; i++)
            {
                int n = getCount("select count(*) from Leads where Status = '" + names[i] + "'");
                int percent = 0;
                if (total > 0) percent = n * 100 / total;

                html += "<div class='crm-bar-row'><div class='top'><span>" + names[i] + "</span><strong>" + n + "</strong></div>"
                      + "<div class='crm-bar " + colors[i] + "'><span style='width:" + percent + "%'></span></div></div>";
            }

            litLeadBars.Text = html;
        }

        void loadGrids()
        {
            gvLeads.DataSource = getData("select top 5 * from Leads order by Id desc");
            gvLeads.DataBind();

            gvTasks.DataSource = getData("select top 5 * from Tasks where Status <> 'Completed' order by DueDate");
            gvTasks.DataBind();
        }

        void loadActivity()
        {
            DataSet d = getData("select top 6 * from ActivityLog order by Id desc");
            string html = "<ul class='crm-feed'>";

            foreach (DataRow row in d.Tables[0].Rows)
            {
                html += "<li><div class='dot'><i class='bx bx-bell'></i></div><div><div>"
                      + Server.HtmlEncode(row["UserName"].ToString()) + " - " + Server.HtmlEncode(row["Action"].ToString())
                      + "</div><small>" + Convert.ToDateTime(row["CreatedDate"]).ToString("dd MMM yyyy, hh:mm tt") + "</small></div></li>";
            }

            if (d.Tables[0].Rows.Count == 0)
                html += "<li class='text-muted'>No activity yet.</li>";

            html += "</ul>";
            litActivity.Text = html;
        }
    }
}
