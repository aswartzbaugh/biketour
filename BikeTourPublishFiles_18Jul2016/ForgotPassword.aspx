<%@ page language="C#" culture="de-DE" uiculture="de-DE" autoeventwireup="true" inherits="ForgotPassword, App_Web_1q0p2yyy" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<link href="_css/AdminLayout.css" rel="stylesheet" type="text/css" />
    <title>Bike Tour - Forgot Password</title>
    <style type="text/css">
        .text
        {
            display: block;
            line-height: 20px;
            height: auto;
            font-family: arial, Helvetica, sans-serif;
            font-size: 12px;
            padding: 2px 0px;
            font-weight: 100;
            color:#ffffff;
            text-align:justify;
        }
        .message
        {
            background-color: #7FFFD4;
            display: block;
            width: 600px !important;
            line-height: 20px;
            height: auto;
            font-family: arial, Helvetica, sans-serif;
            font-size: 12px;
            padding: 2px 0px;
            font-weight: 150;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Panel ID="pnlRequest" CssClass="LoginWrap" runat="server">
           
            <table>
                
                
            </table>
              <div class="LoginHeader">
                <asp:Label ID="lblForgotPwd" runat="server" CssClass="ForgotPwd" meta:ResourceKey="lblForgotPwd"></asp:Label>
            </div>
            <div class="LoginInnerwrap">
                <table cellpadding="0" cellspacing="10" width="100%">
                    <tr>
                        <td colspan="2">
                           <asp:Label ID="lblStartMessage" runat="server" meta:ResourceKey="lblStartMessage" CssClass="text"></asp:Label>
                        </td>
                    </tr>
                   <tr>
                    <td width="50px">
                        <asp:Label ID="lblEmail" runat="server" CssClass="Loginlbl" meta:ResourceKey="lblEmail"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtEmail" runat="server" Width="200 px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" Display="Dynamic"
                            ControlToValidate="txtEmail" ValidationGroup="Submit" CssClass="error" meta:ResourceKey="rfvEmail"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                         meta:ResourceKey="rev_Email" CssClass="error" Display="Dynamic"
                        ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" ValidationGroup="Submit"
                        ForeColor="#FF3300">
                    </asp:RegularExpressionValidator>
                    </td>
                </tr>
                   <tr>
                    <td colspan="2">
                        <table>
                            <tr>
                                <td><asp:Button ID="btnRequest" runat="server" CssClass="Loginbtn" meta:ResourceKey="btnRequest" OnClick="btnRequest_Click" Width="185px" ValidationGroup="Submit" /></td>
                                <td><asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" CssClass="Loginbtn" onclick="btnCancel_Click" /></td>
                            </tr>
                        </table>
                    </td>
                </tr>
                </table>
                
            </div>
        </asp:Panel>
        <asp:Panel ID="pnlMessage" runat="server">
                <asp:Label ID="lblMessageEnd" runat="server" meta:ResourceKey="lblMessageEnd" CssClass="message"></asp:Label>
        </asp:Panel>
    </div>
    </form>
</body>
</html>
