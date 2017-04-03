<%--//   Google Maps User Control for ASP.Net version 1.0:
//   ========================
//   Copyright (C) 2008  Shabdar Ghata 
//   Email : ghata2002@gmail.com
//   URL : http://www.shabdar.org

//   This program is free software: you can redistribute it and/or modify
//   it under the terms of the GNU General Public License as published by
//   the Free Software Foundation, either version 3 of the License, or
//   (at your option) any later version.

//   This program is distributed in the hope that it will be useful,
//   but WITHOUT ANY WARRANTY; without even the implied warranty of
//   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//   GNU General Public License for more details.

//   You should have received a copy of the GNU General Public License
//   along with this program.  If not, see <http://www.gnu.org/licenses/>.

//   This program comes with ABSOLUTELY NO WARRANTY.
--%>
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="GoogleMapForASPNet.ascx.cs" Inherits="GoogleMapForASPNet" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
  <asp:ScriptManagerProxy id="proxy1" runat="server">
 <Services>
    <asp:ServiceReference Path="~/UserControl/GService.asmx" />
  </Services>
  </asp:ScriptManagerProxy>


<div id="GoogleMap_Div" class="centerMap" style="width:<%=GoogleMapObject.Width %>;height:<%=GoogleMapObject.Height %>;">

</div>
<div id="directions_canvas">

</div>

<script type='text/javascript' src='https://maps.googleapis.com/maps/api/js?v=3&amp;key=<%=ConfigurationManager.AppSettings["GoogleAPIKey"] %>'></script>
<script type='text/javascript' src="../_js/GoogleMapAPIWrapper.js"></script>
<script type='text/javascript'>
    //Load map on window start
    google.maps.event.addDomListener(window, 'load', DrawGoogleMap);
</script>

