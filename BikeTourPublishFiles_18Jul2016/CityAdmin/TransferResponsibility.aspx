<%@ page title="Bike Tour - Transfer Responsibility" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="CityAdmin_TransferResponsibility, App_Web_qvm2tkwv" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
<h5>
    <asp:Label ID="lblClassAdmin" runat="server" meta:ResourceKey="lblClassAdmin"></asp:Label>
</h5>
<div class="AdminContWrap">
    <asp:Panel ID="pnl_AddAdmin" runat="server">
        
        <div id="div_AdminList" class="frmBox">
                <table>
                    <tr>
                        <td><asp:Label ID="lbl_AdminList" runat="server" meta:ResourceKey="lbl_AdminList"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddl_ClassAdmins" runat="server" 
                                DataSourceID="sds_ClassAdmins" DataTextField="UserName" 
                                DataValueField="ClassAdminId">
                            </asp:DropDownList><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfv_Admin" runat="server" meta:ResourceKey="rfv_Admin"
                                Display="Dynamic" ControlToValidate="ddl_ClassAdmins" InitialValue="0" ValidationGroup="Save"
                                CssClass="error"></asp:RequiredFieldValidator>

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
                        <td><asp:Button ID="btn_SaveAdmin" runat="server" meta:ResourceKey="btn_SaveAdmin" 
                                ValidationGroup="Save" onclick="btn_SaveAdmin_Click" />
                            <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click" />
                        </td>
                    </tr>
                </table>
            </div> 
        <center>
        <h2> <b><asp:Label ID="lblOR" meta:ResourceKey="lblOR" runat="server"></asp:Label></b></h2></center> 
        <div class="frmBox">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_FirstName" runat="server"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" meta:ResourceKey="rfvFirstName"
                                ControlToValidate="txt_FirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_LastName" runat="server" CssClass="gltxt"></asp:TextBox><span
                                class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" meta:ResourceKey="rfvLastName"
                                ControlToValidate="txt_LastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="gltxt"></asp:TextBox><span
                                class="error">*</span>
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
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" meta:ResourceKey="rfvEmail"
                                ControlToValidate="txtEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" meta:ResourceKey="rev_Email" ControlToValidate="txtEmail"
                                CssClass="error" Display="Dynamic"
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
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" meta:ResourceKey="rfvPassword" 
                                ControlToValidate="txtPassword" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr runat="server" id="tr_Conpassword">
                        <td>
                            <asp:Label ID="lblConfirmPassword" runat="server" meta:ResourceKey="lblConfirmPassword" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="gltxt"></asp:TextBox><span
                                class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" meta:ResourceKey="rfvConfirmPassword" runat="server"
                                ControlToValidate="txtConfirmPassword" ValidationGroup="Submit" CssClass="error"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cmpvalPassword" runat="server" meta:ResourceKey="cmpvalPassword"
                                Display="Dynamic" ValidationGroup="Submit" Type="String" Operator="Equal" ControlToCompare="txtPassword"
                                ControlToValidate="txtConfirmPassword" CssClass="error"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" ValidationGroup="Submit" OnClick="btn_Save_Click" />
                            <asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" OnClick="btn_Cancel_Click" />
                        </td>
                    </tr>
                </table>
                <asp:HiddenField ID="hdn_ClassAdminId" runat="server" Value="0" />
            </div>
            
            
    </asp:Panel>
</div>
        </div>
</asp:Content>

