using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bool isLoggedIn = Session["UserId"] != null;

                phLoggedIn.Visible = isLoggedIn;
                phLoggedOut.Visible = !isLoggedIn;

                if (isLoggedIn)
                {
                    string userName = Session["UserName"]?.ToString();
                    if (string.IsNullOrWhiteSpace(userName)) userName = "User";
                    string role = Session["Role"]?.ToString() ?? "user";
                    bool isAdmin = role.Equals("admin", StringComparison.OrdinalIgnoreCase);

                    litNavUserInitial.Text = userName.Trim().Substring(0, 1).ToUpper();
                    litNavUserName.Text = userName;
                    litNavUserNameFull.Text = userName;
                    litNavUserRole.Text = isAdmin ? "Administrator" : "User";

                    phAdminMenu.Visible = isAdmin;

                    // Set the Dashboard link based on role
                    navDashboardLink.HRef = isAdmin ? "Default.aspx" : "UserDashboard.aspx";
                }
                else
                {
                    phAdminMenu.Visible = false;
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}