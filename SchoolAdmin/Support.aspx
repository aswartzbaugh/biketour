<%@ Page Title="BikeTour - Support" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="Support.aspx.cs"
    Inherits="Support" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                <asp:Label ID="lblh2" runat="server" meta:ResourceKey="lblh2"></asp:Label></h2>
            <p>
                <asp:Label ID="lblp1" runat="server" meta:ResourceKey="lblp1"></asp:Label>
            </p>
            <p>
                <asp:Label ID="lblp2" runat="server" meta:ResourceKey="lblp2"></asp:Label>
            </p>
            <br />
            <h2>
                <asp:Label ID="lblh2n" runat="server" meta:ResourceKey="lblh2n"></asp:Label></h2>
            <a id="mailLink" runat="server"></a>
            <br />
        </div>
    </div>
</asp:Content>
