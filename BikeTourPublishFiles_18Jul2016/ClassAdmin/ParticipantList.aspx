<%@ page title="Bike Tour - Participant List" culture="de-DE" uiculture="de-DE" language="C#" enableeventvalidation="false" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="ClassAdmin_ParticipantList, App_Web_czoj0jh4" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
  
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
      <script type="text/javascript">
          $(document).ready(function () { $("[id$=btnDeleteStudent]").hide(); });
          function Confirm(obj) {
              var Ok = confirm('Wollen Sie löschen?');
              if (Ok) {
                  $("[id$=hdnDeleteId]").val(obj);
                  $("[id$=btnDeleteStudent]").trigger("click");
                  return true;
              }
              else {
                  return false;
              }
          }

          function successDelete()
          {
              alert('Deleted Successfully!');
          }


    </script>
    <div class="frmBox_2">
        <table width="70%">
            <tr>
                <td>
                    <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                </td>
                <td>
                    <span class="error right">*</span>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                DataValueField="SchoolId" AutoPostBack="true">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], 'Schule' as [School] union all 
                                   select distinct sm.SchoolId, sm.School from ClassAdminClasses cac inner join SchoolMaster sm
                                     on cac.SchoolId = sm.SchoolId
                                     where ClassAdminId = @ClassAdminId
                                     ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ClassAdminId" SessionField="UserId" DefaultValue="5" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="ddlSchool" />
                        </Triggers>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass"></asp:Label>
                </td>
                <td>
                    <span class="error right">*</span>
                    <asp:UpdatePanel ID="Up_ddlClass" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="sds_Class" DataTextField="ClassName"
                                DataValueField="classid" AutoPostBack="true" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sds_Class" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="select 'Klasse' as ClassName, '0' as classid union all 
                                    select distinct scm.class as ClassName, scm.classid from  ClassAdminClasses cac inner join SchoolClassMaster scm
                                      on cac.ClassId = scm.ClassId
                                     where 
                                      ClassAdminId = @ClassAdminId and
                                       cac.SchoolId = @SchoolId
                                        and scm.IsActive = 1">
                                <SelectParameters>
                                    <asp:SessionParameter DefaultValue="" Name="ClassAdminId" SessionField="UserId" />
                                    <asp:ControlParameter ControlID="ddlSchool" Name="SchoolId" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool"
                        InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                        CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
                <td></td>
                <td>
                    <asp:RequiredFieldValidator ID="rfvClass" runat="server" meta:ResourceKey="rfvClass"
                        InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                        Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
    </div>
    <div class="container">
        <h5>
            <asp:Label ID="lblParticipantList" runat="server" meta:ResourceKey="lblParticipantList"></asp:Label>
        </h5>
        <div class="AdminContWrap">
            <div class="GridWrap">
                <asp:UpdatePanel ID="Up_grd_ParticipantsList" runat="server">
                    <ContentTemplate>
                        <asp:GridView ID="grd_ParticipantsList" runat="server" Width="100%" AutoGenerateColumns="False"
                            OnRowCreated="grd_ParticipantsList_RowCreated"
                            EmptyDataText="Kein Eintrag vorhanden!" AllowPaging="True"
                            OnPageIndexChanging="grd_ParticipantsList_PageIndexChanging"
                            OnRowCommand="grd_ParticipantsList_RowCommand"
                            OnRowDataBound="grd_ParticipantsList_RowDataBound"
                            OnSorting="grd_ParticipantsList_Sorting">
                            <Columns>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:LinkButton ID="lbtngrdStudent" runat="server" meta:ResourceKey="lbtngrdStudent"
                                            CommandName="Sort" CommandArgument="STUDENTNAME"></asp:LinkButton>
                                        <asp:PlaceHolder ID="placeholderSTUDENTNAME" runat="server"></asp:PlaceHolder>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkEdit" runat="server" ForeColor="#0033CC" PostBackUrl='<%#"~/ClassAdmin/StudentDetails.aspx?StudentId="+ Eval("StudentId") %>'
                                            Text='<%# Eval("STUDENTNAME") %>' ToolTip="" meta:ResourceKey="lnkEdit"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblgrdUserName" runat="server" Text='<%#Eval("UserName") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:LinkButton ID="lbtngrdUserName" runat="server" meta:ResourceKey="lbtngrdLoginName" CommandName="Sort"
                                            CommandArgument="UserName"></asp:LinkButton>
                                        <asp:PlaceHolder ID="placeholderLoginName" runat="server"></asp:PlaceHolder>
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblgrdConfirmed" runat="server" meta:ResourceKey="lblgrdConfirmed"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk_Confirmed" runat="server" Checked='<%# Eval("IsStatusConfirmed") %>'
                                            AutoPostBack="true" OnCheckedChanged="CheckBox1_CheckedChanged" Enabled="true" />
                                        <asp:Label ID="lbl_StudentId" runat="server" Text='<%# Eval("StudentId") %>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField Visible="false">
                                    <HeaderTemplate>
                                        <asp:Label ID="lblgrdActive" runat="server" meta:ResourceKey="lblgrdActive"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk_Active" runat="server" Checked='<%# Eval("IsStatusConfirmed") %>'
                                            Enabled="true" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblUploadBlocked" runat="server" meta:ResourceKey="lblUploadBlocked"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chk_UploadBlocked" runat="server" Checked='<%# Eval("isUploadBlock") %>'
                                            Enabled="true" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Label ID="lblgrdPass" runat="server" Text='<%#Eval("Password") %>'></asp:Label>
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:LinkButton ID="lbtngrdPass" runat="server" meta:ResourceKey="lbtngrdPass" CommandName="Sort"
                                            CommandArgument="Password"></asp:LinkButton>
                                        <asp:PlaceHolder ID="placeholderPassword" runat="server"></asp:PlaceHolder>
                                    </HeaderTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblEditDetails" runat="server" meta:ResourceKey="lblEditDetails"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="btnEditStudDetails" runat="server" Text="" ToolTip="bearbeiten" CssClass="grdedit"
                                            OnClick="btnEditStudDetails_Click" CommandArgument='<%# Eval("StudentId") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>

                               <asp:TemplateField>
                                    <HeaderTemplate>
                                        <asp:Label ID="lblDeleteStudent" runat="server" meta:ResourceKey="btnDeleteStudent"></asp:Label>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                           <input id="btDelete" type="button" class="grddel" title="löschen" onclick="Confirm('<%# Eval("StudentId") %>    ')" />
                        
                       
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                                 <asp:Button ID="btnDeleteStudent" runat="server" Text="" ToolTip="löschen" CssClass="hide" 
                                         onclick="btnDeleteStudent_Click"    CommandArgument='<%# Eval("StudentId") %>' Visible="False" />         
                       
                        <%--<asp:SqlDataSource ID="sds_ParticipantsList" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="SP_GET_ClassParticipantsList" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="1" Name="ClassAdminId" SessionField="UserId"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="ddlClass" Name="classid" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>--%>
                    </ContentTemplate>
                   
                </asp:UpdatePanel>
            </div>
            <div id="div_ButtonList" runat="server">
                <asp:Button ID="btn_Save" runat="server" meta:ResourceKey="btn_Save" OnClick="btn_Save_Click" />
            </div>
            <div class="clear"></div>
                  <asp:HiddenField ID="hdnDeleteId" runat="server" />
        </div>
    </div>
</asp:Content>
