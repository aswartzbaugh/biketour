<%@ Page Title="Bike Tour - Set Date" Culture="en-US" UICulture="en-US" Language="C#" MasterPageFile="~/SiteMaster/AdminMaster.master"
    AutoEventWireup="true" CodeFile="CityParameters.aspx.cs" Inherits="AppAdmin_CityParameters" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 219px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<script type="text/javascript">

    function ConfirmAll(message) {

        var Ok = confirm(message);
        if (Ok) {
            $("[id$=btnUpdateSettings]").trigger("click");
            return true;
        }
        else {
            return false;
        }
    }

    function successDelete(message) {
        alert(message);
    }
    </script>
<asp:Button ID="btnUpdateSettings"  AutoPostBack="True" runat="server" 
                                onclick="btnUpdateSettings_Click"  CssClass="hide" Style="display: none;"  />
    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </cc1:ToolkitScriptManager>
    <div class="container">
        <h5>
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblCityParamHead"></asp:Label></h5>
        <div class="AdminContWrap">
            <div class="frmBox">
                <table>
                <tr>
                 <td>
                    <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass" CssClass="blue"></asp:Label>
                </td>
                <td>                    
                    <asp:UpdatePanel ID="Up_ddlClass" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="True" DataSourceID="sdsClass"
                                DataTextField="CityName" DataValueField="CityId">
                            </asp:DropDownList>
                            <span class="error right">*</span>
                             <asp:SqlDataSource ID="sdsClass" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand=" select cm.CityId, cm.CityName from CityMaster cm
                                           where cm.IsActive=1
                                           and cm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId) order by CityName
                                               ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CityAdminId" SessionField="UserId" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:RequiredFieldValidator ID="rfvClass" runat="server" meta:ResourceKey="rfvCity"
                                InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="ddlClass" />
                        </Triggers>
                          
                    </asp:UpdatePanel>
                </td>
                </tr>
                    <tr>
                        <td class="style1">
                            <asp:Label ID="lblSetCityDate" runat="server" meta:ResourceKey="lblSetCityDate" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_Date" runat="server" ImageUrl="~/Calendar.png"></asp:TextBox><span class="error">*</span>
                            <cc1:CalendarExtender ID="ceLoanTakenDate" runat="server" Format="yyyy-MM-dd HH:mm:ss" 
    PopupButtonID="txt_Date" TargetControlID="txt_Date">
</cc1:CalendarExtender>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                                ControlToValidate="txt_Date" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvtxt_DateError"></asp:RequiredFieldValidator>                           
                        </td>
                    </tr>
                    <tr>
                        <td class="style1">
                            <asp:Label ID="lblMarkInvalidFile" runat="server" meta:ResourceKey="lblMarkInvalidFile" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkMarkInvalid" runat="server" ></asp:CheckBox>                            
                        </td>
                    </tr>                                 
                    
                    <tr>
                        <td class="style1">&nbsp;
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
