using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace CRM_PROJECT
{
    public partial class Register : System.Web.UI.Page
    {
        SqlConnection con;
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
                con = new SqlConnection(conStr);

            if (con.State == ConnectionState.Closed)
                con.Open();
        }


        void fieldClear()
        {
            txtFullName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtConfirmPassword.Text = string.Empty;
            ViewState["id"] = null;
            btnRegister.Text = "Complete Registration";
        }


        void fillGrid()
        {
            getCon();
            SqlDataAdapter da = new SqlDataAdapter("select * from Users", con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            Usergv.DataSource = ds;
            Usergv.DataBind();
        }

        void fillData(int id)
        {
            getCon();
            SqlDataAdapter da = new SqlDataAdapter("select * from Users where Id = '" + id + "'", con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                txtFullName.Text = ds.Tables[0].Rows[0]["FullName"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                txtPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
                txtConfirmPassword.Text = ds.Tables[0].Rows[0]["Password"].ToString();
            }
        }

        void insertData()
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            string role = "user";
            if (email.ToLower() == "admin123@gmail.com")
                role = "admin";

            getCon();
            SqlCommand cmd = new SqlCommand("insert into Users (FullName, Email, Password, Role) values ('" + fullName + "', '" + email + "', '" + password + "', '" + role + "')", con);
            cmd.ExecuteNonQuery();

            fillGrid();
            fieldClear();

            Response.Redirect("Login.aspx?registered=1");
        }


        void updateData()
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            string role = "user";
            if (email.ToLower() == "admin123@gmail.com")
                role = "admin";

            getCon();
            SqlCommand cmd = new SqlCommand("update Users set FullName='" + fullName + "', Email='" + email + "', Password='" + password + "', Role='" + role + "' where Id='" + ViewState["id"] + "'", con);
            cmd.ExecuteNonQuery();

            fillGrid();
            fieldClear();
        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;

            if (password != confirmPassword) return;

            try
            {
                if (btnRegister.Text == "Complete Registration")
                    insertData();
                else
                    updateData();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        protected void Usergv_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int id = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "cmd_edt")
            {
                ViewState["id"] = id;
                fillData(id);
                btnRegister.Text = "Update Account";
            }
            else if (e.CommandName == "cmd_dlt")
            {
                getCon();
                SqlCommand cmd = new SqlCommand("delete from Users where Id = '" + id + "'", con);
                cmd.ExecuteNonQuery();

                fillGrid();
                fieldClear();
            }
        }
    }
}