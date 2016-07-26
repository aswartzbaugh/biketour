<%@ page title="Bike Tour - Stage Plan" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="ClassAdmin_StagePlan, App_Web_4pgugvei" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet"
    TagPrefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () { $("[id$=btnDelete]").hide(); });
        function Confirm(obj) {
            var Ok = confirm('Confirm Delete ?');
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
    </asp:ToolkitScriptManager>
    <h5><asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label>
        </h5>
    <div class="AdminContWrap">
        <div class="clear">
        </div>
        <div class="frmBox">
            <asp:HiddenField ID="hdnClassId" runat="server" />
            <asp:HiddenField ID="hdnStagePlanId" runat="server" />
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                            DataValueField="SchoolId" AutoPostBack="true" 
                            onselectedindexchanged="ddlSchool_SelectedIndexChanged">
                        </asp:DropDownList>
                        <span class="error">*</span>
                        <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool" ErrorMessage=""
                            InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                            CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="SELECT '0' as [SchoolId], 'Select School' as [School] union all 
select distinct sm.SchoolId, sm.School from ClassAdminClasses cac inner join SchoolMaster sm
on cac.SchoolId = sm.SchoolId
where ClassAdminId = @ClassAdminId
">
                            <SelectParameters>
                                <asp:SessionParameter Name="ClassAdminId" SessionField="UserId" DefaultValue="5" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td>
                        <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass"></asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="sds_Class" DataTextField="ClassName"
                            DataValueField="classid" AutoPostBack="True" 
                            onselectedindexchanged="ddlClass_SelectedIndexChanged">
                        </asp:DropDownList>
                        <span class="error">*</span>
                        <asp:RequiredFieldValidator ID="rfvClass" meta:ResourceKey="rfvClass" runat="server" ErrorMessage=""
                            InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="sds_Class" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="select 'Select class' as ClassName, '0' as classid union all 
select distinct scm.class as ClassName, scm.classid from  ClassAdminClasses cac inner join SchoolClassMaster scm
on cac.ClassId = scm.ClassId
where  ClassAdminId = @ClassAdminId
and cac.SchoolId = @SchoolId">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="5" Name="ClassAdminId" SessionField="UserId" />
                                <asp:ControlParameter ControlID="ddlSchool" Name="schoolid" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                    <td>
                        <asp:Button ID="btnOk" runat="server" meta:ResourceKey="btnOk" OnClick="btnOk_Click" Visible="false" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:Panel ID="pnlContent" runat="server"  Visible="false">
            <div align="center">
                <h2>
                    <asp:Label ID="lblClassHeader" runat="server" Text=""></asp:Label>
                </h2>
            </div>
            <div class="GridWrap" aling="left" >
                <asp:GridView ID="grdStagePlan" runat="server" AutoGenerateColumns="False" DataSourceID="sdsStagePlan"  Width="100%" 
                    DataKeyNames="StagePlanId,Status" EmptyDataText="No records found">
                    <Columns>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdStartCity" runat="server" meta:ResourceKey="lblgrdStartCity"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblFromCity" runat="server" Text='<%# Eval("FromCity") %>'></asp:Label>
                                <asp:Label ID="lblFromCityId" runat="server" Text='<%# Eval("FromCityId") %>' Style="display: none;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                             <HeaderTemplate>
                                <asp:Label ID="lblgrdEndCity" runat="server" meta:ResourceKey="lblgrdEndCity"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblToCity" runat="server" Text='<%# Eval("ToCity") %>'></asp:Label>
                                <asp:Label ID="lblToCityId" runat="server" Text='<%# Eval("ToCityId") %>' Style="display: none;"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdStatus" runat="server" meta:ResourceKey="lblgrdStatus"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
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
                <asp:Button ID="btnDeleteLastLeg" runat="server" meta:ResourceKey="btnDeleteLastLeg" Width="150"
                    OnClick="btnDeleteLastLeg_Click" />
            </div>

            <div style="right: auto; clip: rect(auto, inherit, auto, auto)"> 
             <uc1:GoogleMapForASPNet ID="GoogleMapForASPNet1" runat="server" />
            </div>



            <div>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblRadius" runat="server" meta:ResourceKey="lblRadius"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlRadius" runat="server" AutoPostBack="True" 
                                onselectedindexchanged="ddlRadius_SelectedIndexChanged">
                                <asp:ListItem Text="Select radius" Value="0"></asp:ListItem>
                                <asp:ListItem Text="100-200" Value="100-200"></asp:ListItem>
                                <asp:ListItem Text="200-300" Value="200-300"></asp:ListItem>
                                <asp:ListItem Text="300-500" Value="300-500"></asp:ListItem>
                            </asp:DropDownList>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvRadius" runat="server" meta:ResourceKey="rfvRadius" ErrorMessage=""
                                ControlToValidate="ddlRadius" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="lblFromCityDdl" runat="server" meta:ResourceKey="lblFromCityDdl"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlFromCity" runat="server" DataSourceID="sdsFromCity" DataTextField="cityname"
                                DataValueField="cityid" AutoPostBack="true" 
                                onselectedindexchanged="ddlFromCity_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsFromCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="select '0' as cityid, 'Select city' as cityname union all
select cityid, cityname from citymaster
where isactive=1 order by cityname asc"></asp:SqlDataSource>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvFromCity" runat="server" meta:ResourceKey="rfvFromCity" ErrorMessage=""
                                ControlToValidate="ddlFromCity" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Label ID="lblToCityDdl" runat="server" meta:ResourceKey="lblToCityDdl"></asp:Label>
                        </td>
                        <td class="style1">
                            <asp:DropDownList ID="ddlToCity" runat="server" DataSourceID="" DataTextField="cityname"
                                DataValueField="cityid">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsToCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="">
                            </asp:SqlDataSource>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvToCity" runat="server" meta:ResourceKey="rfvToCity" ErrorMessage="Please select To city"
                                ControlToValidate="ddlToCity" InitialValue="0" ValidationGroup="Submit" CssClass="error"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:Button ID="btnAddRoute" runat="server" Text="" meta:ResourceKey="btnAddRoute" OnClick="btnAddRoute_Click" ValidationGroup="Submit" />
                        </td>
                        <td>
                            <asp:Button ID="btnBack" runat="server" Text="" meta:ResourceKey="btnBack" OnClick="btnBack_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="hide" OnClick="btnDelete_Click"
            Style="display: none;" />
    </div>
</asp:Content>
