<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="CRM_PROJECT.Register" %>



<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Register | CRM System</title>
  <link rel="stylesheet" href="css/pages/register.css" />
</asp:Content>

<asp:Content
  ID="MainContent"
  ContentPlaceHolderID="ContentPlaceHolder2"
  runat="server"
>
  <div class="crm-auth-wrapper">
    <div class="card crm-auth-card register-auth-card">
      <div class="card-body p-4 p-sm-5">
        <div class="card-header-brand text-center mb-4">
          <div class="register-brand-icon mx-auto">
            <i class="bx bx-user-plus"></i>
          </div>
          <h4 class="fw-bold mb-1">Create Account</h4>
          <p class="text-muted small mb-0">
            Join CRM System to start managing sales & customers
          </p>
        </div>

        <div
          class="alert alert-danger d-none"
          id="registerError"
          role="alert"
        ></div>

        <div class="registerForm">
          <div class="mb-3">
            <label for="fullName" class="form-label"
              >Full Name <span class="text-danger">*</span></label
            >
            <asp:TextBox
              runat="server"
              CssClass="form-control"
              ID="txtFullName"
              placeholder="John Doe"
              Required="true"
            />
          </div>
          <div class="mb-3">
            <label for="email" class="form-label"
              >Email Address <span class="text-danger">*</span></label
            >
            <asp:TextBox
              runat="server"
              TextMode="Email"
              CssClass="form-control"
              ID="txtEmail"
              placeholder="john.doe@example.com"
              Required="true"
            />
          </div>
          <div class="row">
            <div class="col-md-6 mb-3">
              <label for="password" class="form-label"
                >Password <span class="text-danger">*</span></label
              >
              <asp:TextBox
                runat="server"
                TextMode="Password"
                CssClass="form-control"
                ID="txtPassword"
                placeholder="••••••••"
                Required="true"
              />
            </div>
            <div class="col-md-6 mb-3">
              <label for="confirmPassword" class="form-label"
                >Confirm Password <span class="text-danger">*</span></label
              >
              <asp:TextBox
                runat="server"
                TextMode="Password"
                CssClass="form-control"
                ID="txtConfirmPassword"
                placeholder="••••••••"
                Required="true"
              />
            </div>
          </div>
          <div class="mb-3 form-check">
            <input
              class="form-check-input"
              type="checkbox"
              id="terms"
              required
            />
            <label class="form-check-label small" for="terms">
              I agree to the
              <a href="javascript:void(0)" class="text-primary"
                >Terms of Service</a
              >
              &
              <a href="javascript:void(0)" class="text-primary"
                >Privacy Policy</a
              >
            </label>
          </div>
          <asp:Button runat="server" ID="btnRegister" CssClass="btn btn-primary w-100 py-2 fw-semibold" Text="Complete Registration" OnClick="btnRegister_Click" />
        </div>

        <div class="text-center mt-4 pt-2 border-top">
          <p class="mb-0 text-muted small">
            Already have an account?
            <a href="Login.aspx" class="fw-bold text-primary">Sign in here</a>
          </p>
        </div>
      </div>
    </div>
  </div>

    <asp:GridView ID="Usergv" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:TemplateField HeaderText="UserID">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="FullName">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("FullName") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Email">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Password">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
    </asp:GridView>
</asp:Content>

<asp:Content
  ID="ScriptContent"
  ContentPlaceHolderID="ContentPlaceHolder3"
  runat="server"
>
  <script src="js/pages/register.js"></script>
</asp:Content>

