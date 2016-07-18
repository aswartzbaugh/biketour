<%@ page title="BikeTour - School Master" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="AppAdmin_SchoolMaster, App_Web_x1fc3qah" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        function Confirm(obj) {

            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnSchoolId]").val(obj);
                $("[id$=btnDeleteSchool]").trigger("click");
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

    <asp:HiddenField ID="hdnSchoolId" runat="server" />
    <asp:HiddenField ID="hdnCityId" runat="server" />

    <div class="container">
    <h5>
    <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
    </asp:Label></h5>

    <asp:Button ID="btnDelete" runat="server" meta:ResourceKey="btnDelete" OnClick="btnDelete_Click" CssClass="hide" />
    <div class="AdminContWrap">
    
        <asp:Panel ID="pnlAddNew" runat="server" DefaultButton="btnSave">
        <div class="frmBox">
            <div>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblSelectCity" runat="server" meta:ResourceKey="lblSelectCity" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <%-- <b><asp:Label ID="lblCityName" runat="server" Text="" Font-Size="Large"  CssClass="Glblbl" ></asp:Label></b>--%>
                            <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCity" DataTextField="Cityname"
                                DataValueField="CityId">
                            </asp:DropDownList><span class="error"> * </span>
                            <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="select '0' as CityId, 'Stadt' as CityName union all  select CityId, CityName from CityMaster where IsActive = 1 and IsParticipatingCity=1 order by CityName ">
                            </asp:SqlDataSource>
                            <asp:RequiredFieldValidator ID="rfvCity" runat="server" ErrorMessage="Please select City"
                                Display="Dynamic" ControlToValidate="ddlCity" InitialValue="0" ValidationGroup="Submit"
                                CssClass="error" meta:ResourceKey="rfvCity"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSchoolName" runat="server" meta:ResourceKey="lblSchoolName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtSchoolName" runat="server" CssClass="gltxt"></asp:TextBox><span class="error"> * </span>
                            <asp:RequiredFieldValidator ID="rfvSchoolName" runat="server" ErrorMessage="Please enter School Name"
                                ControlToValidate="txtSchoolName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"
                                meta:ResourceKey="rfvSchoolName"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress" CssClass="gltxt"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress" runat="server"></asp:TextBox><span class="error"> * </span>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Please enter School Address"
                                ControlToValidate="txtAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvAddress"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                         <asp:UpdatePanel ID="Up_btns" runat="server">
                                <ContentTemplate> 
                            <asp:Button ID="btnSave" runat="server" meta:ResourceKey="btnSave" ValidationGroup="Submit" OnClick="btnSave_Click" />
                            <asp:Button ID="btnCancel" runat="server" meta:ResourceKey="btnCancel" OnClick="btnCancel_Click" />
                           </ContentTemplate>
                           <Triggers >
                             <asp:PostBackTrigger ControlID="btnSave" />
                              <asp:PostBackTrigger ControlID="btnCancel" />
                           </Triggers>
                           </asp:UpdatePanel>
                        </td>
                    </tr>
                </table>
            </div>

            </div>
        </asp:Panel>
        <asp:Panel ID="pnlGrid" runat="server">

        <div class="frmBox">
            <asp:Button ID="btnAddNew" runat="server" meta:ResourceKey="btnAddNew" OnClick="btnAddNew_Click" CssClass="right" />
           
            <div class="div_SearchBox">
                <table>
                    <tr>
                        <td><asp:Label ID="lbl_City" runat="server" meta:ResourceKey="lbl_City"></asp:Label></td>
                        <td>
                            <asp:DropDownList ID="ddl_City" runat="server" DataSourceID="sds_CityList" DataTextField="Cityname"
                                DataValueField="CityId">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sds_CityList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                
                                
                                SelectCommand="select '0' as CityId, ' Stadt' as CityName union all  select CityId, CityName from CityMaster where IsActive = 1 and IsParticipatingCity=1  order by CityName ">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lbl_SchoolName" runat="server" meta:ResourceKey="lbl_SchoolName"></asp:Label></td>
                        <td><asp:TextBox ID="txt_SearchSchoolName" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="2">


                            <asp:Button ID="btn_Search" runat="server" meta:ResourceKey="btn_Search"
                                onclick="btn_Search_Click" />
                            <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel"
                                onclick="btn_Cancel_Click" />
                               
                        </td>
                    </tr>
                </table>
            </div>

            </div>
            <div class="GridWrap">

                <asp:GridView ID="grdScools" runat="server"  Width="100%" 
                    AutoGenerateColumns="False" DataKeyNames="schoolid"
                    HeaderStyle-CssClass="gridHeader"
                    AllowPaging="True" onpageindexchanging="grdScools_PageIndexChanging" 
                    onselectedindexchanged="grdScools_SelectedIndexChanged" 
                    onrowcommand="grdScools_RowCommand" onrowdatabound="grdScools_RowDataBound" 
                    onsorting="grdScools_Sorting" >
                    <EmptyDataTemplate>
                        <asp:Label ID="lblEmptyData" runat="server" meta:ResourceKey="lblEmptyData"></asp:Label>
                    </EmptyDataTemplate>
                    <Columns>
                        <%--<asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />--%>

                        <asp:TemplateField SortExpression="City">
                            <HeaderTemplate>
                                <%--<asp:Label ID="lblHeaderCity" runat="server" meta:ResourceKey="lblHeaderCity"></asp:Label>--%>
                                <asp:LinkButton ID="lbtngrdHeaderCity" runat="server" meta:ResourceKey="lbtngrdHeaderCity" CommandName="sort" CommandArgument="City"></asp:LinkButton>
                                <asp:PlaceHolder id="phtgrdHeaderCity" runat="server"> </asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblgrdCity" runat="server" Text='<%# Eval("City") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                      <%--  <asp:BoundField DataField="school" HeaderText="School" SortExpression="school" />--%>
                         <asp:TemplateField SortExpression="School">
                            <HeaderTemplate>
                                <%--<asp:Label ID="lblgrdSchool" runat="server" meta:ResourceKey="lblgrdSchool"></asp:Label>--%>
                                <asp:LinkButton ID="lbtngrdSchool" runat="server" meta:ResourceKey="lbtngrdSchool" CommandName="sort" CommandArgument="school"></asp:LinkButton>
                                <asp:PlaceHolder id="phtgrdSchool" runat="server"> </asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSchool" runat="server" Text='<%# Eval("school") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                        <HeaderTemplate>
                                <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("schoolid") %>'
                                    CssClass="grdedit" OnClick="btnEdit_Click" meta:ResourceKey="btnEdit"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                         <HeaderTemplate>
                                <asp:Label ID="lblDeleteSchool" runat="server" meta:ResourceKey="lbldeleteSchool"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                  <input type="button" id="but1" class="grddel" onclick="Confirm('<%# Eval("schoolid") %>    ')"
                                        title="Delete" />
                                 
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
              <asp:Button ID="btnDeleteSchool" runat="server" CommandArgument='<%# Eval("schoolid") %>'
                          CssClass="hide"  OnClick="btnDeleteSchool_Click"/>
                
                <asp:SqlDataSource ID="sdsGrid" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                    SelectCommand="SP_GET_SCHOOL" SelectCommandType="StoredProcedure">
                    <SelectParameters>

                        <asp:Parameter DefaultValue="0" Name="SchoolId" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="CityAdminId" Type="Int32" />
                        <asp:ControlParameter ControlID="ddl_City" DefaultValue="0" Name="CityId" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:ControlParameter ControlID="txt_SearchSchoolName" DefaultValue="" 
                            Name="SchoolName" PropertyName="Text" Type="String" />

                    </SelectParameters>
                </asp:SqlDataSource>

            </div>
        </asp:Panel> 
        </div>
    </div>
     </div>

   
</asp:Content>
