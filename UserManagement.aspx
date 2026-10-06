<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserManagement.aspx.cs" Inherits="CRM_PROJECT.UserManagement" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>User Management | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-user-circle"></i></div>
      <div>
        <h4 class="mb-0">User Management</h4>
        <span class="text-muted">Create login accounts and control who is an admin.</span>
      </div>
    </div>
    <div class="crm-total-pill">
      <span class="text-muted">Total records</span>
      <strong><asp:Literal ID="litTotal" runat="server" Text="0" /></strong>
    </div>
  </div>

  <asp:Literal ID="litMsg" runat="server" />

  <div class="card crm-panel mb-4">
    <div class="card-header crm-panel-head">
      <h5 class="mb-0"><i class="bx bx-edit me-2"></i><asp:Label ID="lblFormTitle" runat="server" Text="Add New User" /></h5>
    </div>
    <div class="card-body">
      <asp:Panel ID="pnlForm" runat="server" DefaultButton="btnSave">
        <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label">Full Name <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="e.g. Priya Patel" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Email <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="name@company.com" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Phone</label>
          <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+91 98765 43210" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Role</label>
          <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
            <asp:ListItem Value="user">User</asp:ListItem>
            <asp:ListItem Value="admin">Admin</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label class="form-label">Password <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Leave blank to keep old password (when editing)" />
        </div>
        </div>
        <div class="mt-4 d-flex gap-2 flex-wrap">
          <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary px-4" OnClick="btnSave_Click"><i class="bx bx-save me-1"></i>Save User</asp:LinkButton>
          <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-label-secondary px-4" OnClick="btnCancel_Click" CausesValidation="false"><i class="bx bx-x me-1"></i>Cancel</asp:LinkButton>
        </div>
      </asp:Panel>
    </div>
  </div>

  <div class="card crm-panel">
    <div class="card-header crm-panel-head d-flex flex-wrap justify-content-between align-items-center gap-2">
      <h5 class="mb-0"><i class="bx bx-list-ul me-2"></i>All User Management</h5>
      <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" CssClass="crm-search-box">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..." />
        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click"><i class="bx bx-search"></i></asp:LinkButton>
        <asp:LinkButton ID="btnReset" runat="server" CssClass="btn btn-label-secondary" OnClick="btnReset_Click"><i class="bx bx-refresh"></i></asp:LinkButton>
      </asp:Panel>
    </div>
    <div class="table-responsive">
      <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
        CssClass="table crm-table align-middle mb-0" GridLines="None" BorderWidth="0"
        EmptyDataText="No records found. Add your first record using the form above."
        OnRowCommand="gv_RowCommand">
        <Columns>
        <asp:BoundField DataField="Id" HeaderText="#" />
        <asp:BoundField DataField="FullName" HeaderText="Name" />
        <asp:BoundField DataField="Email" HeaderText="Email" />
        <asp:BoundField DataField="Phone" HeaderText="Phone" />
        <asp:TemplateField HeaderText="Role">
          <ItemTemplate>
            <span class='badge st-<%# Eval("Role").ToString().Replace(" ", "") %>'><%# Eval("Role") %></span>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-edit" ToolTip="Edit"><i class="bx bx-edit-alt"></i></asp:LinkButton>
            <asp:LinkButton runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-del" ToolTip="Delete" OnClientClick="return confirm('Are you sure you want to delete this record?');"><i class="bx bx-trash"></i></asp:LinkButton>
          </ItemTemplate>
        </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
