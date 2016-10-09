<%@ page language="C#" culture="de-DE" uiculture="de-DE" autoeventwireup="true" inherits="StartPage, App_Web_ymnmxjfp" %>

<%@ Register Src="UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet"
    TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>BikeTour - Home</title>
    <link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <style type="text/css">
		p{margin:0 0 20px 0;}
		.content{margin:0px; width:100%; max-height:400px; height:auto; padding:2px; overflow:auto; background:#666; -webkit-border-radius:3px; -moz-border-radius:3px; border-radius:3px;}
		.content p:nth-child(even){color:#333333; font-family:Georgia,serif; font-size:12px; font-style:italic;}
		.content p:nth-child(3n+0){color:#c96;}
	</style>
    <link href="_fonts/stylesheet.css" rel="stylesheet" type="text/css" />
    <script src="_js/jquery-1.7.1.js" type="text/javascript"></script>
    <link href="_css/index.css" rel="stylesheet" type="text/css" />
    <script src="_js/jquery.mCustomScrollbar.concat.min.js" type="text/javascript"></script>
    <link href="_css/jquery.mCustomScrollbar.css" rel="stylesheet" type="text/css" />
    <script src="_js/jquery.simplyscroll.min.js" type="text/javascript"></script>
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDY0kkJiTPVd2U7aTOAwhc9ySH6oHxOIYM&sensor=false&language=de"
        type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {


            $("#content_1").mCustomScrollbar({
                autoHideScrollbar: true,
                theme: "light-thin"
            });

        });
    
    
    
    </script>
    <script type="text/javascript">

        $(document).ready(function () {

            $(function () { //on DOM ready 
                $("#scroller").simplyScroll({ frameRate: 30 });
            });

        });
    
    
    </script>
    <script type="text/javascript">


        //       ---- Google Map--------------------------

//        function initialize() {
//            var mapProp = {
//                center: new google.maps.LatLng(51.0000, 9.0000),
//                zoom: 6,
//                mapTypeId: google.maps.MapTypeId.ROADMAP
//            };
//            var map = new google.maps.Map(document.getElementById("googleMap")
//              , mapProp);
//        }

//        google.maps.event.addDomListener(window, 'load', initialize);

    </script>


    <script type="text/javascript">
        window.onload = function () {
            <%=MapData%>
            <%=ZoomLevelString%>
        }
        
        function toggleBounce() {

            if (marker.getAnimation() != null) {
                marker.setAnimation(null);
            } else {
                marker.setAnimation(google.maps.Animation.BOUNCE);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
            <asp:Timer ID="BlogRefreshTimer" runat="server" Interval="10000" OnTick="BlogRefreshTimer_Tick">
            </asp:Timer>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div class="MainWraper">
        <div class="HeaderWrap">
            <div class="head ">
                <div class="PageWidthWrap">
                    <div class="Logowrap Left">
                        <img src="_images/NewImages/logo_adfc.png" class="Logoimg" />
                    </div>
                    <div class="MenuWrap right">
                    </div>
                    <div class="clear">
                    </div>
                </div>
                <div class="clear">
                </div>
            </div>
            <div class="linkLogin">
                <div class="links">
                    <%---------------links-----------------------------------%>
                    <ul id="scroller">
                        <%--    <li><a href><img src="_images/NewImages/15.png" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/16.jpg" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/17.jpg" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/18.jpg" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/19.jpg" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/20.jpg" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/21.jpg" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/22.png" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/23.jpg" height="90px"/></a></li>
                         <li><a href><img src="_images/NewImages/24.jpg" height="90px"/></a></li>--%>
                        <asp:Literal Text="" ID="LitGalImges" runat="server"></asp:Literal>
                    </ul>
                    <%---------------links end-----------------------------------%>
                </div>
                <div class="login">
                    <a href="Login.aspx" class="LogLnq right">
                        <asp:Label ID="lblLoginHome" runat="server" meta:resourceKey="lblLoginHome"></asp:Label></a>
                </div>
            </div>
            <div class="PageWidthWrap">
                <div class="">
                    <div class="contents">
                        <%-------------contener------------------------%>
                        <div>
                            <div class="leftcol">
                                <div class="frmBox">
                                    <%-----------------dropdown with Data------------%>
                                    <div class="linkdiv">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <a href="AboutUs.aspx" class="about">
                                                        <asp:Label ID="lblAboutUs" runat="server" meta:resourceKey="lblAboutUs"></asp:Label></a>
                                                </td>
                                                <td>
                                                    <a href="ContactUs.aspx" class="contact">
                                                        <asp:Label ID="lblContactus" runat="server" meta:resourceKey="lblContactus"></asp:Label></a>
                                                </td>
                                                 <td>
                                                    <a href="FAQ.aspx" class="faq">
                                                        <asp:Label ID="lblFAQ" runat="server" meta:resourceKey="lblFAQ"></asp:Label></a>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="scorewrapp">
                                        <div class="citybox">
                                            <table border="0" cellpadding="0" cellspacing="5" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblcity" runat="server" CssClass="GlbLbll" meta:ResourceKey="lblcity"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:UpdatePanel ID="upcity" runat="server" UpdateMode="Conditional">
                                                            <ContentTemplate>
                                                                <asp:DropDownList ID="ddlCity" runat="server" AutoPostBack="true" DataSourceID="ddlparticipatigcity"
                                                                    DataTextField="CityName" DataValueField="CityId" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
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
                                        <%------------------score---------------%>
                                        <div class="margintop">
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <ContentTemplate>
                                                    <p class="selectCity">
                                                        <asp:Label ID="lblNoRecord" runat="server" meta:ResourceKey="lblNoRecord" Visible="false"
                                                            CssClass="selectCity"></asp:Label></p>
                                                    <asp:DataList ID="dlsore" runat="server" Width="341px">
                                                        <ItemTemplate>
                                                            <div class="scroe">
                                                                <table border="0" cellpadding="0" cellspacing="7" width="100%">
                                                                    <tr>
                                                                        <td class="fontB" style="width:80px;">
                                                                            <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool"></asp:Label>
                                                                        </td>
                                                                        <td class="className">
                                                                            <asp:Label ID="lblclassname" runat="server" Text='<%# Eval("School") %>' />
                                                                        </td>
                                                                        <td rowspan="2" class="bg">
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
                                    </div>
                                    <div class="clear">
                                    </div>
                                </div>
                            </div>
                            <div class="rightcol">
                                <div class="mapwrapp ">
                                    <%--  <img src="_images/NewImages/GermanyMap.png" width="300" />--%>
                                    <%--<div class="map" id="googleMap">
                                    </div>--%>
                                    <div id="dvMap" class="map" runat="server" > 
                                    <div class="clear">
                                    </div>
                                </div>
                                <div class="forumwrapp right">
                                    <h5>
                                        <asp:Label ID="lblForum" runat="server" meta:ResourceKey="lblForum"></asp:Label></h5>
                                    <br />
                                    <%----------------------chat Fourm---------------------------%>
                                    <div id="content_1" class="content">
                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                            <ContentTemplate>
                                                <asp:Timer ID="Timer1" runat="server" Interval="10000" OnTick="BlogRefreshTimer_Tick">
                                                </asp:Timer>
                                                <asp:DataList ID="dlBlog" runat="server" CssClass="datalist" DataKeyField="BlogId"
                                                    DataSourceID="sdsForum" Width="100%">
                                                    <ItemTemplate>
                                                        <table border="0" cellpadding="0" cellspacing="7px" width="100%">
                                                            <tr>
                                                                <td style="width: 250px;vertical-align:top;padding-top:20px;">
                                                                    <div class="name">
                                                                        <div class="Square Left">
                                                                            <asp:Label ID="lblBlogBy" runat="server" Text='<%# Eval("BlogWrittenBy") %>' CssClass="GlbLblh"></asp:Label>
                                                                            <p class="schoolwidth">
                                                                                <asp:Label ID="lblBlogInfo" runat="server" Text='<%# Eval("SchoolName") + ", " + Eval("ClassName") %>'></asp:Label></p>
                                                                        </div>
                                                                </td>
                                                                <td>
                                                                    <div class="bolgsms">
                                                                        <p>
                                                                            <%# Eval("blogtext") %></p>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                                <asp:SqlDataSource ID="sdsForum" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                                    SelectCommand="SP_HOMEPAGE_FORUM" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
                                                <div class="clear">
                                                </div>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="BlogRefreshTimer" EventName="Tick" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                    <div class="clear">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="clear">
                        </div>
                    </div>
                </div>
            </div>
            <div class="clear">
            </div>
        </div>
    </div>
    <%-----------------backData-------------------%>
    <div>
    </div>
    <%-----------------backDataEnd-------------------%>
    </form>
</body>
</html>
