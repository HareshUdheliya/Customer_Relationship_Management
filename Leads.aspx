<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Leads.aspx.cs" Inherits="CRM_PROJECT.Leads" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Leads | CRM System</title>
  <link rel="stylesheet" href="css/pages/leads.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-0">Leads</h4>
      <span class="text-muted">Review lead pipeline and status.</span>
    </div>
    <button
      type="button"
      class="btn btn-primary"
      data-bs-toggle="modal"
      data-bs-target="#addLeadModal"
    >
      <i class="bx bx-plus me-1"></i> New Lead
    </button>
  </div>

  <div class="card crm-stat-card">
    <div class="card-body">
      <table class="table crm-table">
        <thead>
          <tr>
            <th>Lead</th>
            <th>Company</th>
            <th>Status</th>
            <th>Source</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Ritika Shah</td>
            <td>BrightEdge</td>
            <td><span class="badge badge-lead-new">New</span></td>
            <td>Website</td>
          </tr>
          <tr>
            <td>Arjun Patel</td>
            <td>Nova Labs</td>
            <td><span class="badge badge-lead-qualified">Qualified</span></td>
            <td>Referral</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <div class="modal fade" id="addLeadModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Lead</h5>
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
                <label class="form-label">Full Name</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="e.g. Karan Mehta"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Company</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="e.g. Zen Retail"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Source</label>
                <select class="form-select">
                  <option>Website</option>
                  <option>Referral</option>
                  <option>Cold Call</option>
                  <option>Social Media</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Status</label>
                <select class="form-select">
                  <option>New</option>
                  <option>Contacted</option>
                  <option>Qualified</option>
                  <option>Lost</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Assigned To</label>
                <select class="form-select">
                  <option>Amit Kumar</option>
                  <option>Priya Patel</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Phone</label>
                <input type="text" class="form-control" placeholder="+91 " />
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
          <button type="button" class="btn btn-primary">Add Lead</button>
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
</asp:Content>

