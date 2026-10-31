<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Pipeline.aspx.cs" Inherits="CRM_PROJECT.Pipeline" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Lead Pipeline | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="crm-page-head">
        <div class="d-flex align-items-center gap-3">
            <div class="crm-page-icon"><i class="bx bx-columns"></i></div>
            <div>
                <h4 class="mb-0">Lead Pipeline</h4>
                <span class="text-muted">Move leads from first contact to deal won using the arrows.</span>
            </div>
        </div>
        <div class="d-flex gap-2 align-items-center flex-wrap">
            <div class="crm-total-pill">
                <span class="text-muted">Open pipeline value</span>
                <strong>Rs.
                    <asp:Literal ID="litTotalValue" runat="server" Text="0" /></strong>
            </div>
            <a href="Leads.aspx" class="btn btn-primary"><i class="bx bx-plus me-1"></i>Add Lead</a>
        </div>
    </div>

    <asp:Literal ID="litMsg" runat="server" />

    <div class="kb-board">
        <asp:Literal ID="litBoard" runat="server" />
    </div>

</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
