<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CRM_PROJECT.Default" %>



<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Dashboard | CRM System</title>
  <link rel="stylesheet" href="css/pages/index.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-0">Dashboard</h4>
      <span class="text-muted"
        >Welcome back, Admin. Here's what happening today.</span
      >
    </div>
    <button class="btn btn-primary">
      <i class="bx bx-plus me-1"></i> Add Lead
    </button>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-sm-6 col-xl-3">
      <div class="card crm-stat-card h-100">
        <div class="card-body">
          <div class="d-flex align-items-center justify-content-between">
            <div>
              <p class="text-muted mb-1">Total Leads</p>
              <h4 class="mb-0">1,284</h4>
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
              <p class="text-muted mb-1">Customers</p>
              <h4 class="mb-0">892</h4>
            </div>
            <div class="crm-stat-icon bg-success-subtle text-success">
              <i class="bx bx-user"></i>
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
              <p class="text-muted mb-1">Open Tasks</p>
              <h4 class="mb-0">56</h4>
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
              <p class="text-muted mb-1">Follow-ups</p>
              <h4 class="mb-0">32</h4>
            </div>
            <div class="crm-stat-icon bg-info-subtle text-info">
              <i class="bx bx-calendar-check"></i>
            </div>
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
  <script src="js/vendor/apexcharts.js"></script>
  <script src="js/dashboard.js"></script>
  <script src="js/pages/index.js"></script>
</asp:Content>

