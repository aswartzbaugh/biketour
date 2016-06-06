using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.IO;

public partial class StartPage : System.Web.UI.Page
{
    BCUser objUser = new BCUser();
    public string MapData = "";
    public string ZoomLevelString = "";

    BCAppAdmin bcadmin = new BCAppAdmin();
    BCImageLink objImageLink = new BCImageLink();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ddlCity.SelectedValue == "0")
        {
            ddlCity.DataBind();
            GetData(ddlCity.SelectedValue.ToString());
            lblNoRecord.Visible = true;
            lblmsg.Text = "";
        }
        else
        {
            lblNoRecord.Visible = false;
        }

        if (!IsPostBack)
        {
            GetResult();
            //_bindblog();
            //_GetImage();
           // bindHighScore();
            try
            {
                if (Request.Cookies["ForumCity"] != null)
                {
                    HttpCookie ce1 = Request.Cookies["ForumCity"];
                    string id = ce1.Value;
                    ddlCity.DataBind();
                    ddlCity.SelectedValue = id;
                    GetData(ddlCity.SelectedValue.ToString());
                    ddlCity.DataBind();
                }
            }
            catch { }
            sLoad();
        }
        
    }

    private void sLoad()
    {
        #region Featureed Wearouse Gallery
        DataTable dt = new DataTable();
        dt = objImageLink.RotateImageLink();
        if (dt.Rows.Count > 0)
        {
            //  int HomePageImageId = Convert.ToInt32(dt.Rows[0]["ImageName"]);

            StringBuilder sbcrousel = new StringBuilder();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (dt.Rows[i]["ImageName"].ToString() != "")
                {
                    if (File.Exists(Server.MapPath("LinkImages/" + dt.Rows[i]["ImageName"].ToString())))
                    {
                        sbcrousel.Append("<li><a href=" + dt.Rows[i]["ImageLink"].ToString() + " target=\"_blank \" title=" + dt.Rows[i]["ImageText"].ToString() + "><img src='./LinkImages/" + dt.Rows[i]["ImageName"].ToString() + "  ' alt='' height='100px'/></a></li>");
                    }
                }
            }

            LitGalImges.Text = sbcrousel.ToString();
        }
        #endregion
    }


    private void _bindblog()
    {
        DataTable dt = new DataTable();
        dt = bcadmin.ClassBlog();
        if (dt.Rows.Count > 0)
        {
            dlBlog.DataSource = dt;
            dlBlog.DataBind();
        }
    }
    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Request.Cookies["ForumCity"] != null)
        {
            HttpCookie ce = Request.Cookies["ForumCity"];
            ce.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(ce);
        }

        HttpCookie ce12 = new HttpCookie("ForumCity");
        ce12.Value = ddlCity.SelectedValue.ToString();
        Response.Cookies.Add(ce12);
        GetData(ddlCity.SelectedValue.ToString());
        
    }

    public void GetData(String Id)
    {
            DataTable dt = new DataTable();
            dt = bcadmin.HighScore(Convert.ToInt32(Id));
            if (dt.Rows.Count > 0)
            {
                lblmsg.Visible = false;
                dlsore.DataSource = dt;
                dlsore.DataBind();
            }
            else
            {
                dlsore.DataSource = null;
                dlsore.DataBind();
                lblmsg.Visible = true;
                lblmsg.Text = "No High Score For This City";       
            }
            lblNoRecord.Visible = false;
            if (ddlCity.SelectedValue == "0")
            {
                lblmsg.Text = "";
                lblNoRecord.Visible = true;
            }

        
        
    }
    protected void linkchat_Click(object sender, EventArgs e)
    {

    }
    //private void _GetImage()
    //{
    //    try
    //    {
    //        DataTable _dt = new DataTable();
    //        _dt = objImageLink.RotateImageLink();
    //        dlImages.DataSource = _dt;
    //        dlImages.DataBind();
    //    }
    //    catch (Exception)
    //    {}

    //}
    protected void BlogRefreshTimer_Tick(object sender, EventArgs e)
    {
       
        try
        {
            //_bindblog();
            dlBlog.DataBind();
        }
        catch (Exception)
        {}
    }

    public string GetVisible(object IsDefault)
    {
        try
        {
            if (Convert.ToInt32(IsDefault) == 0)
            {
                return "true";
            }
            else
            {
                return "false";
            }
        }
        catch (Exception ex)
        {
            throw;
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
                MapData += "var map = new google.maps.Map(document.getElementById('dvMap'),  mapOptions);";

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
            if (dT != "")
            {
                dvMap.Visible = true;
            }
        }

    }

}