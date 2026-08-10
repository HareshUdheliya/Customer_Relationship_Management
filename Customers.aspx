<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Customers.aspx.cs" Inherits="CRM_PROJECT.Customers" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Customers | CRM System</title>
  <link rel="stylesheet" href="css/pages/customers.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-0">Customers</h4>
      <span class="text-muted"
        >Manage customer records and accounts activity.</span
      >
    </div>
    <button
      type="button"
      class="btn btn-primary"
      data-bs-toggle="modal"
      data-bs-target="#addCustomerModal"
    >
      <i class="bx bx-plus me-1"></i> Add Customer
    </button>
  </div>

  <div class="card crm-stat-card">
    <div class="card-body">
      <table class="table crm-table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Status</th>
            <th>Owner</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Ritika Shah</td>
            <td>ritika@example.com</td>
            <td><span class="badge badge-status-in-progress">Active</span></td>
            <td>Admin</td>
          </tr>
          <tr>
            <td>Karan Mehta</td>
            <td>karan@example.com</td>
            <td><span class="badge badge-status-pending">Pending</span></td>
            <td>Team Lead</td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <div
    class="modal fade"
    id="addCustomerModal"
    tabindex="-1"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Customer</h5>
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
                  placeholder="e.g. Ritika Shah"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Company</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="e.g. Nova Traders"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Email</label>
                <input
                  type="email"
                  class="form-control"
                  placeholder="e.g. name@company.com"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Phone</label>
                <input type="text" class="form-control" placeholder="+91" />
              </div>
              <div class="col-md-6">
                <label class="form-label">Status</label>
                <select class="form-select">
                  <option>Active</option>
                  <option>Inactive</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Assigned To</label>
                <select class="form-select">
                  <option>Amit Kumar</option>
                  <option>Priya Patel</option>
                  <option>Rahul Nair</option>
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
          <button type="button" class="btn btn-primary">Add Customer</button>
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

