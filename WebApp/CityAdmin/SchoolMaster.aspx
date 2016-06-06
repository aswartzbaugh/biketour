<%@ Page Title="BikeTour - School Master" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="SchoolMaster.aspx.cs"
    Inherits="AppAdmin_SchoolMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function Confirm(obj) {

            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnSchoolId]").val(obj);
                $("[id$=btnDelete]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:HiddenField ID="hdnSchoolId" runat="server" />
    <asp:HiddenField ID="hdnCityId" runat="server" />
    <div class="container">
        <h5>
            <asp:Label ID="lblSchoolMaster" runat="server" meta:ResourceKey="lblSchoolMaster"></asp:Label>
        </h5>
        <asp:Button ID="btnDelete" runat="server" Text="" OnClick="btnDelete_Click" CssClass="hide" />
        <div class="AdminContWrap">
            <asp:Panel ID="pnlAddNew" runat="server" DefaultButton="btnSave">
                <div class="frmBox">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblSelectCity" runat="server" meta:ResourceKey="lblSelectCity" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <%-- <b><asp:Label ID="lblCityName" runat="server" Text="" Font-Size="Large"  CssClass="Glblbl" ></asp:Label></b>--%>
                                <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCity" DataTextField="Cityname"
                                    DataValueField="CityId">
                                </asp:DropDownList>
                                <span class="error">* </span>
                                <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand=" SELECT '0' as [CityId], ' Stadt' as [CityName]  union all
select cac.CityId, cm.CityName from CityAdminCities cac inner join CityMaster cm
on cac.CityId = cm.CityId
where cac.CityAdminId = @CityAdminId and cac.IsActive = 1 ORDER BY CityName ">
                                    <SelectParameters>
                                        <asp:SessionParameter DefaultValue="" Name="CityAdminId" SessionField="UserId" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" meta:ResourceKey="rfvCity"
                                    Display="Dynamic" ControlToValidate="ddlCity" InitialValue="0" ValidationGroup="Submit"
                                    CssClass="error"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSchoolName" runat="server" meta:ResourceKey="lblSchoolName" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSchoolName" runat="server" CssClass="gltxt"></asp:TextBox><span
                                    class="error"> * </span>
                                <asp:RequiredFieldValidator ID="rfvSchoolName" runat="server" meta:ResourceKey="rfvSchoolName"
                                    ControlToValidate="txtSchoolName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress" CssClass="gltxt"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAddress" runat="server" Text=""></asp:TextBox><span class="error">
                                    * </span>
                                <asp:RequiredFieldValidator ID="rfvAddress" meta:ResourceKey="rfvAddress" runat="server"
                                    ControlToValidate="txtAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Button ID="btnSave" runat="server" meta:ResourceKey="btnSave" ValidationGroup="Submit"
                                    OnClick="btnSave_Click" />
                                <asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" OnClick="btnCancel_Click" />
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:Panel ID="pnlGrid" runat="server" DefaultButton="btn_Search">
                <asp:Button ID="btnAddNew" runat="server" meta:ResourceKey="btnAddNew" OnClick="btnAddNew_Click"
                    CssClass="right R_M" />
                <div class="frmBox">
                    <div class="div_SearchBox">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_City" runat="server" meta:ResourceKey="lbl_City"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddl_City" runat="server" DataSourceID="sds_CityList" DataTextField="Cityname"
                                        DataValueField="CityId">
                                    </asp:DropDownList>
                                    <asp:SqlDataSource ID="sds_CityList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="SELECT '0' as [CityId], ' Stadt' as [CityName]  union all select cac.CityId, 
                                    cm.CityName from CityAdminCities cac inner join CityMaster cm on cac.CityId = cm.CityId
                                    where cac.CityAdminId = @CityAdminId and cac.IsActive = 1 order by CityName">
                                        <SelectParameters>
                                            <asp:SessionParameter DefaultValue="" Name="CityAdminId" SessionField="UserId" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_SchoolName" runat="server" meta:ResourceKey="lbl_SchoolName"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_SearchSchoolName" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btn_Search" runat="server" meta:ResourceKey="btn_Search" OnClick="btn_Search_Click" />
                                    <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="GridWrap">
                    <asp:GridView ID="grdScools" runat="server" Width="100%" AutoGenerateColumns="False"
                        DataKeyNames="schoolid" 
                        AllowSorting="true" HeaderStyle-CssClass="gridHeader"
                        EmptyDataText="No Records found" AllowPaging="True" OnPageIndexChanging="grdScools_PageIndexChanging"
                        OnSelectedIndexChanged="grdScools_SelectedIndexChanged" OnRowCommand="grdScools_RowCommand"
                        OnRowDataBound="grdScools_RowDataBound" OnSorting="grdScools_Sorting">
                        <Columns>
                            <asp:TemplateField HeaderText="City" SortExpression="City">
                            <HeaderTemplate>
                                <asp:LinkButton ID="grdlnkCity" runat="server" meta:ResourceKey="grdlnkCity"
                                    CommandName="Sort" CommandArgument="City">
                                </asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderCity" runat="server"></asp:PlaceHolder>
                           </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCitygrd" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="school" HeaderText="School" SortExpression="school" />--%>
                            <asp:TemplateField HeaderText="school" SortExpression="school">
                                <HeaderTemplate>
                                <asp:LinkButton ID="grdlnkschool" runat="server" meta:ResourceKey="grdlnkschool"
                                    CommandName="Sort" CommandArgument="School">
                                </asp:LinkButton>
                                <asp:PlaceHolder ID="placeholderSchool" runat="server"></asp:PlaceHolder>
                           </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblschoolgrd" runat="server" Text='<%# Eval("school") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("schoolid") %>'
                                        CssClass="grdedit" OnClick="btnEdit_Click" meta:ResourceKey="EditToolTip" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" Visible="true">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdDelete" runat="server" meta:ResourceKey="lblgrdDelete"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <input type="button" id="but1" class="grddel" onclick="Confirm('<%# Eval("schoolid") %>')"
                                        title="Delete" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="SP_GET_SCHOOL" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="SchoolId" Type="Int32" />
                            <asp:SessionParameter DefaultValue="" Name="CityAdminId" SessionField="UserId" Type="Int32" />
                            <asp:ControlParameter ControlID="ddl_City" DefaultValue="0" Name="CityId" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="txt_SearchSchoolName" DefaultValue=" " Name="SchoolName"
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
