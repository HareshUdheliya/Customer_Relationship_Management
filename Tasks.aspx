<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Tasks.aspx.cs" Inherits="CRM_PROJECT.Tasks" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Tasks | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-task"></i></div>
      <div>
        <h4 class="mb-0">Tasks</h4>
        <span class="text-muted">Create, assign and monitor team tasks.</span>
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
      <h5 class="mb-0"><i class="bx bx-edit me-2"></i><asp:Label ID="lblFormTitle" runat="server" Text="Add New Task" /></h5>
    </div>
    <div class="card-body">
      <asp:Panel ID="pnlForm" runat="server" DefaultButton="btnSave">
        <div class="row g-3">
        <div class="col-md-8">
          <label class="form-label">Task Title <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. Send proposal to Nova Traders" />
        </div>
        <div class="col-md-4">
          <label class="form-label">Due Date <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtDueDate" runat="server" CssClass="form-control" TextMode="Date" placeholder="" />
        </div>
        <div class="col-md-4">
          <label class="form-label">Priority</label>
          <asp:DropDownList ID="ddlPriority" runat="server" CssClass="form-select">
            <asp:ListItem Value="Low">Low</asp:ListItem>
            <asp:ListItem Value="Medium">Medium</asp:ListItem>
            <asp:ListItem Value="High">High</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-4">
          <label class="form-label">Status</label>
          <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
            <asp:ListItem Value="Pending">Pending</asp:ListItem>
            <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
            <asp:ListItem Value="Completed">Completed</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-4">
          <label class="form-label">Assigned To</label>
          <asp:DropDownList ID="ddlAssignedTo" runat="server" CssClass="form-select"></asp:DropDownList>
        </div>
        <div class="col-12">
          <label class="form-label">Description</label>
          <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" placeholder="Task details..." />
        </div>
        </div>
        <div class="mt-4 d-flex gap-2 flex-wrap">
          <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary px-4" OnClick="btnSave_Click"><i class="bx bx-save me-1"></i>Save Task</asp:LinkButton>
          <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-label-secondary px-4" OnClick="btnCancel_Click" CausesValidation="false"><i class="bx bx-x me-1"></i>Cancel</asp:LinkButton>
        </div>
      </asp:Panel>
    </div>
  </div>

  <div class="card crm-panel">
    <div class="card-header crm-panel-head d-flex flex-wrap justify-content-between align-items-center gap-2">
      <h5 class="mb-0"><i class="bx bx-list-ul me-2"></i>All Tasks</h5>
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
        <asp:BoundField DataField="Title" HeaderText="Task" />
        <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />
        <asp:TemplateField HeaderText="Priority">
          <ItemTemplate>
            <span class='badge st-<%# Eval("Priority").ToString().Replace(" ", "") %>'><%# Eval("Priority") %></span>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Status">
          <ItemTemplate>
            <span class='badge st-<%# Eval("Status").ToString().Replace(" ", "") %>'><%# Eval("Status") %></span>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="AssignedName" HeaderText="Assigned To" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton runat="server" CommandName="cmd_done" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-ok" ToolTip="Mark Completed"><i class="bx bx-check-circle"></i></asp:LinkButton>
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
