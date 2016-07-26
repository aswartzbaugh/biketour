<%@ page title="Bike Tour - Forum" culture="de-DE" uiculture="de-DE" language="C#" masterpagefile="~/SiteMaster/AdminMaster.master" autoeventwireup="true" inherits="Student_Forum, App_Web_oe4n1ss3" %>

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

        function msg()
        {
            
            //var lt_Quiz = document.getElementById('lt_Quiz');
            //var HdnQuizData = document.getElementById('HdnQuizData');
            //lt_Quiz.innerHTML = HdnQuizData.innerText;
            alert(HdnQuizData.innerText);
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
                                                <asp:LinkButton ID="lbtnUpload" runat="server" meta:ResourceKey="lbtnUpload" CssClass="glbtn"
                                                    PostBackUrl="~/Student/UploadGpx.aspx" Visible="False"  ></asp:LinkButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="QuizTest right" runat="server" id="div_QuizTest">
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
                                                AlternateText="No Image" Visible="False" />
                                        </td>
                                        <td>
                                            <h2 align="center">
                                                <asp:Label ID="lblCurrentStage" CssClass="CurrentStage" runat="server" Text=""></asp:Label>
                                                <asp:Label ID="lblDistanceCovered" CssClass="CurrentStage1" runat="server" Text=""></asp:Label>
                                            </h2>
                                            <div id="div_NextStage" runat="server" visible="true" style="text-align: center">
                                                <asp:Label ID="lblFromCityName" CssClass="cityfont" runat="server" Text=""></asp:Label>
                                                <center style="margin-top:38px">
                                                    <asp:LinkButton ID="lnkQuizTest2" runat="server" CssClass="glbtn" meta:resourceKey="lnkQuizTest2" ></asp:LinkButton></center>
                                            </div>
                                        </td>
                                        <td>
                                            <asp:Image ID="imgToCity" runat="server" Height="160px" Width="200px" CssClass="Right"
                                                AlternateText="No Image" Visible="False" />
                                        </td>
                                    </tr>
                                </table>
                                <br />
                             
                             
                            </div>

                            <div class="GridWrap" align="left" style="margin-top: 105%;">
                     
                            </div>
                            
                            <div runat="server" id="divForumBlog" class="rightcol" style="width: 700px;">
                                <div class="clear">
                                </div>
                                <div class="bolg">
                                    <h5>
                                        <asp:Label ID="lblClassBlog" runat="server" meta:ResourceKey="lblClassBlog"></asp:Label></h5>
                                </div>
                                <br />
                              
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
                           
                            <asp:Literal ID="lt_Quiz" runat="server" ></asp:Literal>
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
                      <asp:HiddenField ID="HdnQuizData" Value="0" runat="server" />
                </h3>
            </div>
            <div class="clear">
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
</asp:Content>
