using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader reader;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                RedirectBasedOnRole(Session["Role"]?.ToString());
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

            con = new SqlConnection(conStr);
            string query = "SELECT Id, FullName, Role FROM Users WHERE Email = '" + email + "' AND Password = '" + password + "'";
            cmd = new SqlCommand(query, con);

            try
            {
                con.Open();
                reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    Session["UserId"] = reader["Id"].ToString();
                    Session["UserName"] = reader["FullName"].ToString();
                    Session["Role"] = reader["Role"].ToString();

                    RedirectBasedOnRole(Session["Role"].ToString());
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
            finally
            {
                if (reader != null) reader.Close();
                if (con != null) con.Close();
            }
        }

        private void RedirectBasedOnRole(string role)
        {
            if (string.Equals(role, "admin", StringComparison.OrdinalIgnoreCase))
            {
                Response.Redirect("Default.aspx");
            }
            else
            {
                Response.Redirect("UserDashboard.aspx");
            }
        }
    }
}