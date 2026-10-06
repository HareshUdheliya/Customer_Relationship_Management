<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="CRM_PROJECT.Employees" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Employees | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-group"></i></div>
      <div>
        <h4 class="mb-0">Employees</h4>
        <span class="text-muted">Team management and staff records.</span>
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
      <h5 class="mb-0"><i class="bx bx-edit me-2"></i><asp:Label ID="lblFormTitle" runat="server" Text="Add New Employee" /></h5>
    </div>
    <div class="card-body">
      <asp:Panel ID="pnlForm" runat="server" DefaultButton="btnSave">
        <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label">Full Name <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="e.g. Amit Kumar" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Email</label>
          <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" placeholder="name@company.com" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Phone</label>
          <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="+91 98765 43210" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Department</label>
          <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select">
            <asp:ListItem Value="Sales">Sales</asp:ListItem>
            <asp:ListItem Value="Marketing">Marketing</asp:ListItem>
            <asp:ListItem Value="Support">Support</asp:ListItem>
            <asp:ListItem Value="HR">HR</asp:ListItem>
            <asp:ListItem Value="IT">IT</asp:ListItem>
            <asp:ListItem Value="Finance">Finance</asp:ListItem>
            <asp:ListItem Value="Operations">Operations</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label class="form-label">Designation</label>
          <asp:TextBox ID="txtDesignation" runat="server" CssClass="form-control" placeholder="e.g. Sales Executive" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Salary (Rs.)</label>
          <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" TextMode="Number" step="any" min="0" placeholder="0" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Joining Date <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtJoinDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Status</label>
          <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
            <asp:ListItem Value="Active">Active</asp:ListItem>
            <asp:ListItem Value="On Leave">On Leave</asp:ListItem>
            <asp:ListItem Value="Resigned">Resigned</asp:ListItem>
          </asp:DropDownList>
        </div>
        </div>
        <div class="mt-4 d-flex gap-2 flex-wrap">
          <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary px-4" OnClick="btnSave_Click"><i class="bx bx-save me-1"></i>Save Employee</asp:LinkButton>
          <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-label-secondary px-4" OnClick="btnCancel_Click" CausesValidation="false"><i class="bx bx-x me-1"></i>Cancel</asp:LinkButton>
        </div>
      </asp:Panel>
    </div>
  </div>

  <div class="card crm-panel">
    <div class="card-header crm-panel-head d-flex flex-wrap justify-content-between align-items-center gap-2">
      <h5 class="mb-0"><i class="bx bx-list-ul me-2"></i>All Employees</h5>
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
        <asp:BoundField DataField="Department" HeaderText="Department" />
        <asp:BoundField DataField="Designation" HeaderText="Designation" />
        <asp:BoundField DataField="Phone" HeaderText="Phone" />
        <asp:BoundField DataField="JoinDate" HeaderText="Joined" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />
        <asp:TemplateField HeaderText="Status">
          <ItemTemplate>
            <span class='badge st-<%# Eval("Status").ToString().Replace(" ", "") %>'><%# Eval("Status") %></span>
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
