<%@ Page Title="BikeTour - Quiz Test Report" Language="C#" Culture="de-DE" UICulture="de-DE"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="TestReport.aspx.cs"
    Inherits="ClassAdmin_TestReport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                                DataValueField="SchoolId" AutoPostBack="true" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged">
                            </asp:DropDownList>
                            <%--<span class="error">*</span>--%>
                            <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool"
                                InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                                CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [SchoolId], 'Select School' as [School] union all 
                                select distinct sm.SchoolId, sm.School from ClassAdminClasses cac inner join SchoolMaster sm
                                  on cac.SchoolId = sm.SchoolId
                                 where ClassAdminId = @ClassAdminId
                                  ">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ClassAdminId" SessionField="UserId" />
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
                            <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="sds_Class" DataTextField="ClassName"
                                DataValueField="classid" AutoPostBack="True" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                            </asp:DropDownList>
                            <%--<span class="error">*</span>--%>
                            <asp:RequiredFieldValidator ID="rfvClass" runat="server" InitialValue="0" ControlToValidate="ddlClass"
                                meta:ResourceKey="rfvClass" ValidationGroup="SubmitClass" CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
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
                                DataValueField="tocityid" AutoPostBack="True" OnSelectedIndexChanged="ddl_Stage_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sds_Stages" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="select '0' as tocityid, 'Select' as StageLeg UNION ALL select tocityid,
                            StageLeg=(select CityName from CityMaster where CityId=SP.FromCityId)+' to '+(select CityName from CityMaster where CityId=SP.ToCityId)
                            from StagePlan SP  inner join StagePlanStatus sps on sp.StatusId = sps.StatusId        
                            inner join SchoolClassMaster scm on sp.ClassId = scm.ClassId       
                            inner join CityMaster CM on CM.CityId=FromCityId    
                            inner join SchoolMaster sm on sm.SchoolId = scm.SchoolId               
                            where sp.IsActive = 1 and SP.StatusId=3 and SP.ClassId=@ClassId">
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
            <asp:Label ID="lblHead" runat="server" meta:ResourceKey="lblHead"></asp:Label></h5>
        <div class="AdminContWrap">
            <asp:Panel ID="pnlContent" runat="server">
                <div class="clear">
                </div>
                <div class="GridWrap">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:GridView ID="grd_Report" runat="server" AutoGenerateColumns="False" HeaderStyle-CssClass="gridHeader"
                                EmptyDataText="No records found" CssClass="gv" Width="100%" 
                                onrowcommand="grd_Report_RowCommand" onrowdatabound="grd_Report_RowDataBound" 
                                onsorting="grd_Report_Sorting">
                                <Columns>
                                    <asp:TemplateField SortExpression="StudentName">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lblgrdStudentName" runat="server" meta:ResourceKey="lblgrdStudentName"
                                                CommandName="Sort" CommandArgument="StudentName"></asp:LinkButton>
                                            <asp:PlaceHolder ID="placeholderStudentName" runat="server"></asp:PlaceHolder>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentName" runat="server" Text='<%#Eval("StudentName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="StudentName" HeaderText="Student" 
                        SortExpression="StudentName" />--%>
                                    <asp:TemplateField SortExpression="CityName">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lblgrdCityName" runat="server" meta:ResourceKey="lblgrdCityName"
                                                CommandName="Sort" CommandArgument="CityName"></asp:LinkButton>
                                            <asp:PlaceHolder ID="placeholderCityName" runat="server"></asp:PlaceHolder>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblCityName" runat="server" Text='<%#Eval("CityName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%-- <asp:BoundField DataField="CityName" HeaderText="City" 
                        SortExpression="CityName" />--%>
                                    <asp:TemplateField SortExpression="OutofScore">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lblgrdOutofScore" runat="server" meta:ResourceKey="lblgrdOutofScore"
                                                CommandName="Sort" CommandArgument="OutofScore"></asp:LinkButton>
                                            <asp:PlaceHolder ID="placeholderOutofScore" runat="server"></asp:PlaceHolder>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblOutofScore" runat="server" Text='<%#Eval("OutofScore") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="OutofScore" HeaderText="OutofScore" 
                        SortExpression="OutofScore" />--%>
                                    <asp:TemplateField SortExpression="PassingScore">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lblgrdPassingScore" runat="server" meta:ResourceKey="lblgrdPassingScore"
                                                CommandName="Sort" CommandArgument="PassingScore"></asp:LinkButton>
                                            <asp:PlaceHolder ID="placeholderPassingScore" runat="server"></asp:PlaceHolder>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPassingScore" runat="server" Text='<%#Eval("PassingScore") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--  <asp:BoundField DataField="PassingScore" HeaderText="PassingScore" 
                        SortExpression="PassingScore" />--%>
                                    <asp:TemplateField SortExpression="StudentScore">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lblgrdStudentScore" runat="server" meta:ResourceKey="lblgrdStudentScore"
                                                CommandName="Sort" CommandArgument="StudentScore"></asp:LinkButton>
                                            <asp:PlaceHolder ID="placeholderStudentScore" runat="server"></asp:PlaceHolder>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblStudentScore" runat="server" Text='<%#Eval("StudentScore") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="StudentScore" HeaderText="StudentScore" 
                        SortExpression="StudentScore" />--%>
                                    <asp:TemplateField SortExpression="Result">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lblgrdResult" runat="server" meta:ResourceKey="lblgrdResult"
                                                CommandName="Sort" CommandArgument="Result"></asp:LinkButton>
                                            <asp:PlaceHolder ID="placeholderResult" runat="server"></asp:PlaceHolder>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblResult" runat="server" Text='<%#Eval("Result") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="Result" HeaderText="Result" 
                        SortExpression="Result" />--%>
                                    <asp:TemplateField SortExpression="ResultDate">
                                        <HeaderTemplate>
                                            <asp:LinkButton ID="lblgrdResultDate" runat="server" meta:ResourceKey="lblgrdResultDate"
                                                CommandName="Sort" CommandArgument="ResultDate"></asp:LinkButton>
                                            <asp:PlaceHolder ID="placeholderResultDate" runat="server"></asp:PlaceHolder>
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblResultDate" runat="server" Text='<%#Eval("ResultDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <%--<asp:BoundField DataField="ResultDate" HeaderText="ResultDate" 
                        SortExpression="ResultDate" />--%>
                                </Columns>
                                <HeaderStyle CssClass="gridHeader" />
                            </asp:GridView>
                            <%--<asp:SqlDataSource ID="sdsResult" runat="server" 
                ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" 
                SelectCommand="SELECT QR.StudentId, QR.ClassId, QR.CityId, QR.OutofScore, QR.PassingScore,
                QR.StudentScore, Result=(CASE QR.IsPassed when '1' then 'Pass' else 'Fail' end), 
                QR.ResultDate, SM.FirstName+' '+SM.LastName as StudentName, CM.CityName
                FROM QuizResult QR LEFT JOIN StudentMaster SM on QR.StudentId=SM.StudentId 
                LEFT JOIN CityMaster CM ON QR.CityId=CM.CityId
                WHERE QR.CityId=@CityId and QR.ClassId=@ClassId">
                <SelectParameters>
                    <asp:ControlParameter ControlID="ddlClass" Name="ClassId" PropertyName="SelectedValue" />
                    <asp:ControlParameter ControlID="ddl_Stage" Name="CityId" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>--%>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
