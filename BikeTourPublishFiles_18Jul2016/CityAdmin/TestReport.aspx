<%@ page title="BikeTour - Quiz Test Report" language="C#" culture="de-DE" uiculture="de-DE" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="ClassAdmin_TestReport, App_Web_qvm2tkwv" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
     <div class="frmBox_2">  
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                </td>
                <td>
                    <asp:UpdatePanel ID="up_School" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                DataValueField="SchoolId" AutoPostBack="true" 
                                onselectedindexchanged="ddlSchool_SelectedIndexChanged" >
                            </asp:DropDownList>
                            <%--<span class="error">*</span>--%>
                            <asp:RequiredFieldValidator ID="rfvSchool" runat="server" ErrorMessage="Schule"
                                InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                                CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], ' Schule' as [School] union all 
                                           select sm.SchoolId, sm.School from schoolmaster sm where sm.IsActive=1
                                           and sm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId )">
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
                            
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:UpdateProgress ID="UpdateProgressClass" runat="server" AssociatedUpdatePanelID="up_School">
                        <ProgressTemplate>
                            <asp:Image ID="ImageLoading" runat="server" ImageUrl="~/_images/ajax_loader_blue_32.gif"
                                CssClass="loader" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
                <td>
                    <asp:Label ID="lblStage" runat="server" meta:ResourceKey="lblStage"></asp:Label>
                </td>
                <td>
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                    <asp:DropDownList ID="ddl_Stage" runat="server" DataSourceID="sds_Stages" DataTextField="StageLeg"
                        DataValueField="tocityid" AutoPostBack="True" 
                        onselectedindexchanged="ddl_Stage_SelectedIndexChanged" >
                    </asp:DropDownList>

                    <asp:SqlDataSource ID="sds_Stages" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="select '0' as tocityid, ' Stadt' as StageLeg UNION ALL select tocityid,
                            StageLeg=(select CityName from CityMaster where CityId=SP.FromCityId)+' to '+(select CityName from CityMaster where CityId=SP.ToCityId)
                            from StagePlan SP  inner join StagePlanStatus sps on sp.StatusId = sps.StatusId        
                            inner join SchoolClassMaster scm on sp.ClassId = scm.ClassId       
                            inner join CityMaster CM on CM.CityId=FromCityId    
                            inner join SchoolMaster sm on sm.SchoolId = scm.SchoolId               
                            where sp.IsActive = 1 and SP.StatusId=3 and SP.ClassId=@ClassId and scm.IsActive = 1">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="ddlClass" Name="ClassId" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    </ContentTemplate>
                    </asp:UpdatePanel>
                </td>
                <td>
                    <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upClass">
                        <ProgressTemplate>
                            <asp:Image ID="ImageLoading2" runat="server" ImageUrl="~/_images/ajax_loader_blue_32.gif"
                                CssClass="loader" />
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </td>
            </tr>
        </table>
</div>
    <div class="container">
    <h5 id="h1_ClassForum" runat="server">
        <asp:Label ID="lblHeadText" runat="server" meta:ResourceKey="lblHeadText"></asp:Label>
    </h5> 
    <div class="AdminContWrap"> 
         
        <asp:Panel ID="pnlContent" runat="server">
        <br />
        <div class="GridWrap">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
            <asp:GridView ID="grd_Report" runat="server" AutoGenerateColumns="False" 
                HeaderStyle-CssClass="gridHeader" meta:ResourceKey="EmptyGrid"
                CssClass="gv" DataSourceID="sdsResult" Width="100%">
                
                <Columns>
                    <asp:BoundField DataField="StudentName" HeaderText="Student" 
                        SortExpression="StudentName" />
                    <asp:BoundField DataField="CityName" HeaderText="City" 
                        SortExpression="CityName" />
                    <asp:BoundField DataField="OutofScore" HeaderText="OutofScore" 
                        SortExpression="OutofScore" />
                    <asp:BoundField DataField="PassingScore" HeaderText="PassingScore" 
                        SortExpression="PassingScore" />
                    <asp:BoundField DataField="StudentScore" HeaderText="StudentScore" 
                        SortExpression="StudentScore" />
                    <asp:BoundField DataField="Result" HeaderText="Result" 
                        SortExpression="Result" />
                    <asp:BoundField DataField="ResultDate" HeaderText="ResultDate" 
                        SortExpression="ResultDate" />
                </Columns>
                <HeaderStyle CssClass="gridHeader" />
                
            </asp:GridView>
            <asp:SqlDataSource ID="sdsResult" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" 
                SelectCommand="SELECT QR.StudentId, QR.ClassId, QR.CityId, QR.OutofScore, QR.PassingScore,
                QR.StudentScore, Result=(CASE QR.IsPassed when '1' then 'Pass' else 'Fail' end), 
                CONVERT(VARCHAR(10), QR.ResultDate, 101) as ResultDate, SM.FirstName+' '+SM.LastName as StudentName, CM.CityName
                FROM QuizResult QR LEFT JOIN StudentMaster SM on QR.StudentId=SM.StudentId 
                LEFT JOIN CityMaster CM ON QR.CityId=CM.CityId
                WHERE QR.CityId=@CityId and QR.ClassId=@ClassId">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlClass" Name="ClassId" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddl_Stage" Name="CityId" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>
            </ContentTemplate>
            </asp:UpdatePanel>
            </div>
        </asp:Panel>
    </div>
        </div>
</asp:Content>

