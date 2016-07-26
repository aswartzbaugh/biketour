<%@ page title="Bike Tour - My Profile" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_MyProfile, App_Web_qvm2tkwv" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <div class="container">
        <h5>
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label></h5>
        <div class="AdminContWrap">
            <div class="frmBox">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_FirstName" runat="server"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                                ControlToValidate="txt_FirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvFirstName"></asp:RequiredFieldValidator>
                            <%--<asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" ValidChars=" "
                                TargetControlID="txt_FirstName" FilterType="LowercaseLetters, UppercaseLetters, Custom" FilterMode="ValidChars">
                            </asp:FilteredTextBoxExtender>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_LastName" runat="server"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                                ControlToValidate="txt_LastName" meta:ResourceKey="rfvLastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <%--<asp:FilteredTextBoxExtender ID="FilteredTextBoxExtender2" runat="server" ValidChars=" "
                                TargetControlID="txt_LastName" FilterType="LowercaseLetters, UppercaseLetters, Custom" FilterMode="ValidChars">
                            </asp:FilteredTextBoxExtender>--%>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server"
                                ControlToValidate="txtAddress" meta:ResourceKey="rfvAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                ControlToValidate="txtEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvEmail"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                               CssClass="error" Display="Dynamic" meta:ResourceKey="rev_Email"
                                ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" ValidationGroup="Submit">
                            </asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td valign="top">
                            <asp:Label ID="lblCity" runat="server" meta:ResourceKey="lblCity" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <asp:DataList ID="dlstCity" runat="server" BackColor="White" Width="150px">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCityName" runat="server" Text='<%# Eval("cityname") %>' />
                                            <br />
                                        </ItemTemplate>
                                    </asp:DataList>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UPanel2" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" ValidationGroup="Submit" OnClick="btn_Save_Click" />
                                    <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click" />
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btn_Save" />
                                    <asp:PostBackTrigger ControlID="btn_Cancel" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>

            </div>
            <asp:HiddenField ID="hdn_MyProfileId" runat="server" />
        </div>
    </div>
</asp:Content>
