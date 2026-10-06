<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Documents.aspx.cs" Inherits="CRM_PROJECT.Documents" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <title>Documents | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

  <div class="crm-page-head">
    <div class="d-flex align-items-center gap-3">
      <div class="crm-page-icon"><i class="bx bx-folder"></i></div>
      <div>
        <h4 class="mb-0">Documents</h4>
        <span class="text-muted">Upload and manage customer documents.</span>
      </div>
    </div>
    <div class="crm-total-pill">
      <span class="text-muted">Total files</span>
      <strong><asp:Literal ID="litTotal" runat="server" Text="0" /></strong>
    </div>
  </div>

  <asp:Literal ID="litMsg" runat="server" />

  <div class="card crm-panel mb-4">
    <div class="card-header crm-panel-head">
      <h5 class="mb-0"><i class="bx bx-upload me-2"></i><asp:Label ID="lblFormTitle" runat="server" Text="Upload New Document" /></h5>
    </div>
    <div class="card-body">
      <div class="row g-3">
        <div class="col-md-6">
          <label class="form-label">Customer <span class="text-danger">*</span></label>
          <asp:DropDownList ID="ddlCustomerId" runat="server" CssClass="form-select"></asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label class="form-label">Document Name <span class="text-danger">*</span></label>
          <asp:TextBox ID="txtDocName" runat="server" CssClass="form-control" placeholder="e.g. Contract - Nova Traders" />
        </div>
        <div class="col-md-6">
          <label class="form-label">Document Type</label>
          <asp:DropDownList ID="ddlDocType" runat="server" CssClass="form-select">
            <asp:ListItem Value="Contract">Contract</asp:ListItem>
            <asp:ListItem Value="Proposal">Proposal</asp:ListItem>
            <asp:ListItem Value="Invoice">Invoice</asp:ListItem>
            <asp:ListItem Value="Other">Other</asp:ListItem>
          </asp:DropDownList>
        </div>
        <div class="col-md-6">
          <label class="form-label">File <span class="text-danger">*</span></label>
          <asp:FileUpload ID="fuFile" runat="server" CssClass="form-control" />
          <small class="text-muted">Allowed: pdf, doc, docx, xls, xlsx, ppt, pptx, txt, csv, png, jpg (max 10 MB). When editing, leave empty to keep the old file.</small>
        </div>
      </div>
      <div class="mt-4 d-flex gap-2 flex-wrap">
        <asp:LinkButton ID="btnSave" runat="server" CssClass="btn btn-primary px-4" OnClick="btnSave_Click"><i class="bx bx-upload me-1"></i>Upload Document</asp:LinkButton>
        <asp:LinkButton ID="btnCancel" runat="server" CssClass="btn btn-label-secondary px-4" OnClick="btnCancel_Click"><i class="bx bx-x me-1"></i>Cancel</asp:LinkButton>
      </div>
    </div>
  </div>

  <div class="card crm-panel">
    <div class="card-header crm-panel-head d-flex flex-wrap justify-content-between align-items-center gap-2">
      <h5 class="mb-0"><i class="bx bx-list-ul me-2"></i>All Documents</h5>
      <asp:Panel ID="pnlSearch" runat="server" DefaultButton="btnSearch" CssClass="crm-search-box">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..." />
        <asp:LinkButton ID="btnSearch" runat="server" CssClass="btn btn-primary" OnClick="btnSearch_Click"><i class="bx bx-search"></i></asp:LinkButton>
        <asp:LinkButton ID="btnReset" runat="server" CssClass="btn btn-label-secondary" OnClick="btnReset_Click"><i class="bx bx-refresh"></i></asp:LinkButton>
      </asp:Panel>
    </div>
    <div class="table-responsive">
      <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
        CssClass="table crm-table align-middle mb-0" GridLines="None" BorderWidth="0"
        EmptyDataText="No documents uploaded yet." OnRowCommand="gv_RowCommand">
        <Columns>
          <asp:BoundField DataField="Id" HeaderText="#" />
          <asp:BoundField DataField="DocName" HeaderText="Name" />
          <asp:BoundField DataField="CustomerName" HeaderText="Customer" />
          <asp:TemplateField HeaderText="Type"><ItemTemplate><span class='badge st-<%# Eval("DocType") %>'><%# Eval("DocType") %></span></ItemTemplate></asp:TemplateField>
          <asp:BoundField DataField="FileSizeText" HeaderText="Size" />
          <asp:BoundField DataField="UploadedBy" HeaderText="Uploaded By" />
          <asp:BoundField DataField="UploadedDate" HeaderText="Uploaded On" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />
          <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
              <a href='<%# "Uploads/" + Eval("FilePath") %>' target="_blank" download class="crm-act crm-act-ok" title="Download"><i class="bx bx-download"></i></a>
              <asp:LinkButton runat="server" CommandName="cmd_edt" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-edit" ToolTip="Edit"><i class="bx bx-edit-alt"></i></asp:LinkButton>
              <asp:LinkButton runat="server" CommandName="cmd_dlt" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-del" ToolTip="Delete" OnClientClick="return confirm('Delete this document?');"><i class="bx bx-trash"></i></asp:LinkButton>
            </ItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
