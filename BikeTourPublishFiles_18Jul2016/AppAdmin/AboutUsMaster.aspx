<%@ page title="BikeTour - About Us" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_AddCityContent, App_Web_x1fc3qah" culture="de-DE" uiculture="de-DE" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <div class="container">
    <h5 id="h1_ClassForum" runat="server">
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
        </asp:Label></h5>
    <div class="frmBox">
        <table>
            <tr>
                <td>
                    &nbsp
                </td>
                <td>
                    <asp:Label ID="lblMessage" runat="server" CssClass="massage"></asp:Label><br />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblDescription" runat="server" meta:ResourceKey="lblDescription"></asp:Label>
                </td>
                <td>
                    <cc1:Editor ID="txtEDescription" runat="server"/>
                  
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp
                </td>
                <td>
                    <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" meta:ResourceKey="btnUpdate"/>
                </td>
            </tr>
        </table>
    </div>
    </div>
</asp:Content>
