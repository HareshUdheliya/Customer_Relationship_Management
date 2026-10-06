<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Leads.aspx.cs" Inherits="CRM_PROJECT.Leads" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Leads | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-target-lock"></i></div>
      <div>
        <h4 class="mb-0">Leads</h4>
        <span class="text-muted">Track potential customers from first contact to deal won.</span>
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
      <h5 class="mb-0"><i class="bx bx-edit me-2"></i><asp:Label ID="lblFormTitle" runat="server" Text="Add New Lead" /></h5>
    </div>
    <div class="card-body">
      <asp:Panel ID="pnlForm" runat="server" DefaultButton="btnSave">
        <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label">Lead Name <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtLeadName" runat="server" CssClass="form-control" placeholder="e.g. Karan Mehta" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Company</label>
          <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" placeholder="e.g. Mehta Industries" />
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
          <label class="form-label">Lead Source</label>
          <asp:DropDownList ID="ddlSource" runat="server" CssClass="form-select">
            <asp:ListItem Value="Website">Website</asp:ListItem>
            <asp:ListItem Value="Referral">Referral</asp:ListItem>
            <asp:ListItem Value="Social Media">Social Media</asp:ListItem>
            <asp:ListItem Value="Cold Call">Cold Call</asp:ListItem>
            <asp:ListItem Value="Email Campaign">Email Campaign</asp:ListItem>
            <asp:ListItem Value="Other">Other</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label class="form-label">Status</label>
          <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
            <asp:ListItem Value="New">New</asp:ListItem>
            <asp:ListItem Value="Contacted">Contacted</asp:ListItem>
            <asp:ListItem Value="Qualified">Qualified</asp:ListItem>
            <asp:ListItem Value="Proposal">Proposal</asp:ListItem>
            <asp:ListItem Value="Won">Won</asp:ListItem>
            <asp:ListItem Value="Lost">Lost</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label class="form-label">Expected Value (Rs.)</label>
          <asp:TextBox ID="txtValue" runat="server" CssClass="form-control" TextMode="Number" step="any" min="0" placeholder="0" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Assigned To</label>
          <asp:DropDownList ID="ddlAssignedTo" runat="server" CssClass="form-select"></asp:DropDownList>
        </div>
        </div>
        <div class="mt-4 d-flex gap-2 flex-wrap">
          <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary px-4" OnClick="btnSave_Click"><i class="bx bx-save me-1"></i>Save Lead</asp:LinkButton>
          <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-label-secondary px-4" OnClick="btnCancel_Click" CausesValidation="false"><i class="bx bx-x me-1"></i>Cancel</asp:LinkButton>
        </div>
      </asp:Panel>
    </div>
  </div>

  <div class="card crm-panel">
    <div class="card-header crm-panel-head d-flex flex-wrap justify-content-between align-items-center gap-2">
      <h5 class="mb-0"><i class="bx bx-list-ul me-2"></i>All Leads</h5>
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
        <asp:BoundField DataField="LeadName" HeaderText="Lead" />
        <asp:BoundField DataField="Company" HeaderText="Company" />
        <asp:BoundField DataField="Phone" HeaderText="Phone" />
        <asp:BoundField DataField="Source" HeaderText="Source" />
        <asp:TemplateField HeaderText="Status">
          <ItemTemplate>
            <span class='badge st-<%# Eval("Status").ToString().Replace(" ", "") %>'><%# Eval("Status") %></span>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Value" HeaderText="Value (Rs.)" DataFormatString="{0:N0}" HtmlEncode="false" />
        <asp:BoundField DataField="AssignedName" HeaderText="Owner" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="cmd_convert" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-ok" ToolTip="Convert to Customer" OnClientClick="return confirm('Convert this lead into a customer?');"><i class="bx bx-user-check"></i></asp:LinkButton>
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
