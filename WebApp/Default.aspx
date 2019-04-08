<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- startblock -->
    <div class="flexslider">
        <ul class="slides">
            <li style="background-image: url(_images/header-01.jpg)">
                <div class="wrapper">
                    <div class="main-box box-layout-left">
                        <h1 class="title white">Du hast Lust auf Fahrrad Fahren?</h1>
                        <p>Einer der Dreh- und Angelpunkte des Projekts ist das Fahrrad fahren, solltest du jetzt schon ein begeisterter Fahrrad Fahrer sein bist du hier genau richtig. </p>
                        <p><a href="DasProject.aspx">ja, das bin ich!</a></p>
                    </div>
                </div>
            </li>
            <li style="background-image: url(_images/header-02.jpg)">
                <div class="wrapper">
                    <div class="main-box box-layout-left">
                        <h1 class="title white">Du hast Lust auf moderne Technologie?</h1>
                        <p>Aber nicht nur Radfahrer auch Technik Freak kommen bei Stadt-Land-Rad voll auf Ihre Kosten. Moderne GPS Technik mit passender Software sowie eine eigene App werdet ihr in dem Projekt benutzen.</p>
                        <p><a href="DasProject.aspx">ja, das bin ich!</a></p>
                    </div>
                </div>
            </li>
            <li style="background-image: url(_images/header-03.jpg)">
                <div class="wrapper">
                    <div class="main-box box-layout-left">
                        <h1 class="title white">Du hast Lust dein Heimat- land kennen zu lernen?</h1>
                        <p>oder bist einfach fasziniert von Geographie und willst viele spannende Städte in Deutschland besser kennen lernen und mehr über dein Land erfahren?</p>
                        <p><a href="DasProject.aspx">ja, das bin ich!</a></p>
                    </div>
                </div>
            </li>
        </ul>
    </div>
    <div class="zackenholder">
        <div class="zacke">
            <div class="wrapper">
                <h1>Willkommen bei Stadt-Land-Rad</h1>
                <h2>einem Projekt des ADFC </h2>
            </div>
        </div>
    </div>

    <div class="main-container">
        <div class="wrapper">
            <div class="col col-45 main-left">
                <div class="pad">
                    <asp:UpdatePanel ID="upCity" runat="server">
                        <ContentTemplate>
                            <div class="frmBox"><table>
                                                <tr>
                        <td>
                            <asp:Label ID="lblCity" runat="server" style="padding: 2px; margin: 0px;color: #666666;font-weight: 600; font-size: 12px;    text-decoration: none;    display: inline-block;">Stadt auswählen :</asp:Label>
                        </td>
                        <td>

                            <asp:DropDownList ID="ddlCity" runat="server" DataSourceID="sdsCity" DataTextField="CityName"
                                DataValueField="CityId" AutoPostBack="true" style="display: inline-block;width: 192px; padding: 2px 5px 2px 5px;    margin: 2px 0px 2px 2px;    border: 1px solid #C2C5CD;    line-height: 36px;    height: 28px;"
                                OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="sdsCity" runat="server" ConnectionString="<%$ ConnectionStrings:BikeTourConnectionString %>"
                                SelectCommand="SELECT '0' as [CityId], ' Stadt' as [CityName] union all SELECT [CityId], [CityName] FROM [CityMaster] 
                                            WHERE [IsActive] = 1 order by CityName"></asp:SqlDataSource>
                            </td>
                                                    </tr>
                                                    </table>
                                </div>
                      
                    <asp:DataList ID="dlsore" runat="server" Width="341px">
                        <ItemTemplate>
                            <div data-rownumber='<%# Container.ItemIndex+1%>' id="divrow" class="row">
                                <div class="counter">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Container.ItemIndex+1%>' />
                                </div>
                                <p>
                                    <strong>
                                        <asp:Label ID="lblSchool" runat="server" meta:ResourceKey="lblSchool" Text='<%# Eval("School") %>' />, 
                                        <asp:Label ID="Label2" runat="server" meta:ResourceKey="lblSchool" Text='<%# Eval("Class") %>' /></strong><br />
                                    <em>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Eval("CityName") %>' /></em>
                                </p>
                                <div class="counts">
                                    <div class="col col-60">
                                        <div class="getScoreWithBonus" data-score='<%# Eval("score") %>' data-scorewithbonus='<%# Eval("scorewithbonus") %>'>&nbsp; </div>
                                    </div>
                                    <div class="col col-40">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("scorewithbonus") %>' />
                                        Punkte
                                    </div>
                                    <div class="clear"></div>
                                </div>
                                <div class="counts">
                                    <div class="col col-60">
                                        <div class="getList" data-totaldistance='<%# Eval("totaldistance") %>' data-score='<%# Eval("score") %>'>&nbsp; </div>
                                    </div>
                                    <div class="col col-40">
                                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("totaldistance")+" km" %>' />
                                    </div>
                                    <div class="clear"></div>
                                </div>
                        </ItemTemplate>
                    </asp:DataList>
                      </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
            <div class="col col-50 main-right">
                <div class="col col-35">
                    <a href="DasProject.aspx">
                        <img src="_images/thumbnail-01.png" /></a>
                </div>
                <div class="col col-65">
                    <p>
                        <a href="DasProject.aspx"><strong>ÜBER DAS PROJEKT</strong></a><br />
                        Kindern den Spaß am Radfahren näher bringen, das eigene Land besser kennenlernen sowie den Umgang mit Navigationstechnik spielerisch vermitteln. Das sind die drei Schwerpunkte des Projekts aber es gibt noch viel mehr...   »<a href="DasProject.aspx">weiterlesen</a>
                    </p>
                </div>
                <div class="clear"></div>
                <div class="col col-35">
                    <a href="JoinUs.aspx">
                        <img src="_images/thumbnail-02.png" /></a>
                </div>
                <div class="col col-65">
                    <p>
                        <a href="JoinUs.aspx"><strong>MITMACHEN</strong></a><br />
                        Ihr habt Lust, euch am Projekt „Stadt-Land-Rad“ zu beteiligen? So funktioniert es: Mindestens 70% eurer Klasse will mitmachen und mitradeln. Dann überzeugt euren Klassenlehrer!  »<a href="JoinUs.aspx">weiterlesen</a>
                    </p>
                </div>
                <div class="clear"></div>
                <div class="col col-35">
                    <a href="Support.aspx">
                        <img src="_images/thumbnail-03.png" /></a>
                </div>
                <div class="col col-65">
                    <p>
                        <a href="Support.aspx"><strong>HILFE UND SUPPORT</strong></a><br />
                        Gibt es Probleme mit der Internetseite, der App oder dem GPS Gerät? Dann habt ihr hier die richtigen Ansprechpartner bei allen Problemen. »<a href="Support.aspx">weiterlesen</a>
                    </p>
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    <script>$(document).ready(function () {

    var divrow = document.getElementById("divrow");

    if (divrow !== null && divrow !== "undefined") {
        var rownumber = divrow.getAttribute("data-rownumber");
        if (parseInt(rownumber) > 1)
            divrow.className = "row"
        divrow.className = "row row-1";
    }

   $('.getList').each(function () {var totaldistance = $(this).attr("data-totaldistance");
       var score = $(this).attr("data-score");
       var points = (parseInt(score) / 5 );
    $(this).width(points + "%");
    });
    
   $('.getScoreWithBonus').each(function () {
       var score = $(this).attr("data-score");
       var scorewithbonus = $(this).attr("data-scorewithbonus");
       var points = ((parseInt(scorewithbonus) / parseInt(score)) / 50) * 100;
       $(this).width(points + "%");
   });

    $('#nav').localScroll(800);

    $('.flexslider').flexslider({
        animation: "fade",
        slideshow: true,
        animationLoop: true,
        slideshowSpeed: 5000,
        animationSpeed: 1500
    });

    $('.flexslider2').flexslider({
        animation: "slide",
        slideshow: true,
        animationLoop: true,
        slideshowSpeed: 3000,
        animationSpeed: 1500
    });

    $('.link-01').click(function () {
        $('.flexslider').flexslider(0);
    });
    $('.link-02').click(function () {
        $('.flexslider').flexslider(1);
    });
    $('.link-03').click(function () {
        $('.flexslider').flexslider(2);
    });
    $('.link-04').click(function () {
        $('.flexslider').flexslider(3);
    });


    $('.fancybox').fancybox({
        padding: 1,
        width: 920,
        height: 518,
        aspectRatio: true,
        helpers: {
            media: {}
        }
    });



});
    </script>
</asp:Content>


<%-- Add content controls here --%>
