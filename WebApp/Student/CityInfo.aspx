<%@ Page Title="Bike Tour - City Information"  Culture="de-DE" UICulture="de-DE"  Language="C#" MasterPageFile="~/SiteMaster/AdminMaster.master" AutoEventWireup="true"
    CodeFile="CityInfo.aspx.cs" Inherits="Student_CityInfo" %>

<%@ Register src="~/UserControl/GoogleMapForASPNet.ascx" tagname="GoogleMapForASPNet" tagprefix="uc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

       <script src="../_js/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="../_js/jquery.colorbox.js" type="text/javascript"></script>
    <link href="../_css/colorbox.css" rel="stylesheet" type="text/css"/>
     <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDY0kkJiTPVd2U7aTOAwhc9ySH6oHxOIYM&sensor=false&language=de" type="text/javascript"></script>
    
   
    <script type="text/javascript">


        //       ---- Google Map--------------------------

        function initialize() {
            var mapProp = {
                center: new google.maps.LatLng(document.getElementById('<%= txtLatitude.ClientID %>').value, document.getElementById('<%= txtLongitude.ClientID %>').value),
                zoom: 8,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(document.getElementById("googleMap")
              , mapProp);
        }

        google.maps.event.addDomListener(window, 'load', initialize);

    </script>
    <style type="text/css">
    


.map
{
    border: 1px solid #CCCCCC;
    width: 100%;
    height: 350px;
    
}

.contents {
    background-color: #FFFFFF;
    border: 1px solid #CCCCCC;
    border-radius: 7px 7px 7px 7px;
    box-shadow: 0 0 10px #999999;
    height: auto;
    margin: 0 auto 20px;
    padding-bottom: 10px;
    width: 100%;
}

.cityInfoText{
    width: 143px;
    height: auto;
    display: block;
    text-align: justify;
    font-weight: normal !important;
}
.picturesWrapp{
    border: 1px solid #666666;
    margin-right: 5px;
    padding:5px;
    width: 145px;
    list-style:none;
    behavior:url('PIE.htc');
    border-radius:5px;
    -moz-border-radius:5px;
    -webkit-border-radius:5px;
    -ms-border-radius:5px;
}
.imgcity{padding:0px;
         margin:0px; 
         }
.imgcity img{padding:0px;
         border: 1px solid #999999;
         margin:0px;
         }
        .infoPara{
            font-family: Arial, Helvetica, sans-serif;
            line-height: 18px;
            text-align: justify;
            font-size: 12px;
            color: #333333;
        }
       
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $("[id$=dlPictures] tr td").attr("valign", "top");

            $(".group3").colorbox({ rel: 'group3', transition: "none", width: "75%", height: "85%" }); 
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<br />
<div class="contents">

   <h5>
    <asp:Label ID="lblCityInformation" runat="server" meta:ResourceKey="lblCityInformation"></asp:Label>
    </h5>
    <asp:TextBox ID="txtLatitude" runat="server" Text="51.0000" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtLongitude" runat="server" Text="9.0000" style="display:none;"></asp:TextBox>

    <div class="AdminContWrap">
        <asp:HiddenField ID="hdnCityId" runat="server" />
        <table width="100%" align="center">
            <tr>
                <td colspan="2" align="center">
                    <asp:Label ID="lblCityName" runat="server" Text="" Font-Size="XX-Large"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:DataList ID="dlPictures" runat="server"  RepeatDirection="Horizontal" DataKeyField="" CssClass="datalist" RepeatColumns="6" >
                                    <ItemTemplate >

                                     <li class="picturesWrapp">
                                     <a class="imgcity group3" href='<%# Eval("ImagePath") %>' Height="120" title='<%# Eval("ImageText") %>'>
                                     
                                     <asp:Image ID="imgCity" runat="server" ImageUrl='<%# Eval("ImagePath") %>' Height="120" title='<%# Eval("ImageText") %>' Width="145" />
                                     </a>  
                                         <div class="clear"></div>
                                     <div class="cityInfo">
                                     <asp:Label ID="lblImageInfo" CssClass="cityInfoText" runat="server" Text='<%# Eval("ImageText") %>'></asp:Label>
                                     
                                     </div>
                                     <asp:HiddenField ID="hdnImageName" runat="server" Value='<%#Eval("ImageName") %>' />
                                                    <asp:HiddenField ID="hdnImagePath" runat="server" Value='<%#Eval("ImagePath") %>' />
                                     
                                     </li>
                                       <%-- <table style="margin-top:0px;">
                                            <tr>
                                                <td >
                                                    
                                                </td>
                                                <td>
                                                    
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    
                                                </td>
                                            </tr>
                                        </table>--%>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <%--<asp:TextBox ID="txtCityInfo" runat="server" TextMode="MultiLine" Wrap="true" Width="100%"></asp:TextBox>--%>
                   <p class="infoPara"> <asp:Label ID="lblCityInfo" runat="server" Text='<%# Eval("CityInfo") %>' ></asp:Label></p><br />
                </td>
            </tr>
            <tr>
                <td align="left" width="50%">
                    <div>
                        <iframe id="ifrm" src="" frameborder="0" runat="server" width="100%" height="350">
                        </iframe>
                    </div>
                </td>
                <td width="50%">
                    <div>
                        <table width="100%" align="center">
                            <tr>
                                <td align="center">
                                    <%--<h5>
                                        Google Map</h5>--%>
                                      <div class="mapwrapp ">
                                  <%--  <img src="_images/NewImages/GermanyMap.png" width="300" />--%>
                                  <div class="map" id="googleMap"></div>
                                     <div class="clear"></div>
                                    </div>
                                      
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
            <tr>
            <td colspan="2" align="right">
                <asp:Button ID="btnBack" runat="server" meta:ResourceKey="btnBack" onclick="btnBack_Click" />
            </td>
            </tr>
        </table>
    </div>
    </div>
</asp:Content>
