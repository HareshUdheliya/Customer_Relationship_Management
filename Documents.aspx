<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Documents.aspx.cs" Inherits="CRM_PROJECT.Documents" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Documents | CRM System</title>
  <link rel="stylesheet" href="css/pages/documents.css" />
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
      <h4 class="mb-0">Document Management</h4>
      <span class="text-muted">Upload and manage customer documents</span>
    </div>
  </div>

  <div class="card">
    <div class="card-header d-flex justify-content-between align-items-center">
      <h6 class="mb-0">Uploaded Documents</h6>
      <button
        type="button"
        class="btn btn-sm btn-primary"
        data-bs-toggle="modal"
        data-bs-target="#uploadDocModal"
      >
        Upload Document
      </button>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table crm-table">
          <thead>
            <tr>
              <th>Name</th>
              <th>Customer</th>
              <th>Type</th>
              <th>Uploaded On</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>contract_nova_traders.pdf</td>
              <td>Nova Traders</td>
              <td>Contract</td>
              <td>18 Jul 2026</td>
            </tr>
            <tr>
              <td>proposal_bluewave.docx</td>
              <td>Bluewave Inc</td>
              <td>Proposal</td>
              <td>19 Jul 2026</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <div class="modal fade" id="uploadDocModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Upload Document</h5>
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
                <label class="form-label">Customer</label>
                <select class="form-select">
                  <option>Ritika Shah</option>
                  <option>Karan Mehta</option>
                  <option>Priya Patel</option>
                  <option>Sanjay Desai</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Document Type</label>
                <select class="form-select">
                  <option>Contract</option>
                  <option>Proposal</option>
                  <option>Invoice</option>
                  <option>Notes</option>
                  <option>Other</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">File</label>
                <input type="file" class="form-control" placeholder="" />
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
          <button type="button" class="btn btn-primary">Upload</button>
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

