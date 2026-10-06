using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CRM_PROJECT
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // already logged in - go to dashboard
            // (but not when user just clicked logout)
            if (Session["UserId"] != null)
            {
                string role = "user";
                if (Session["Role"] != null) role = Session["Role"].ToString();
                RedirectBasedOnRole(role);
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim().Replace("'", "''");
            string password = txtPassword.Text.Replace("'", "''");

            if (email == "" || password == "")
            {
                litMsg.Text = "<div class='alert alert-warning'>Please enter email and password.</div>";
                return;
            }

            try
            {
                con = new SqlConnection(conStr);

                string query = "select Id, FullName, Role from Users where Email = '" + email + "' and Password = '" + password + "'";

                da = new SqlDataAdapter(query, con);
                ds = new DataSet();
                da.Fill(ds);

                if (ds.Tables[0].Rows.Count > 0)
                {
                    string role = ds.Tables[0].Rows[0]["Role"].ToString();

                    if (email.ToLower() == "admin@gmail.com")
                        role = "admin";

                    Session["UserId"] = ds.Tables[0].Rows[0]["Id"].ToString();
                    Session["UserName"] = ds.Tables[0].Rows[0]["FullName"].ToString();
                    Session["Role"] = role;

                    RedirectBasedOnRole(role);
                }
                else
                {
                    litMsg.Text = "<div class='alert alert-danger'>Invalid email or password.</div>";
                }
            }
            catch (System.Threading.ThreadAbortException)
            {
                throw;
            }
            catch (Exception ex)
            {
                litMsg.Text = "<div class='alert alert-danger'>Database error: " + Server.HtmlEncode(ex.Message) + "</div>";
            }
        }

        void RedirectBasedOnRole(string role)
        {
            if (role.ToLower() == "admin")
                Response.Redirect("Default.aspx");
            else
                Response.Redirect("UserDashboard.aspx");
        }
    }
}
