<%@ Page Title="BikeTour - ContectUs" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="ContactUs.aspx.cs"
    Inherits="ContactUs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pagepadding">
        <h3 class="colorh">
            <asp:Label ID="lblh3" runat="server" meta:ResourceKey="lblh3"></asp:Label></h3>
        <h2 class="colorh">
            <asp:Label ID="lblh2Head" runat="server" meta:ResourceKey="lblh2Head"></asp:Label>
        </h2>
        <br />
        <h2>
            <asp:Label ID="lblh2" runat="server" meta:ResourceKey="lblh2"></asp:Label></h2>
        <p>
            <asp:Label ID="lblp1" runat="server" meta:ResourceKey="lblp1"></asp:Label></p>
        <p>
            <asp:Label ID="lblp2" runat="server" meta:ResourceKey="lblp2"></asp:Label></p>
        <br />
        <h2>
            <asp:Label ID="lblh2n" runat="server" meta:ResourceKey="lblh2n"></asp:Label></h2>
        <asp:Label ID="lblEmail" runat="server">biketour@gmail.com</asp:Label>
         
        <br />
        <h3>
            <asp:Label ID="lblh3n" runat="server" meta:ResourceKey="lblh3n"></asp:Label></h3>
        <p class="lightcol">
            <asp:Label ID="lblp3" runat="server" meta:ResourceKey="lblp3"></asp:Label></p>
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
            <asp:Label ID="lblp4" runat="server" meta:ResourceKey="lblp4"></asp:Label></p>
        <asp:TextBox ID="txtComments" runat="server" TextMode="MultiLine" CssClass="multiline"></asp:TextBox><span
            class="error">*</span><br />
        <asp:RequiredFieldValidator ID="rfvtxtComment" runat="server" ControlToValidate="txtComments"
            Display="Dynamic" meta:ResourceKey="rfvtxtComment" CssClass="error" ValidationGroup="Submit"></asp:RequiredFieldValidator>
            <br />
        <asp:Button ID="btnSend" runat="server" meta:ResourceKey="btnSend" OnClick="btnSend_Click"
            ValidationGroup="Submit" />
        <asp:Label ID="lblMessage" runat="server" Text="" meta:ResourceKey="lblMessage" Visible="false"></asp:Label>
    </div>
</asp:Content>
