<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ActivityLog.aspx.cs" Inherits="CRM_PROJECT.ActivityLog" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Activity Log | CRM System</title>
  <link rel="stylesheet" href="css/pages/activity-log.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div
    class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2"
  >
    <div>
      <h4 class="mb-0">Activity Log</h4>
      <span class="text-muted">Track user activities and system changes</span>
    </div>
  </div>

  <div class="card">
    <div class="card-header"><h6 class="mb-0">Recent Activity</h6></div>
    <div class="card-body">
      <ul class="list-group list-group-flush">
        <li class="list-group-item d-flex align-items-start gap-3">
          <div class="crm-avatar-sm" style="background: #696cff">
            <i class="bx bx-plus"></i>
          </div>
          <div>
            <p class="mb-0 small">Admin added a new lead: Ritika Shah</p>
            <small class="text-muted">5 min ago</small>
          </div>
        </li>
        <li class="list-group-item d-flex align-items-start gap-3">
          <div class="crm-avatar-sm" style="background: #ff9f43">
            <i class="bx bx-edit"></i>
          </div>
          <div>
            <p class="mb-0 small">Priya Patel updated customer Bluewave Inc</p>
            <small class="text-muted">42 min ago</small>
          </div>
        </li>
        <li class="list-group-item d-flex align-items-start gap-3">
          <div class="crm-avatar-sm" style="background: #28c76f">
            <i class="bx bx-check"></i>
          </div>
          <div>
            <p class="mb-0 small">
              Amit Kumar completed task "Send welcome email"
            </p>
            <small class="text-muted">1 hour ago</small>
          </div>
        </li>
        <li class="list-group-item d-flex align-items-start gap-3">
          <div class="crm-avatar-sm" style="background: #696cff">
            <i class="bx bx-upload"></i>
          </div>
          <div>
            <p class="mb-0 small">
              Admin uploaded document contract_nova_traders.pdf
            </p>
            <small class="text-muted">2 hours ago</small>
          </div>
        </li>
        <li class="list-group-item d-flex align-items-start gap-3">
          <div class="crm-avatar-sm" style="background: #8a8d93">
            <i class="bx bx-log-in"></i>
          </div>
          <div>
            <p class="mb-0 small">Sneha Rao logged in</p>
            <small class="text-muted">3 hours ago</small>
          </div>
        </li>
        <li class="list-group-item d-flex align-items-start gap-3">
          <div class="crm-avatar-sm" style="background: #ea5455">
            <i class="bx bx-bell"></i>
          </div>
          <div>
            <p class="mb-0 small">
              System sent follow-up reminder to Karan Mehta
            </p>
            <small class="text-muted">5 hours ago</small>
          </div>
        </li>
      </ul>
    </div>
  </div>
</asp:Content>

<asp:Content
  ID="ScriptContent"
  ContentPlaceHolderID="ContentPlaceHolder3"
  runat="server"
>
</asp:Content>

