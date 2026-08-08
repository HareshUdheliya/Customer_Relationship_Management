<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="CRM_PROJECT.Profile" %>



<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Profile | CRM System</title>
  <link rel="stylesheet" href="css/pages/profile.css" />
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
      <h4 class="mb-0">Profile Management</h4>
      <span class="text-muted">Update your profile and password</span>
    </div>
  </div>

  <div class="row g-4">
    <div class="col-lg-4">
      <div class="card">
        <div class="card-body text-center">
          <div
            class="crm-avatar-sm mx-auto mb-3"
            style="width: 80px; height: 80px; font-size: 28px"
          >
            AD
          </div>
          <h5 class="mb-0">Admin User</h5>
          <span class="text-muted">Administrator</span>
          <div class="mt-3">
            <button class="btn btn-outline-primary btn-sm">Change Photo</button>
          </div>
        </div>
      </div>
    </div>
    <div class="col-lg-8">
      <div class="card mb-4">
        <div class="card-header"><h6 class="mb-0">Profile Details</h6></div>
        <div class="card-body">
          <div class="row g-3">
            <div class="col-md-6">
              <label class="form-label">Full Name</label
              ><input type="text" class="form-control" value="Admin User" />
            </div>
            <div class="col-md-6">
              <label class="form-label">Email</label
              ><input type="email" class="form-control" value="admin@crm.com" />
            </div>
            <div class="col-md-6">
              <label class="form-label">Phone</label
              ><input
                type="text"
                class="form-control"
                value="+91 98200 00000"
              />
            </div>
            <div class="col-md-6">
              <label class="form-label">Role</label
              ><input
                type="text"
                class="form-control"
                value="Administrator"
                disabled
              />
            </div>
          </div>
          <button class="btn btn-primary btn-sm mt-3">Save Changes</button>
        </div>
      </div>
      <div class="card">
        <div class="card-header"><h6 class="mb-0">Change Password</h6></div>
        <div class="card-body">
          <div class="row g-3">
            <div class="col-md-4">
              <label class="form-label">Current Password</label
              ><input type="password" class="form-control" />
            </div>
            <div class="col-md-4">
              <label class="form-label">New Password</label
              ><input type="password" class="form-control" />
            </div>
            <div class="col-md-4">
              <label class="form-label">Confirm Password</label
              ><input type="password" class="form-control" />
            </div>
          </div>
          <button class="btn btn-primary btn-sm mt-3">Update Password</button>
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
  <script src="js/pages/profile.js"></script>
</asp:Content>

