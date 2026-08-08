using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                if (Session["UserName"] != null)
                {
                    litUserName.Text = Session["UserName"].ToString();
                }
            }
        }
    }
}