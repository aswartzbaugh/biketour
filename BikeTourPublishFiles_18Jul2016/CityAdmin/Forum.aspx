<%@ page title="Bike Tour - Forum" culture="de-DE" uiculture="de-DE" language="C#" enableeventvalidation="false" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="ClassAdmin_Forum, App_Web_g31xiaah" %>

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


        function ConfirmAll() {
            var Ok = confirm('Wollen Sie löschen?');
            if (Ok) {
                $("[id$=btnDeleteAll]").trigger("click");
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
    <style type="text/css">
        #GoogleMap_Div {
            width: 700px !important;
        }
    </style>
</asp:Content>
<asp:content id="Content2" contentplaceholderid="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="Up_hidden" runat="server">
        <ContentTemplate>
            <asp:HiddenField ID="hdnBlogId" runat="server" />
            <asp:HiddenField ID="divPosition" runat="server" />
            <asp:HiddenField ID="hdnScrollPosition" runat="server" Value="0" />
            <asp:Button ID="btnDelete" runat="server" Text="" OnClick="btnDelete_Click" CssClass="hide" />
            <asp:Timer ID="BlogRefreshTimer" runat="server" Interval="10000" OnTick="BlogRefreshTimer_Tick">
            </asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>
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
                                <span class="error">*</span>
                                <asp:RequiredFieldValidator ID="rfvSchool" runat="server"
                                    InitialValue="0" ControlToValidate="ddlSchool" ValidationGroup="SubmitClass"
                                    CssClass="error" Display="Dynamic" meta:ResourceKey="rfvSchool"></asp:RequiredFieldValidator>
                                <asp:SqlDataSource ID="sdsSchool" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="SELECT '0' as [SchoolId], ' Schule' as [School] union all select sm.SchoolId, sm.School from schoolmaster sm
                                           where sm.IsActive=1
                                           and sm.CityId in(select CityId from CityAdminCities where CityAdminId=@CityAdminId)">
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
                                    DataValueField="ClassId" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged">
                                </asp:DropDownList>
                                <span class="error">*</span>
                                <asp:SqlDataSource ID="sdsClass" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="SP_GET_DISTINCT_CLASSES" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="0" Name="ClassAdminId" Type="Int32" />
                                        <asp:ControlParameter ControlID="ddlSchool" DefaultValue="0" Name="SchoolId"
                                            PropertyName="SelectedValue" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>



                                <asp:RequiredFieldValidator ID="rfvClass" runat="server"
                                    InitialValue="0" ControlToValidate="ddlClass" ValidationGroup="SubmitClass" CssClass="error"
                                    Display="Dynamic" meta:ResourceKey="rfvClass"></asp:RequiredFieldValidator>

                            </ContentTemplate>
                            <Triggers>
                                <asp:PostBackTrigger ControlID="ddlClass" />
                            </Triggers>
                        </asp:UpdatePanel>
                    </td>
                    <td>  <div id="div_ButtonList" runat="server">
                         <asp:Button ID="btnDeleteAll" runat="server"   Text="" ToolTip="löschen" CssClass="hide" Style="display: none;" OnClick="btnDeleteAll_Click" />        
        
                <asp:Button ID="btnDeleteAllBlogs" runat="server"  meta:ResourceKey="btn_DeleteAllBlogs" OnClick="btnDeleteAllBlogs_Click" Visible="False" Width="240px"    />
            </div></td>
                </tr>
            </table>
        </div>
    <div class="container">
    <h5 id="h1_ClassForum" runat="server"></h5>
    <div class="AdminContWrap">
        
        <div class="line"></div>
        <asp:Panel ID="pnlContent" runat="server" Visible="false">
            <table width="100%">
                <tr>
                    <td style="width: 30%" valign="top">
                        <div class="rankswrapper">
                            <asp:UpdatePanel ID="Up_dlScoreBoard" runat="server">
                                <ContentTemplate>
                                    <asp:DataList ID="dlScoreBoard" Width="100%" runat="server" DataSourceID="sdsScoreBoard">
                                        <ItemTemplate>
                                            <div class="rankss">
                                                <asp:Label ID="lblHighScoreText" CssClass="color size" runat="server" meta:ResourceKey="lblHighScoreText"></asp:Label>
                                                <%--<span class="color size">High score</span>--%><br />
                                                <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                                <asp:Label ID="lblHighScore" CssClass="color" runat="server" Text='<%#Eval("HighScore") %>'></asp:Label>
                                            </div>
                                            <div class="rankss">
                                                <asp:Label ID="lblLeadingClassText" CssClass="color size" runat="server" meta:ResourceKey="lblLeadingClassText"></asp:Label>
                                                <%--<span class="color size">Leading class</span>--%><br />
                                                <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                                <asp:Label ID="lblLeadingClass" runat="server" CssClass="color" Text='<%#Eval("LeadingClass") %>'></asp:Label>
                                            </div>
                                            <div class="rankss">
                                                <asp:Label ID="lblClassAboveText" CssClass="color size" runat="server" meta:ResourceKey="lblClassAboveText"></asp:Label>
                                                <%--<span class="color size">One Class Above</span>--%><br />
                                                <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                                <span class="color"><%#"# " + Eval("OneAboveRank")%></span><br />

                                                <asp:Label ID="lblRankAbove" runat="server" CssClass="color" Text='<%#Eval("OneAboveClass") + " - " + Eval("OneAbovescore") %>'></asp:Label>
                                            </div>
                                            <div class="rankss">
                                                <asp:Label ID="lblOwnRankText" CssClass="color size" runat="server" meta:ResourceKey="lblOwnRankText"></asp:Label>
                                                <%--<span class="color size">Own class position</span>--%><br />
                                                <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                                <asp:Label ID="lblOwnRank" runat="server" CssClass="color" Text='<%#"# "+Eval("OwnRank") + " - " + Eval("OwnScore") %>'></asp:Label>
                                            </div>
                                            <div class="rankss">
                                                <asp:Label ID="lblRankBelowText" CssClass="color size" runat="server" meta:ResourceKey="lblRankBelowText"></asp:Label>
                                                <%--<span class="color size">One Class Below</span>--%><br />
                                                <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                                <span class="color"><%#"# " + Eval("onebelowrank")%></span><br />

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
                                <table>
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
                               
                              
                                  <div class="clear"></div>
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                <td align="center" colspan="3">
                                 <div class="Centertext">
                                   <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
                                        <tr>
                                            <td align="center">
                                            <asp:Label ID="lblCongratulations1" CssClass="Current " runat="server" meta:ResourceKey="lblCongratulations1"></asp:Label>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td align="center">
                                             <asp:Label ID="lblCongratulations2" CssClass="Currentcity " runat="server" Text=""></asp:Label> 
                                 <asp:Label ID="lblCongratulations3" CssClass="Currentcity" runat="server" meta:ResourceKey="lblCongratulations3"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                
                               
                                    </div>
                                  
                                
                                </td>
                                
                                </tr>
                                    <tr>
                                        <td>
                                         <asp:Image ID="imgFromCity" runat="server" Height="160px" Width="200px" 
                                          AlternateText="No Image" /> 
                                        </td>
                                        <td>
                                        <h2 align="center">
                                         <asp:Label ID="lblStage" runat="server" CssClass="CurrentStages"></asp:Label>
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

                                
                            </div>
                         
                            <div class="clear"></div>
                            <br />
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
                <asp:Label ID="Label1" runat="server" Text="Es tut uns leid! Keine Stufen-Plan Erstellt!" meta:ResourceKey="Label1"></asp:Label>
            </h3>
        </div>
        <div class="clear">
        </div>

        <div runat="server" id="divForumBlog" class="rightcol" style="width:700px;">
        <div class="frmBox">
                        <div class="chat">
                            
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
                                    <%--<asp:AsyncPostBackTrigger ControlID="BlogRefreshTimer" EventName="Tick" />--%>
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
                                                                <asp:Label ID="lblBlogBy" runat="server" Text='<%# Eval("BlogWrittenBy") %>'
                                                                    CssClass="GlbLblh"></asp:Label>
                                                                    <asp:Label ID="lblBlogInfo" runat="server" Text='<%# Eval("SchoolName") + "," + Eval("ClassName") + "wrote:" %>'></asp:Label>
                                                            </div>
                                                        </td>
                                                        <td style="vertical-align:top; padding-top:5px;">
                                                            <div class="bolgsms" >
                                                                <asp:TextBox ID="txtBlogTextEdit" runat="server" Text='<%# Eval("blogtext") %>' CssClass="blog" TextMode="MultiLine" Rows="2" Columns="40"></asp:TextBox>
                                                            </div>
                                                        </td>
                                                        <td style="vertical-align:top; padding-top:2px;">
                                                            <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="update" Text="aktualisieren">  
                      
                                                            </asp:LinkButton>
                                                        </td>
                                                        <td style="vertical-align:top; padding-top:2px;">
                                                            <asp:LinkButton ID="lnkCancel" runat="server" CommandName="cancel" Text="stornieren">  
                      
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
                                                                <asp:Label ID="lblBlogBy" runat="server" Text='<%# Eval("BlogWrittenBy") %>'
                                                                    CssClass="GlbLblh"></asp:Label>
                                                                    <asp:Label ID="lblBlogInfo" runat="server" Text='<%# Eval("SchoolName") + "," + Eval("ClassName") + "wrote:" %>'></asp:Label>
                                                            </div>
                                                        </td>
                                                        <td style="vertical-align:top; padding-top:5px;">
                                                            <div class="bolgsms">
                                                                <span class="blog">
                                                                    <%# Eval("blogtext") %></span>
                                                            </div>
                                                        </td>
                                                        <td style="vertical-align:top; padding-top:2px;">
                                                            <asp:Button ID="btnEdit" runat="server" CommandArgument='<%# Eval("BlogId") %>' CommandName="Edit"
                                                                CssClass="grdedit" ToolTip="bearbeiten" style="margin:0px !important;"/>
                                                        </td>
                                                        <td style="vertical-align:top; padding-top:2px; margin:0px !important;">
                                                            <input type="button" id="but1" class="grddel" title="löschen" onclick="Confirm('<%# Eval("BlogId") %>    ')"
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
                                SelectCommand="SP_GET_FORUMBLOG" SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:SessionParameter Name="UserId" SessionField="UserId" Type="Int32" />
                                    <asp:SessionParameter Name="UserRoleId" SessionField="UserRoleId" Type="Int32" />
                                    <asp:ControlParameter ControlID="ddlClass" DefaultValue="0" Name="ClassId"
                                        PropertyName="SelectedValue" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>


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
                                            <asp:TextBox ID="txtBlog" runat="server" AutoPostBack="false" Columns="50" Width="670px" Height="100px" CssClass="gltxt"
                                                Rows="3" TextMode="MultiLine"></asp:TextBox>
                                                <%--<span class="error">*</span>--%>
                                                
                                            <asp:RequiredFieldValidator ID="rfvBlog" runat="server" ValidationGroup="SubmitMessage" 
                                                        ErrorMessage="Please enter comment" CssClass="error" ControlToValidate="txtBlog" meta:ResourceKey="rfvBlog">
                                                    </asp:RequiredFieldValidator>
                                       <div class="clear"></div>

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
                                                                <%--OnClientClick="return isEmptyBlog();" --%>
                                                                <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" meta:ResourceKey="btnSubmit"
                                                                    ValidationGroup="SubmitMessage" />
                                                                <%--<asp:RequiredFieldValidator ID="rfvBlogMessage" runat="server" ValidationGroup="SubmitMessage" 
                                                        ErrorMessage="Please enter message" ControlToValidate="txtBlog" >
                                                    </asp:RequiredFieldValidator>--%>
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
        </div>

        <div class="clear">
        </div>
    </div>
    </div>
</asp:content>
