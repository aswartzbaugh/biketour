<%@ Page Title="" Language="C#" MasterPageFile="~/Master.master" AutoEventWireup="true" CodeFile="DasProject.aspx.cs" Inherits="DasProject" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <%@ Register Src="UserControl/GoogleMapForASPNet.ascx" TagName="GoogleMapForASPNet"
        TagPrefix="uc1" %>

    <style type="text/css">
        p {
            margin: 0 0 20px 0;
        }

        .content {
            margin: 0px;
            width: 100%;
            max-height: 400px;
            height: auto;
            padding: 2px;
            overflow: auto;
            background: #666;
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            border-radius: 3px;
        }

            .content p:nth-child(even) {
                color: #333333;
                font-family: Georgia,serif;
                font-size: 12px;
                font-style: italic;
            }

            .content p:nth-child(3n+0) {
                color: #c96;
            }
    </style>
    <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDY0kkJiTPVd2U7aTOAwhc9ySH6oHxOIYM&sensor=false&language=de"
        type="text/javascript"></script>


    <!-- startblock -->
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="subsite-holder">
    </div>
    <div class="zackenholder">
        <div class="zacke">
            <div class="wrapper">
                <h1>Über das Projekt</h1>
                <h2>Stadt-Land-Rad</h2>
            </div>
        </div>
    </div>

    <div class="main-container">
        <div class="wrapper">
            <div class="pad">
                <h4>Kindern den Spaß am Radfahren näher bringen, das eigene Land besser kennenlernen 
                sowie den Umgang mit Navigationstechnik spielerisch vermitteln.
                Das sind die drei Schwerpunkte des Projekts aber es gibt noch viel mehr... </h4>
                <div class="col col-45">
                    <p>Jede Klasse bildet ein Team und tritt dann gegen die anderen Klassen in einem Wettstreit um die meisten Kilometer an. Jedes Kind erhält im Vorfeld ein GPS Gerät und zeichnet damit so viele zurückgelegte Kilometer wie möglich auf. Diese Strecken werden dann auf der eigenen Internetseite hochgeladen und gesammelt. Jeder Schülerinnen ist so ein gleichwertiges Mitglied seines Teams.</p>
                    <p>Mit den hochgeladenen Kilometern legen die Schülerinnen eine virtuelle Deutschlandreise durch verschiedene Städte zurück. Zu jeder vorher festgelegten Stadt oder Region gibt es immer ein  kleines Quiz, welches gelöst werden muss bevor zur nächsten Station weiter "geradelt" werden kann. </p>
                    <p>Ziel des Projekts ist es, dass sich Kinder mehr bewegen und Lust am Radfahren bekommen. Durch die virtuelle Deutschlandreise lernen die Schüler viel neues über ihr Heimatland und sammeln praktische Erfahrungen im Umgang mit dem GPS Gerät, der passenden Software und einer App.</p>
                    <p>Auf der Internetseite haben die Schülerinnen und Schüler auch die Möglichkeit einen Klassenblog zu pflegen, der sowohl die Schreibkompetenz als auch die Kommunikation innerhalb der Klasse fördert. </p>

                </div>
                <div class="col col-10">&nbsp;</div>
                <div class="col col-45" style="margin-top: 20px; background: #ccc; height: 400px;border-radius: 7px;-moz-border-radius: 7px;-webkit-border-radius: 7px; "  id="map-canvas"  >
                    <div class="clear">
                    </div>
                </div>
                <div class="clear"></div>
            </div>
        </div>
        <div class="wrapper">
            <hr />
        </div>
        <div class="wrapper">
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <h1 style="text-align: center;">Unsere Projektpartner:</h1>
            <p>&nbsp;</p>
            <table width="100%" cellpadding="5">
                <tr>
                    <td><a href="https://www.adfc-bw.de/heidelberg/" target="_blank">
                        <img src="_images/logo-adfc.jpg" alt="adfc heidelberg" /></a></td>
                    <td><a href="https://www.matchrider.de/" target="_blank">
                        <img src="_images/logo-matchrider.jpg" alt="Matchrider" /></a></td>
                    <td><a href="https://www.xing.com/profile/Sebastian_Weimann" target="_blank">
                        <img src="_images/logo-sebastian-weimann.jpg" alt="Sebastian Weimann" /></a></td>
                    <td><a href="http://www.pixelcloud.de" target="_blank">
                        <img src="_images/logo-pixelcloud.jpg" alt="Werbeagentur Pixelcloud" /></a></td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <hr />
            <p>&nbsp;</p>
            <p>&nbsp;</p>
            <h1 style="text-align: center;">Stadt-Land-Rad wird durch die Stadt Heidelberg gefördert</h1>
            <p>&nbsp;</p>
            <table width="100%" cellpadding="5">
                <tr>
                    <td><a href="https://www.heidelberg.de/" target="_blank">
                        <img src="_images/logo-heidelberg.jpg" alt="stadt heidelberg" /></a></td>
                </tr>
            </table>
            <p>&nbsp;</p>
            <p>&nbsp;</p>
        </div>
        <div class="wrapper">
            <hr />
        </div>
        <div class="wrapper">
            <div class="pad main-right">
                <div class="col col-45">
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
                </div>
                <div class="col col-10">&nbsp;</div>
                <div class="col col-45">
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
    </div>

</asp:Content>

