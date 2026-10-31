<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="CustomerDetails.aspx.cs" Inherits="CRM_PROJECT.CustomerDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Customer 360 | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <asp:Literal ID="litMsg" runat="server" />

    <%-- HERO --%>
    <div class="crm-cust-hero">
        <div class="d-flex align-items-center gap-3 flex-wrap">
            <div class="crm-avatar-lg">
                <asp:Literal ID="litAvatar" runat="server" /></div>
            <div>
                <h3 class="mb-1">
                    <asp:Literal ID="litName" runat="server" /></h3>
                <div class="d-flex align-items-center gap-2 flex-wrap">
                    <span class="opacity-75"><i class="bx bx-building-house me-1"></i>
                        <asp:Literal ID="litCompany" runat="server" /></span>
                    <asp:Literal ID="litStatus" runat="server" />
                </div>
            </div>
        </div>
        <div class="d-flex gap-2 flex-wrap">
            <a href="Customers.aspx" class="btn btn-light"><i class="bx bx-arrow-back me-1"></i>Back to Customers</a>
            <a href="Documents.aspx" class="btn btn-light"><i class="bx bx-upload me-1"></i>Upload Document</a>
        </div>
    </div>

    <%-- STATS --%>
    <div class="row g-3 mb-4">
        <div class="col-sm-4">
            <div class="card crm-stat-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Pending Follow-ups</p>
                        <h4 class="mb-0">
                            <asp:Literal ID="litPending" runat="server" Text="0" /></h4>
                    </div>
                    <div class="crm-stat-icon bg-warning-subtle text-warning"><i class="bx bx-calendar-check"></i></div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="card crm-stat-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Notes</p>
                        <h4 class="mb-0">
                            <asp:Literal ID="litNotes" runat="server" Text="0" /></h4>
                    </div>
                    <div class="crm-stat-icon bg-primary-subtle text-primary"><i class="bx bx-note"></i></div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="card crm-stat-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <p class="text-muted mb-1">Documents</p>
                        <h4 class="mb-0">
                            <asp:Literal ID="litDocs" runat="server" Text="0" /></h4>
                    </div>
                    <div class="crm-stat-icon bg-success-subtle text-success"><i class="bx bx-folder"></i></div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">

        <%-- LEFT COLUMN --%>
        <div class="col-lg-4">
            <div class="card crm-panel mb-4">
                <div class="card-header crm-panel-head">
                    <h5 class="mb-0"><i class="bx bx-id-card me-2"></i>Customer Details</h5>
                </div>
                <div class="card-body">
                    <asp:Literal ID="litInfo" runat="server" /></div>
            </div>

            <div class="card crm-panel mb-4">
                <div class="card-header crm-panel-head">
                    <h5 class="mb-0"><i class="bx bx-calendar-plus me-2"></i>Quick Follow-Up</h5>
                </div>
                <div class="card-body">
                    <asp:Panel ID="pnlFollow" runat="server" DefaultButton="btnAddFollowup">
                        <div class="mb-3">
                            <label class="form-label">Date <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtFDate" runat="server" TextMode="Date" CssClass="form-control" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Mode</label>
                            <asp:DropDownList ID="ddlFMode" runat="server" CssClass="form-select">
                                <asp:ListItem>Call</asp:ListItem>
                                <asp:ListItem>Email</asp:ListItem>
                                <asp:ListItem>Meeting</asp:ListItem>
                                <asp:ListItem>WhatsApp</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Remarks</label>
                            <asp:TextBox ID="txtFRemarks" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-control" placeholder="What to discuss?" />
                        </div>
                        <asp:LinkButton ID="btnAddFollowup" runat="server" CssClass="btn btn-primary w-100" OnClick="btnAddFollowup_Click"><i class="bx bx-plus me-1"></i>Add Follow-Up</asp:LinkButton>
                    </asp:Panel>
                </div>
            </div>

            <div class="card crm-panel">
                <div class="card-header crm-panel-head">
                    <h5 class="mb-0"><i class="bx bx-edit me-2"></i>Quick Note</h5>
                </div>
                <div class="card-body">
                    <asp:Panel ID="pnlNote" runat="server" DefaultButton="btnAddNote">
                        <div class="mb-3">
                            <label class="form-label">Title <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtNTitle" runat="server" CssClass="form-control" placeholder="e.g. Price discussion" />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Note <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtNText" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control" placeholder="Write note..." />
                        </div>
                        <asp:LinkButton ID="btnAddNote" runat="server" CssClass="btn btn-primary w-100" OnClick="btnAddNote_Click"><i class="bx bx-plus me-1"></i>Add Note</asp:LinkButton>
                    </asp:Panel>
                </div>
            </div>
        </div>

        <%-- RIGHT COLUMN --%>
        <div class="col-lg-8">

            <div class="card crm-panel mb-4">
                <div class="card-header crm-panel-head d-flex justify-content-between align-items-center">
                    <h5 class="mb-0"><i class="bx bx-calendar-check me-2"></i>Follow-Ups</h5>
                    <a href="FollowupCalendar.aspx" class="btn btn-sm btn-label-secondary"><i class="bx bx-calendar me-1"></i>Calendar</a>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvFollowups" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                        CssClass="table crm-table align-middle mb-0" GridLines="None" BorderWidth="0"
                        EmptyDataText="No follow-ups for this customer yet." OnRowCommand="gvFollowups_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="FollowupDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />
                            <asp:BoundField DataField="Mode" HeaderText="Mode" />
                            <asp:TemplateField HeaderText="Status">
                                <ItemTemplate><span class='badge st-<%# Eval("Status") %>'><%# Eval("Status") %></span></ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Remarks" HeaderText="Remarks" ItemStyle-CssClass="crm-cell-long" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="f_done" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-ok" ToolTip="Mark Done"><i class="bx bx-check-circle"></i></asp:LinkButton>
                                    <asp:LinkButton runat="server" CommandName="f_del" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-del" ToolTip="Delete" OnClientClick="return confirm('Delete this follow-up?');"><i class="bx bx-trash"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="card crm-panel mb-4">
                <div class="card-header crm-panel-head">
                    <h5 class="mb-0"><i class="bx bx-note me-2"></i>Notes</h5>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvNotes" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                        CssClass="table crm-table align-middle mb-0" GridLines="None" BorderWidth="0"
                        EmptyDataText="No notes for this customer yet." OnRowCommand="gvNotes_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="Title" HeaderText="Title" />
                            <asp:BoundField DataField="NoteText" HeaderText="Note" ItemStyle-CssClass="crm-cell-long" />
                            <asp:BoundField DataField="CreatedBy" HeaderText="Added By" />
                            <asp:BoundField DataField="CreatedDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />
                            <asp:TemplateField HeaderText="Delete">
                                <ItemTemplate>
                                    <asp:LinkButton runat="server" CommandName="n_del" CommandArgument='<%# Eval("Id") %>' CssClass="crm-act crm-act-del" ToolTip="Delete" OnClientClick="return confirm('Delete this note?');"><i class="bx bx-trash"></i></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>

            <div class="card crm-panel">
                <div class="card-header crm-panel-head">
                    <h5 class="mb-0"><i class="bx bx-folder me-2"></i>Documents</h5>
                </div>
                <div class="table-responsive">
                    <asp:GridView ID="gvDocs" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
                        CssClass="table crm-table align-middle mb-0" GridLines="None" BorderWidth="0"
                        EmptyDataText="No documents uploaded for this customer.">
                        <Columns>
                            <asp:BoundField DataField="DocName" HeaderText="Name" />
                            <asp:BoundField DataField="DocType" HeaderText="Type" />
                            <asp:BoundField DataField="UploadedBy" HeaderText="Uploaded By" />
                            <asp:BoundField DataField="UploadedDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" HtmlEncode="false" />
                            <asp:TemplateField HeaderText="Download">
                                <ItemTemplate>
                                    <a href='<%# "Uploads/" + Eval("FilePath") %>' target="_blank" download class="crm-act crm-act-ok" title="Download"><i class="bx bx-download"></i></a>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>
