using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CRM_PROJECT
{
    public partial class Register : System.Web.UI.Page
    {

        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;
        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                fillGrid();
            }
        }


        void getCon()
        {
            if (con == null)
            {
                con = new SqlConnection(conStr);
            }

            if (con.State == ConnectionState.Closed)
            {
                con.Open();
            }
        }

        void fieldClear()
        {
            txtFullName.Text = string.Empty;
            txtFullName.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
        }

        void fillGrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from users", con);
            ds = new DataSet();
            da.Fill(ds);
            Usergv.DataSource = ds;
            Usergv.DataBind();
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (password != confirmPassword) return;

            string role = "user";
            if (email.ToLower() == "admin123@gmail.com")
            {
                role = "admin";
            }


            try
            {
                getCon();
                cmd = new SqlCommand("INSERT INTO Users (FullName, Email, Password, Role) VALUES ('" + fullName + "', '" + email + "', '" + password + "', '" + role + "')", con);
                cmd.ExecuteNonQuery();
                fillGrid();
                fieldClear();

                Response.Redirect("Login.aspx?registered=1");
            }
            catch (Exception ex)
            {
                // Handle exception
            }
        }
    }
}

