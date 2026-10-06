using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace CRM_PROJECT
{
    public partial class Reports : System.Web.UI.Page
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
                loadReports();
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

        // builds the bar chart html for a column of a table
        string makeBars(string table, string column, string[] names, string color)
        {
            int total = getCount("select count(*) from " + table);
            string html = "";

            for (int i = 0; i < names.Length; i++)
            {
                int n = getCount("select count(*) from " + table + " where " + column + " = '" + names[i] + "'");
                int percent = 0;
                if (total > 0) percent = n * 100 / total;

                html += "<div class='crm-bar-row'><div class='top'><span>" + names[i] + "</span><strong>" + n + " (" + percent + "%)</strong></div>"
                      + "<div class='crm-bar " + color + "'><span style='width:" + percent + "%'></span></div></div>";
            }

            return html;
        }

        void loadReports()
        {
            int customers = getCount("select count(*) from Customers");
            int leads = getCount("select count(*) from Leads");
            int won = getCount("select count(*) from Leads where Status = 'Won'");

            litCustomers.Text = customers.ToString();
            litLeads.Text = leads.ToString();

            con = new SqlConnection(conStr);
            cmd = new SqlCommand("select isnull(sum(Value), 0) from Leads where Status <> 'Lost'", con);
            con.Open();
            decimal value = Convert.ToDecimal(cmd.ExecuteScalar());
            con.Close();
            litValue.Text = value.ToString("N0");

            int rate = 0;
            if (leads > 0) rate = won * 100 / leads;
            litRate.Text = rate + "%";

            litLeadBars.Text = makeBars("Leads", "Status", new string[] { "New", "Contacted", "Qualified", "Proposal", "Won", "Lost" }, "");
            litTaskBars.Text = makeBars("Tasks", "Status", new string[] { "Pending", "In Progress", "Completed" }, "green");
            litSourceBars.Text = makeBars("Leads", "Source", new string[] { "Website", "Referral", "Social Media", "Cold Call", "Email Campaign", "Other" }, "orange");
            litDeptBars.Text = makeBars("Employees", "Department", new string[] { "Sales", "Marketing", "Support", "HR", "IT", "Finance", "Operations" }, "");
        }

        // makes one csv cell safe
        string csvCell(string s)
        {
            return "\"" + s.Replace("\"", "\"\"") + "\"";
        }

        protected void btnExport_Click(object sender, EventArgs e)
        {
            string table = ddlExport.SelectedValue;

            con = new SqlConnection(conStr);
            da = new SqlDataAdapter("select * from " + table, con);
            ds = new DataSet();
            da.Fill(ds);

            DataTable dt = ds.Tables[0];
            StringBuilder sb = new StringBuilder();

            for (int i = 0; i < dt.Columns.Count; i++)
            {
                if (i > 0) sb.Append(",");
                sb.Append(csvCell(dt.Columns[i].ColumnName));
            }
            sb.AppendLine();

            foreach (DataRow row in dt.Rows)
            {
                for (int i = 0; i < dt.Columns.Count; i++)
                {
                    if (i > 0) sb.Append(",");
                    sb.Append(csvCell(row[i].ToString()));
                }
                sb.AppendLine();
            }

            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", "attachment; filename=" + table + "_" + DateTime.Now.ToString("yyyyMMdd") + ".csv");
            Response.Write(sb.ToString());
            Response.End();
        }
    }
}
