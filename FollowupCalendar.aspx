<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FollowupCalendar.aspx.cs" Inherits="CRM_PROJECT.FollowupCalendar" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Follow-Up Calendar | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-calendar"></i></div>
      <div>
        <h4 class="mb-0">Follow-Up Calendar</h4>
        <span class="text-muted">See all calls, meetings and emails planned for each day.</span>
      </div>
    </div>
    <a href="Followups.aspx" class="btn btn-primary"><i class="bx bx-plus me-1"></i>Add Follow-Up</a>
  </div>

  <div class="row g-4">
    <div class="col-xl-9">
      <div class="card crm-panel">
        <div class="card-header crm-panel-head d-flex flex-wrap justify-content-between align-items-center gap-2">
          <h5 class="mb-0"><i class="bx bx-calendar me-2"></i><asp:Literal ID="litMonth" runat="server" /></h5>
          <div class="d-flex gap-2">
            <asp:LinkButton ID="btnPrev" runat="server" CssClass="btn btn-label-secondary" OnClick="btnPrev_Click"><i class="bx bx-chevron-left"></i> Prev</asp:LinkButton>
            <asp:LinkButton ID="btnToday" runat="server" CssClass="btn btn-primary" OnClick="btnToday_Click">Today</asp:LinkButton>
            <asp:LinkButton ID="btnNext" runat="server" CssClass="btn btn-label-secondary" OnClick="btnNext_Click">Next <i class="bx bx-chevron-right"></i></asp:LinkButton>
          </div>
        </div>
        <div class="card-body p-2 p-md-3">
          <div class="cal-legend">
            <span><i class="cal-dot cal-Pending"></i> Pending</span>
            <span><i class="cal-dot cal-Done"></i> Done</span>
            <span><i class="cal-dot cal-Cancelled"></i> Cancelled</span>
          </div>
          <div class="table-responsive">
            <asp:Literal ID="litCalendar" runat="server" />
          </div>
        </div>
      </div>
    </div>

    <div class="col-xl-3">
      <div class="card crm-panel mb-4">
        <div class="card-header crm-panel-head"><h5 class="mb-0"><i class="bx bx-sun me-2"></i>Today</h5></div>
        <div class="card-body"><asp:Literal ID="litToday" runat="server" /></div>
      </div>
      <div class="card crm-panel">
        <div class="card-header crm-panel-head"><h5 class="mb-0"><i class="bx bx-error-circle me-2 text-danger"></i>Overdue</h5></div>
        <div class="card-body"><asp:Literal ID="litOverdue" runat="server" /></div>
      </div>
    </div>
  </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
