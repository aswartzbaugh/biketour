<%@ page title="Bike Tour - Stage Plan" language="C#" culture="de-DE" uiculture="de-DE" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" enableeventvalidation="false" inherits="ClassAdmin_StagePlan, App_Web_tvrek5y1" %>

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
        .style1
        {
            width: 192px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager><div class="frmBox_2">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                    </td>
                    <td>
                        <asp:UpdatePanel ID="Up_School" runat="server">
                            <ContentTemplate>
                                  <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                            DataValueField="SchoolId" AutoPostBack="true" >
                        </asp:DropDownList>
                        <span class="error right">*</span>
                        <asp:RequiredFieldValidator ID="rfvSchool" runat="server" ErrorMessage="Please select school."
                            InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                            CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand=" select sm.SchoolId, sm.School from schoolmaster sm
                                           where sm.IsActive=1
                                           and sm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId )  order by School Asc
                                               ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CityAdminId" SessionField="UserId" />
                                </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        
                    </td>
                    <td>
                        <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass"></asp:Label>
                    </td>
                    <td>
                        <asp:UpdatePanel ID="upClass" runat="server">
                            <ContentTemplate>
                                 <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="True" 
                            DataSourceID="sdsClass" DataTextField="Class" 
                            DataValueField="ClassId" onselectedindexchanged="ddlClass_SelectedIndexChanged" >
                        </asp:DropDownList>
                        <span class="error right">*</span>
                        
                        <asp:SqlDataSource ID="sdsClass" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" 
                            SelectCommand="SP_GET_DISTINCT_CLASSES" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="ClassAdminId" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlSchool" DefaultValue="0" Name="SchoolId" 
                                    PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        
                        <asp:RequiredFieldValidator ID="rfvClass" runat="server" ErrorMessage="Please select class."
                            InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                            </ContentTemplate>
                         <Triggers>
                         <asp:PostBackTrigger ControlID="ddlClass" />
                         </Triggers>
                        </asp:UpdatePanel>
                         <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="upClass" runat="server">
                        <ProgressTemplate>
                            <img src="../_images/ajax_loader_blue_32.gif" />
                        </ProgressTemplate>
                        </asp:UpdateProgress>
                    </td>
                    <td style="width: 40px;"><asp:UpdateProgress ID="UProg" AssociatedUpdatePanelID="Up_School" runat="server">
                        <ProgressTemplate>
                            <img src="../_images/ajax_loader_blue_32.gif" />
                        </ProgressTemplate>
                        </asp:UpdateProgress></td>
                    <td style="width: 330px;">
                        <asp:Button ID="btnOk" runat="server" meta:ResourceKey="btnOk" OnClick="btnOk_Click" Visible="false" />
                        <asp:Button ID="btnBack" runat="server" meta:ResourceKey="btnBack" OnClick="btnBack_Click" Visible="false" CssClass="right" />
                    </td>
                </tr>
            </table>
</div>
    <div class="container">
         
    <h5>
        <asp:Label ID="lblStagePlanHead" runat="server" meta:ResourceKey="lblStagePlan"></asp:Label>
        </h5>
    <div class="AdminContWrap">
        <div class="clear">
        </div>
        <div class="">
         <asp:UpdatePanel ID="Up_hidden" runat="server">
           <ContentTemplate>
            <asp:HiddenField ID="hdnClassId" runat="server" />
            <asp:HiddenField ID="hdnStagePlanId" runat="server" Value="0" />
            </ContentTemplate>
            </asp:UpdatePanel> 
           
            <asp:Panel ID="pnlContent" runat="server" Visible="false">
                <div align="center">
                    <h2>
                        <b><asp:Label ID="lblClassHeader" runat="server" Text=""></asp:Label></b>
                    </h2>
                </div>
                <div class="GridWrap" align="left">
                    <asp:UpdatePanel ID="Up_grdStagePlan" runat="server">
                        <ContentTemplate>
                              <asp:GridView ID="grdStagePlan" runat="server" AutoGenerateColumns="False" DataSourceID="sdsStagePlan"
                                Width="100%" ShowFooter="True" DataKeyNames="StagePlanId,Status" EmptyDataText="Keine Daten vorhanden" CssClass="gv"
                                AllowSorting="True" HeaderStyle-CssClass="gridHeader" 
                                onrowdatabound="grdStagePlan_RowDataBound">
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
                                    <asp:BoundField DataField="Distance"  ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide"  />
                                    <asp:BoundField DataField="Distance_Covered" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide"  />
                                   <asp:BoundField DataField="FromCityLat"  ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide"  />
                                     <asp:BoundField DataField="FromCityLong"  ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide"  />
                                     <asp:BoundField DataField="ToCityLat"  ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide"  />
                                     <asp:BoundField DataField="ToCityLong"  ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide" FooterStyle-CssClass="hide"  />
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
                           <%-- OnClientClick="javascript:return confirm('Willst du diese Etappe wirklich löschen?');"--%>
                    </ContentTemplate>
                  
                </asp:UpdatePanel>
                <div class="clear">
                </div>
                <div class="">
                    <table width="100%">
                        <tr>
                            <td valign="top" style="width: 35%">
                                <div class="">
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

                                                    <asp:RequiredFieldValidator ID="rfvRadius" runat="server" ErrorMessage="Radius wählen"
                                                        ControlToValidate="ddlRadius" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                                                </td>
                                                <td><span class="error Right">*</span></td>

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

                                                            <asp:SqlDataSource ID="sdsFromCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                                                SelectCommand="select '0' as cityid, ' Stadt' as cityname union all select cityid, cityname from citymaster
                                                                    where isactive=1 order by cityname asc"></asp:SqlDataSource>
                                                            <asp:RequiredFieldValidator ID="rfvFromCity" runat="server" ErrorMessage="Wähle einen Startort"
                                                                ControlToValidate="ddlFromCity" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                                                        </ContentTemplate>

                                                    </asp:UpdatePanel>
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
                                                            <asp:RequiredFieldValidator ID="rfvToCity" runat="server" ErrorMessage="Wähle einen Zielort"
                                                                ControlToValidate="ddlToCity" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                                                        </ContentTemplate>

                                                    </asp:UpdatePanel>
                                                </td>
                                                <td><span class="error">*</span></td>
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
                                                <td colspan="2">
                                                    <asp:UpdatePanel ID="Up_btnAddRoute" runat="server">
                                                        <ContentTemplate>
                                                            <asp:Button ID="btnAddRoute" Width="150px" runat="server" meta:ResourceKey="btnAddRoute" OnClick="btnAddRoute_Click"
                                                                ValidationGroup="Submit" />
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btnAddRoute" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </td>
                                               
                                            </tr>
                                        </table>
                                    </div>
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
                                <div class="clear">
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
              <asp:UpdatePanel ID="Up_btnDelete" runat="server">
               <ContentTemplate>
                  <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="hide" OnClick="btnDelete_Click"
                  Style="display: none;" />
                </ContentTemplate>
                </asp:UpdatePanel>
        </div>
    </div>
        </div>
</asp:Content>
