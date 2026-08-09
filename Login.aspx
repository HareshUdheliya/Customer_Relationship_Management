<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CRM_PROJECT.Login" %>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Login | CRM System</title>
  <link rel="stylesheet" href="css/pages/login.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="crm-auth-wrapper">
    <div class="card crm-auth-card login-auth-card">
      <div class="card-body p-4 p-sm-5">
        <div class="card-header-brand text-center mb-4">
          <div class="login-brand-icon mx-auto">
            <i class="bx bx-bxs-dashboard"></i>
          </div>
          <h4 class="fw-bold mb-1">
            CRM <span class="text-primary">System</span>
          </h4>
          <p class="text-muted small mb-0">Sign in to access your dashboard</p>
        </div>

        <div
          class="alert alert-danger d-none"
          id="loginError"
          role="alert"
        ></div>

        <div class="loginForm">
          <div class="mb-3">
            <label for="email" class="form-label">Email Address</label>
            <asp:TextBox
              runat="server"
              TextMode="Email"
              CssClass="form-control"
              ID="txtEmail"
              placeholder="Enter Email"
              Required="true"
            />
          </div>
          <div class="mb-3">
            <div class="d-flex justify-content-between">
              <label for="password" class="form-label">Password</label>
              <a href="javascript:void(0)" class="small text-primary"
                >Forgot password?</a
              >
            </div>
            <asp:TextBox
              runat="server"
              TextMode="Password"
              CssClass="form-control"
              ID="txtPassword"
              placeholder="••••••••"
              Required="true"
            />
          </div>
          <div class="mb-3 form-check">
            <input class="form-check-input" type="checkbox" id="remember" runat="server" />
            <label class="form-check-label small" for="remember"
              >Remember me</label
            >
          </div>
          <asp:Button runat="server" ID="btnLogin" CssClass="btn btn-primary w-100 py-2 fw-semibold" Text="Sign In" OnClick="btnLogin_Click" />
        </div>

        <div class="text-center mt-4 pt-3 border-top">
          <p class="mb-2 text-muted small">
            Don't have an account?
            <a href="Register.aspx" class="fw-bold login-register-link"
              >Register Now</a
            >
          </p>
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
  <script src="js/pages/login.js"></script>
</asp:Content>

