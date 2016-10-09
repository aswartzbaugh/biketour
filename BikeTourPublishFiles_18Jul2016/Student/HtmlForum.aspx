<%@ page title="Bike Tour - Forum" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="Student_Forum, App_Web_ovj0uy2w" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="../UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet"
    TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="../_js/index_fixprompt.js" type="text/javascript"></script>
    <script type="text/javascript">
        //        $(document).ready(function () { $("[id$=btnSubmit]").hide(); });
        //        function verifyCode(code) {
        //            $("[id$=btnSubmit]").trigger("click");
        //        }

        function isEmptyBlog() {
            if (document.getElementById('<%= txtBlog.ClientID %>').value == '')
                return false;
            else
                return true;
        }

        function ScrollPosition() {

            if (document.getElementById('<%= hdnScrollPosition.ClientID %>').value != "") {
                var scrollpos = parseInt(document.getElementById('<%= hdnScrollPosition.ClientID %>').value);
                var $t = $('#ContentPlaceHolder1_div_Comments');
                $t.animate({ "scrollTop": scrollpos }, 0);
            } else {
                var $t = $('#ContentPlaceHolder1_div_Comments');
                $t.animate({ "scrollTop": 0 }, 0);
            }

            $("#ContentPlaceHolder1_div_Comments").scroll(function () {
                var currentScroll = $(this).scrollTop();
                document.getElementById('<%= hdnScrollPosition.ClientID %>').value = currentScroll;
                previousScroll = currentScroll;
            });
        }

        var previousScroll = 0;

      

        $(window).load(function () {
            $("#ContentPlaceHolder1_div_Comments").scroll(function () {
                var currentScroll = $(this).scrollTop();
                document.getElementById('<%= hdnScrollPosition.ClientID %>').value = currentScroll;
                previousScroll = currentScroll;
            });
        });
        
        function mesg() {
            
            if ($("#ContentPlaceHolder1_lbtnUpload").attr('class') == "aspNetDisabled glbtn") {
                var message = '<%=GetLocalResourceObject("uploadBlock") %>';
                alert(message);
               // alert('Sie blockiert sind zum Hochladen .gpx bitte an Administrator');
            }
        }
    </script>

    <style type="text/css">
        .cityddl
        {
            border-style: solid;
            border-width: 1px;
            border-color: #012F4E #78ABC7 #78ABC7 #012F4E;
            padding: 10px 6px 10px 6px;
            background-color: #014B7C;
            color: #FFFFFF;
            box-shadow: 1px 1px 0px #333333;
            width: 225px;
        }
        .rightcol123
        {
            float: right;
        }
        .scroe
        {
            background-position: 250px center;
            min-height: 100px;
            margin-bottom: 20px;
            box-shadow: 0px 0px 7px #333333;
            color: #000000;
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
            padding-left: 10px;
            background: #f9fbff;
            background: -webkit-gradient(linear, 0 0, 0 bottom, from(#f9fbff), to(#e8edff));
            background: -webkit-linear-gradient(#f9fbff, #e8edff);
            background: -moz-linear-gradient(#f9fbff, #e8edff);
            background: -ms-linear-gradient(#f9fbff, #e8edff);
            background: -o-linear-gradient(#f9fbff, #e8edff);
            background: linear-gradient(#f9fbff, #e8edff);
            -pie-background: linear-gradient(#f9fbff, #e8edff);
            border-radius: 7px;
            -moz-border-radius: 7px;
            -webkit-border-radius: 7px;
        }
        .margintop
        {
            margin-top: 20px;
        }
        .bg
        {
            background-position: right center;
            width: 40px;
            background-image: url('../_images/NewImages/win.png');
            background-repeat: no-repeat;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
    <asp:HiddenField ID="hdn_StartCity" runat="server" Value="0" />
    <asp:HiddenField ID="hdn_EndCity" runat="server" Value="0" />
    <asp:HiddenField ID="hdnScrollPosition" runat="server" Value="0" />
     <asp:HiddenField ID="hdnUploadBlock" runat="server" Value="0" />
    <asp:Timer ID="BlogRefreshTimer" runat="server" Interval="10000" OnTick="BlogRefreshTimer_Tick">
    </asp:Timer>
    <div class="container">
        <h5 id="h1_ClassForum" runat="server">
            <asp:Literal ID="ltlClassForum" runat="server" meta:ResourceKey="ltlClassForum"></asp:Literal>
            <%--<asp:Label ID="lblClassForum" runat="server" Text="Class Forum "></asp:Label>--%>
        </h5>
        <div class="AdminContWrap">
            <div id="div_Content" runat="server">
                <table border="0" cellpadding="0" cellspacing="0">
                    <tr>
                        <td valign="top" style="width: 30%">
                            <div class="rankswrapper">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:DataList ID="dlScoreBoard" runat="server" DataSourceID="sdsScoreBoard" Width="100%">
                                            <ItemTemplate>
                                                <div class="rankss">
                                                    <asp:Label ID="lblHighScoreText" runat="server" meta:ResourceKey="lblHighScoreText"
                                                        CssClass="color size"></asp:Label><br />
                                                    <hr style="margin-top: 3px; margin-bottom: 3px; background-color: #666666;" />
                                                    <asp:Label ID="lblHighScore" CssClass="color" runat="server" Text='<%#Eval("scorewithbonus") %>'></asp:Label>
                                                </div>
                                                <div class="rankss">
                                                    <asp:Label ID="lblLeadingClassText" runat="server" CssClass="color size" meta:ResourceKey="lblLeadingClassText"></asp:Label><br />
                                                    <hr style="margin-top: 3px; margin-bottom: 3px;" />
                                                    <asp:Label ID="lblLeadingClass" CssClass="color" runat="server" Text='<%#Eval("LeadingClass") %>'></asp:Label>
                                                </div>
                                                <div class="rankss">
                                                    <asp:Label ID="lblRankAboveText" runat="server" CssClass="color size" meta:ResourceKey="lblRankAboveText"></asp:Label><br />
                                                    <hr style="margin-top: 3px; margin-bottom: 3px;" />
                                                    <span class="color size">
                                                        <%#"# " + Eval("OneAboveRank")%></span><br />
                                                    <asp:Label ID="lblRankAbove" runat="server" CssClass="color" Text='<%#Eval("OneAboveClass") + " - " + Eval("OneAboveScoreWithBonus") %>'></asp:Label>
                                                </div>
                                                <div class="rankss">
                                                    <asp:Label ID="lblOwnRankText" runat="server" CssClass="color size" meta:ResourceKey="lblOwnRankText"></asp:Label><br />
                                                    <hr style="margin-top: 3px; margin-bottom: 3px;" />
                                                    <asp:Label ID="lblOwnRank" runat="server" CssClass="color" Text='<%#"# "+Eval("OwnRank") + " - " + Eval("OwnScoreWithBonus") %>'></asp:Label>
                                                </div>
                                                <div class="rankss">
                                                    <asp:Label ID="lblRankBelowText" runat="server" CssClass="color size" meta:ResourceKey="lblRankBelowText"></asp:Label><br />
                                                    <hr style="margin-top: 3px; margin-bottom: 3px;" />
                                                    <span class="color">
                                                        <%#"# " + Eval("onebelowrank")%></span><br />
                                                    <asp:Label ID="lblRankBelow" runat="server" CssClass="color" Text='<%#Eval("onebelowclass") + " - " + Eval("onebelowscorewithbonus") %>'></asp:Label>
                                                </div>
                                            </ItemTemplate>
                                        </asp:DataList>
                                        <asp:LinkButton ID="lbtnHometownScore" runat="server" meta:ResourceKey="lbtnHometownScore"
                                            OnClick="lbtnHometownScore_Click" Visible="false"></asp:LinkButton>
                                        <asp:LinkButton ID="lbtnAllScore" runat="server" meta:ResourceKey="lbtnAllScore"
                                            OnClick="lbtnAllScore_Click" Visible="false"></asp:LinkButton>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <asp:SqlDataSource ID="sdsScoreBoard" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                    SelectCommand="SP_GET_SCOREBOARD" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:Parameter DefaultValue="all" Name="Action" Type="String" />
                                        <asp:SessionParameter Name="UserId" SessionField="UserId" Type="Int32" />
                                        <asp:SessionParameter Name="UserRoleId" SessionField="UserRoleId" Type="Int32" />
                                        <asp:Parameter DefaultValue="0" Name="ClassId" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                
                            </div>
                            <%--<div class="scorewrapp">--%>
                                <div class="cityddl">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblcity" runat="server" CssClass="GlbLbll" meta:ResourceKey="lblcity"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="upcity" runat="server" UpdateMode="Conditional">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlCompetitionCity" runat="server" AutoPostBack="true" DataSourceID="ddlparticipatigcity" Width="200px"
                                                            DataTextField="CityName" DataValueField="CityId" OnSelectedIndexChanged="ddlCompetitionCity_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                        <asp:SqlDataSource ID="ddlparticipatigcity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                                            SelectCommand="SELECT '0' as [CityId] ,' Deutschlandweit' As [CityName] union All  
                                                    SELECT CityId, CityName   from  CityMaster where IsActive = 1 and IsParticipatingCity=1 
                                                    AND CityId IN (select DISTINCT CityId
                                                    from StudentUpload SU INNER JOIN SchoolClassMaster SCM
                                                    ON SU.ClassId = SCM.ClassId
                                                    INNER JOIN SchoolMaster SM
                                                    ON SCM.SchoolId = SM.SchoolId)
                                                    Order by CityName asc"></asp:SqlDataSource>
                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="ddlCity" EventName="SelectedIndexChanged" />
                                                    </Triggers>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <%-- ----------------score---------------%>
                                <div class="margintop">
                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                        <ContentTemplate>
                                            <p class="selectCity">
                                                <asp:Label ID="lblNoRecord" runat="server" meta:ResourceKey="lblNoRecord" Visible="false"
                                                    CssClass="selectCity"></asp:Label></p>
                                            <asp:DataList ID="dlsore" runat="server" Width="250px">
                                                <ItemTemplate>
                                                    <div class="scroe">
                                                        <table border="0" cellpadding="0" cellspacing="7" width="100%">
                                                            <tr>
                                                                <td class="fontB" style="width: 80px;">
                                                                    <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                                                                </td>
                                                                <td class="className">
                                                                    <asp:Label ID="lblclassname" runat="server" Text='<%# Eval("School") %>' />
                                                                </td>
                                                                <td rowspan="2" class="">
                                                                </td>
                                                            </tr>
                                                            <tr runat="server" id="trCity" visible='<%#bool.Parse(GetVisible(Eval("CityId")))%>'>
                                                                <td class="fontB" style="width: 70px;">
                                                                    <asp:Label ID="lblCityList" runat="server" meta:ResourceKey="lblCityList"></asp:Label>
                                                                </td>
                                                                <td class="className">
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("CityName") %>' />
                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="fontB">
                                                                    <asp:Label ID="lblClass" runat="server" meta:ResourceKey="lblClass"></asp:Label>
                                                                </td>
                                                                <td class="className">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Class") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="fontB">
                                                                    <asp:Label ID="lblScoreList" runat="server" meta:ResourceKey="lblScoreList"></asp:Label>
                                                                </td>
                                                                <td class="scorefont">
                                                                    <asp:Label ID="lblscore" runat="server" Text='<%# Eval("scorewithbonus") %>' />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td class="fontB">
                                                                    <asp:Label ID="lblTotalDistance" runat="server" meta:ResourceKey="lblTotalDistance"></asp:Label>
                                                                </td>
                                                                <td class="scorefont">
                                                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("totaldistance")+" KM" %>' />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <br />
                                            <br />
                                            <br />
                                            <p class="selectCity">
                                                <asp:Label ID="lblmsg" runat="server" CssClass="selectCity" Visible="False"></asp:Label></p>
                                        </ContentTemplate>
                                    </asp:UpdatePanel>
                                </div>
                            <%--</div>--%>
                        </td>
                        <td valign="top">
                            <div class="rightcol" id="div_RightCol" runat="server">
                                <table width="100%">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lbl_TestResult" runat="server" Text="" CssClass="Current" Visible="false"></asp:Label>
                                            <div class="currentstagewrap" id="div_Congrats" runat="server" style="text-aling: center;">
                                                <table border="0" cellpadding="0" cellspacing="0" align="center" width="100%">
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblCongratulations1" CssClass="Current" runat="server" Text="" meta:ResourceKey="lblCongratulations1"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="center">
                                                            <asp:Label ID="lblCongratulations2" CssClass="Currentcity" runat="server" Text=""></asp:Label>
                                                            <asp:Label ID="lblCongratulations3" CssClass="Currentcity" runat="server" Text="!"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <div class="clear">
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                                <div >
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:LinkButton ID="lbtnUpload"  runat="server" meta:ResourceKey="lbtnUpload" CssClass="glbtn"
                                                    PostBackUrl="~/Student/UploadGpx.aspx"  Visible="True"   OnClientClick="mesg();"></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="QuizTest right" runat="server" id="div_QuizTest" visible="true">
                                    <table>
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblpcity" runat="server" meta:ResourceKey="lblpcity" CssClass="GlbLbl"></asp:Label>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                                    <ContentTemplate>
                                                        <asp:DropDownList ID="ddlcity" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlcity_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                            <td>
                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                    <ContentTemplate>
                                                        <asp:LinkButton ID="lbtnCityInfo" runat="server" meta:ResourceKey="lbtnCityInfo"
                                                            CssClass="glbtn Right" PostBackUrl=""></asp:LinkButton>
                                                    </ContentTemplate>
                                                </asp:UpdatePanel>
                                            </td>
                                        </tr>
                                    </table>
                                    <div class="clear">
                                    </div>
                                    <div class="clear">
                                    </div>
                                </div>
                                <table border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td>
                                            <asp:Image ID="imgFromCity" runat="server" Height="160px" Width="200px" CssClass="left"
                                                AlternateText="No Image" Visible="True" />
                                        </td>
                                        <td>
                                            <h2 align="center">
                                                <asp:Label ID="lblCurrentStage" CssClass="CurrentStage" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="lblDistanceCovered" CssClass="CurrentStage1" runat="server" Text=""></asp:Label>
                                            </h2>
                                            <div id="div_NextStage" runat="server" visible="false" style="text-align: center">
                                                <asp:Label ID="lblFromCityName" CssClass="cityfont" runat="server" Text=""></asp:Label>
                                                <center style="margin-top:38px">
                                                    <asp:LinkButton ID="lnkQuizTest2" runat="server" CssClass="glbtn" Visible="true" meta:resourceKey="lnkQuizTest2"></asp:LinkButton></center>
                                            </div>
                                        </td>
                                        <td>
                                            <asp:Image ID="imgToCity" runat="server" Height="160px" Width="200px" CssClass="Right"
                                                AlternateText="No Image" Visible="True" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <div class="clear">
                                </div>
                                <div class="clear">
                                </div>
                                <div class="mapwrapper" id="div_GoogleMap" runat="server">
                                    <uc1:GoogleMapForASPNet ID="GoogleMapForASPNet1" runat="server" />
                                </div>
                            </div>

                            <div class="GridWrap" align="left" style="margin-top: 105%;">
                            <div id="DivScroll" style="max-height:220px; overflow:auto;">
                                <asp:GridView ID="grdStagePlan" runat="server" AutoGenerateColumns="False" OnRowDataBound="grdStagePlan_RowDataBound"
                                    Width="680px" ShowFooter="True" DataKeyNames="StagePlanId,Status" EmptyDataText="Keine Daten vorhanden"
                                    CssClass="gv" AllowSorting="True" HeaderStyle-CssClass="gridHeader" >
                                    <Columns>
                                        <asp:TemplateField HeaderText="Startort">
                                            <ItemTemplate>
                                                <asp:Label ID="lblFromCity" runat="server" Text='<%# Eval("FromCity") %>'></asp:Label>
                                                <asp:Label ID="lblFromCityId" runat="server" Text='<%# Eval("FromCityId") %>' Style="display: none;"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Zielort">
                                            <ItemTemplate>
                                                <asp:Label ID="lblToCity" runat="server" Text='<%# Eval("ToCity") %>'></asp:Label>
                                                <asp:Label ID="lblToCityId" runat="server" Text='<%# Eval("ToCityId") %>' Style="display: none;"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Streckenlänge">
                                            <ItemTemplate>
                                                <asp:Label ID="lblTotalDistanceCovered" runat="server" Text='<%# Eval("TotalDistanceCovered") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Distance" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide"
                                            FooterStyle-CssClass="hide" />
                                        <asp:BoundField DataField="Distance_Covered" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide"
                                            FooterStyle-CssClass="hide" />
                                        <asp:BoundField DataField="FromCityLat" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide"
                                            FooterStyle-CssClass="hide" />
                                        <asp:BoundField DataField="FromCityLong" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide"
                                            FooterStyle-CssClass="hide" />
                                        <asp:BoundField DataField="ToCityLat" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide"
                                            FooterStyle-CssClass="hide" />
                                        <asp:BoundField DataField="ToCityLong" ItemStyle-CssClass="hide" HeaderStyle-CssClass="hide"
                                            FooterStyle-CssClass="hide" />
                                    </Columns>
                                    <HeaderStyle CssClass="gridHeader" />
                                </asp:GridView>
                            </div>
                            </div>
                            
                            <div runat="server" id="divForumBlog" class="rightcol" style="width: 700px;">
                                <div class="clear">
                                </div>
                                <div class="bolg">
                                    <h5>
                                        <asp:Label ID="lblClassBlog" runat="server" meta:ResourceKey="lblClassBlog"></asp:Label></h5>
                                </div>
                                <br />
                                <div class="frmBox">
                                    <div class="chat">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="BlogRefreshTimer" EventName="Tick" />
                                            </Triggers>
                                            <ContentTemplate>
                                                <div id="div_Comments" runat="server" class="scroll">
                                                    <asp:DataList ID="dlBlog" runat="server" DataSourceID="sdsForum" Width="100%" CssClass="datalist">
                                                        <ItemTemplate>
                                                            <div style="border-bottom: thin dashed #CCCCCC;">
                                                                <table>
                                                                    <tr>
                                                                        <td style="min-width: 230px; vertical-align: top;">
                                                                            <div class="name">
                                                                                <asp:Label ID="lblBlogBy" runat="server" Text='<%# Eval("BlogWrittenBy") %>' CssClass="GlbLblh"></asp:Label>
                                                                                <asp:Label ID="lblBlogInfo" runat="server" Text='<%# Eval("SchoolName") + "," + Eval("ClassName") + "wrote:" %>'></asp:Label>
                                                                            </div>
                                                                        </td>
                                                                        <td style="vertical-align: top; padding-top: 5px;">
                                                                            <div class="bolgsms">
                                                                                <span class="blog">
                                                                                    <%# Eval("blogtext") %></span>
                                                                            </div>
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
                                                <asp:Parameter DefaultValue="0" Name="ClassId" Type="Int32" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <br />
                                        <div id="div_CommnetBox">
                                            <table>
                                                <tr>
                                                    <td colspan="2">
                                                        <asp:Label ID="lbl_Comment" runat="server" meta:ResourceKey="lbl_Comment"></asp:Label><br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtBlog" runat="server" AutoPostBack="false" CssClass="gltxt" TextMode="MultiLine"
                                                            Rows="3" Columns="50"></asp:TextBox><br />
                                                        <span class="error">*</span>
                                                        <asp:RequiredFieldValidator ID="rfvBlog" runat="server" ValidationGroup="SubmitMessage"
                                                            CssClass="error" ControlToValidate="txtBlog" meta:ResourceKey="rfvBlog">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td>
                                                        <%--OnClientClick="return isEmptyBlog();"--%>
                                                        <asp:Button ID="btnSubmit" runat="server" meta:ResourceKey="btnSubmit" OnClick="btnSubmit_Click"
                                                            ValidationGroup="SubmitMessage" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </table>
                <asp:ModalPopupExtender ID="ModalPopupExtender2" runat="server" TargetControlID="lnkQuizTest2"
                    PopupControlID="pnlQuizBox" CancelControlID="btnQuizCancel">
                </asp:ModalPopupExtender>
                <asp:Panel ID="pnlQuizBox" runat="server" BorderColor="Black" BackColor="Gainsboro"
                    Style="display: none;" CssClass="QuizBox">
                    <div class="PopupControls">
                        <div class="pad10">
                            <asp:Literal ID="lt_Quiz" runat="server"></asp:Literal>
                            <asp:Button ID="btnQuizCancel" runat="server" meta:ResourceKey="btnQuizCancel" Text=""
                                CssClass="glbtn Right" />
                            <asp:Button ID="btnQuizNext" runat="server" meta:ResourceKey="btnQuizNext" Visible="false"
                                CssClass="glbtn Right" OnClick="btnQuizNext_Click" />
                        </div>
                    </div>
                </asp:Panel>
                <div class="clear">
                </div>
            </div>
            <div runat="server" id="div_NoStagePlan" visible="false">
                <h3>
                    <asp:Label ID="Label1" runat="server" meta:ResourceKey="Label1"></asp:Label>
                    <asp:HiddenField ID="HdnstudId" Value="0" runat="server" />
                    <asp:HiddenField ID="HdnClassId" Value="0" runat="server" />
                </h3>
            </div>
            <div class="clear">
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
</asp:Content>
