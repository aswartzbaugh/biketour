<%@ page language="C#" culture="de-DE" uiculture="de-DE" autoeventwireup="true" inherits="Login, App_Web_bgysvwkt" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <METAHTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    <link href="_css/AdminLayout.css" rel="stylesheet" type="text/css" />
    <title>Bike Tour - Login</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
    <link rel="icon" href="favicon.ico" type="image/x-icon" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="LoginWrapBg">
        <asp:Panel ID="Panel1" runat="server" CssClass="LoginWrap" DefaultButton="btn_Login">
            <div class="LoginHeader">
                <h2>
                    <asp:Label ID="lblLogin" runat="server" meta:ResourceKey="lblLogin"></asp:Label></h2>

            </div>
            <div class="LoginInnerwrap">
                <table cellpadding="0" cellspacing="10" width="100%">
                    <tr>
                        <td>
                            <asp:Label ID="lbl_UserName" runat="server" meta:ResourceKey="lbl_UserName" CssClass="Loginlbl"></asp:Label><br />
                            <asp:TextBox ID="txt_UserName" runat="server" CssClass="Logintxt left" ToolTip="User Name"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RequiredFieldValidator ID="rfv_UserName" runat="server" ControlToValidate="txt_UserName"
                                CssClass="error" Display="Dynamic" meta:ResourceKey="rfv_UserName"
                                ForeColor="Red" ValidationGroup="Login">
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_UserName" runat="server" ControlToValidate="txt_UserName"
                                meta:ResourceKey="rev_UserName" CssClass="error" Display="Dynamic"
                                
                                ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" ValidationGroup="Login"
                                ForeColor="#FF3300" Enabled="False"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_Password" runat="server" meta:ResourceKey="lbl_Password" CssClass="Loginlbl"></asp:Label><br />
                            <asp:TextBox ID="txt_Password" runat="server" ToolTip="Password" TextMode="Password"
                                CssClass="Logintxt left"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:RequiredFieldValidator ID="rfv_Password" runat="server" ControlToValidate="txt_Password"
                                CssClass="error" Display="Dynamic" meta:ResourceKey="rfv_Password" ForeColor="Red"
                                ValidationGroup="Login">
                            </asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Button ID="btn_Login" runat="server" meta:ResourceKey="btn_Login" ValidationGroup="Login"
                                CssClass="Loginbtn" OnClick="btn_Login_Click" /><br />
                            <div id="div_LoginFailed" runat="server" visible="false">
                                <asp:Label ID="Label1" runat="server" meta:ResourceKey="Label1" CssClass="error"></asp:Label>
                                </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:CheckBox ID="chkRMe" runat="server" CssClass="Loginchk left" meta:ResourceKey="chkRMe" />
                            <asp:HyperLink ID="lnk_forgotpwd" runat="server" CssClass="Loginlbl Right" NavigateUrl="~/ForgotPassword.aspx"
                                meta:ResourceKey="lnk_forgotpwd"></asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:HyperLink ID="lnk_Register" runat="server" CssClass="Loginlbl Right" NavigateUrl="~/StudentRegistration.aspx"
                                meta:ResourceKey="lnk_Register"></asp:HyperLink>
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
    </div>
    <div id="mask">
    </div>
    <asp:Panel ID="pnlMsgWrapp" runat="server" Visible="false">
        <div id="alertBox" class="alertStyle">
            <div class="PopTop">
                <img src="../_images/IconDelete.png" class="right" alt="Close" id="imgClose" />
            </div>
            <div class="PopMid">
                <asp:Label ID="lblAlertMessage" runat="server" Text="" CssClass="alertMessageLabel"></asp:Label>
            </div>
            <div class="PopBot">
            </div>
        </div>
    </asp:Panel>
    </form>
</body>
</html>
