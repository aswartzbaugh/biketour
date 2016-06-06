using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data;
using System.Configuration;

public partial class ClassAdmin_StagePlan : System.Web.UI.Page
{
    BCClassAdmin objClassAdmin = new BCClassAdmin();
    string ServiceUri;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            ddlToCity.Items.Insert(0, new ListItem("Select city", "0"));
            hdnStagePlanId.Value = "0";
        }

      
    }

    protected void btnOk_Click(object sender, EventArgs e)
    {
        
        
    }
    
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                //objSchoolAdmin.DeleteClassAdmin(Convert.ToInt32(hdn_ClassAdminId.Value));
                //string popupScript = "alert('Class admin deleted successfully.');";
                //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //grd_ClassAdminList.DataBind();
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    protected void btnDeleteLastLeg_Click(object sender, EventArgs e)
    {
        int lastRowIndex = grdStagePlan.Rows.Count - 1;

        if (grdStagePlan.DataKeys[lastRowIndex]["Status"].ToString().ToLower().Equals("not started"))
        {
            int stagePlanId = Convert.ToInt32(grdStagePlan.DataKeys[lastRowIndex]["StagePlanId"].ToString());
            objClassAdmin.DeleteLastLeg(stagePlanId);
            grdStagePlan.DataBind();
            _BindData();
        }
        else
        {
            string popupScript = "alert('Leg has already started. Cannot delete.');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
    }

    protected void btnAddRoute_Click(object sender, EventArgs e)
    {
        int result = objClassAdmin.SaveStagePlan(Convert.ToInt32(hdnStagePlanId.Value), Convert.ToInt32(hdnClassId.Value),
            Convert.ToInt32(ddlFromCity.SelectedValue), Convert.ToInt32(ddlToCity.SelectedValue));

        if (result > 0)
        {
            _BindData();
            string popupScript = "alert('Stage plan leg added successfully!');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
        else
        {
            string popupScript = "alert('Operation failed!');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }

        grdStagePlan.DataBind();
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/ControlPanel/Home.aspx");
    }

    protected void ddlFromCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    private void _BindToCity(string fromCityId, string classId)
    {
        sdsToCity.SelectParameters.Clear();
        sdsToCity.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
        sdsToCity.SelectCommand = "SP_GET_CITIESINRADIUS";
        sdsToCity.SelectParameters.Add("FromCityId", fromCityId);
        sdsToCity.SelectParameters.Add("ClassId", classId);
        sdsToCity.SelectParameters.Add("limit1", ddlRadius.SelectedItem.Value.Split('-')[0]);
        sdsToCity.SelectParameters.Add("limit2", ddlRadius.SelectedItem.Value.Split('-')[1]);
        ddlToCity.DataSourceID = "sdsToCity";
        ddlToCity.DataBind();
    }

    protected void ddlRadius_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlRadius.SelectedIndex != 0)
            _BindToCity(ddlFromCity.SelectedValue, hdnClassId.Value);
        else
            ddlToCity.Items.Clear();

        ddlToCity.Items.Insert(0, new ListItem("Select city", "0"));
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlClass.SelectedIndex != 0)
        {
            _BindData();
        }
        else
        {
            pnlContent.Visible = false;
        }
    }

    private void _BindData()
    {
        lblClassHeader.Text = ddlSchool.SelectedItem.Text + " - " + ddlClass.SelectedItem.Text;
        pnlContent.Visible = true;
        hdnClassId.Value = ddlClass.SelectedValue;
        grdStagePlan.DataBind();
        
            ddlFromCity.DataBind();

            if (grdStagePlan != null && grdStagePlan.Rows.Count > 0)
            {
                GridViewRow lRow = grdStagePlan.Rows[grdStagePlan.Rows.Count - 1];
                //string fromCityId = (lRow.FindControl("lblFromCityId") as Label).Text;
                string toCityId = (lRow.FindControl("lblToCityId") as Label).Text;
                BindMap();
                ddlFromCity.SelectedValue = toCityId;
                btnDeleteLastLeg.Visible = true;

            }
            else
            {
                string cityId = objClassAdmin.GetCityIdFromClassId(ddlClass.SelectedValue);
                if (ddlFromCity.Items.FindByValue(cityId) != null)
                    ddlFromCity.SelectedValue = cityId;

                btnDeleteLastLeg.Visible = false;
            }

            ddlFromCity.Enabled = false;
            ddlRadius.ClearSelection();
            ddlToCity.Items.Clear();
            ddlToCity.Items.Insert(0, new ListItem("Select city", "0"));
            ddlToCity.ClearSelection();

            
      
    }

    private void BindMap()
    {
        try
        {
            Remove();
            GoogleMapForASPNet1.GoogleMapObject.APIKey = ConfigurationManager.AppSettings["GoogleAPIKey"];
            //Specify width and height for map. You can specify either in pixels or in percentage relative to it's container.
            GoogleMapForASPNet1.GoogleMapObject.Width = "700px"; // You can also specify percentage(e.g. 80%) here
            GoogleMapForASPNet1.GoogleMapObject.Height = "350px";
            //Specify initial Zoom level.
            GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 2;
            //Specify Center Point for map. Map will be centered on this point.
            // Run time you can ava of lat or long 
            List<GooglePoint> Gp = new List<GooglePoint>();
            GooglePoint min = new GooglePoint();
            int i = Convert.ToInt32(grdStagePlan.Rows.Count.ToString());
            GooglePoint[] Gpoint = new GooglePoint[i];
            GooglePolyline PL1 = new GooglePolyline();
            List<GooglePoint> Gp2 = new List<GooglePoint>();
            int i2 = Convert.ToInt32(grdStagePlan.Rows.Count.ToString());
            GooglePoint[] Gpoint2 = new GooglePoint[i2];
            GooglePoint min1 = new GooglePoint();
            double centerlat;
            double ceterlong;
            DataTable dat1=new DataTable();
            dat1.Columns.Add("Lattitude", typeof(double));
            dat1.Columns.Add("Longitude", typeof(double));
            DataTable dat2 = new DataTable();
            dat2.Columns.Add("Lattitude", typeof(double));
            dat2.Columns.Add("Longitude", typeof(double));
            PL1.ColorCode = "#0000FF";
            PL1.Width = 5;
            for (int Count = 0; Count <= grdStagePlan.Rows.Count; Count++)
            {
                string FromCity = string.Empty;
                string ToCity = string.Empty;
                 FromCity = ((Label)grdStagePlan.Rows[Count].FindControl("lblFromCity")).Text;
                 ToCity = ((Label)grdStagePlan.Rows[Count].FindControl("lblToCity")).Text;
                if (FromCity != null)
                {
                    Gpoint[Count] = new GooglePoint();
                    Gp.Add(Gpoint[Count]);
                    Gpoint[Count].ID = "Gpoint[Count]";
                    string appId = "dj0yJmk9NUdkWVpoeGhPMHh1JmQ9WVdrOVZXRnFaa0poTm1zbWNHbzlNVEl6TURBek1UYzJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD04Nw--";
                    string url = string.Format("http://where.yahooapis.com/geocode?location={0}&appid={1}", Server.UrlEncode(FromCity), appId);
                    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
                    try
                    {
                        using (WebResponse response = request.GetResponse())
                        {
                            using (DataSet ds = new DataSet())
                            {
                                try
                                {
                                    ds.ReadXml(response.GetResponseStream());
                                    Gpoint[Count].Latitude = double.Parse(ds.Tables["Result"].Rows[0]["Latitude"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                    Gpoint[Count].Longitude = double.Parse(ds.Tables["Result"].Rows[0]["Longitude"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                    GoogleMapForASPNet1.GoogleMapObject.Points.Add(Gpoint[Count]);
                                    Gpoint[Count].InfoHTML=FromCity;
                                    Gpoint[Count].IconImage ="icons/sun.png";
                                    dat1.NewRow();
                                    dat1.Rows.Add(Gpoint[Count].Latitude, Gpoint[Count].Longitude);
                                    response.Close();
                                }
                                catch (Exception ex)
                                { }
                                finally
                                {
                                    ds.Dispose();
                                }

                            }
                        }
                    }
                    catch (Exception ex)
                    {
                    }
                    
                }


                if (ToCity != null)
                {
                    Gpoint2[Count] = new GooglePoint();
                    Gp2.Add(Gpoint[Count]);
                    Gpoint2[Count].ID = "Gpoint2[Count]";
                    string appId = "{ConsumerKey}";
                    string url = string.Format("http://where.yahooapis.com/geocode?location={0}&appid={1}", Server.UrlEncode(ToCity), appId);
                    HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(url);
                    using (WebResponse response = request.GetResponse())
                    {
                        using (DataSet ds = new DataSet())
                        {
                            try
                            {
                                ds.ReadXml(response.GetResponseStream());
                                Gpoint2[Count].Latitude = double.Parse(ds.Tables["Result"].Rows[0]["Latitude"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                Gpoint2[Count].Longitude = double.Parse(ds.Tables["Result"].Rows[0]["Longitude"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                GoogleMapForASPNet1.GoogleMapObject.Points.Add(Gpoint2[Count]);
                                Gpoint2[Count].InfoHTML =ToCity;
                                Gpoint[Count].IconImage = "icons/snow.png";
                                dat2.NewRow();
                                dat2.Rows.Add(Gpoint2[Count].Latitude, Gpoint2[Count].Longitude);
                                response.Close();
                            }
                            catch (Exception ex)
                            { }
                            finally
                            {
                                //ds.Clear();
                                ds.Dispose();
                            }

                        }
                    }
                }
               
                PL1.Points.Add(Gpoint[Count]);
                PL1.Points.Add(Gpoint2[Count]);
                GoogleMapForASPNet1.GoogleMapObject.Polylines.Add(PL1);
              
               
            }

        
            //Plyline Draw 
           // GoogleMapForASPNet1.GoogleMapObject.Polylines.Add(PL1);
            //Google Map Certer 
            Double MinLattitude = Double.MaxValue;
            Double MinLongitude = Double.MaxValue;
            foreach (DataRow dr in dat1.Rows)
            {
                double Lattitude = dr.Field<double>("Lattitude");
                double Longitude = dr.Field<double>("Longitude");
                MinLattitude = Math.Min(MinLattitude, Lattitude);
                MinLongitude = Math.Min(MinLongitude, Longitude);
               
            }

            GoogleMapForASPNet1.GoogleMapObject.CenterPoint = new GooglePoint("1", MinLattitude, MinLongitude);
            
          
        }
        catch (Exception ex)
        {
        }

    }
    public void Remove()
    {
        try
        {
            List<GooglePoint> Gp = new List<GooglePoint>();
            List<GooglePoint> Gp2 = new List<GooglePoint>();
            int i = Convert.ToInt32(grdStagePlan.Rows.Count.ToString());
            GooglePoint[] Gpoint = new GooglePoint[i];
            int i2 = Convert.ToInt32(grdStagePlan.Rows.Count.ToString());
            GooglePolyline PL1 = new GooglePolyline();
            GooglePoint[] Gpoint2 = new GooglePoint[i2];
            Array.Clear(Gpoint, 0, Gpoint.Length);
            Array.Clear(Gpoint2, 0, Gpoint.Length);
            Gp.Clear();
            Gp2.Clear();
            PL1.Points.Clear();
            GoogleMapForASPNet1.GoogleMapObject.Polylines.Clear();
            GoogleMapForASPNet1.GoogleMapObject.Points.Clear();
        }
        catch (Exception)
        {}
    }

    protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
    {
        pnlContent.Visible = false;
    }
}