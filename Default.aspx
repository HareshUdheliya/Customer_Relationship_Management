<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CRM_PROJECT.Default" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Dashboard | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-hero">
    <div>
      <h3>Welcome back, <asp:Literal ID="litName" runat="server" />!</h3>
      <p>Here is what is happening in your CRM today.</p>
    </div>
    <a href="Leads.aspx" class="btn"><i class="bx bx-plus me-1"></i> Add Lead</a>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-xl-3">
      <a href="Leads.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">Total Leads</p><h4 class="mb-0"><asp:Literal ID="litLeads" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-primary-subtle text-primary"><i class="bx bx-target-lock"></i></div>
      </div></div></a>
    </div>
    <div class="col-sm-6 col-xl-3">
      <a href="Customers.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">Customers</p><h4 class="mb-0"><asp:Literal ID="litCustomers" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-success-subtle text-success"><i class="bx bx-user"></i></div>
      </div></div></a>
    </div>
    <div class="col-sm-6 col-xl-3">
      <a href="Tasks.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">Open Tasks</p><h4 class="mb-0"><asp:Literal ID="litTasks" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-warning-subtle text-warning"><i class="bx bx-task"></i></div>
      </div></div></a>
    </div>
    <div class="col-sm-6 col-xl-3">
      <a href="Followups.aspx" class="crm-stat-link"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
        <div><p class="text-muted mb-1">Pending Follow-ups</p><h4 class="mb-0"><asp:Literal ID="litFollowups" runat="server" /></h4></div>
        <div class="crm-stat-icon bg-info-subtle text-info"><i class="bx bx-calendar-check"></i></div>
      </div></div></a>
    </div>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-lg-4">
      <div class="card crm-panel h-100">
        <div class="card-header crm-panel-head"><h5 class="mb-0"><i class="bx bx-line-chart me-2"></i>Leads by Status</h5></div>
        <div class="card-body"><asp:Literal ID="litLeadBars" runat="server" /></div>
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card crm-panel h-100">
        <div class="card-header crm-panel-head d-flex justify-content-between align-items-center">
          <h5 class="mb-0"><i class="bx bx-time-five me-2"></i>Recent Leads</h5>
          <a href="Leads.aspx" class="btn btn-sm btn-label-secondary">View all</a>
        </div>
        <div class="table-responsive">
          <asp:GridView ID="gvLeads" runat="server" AutoGenerateColumns="False" CssClass="table crm-table mb-0" GridLines="None" EmptyDataText="No leads yet.">
            <Columns>
              <asp:BoundField DataField="LeadName" HeaderText="Lead" />
              <asp:BoundField DataField="Company" HeaderText="Company" />
              <asp:BoundField DataField="Source" HeaderText="Source" />
              <asp:TemplateField HeaderText="Status"><ItemTemplate><span class='badge st-<%# Eval("Status").ToString().Replace(" ", "") %>'><%# Eval("Status") %></span></ItemTemplate></asp:TemplateField>
            </Columns>
          </asp:GridView>
        </div>
      </div>
    </div>
  </div>

  <div class="row g-4">
    <div class="col-lg-6">
      <div class="card crm-panel h-100">
        <div class="card-header crm-panel-head d-flex justify-content-between align-items-center">
          <h5 class="mb-0"><i class="bx bx-task me-2"></i>Upcoming Tasks</h5>
          <a href="Tasks.aspx" class="btn btn-sm btn-label-secondary">View all</a>
        </div>
        <div class="table-responsive">
          <asp:GridView ID="gvTasks" runat="server" AutoGenerateColumns="False" CssClass="table crm-table mb-0" GridLines="None" EmptyDataText="No open tasks.">
            <Columns>
              <asp:BoundField DataField="Title" HeaderText="Task" />
              <asp:BoundField DataField="DueDate" HeaderText="Due" DataFormatString="{0:dd MMM}" HtmlEncode="false" />
              <asp:TemplateField HeaderText="Priority"><ItemTemplate><span class='badge st-<%# Eval("Priority") %>'><%# Eval("Priority") %></span></ItemTemplate></asp:TemplateField>
            </Columns>
          </asp:GridView>
        </div>
      </div>
    </div>
    <div class="col-lg-6">
      <div class="card crm-panel h-100">
        <div class="card-header crm-panel-head d-flex justify-content-between align-items-center">
          <h5 class="mb-0"><i class="bx bx-history me-2"></i>Recent Activity</h5>
          <a href="ActivityLog.aspx" class="btn btn-sm btn-label-secondary">View all</a>
        </div>
        <div class="card-body"><asp:Literal ID="litActivity" runat="server" /></div>
      </div>
    </div>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
