<%@ Page Title="Bike Tour - Set Date" Culture="de-DE" UICulture="de-DE" Language="C#" MasterPageFile="~/SiteMaster/AdminMaster.master"
    AutoEventWireup="true" CodeFile="CityDateSetting.aspx.cs" Inherits="AppAdmin_CityDateSetting" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <cc1:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></cc1:ToolkitScriptManager>
    <div class="container">
        <h5>
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label></h5>
        <div class="AdminContWrap">
            <div class="frmBox">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblSetCityDate" runat="server" meta:ResourceKey="lblSetCityDate" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_Date" runat="server" ImageUrl="~/Calendar.png"></asp:TextBox><span class="error">*</span>
                            <cc1:CalendarExtender ID="ceLoanTakenDate" runat="server" Format="dd/MM/yyyy" 
    PopupButtonID="txt_Date" TargetControlID="txt_Date">
</cc1:CalendarExtender>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                                ControlToValidate="txt_Date" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvtxt_Date.Error"></asp:RequiredFieldValidator>                           
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="chkMarkInvalidFile" runat="server" meta:ResourceKey="chkMarkInvalidFile.Text" CssClass="blue"></asp:Label>
                        </td>
                        <td>
                            <asp:CheckBox ID="chkMarkInvalid" runat="server"></asp:CheckBox>                            
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
