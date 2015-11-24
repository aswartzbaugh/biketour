<%@ Page Title="Bike Tour - Class Master" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="SchoolClassMaster.aspx.cs"
    Inherits="AppAdmin_SchoolClassMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function Confirm(obj) {

            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnClassId]").val(obj);
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
    <div class="container">
        <h5>
            <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label>
        </h5>
        <div class="AdminContWrap">
            <div class="">
                <asp:HiddenField ID="hdnClassId" runat="server" />
                <asp:HiddenField ID="hdnSchoolId" runat="server" />
                <asp:Button ID="btnDelete" runat="server" Text="" OnClick="btnDelete_Click" CssClass="hide" />
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
                                        DataValueField="CityId" AutoPostBack="True">
                                    </asp:DropDownList>
                                    <span class="error">* </span>
                                    <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="select cac.CityId, cm.CityName from CityAdminCities cac inner join CityMaster cm
                                          on cac.CityId = cm.CityId
                                            where cac.CityAdminId = @CityAdminId and cac.IsActive = 1 ORDER BY CityName ASC">
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
                                    <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool" CssClass="Glblbl"></asp:Label>
                                </td>
                                <td>
                                    <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                        DataValueField="SchoolId">
                                    </asp:DropDownList>
                                    <span class="error">*</span>
                                    <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand="select ' Schule' as school, '0' as schoolid union all
                              select sm.School, sm.SchoolId from schoolmaster sm  where  sm.IsActive = 1 and sm.CityId=(Case @CityId  when 0 then null else @CityId end)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlCity" DefaultValue="0" Name="CityId" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool"
                                        Display="Dynamic" ControlToValidate="ddlSchool" InitialValue="0" ValidationGroup="Submit"
                                        CssClass="error"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass" CssClass="Glblbl"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtClass" runat="server" MaxLength="10"></asp:TextBox><span class="error">*</span>
                                    <asp:RequiredFieldValidator ID="rfvClass" runat="server" meta:ResourceKey="rfvClass"
                                        ControlToValidate="txtClass" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblClassYear" runat="server" meta:ResourceKey="lblClassYear" CssClass="Glblbl"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtClassYear" runat="server"></asp:TextBox><span class="error">*</span>
                                    <asp:RequiredFieldValidator ID="rfv_ClassYear" runat="server" meta:ResourceKey="rfv_ClassYear"
                                        ControlToValidate="txtClassYear" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btnSave" runat="server" ValidationGroup="Submit"
                                        OnClick="btnSave_Click" />
                                    <asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" OnClick="btnCancel_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlGrid" runat="server" DefaultButton="btn_Search">
                    <div class="frmBox">
                        <asp:Button ID="btnAddNew" runat="server" meta:ResourceKey="btnAddNew" CssClass="right"
                            OnClick="btnAddNew_Click" />
                        <div class="div_SearchBox">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_School" runat="server" meta:ResourceKey="lbl_School"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtschool" runat="server"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lbl_City" runat="server" meta:ResourceKey="lblSelectCity"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddl_SearchCity" runat="server" DataSourceID="sdsSearchCity"
                                            DataTextField="Cityname" DataValueField="CityId">
                                        </asp:DropDownList>
                                        <asp:SqlDataSource ID="sdsSearchCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                            SelectCommand="select cac.CityId, cm.CityName from CityAdminCities cac 
                                            inner join CityMaster cm on cac.CityId = cm.CityId
                                            where cac.CityAdminId = @CityAdminId and cac.IsActive = 1 
                                            ORDER BY CityName ASC">
                                            <SelectParameters>
                                                <asp:SessionParameter DefaultValue="" Name="CityAdminId" SessionField="UserId" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
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
                        <asp:GridView ID="grdClass" runat="server" AutoGenerateColumns="False" DataKeyNames="ClassId"
                            Width="100%"  EmptyDataText="No Records!" AllowSorting="true"
                            HeaderStyle-CssClass="gridHeader" AllowPaging="True" 
                            OnPageIndexChanging="grdClass_PageIndexChanging" 
                            onrowcommand="grdClass_RowCommand" onrowdatabound="grdClass_RowDataBound" 
                            onsorting="grdClass_Sorting">
                            <Columns>
                                <asp:TemplateField HeaderText="School">
                                    <HeaderTemplate>
                                        <asp:LinkButton ID="grdlnkSchool" runat="server" meta:ResourceKey="grdlnkSchool"
                                            CommandName="Sort" CommandArgument="School"></asp:LinkButton>
                                        <asp:PlaceHolder ID="placeholderSchool" runat="server"></asp:PlaceHolder>                                        
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblSchoolgrd" runat="server" Text='<%# Eval("School") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="Class">
                                     <HeaderTemplate>
                                        <asp:LinkButton ID="grdlnkClass" runat="server" meta:ResourceKey="grdlnkClass"
                                            CommandName="Sort" CommandArgument="Class"></asp:LinkButton>
                                        <asp:PlaceHolder ID="placeholderCity" runat="server"></asp:PlaceHolder>                                        
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblClassgrd" runat="server" Text='<%# Eval("Class") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                
                                <asp:TemplateField HeaderText="CityName">
                                   <HeaderTemplate>
                                        <asp:LinkButton ID="grdlnkCityName" runat="server" meta:ResourceKey="grdlnkCityName"
                                            CommandName="Sort" CommandArgument="CityName"></asp:LinkButton>
                                        <asp:PlaceHolder ID="placeholderCityName" runat="server"></asp:PlaceHolder>                                        
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblCityNamegrd" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <%--<asp:BoundField DataField="ClassYear" HeaderText="Year" />--%>
                                <asp:TemplateField HeaderText="ClassYear">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblgrdClassYear" runat="server" meta:ResourceKey="lblgrdClassYear"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblClassYeargrd" runat="server" Text='<%# Eval("ClassYear") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Edit">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("ClassId") + "|" + Eval("SchoolId") %>'
                                            CssClass="grdedit" OnClick="btnEdit_Click" meta:ResourceKey="EditToolTip" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Delete">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblgrdDelete" runat="server" meta:ResourceKey="lblgrdDelete"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <input type="button" id="but1" class="grddel" onclick='<%# Eval("ClassId", "Confirm({0}); return false;") %>'
                                            title="löschen" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="select SM.School,SM.SchoolId, CM.CityName,
                               SCM.Class,SCM.ClassYear, SCM.ClassId from SchoolClassMaster SCM 
                               inner join SchoolMaster SM on SCM.SchoolId = SM.SchoolId
                               left join CityMaster CM on SM.CityId=CM.CityId 
                               where sCm.IsActive = 1
                               and SM.CityId IN(select CityId from CityAdminCities where IsActive=1 and CityAdminId=@CityAdminId) and
                               SM.CityId=(case @CityId when 0 then SM.CityId else @CityId end) and
                               SM.School like (CASE @School WHEN ' ' THEN SM.School ELSE @School END)+'%' order by School Asc ">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="txtschool" DefaultValue=" " Name="School" PropertyName="Text" />
                                <asp:SessionParameter DefaultValue="" Name="CityAdminId" SessionField="UserId" />
                                <asp:ControlParameter ControlID="ddl_SearchCity" DefaultValue="0" Name="CityId" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </div>
</asp:Content>
