using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CRM_PROJECT
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
                Response.Redirect("Default.aspx");
        }

        string fix(string s)
        {
            return s.Trim().Replace("'", "''");
        }

        void showMsg(string msg, string type)
        {
            litMsg.Text = "<div class='alert alert-" + type + "'>" + msg + "</div>";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = fix(txtFullName.Text);
            string email = fix(txtEmail.Text);
            string phone = fix(txtPhone.Text);
            string password = fix(txtPassword.Text);

            if (fullName == "" || email == "" || password == "")
            {
                showMsg("Please fill all required fields.", "warning");
                return;
            }

            if (txtPassword.Text != txtConfirmPassword.Text)
            {
                showMsg("Password and confirm password do not match.", "warning");
                return;
            }

            if (!chkTerms.Checked)
            {
                showMsg("Please accept the Terms of Service.", "warning");
                return;
            }

            try
            {
                con = new SqlConnection(conStr);
                con.Open();

                
                cmd = new SqlCommand("select count(*) from Users where Email = '" + email + "'", con);
                int found = Convert.ToInt32(cmd.ExecuteScalar());

                if (found > 0)
                {
                    con.Close();
                    showMsg("This email is already registered. Please login.", "danger");
                    return;
                }

                string role = "user";
                if (email.ToLower() == "admin@gmail.com")
                    role = "admin";

                cmd = new SqlCommand("insert into Users (FullName, Email, Phone, Password, Role) values ('"
                    + fullName + "', '" + email + "', '" + phone + "', '" + password + "', '" + role + "')", con);
                cmd.ExecuteNonQuery();
                con.Close();

                Response.Redirect("Login.aspx?registered=1");
            }
            catch (System.Threading.ThreadAbortException)
            {
                throw;
            }
            catch (Exception ex)
            {
                showMsg("Error: " + Server.HtmlEncode(ex.Message), "danger");
            }
        }
    }
}
