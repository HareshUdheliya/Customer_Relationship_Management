<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="ActivityLog.aspx.cs" Inherits="CRM_PROJECT.ActivityLog" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Activity Log | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-history"></i></div>
      <div>
        <h4 class="mb-0">Activity Log</h4>
        <span class="text-muted">Track user activities and system changes.</span>
      </div>
    </div>
    <div class="crm-total-pill">
      <span class="text-muted">Total entries</span>
      <strong><asp:Literal ID="litTotal" runat="server" Text="0" /></strong>
    </div>
  </div>

  <asp:Literal ID="litMsg" runat="server" />

  <div class="card crm-panel">
    <div class="card-header crm-panel-head d-flex flex-wrap justify-content-between align-items-center gap-2">
      <h5 class="mb-0"><i class="bx bx-list-ul me-2"></i>Recent Activity</h5>
      <div class="d-flex gap-2 flex-wrap">
        <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" CssClass="crm-search-box">
          <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..." />
          <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click"><i class="bx bx-search"></i></asp:LinkButton>
          <asp:LinkButton ID="btnReset" runat="server" CssClass="btn btn-label-secondary" OnClick="btnReset_Click"><i class="bx bx-refresh"></i></asp:LinkButton>
        </asp:Panel>
        <asp:LinkButton ID="btnClear" runat="server" CssClass="btn btn-danger" OnClick="btnClear_Click" OnClientClick="return confirm('Delete ALL activity log entries?');"><i class="bx bx-trash me-1"></i>Clear All</asp:LinkButton>
      </div>
    </div>
    <div class="table-responsive">
      <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
        CssClass="table crm-table align-middle mb-0" GridLines="None" BorderWidth="0"
        EmptyDataText="No activity recorded yet." OnRowCommand="gv_RowCommand">
        <Columns>
          <asp:BoundField DataField="Id" HeaderText="#" />
          <asp:BoundField DataField="UserName" HeaderText="User" />
          <asp:BoundField DataField="Action" HeaderText="Action" ItemStyle-CssClass="crm-cell-long" />
          <asp:BoundField DataField="CreatedDate" HeaderText="Date &amp; Time" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" HtmlEncode="false" />
          <asp:TemplateField HeaderText="Delete">
            <ItemTemplate>
              <asp:LinkButton runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-del" ToolTip="Delete" OnClientClick="return confirm('Delete this entry?');"><i class="bx bx-trash"></i></asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
