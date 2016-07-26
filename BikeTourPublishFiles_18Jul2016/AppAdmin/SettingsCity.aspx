<%@ page title="BikeTour : Setting City" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_SettingsCity, App_Web_ekadcbkj" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div class="container">
    <h5 id="h1_ClassForum" runat="server">
        <asp:Label ID="lblHead" runat="server" Text="Setting City">
        </asp:Label></h5>
    <div class="frmBox">
<table>
    <tr>
        <td>
            <asp:Label ID="Label1" runat="server" Text="Enter City Name"></asp:Label>
        </td>
        <td>
            <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCity" DataTextField="CityName"
                DataValueField="CityId" AutoPostBack="true" 
                onselectedindexchanged="ddlCity_SelectedIndexChanged">
            </asp:DropDownList>
            <span class="error">*</span>
            <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                SelectCommand="Select 0 as CityId, ' - Select - ' Cityname Union ALL SELECT [CityId], [Cityname] FROM [CityMaster] WHERE ([IsActive] = 1) and IsParticipatingCity=1 order by Cityname Asc  ">
                <SelectParameters>
                    <asp:Parameter DefaultValue="true" Name="IsActive" Type="Boolean" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="Select" 
                ErrorMessage="Select City" ControlToValidate="ddlCity" InitialValue="0">
            </asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <asp:TextBox ID="txtLatitude" runat="server" Enabled="false"></asp:TextBox>
            <asp:TextBox ID="txtLongitude" runat="server" Enabled="false"></asp:TextBox>
        </td>
    </tr>
    <tr>
        <td></td>
        <td>
            <asp:Button ID="btnSave" runat="server" Text="Save Distance Mapping"  ValidationGroup="Select" 
                onclick="btnSave_Click" />
        </td>
    </tr>
</table>
</div>
</asp:Content>

