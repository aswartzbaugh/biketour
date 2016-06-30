using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DasProject : System.Web.UI.Page
{
    BCUser objUser = new BCUser();
    public string MapData = "";
    public string ZoomLevelString = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            GetResult();
        }
    }

    protected void GetResult()
    {
        string Latitude = "";
        string Longitude = "";
        //if (Request.QueryString["Latitude"] != "" && Request.QueryString["Longitude"] != null)
        {
            DataTable dt = objUser.GetAllCities();
            if (dt.Rows.Count > 0)
            {
             Latitude = dt.Rows[0]["latitude"].ToString().Replace(',', '.');
                Longitude = dt.Rows[0]["longitude"].ToString().Replace(',', '.');

                MapData += "var mapOptions = { center: new google.maps.LatLng('" + Latitude + "', '" + Longitude + "'), zoom: 4, mapTypeId: google.maps.MapTypeId.ROADMAP };";
                MapData += "var infoWindow = new google.maps.InfoWindow();";
                MapData += "var map = new google.maps.Map(document.getElementById('map-canvas'),  mapOptions);";

                ZoomLevelString += "var cwc2011_venue_data = [";

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    string myLatlng = "myLatlng" + i.ToString();
                    string marker = "marker" + i.ToString();

                    MapData += "var " + myLatlng + " = new google.maps.LatLng('" + dt.Rows[i]["latitude"].ToString().Replace(',', '.') + "', '" + dt.Rows[i]["longitude"].ToString().Replace(',', '.') + "');\n";
                    MapData += "var " + marker + " = new google.maps.Marker({ position: " + myLatlng + ", map: map, title: '" + dt.Rows[i]["CityName"].ToString() + "', animation: google.maps.Animation.DROP });\n";

                    MapData += "google.maps.event.addListener(" + marker + ", 'mouseover', function (e) {";

                    StringBuilder sb = new StringBuilder();
                    sb.Append("<table>");
                    sb.Append("<tr>");
                    sb.Append("<td>");
                    if (dt.Rows[i]["CityImage"].ToString() != "")
                    {
                        sb.Append("<img src=\"CityImages/" + dt.Rows[i]["CityImage"].ToString() + "\" width=80px />");
                    }
                    sb.Append("</td>");
                    sb.Append("<td>&nbsp;</td>");
                    sb.Append("<td>");
                    sb.Append("<b>"+dt.Rows[i]["CityName"].ToString()+"</b><br/>");
                    sb.Append("<span style=display:block;max-width:250px;word-wrap:break-word;>" + dt.Rows[i]["MapText"].ToString() + "</span>");
                    sb.Append("</td>");
                    sb.Append("</tr>");
                    sb.Append("</table>");

                    MapData += "infoWindow.setContent('" + sb.ToString() + "');\n";
                    MapData += "infoWindow.open(map, " + marker + ");\n});";

                    if (i != dt.Rows.Count - 1)
                    {
                        ZoomLevelString += "{ name: '" + dt.Rows[i]["CityName"].ToString() + "', latlng: new google.maps.LatLng(" + dt.Rows[i]["latitude"].ToString().Replace(',', '.') + ", " + dt.Rows[i]["longitude"].ToString().Replace(',', '.') + ") },";
                    }
                    else
                    {
                        ZoomLevelString += "{ name: '" + dt.Rows[i]["CityName"].ToString() + "', latlng: new google.maps.LatLng(" + dt.Rows[i]["latitude"].ToString().Replace(',', '.') + ", " + dt.Rows[i]["longitude"].ToString().Replace(',', '.') + ") }";
                    }
                }

                ZoomLevelString += "];";
                ZoomLevelString += "var latlngbounds = new google.maps.LatLngBounds();";
                ZoomLevelString += " for (var i = 0; i < cwc2011_venue_data.length; i++) {";
                ZoomLevelString += "latlngbounds.extend(cwc2011_venue_data[i].latlng);";
                ZoomLevelString += "}";
                ZoomLevelString += "map.fitBounds(latlngbounds);";
                
            }
            string dT = MapData;
            //if (dT != "")
            //{
            //    map-canvas.Visible = true;
            //}
        }
    }

}