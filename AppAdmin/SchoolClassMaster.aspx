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
 <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="container">
        <h5>
        <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label></h5>
        <div class="AdminContWrap">
            <asp:HiddenField ID="hdnClassId" runat="server" />
            <asp:HiddenField ID="hdnSchoolId" runat="server" />
            <asp:Button ID="btnDelete" runat="server" meta:ResourceKey="btnDelete" OnClick="btnDelete_Click" CssClass="hide" />
            <asp:Panel ID="pnlAddNew" runat="server" DefaultButton="btnSave">
                <div class="frmBox">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lblSelectCity" runat="server" meta:ResourceKey="lblSelectCity" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                            
                           
                                <%-- <b><asp:Label ID="lblCityName" runat="server" Text="" Font-Size="Large"  CssClass="Glblbl" ></asp:Label></b>--%>
                                <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCity" DataTextField="Cityname"
                                    DataValueField="CityId" AutoPostBack="True">
                                </asp:DropDownList>
                                <span class="error">* </span>
                                <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="select CityId, Cityname from CityMaster where IsActive=1 ORDER BY CityName">
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="Please select City"
                                    Display="Dynamic" ControlToValidate="ddlCity" InitialValue="0" ValidationGroup="Submit"
                                    CssClass="error" meta:ResourceKey="rfvCity"></asp:RequiredFieldValidator>
                                     </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                             <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                    DataValueField="SchoolId">
                                </asp:DropDownList>
                                <span class="error">*</span>
                                <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="select ' Schule' as school, '0' as schoolid union all  select sm.School, sm.SchoolId from schoolmaster sm  where  sm.IsActive = 1 and sm.CityId=(Case @CityId  when 0 then null else @CityId end) order by School Asc">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="ddlCity" DefaultValue="0" Name="CityId" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:RequiredFieldValidator ID="rfvSchool" runat="server" ErrorMessage="Please select school"
                                    Display="Dynamic" ControlToValidate="ddlSchool" InitialValue="0" ValidationGroup="Submit"
                                    CssClass="error" meta:ResourceKey="rfvSchool"></asp:RequiredFieldValidator>
                                     </ContentTemplate>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtClass" runat="server" MaxLength="10"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvClass" runat="server" ErrorMessage="Please enter class"
                                    ControlToValidate="txtClass" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvClass"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblClassYear" runat="server" meta:ResourceKey="lblClassYear" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtClassYear" runat="server"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfv_ClassYear" runat="server" ErrorMessage="Please enter class year"
                                    ControlToValidate="txtClassYear" meta:ResourceKey="rfv_ClassYear" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
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
                <asp:Button ID="btnAddNew" runat="server" meta:ResourceKey="btnAddNew" CssClass="right R_M"
                    OnClick="btnAddNew_Click" />
                <div class="div_SearchBox">
                    <div class="frmBox">
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
                                        SelectCommand="select CityId, Cityname from CityMaster where IsActive=1 ORDER BY CityName">
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
                        Width="100%" DataSourceID="sdsGrid" AllowSorting="True"
                        HeaderStyle-CssClass="gridHeader" AllowPaging="True" 
                        OnPageIndexChanging="grdClass_PageIndexChanging" 
                        onrowcommand="grdClass_RowCommand" onrowdatabound="grdClass_RowDataBound" 
                        onsorting="grdClass_Sorting">
                        <EmptyDataTemplate>
                        <asp:Label ID="lblEmptyData" runat="server" meta:ResourceKey="lblEmptyData"></asp:Label>
                    </EmptyDataTemplate>
                        <Columns>
                            <%-- <asp:BoundField DataField="School" HeaderText="School" SortExpression="School" />--%>
                            <asp:TemplateField SortExpression="School">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdSchool" runat="server" meta:ResourceKey="lblgrdSchool"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdSchool" runat="server" meta:ResourceKey="lbtngrdSchool" CommandName="sort" CommandArgument="School"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdSchool" runat="server"> </asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSchool" runat="server" Text='<%# Eval("School") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:BoundField DataField="Class" HeaderText="Class" SortExpression="Class" />--%>
                            <asp:TemplateField SortExpression="Class">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdClass" runat="server" meta:ResourceKey="lblgrdClass"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdClass" runat="server" meta:ResourceKey="lbtngrdClass" CommandName="sort" CommandArgument="Class"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdClass" runat="server"> </asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblClass" runat="server" Text='<%# Eval("Class") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:BoundField DataField="CityName" HeaderText="City" SortExpression="CityName" />--%>
                            <asp:TemplateField SortExpression="CityName">
                                <HeaderTemplate>
                                    <%--<asp:Label ID="lblgrdCity" runat="server" meta:ResourceKey="lblgrdCity"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdCity" runat="server" meta:ResourceKey="lbtngrdCity" CommandName="sort" CommandArgument="CityName"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdCity" runat="server"> </asp:PlaceHolder>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--   <asp:BoundField DataField="ClassYear" HeaderText="Year"/>--%>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdYear" runat="server" meta:ResourceKey="lblgrdYear"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblYear" runat="server" Text='<%# Eval("ClassYear") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("ClassId") + "|" + Eval("SchoolId") %>'
                                        CssClass="grdedit" OnClick="btnEdit_Click" meta:ResourceKey="btnEdit"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%-- <asp:TemplateField HeaderText="Delete">
                            <ItemTemplate>
                                <input type="button" id="but1" class="grddel" onclick="Confirm('<%# Eval("ClassId") %>')"
                                    title="Delete" />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="select SM.School,SM.SchoolId, CM.CityName,
                   SCM.Class,SCM.ClassYear, SCM.ClassId from SchoolClassMaster SCM 
                   inner join SchoolMaster SM on SCM.SchoolId = SM.SchoolId
                   left join CityMaster CM on SM.CityId=CM.CityId 
                   where sCm.IsActive = 1 and SM.CityId=(case @CityId when 0 then SM.CityId else @CityId end) and 
                   SM.School like (CASE @School WHEN ' ' THEN SM.School ELSE @School END)+'%' order by School Asc ">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="txtschool" DefaultValue=" " Name="School" PropertyName="Text" />
                            <asp:ControlParameter ControlID="ddl_SearchCity" DefaultValue="0" Name="CityId" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
