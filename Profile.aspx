
<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="CRM_PROJECT.Profile" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <title>Profile | CRM System</title>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

    <div class="container mt-4">

        <div class="row">

            <div class="col-md-4">

                <div class="card text-center">

                    <div class="card-body">

                        <div class="rounded-circle bg-primary text-white mx-auto mb-3"
                             style="width:80px;height:80px;display:flex;align-items:center;justify-content:center;font-size:35px;">

                            <asp:Literal ID="litAvatarInitial" runat="server"></asp:Literal>

                        </div>

                        <h4>
                            <asp:Literal ID="litDisplayName" runat="server"></asp:Literal>
                        </h4>

                        <p class="text-muted">
                            <asp:Literal ID="litDisplayRole" runat="server"></asp:Literal>
                        </p>

                    </div>

                </div>

            </div>


            <div class="col-md-8">

                <div class="card">

                    <div class="card-body">

                        <h4 class="mb-4">My Profile</h4>

                        <asp:Literal ID="litProfileMsg" runat="server"></asp:Literal>


                        <div class="mb-3">

                            <label class="form-label">Full Name</label>

                            <asp:TextBox
                                ID="txtFullName"
                                runat="server"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">Email</label>

                            <asp:TextBox
                                ID="txtEmail"
                                runat="server"
                                TextMode="Email"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">Phone</label>

                            <asp:TextBox
                                ID="txtPhone"
                                runat="server"
                                TextMode="Phone"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">Role</label>

                            <asp:TextBox
                                ID="txtRole"
                                runat="server"
                                CssClass="form-control"
                                ReadOnly="true">
                            </asp:TextBox>

                        </div>


                        <asp:Button
                            ID="btnSaveProfile"
                            runat="server"
                            Text="Save Profile"
                            CssClass="btn btn-primary"
                            OnClick="btnSaveProfile_Click" />

                    </div>

                </div>


                <div class="card mt-4">

                    <div class="card-body">

                        <h4 class="mb-4">Change Password</h4>

                        <asp:Literal ID="litPasswordMsg" runat="server"></asp:Literal>


                        <div class="mb-3">

                            <label class="form-label">Current Password</label>

                            <asp:TextBox
                                ID="txtCurrentPassword"
                                runat="server"
                                TextMode="Password"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">New Password</label>

                            <asp:TextBox
                                ID="txtNewPassword"
                                runat="server"
                                TextMode="Password"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <div class="mb-3">

                            <label class="form-label">Confirm Password</label>

                            <asp:TextBox
                                ID="txtConfirmPassword"
                                runat="server"
                                TextMode="Password"
                                CssClass="form-control">
                            </asp:TextBox>

                        </div>


                        <asp:Button
                            ID="btnUpdatePassword"
                            runat="server"
                            Text="Update Password"
                            CssClass="btn btn-primary"
                            OnClick="btnUpdatePassword_Click" />

                    </div>

                </div>

            </div>

        </div>

    </div>

</asp:Content>


<asp:Content ID="ScriptContent" ContentPlaceHolderID="ContentPlaceHolder3" runat="server">
</asp:Content>

