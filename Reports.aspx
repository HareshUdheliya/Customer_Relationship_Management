<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="CRM_PROJECT.Reports" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Reports | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-bar-chart-alt-2"></i></div>
      <div>
        <h4 class="mb-0">Reports</h4>
        <span class="text-muted">Summary of customers, leads, tasks and employees.</span>
      </div>
    </div>
    <div class="d-flex gap-2 align-items-center flex-wrap">
      <asp:DropDownList ID="ddlExport" runat="server" CssClass="form-select" Width="170px">
        <asp:ListItem Value="Customers">Customers</asp:ListItem>
        <asp:ListItem Value="Leads">Leads</asp:ListItem>
        <asp:ListItem Value="Tasks">Tasks</asp:ListItem>
        <asp:ListItem Value="Followups">Follow-Ups</asp:ListItem>
        <asp:ListItem Value="Employees">Employees</asp:ListItem>
      </asp:DropDownList>
      <asp:LinkButton ID="btnExport" runat="server" CssClass="btn btn-primary" OnClick="btnExport_Click"><i class="bx bx-download me-1"></i>Export CSV</asp:LinkButton>
    </div>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-xl-3"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
      <div><p class="text-muted mb-1">Customers</p><h4 class="mb-0"><asp:Literal ID="litCustomers" runat="server" /></h4></div>
      <div class="crm-stat-icon bg-success-subtle text-success"><i class="bx bx-user"></i></div></div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
      <div><p class="text-muted mb-1">Leads</p><h4 class="mb-0"><asp:Literal ID="litLeads" runat="server" /></h4></div>
      <div class="crm-stat-icon bg-primary-subtle text-primary"><i class="bx bx-target-lock"></i></div></div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
      <div><p class="text-muted mb-1">Pipeline Value (Rs.)</p><h4 class="mb-0"><asp:Literal ID="litValue" runat="server" /></h4></div>
      <div class="crm-stat-icon bg-warning-subtle text-warning"><i class="bx bx-rupee"></i></div></div></div></div>
    <div class="col-sm-6 col-xl-3"><div class="card crm-stat-card h-100"><div class="card-body d-flex justify-content-between align-items-center">
      <div><p class="text-muted mb-1">Conversion Rate</p><h4 class="mb-0"><asp:Literal ID="litRate" runat="server" /></h4></div>
      <div class="crm-stat-icon bg-info-subtle text-info"><i class="bx bx-trending-up"></i></div></div></div></div>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-lg-6"><div class="card crm-panel h-100">
      <div class="card-header crm-panel-head"><h5 class="mb-0"><i class="bx bx-target-lock me-2"></i>Leads by Status</h5></div>
      <div class="card-body"><asp:Literal ID="litLeadBars" runat="server" /></div>
    </div></div>
    <div class="col-lg-6"><div class="card crm-panel h-100">
      <div class="card-header crm-panel-head"><h5 class="mb-0"><i class="bx bx-task me-2"></i>Tasks by Status</h5></div>
      <div class="card-body"><asp:Literal ID="litTaskBars" runat="server" /></div>
    </div></div>
  </div>

  <div class="row g-4">
    <div class="col-lg-6"><div class="card crm-panel h-100">
      <div class="card-header crm-panel-head"><h5 class="mb-0"><i class="bx bx-globe me-2"></i>Leads by Source</h5></div>
      <div class="card-body"><asp:Literal ID="litSourceBars" runat="server" /></div>
    </div></div>
    <div class="col-lg-6"><div class="card crm-panel h-100">
      <div class="card-header crm-panel-head"><h5 class="mb-0"><i class="bx bx-group me-2"></i>Employees by Department</h5></div>
      <div class="card-body"><asp:Literal ID="litDeptBars" runat="server" /></div>
    </div></div>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
