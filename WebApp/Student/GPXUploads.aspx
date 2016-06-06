<%@ Page Title="" Culture="de-DE" UICulture="de-DE" Language="C#" MasterPageFile="~/SiteMaster/UserMaster.master" AutoEventWireup="true" CodeFile="GPXUploads.aspx.cs" Inherits="Student_GPXUploads" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div>
    <asp:FileUpload ID="fuGPX" runat="server"  />
    <asp:Button ID="btnUpload" runat="server" meta:ResourceKey="btnUpload" 
        onclick="btnUpload_Click" />
    <asp:GridView ID="grdUploads" runat="server">
    </asp:GridView>
</div>
</asp:Content>

