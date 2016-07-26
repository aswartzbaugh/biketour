<%@ page title="Bike Tour - Class Admin" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="ClassAdmin_ClassAdmin, App_Web_qvm2tkwv" %>

<%@ Register Assembly="DropDownCheckBoxes" Namespace="Saplin.Controls" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  
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
          <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label> </h5>
        <div class="AdminContWrap">
            <asp:HiddenField ID="hdnSchoolId" runat="server" />
            <asp:Panel ID="pnl_AddAdmin" runat="server" Visible="false">
                <div class="frmBox">
                    <table width="100%">
                        <tr>
                            <td style="width: 160px;">
                                <asp:Label ID="lblFirstName" runat="server" meta:ResourceKey="lblFirstName" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_FirstName" runat="server"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" 
                                    ControlToValidate="txt_FirstName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"
                                    Height="16px" meta:ResourceKey="rfvFirstName"></asp:RequiredFieldValidator>
                               <%-- <asp:RegularExpressionValidator runat="server" ID="rfv2FirstName" ControlToValidate="txt_FirstName"
                                    ValidationGroup="Submit" ValidationExpression="^[a-zA-Z]*$" 
                                    CssClass="error" Display="Dynamic" meta:RsourceKey="rfv2FirstName"/>--%>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblLastName" runat="server" meta:ResourceKey="lblLastName" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txt_LastName" runat="server" CssClass="gltxt"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvLastName" runat="server" 
                                    ControlToValidate="txt_LastName" meta:ResourceKey="rfvLastName" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                                <%--<asp:RegularExpressionValidator runat="server" ID="rfv2LastName" ControlToValidate="txt_LastName"
                                    ValidationGroup="Submit" ValidationExpression="^[a-zA-Z]*$" 
                                    CssClass="error" Display="Dynamic" meta:ResourceKey="rfv2LastName"/>--%>
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
                                   meta:ResourceKey="rfvAddress" ControlToValidate="txtAddress" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblEmail" runat="server" meta:ResourceKey="lblEmail" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="gltxt"></asp:TextBox><span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                    ControlToValidate="txtEmail" ValidationGroup="Submit" CssClass="error" Display="Dynamic" meta:ResourceKey="rfvEmail"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="rev_Email" runat="server" ControlToValidate="txtEmail"
                                     CssClass="error" Display="Dynamic"
                                    ValidationExpression="^[\w-\.]{1,}\@([\da-zA-Z-]{1,}\.){1,}[\da-zA-Z-]{2,3}$"
                                    ValidationGroup="Submit" meta:ResourceKey="rev_Email">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UP_ddlSchool" runat="server">
                                    <contenttemplate>
                            <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                DataValueField="SchoolId" AutoPostBack="true">
                            </asp:DropDownList>
                            <span class="error">*</span>
                            <asp:RequiredFieldValidator ID="rfvSchool" runat="server" 
                                InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                                CssClass="error" Display="Dynamic" meta:ResourceKey="rfvSchool"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], ' Schule' as [School] union all select sm.SchoolId, sm.School from schoolmaster sm
                                                where sm.IsActive=1
                                                and sm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId) order by School
                                                ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CityAdminId" SessionField="UserId" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                             </contenttemplate>
                                    <triggers>
                             <asp:PostBackTrigger ControlID="ddlSchool" />
                             </triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass" CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:UpdatePanel ID="UP_ddl_Class" runat="server">
                                    <contenttemplate> 
                            <cc1:DropDownCheckBoxes ID="ddl_Class" runat="server" AddJQueryReference="True" CssClass="" Width="200px" Height="22px"
                                DataSourceID="sds_Class" DataTextField="Class" UseSelectAllNode="true" DataValueField="ClassId" 
                                RepeatDirection="Vertical" UseButtons="False" >
                            </cc1:DropDownCheckBoxes>
                            <span class="error">*</span>
                            <cc1:ExtendedRequiredFieldValidator ID="rfv_ddlClass" runat="server" ControlToValidate="ddl_Class"
                                ValidationGroup="SubmitClass" ForeColor="Red" CssClass="error" meta:ResourceKey="rfv_ddlClass" ErrorMessage="Please select class">
                                
</cc1:ExtendedRequiredFieldValidator>
                            <asp:SqlDataSource ID="sds_Class" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand=" select classid, Class from SchoolClassMaster where SchoolId=@SchoolId and IsActive=1">
                             <SelectParameters>
                                    <asp:ControlParameter ControlID="ddlSchool" DefaultValue="" Name="schoolid" 
                                        PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </contenttemplate>
                                    <triggers>
                            <asp:PostBackTrigger ControlID ="ddl_Class" />
                            </triggers>
                                </asp:UpdatePanel>
                                <%--<span class="error">*</span>--%>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <contenttemplate> 
                                  <asp:Button ID="btnAddClass" runat="server" meta:ResourceKey="btnAddClass" OnClick="btnAddClass_Click"
                                    ValidationGroup="SubmitClass" />
                                </contenttemplate>
                                    <triggers>
                                <asp:PostBackTrigger ControlID="btnAddClass" />
                                </triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="left">
                                <div class="GridWrap">
                                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <contenttemplate>
                                   <asp:GridView ID="grdClasses" runat="server" 
                                    AutoGenerateColumns="False" Width="100%" DataKeyNames="SchoolId,ClassIds" 
                                    AllowSorting="true" AllowPaging="True" 
                                    onpageindexchanging="grdClasses_PageIndexChanging" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="School">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblSchoolgrd" runat="server" meta:ResourceKey="lblSchoolgrd"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblSchool" runat="server" Text='<%# Eval("School") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Classes">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblClassesgrd" runat="server" meta:ResourceKey="lblClassesgrd"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="lblClasses" runat="server" Text='<%# Eval("Classes") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                      <%--  <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="50px" >
                                            <ItemTemplate>
                                                <asp:Button ID="btnEditClass" runat="server" Text="" CssClass="grdedit" ToolTip="Edit"
                                                    CommandArgument='<%# Eval("SchoolId") + "|" + Eval("ClassIds") %>' OnClick="btnEditClass_Click" />
                                            </ItemTemplate>
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Delete">
                                            <HeaderTemplate>
                                                <asp:Label ID="lblDeletegrd" runat="server" meta:ResourceKey="lblDeletegrd"></asp:Label>
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:Button ID="btnDeleteClass" runat="server" Text="" meta:ResourceKey="ToolTipDelete" CssClass="grddel" CommandArgument='<%# Eval("SchoolId") + "|" + Eval("ClassIds") %>'
                                                     OnClientClick='<%# Eval("SchoolId", "ConfirmDeleteClass({0}); return false;") %>'/>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                </contenttemplate>
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
                                   meta:ResourceKey="rfvPassword" ControlToValidate="txtPassword" ValidationGroup="Submit" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr runat="server" id="tr_Conpassword">
                            <td>
                                <asp:Label ID="lblConfirmPassword" runat="server" meta:ResourceKey="lblConfirmPassword"
                                    CssClass="Glblbl"></asp:Label>
                            </td>
                            <td>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="gltxt"></asp:TextBox><span
                                    class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ErrorMessage="Please confirm Password"
                                    ControlToValidate="txtConfirmPassword" ValidationGroup="Submit" CssClass="error"
                                    Display="Dynamic" meta:ResourceKey="rfvConfirmPassword"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cmpvalPassword" runat="server" ErrorMessage="Passwords dont match"
                                    Display="Dynamic" ValidationGroup="Submit" Type="String" Operator="Equal" ControlToCompare="txtPassword"
                                    ControlToValidate="txtConfirmPassword" CssClass="error" meta:ResourceKey="cmpvalPassword"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <table border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <contenttemplate> 
                            <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" ValidationGroup="Submit" OnClick="btn_Save_Click"
                                CssClass="glbtn" />
                            <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click"
                                CssClass="glbtn" />
                                </contenttemplate>
                                    <triggers>
                                <asp:PostBackTrigger ControlID ="btn_Save" />
                                <asp:PostBackTrigger ControlID ="btn_Cancel" />
                                
                                </triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </div>
            </asp:Panel>
            <asp:HiddenField ID="hdn_ClassAdminId" runat="server" Value="0" />
            <asp:Panel ID="pnl_AdminList" runat="server" DefaultButton="btn_Search">
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <contenttemplate> 
               <asp:Button ID="btn_AddNew" runat="server" meta:ResourceKey="btn_AddNew"  CssClass="right R_M" OnClick="btn_AddNew_Click" />
           </contenttemplate>
                    <triggers>  
           <asp:PostBackTrigger ControlID ="btn_AddNew" />
           </triggers>
                </asp:UpdatePanel>
                <div class="div_SearchBox">
                    <div class="frmBox">
                        <table>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_Name" runat="server" meta:ResourceKey="lbl_Name"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_SearchName" runat="server"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lbl_School" runat="server" meta:ResourceKey="lbl_School"></asp:Label>
                                </td>
                                <td>
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <contenttemplate> 
                              <asp:DropDownList ID="ddl_School" runat="server" DataSourceID="sds_School" DataTextField="School"
                                DataValueField="SchoolId">
                            </asp:DropDownList>
                            
                            <asp:SqlDataSource ID="sds_School" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], ' Schule' as [School] union all select sm.SchoolId, sm.School from schoolmaster sm
                                    where sm.IsActive=1
                                    and sm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId) order by School
                                    ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="CityAdminId" SessionField="UserId" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            </contenttemplate>
                                    </asp:UpdatePanel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <asp:Button ID="btn_Search" runat="server" meta:ResourceKey="btn_Search" OnClick="btn_Search_Click" />
                                    <asp:Button ID="btn_SearchCancel" runat="server" meta:ResourceKey="btn_SearchCancel"
                                        OnClick="btn_SearchCancel_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="GridWrap">
                    <asp:GridView ID="grd_ClassAdminList" runat="server" AutoGenerateColumns="False"
                        EmptyDataText="No Records!" DataKeyNames="ClassAdminId" DataSourceID="sds_ClassAdminList"
                        OnRowDataBound="grd_ClassAdminList_RowDataBound" AllowPaging="True" OnPageIndexChanging="grd_ClassAdminList_PageIndexChanging"
                        Width="100%"
                        onsorting="grd_ClassAdminList_Sorting" AllowSorting="true">
                        <Columns>
                            <asp:TemplateField HeaderText="Name">
                                <HeaderTemplate>
                                    <asp:LinkButton ID="lblgrdName" runat="server" meta:ResourceKey="lblgrdName"
                                    CommandName="sort" CommandArgument="Name"></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdEmail" runat="server" meta:ResourceKey="lblgrdEmail"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                              <asp:TemplateField HeaderText="Password">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdPassword" runat="server" meta:ResourceKey="lblPassword" ></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblShowPassword" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="Address">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdAddress" runat="server" meta:ResourceKey="lblgrdAddress"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblAddress" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="CityName" HeaderText="City" SortExpression="CityName" />--%>
                            <asp:TemplateField HeaderText="City" SortExpression="CityName">
                                <HeaderTemplate>
                                    <asp:LinkButton ID="lblgrdCity" runat="server" meta:ResourceKey="lblgrdCity"
                                    CommandName="sort" CommandArgument="CityName"></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCity" runat="server" Text='<%# Eval("CityName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="School" HeaderText="School" SortExpression="School" />--%>
                            <asp:TemplateField HeaderText="School" SortExpression="School">
                                <HeaderTemplate>
                                    <asp:LinkButton ID="lblgrdSchool" runat="server" meta:ResourceKey="lblgrdSchool"
                                    CommandName="sort" CommandArgument="School"></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblSchool" runat="server" Text='<%# Eval("School") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:BoundField DataField="Classes" HeaderText="Classes" SortExpression="Classes" />--%>
                            <asp:TemplateField HeaderText="Address" SortExpression="Classes">
                                <HeaderTemplate>
                                    <asp:LinkButton ID="lblgrdClasses" runat="server" meta:ResourceKey="lblgrdClasses"
                                    CommandName="sort" CommandArgument="Classes"></asp:LinkButton>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblClasses" runat="server" Text='<%# Eval("Classes") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Edit" HeaderStyle-Width="50px">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdEdit" runat="server" meta:ResourceKey="lblgrdEdit"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btn_Edit" runat="server" Text="" CssClass="grdedit" meta:ResourceKey="ToolTipEdit"
                                        CommandArgument='<%# Eval("ClassAdminId") %>' OnClick="btnEdit_Click" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Delete" HeaderStyle-Width="50px">
                                <HeaderTemplate>
                                    <asp:Label ID="lblgrdDelete" runat="server" meta:ResourceKey="lblgrdDelete"></asp:Label>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:Button ID="btn_Delete" po runat="server" Text="" meta:ResourceKey="ToolTipDelete" CssClass="grddel"
                                        OnClientClick='<%# Eval("ClassAdminId", "Confirm({0}); return false;") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sds_ClassAdminList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="SP_GETCLASSADMINS" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="ClassAdminId" Type="Int32" />
                            <asp:ControlParameter ControlID="txt_SearchName" DefaultValue=" " Name="AdminName"
                                PropertyName="Text" Type="String" />
                            <asp:ControlParameter ControlID="ddl_School" DefaultValue="0" Name="SchoolId" PropertyName="SelectedValue"
                                Type="Int32" />
                            <asp:SessionParameter DefaultValue="0" Name="CityAdminId" SessionField="UserId" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </div>
            </asp:Panel>
            <asp:Button ID="btnDelete" runat="server" Text="Delete" CssClass="hide" OnClick="btnDelete_Click"
                Style="display: none;" />
            <asp:Button ID="btnClassDelete" runat="server" Text="DeleteClass" CssClass="hide"
                OnClick="btnClassDelete_Click" Style="display: none;" />
        </div>
    </div>

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
                  return false;
              }
              else {
                  return false;
              }
          }

          function ConfirmDeleteClass(obj) {
              debugger;
              var Ok = confirm('Wollen Sie löschen?');
              if (Ok) {
                  $("[id$=hdnSchoolId]").val(obj);
                  $("[id$=btnClassDelete]").trigger("click");
                  return false;
              }
              else {
                  return false;
              }
          }
    </script>
</asp:Content>
