<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="CRM_PROJECT.UserDashboard" %>



<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>My Dashboard | CRM System</title>
  <link rel="stylesheet" href="css/pages/index.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-0">My Dashboard</h4>
      <span class="text-muted"
        >Welcome back, <asp:Literal ID="litUserName" runat="server">User</asp:Literal>. Here are your tasks for today.</span
      >
    </div>
    <button class="btn btn-primary" type="button">
      <i class="bx bx-check-circle me-1"></i> Log Activity
    </button>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-xl-3">
      <div class="card crm-stat-card h-100">
        <div class="card-body">
          <div class="d-flex align-items-center justify-content-between">
            <div>
              <p class="text-muted mb-1">My Assigned Leads</p>
              <h4 class="mb-0">12</h4>
            </div>
            <div class="crm-stat-icon bg-primary-subtle text-primary">
              <i class="bx bx-target-lock"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-sm-6 col-xl-3">
      <div class="card crm-stat-card h-100">
        <div class="card-body">
          <div class="d-flex align-items-center justify-content-between">
            <div>
              <p class="text-muted mb-1">My Active Tasks</p>
              <h4 class="mb-0">8</h4>
            </div>
            <div class="crm-stat-icon bg-warning-subtle text-warning">
              <i class="bx bx-task"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-sm-6 col-xl-3">
      <div class="card crm-stat-card h-100">
        <div class="card-body">
          <div class="d-flex align-items-center justify-content-between">
            <div>
              <p class="text-muted mb-1">My Follow-ups Today</p>
              <h4 class="mb-0">3</h4>
            </div>
            <div class="crm-stat-icon bg-info-subtle text-info">
              <i class="bx bx-calendar-check"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="col-sm-6 col-xl-3">
      <div class="card crm-stat-card h-100">
        <div class="card-body">
          <div class="d-flex align-items-center justify-content-between">
            <div>
              <p class="text-muted mb-1">Recent Notes</p>
              <h4 class="mb-0">5</h4>
            </div>
            <div class="crm-stat-icon bg-success-subtle text-success">
              <i class="bx bx-note"></i>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <!-- User specific content like "My Recent Tasks" list could go here -->
    <div class="col-12">
        <div class="card">
            <div class="card-header border-bottom">
                <h5 class="card-title mb-0">My Recent Tasks</h5>
            </div>
            <div class="card-body pt-3">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Task</th>
                                <th>Related Lead</th>
                                <th>Due Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Call regarding new proposal</td>
                                <td>Acme Corp</td>
                                <td>Today, 2:00 PM</td>
                                <td><span class="badge bg-warning-subtle text-warning">Pending</span></td>
                            </tr>
                            <tr>
                                <td>Send follow-up email</td>
                                <td>Stark Industries</td>
                                <td>Tomorrow, 10:00 AM</td>
                                <td><span class="badge bg-info-subtle text-info">In Progress</span></td>
                            </tr>
                            <tr>
                                <td>Update contact information</td>
                                <td>Wayne Enterprises</td>
                                <td>Yesterday</td>
                                <td><span class="badge bg-success-subtle text-success">Completed</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
  </div>
</asp:Content>

<asp:Content
  ID="ScriptContent"
  ContentPlaceHolderID="ContentPlaceHolder3"
  runat="server"
>
  <script src="js/dashboard.js"></script>
</asp:Content>

