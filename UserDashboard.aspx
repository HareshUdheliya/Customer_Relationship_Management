<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="CRM_PROJECT.UserDashboard" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>My Dashboard | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-hero">
    <div>
      <h3>Hello, <asp:Literal ID="litUserName" runat="server" />!</h3>
      <p>Here are your leads, tasks and follow-ups for today.</p>
    </div>
    <a href="Tasks.aspx" class="btn"><i class="bx bx-plus me-1"></i> Add Task</a>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-xl-3">
      <a href="Leads.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">My Assigned Leads</p><h4 class="mb-0"><asp:Literal ID="litLeads" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-primary-subtle text-primary"><i class="bx bx-target-lock"></i></div>
      </div></div></a>
    </div>
    <div class="col-sm-6 col-xl-3">
      <a href="Tasks.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">My Active Tasks</p><h4 class="mb-0"><asp:Literal ID="litTasks" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-warning-subtle text-warning"><i class="bx bx-task"></i></div>
      </div></div></a>
    </div>
    <div class="col-sm-6 col-xl-3">
      <a href="Customers.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">My Customers</p><h4 class="mb-0"><asp:Literal ID="litCustomers" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-success-subtle text-success"><i class="bx bx-user"></i></div>
      </div></div></a>
    </div>
    <div class="col-sm-6 col-xl-3">
      <a href="Followups.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">Pending Follow-ups</p><h4 class="mb-0"><asp:Literal ID="litFollowups" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-info-subtle text-info"><i class="bx bx-calendar-check"></i></div>
      </div></div></a>
    </div>
  </div>

  <div class="card crm-panel">
    <div class="card-header crm-panel-head d-flex justify-content-between align-items-center">
      <h5 class="mb-0"><i class="bx bx-task me-2"></i>My Tasks</h5>
      <a href="Tasks.aspx" class="btn btn-sm btn-label-secondary">Manage tasks</a>
    </div>
    <div class="table-responsive">
      <asp:GridView ID="gvTasks" runat="server" AutoGenerateColumns="False" CssClass="table crm-table mb-0" GridLines="None" EmptyDataText="You have no open tasks. Great job!">
        <Columns>
          <asp:BoundField DataField="Title" HeaderText="Task" />
          <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />
          <asp:TemplateField HeaderText="Priority"><ItemTemplate><span class='badge st-<%# Eval("Priority") %>'><%# Eval("Priority") %></span></ItemTemplate></asp:TemplateField>
          <asp:TemplateField HeaderText="Status"><ItemTemplate><span class='badge st-<%# Eval("Status").ToString().Replace(" ", "") %>'><%# Eval("Status") %></span></ItemTemplate></asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
