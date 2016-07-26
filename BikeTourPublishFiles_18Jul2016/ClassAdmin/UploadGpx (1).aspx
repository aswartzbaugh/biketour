<%@ page title="Bike Tour - Upload GPX File" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="Student_UploadGpx, App_Web_r5342lxs" %>

<%@ Register Src="../UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script type="text/javascript">
    function ConfirmApprove() {
        var ok = confirm(document.getElementById('<%= hdnApproveText.ClientID %>').value);
        if (ok) { return true; }
        else { return false; }
    }

    function ConfirmReject() {
        var ok = confirm(document.getElementById('<%= hdnRejectedText.ClientID %>').value);
        if (ok) { return true; }
        else { return false; }
    }

</script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <asp:HiddenField ID="hdnApproveText" runat="server" meta:ResourceKey="ApprovedText" />
    <asp:HiddenField ID="hdnRejectedText" runat="server" meta:ResourceKey="RejectedText" />

    <div class="frmBox_2">
        <table>
                <tr>
                    <td>
                        <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                    </td>
                    <td>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                        <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                            DataValueField="SchoolId" AutoPostBack="true">
                        </asp:DropDownList>
                        </ContentTemplate>
                        </asp:UpdatePanel>
                        <%--<span class="error Right">*</span>--%>
                        <asp:RequiredFieldValidator ID="rfvSchool" runat="server"
                            InitialValue="0" meta:ResourceKey="rfvSchool" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
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
                    <asp:UpdatePanel ID="upClass" runat="server">
                        <ContentTemplate>
                            <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="sds_Class" DataTextField="ClassName"
                            DataValueField="classid" AutoPostBack="true" 
                            onselectedindexchanged="ddlClass_SelectedIndexChanged">
                        </asp:DropDownList>
                        <%--<span class="error">*</span>--%>
                        <asp:RequiredFieldValidator ID="rfvClass" runat="server"  meta:ResourceKey="rfvClass"
                            InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="sds_Class" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="select 'Select class' as ClassName, '0' as classid union all 
                            select distinct scm.class as ClassName, scm.classid from  ClassAdminClasses cac inner join SchoolClassMaster scm
                            on cac.ClassId = scm.ClassId
                            where  ClassAdminId = @ClassAdminId
                            and cac.SchoolId = @SchoolId">
                            <SelectParameters>
                                <asp:SessionParameter DefaultValue="" Name="ClassAdminId" 
                                    SessionField="UserId" />
                                <asp:ControlParameter ControlID="ddlSchool" Name="schoolid" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="ddlClass" />
                        </Triggers>

                    </asp:UpdatePanel>

                        
                    </td>
                </tr>
            </table>
</div>
    <div class="container">
    <%--<h5 id="h1_ClassSchool" runat="server">Upload GPX File</h5>--%>
    <h5 id="h1_ClassSchool" runat="server"><asp:Label ID="lblClassSchool" runat="server" meta:ResourceKey="lblClassSchool"></asp:Label></h5>
    <div class="AdminContWrap">
        
        <div class="frmBox"> 
        <asp:Label ID="lblMessage" runat="server" Text=""  CssClass="CurrentStage" Visible="true"></asp:Label><br />
        <asp:FileUpload ID="fu_UploadGpx" runat="server" Visible="true" />
        <asp:Button ID="btn_Upload" runat="server" meta:ResourceKey="btn_Upload" 
            onclick="btn_Upload_Click" Visible="true" style="width:160px" />
        <div class="clear"></div></div>

        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
        <div class="SearchBox">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblSearchSpeed" runat="server" meta:ResourceKey="lblSearchSpeed"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtSearchSpeed" runat="server"></asp:TextBox>
                        <asp:FilteredTextBoxExtender ID="ftbSearchSpeed" runat="server" FilterType="Numbers"
                            TargetControlID="txtSearchSpeed">
                        </asp:FilteredTextBoxExtender>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSearch" runat="server" meta:ResourceKey="btnSearch" 
                            onclick="btnSearch_Click"/>
                        <asp:Button ID="btnClearSearch" runat="server" 
                            meta:ResourceKey="btnClearSearch" onclick="btnClearSearch_Click"/>
                    </td>
                </tr>
            </table>
        </div>
        </ContentTemplate>
        </asp:UpdatePanel>

        <div class="GridWrap">

        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>

        <asp:GridView ID="grd_Uploads" runat="server" AutoGenerateColumns="False"  Width="100%" 
            DataKeyNames="StudentUploadId" EmptyDataText="Kein Eintrag vorhanden!" AllowSorting="true" 
                                HeaderStyle-CssClass="gridHeader" onrowcommand="grd_Uploads_RowCommand" 
                                onrowdatabound="grd_Uploads_RowDataBound" onsorting="grd_Uploads_Sorting" >
            <Columns>
                <%--<asp:BoundField DataField="StudentUploadId" HeaderText="StudentUploadId" 
                    InsertVisible="False" ReadOnly="True" SortExpression="StudentUploadId" />
                <asp:BoundField DataField="StudentId" HeaderText="StudentId" 
                    SortExpression="StudentId" />
                <asp:BoundField DataField="StagePlanId" HeaderText="StagePlanId" 
                    SortExpression="StagePlanId" />--%>
                <asp:TemplateField>
                    <HeaderTemplate>
                         <asp:LinkButton ID="lblgrdUploadedFile" runat="server" meta:ResourceKey="lblgrdUploadedFile" CommandName="Sort"
                                CommandArgument="FileName"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderFileName" runat="server"></asp:PlaceHolder>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lbl_FileName" runat="server" Text='<%# Eval("FileName") %>' ></asp:Label>
                        <asp:Label ID="lbl_File" runat="server" Text='<%# Eval("FilePath") %>' Visible="false"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                 <asp:TemplateField SortExpression="StudentName">
                    <HeaderTemplate>
                         <asp:LinkButton ID="lblgrdStudentName" runat="server" meta:ResourceKey="lblgrdStudentName" CommandName="Sort"
                                CommandArgument="StudentName"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderStudentName" runat="server"></asp:PlaceHolder>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblStudentName" runat="server" Text='<%# Eval("StudentName") %>' ></asp:Label>
                    </ItemTemplate>                                                
                </asp:TemplateField>
                 <%--<asp:BoundField DataField="StudentName" HeaderText="Student Name" 
                    SortExpression="StudentName" />--%>
                <asp:TemplateField SortExpression="AddedOn">
                    <HeaderTemplate>
                        <asp:LinkButton ID="lblgrdDate" runat="server" meta:ResourceKey="lblgrdDate" CommandName="Sort"
                                CommandArgument="AddedOn"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderAddedOn" runat="server"></asp:PlaceHolder>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblDate" runat="server" Text='<%# Eval("AddedOn") %>' ></asp:Label>
                    </ItemTemplate>                                                
                </asp:TemplateField>
               <%-- <asp:BoundField DataField="AddedOn" HeaderText="Date" 
                    SortExpression="AddedOn" />--%>
                 <asp:TemplateField SortExpression="Kilometer">
                    <HeaderTemplate>
                         <asp:LinkButton ID="lblgrdDistance" runat="server" meta:ResourceKey="lblgrdDistance" CommandName="Sort"
                                CommandArgument="Kilometer"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderKilometer" runat="server"></asp:PlaceHolder>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblDistance" runat="server" Text='<%# Eval("Kilometer") %>' ></asp:Label>
                    </ItemTemplate>                                                
                </asp:TemplateField>
                <%--<asp:BoundField DataField="Kilometer" HeaderText="Distance (KM)" 
                    SortExpression="Kilometer" />--%>
                 <asp:TemplateField SortExpression="Time">
                    <HeaderTemplate>
                         <asp:LinkButton ID="lblgrdTime" runat="server" meta:ResourceKey="lblgrdTime" CommandName="Sort"
                                CommandArgument="Time"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderTime" runat="server"></asp:PlaceHolder>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblTime" runat="server" Text='<%# Eval("Time") %>' ></asp:Label>
                    </ItemTemplate>                                                
                </asp:TemplateField>
                <%--<asp:BoundField DataField="Time" HeaderText="Time (Hr)" SortExpression="Time" />--%>
               
                <%--<asp:BoundField DataField="AvgSpeed" HeaderText="Speed (KMPH)" 
                    SortExpression="AvgSpeed" />--%>
                <asp:TemplateField SortExpression="AvgSpeed">
                    <HeaderTemplate>
                        <asp:LinkButton ID="lblgrdAvgSpeed" runat="server" meta:ResourceKey="lblgrdAvgSpeed" CommandName="Sort"
                                CommandArgument="AvgSpeed"></asp:LinkButton>
                            <asp:PlaceHolder ID="placeholderAvgSpeed" runat="server"></asp:PlaceHolder>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblAvgSpeed" runat="server" Text='<%# Eval("AvgSpeed") %>' ></asp:Label>
                    </ItemTemplate>                                                
                </asp:TemplateField>
                 <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label ID="lblgrdDownload" runat="server" meta:ResourceKey="lblgrdDownload"></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                       <a target="_blank" href='<%# "../GPXFiles/" + Eval("SchoolId") + "/" + Eval("ClassId") + "/" + Eval("StudentId") + "/" + Eval("FileName") %>' id="GpxDownload" runat="server">
                           <asp:Label ID="lblGpx" runat="server" Text='<%# Eval("FileName") %>'></asp:Label>
                       </a> 
                    </ItemTemplate>
                </asp:TemplateField>
                <%--<asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label ID="lblgrdStatus" runat="server" meta:ResourceKey="lblgrdStatus"></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chk_Approved" runat="server"  Checked='<%# Eval("IsValid") %>' />
                        <asp:Label ID="lbl_UploadId" runat="server" Text='<%# Eval("StudentUploadId") %>' Visible="false"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>--%>

                <asp:TemplateField>
                    <HeaderTemplate>
                        <asp:Label ID="lblStatus" runat="server" meta:ResourceKey="lblgrdStatus"></asp:Label>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <asp:Label ID="lblApprovalStatus" runat="server" Text='<%# GetApproveStatusText(Eval("ApprovedStatus")) %>' Visible='<%# GetApprovalStatusVisibility(Eval("IsValid")) %>'></asp:Label>
                        <div runat="server" id="dvBtns" visible='<%# GetBtnsVisibility(Eval("IsValid")) %>'>
                        <table style="border:0px !important;">
                            <tr>
                                <td>
                                                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnApprove" />
                            </Triggers>
                                <ContentTemplate>
                                
                        <asp:ImageButton ID="btnApprove" runat="server" ImageUrl="~/_images/IsApprowal.png" OnClientClick="return ConfirmApprove();" meta:ResourceKey="ApproveText" CommandArgument='<%# Eval("StudentUploadId") %>'
                            onclick="btnApprove_Click" />
                            </ContentTemplate>
                            </asp:UpdatePanel>
                                </td>
                                <td>
                                 <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                            <Triggers>
                                <asp:PostBackTrigger ControlID="btnReject" />
                            </Triggers>
                                <ContentTemplate>
                        <asp:ImageButton ID="btnReject" runat="server" ImageUrl="~/_images/IsNotApprowal.png" OnClientClick="return ConfirmReject();" meta:ResourceKey="RejectText" CommandArgument='<%# Eval("StudentUploadId") %>' 
                            onclick="btnReject_Click" />
                            </ContentTemplate>
                            </asp:UpdatePanel>
                                </td>
                            </tr>
                        </table>


                           
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>


            </Columns>
            <HeaderStyle CssClass="gridHeader" />
        </asp:GridView>
        </ContentTemplate>
        </asp:UpdatePanel>

        <asp:Button ID="btn_SaveGrid" runat="server" meta:ResourceKey="btn_SaveGrid" onclick="btn_SaveGrid_Click"  style="display:none;"  />
        <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" onclick="btn_Cancel_Click" />

       <%-- <asp:SqlDataSource ID="sds_Uploads" runat="server" 
            ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" 
            SelectCommand="SP_GET_STUDENT_UPLOADS" SelectCommandType="StoredProcedure" 
                onselecting="sds_Uploads_Selecting">
            <SelectParameters>
                <asp:SessionParameter DefaultValue="0" Name="RoleId" SessionField="UserRoleId" 
                    Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="StudentId" Type="Int32" />
                <asp:SessionParameter DefaultValue="0" Name="ClassAdminId" 
                    SessionField="UserId" Type="Int32" />
                <asp:ControlParameter ControlID="ddlClass" DefaultValue="0" Name="ClassId" 
                    PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>--%>
        </div>
        <br />
        <%--<asp:Button ID="btn_ReadGpx" runat="server" Text="Read" 
            onclick="btn_ReadGpx_Click" />--%>

        <div id="div_GpxMap" runat="server" visible="false">
            <%--<h2>File Name: <asp:Label ID="lblJourny" runat="server" Text=""></asp:Label></h2><br />--%>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblFileName" runat="server" meta:ResourceKey="lblFileName"></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="lblJourny" runat="server" Text=""></asp:Label>
                    </td>
                </tr>
            </table>
            <uc1:GoogleMapForASPNet ID="GoogleMapForASPNet1" runat="server" />
        </div>

    </div>
</div>
</asp:Content>

