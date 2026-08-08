<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="CRM_PROJECT.Employees" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Employees | CRM System</title>
  <link rel="stylesheet" href="css/pages/employees.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-0">Employees</h4>
      <span class="text-muted">Team management and staff records.</span>
    </div>
    <button
      type="button"
      class="btn btn-primary"
      data-bs-toggle="modal"
      data-bs-target="#addEmployeeModal"
    >
      <i class="bx bx-plus me-1"></i> Add Employee
    </button>
  </div>

  <div class="card crm-stat-card">
    <div class="card-body">
      <table class="table crm-table">
        <thead>
          <tr>
            <th>Name</th>
            <th>Role</th>
            <th>Department</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Admin User</td>
            <td>Administrator</td>
            <td>Operations</td>
            <td><span class="badge badge-status-in-progress">Active</span></td>
          </tr>
          <tr>
            <td>Employee User</td>
            <td>Staff</td>
            <td>Sales</td>
            <td><span class="badge badge-status-pending">On Duty</span></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>

  <div
    class="modal fade"
    id="addEmployeeModal"
    tabindex="-1"
    aria-hidden="true"
  >
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title">Add Employee</h5>
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
                  placeholder="e.g. Vikram Singh"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Role</label>
                <select class="form-select">
                  <option>Sales Executive</option>
                  <option>Sales Manager</option>
                  <option>Support Executive</option>
                  <option>HR Executive</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Email</label>
                <input
                  type="email"
                  class="form-control"
                  placeholder="e.g. name@crm.com"
                />
              </div>
              <div class="col-md-6">
                <label class="form-label">Phone</label>
                <input type="text" class="form-control" placeholder="+91 " />
              </div>
              <div class="col-md-6">
                <label class="form-label">Status</label>
                <select class="form-select">
                  <option>Active</option>
                  <option>On Leave</option>
                  <option>Inactive</option>
                </select>
              </div>
              <div class="col-md-6">
                <label class="form-label">Access Role</label>
                <select class="form-select">
                  <option>Admin</option>
                  <option>Employee</option>
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
          <button type="button" class="btn btn-primary">Add Employee</button>
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

