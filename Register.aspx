<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CRM_PROJECT.Register" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Register | CRM System</title>
  <link rel="stylesheet" href="css/pages/register.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
  <div class="crm-auth-wrapper">
    <div class="card crm-auth-card register-auth-card">
      <div class="card-body p-4 p-sm-5">

        <div class="card-header-brand text-center mb-4">
          <div class="register-brand-icon mx-auto"><i class="bx bx-user-plus"></i></div>
          <h4 class="fw-bold mb-1">Create Account</h4>
          <p class="text-muted small mb-0">Join CRM System to start managing sales &amp; customers</p>
        </div>

        <asp:Literal ID="litMsg" runat="server" />

        <asp:Panel ID="pnlRegister" runat="server" DefaultButton="btnRegister">
          <div class="mb-3">
            <label class="form-label">Full Name <span class="text-danger">*</span></label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="John Doe" />
          </div>
          <div class="mb-3">
            <label class="form-label">Email Address <span class="text-danger">*</span></label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control" placeholder="john.doe@example.com" />
          </div>
          <div class="mb-3">
            <label class="form-label">Phone</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+91 98765 43210" />
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label class="form-label">Password <span class="text-danger">*</span></label>
              <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Password" />
            </div>
            <div class="col-md-6 mb-3">
              <label class="form-label">Confirm <span class="text-danger">*</span></label>
              <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm" />
            </div>
          </div>
          <div class="mb-3 form-check">
            <asp:CheckBox ID="chkTerms" runat="server" CssClass="form-check-input" />
            <label class="form-check-label small" for="<%= chkTerms.ClientID %>">I agree to the Terms of Service &amp; Privacy Policy</label>
          </div>
          <asp:Button ID="btnRegister" runat="server" CssClass="btn btn-primary w-100 py-2 fw-semibold" Text="Complete Registration" OnClick="btnRegister_Click" />
        </asp:Panel>

        <div class="text-center mt-4 pt-2 border-top">
          <p class="mb-0 text-muted small">Already have an account? <a href="Login.aspx" class="fw-bold text-primary">Sign in here</a></p>
        </div>
      </div>
    </div>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
