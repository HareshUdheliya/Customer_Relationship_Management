<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="CRM_PROJECT.UserManagement" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>User Management | CRM System</title>
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div>
      <h4 class="mb-0">User Management</h4>
      <span class="text-muted"
        >Manage system users, roles, and access.</span
      >
    </div>
    <button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#addUserModal">
      <i class="bx bx-user-plus me-1"></i> Add User
    </button>
  </div>

  <div class="card">
    <div class="card-header border-bottom">
        <h5 class="card-title mb-0">System Users</h5>
    </div>
    <div class="card-body pt-3">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><div class="d-flex align-items-center"><div class="avatar avatar-sm me-2"><span class="avatar-initial rounded-circle bg-primary">A</span></div><strong>Admin User</strong></div></td>
                        <td>admin@example.com</td>
                        <td><span class="badge bg-danger-subtle text-danger">Administrator</span></td>
                        <td><span class="badge bg-success">Active</span></td>
                        <td>
                            <button type="button" class="btn btn-icon btn-sm btn-outline-secondary" disabled><i class="bx bx-edit"></i></button>
                        </td>
                    </tr>
                    <tr>
                        <td><div class="d-flex align-items-center"><div class="avatar avatar-sm me-2"><span class="avatar-initial rounded-circle bg-info">J</span></div><strong>John Doe</strong></div></td>
                        <td>john.doe@example.com</td>
                        <td><span class="badge bg-info-subtle text-info">User</span></td>
                        <td><span class="badge bg-success">Active</span></td>
                        <td>
                            <button type="button" class="btn btn-icon btn-sm btn-outline-primary"><i class="bx bx-edit"></i></button>
                            <button type="button" class="btn btn-icon btn-sm btn-outline-danger"><i class="bx bx-trash"></i></button>
                        </td>
                    </tr>
                     <tr>
                        <td><div class="d-flex align-items-center"><div class="avatar avatar-sm me-2"><span class="avatar-initial rounded-circle bg-warning">S</span></div><strong>Sarah Smith</strong></div></td>
                        <td>sarah.s@example.com</td>
                        <td><span class="badge bg-info-subtle text-info">User</span></td>
                        <td><span class="badge bg-secondary">Inactive</span></td>
                        <td>
                            <button type="button" class="btn btn-icon btn-sm btn-outline-primary"><i class="bx bx-edit"></i></button>
                            <button type="button" class="btn btn-icon btn-sm btn-outline-danger"><i class="bx bx-trash"></i></button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
  </div>

  <!-- Add User Modal -->
  <div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="row">
            <div class="col mb-3">
              <label for="nameBasic" class="form-label">Full Name</label>
              <input type="text" id="nameBasic" class="form-control" placeholder="Enter Name">
            </div>
          </div>
          <div class="row g-2">
            <div class="col mb-0">
              <label for="emailBasic" class="form-label">Email</label>
              <input type="email" id="emailBasic" class="form-control" placeholder="xxxx@xxx.xx">
            </div>
            <div class="col mb-0">
              <label for="roleBasic" class="form-label">Role</label>
              <select id="roleBasic" class="form-select">
                <option value="user">User</option>
                <option value="admin">Administrator</option>
              </select>
            </div>
          </div>
        </div>
        <div class="modal-footer mt-2">
          <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
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
