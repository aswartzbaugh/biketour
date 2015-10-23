<%@ Page Title="Bike Tour - Stage Plan" Language="C#" Culture="de-DE" UICulture="de-DE" MasterPageFile="~/SiteMaster/AdminMaster.master"
    AutoEventWireup="true" CodeFile="StagePlan.aspx.cs" EnableEventValidation="false" Inherits="ClassAdmin_StagePlan" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () { $("[id$=btnDelete]").hide(); });
        function Confirm(obj) {
            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdn_ClassAdminId]").val(obj);
                $("[id$=btnDelete]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }
    </script>
    <style type="text/css">
        .style1 {
            width: 192px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <div class="frmBox_2">
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                </td>
                <td>
                    <asp:UpdatePanel ID="Up_School" runat="server">
                        <ContentTemplate>
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                DataValueField="SchoolId" AutoPostBack="true" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged">
                            </asp:DropDownList>
                                    </td>
                                    <td  valign="top"><span class="error right">*</span>
                                    </td>
                                </tr>
                            </table>
                            
                            
                            <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool" ErrorMessage=""
                                InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                                CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], 'Schule' as [School] union all 
                                select distinct sm.SchoolId, sm.School from ClassAdminClasses cac inner join SchoolMaster sm
                      on cac.SchoolId = sm.SchoolId
                     where ClassAdminId = @ClassAdminId
                      ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ClassAdminId" SessionField="UserId" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>

                    </asp:UpdatePanel>

                </td>
                <td>
                   &nbsp;&nbsp; <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass"></asp:Label>
                </td>
                <td>
                    <asp:UpdatePanel ID="upClass" runat="server">
                        <ContentTemplate>
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:DropDownList ID="ddlClass" runat="server" DataSourceID="sds_Class" DataTextField="ClassName"
                                DataValueField="classid" AutoPostBack="True" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                            </asp:DropDownList>
                                    </td>
                                    <td valign="top"> <span class="error right">*</span>
                                    </td>
                                </tr>
                            </table>
                            
                            

                            <asp:RequiredFieldValidator ID="rfvClass" runat="server" meta:ResourceKey="rfvClass" ErrorMessage=""
                                InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                                Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sds_Class" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="select 'Klasse' as ClassName, '0' as classid union all 
                              select distinct scm.class as ClassName, scm.classid from  ClassAdminClasses cac inner join SchoolClassMaster scm
                            on cac.ClassId = scm.ClassId
                            where  ClassAdminId = @ClassAdminId
                            and cac.SchoolId = @SchoolId">
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="5" Name="ClassAdminId" SessionField="UserId" />
                                    <asp:ControlParameter ControlID="ddlSchool" Name="schoolid" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="ddlClass" />
                        </Triggers>
                    </asp:UpdatePanel>

                </td>
                <td style="width: 40px;">
                    <asp:UpdateProgress ID="UProg" AssociatedUpdatePanelID="Up_School" runat="server">
                        <ProgressTemplate>
                            <img src="../_images/ajax_loader_blue_32.gif" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
                <td style="">
                    <asp:Button ID="btnOk" runat="server" meta:ResourceKey="btnOk" OnClick="btnOk_Click" Visible="false" />
                    <asp:Button ID="btnBack" runat="server" meta:ResourceKey="btnBack" Visible="false" OnClick="btnBack_Click" CssClass="right" />
                </td>
            </tr>
        </table>
    </div>
    <div class="container">
        <h5>Etappenplan</h5>
        <div class="AdminContWrap">
            <div class="clear">
            </div>
            <%--<div class="frmBox">--%>
            <asp:HiddenField ID="hdnClassId" runat="server" Value="0" />
            <asp:HiddenField ID="hdnStagePlanId" runat="server" Value="0" />

            <asp:Panel ID="pnlContent" runat="server" Visible="false">
                <div align="center">
                    <h2>
                        <asp:Label ID="lblClassHeader" runat="server" Text=""></asp:Label>
                    </h2>
                </div>
                <div class="GridWrap" align="left">
                    <asp:UpdatePanel ID="Up_grdStagePlan" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grdStagePlan" runat="server" AutoGenerateColumns="False" DataSourceID="sdsStagePlan"
                                Width="100%" ShowFooter="True" DataKeyNames="StagePlanId,Status" EmptyDataText="Keine Daten vorhanden" CssClass="gv"
                                AllowSorting="True" HeaderStyle-CssClass="gridHeader"
                                OnRowDataBound="grdStagePlan_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Startort">
                                        <ItemTemplate>
                                            <asp:Label ID="lblFromCity" runat="server" Text='<%# Eval("FromCity") %>'></asp:Label>
                                            <asp:Label ID="lblFromCityId" runat="server" Text='<%# Eval("FromCityId") %>' Style="display: none;"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Zielort">
                                        <ItemTemplate>
                                            <asp:Label ID="lblToCity" runat="server" Text='<%# Eval("ToCity") %>'></asp:Label>
                                            <asp:Label ID="lblToCityId" runat="server" Text='<%# Eval("ToCityId") %>' Style="display: none;"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Streckenlänge">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTotalDistanceCovered" runat="server" Text='<%# Eval("TotalDistanceCovered") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Distance" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide" />
                                    <asp:BoundField DataField="Distance_Covered" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide" />
                                    <asp:BoundField DataField="FromCityLat" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide" />
                                    <asp:BoundField DataField="FromCityLong" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide" />
                                    <asp:BoundField DataField="ToCityLat" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide" />
                                    <asp:BoundField DataField="ToCityLong" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide" />
                                </Columns>
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsStagePlan" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SP_GET_STAGEPLAN" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="5" Name="ClassAdminId" SessionField="UserId"
                                        Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlClass" Name="ClassId" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
                <asp:UpdatePanel ID="Up_btnDeleteLastLeg" runat="server">
                    <ContentTemplate>
                        <asp:Button ID="btnDeleteLastLeg" runat="server" meta:ResourceKey="btnDeleteLastLeg" Width="150"
                            OnClick="btnDeleteLastLeg_Click" CssClass="left" />
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="btnDeleteLastLeg" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="clear">
                </div>
                <div class="line"></div> 
                <div class="margin">
                    <table width="100%">
                        <tr>
                            <td valign="top" style="width: 35%">
                                <div class="frmBox">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblRadius" runat="server" meta:ResourceKey="lblRadius"></asp:Label>
                                            </td>
                                            <td style="width: 150px;">

                                                <asp:UpdatePanel ID="up_Radius" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlRadius" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlRadius_SelectedIndexChanged"
                                                            CssClass="left">
                                                             <asp:ListItem Text="Radius wählen" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="0 km to 100 km" Value="0-100"></asp:ListItem>
                                                                <asp:ListItem Text="101 km to 200 km" Value="101-200"></asp:ListItem>
                                                                <asp:ListItem Text="201 km to 300 km" Value="201-300"></asp:ListItem>
                                                                <asp:ListItem Text="301 km to 500 km" Value="301-500"></asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                            <td>
                                                <span class="error left">*</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="rfvRadius" runat="server" meta:ResourceKey="rfvRadius" ErrorMessage=""
                                                    ControlToValidate="ddlRadius" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>

                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblFromCityDdl" runat="server" meta:ResourceKey="lblFromCityDdl"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="Up_FromCity" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlFromCity" runat="server" DataSourceID="sdsFromCity" DataTextField="cityname"
                                                            DataValueField="cityid" AutoPostBack="true" OnSelectedIndexChanged="ddlFromCity_SelectedIndexChanged"
                                                            CssClass="left">
                                                        </asp:DropDownList>
                                                        <%--<span class="error Left">*</span>  --%>
                                                        <asp:SqlDataSource ID="sdsFromCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                                            SelectCommand="select '0' as cityid, ' Stadt' as cityname union all
                                                    select cityid, cityname from citymaster
                                                    where isactive=1 order by cityname asc"></asp:SqlDataSource>

                                                    </ContentTemplate>

                                                </asp:UpdatePanel>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>
                                                <asp:RequiredFieldValidator ID="rfvFromCity" runat="server" meta:ResourceKey="rfvFromCity" ErrorMessage=""
                                                    ControlToValidate="ddlFromCity" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblToCityDdl" runat="server" meta:ResourceKey="lblToCityDdl"></asp:Label>
                                            </td>
                                            <td class="style1">
                                                <asp:UpdatePanel ID="upToCity" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlToCity" runat="server" DataSourceID="" DataTextField="cityname"
                                                            DataValueField="cityid" CssClass="left">
                                                        </asp:DropDownList>

                                                        <asp:SqlDataSource ID="sdsToCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                                            SelectCommand=""></asp:SqlDataSource>

                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:PostBackTrigger ControlID="ddlToCity" />
                                                    </Triggers>
                                                </asp:UpdatePanel>

                                            </td>
                                            <td><span class="error left">*</span>
                                            </td>
                                            <td>
                                                <asp:UpdateProgress ID="UpdateProgressToCity" runat="server" AssociatedUpdatePanelID="up_Radius">
                                                    <ProgressTemplate>
                                                        <asp:Image ID="ImageLoading" runat="server" ImageUrl="~/_images/ajax_loader_blue_32.gif"
                                                            CssClass="loader" />
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td>

                                                <asp:RequiredFieldValidator ID="rfvToCity" runat="server" meta:ResourceKey="rfvToCity" ErrorMessage=""
                                                    ControlToValidate="ddlToCity" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <asp:Button ID="btnAddRoute" Width="150px" runat="server"  meta:ResourceKey="btnAddRoute" OnClick="btnAddRoute_Click"
                                                    ValidationGroup="Submit" />
                                            </td>
                                            
                                        </tr>
                                    </table>
                                </div>
                            </td>
                            <td valign="top">
                                <div style="right: auto; clip: rect(auto, inherit, auto, auto); float: right; width: 620px; border: solid 1px #CCCCCC">
                                    <%--<asp:UpdatePanel ID="upGoogleMap" runat="server">
                            <ContentTemplate>--%>
                                    <uc1:GoogleMapForASPNet ID="GoogleMapForASPNet1" runat="server" />
                                    <%--</ContentTemplate>
                        </asp:UpdatePanel>--%>
                                </div>
                            </td>
                        </tr>
                    </table>
                     

                    <div class="clear">
                    </div>
                </div>
            </asp:Panel>
            <asp:Button ID="btnDelete" runat="server" Text="" meta:ResourceKey="btnDelete" CssClass="hide" OnClick="btnDelete_Click"
                Style="display: none;" />
            <%--</div>--%>
        </div>
    </div>

</asp:Content>
