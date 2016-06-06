<%@ Page Culture="de-DE" UICulture="de-DE" Title="Bike Tour - My Profile" Language="C#" AutoEventWireup="true" MasterPageFile="~/SiteMaster/AdminMaster.master" CodeFile="MyProfile.aspx.cs" Inherits="ClassAdmin_myProfile" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () { $("[id$=btnDelete]").hide(); });
        function Confirm(obj) {
            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdn_ClassAdminId]").val(obj);
                $("[id$=btnDelete]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <div class="container">
    <h5>
    <asp:Label ID="lblMyProfile" runat="server" meta:ResourceKey="lblMyProfile"></asp:Label>
    </h5>
    <div class="AdminContWrap">

        <asp:Panel ID="pnl_MyProfile" runat="server" Visible="false">
            <div class="frmBox">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblFirstName" meta:ResourceKey="lblFirstName" runat="server"
                                CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_FirstName" runat="server" CssClass="gltxt"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" meta:ResourceKey="rfvFirstName"
                                ControlToValidate="txt_FirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <%--<asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" ValidChars=" "
                                TargetControlID="txt_FirstName" FilterType="LowercaseLetters, UppercaseLetters, Custom" FilterMode="ValidChars">
                            </asp:FilteredTextBoxExtender>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_LastName" runat="server" CssClass="gltxt"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" meta:ResourceKey="rfvLastName"
                                ControlToValidate="txt_LastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <%--<asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" ValidChars=" "
                                TargetControlID="txt_LastName" FilterType="LowercaseLetters, UppercaseLetters, Custom" FilterMode="ValidChars">
                            </asp:FilteredTextBoxExtender>--%>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="gltxt"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" meta:ResourceKey="rfvAddress"
                                ControlToValidate="txtAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="gltxt"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                ControlToValidate="txtEmail" meta:ResourceKey="rfvEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                CssClass="error" Display="Dynamic" meta:ResourceKey="rev_Email"
                                ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" ValidationGroup="Submit">
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool" CssClass="Glblbl"></asp:Label></td>
                        <td align="right">
                            <asp:GridView ID="grdClasses" runat="server" AutoGenerateColumns="false" Width="100%" BackColor="White"
                                ShowHeader="false" GridLines="None" AllowSorting="true">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblSchool" runat="server" Text='<%# Eval("School") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Label ID="lblClasses" runat="server" Text='<%# Eval("classes") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <asp:TextBox ID="txtClassID" runat="server" CssClass="gltxt" Visible="false"></asp:TextBox>
                    </tr>

                    <tr>
                        <td>&nbsp;</td>
                        <td>
                            <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" CssClass="glbtn" ValidationGroup="Submit"
                                OnClick="btn_Update_Click" />
                            <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" CssClass="glbtn"
                                OnClick="btn_Cancel_Click" />

                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>

        <asp:HiddenField ID="hdn_MyProfileId" runat="server" />

        <asp:HiddenField ID="hdn_ClassID" runat="server" />

        <asp:Panel ID="pnl_AdminList" runat="server">
        </asp:Panel>
    </div>
</div>
</asp:Content>

