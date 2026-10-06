using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CRM_PROJECT
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        SqlConnection con;
        SqlCommand cmd;

        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // do not let the browser keep an old copy of the page
            // (this was the reason the Login button looked wrong after login / back button)
            Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddDays(-1));

            // NOTE: no "if (!IsPostBack)" here. This must run on EVERY request,
            // otherwise the navbar state is wrong after a button click.
            bool isLoggedIn = Session["UserId"] != null;

            phSidebar.Visible = isLoggedIn;
            phNavbar.Visible = isLoggedIn;

            if (!isLoggedIn)
            {
                // login / register page: no sidebar, no navbar
                bodyTag.Attributes["class"] = "no-sidebar";
                return;
            }

            string userName = "User";
            if (Session["UserName"] != null) userName = Session["UserName"].ToString();
            if (userName.Trim() == "") userName = "User";

            string role = "user";
            if (Session["Role"] != null) role = Session["Role"].ToString();
            bool isAdmin = role.ToLower() == "admin";

            litNavUserInitial.Text = userName.Trim().Substring(0, 1).ToUpper();
            litNavUserName.Text = Server.HtmlEncode(userName);
            litNavUserNameFull.Text = Server.HtmlEncode(userName);
            litNavUserRole.Text = isAdmin ? "Administrator" : "User";

            phAdminMenu.Visible = isAdmin;

            if (isAdmin)
                navDashboardLink.HRef = "Default.aspx";
            else
                navDashboardLink.HRef = "UserDashboard.aspx";

            loadNotifications(isAdmin);
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

        void loadNotifications(bool isAdmin)
        {
            string userId = Session["UserId"].ToString();

            string taskWhere = "Status <> 'Completed'";
            string followWhere = "Status = 'Pending' and FollowupDate <= GETDATE()";

            if (!isAdmin)
                taskWhere += " and AssignedTo = " + userId;

            int pendingTasks = 0;
            int dueFollowups = 0;

            try
            {
                pendingTasks = getCount("select count(*) from Tasks where " + taskWhere);
                dueFollowups = getCount("select count(*) from Followups where " + followWhere);
            }
            catch (Exception)
            {
                // database tables not created yet - ignore so the page still opens
            }

            int total = pendingTasks + dueFollowups;

            if (total > 0)
                litNotifCount.Text = "<span class='crm-notif-badge'>" + total + "</span>";

            string items = "";

            if (pendingTasks > 0)
                items += "<li><a class='dropdown-item' href='Tasks.aspx'><i class='bx bx-task me-2 text-warning'></i>" + pendingTasks + " pending task(s)</a></li>";

            if (dueFollowups > 0)
                items += "<li><a class='dropdown-item' href='Followups.aspx'><i class='bx bx-calendar-check me-2 text-info'></i>" + dueFollowups + " follow-up(s) due</a></li>";

            if (items == "")
                items = "<li class='px-2 py-3 text-center text-muted small'>No new notifications</li>";

            litNotifItems.Text = items;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx?logout=1");
        }
    }
}
