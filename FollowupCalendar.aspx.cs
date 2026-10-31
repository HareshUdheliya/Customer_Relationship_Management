using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;

namespace CRM_PROJECT
{
    public partial class FollowupCalendar : System.Web.UI.Page
    {
        SqlConnection con;
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

            if (!IsPostBack)
            {
                // start with the current month
                ViewState["month"] = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
                drawAll();
            }
        }

        // ---------------------------------------------------------------
        // helper methods
        // ---------------------------------------------------------------

        bool isAdmin()
        {
            if (Session["Role"] == null) return false;
            return Session["Role"].ToString().ToLower() == "admin";
        }

        DataSet getData(string query)
        {
            con = new SqlConnection(conStr);
            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);
            return ds;
        }

        // extra condition so a normal user sees only his own customers' follow-ups
        string scope()
        {
            if (isAdmin()) return "";
            return " and f.CustomerId in (select Id from Customers where AssignedTo = " + Session["UserId"].ToString() + ")";
        }

        string modeIcon(string mode)
        {
            if (mode == "Call") return "bx-phone";
            if (mode == "Email") return "bx-envelope";
            if (mode == "Meeting") return "bx-group";
            return "bx-chat";
        }

        string sqlDate(DateTime d)
        {
            return d.ToString("yyyy-MM-dd", CultureInfo.InvariantCulture);
        }

        // ---------------------------------------------------------------
        // draw everything
        // ---------------------------------------------------------------

        void drawAll()
        {
            drawCalendar();
            drawToday();
            drawOverdue();
        }

        void drawCalendar()
        {
            DateTime first = (DateTime)ViewState["month"];
            DateTime next = first.AddMonths(1);
            int daysInMonth = DateTime.DaysInMonth(first.Year, first.Month);
            int startColumn = (int)first.DayOfWeek;   // Sunday = 0 ... Saturday = 6

            litMonth.Text = first.ToString("MMMM yyyy", CultureInfo.InvariantCulture);

            DataSet d = getData("select f.Id, f.CustomerId, f.FollowupDate, f.Mode, f.Status, c.FullName "
                + "from Followups f left join Customers c on f.CustomerId = c.Id "
                + "where f.FollowupDate >= '" + sqlDate(first) + "' and f.FollowupDate < '" + sqlDate(next) + "'"
                + scope() + " order by f.Id");

            // html of every day (index 1 to 31) and how many items each day has
            string[] dayHtml = new string[32];
            int[] dayCount = new int[32];

            foreach (DataRow r in d.Tables[0].Rows)
            {
                DateTime date = Convert.ToDateTime(r["FollowupDate"]);
                int day = date.Day;
                dayCount[day]++;

                // show only 3 items per day, the rest as "+ more"
                if (dayCount[day] <= 3)
                {
                    string status = r["Status"].ToString();
                    string name = r["FullName"].ToString();
                    if (name == "") name = "Customer";

                    dayHtml[day] += "<a class='cal-chip cal-" + status + "' href='CustomerDetails.aspx?id=" + r["CustomerId"] + "' title='"
                        + Server.HtmlEncode(r["Mode"] + " - " + name + " (" + status + ")") + "'>"
                        + "<i class='bx " + modeIcon(r["Mode"].ToString()) + "'></i> " + Server.HtmlEncode(name) + "</a>";
                }
            }

            string html = "<table class='cal-table'><thead><tr>"
                + "<th>Sun</th><th>Mon</th><th>Tue</th><th>Wed</th><th>Thu</th><th>Fri</th><th>Sat</th>"
                + "</tr></thead><tbody><tr>";

            int cell = 0;

            // empty boxes before day 1
            for (int i = 0; i < startColumn; i++)
            {
                html += "<td class='cal-empty'></td>";
                cell++;
            }

            for (int day = 1; day <= daysInMonth; day++)
            {
                if (cell % 7 == 0 && cell > 0)
                    html += "</tr><tr>";

                string cls = "cal-cell";
                if (first.AddDays(day - 1).Date == DateTime.Today)
                    cls += " cal-today";

                string more = "";
                if (dayCount[day] > 3)
                    more = "<div class='cal-more'>+ " + (dayCount[day] - 3) + " more</div>";

                html += "<td class='" + cls + "'><div class='cal-num'>" + day + "</div>" + dayHtml[day] + more + "</td>";
                cell++;
            }

            // empty boxes after the last day
            while (cell % 7 != 0)
            {
                html += "<td class='cal-empty'></td>";
                cell++;
            }

            html += "</tr></tbody></table>";
            litCalendar.Text = html;
        }

        // small list used by "Today" and "Overdue" boxes
        string makeList(DataTable dt, bool showDate, string emptyText)
        {
            if (dt.Rows.Count == 0)
                return "<div class='text-muted small'>" + emptyText + "</div>";

            string html = "<ul class='crm-feed'>";

            foreach (DataRow r in dt.Rows)
            {
                string sub = r["Mode"].ToString();
                if (showDate)
                {
                    int late = (DateTime.Today - Convert.ToDateTime(r["FollowupDate"]).Date).Days;
                    sub += " - " + late + " day(s) late";
                }

                html += "<li><div class='dot'><i class='bx " + modeIcon(r["Mode"].ToString()) + "'></i></div><div>"
                    + "<a href='CustomerDetails.aspx?id=" + r["CustomerId"] + "'>" + Server.HtmlEncode(r["FullName"].ToString()) + "</a>"
                    + "<div><small>" + Server.HtmlEncode(sub) + "</small></div></div></li>";
            }

            return html + "</ul>";
        }

        void drawToday()
        {
            DataSet d = getData("select f.CustomerId, f.FollowupDate, f.Mode, c.FullName "
                + "from Followups f inner join Customers c on f.CustomerId = c.Id "
                + "where f.Status = 'Pending' and f.FollowupDate = cast(GETDATE() as date)" + scope());

            litToday.Text = makeList(d.Tables[0], false, "Nothing planned for today.");
        }

        void drawOverdue()
        {
            DataSet d = getData("select top 8 f.CustomerId, f.FollowupDate, f.Mode, c.FullName "
                + "from Followups f inner join Customers c on f.CustomerId = c.Id "
                + "where f.Status = 'Pending' and f.FollowupDate < cast(GETDATE() as date)" + scope()
                + " order by f.FollowupDate");

            litOverdue.Text = makeList(d.Tables[0], true, "No overdue follow-ups. Great!");
        }

        // ---------------------------------------------------------------
        // button events
        // ---------------------------------------------------------------

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            ViewState["month"] = ((DateTime)ViewState["month"]).AddMonths(-1);
            drawCalendar();
            drawToday();
            drawOverdue();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            ViewState["month"] = ((DateTime)ViewState["month"]).AddMonths(1);
            drawCalendar();
            drawToday();
            drawOverdue();
        }

        protected void btnToday_Click(object sender, EventArgs e)
        {
            ViewState["month"] = new DateTime(DateTime.Today.Year, DateTime.Today.Month, 1);
            drawCalendar();
            drawToday();
            drawOverdue();
        }
    }
}