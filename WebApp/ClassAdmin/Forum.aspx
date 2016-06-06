<%@ Page Title="Bike Tour - Forum" Culture="de-DE" UICulture="de-DE" Language="C#"
    MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true" CodeFile="Forum.aspx.cs" EnableEventValidation="false"
    Inherits="ClassAdmin_Forum" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        //        $(document).ready(function () { $("[id$=btnSubmit]").hide(); });
        //        function verifyCode(code) {
        //            $("[id$=btnSubmit]").trigger("click");
        //        }
        function Confirm(obj) {

            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=hdnBlogId]").val(obj);
                $("[id$=btnDelete]").trigger("click");
                return true;
            }
            else {
                return false;
            }
        }

        function isEmptyBlog() {
            if (document.getElementById('<%= txtBlog.ClientID %>').value == '')
                return false;
            else
                return true;
        }

        function ScrollPosition() {
            
            if (document.getElementById('<%= hdnScrollPosition.ClientID %>').value != "") {
                var scrollpos = parseInt(document.getElementById('<%= hdnScrollPosition.ClientID %>').value);
                var $t = $('#div_Comments');
                $t.animate({ "scrollTop": scrollpos }, 0);
            } else {
                var $t = $('#div_Comments');
                $t.animate({ "scrollTop": 0 }, 0);
            }

            $("#div_Comments").scroll(function () {
                var currentScroll = $(this).scrollTop();
                document.getElementById('<%= hdnScrollPosition.ClientID %>').value = currentScroll;
                previousScroll = currentScroll;
            });
        }
        
        var previousScroll = 0;

        $(window).load(function () {
            $("#div_Comments").scroll(function () {
                var currentScroll = $(this).scrollTop();
                document.getElementById('<%= hdnScrollPosition.ClientID %>').value = currentScroll;
                previousScroll = currentScroll;
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:HiddenField ID="hdnBlogId" runat="server" />
    <asp:HiddenField ID="divPosition" runat="server" />
    <asp:HiddenField ID="hdnScrollPosition" runat="server" Value="0" />
    <asp:Button ID="btnDelete" runat="server" Text="" OnClick="btnDelete_Click" CssClass="hide" />
    <asp:Timer ID="BlogRefreshTimer" runat="server" Interval="10000" OnTick="BlogRefreshTimer_Tick">
    </asp:Timer>

    <div class="frmBox_2">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                    </td>
                    <td>
                        <asp:UpdatePanel ID="Up_ddlSchool" runat="server">
                            <ContentTemplate>
                                <asp:DropDownList ID="ddlSchool" runat="server" DataSourceID="sdsSchool" DataTextField="School"
                                    DataValueField="SchoolId" AutoPostBack="true" OnSelectedIndexChanged="ddlSchool_SelectedIndexChanged">
                                </asp:DropDownList>
                               
                                <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="SELECT '0' as [SchoolId], ' Schule' as [School] union all 
                                           select distinct sm.SchoolId, sm.School from ClassAdminClasses cac inner join SchoolMaster sm
                                           on cac.SchoolId = sm.SchoolId
                                            where ClassAdminId = @ClassAdminId">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="ClassAdminId" SessionField="UserId" DefaultValue="" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </ContentTemplate>
                            <%-- <Triggers> 
                        <asp:PostBackTrigger ControlID="ddlSchool" />
                        </Triggers>--%>
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
                                
                                <asp:SqlDataSource ID="sds_Class" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="select ' Klasse' as ClassName, '0' as classid union all 
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
                            <Triggers>
                                <asp:PostBackTrigger ControlID="ddlClass" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                </tr>
            </table>
        </div>
    <div class="container">
    <h5 id="h1_ClassForum" runat="server">
        </h5>
    <div class="AdminContWrap">
        
        
        <asp:Panel ID="pnlContent" runat="server" Visible="false">
            <table width="100%">
                <tr>
                    <td valign="top" style="width:30%">
                    <div class="rankswrapper">
                <asp:UpdatePanel ID="Up_dlScoreBoard" runat="server">
                    <ContentTemplate>
                        <asp:DataList ID="dlScoreBoard" runat="server" Width="100%" DataSourceID="sdsScoreBoard">
                            <ItemTemplate>
                                <div class="rankss">
                                    <asp:Label ID="lblHighScoreText" runat="server" meta:ResourceKey="lblHighScoreText" CssClass="color size"></asp:Label>
                                    <br />
                                    <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                    <asp:Label ID="lblHighScore" CssClass="color" runat="server" Text='<%#Eval("HighScore") %>'></asp:Label>
                                </div>
                                <div class="rankss">
                                <asp:Label ID="lblLeadingClassText" runat="server" meta:ResourceKey="lblLeadingClassText" CssClass="color size"></asp:Label>
                                    <br />
                                    <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                    <asp:Label ID="lblLeadingClass" runat="server" CssClass="color" Text='<%#Eval("LeadingClass") %>'></asp:Label>
                                </div>
                                <div class="rankss">
                                 <asp:Label ID="lblRankAboveText" runat="server" meta:ResourceKey="lblRankAboveText" CssClass="color size"></asp:Label>
                                    <br />
                                    <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                    <span class="color">
                                        <%#"# " + Eval("OneAboveRank")%></span><br />
                                    <asp:Label ID="lblRankAbove" runat="server" CssClass="color" Text='<%#Eval("OneAboveClass") + " - " + Eval("OneAbovescore") %>'></asp:Label>
                                </div>
                                <div class="rankss">
                                <asp:Label ID="lblOwnRankText" runat="server" meta:ResourceKey="lblOwnRankText" CssClass="color size"></asp:Label>
                                    <br />
                                    <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                    <asp:Label ID="lblOwnRank" runat="server" CssClass="color" Text='<%#"# "+Eval("OwnRank") + " - " + Eval("OwnScore") %>'></asp:Label>
                                </div>
                                <div class="rankss">
                                 <asp:Label ID="lblRankBelowText" runat="server" meta:ResourceKey="lblRankBelowText" CssClass="color size"></asp:Label>
                                   <br />
                                    <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                    <span class="color">
                                        <%#"# " + Eval("onebelowrank")%></span><br />
                                    <asp:Label ID="lblRankBelow" runat="server" CssClass="color" Text='<%#Eval("onebelowclass") + " - " + Eval("Onebelowscore") %>'></asp:Label>
                                </div>
                            </ItemTemplate>
                        </asp:DataList>
                        <asp:SqlDataSource ID="sdsScoreBoard" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                            SelectCommand="SP_GET_SCOREBOARD" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:Parameter DefaultValue="all" Name="Action" Type="String" />
                                <asp:Parameter DefaultValue="0" Name="UserId" Type="Int32" />
                                <asp:Parameter DefaultValue="0" Name="UserRoleId" Type="Int32" />
                                <asp:ControlParameter ControlID="ddlClass" Name="ClassId" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="btndiv">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:UpdatePanel ID="Up_lbtnUpload" runat="server">
                                    <ContentTemplate>
                                        <asp:Button ID="lbtnUpload" runat="server" meta:ResourceKey="lbtnUpload" CssClass="glbtn"
                                            OnClick="lbtnUpload_Click" />
                                    </ContentTemplate>
                                    <%-- <Triggers>
                                    <asp:PostBackTrigger ControlID="lbtnUpload" />
                                    </Triggers>--%>
                                </asp:UpdatePanel>
                            </td>
                        
                            <td>
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:LinkButton ID="lbtnCityInfo" runat="server" meta:ResourceKey="lbtnCityInfo"
                                            CssClass="glbtn" PostBackUrl="" Visible="false"></asp:LinkButton>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="lbtnCityInfo" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
                   </td>
                    <td valign="top">
<div class="">

    <div class="currentstagewrap">
        <table border="0" cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="3" align="center">
                    <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblCongratulations1" CssClass="Current " runat="server" meta:ResourceKey="lblCongratulations1"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <asp:Label ID="lblCongratulations2" CssClass="Currentcity " runat="server" Text=""></asp:Label>
                                <asp:Label ID="lblCongratulations3" CssClass="Currentcity" runat="server" Text="!"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Image ID="imgFromCity" runat="server" Height="160px" Width="200px" CssClass="left"
                        AlternateText="No Image" />
                </td>
                <td>
                    <h2 align="center">
                        <asp:Label ID="lblStage" runat="server" CssClass="CurrentStages" meta:ResourceKey="lblStage"></asp:Label>
                        <asp:Label ID="lblCurrentStage" runat="server" CssClass="CurrentStage" Text=""></asp:Label>
                        <asp:Label ID="lblDistanceCovered" runat="server" CssClass="CurrentStage1" Text=""></asp:Label>
                    </h2>
                </td>
                <td>
                    <asp:Image ID="imgToCity" runat="server" Height="160px" Width="200px" CssClass="Right"
                        AlternateText="No Image" />
                </td>
            </tr>
        </table>
        <br />
        <div class="clear">
        </div>
        <div class="clear">
        </div>
    </div>
                <div class="clear">
                </div>
    <div class="mapwrapper">
        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="false">
            <ContentTemplate>
                <uc1:GoogleMapForASPNet ID="GoogleMapForASPNet1" runat="server" />
            </ContentTemplate>
            <Triggers>
                <asp:PostBackTrigger ControlID="GoogleMapForASPNet1" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
            </div>
            <div class="clear">
            </div>
            

                    </td>
                </tr>
            </table>
            
            
        </asp:Panel>

        <div runat="server" id="div_NoStagePlan" visible="false" >
            <h3>
                <asp:Label ID="Label1" runat="server" meta:ResourceKey="Label1"></asp:Label>
            </h3>
        </div>
        <div class="clear">
        </div>
        <div runat="server" id="divForumBlog" class="rightcol" style="width:700px;">
            <div class="frmBox">

                 <h5><asp:Label ID="lblClassBlog" runat="server" meta:ResourceKey="lblClassBlog" CssClass="Left"></asp:Label>
                 <div class="right"><asp:UpdateProgress ID="UpdateProgressToBlog" runat="server" AssociatedUpdatePanelID="UpdatePanelBlog">
                                <ProgressTemplate>
                                    <asp:Image ID="ImageLoading" runat="server" ImageUrl="~/_images/ajax_loader_blue_32.gif"
                                        CssClass="loader" />
                                </ProgressTemplate>
                            </asp:UpdateProgress></div></h5>
               
                <br />
                <asp:UpdatePanel ID="UpdatePanelBlog" runat="server" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="BlogRefreshTimer" EventName="Tick" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:Timer ID="Timer1" runat="server" Interval="40000" OnTick="BlogRefreshTimer_Tick">
                        </asp:Timer>
                        <div id="div_Comments" class="scroll">
                            <asp:DataList ID="dlBlog" runat="server" DataSourceID="sdsForum" Width="100%" CssClass="datalist"
                                DataKeyField="BlogId" OnCancelCommand="dlBlog_CancelCommand" OnEditCommand="dlBlog_EditCommand"
                                OnUpdateCommand="dlBlog_UpdateCommand">
                                <EditItemTemplate>
                                <div style="border-bottom: thin dashed #CCCCCC;">
                                    <table>
                                        <tr>
                                            <td style="min-width:210px;vertical-align:top;">
                                                 <div class="name">
                                                    <asp:Label ID="lblBlogBy" runat="server" Text='<%# Eval("BlogWrittenBy") %>' CssClass="GlbLblh"></asp:Label>
                                                    <asp:Label ID="lblBlogInfo" runat="server" Text='<%# Eval("SchoolName") + "," + Eval("ClassName") + "wrote:" %>'></asp:Label>
                                                </div>
                                            </td>
                                            <td style="vertical-align:top; padding-top:5px;">
                                                <div class="bolgsms">
                                                    <asp:TextBox ID="txtBlogTextEdit" runat="server" Text='<%# Eval("blogtext") %>' CssClass="blog" TextMode="MultiLine" Rows="2" Columns="50"></asp:TextBox>
                                                </div>
                                            </td>
                                            <td style="vertical-align:top; padding-top:2px;">
                                                <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="update" meta:ResourceKey="lnkUpdate">  
                      
                                                </asp:LinkButton>
                                            </td>
                                            <td style="vertical-align:top; padding-top:2px;">
                                                <asp:LinkButton ID="lnkCancel" runat="server" CommandName="cancel" meta:ResourceKey="lnkCancel">  
                      
                                                </asp:LinkButton>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                </EditItemTemplate>
                                <ItemTemplate>
                                <div style="border-bottom: thin dashed #CCCCCC;">
                                    <table>
                                        <tr>
                                            <td style="min-width:210px;vertical-align:top;">
                                                <div class="name">
                                                    <asp:Label ID="lblBlogBy" runat="server" Text='<%# Eval("BlogWrittenBy") %>' CssClass="GlbLblh"></asp:Label>
                                                    <asp:Label ID="lblBlogInfo" runat="server" Text='<%# Eval("SchoolName") + "," + Eval("ClassName") + "wrote:" %>'></asp:Label>
                                                </div>
                                            </td>
                                            <td style="vertical-align:top; padding-top:5px;">
                                                <div class="bolgsms">
                                                    <span class="blog">
                                                        <%# Eval("blogtext") %></span>
                                                </div>
                                            </td>
                                            <td style="vertical-align:top; padding-top:2px; margin:0px !important;">
                                                <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("BlogId") %>' CommandName="Edit"
                                                    CssClass="grdedit" ToolTip="bearbeiten" style="margin:0px !important;"/>
                                            </td>
                                            <td style="vertical-align:top; padding-top:2px;">
                                                <input type="button" id="but1" class="grddel" title="löschen" onclick="Confirm('<%# Eval("BlogId") %>')"
                                                    title="" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                </ItemTemplate>
                            </asp:DataList>
                            <div class="clear">
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:SqlDataSource ID="sdsForum" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                    SelectCommand="" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                <br />
                <div id="div_CommnetBox">
                    <table>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="lbl_Comment" runat="server" meta:ResourceKey="lbl_Comment"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txtBlog" runat="server" AutoPostBack="false" Columns="50" CssClass="gltxt"
                                    Rows="3" TextMode="MultiLine"></asp:TextBox><br />
                                      <%-- <span class="error">*</span>--%>
                                     <asp:RequiredFieldValidator ID="rfvBlog" runat="server" ValidationGroup="SubmitMessage" 
                                  ErrorMessage="Please enter comment" CssClass="error" ControlToValidate="txtBlog" meta:ResourceKey="rfvBlog">
                                                    </asp:RequiredFieldValidator>
                            </td>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkShowOnForum" runat="server" meta:ResourceKey="chkShowOnForum" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:UpdatePanel ID="Up_btnSubmit" runat="server">
                                                <ContentTemplate>
                                                <%--OnClientClick="return isEmptyBlog();"--%>
                                                    <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" meta:ResourceKey="btnSubmit" ValidationGroup="SubmitMessage"  />
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:PostBackTrigger ControlID="btnSubmit" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                                
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <div class="clear">
        </div>
    </div>
</div>
</asp:Content>
