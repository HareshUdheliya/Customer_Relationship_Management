using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CRM_PROJECT
{
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

        string userId;
        string query;

        string name;
        string email;
        string phone;
        string role;

        string currentPassword;
        string newPassword;
        string confirmPassword;
        string oldPassword;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        void LoadProfile()
        {
            userId = Session["UserId"].ToString();

            con = new SqlConnection(conStr);

            query = "SELECT FullName, Email, Phone, Role FROM Users WHERE Id = " + userId;

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();

            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                name = ds.Tables[0].Rows[0]["FullName"].ToString();
                email = ds.Tables[0].Rows[0]["Email"].ToString();
                phone = ds.Tables[0].Rows[0]["Phone"].ToString();
                role = ds.Tables[0].Rows[0]["Role"].ToString();

                txtFullName.Text = name;
                txtEmail.Text = email;
                txtPhone.Text = phone;

                if (role.ToLower() == "admin")
                {
                    txtRole.Text = "Administrator";
                    litDisplayRole.Text = "Administrator";
                }
                else
                {
                    txtRole.Text = "User";
                    litDisplayRole.Text = "User";
                }

                litDisplayName.Text = name;

                if (name != "")
                {
                    litAvatarInitial.Text = name.Substring(0, 1).ToUpper();
                }
                else
                {
                    litAvatarInitial.Text = "U";
                }
            }
        }

        protected void btnSaveProfile_Click(object sender, EventArgs e)
        {
            userId = Session["UserId"].ToString();

            name = txtFullName.Text.Trim();
            email = txtEmail.Text.Trim();
            phone = txtPhone.Text.Trim();

            if (name == "" || email == "")
            {
                litProfileMsg.Text =
                    "<div class=\"alert alert-warning\">Full name and email are required.</div>";

                return;
            }

            con = new SqlConnection(conStr);

            query = "UPDATE Users SET FullName = '" + name +
                    "', Email = '" + email +
                    "', Phone = '" + phone +
                    "' WHERE Id = " + userId;

            cmd = new SqlCommand(query, con);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            Session["UserName"] = name;

            litDisplayName.Text = name;
            litAvatarInitial.Text = name.Substring(0, 1).ToUpper();

            litProfileMsg.Text =
                "<div class=\"alert alert-success\">Profile updated successfully.</div>";
        }

        protected void btnUpdatePassword_Click(object sender, EventArgs e)
        {
            userId = Session["UserId"].ToString();

            currentPassword = txtCurrentPassword.Text;
            newPassword = txtNewPassword.Text;
            confirmPassword = txtConfirmPassword.Text;

            if (currentPassword == "" ||
                newPassword == "" ||
                confirmPassword == "")
            {
                litPasswordMsg.Text =
                    "<div class=\"alert alert-warning\">Please fill in all password fields.</div>";

                return;
            }

            if (newPassword != confirmPassword)
            {
                litPasswordMsg.Text =
                    "<div class=\"alert alert-warning\">New password and confirm password do not match.</div>";

                return;
            }

            con = new SqlConnection(conStr);

            query = "SELECT Password FROM Users WHERE Id = " + userId;

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();

            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                oldPassword = ds.Tables[0].Rows[0]["Password"].ToString();

                if (oldPassword != currentPassword)
                {
                    litPasswordMsg.Text =
                        "<div class=\"alert alert-danger\">Current password is incorrect.</div>";

                    return;
                }
            }

            query = "UPDATE Users SET Password = '" + newPassword +
                    "' WHERE Id = " + userId;

            cmd = new SqlCommand(query, con);

            con.Open();

            cmd.ExecuteNonQuery();

            con.Close();

            txtCurrentPassword.Text = "";
            txtNewPassword.Text = "";
            txtConfirmPassword.Text = "";

            litPasswordMsg.Text =
                "<div class=\"alert alert-success\">Password updated successfully.</div>";
        }
    }
}