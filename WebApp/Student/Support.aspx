<%@ Page Title="BikeTour - Support" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="Support.aspx.cs"
    Inherits="Support" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" type="text/css" href="../_css/download-button.css">
    <style type="text/css">
        .multiline {
            display: inline-block;
            width: 600px !important;
            padding: 5px;
            height: 70px;
            margin: 2px;
            border: 1px solid #B9BBC6;
            line-height: 18px;
        }
    </style>

    <div class="container">
        <h5>
            <asp:Label ID="lblh3" runat="server" meta:ResourceKey="lblh3"></asp:Label>
        </h5>
        <div class="AdminContWrap">
            <h2 class="colorh">
                <asp:Label ID="lblh2Head" runat="server" meta:ResourceKey="lblh2Head"></asp:Label>
            </h2>
            <br />            
            <h2>
                <asp:Label Font-Bold="true" ID="lblh2" runat="server" meta:ResourceKey="lblh2"></asp:Label></h2>
            <p>
                <asp:Label ID="lblp1" runat="server" meta:ResourceKey="lblp1"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblp2" runat="server" meta:ResourceKey="lblp2"></asp:Label>
            </p>
            <br />
            <h2>
                <asp:Label ID="lblh2n" Font-Bold="true" runat="server" meta:ResourceKey="lblh2n"></asp:Label></h2>
            <a id="mailLink" runat="server"></a>
            <br />
            <br />
            <p class="lightcol">
                <asp:Label ID="lblp3" runat="server" meta:ResourceKey="lblp3"></asp:Label>
            </p>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="textbox"></asp:TextBox><span
                class="error">*</span>
            <asp:RequiredFieldValidator ID="rfvtxtEmail" runat="server" ControlToValidate="txtEmail"
                Display="Dynamic" meta:ResourceKey="rfvtxtEmail" CssClass="error" ValidationGroup="Submit">
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                meta:ResourceKey="revEmail" CssClass="error" Display="Dynamic" ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
                ValidationGroup="Submit" ForeColor="#FF3300">
            </asp:RegularExpressionValidator>

            <p class="lightcol">
                <asp:Label ID="lblp4" runat="server" meta:ResourceKey="lblp4"></asp:Label>
            </p>
            <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" CssClass="multiline"></asp:TextBox><span
                class="error">*</span><br />
            <asp:RequiredFieldValidator ID="rfvtxtComment" runat="server" ControlToValidate="txtComments"
                Display="Dynamic" meta:ResourceKey="rfvtxtComment" CssClass="error" ValidationGroup="Submit"></asp:RequiredFieldValidator>
            <asp:Button ID="btnSend" runat="server" meta:ResourceKey="btnSend" OnClick="btnSend_Click"
                ValidationGroup="Submit" />
            <br />
            <asp:Label ID="lblMessage" runat="server" Text="" meta:ResourceKey="lblMessage" Visible="false"></asp:Label>
             <br />
            <br />
            
        </div>
        <asp:Label ID="lblDownloadMessage" runat="server" Text="" meta:ResourceKey="lblDownloadMessage" Visible="true"></asp:Label>
        <table>
            <tr>                
                <td>
                    <div class="button">
                        <a href="../Downloads/Support/Leitfaden Schüler 2.pdf" target="_blank">Schüler Leitfaden</a>
                    </div>
                </td>
                <td>
                    <div class="button">
                        <a href="../Downloads/Support/setup_NCC_latest.exe" target="_blank">GPS Software</a>
                    </div>
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
