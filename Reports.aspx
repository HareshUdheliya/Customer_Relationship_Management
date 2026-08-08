<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="CRM_PROJECT.Reports" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Reports | CRM System</title>
  <link rel="stylesheet" href="css/pages/reports.css" />
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
      <h4 class="mb-0">Reports</h4>
      <span class="text-muted"
        >Generate customer, employee, lead, and task reports</span
      >
    </div>
    <button
      type="button"
      class="btn btn-primary btn-sm"
      data-bs-toggle="modal"
      data-bs-target="#exportReportModal"
    >
      <i class="bx bx-download me-1"></i>Export
    </button>
  </div>

  <div class="row g-4 mb-4">
    <div class="col-lg-6">
      <div class="card h-100">
        <div class="card-header">
          <h6 class="mb-0">Leads Conversion by Month</h6>
        </div>
        <div class="card-body">
          <div id="leadsConversionChart"></div>
        </div>
      </div>
    </div>

    <div class="col-lg-6">
      <div class="card h-100">
        <div class="card-header">
          <h6 class="mb-0">Open vs Closed Tasks</h6>
        </div>
        <div class="card-body">
          <div id="tasksStatusChart"></div>
        </div>
      </div>
    </div>
  </div>

  <div
    class="modal fade"
    id="exportReportModal"
    tabindex="-1"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Export Report</h5>
          <button
            type="button"
            class="btn-close"
            data-bs-dismiss="modal"
            aria-label="Close"
          ></button>
        </div>
        <div class="modal-body">
          <form>
            <div class="row g-3">
              <div class="col-md-6">
                <label class="form-label">Report Type</label>
                <select class="form-select">
                  <option>Customer Report</option>
                  <option>Employee Report</option>
                  <option>Lead Report</option>
                  <option>Task Report</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">From Date</label>
                <input type="date" class="form-control" placeholder="" />
              </div>
              <div class="col-md-6">
                <label class="form-label">To Date</label>
                <input type="date" class="form-control" placeholder="" />
              </div>
              <div class="col-md-6">
                <label class="form-label">Format</label>
                <select class="form-select">
                  <option>PDF</option>
                  <option>Excel (CSV)</option>
                </select>
              </div>
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button
            type="button"
            class="btn btn-label-secondary"
            data-bs-dismiss="modal"
          >
            Cancel
          </button>
          <button type="button" class="btn btn-primary">Export</button>
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
  <script src="js/reports.js"></script>
  <script src="js/pages/reports.js"></script>
</asp:Content>

