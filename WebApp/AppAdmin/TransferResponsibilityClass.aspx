<%@ Page Title="" Culture="de-DE" UICulture="de-DE" Language="C#" 
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" 
    CodeFile="TransferResponsibilityClass.aspx.cs" Inherits="AppAdmin_TransferResponsibility" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container">
        <h5>
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
        </asp:Label></h5>
        <div class="AdminContWrap">
            <asp:Panel ID="pnl_AddAdmin" runat="server">

                <div id="div_AdminList">
                    <div class="frmBox">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_AdminList" runat="server" meta:ResourceKey="lbl_AdminList"></asp:Label></td>
                                <td>
                                    <asp:DropDownList ID="ddl_ClassAdmins" runat="server"
                                        DataSourceID="sds_ClassAdmins" DataTextField="UserName"
                                        DataValueField="ClassAdminId">
                                    </asp:DropDownList><span class="error">*</span>
                                    <asp:RequiredFieldValidator ID="rfv_Admin" runat="server" 
                                        Display="Dynamic" ControlToValidate="ddl_ClassAdmins" InitialValue="0" ValidationGroup="Save"
                                        CssClass="error" meta:ResourceKey="rfv_Admin"></asp:RequiredFieldValidator>

                                    <asp:SqlDataSource ID="sds_ClassAdmins" runat="server"
                                        ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="Select '0' as ClassAdminId, 'Select Admin' as UserName UNION ALL SELECT [ClassAdminId], FirstName +' '+ LastName as UserName 
FROM [ClassAdminMaster] where IsActive=1 and ClassAdminId!=@ClassAdminId ">
                                        <SelectParameters>
                                            <asp:QueryStringParameter DefaultValue="0" Name="ClassAdminId" QueryStringField="oldAdmin" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    <asp:Button ID="btn_SaveAdmin" runat="server" meta:ResourceKey="btn_SaveAdmin"
                                        ValidationGroup="Save" OnClick="btn_SaveAdmin_Click" />
                                    <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click" Visible="False"  />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <h2 align="center"><b>OR</b></h2>
                <div class="frmBox">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_FirstName" runat="server"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                                    ControlToValidate="txt_FirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"
                                    meta:ResourceKey="rfvFirstName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_LastName" runat="server" CssClass="gltxt"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                                    ControlToValidate="txt_LastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"
                                    meta:ResourceKey="rfvLastName"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAddress" runat="server" CssClass="gltxt"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" 
                                    ControlToValidate="txtAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvAddress"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="gltxt"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                    ControlToValidate="txtEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic"
                                    meta:ResourceKey="rfvEmail"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                     CssClass="error" Display="Dynamic" meta:ResourceKey="rev_Email"
                                    ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" ValidationGroup="Submit">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>

                        <tr runat="server" id="tr_password">
                            <td>
                                <asp:Label ID="lblPassword" runat="server" meta:ResourceKey="lblPassword" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="gltxt"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                                   meta:ResourceKey="rfvPassword" ControlToValidate="txtPassword" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr runat="server" id="tr_Conpassword">
                            <td>
                                <asp:Label ID="lblConfirmPassword" runat="server" meta:ResourceKey="lblConfirmPassword" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="gltxt"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server"
                                    ControlToValidate="txtConfirmPassword" ValidationGroup="Submit" CssClass="error" meta:ResourceKey="rfvConfirmPassword"
                                    Display="Dynamic"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmpvalPassword" runat="server" 
                                    Display="Dynamic" ValidationGroup="Submit" Type="String" Operator="Equal" ControlToCompare="txtPassword"
                                    ControlToValidate="txtConfirmPassword" CssClass="error" meta:ResourceKey="cmpvalPassword"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;
                            </td>
                            <td>
                                <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" ValidationGroup="Submit" OnClick="btn_Save_Click" />
                                <asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" OnClick="btn_Cancel_Click" Visible="False" />
                            </td>
                        </tr>
                    </table>
                    <asp:HiddenField ID="hdn_ClassAdminId" runat="server" Value="0" />
                </div>

                 <h2 align="center"><b>OR</b></h2>
                <div class="frmBox" >
                       <asp:Button ID="btnSetDefault" runat="server"  meta:ResourceKey="btn_SaveDefault" OnClick="btnSetDefault_Click" Width="160px"/>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content> 

