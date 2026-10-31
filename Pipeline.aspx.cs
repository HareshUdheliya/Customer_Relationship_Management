using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace CRM_PROJECT
{
    public partial class Pipeline : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string conStr = ConfigurationManager.ConnectionStrings["dbConStr"].ConnectionString;

        // the stages in order (left to right on the board)
        string[] stages = { "New", "Contacted", "Qualified", "Proposal", "Won", "Lost" };
        string[] icons = { "bx-star", "bx-phone-call", "bx-check-shield", "bx-file", "bx-trophy", "bx-x-circle" };
        string[] colors = { "#696cff", "#ff9f43", "#00bad1", "#9b59b6", "#28c76f", "#ea5455" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // the arrows on the cards are links like  Pipeline.aspx?move=5&to=Qualified
            if (Request.QueryString["move"] != null)
            {
                doMove();
                return;
            }

            if (Request.QueryString["convert"] != null)
            {
                doConvert();
                return;
            }

            // message saved by doMove / doConvert before the redirect
            if (Session["PipeMsg"] != null)
            {
                litMsg.Text = Session["PipeMsg"].ToString();
                Session["PipeMsg"] = null;
            }

            loadBoard();
        }

        // ---------------------------------------------------------------
        // helper methods
        // ---------------------------------------------------------------

        string fix(string s)
        {
            return s.Trim().Replace("'", "''");
        }

        bool isAdmin()
        {
            if (Session["Role"] == null) return false;
            return Session["Role"].ToString().ToLower() == "admin";
        }

        void runQuery(string query)
        {
            con = new SqlConnection(conStr);
            cmd = new SqlCommand(query, con);
            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
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

        void logActivity(string text)
        {
            string user = "System";
            if (Session["UserName"] != null) user = Session["UserName"].ToString();
            runQuery("insert into ActivityLog (UserName, Action) values ('" + fix(user) + "', '" + fix(text) + "')");
        }

        // is this lead allowed for the logged in user?
        bool canAccess(int id)
        {
            if (isAdmin()) return true;
            string uid = Session["UserId"].ToString();
            return getCount("select count(*) from Leads where Id = " + id + " and AssignedTo = " + uid) > 0;
        }

        void goBack(string msg, string type)
        {
            Session["PipeMsg"] = "<div class='alert alert-" + type + " alert-dismissible' role='alert'>" + msg
                + "<button type='button' class='btn-close' data-bs-dismiss='alert'></button></div>";

            // redirect to the clean address so refresh (F5) does not repeat the action
            Response.Redirect("Pipeline.aspx");
        }

        // ---------------------------------------------------------------
        // move lead to another stage
        // ---------------------------------------------------------------

        void doMove()
        {
            int id;
            string to = Request.QueryString["to"];

            if (!int.TryParse(Request.QueryString["move"], out id) || to == null)
            {
                goBack("Invalid request.", "danger");
                return;
            }

            // only allow real stage names (this also keeps the query safe)
            if (Array.IndexOf(stages, to) < 0)
            {
                goBack("Invalid stage.", "danger");
                return;
            }

            if (!canAccess(id))
            {
                goBack("You can only move your own leads.", "warning");
                return;
            }

            runQuery("update Leads set Status = '" + to + "' where Id = " + id);
            logActivity("Moved lead ID " + id + " to " + to);
            goBack("Lead moved to <strong>" + to + "</strong>.", "success");
        }

        // ---------------------------------------------------------------
        // convert a won lead into a customer
        // ---------------------------------------------------------------

        void doConvert()
        {
            int id;

            if (!int.TryParse(Request.QueryString["convert"], out id))
            {
                goBack("Invalid request.", "danger");
                return;
            }

            if (!canAccess(id))
            {
                goBack("You can only convert your own leads.", "warning");
                return;
            }

            // do not create the same customer twice
            int exists = getCount("select count(*) from Customers c, Leads l where l.Id = " + id
                + " and c.FullName = l.LeadName and isnull(c.Company, '') = isnull(l.Company, '')");

            if (exists > 0)
            {
                goBack("This lead is already a customer.", "warning");
                return;
            }

            runQuery("insert into Customers (FullName, Company, Email, Phone, City, Status, AssignedTo) "
                + "select LeadName, Company, Email, Phone, '', 'Active', AssignedTo from Leads where Id = " + id);

            logActivity("Converted lead ID " + id + " to customer (pipeline)");
            goBack("Lead converted to customer. See it in the Customers page.", "success");
        }

        // ---------------------------------------------------------------
        // build the board
        // ---------------------------------------------------------------

        void loadBoard()
        {
            string query = "select l.*, u.FullName as OwnerName from Leads l left join Users u on l.AssignedTo = u.Id";

            if (!isAdmin())
                query += " where l.AssignedTo = " + Session["UserId"].ToString();

            query += " order by l.Id desc";

            con = new SqlConnection(conStr);
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            DataTable dt = ds.Tables[0];
            string html = "";
            decimal openValue = 0;

            for (int i = 0; i < stages.Length; i++)
            {
                DataRow[] rows = dt.Select("Status = '" + stages[i] + "'");

                decimal sum = 0;
                string cards = "";

                foreach (DataRow r in rows)
                {
                    sum += Convert.ToDecimal(r["Value"]);
                    cards += makeCard(r, i);
                }

                // value of leads that are still open (not Won / Lost)
                if (stages[i] != "Won" && stages[i] != "Lost")
                    openValue += sum;

                if (cards == "")
                    cards = "<div class='kb-empty'>No leads</div>";

                html += "<div class='kb-col'>"
                    + "<div class='kb-head' style='border-top-color:" + colors[i] + "'>"
                    + "<div><i class='bx " + icons[i] + "' style='color:" + colors[i] + "'></i> <strong>" + stages[i] + "</strong></div>"
                    + "<span class='kb-count'>" + rows.Length + "</span></div>"
                    + "<div class='kb-sum'>Rs. " + sum.ToString("N0") + "</div>"
                    + cards + "</div>";
            }

            litBoard.Text = html;
            litTotalValue.Text = openValue.ToString("N0");
        }

        // html of one lead card. index = position of its stage in the stages array
        string makeCard(DataRow r, int index)
        {
            string id = r["Id"].ToString();
            string company = r["Company"].ToString();
            string owner = r["OwnerName"].ToString();
            if (owner == "") owner = "Unassigned";

            string card = "<div class='kb-card' style='border-left-color:" + colors[index] + "'>"
                + "<div class='kb-name'>" + Server.HtmlEncode(r["LeadName"].ToString()) + "</div>";

            if (company != "")
                card += "<div class='kb-line'><i class='bx bx-building-house'></i> " + Server.HtmlEncode(company) + "</div>";

            card += "<div class='kb-line'><i class='bx bx-rupee'></i> " + Convert.ToDecimal(r["Value"]).ToString("N0") + "</div>"
                + "<div class='kb-line'><i class='bx bx-user'></i> " + Server.HtmlEncode(owner) + "</div>";

            if (r["Source"].ToString() != "")
                card += "<span class='badge st-New'>" + Server.HtmlEncode(r["Source"].ToString()) + "</span>";

            // action row : previous stage, next stage, convert
            card += "<div class='kb-actions'>";

            if (index > 0 && index <= 4)
                card += "<a href='Pipeline.aspx?move=" + id + "&to=" + stages[index - 1] + "' class='crm-act crm-act-edit' title='Move to " + stages[index - 1] + "'><i class='bx bx-chevron-left'></i></a>";

            if (index < 3)
                card += "<a href='Pipeline.aspx?move=" + id + "&to=" + stages[index + 1] + "' class='crm-act crm-act-edit' title='Move to " + stages[index + 1] + "'><i class='bx bx-chevron-right'></i></a>";

            if (index == 3)
            {
                card += "<a href='Pipeline.aspx?move=" + id + "&to=Won' class='crm-act crm-act-ok' title='Mark as Won'><i class='bx bx-trophy'></i></a>";
                card += "<a href='Pipeline.aspx?move=" + id + "&to=Lost' class='crm-act crm-act-del' title='Mark as Lost'><i class='bx bx-x'></i></a>";
            }

            if (index == 4)
                card += "<a href='Pipeline.aspx?convert=" + id + "' class='crm-act crm-act-ok' title='Convert to Customer' onclick=\"return confirm('Convert this lead into a customer?');\"><i class='bx bx-user-check'></i></a>";

            if (index == 5)
                card += "<a href='Pipeline.aspx?move=" + id + "&to=New' class='crm-act crm-act-edit' title='Re-open as New'><i class='bx bx-refresh'></i></a>";

            if (index < 3)
                card += "<a href='Pipeline.aspx?move=" + id + "&to=Lost' class='crm-act crm-act-del' title='Mark as Lost'><i class='bx bx-x'></i></a>";

            card += "</div></div>";
            return card;
        }
    }
}