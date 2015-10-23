<%@ Page Title="Bike Tour - Class Admin" Culture="de-DE" UICulture="de-DE" Language="C#" MasterPageFile="~/SiteMaster/AdminMaster.master"
    AutoEventWireup="true" CodeFile="ClassAdmin.aspx.cs" Inherits="ClassAdmin_ClassAdmin" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $("[id$=btnDelete]").hide();
            $("#ContentPlaceHolder1_ddl_Class_sl #caption").text(' wählen');
            $("#ContentPlaceHolder1_ddl_Class_sl #ContentPlaceHolder1_ddl_Class_dv #checks span:first-child label").text(' Wählen Sie alle');
            
         });
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

        function ConfirmDeleteClasses() {
            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                return true;
            } else {
                return false;
            }
        }

        function ConfirmDeleteClass(obj) {
            //            var Ok = confirm('Confirm Delete ?');
            //            if (Ok) {
            //                $("[id$=hdnSchoolId]").val(obj);
            //                $("[id$=btnClassDelete]").trigger("click");
            //                return true;
            //            }
            //            else {
            //                return false;
            //            }

            $("[id$=hdnSchoolId]").val(obj);
            $("[id$=btnClassDelete]").trigger("click");
            return true;
        }
    </script>

    <style type="text/css">
        /*###################################   Custom Dropdown Style  #####################################*/
        #ContentPlaceHolder1_ddl_Class_sl {
            width: 188px!important;
            padding: 2px;
            height: 22px;
        }

            #ContentPlaceHolder1_ddl_Class_sl #caption {
                padding: 2px;
                line-height: 16px;
                height: 20px;
            }

            #ContentPlaceHolder1_ddl_Class_sl div.dd_chk_drop {
                top: 24px!important;
            }

        .dd_chk_drop br {
            display: block;
            height: 2px!important;
            padding: 0!important;
            margin: 0!important;
        }
        
        div.dd_chk_select {
            background-image: url('../_images/dropdown_btn2.png')!important;
        }
        
       div.dd_chk_select:active {
                background-image: url('../_images/dropdown_btn.png')!important;
        }
        
        /*###################################   Custom Dropdown Style  #####################################*/
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

     <div class="container">

    <h5 id="h1_Transfer" runat="server">
    <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead">
    </asp:Label></h5>
    <div class="AdminContWrap">
      
         <asp:HiddenField ID="hdnSchoolId" runat="server" />
         <asp:HiddenField ID="hdn_ClassAdminId" runat="server" Value="0" />
         
        <asp:Panel ID="pnl_AddAdmin" runat="server" Visible="false" DefaultButton="btn_Save">
           <div class="frmBox">
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_FirstName" runat="server"  ></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server"
                                ControlToValidate="txt_FirstName" ValidationGroup="Save" CssClass="error" 
                                Display="Dynamic" Height="16px" meta:ResourceKey="rfvFirstName"></asp:RequiredFieldValidator>
                              <%--<asp:RegularExpressionValidator runat="server" id="rfv2FirstName" ControlToValidate="txt_FirstName"
                           ValidationExpression="^[a-zA-Z]*$" 
                                CssClass="error"  Display="Dynamic" ValidationGroup="Save" meta:ResourceKey="rfv2FirstName"/>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_LastName" runat="server" CssClass="gltxt" ></asp:TextBox><span
                                class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server"
                                ControlToValidate="txt_LastName" ValidationGroup="Save" CssClass="error" 
                                Display="Dynamic" meta:ResourceKey="rfvLastName"></asp:RequiredFieldValidator>
<%--                                <asp:RegularExpressionValidator runat="server" id="rfv2LastName" ControlToValidate="txt_LastName"
                           ValidationExpression="^[a-zA-Z]*$"
                                CssClass="error"  Display="Dynamic" ValidationGroup="Save" meta:ResourceKey="rfv2LastName"/>--%>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblAddress" runat="server" meta:ResourceKey="lblAddress" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="gltxt"></asp:TextBox><span
                                class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" 
                                ControlToValidate="txtAddress" ValidationGroup="Save" CssClass="error" 
                                Display="Dynamic" meta:ResourceKey="rfvAddress"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="gltxt"></asp:TextBox><span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                ControlToValidate="txtEmail" ValidationGroup="Save" CssClass="error" 
                                Display="Dynamic" meta:ResourceKey="rfvEmail"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                 CssClass="error" Display="Dynamic"
                                ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$" 
                                ValidationGroup="Save" meta:ResourceKey="rev_Email"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="UP_ddlSchool" runat="server">
                           <ContentTemplate>
                            <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                DataValueField="SchoolId" AutoPostBack="true">
                            </asp:DropDownList>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvSchool" runat="server" 
                                InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                                CssClass="error" Display="Dynamic" meta:ResourceKey="rfvSchool"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], ' Schule' as [School] union all select sm.SchoolId, sm.School from schoolmaster sm
                                 where sm.IsActive=1 order by School  ">
                            </asp:SqlDataSource>
                             </ContentTemplate> 
                             <Triggers>
                             <asp:PostBackTrigger ControlID="ddlSchool" />
                             </Triggers>
                             </asp:UpdatePanel>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:UpdatePanel ID="Up_ddl_Class" runat="server">
                                <ContentTemplate>
                                    <cc1:DropDownCheckBoxes ID="ddl_Class" runat="server" AddJQueryReference="True" CssClass=""
                                        DataSourceID="sds_Class" DataTextField="Class" UseSelectAllNode="true" DataValueField="ClassId"
                                        RepeatDirection="Vertical" UseButtons="False">
                                    </cc1:DropDownCheckBoxes>
                                    <span class="error">*</span>
                                    <cc1:ExtendedRequiredFieldValidator ID="rfv_ddlClass" runat="server" ValidationGroup="SubmitClass"
                                        ControlToValidate="ddl_Class" ForeColor="Red" CssClass="error" 
                                         meta:ResourceKey="rfv_ddlClass">
                                         </cc1:ExtendedRequiredFieldValidator>
                                    <asp:SqlDataSource ID="sds_Class" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                        SelectCommand=" select classid, Class from SchoolClassMaster where SchoolId=@SchoolId and
                                 classid NOT IN(select distinct classid from ClassAdminClasses where IsActive = 1)
                                 and IsActive=1 ">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlSchool" DefaultValue="" Name="schoolid" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                           <%-- <asp:UpdatePanel ID="Up_btnAddClass" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnAddClass" runat="server" meta:ResourceKey="btnAddClass" OnClick="btnAddClass_Click"
                                        ValidationGroup="SubmitClass" />
                                </ContentTemplate>
                            </asp:UpdatePanel>--%>
                        </td>
                    </tr>
                    <tr>
                    <td></td>
                    <td>
                     <asp:UpdatePanel ID="Up_btnAddClass" runat="server">
                                <ContentTemplate>
                                    <asp:Button ID="btnAddClass" runat="server" meta:ResourceKey="btnAddClass" OnClick="btnAddClass_Click"
                                        ValidationGroup="SubmitClass" />
                                </ContentTemplate>
                            </asp:UpdatePanel>
                    </td>
                    </tr>
                   
                    <tr>
                        <td colspan="2" align="left">
                            <div class="GridWrap">
                                <asp:UpdatePanel ID="Up_grdClasses" runat="server">
                                   <ContentTemplate> 
                                   <asp:GridView ID="grdClasses" runat="server" 
                                    AutoGenerateColumns="False" Width="100%" DataKeyNames="SchoolId,ClassIds" 
                                    AllowSorting="true" AllowPaging="True" 
                                    onpageindexchanging="grdClasses_PageIndexChanging" >
                                    <Columns>
                                        <asp:TemplateField>
                                         <HeaderTemplate>
                                <asp:Label ID="lblgrdSchool" runat="server" meta:ResourceKey="lblgrdSchool"></asp:Label>
                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSchool" runat="server" Text='<%# Eval("School") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                        <HeaderTemplate>
                                <asp:Label ID="lblgrdClasses" runat="server" meta:ResourceKey="lblgrdClasses"></asp:Label>
                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblClasses" runat="server" Text='<%# Eval("Classes") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                       
                                        <asp:TemplateField>
                                        <HeaderTemplate>
                                <asp:Label ID="lblgrdDelete" runat="server" meta:ResourceKey="lblgrdDelete"></asp:Label>
                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="btnDeleteClass" runat="server" meta:ResourceKey="btnDeleteClass" CssClass="grddel" CommandArgument='<%# Eval("SchoolId") + "|" + Eval("ClassIds") %>'
                                                     OnClientClick='<%# Eval("SchoolId", "ConfirmDeleteClass({0})") %>'/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                   </ContentTemplate>  
                                </asp:UpdatePanel>
                            </div>
                        </td>
                    </tr>
                    <tr runat="server" id="tr_password">
                        <td>
                            <asp:Label ID="lblPassword" runat="server" meta:ResourceKey="lblPassword" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="gltxt"></asp:TextBox><span
                                class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Please enter Password"
                                ControlToValidate="txtPassword" ValidationGroup="Save" CssClass="error" 
                                Display="Dynamic" meta:ResourceKey="rfvPassword"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr runat="server" id="tr_Conpassword">
                        <td>
                            <asp:Label ID="lblConfirmPassword" runat="server" meta:ResourceKey="lblConfirmPassword" CssClass="Glblbl"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="gltxt"></asp:TextBox><span
                                class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="Please confirm Password"
                                ControlToValidate="txtConfirmPassword" ValidationGroup="Save" CssClass="error"
                                Display="Dynamic" meta:ResourceKey="rfvConfirmPassword"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cmpvalPassword" runat="server" ErrorMessage="Passwords dont match"
                                Display="Dynamic" ValidationGroup="Save" Type="String" Operator="Equal" ControlToCompare="txtPassword"
                                ControlToValidate="txtConfirmPassword" CssClass="error" meta:ResourceKey="cmpvalPassword"></asp:CompareValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            
                        </td>
                        <td>
                       <asp:UpdatePanel ID="Up_btns" runat="server">
                      <ContentTemplate>
                            <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save"  OnClick="btn_Save_Click"
                                CssClass="glbtn" ValidationGroup="Save" />
                            <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click"
                                CssClass="glbtn"  />
                       </ContentTemplate>
                       <Triggers >
                       <asp:PostBackTrigger ControlID="btn_Save" />
                       <asp:PostBackTrigger ControlID="btn_Cancel" />

                       </Triggers>
                     </asp:UpdatePanel>
                            
                        </td>
                    </tr>
                </table>
                
                </div>
        </asp:Panel>

        <asp:ModalPopupExtender ID="mpeDeleteClasses" runat="server" PopupControlID="pnlClassPopup"
        CancelControlID="btnCancelPopup" TargetControlID="btnDummy">
        </asp:ModalPopupExtender>
        <asp:Button ID="btnDummy" runat="server" meta:ResourceKey="btnDummy" style="display:none;"/>
        <asp:Panel ID="pnlClassPopup" runat="server" style="display:none;" >
        <div class="classpop">
            <table>
                <tr>
                    <td>
                        <h3>Class List</h3>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:CheckBoxList ID="chkListClasses" runat="server" DataSourceID="sdsClassAdminClasses"
                            DataTextField="ClassName" DataValueField="MappingId">
                        </asp:CheckBoxList>
                        <asp:SqlDataSource ID="sdsClassAdminClasses" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="select CAC.MappingId, ' '+CM.Class as ClassName from ClassAdminClasses CAC
                            LEFT OUTER JOIN SchoolClassMaster CM ON CAC.ClassId=CM.ClassId
                            where CAC.ClassAdminId=@ClassAdminId and CAC.SchoolId=@SchoolId and CAC.IsActive=1">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="hdnSchoolId" DefaultValue="0" Name="SchoolId" PropertyName="Value"
                                    Type="String" />
                                <asp:ControlParameter ControlID="hdn_ClassAdminId" DefaultValue="0" Name="ClassAdminId" PropertyName="Value"
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnRemoveClasses" runat="server" meta:ResourceKey="btnRemoveClasses" 
                            onclick="btnRemoveClasses_Click" OnClientClick="retunt ConfirmDeleteClasses();" />
                        <asp:Button ID="btnCancelPopup" runat="server" meta:ResourceKey="btnCancelPopup" />
                    </td>
                </tr>
            </table>
            </div>
        </asp:Panel>
       
        <asp:Panel ID="pnl_AdminList" runat="server" DefaultButton="btn_Search">
         <div class="frmBox">

           <asp:Button ID="btn_AddNew" runat="server" meta:ResourceKey="btn_AddNew"  CssClass="right R_M" OnClick="btn_AddNew_Click" />
            <div class="div_SearchBox">
                <table>
                    <tr>
                        <td><asp:Label ID="lbl_Name" runat="server" meta:ResourceKey="lbl_Name"></asp:Label></td>
                        <td><asp:TextBox ID="txt_SearchName" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lbl_School" runat="server" meta:ResourceKey="lbl_School"></asp:Label></td>
                        <td>
                            
                              <asp:DropDownList ID="ddl_School" runat="server" DataSourceID="sds_School" DataTextField="School"
                                DataValueField="SchoolId">
                            </asp:DropDownList>
                            
                            <asp:SqlDataSource ID="sds_School" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], 'Schule' as [School] union all select sm.SchoolId, sm.School from schoolmaster sm
                                    where sm.IsActive=1 
                                    ">
                              
                            </asp:SqlDataSource>
                           
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                           
                                 <asp:Button ID="btn_Search" runat="server" meta:ResourceKey="btn_Search" 
                                     onclick="btn_Search_Click" CssClass="Left" />
                                
                                      <asp:Button ID="btn_SearchCancel" runat="server" meta:ResourceKey="btn_SearchCancel"  
                                     onclick="btn_SearchCancel_Click"  />
                                
                        </td>
                    </tr>
                </table>
            </div>
            </div>
            <div class="GridWrap">
               
                <asp:GridView ID="grd_ClassAdminList" runat="server" 
                    AutoGenerateColumns="False" DataKeyNames="ClassAdminId" DataSourceID="sds_ClassAdminList" AllowSorting="true"
                    OnRowDataBound="grd_ClassAdminList_RowDataBound" AllowPaging="True" 
                    onpageindexchanging="grd_ClassAdminList_PageIndexChanging" Width="100%" 
                    onrowcommand="grd_ClassAdminList_RowCommand" 
                    onsorting="grd_ClassAdminList_Sorting">
                    <EmptyDataTemplate>
                        <asp:Label ID="lblEmptyData" runat="server" meta:ResourceKey="lblEmptyData"></asp:Label>
                    </EmptyDataTemplate>
                    <Columns>
                        <asp:TemplateField>
                        <HeaderTemplate>
                                <asp:Label ID="lblgrdName" runat="server" meta:ResourceKey="lblgrdName"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdEmail" runat="server" meta:ResourceKey="lblgrdEmail"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Password">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdPassword" runat="server" Text="Password" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblShowPassword" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        <asp:TemplateField>
                         <HeaderTemplate>
                                <asp:Label ID="lblgrdAddress" runat="server" meta:ResourceKey="lblgrdAddress"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="CityName" HeaderText="City" SortExpression="CityName" />--%>
                        <asp:TemplateField>
                         <HeaderTemplate>
                                <%--<asp:Label ID="lblgrdCity" runat="server" meta:ResourceKey="lblgrdCity"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdCity" runat="server" meta:ResourceKey="lbtngrdCity" CommandName="sort" CommandArgument="CityName"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdCity" runat="server"> </asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="School" HeaderText="School" SortExpression="School" />--%>
                        <asp:TemplateField>
                         <HeaderTemplate>
                                <%--<asp:Label ID="lblgrdSchool" runat="server" meta:ResourceKey="lblgrdSchool"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdSchool" runat="server" meta:ResourceKey="lbtngrdSchool" CommandName="sort" CommandArgument="School"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdSchool" runat="server"> </asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblSchool" runat="server" Text='<%# Eval("School") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="Classes" HeaderText="Classes" SortExpression="Classes" />--%>
                        <asp:TemplateField>
                         <HeaderTemplate>
                                <%--<asp:Label ID="lblgrdClasses" runat="server" meta:ResourceKey="lblgrdClasses"></asp:Label>--%>
                                    <asp:LinkButton ID="lbtngrdClasses" runat="server" meta:ResourceKey="lbtngrdClasses" CommandName="sort" CommandArgument="Classes"></asp:LinkButton>
                                    <asp:PlaceHolder id="phtgrdClasses" runat="server"> </asp:PlaceHolder>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblClasses" runat="server" Text='<%# Eval("Classes") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderStyle-Width="50px">
                        <HeaderTemplate>
                                <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Button ID="btn_Edit" runat="server" Text="" CssClass="grdedit" meta:ResourceKey="btn_Edit"
                                    CommandArgument='<%# Eval("ClassAdminId") %>' OnClick="btnEdit_Click" />
                            </ItemTemplate>
                        </asp:TemplateField>
                      <%--  <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="50px">
                            <ItemTemplate>
                                <asp:Button ID="btn_Delete" runat="server" Text="" ToolTip="Delete" CssClass="grddel" OnClientClick='<%# Eval("ClassAdminId", "Confirm({0})") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sds_ClassAdminList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                    SelectCommand="SP_GETCLASSADMINS" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:Parameter DefaultValue="0" Name="ClassAdminId" Type="Int32" />
                        <asp:ControlParameter ControlID="txt_SearchName" DefaultValue=" " 
                            Name="AdminName" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="ddl_School" DefaultValue="0" Name="SchoolId" 
                            PropertyName="SelectedValue" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="CityAdminId" Type="Int32" />
                     
                    </SelectParameters>
                </asp:SqlDataSource>
                
            </div>
        </asp:Panel>
       
        <asp:Button ID="btnDelete" runat="server" meta:ResourceKey="btnDelete" CssClass="hide" OnClick="btnDelete_Click"
            Style="display: none;" />
            <asp:Button ID="btnClassDelete" runat="server" meta:ResourceKey="btnClassDelete" CssClass="hide"
             OnClick="btnClassDelete_Click" Style="display: none;" />

    </div>

    </div>
</asp:Content>
