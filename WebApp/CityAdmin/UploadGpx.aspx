<%@ Page Title="Bike Tour - Upload GPX File" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="UploadGpx.aspx.cs"
    Inherits="Student_UploadGpx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>

        <asp:HiddenField ID="hdnApproveText" runat="server" meta:ResourceKey="ApprovedText" />
    <asp:HiddenField ID="hdnRejectedText" runat="server" meta:ResourceKey="RejectedText" />
    <div class="frmBox_2">
        <table>
            <tr>
                <td>
                    <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                </td>
                <td>
                    <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                        DataValueField="SchoolId" AutoPostBack="true">
                    </asp:DropDownList>
                    <span class="error">*</span>
                    <asp:RequiredFieldValidator ID="rfvSchool" runat="server" meta:ResourceKey="rfvSchool"
                        InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                        CssClass="error" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                        SelectCommand="SELECT '0' as [SchoolId], 'Select School' as [School] union all select sm.SchoolId, sm.School from schoolmaster sm
                                           where sm.IsActive=1
                                           and sm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId)
                                               ">
                        <SelectParameters>
                            <asp:SessionParameter Name="CityAdminId" SessionField="UserId" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td>
                    <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass"></asp:Label>
                </td>
                <td>
                    <asp:UpdatePanel ID="upClass" runat="server">
                        <contenttemplate>
                            <asp:DropDownList ID="ddlClass" runat="server" DataSourceID="sds_Class" DataTextField="Class"
                            DataValueField="classid" AutoPostBack="true" 
                            onselectedindexchanged="ddlClass_SelectedIndexChanged">
                        </asp:DropDownList>
                        <span class="error">*</span>
                        <asp:RequiredFieldValidator ID="rfvClass" runat="server" meta:ResourceKey="rfvClass"
                            InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                            Display="Dynamic"></asp:RequiredFieldValidator>
                        <asp:SqlDataSource ID="sds_Class" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>" 
                            SelectCommand="SP_GET_DISTINCT_CLASSES" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="0" Name="ClassAdminId" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlSchool" DefaultValue="0" Name="SchoolId" 
                                    PropertyName="SelectedValue" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>

                        </contenttemplate>
                        <triggers>
                            <asp:PostBackTrigger ControlID="ddlClass" />
                        </triggers>
                    </asp:UpdatePanel>
                </td>
            </tr>
        </table>
    </div>
    <div class="container">
        <h5 id="h1_ClassSchool" runat="server">
            <asp:Label ID="lblUploadGPX" runat="server" meta:ResourceKey="lblUploadGPX"></asp:Label></h5>
        <div class="AdminContWrap">
            <div class="frmBox">
                <asp:Label ID="lblMessage" runat="server" Text="" CssClass="CurrentStage" Visible="false"></asp:Label><br />
                <asp:FileUpload ID="fu_UploadGpx" runat="server" />
                <asp:Button ID="btn_Upload" runat="server" meta:ResourceKey="btn_Upload" OnClick="btn_Upload_Click" />
                <div class="clear">
                </div>
            </div>

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

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="GridWrap">
                <asp:GridView ID="grd_Uploads" runat="server" AutoGenerateColumns="False" Width="100%"
                    DataKeyNames="StudentUploadId" DataSourceID="sds_Uploads" EmptyDataText="Kein Eintrag vorhanden!"
                    AllowSorting="true" HeaderStyle-CssClass="gridHeader">
                    <Columns>
                        <%--<asp:BoundField DataField="StudentUploadId" HeaderText="StudentUploadId" 
                    InsertVisible="False" ReadOnly="True" SortExpression="StudentUploadId" />
                <asp:BoundField DataField="StudentId" HeaderText="StudentId" 
                    SortExpression="StudentId" />
                <asp:BoundField DataField="StagePlanId" HeaderText="StagePlanId" 
                    SortExpression="StagePlanId" />--%>
                        <asp:TemplateField HeaderText="Uploaded File">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdUploadedFile" runat="server" meta:ResourceKey="lblgrdUploadedFile"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lbl_FileName" runat="server" Text='<%# Eval("FileName") %>'></asp:Label>
                                <asp:Label ID="lbl_File" runat="server" Text='<%# Eval("FilePath") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="StudentName" HeaderText="Student Name" 
                    SortExpression="StudentName" />--%>
                        <asp:TemplateField HeaderText="StudentName" SortExpression="StudentName">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdStudentName" runat="server" meta:ResourceKey="lblgrdStudentName"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblStudentNamegrd" runat="server" Text='<%# Eval("StudentName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="AddedOn" HeaderText="Date" 
                    SortExpression="AddedOn" />--%>
                        <asp:TemplateField HeaderText="Date" SortExpression="AddedOn">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdDate" runat="server" meta:ResourceKey="lblgrdDate"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblDate" runat="server" Text='<%# Eval("AddedOn") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:BoundField DataField="Kilometer" HeaderText="Distance" 
                    SortExpression="Kilometer" />--%>
                        <asp:TemplateField HeaderText="Kilometer" SortExpression="Kilometer">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdKilometer" runat="server" meta:ResourceKey="lblgrdKilometer"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblKilometer" runat="server" Text='<%# Eval("Kilometer") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%-- <asp:BoundField DataField="Time" HeaderText="Time" SortExpression="Time" />--%>
                        <asp:TemplateField HeaderText="Time" SortExpression="Time">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdTime" runat="server" meta:ResourceKey="lblgrdTime"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblTime" runat="server" Text='<%# Eval("Time") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

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

                        <asp:TemplateField HeaderText="Download">
                            <HeaderTemplate>
                                <asp:Label ID="lblgrdDownload" runat="server" meta:ResourceKey="lblgrdDownload"></asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <a target="_blank" href='<%# "../GPXFiles/" + Eval("SchoolId") + "/" + Eval("ClassId") + "/" + Eval("StudentId") + "/" + Eval("FileName") %>'
                                    id="GpxDownload" runat="server">
                                    <asp:Label ID="lblGpx" runat="server" Text='<%# Eval("FileName") %>'></asp:Label>
                                </a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText="Status">
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
                </asp:GridView>
                <asp:Button ID="btn_SaveGrid" runat="server" meta:ResourceKey="btn_SaveGrid" OnClick="btn_SaveGrid_Click" style="display:none;" />
                <asp:Button ID="btn_Cancel" runat="server" meta:ResourceKey="btn_Cancel" OnClick="btn_Cancel_Click" />
                <asp:SqlDataSource ID="sds_Uploads" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                    SelectCommand="SP_GET_STUDENT_UPLOADS" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:SessionParameter DefaultValue="0" Name="RoleId" SessionField="UserRoleId" Type="Int32" />
                        <asp:Parameter DefaultValue="0" Name="StudentId" Type="Int32" />
                        <asp:SessionParameter DefaultValue="0" Name="ClassAdminId" SessionField="UserId"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="ddlClass" DefaultValue="0" Name="ClassId" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:ControlParameter ControlID="txtSearchSpeed" DefaultValue="0" Name="Speed" PropertyName="Text"
                            Type="Double" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
            </ContentTemplate>
            </asp:UpdatePanel>
            <br />
            <%--<asp:Button ID="btn_ReadGpx" runat="server" Text="Read" 
            onclick="btn_ReadGpx_Click" />--%>
        </div>
    </div>
</asp:Content>
