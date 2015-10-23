using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Data;
using System.Configuration;
using System.Xml.Linq;

public partial class ClassAdmin_StagePlan : System.Web.UI.Page
{
    BCClassAdmin objClassAdmin = new BCClassAdmin();
    decimal totalDistance = 0;
    decimal totalDistanceCovered = 0;

    string ServiceUri, ServiceUri2;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (grdStagePlan.Rows.Count == 0)
        {
            SetStartCity();
        }

        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            if (Session["SchoolId"] != null && Session["ClassId"] != null)   //Application["SchoolId"] != null && Application["ClassId"] != null)
            {
                try
                {
                    ddlSchool.SelectedValue = Session["SchoolId"].ToString();
                    ddlSchool.DataTextField = "School";
                    ddlSchool.DataValueField = "SchoolId";
                    ddlSchool.DataBind();
                    ddlClass.SelectedValue = Session["ClassId"].ToString();
                    ddlClass.DataTextField = "ClassName";
                    ddlClass.DataValueField = "classid";
                    ddlClass.DataBind();
                    try
                    {
                        ddlClass_SelectedIndexChanged(sender, e);
                    }
                    catch (Exception ex)
                    {

                    }
                }
                catch (Exception)
                {}
            }
            //ddlToCity.Items.Insert(0, new ListItem("Select city", "0"));
            //hdnStagePlanId.Value = "0";

            if (Request.Cookies["LegDeleted"] != null)
            {
                string popupScript = "alert('Letzte Etappe gelöscht.');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

                HttpCookie ce = Request.Cookies["LegDeleted"];
                ce.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(ce);
            }
        }
    }

    public void SetStartCity()
    {
        if (ddlClass.Items.Count > 0)
        {
            int StartCity = objClassAdmin.GetStartCity(Convert.ToInt32(ddlClass.SelectedValue));
            if (StartCity > 0)
            {
                ddlFromCity.SelectedValue = StartCity.ToString();
            }
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

        if (grdStagePlan.DataKeys[lastRowIndex]["Status"].ToString().ToLower().Equals("not started") || grdStagePlan.DataKeys[lastRowIndex]["Status"].ToString().ToLower().Equals("noch nicht gestartet"))
        {
            int stagePlanId = Convert.ToInt32(grdStagePlan.DataKeys[lastRowIndex]["StagePlanId"].ToString());
            objClassAdmin.DeleteLastLeg(stagePlanId);
            totalDistance = 0;
            totalDistanceCovered = 0;
            _BindData();
            grdStagePlan.DataBind();
            if (grdStagePlan.Rows.Count == 0)
            {
                SetStartCity();
            }

            HttpCookie ce1 = new HttpCookie("LegDeleted");
            ce1.Value = "Letzte Etappe gelöscht.";
            Response.Cookies.Add(ce1);
            Response.Redirect("StagePlan.aspx");
        }
        else
        {
            string popupScript = "alert('Leg hat bereits begonnen. Kann nicht gelöscht werden.');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
    }

    protected void btnAddRoute_Click(object sender, EventArgs e)
    {
        //DataTable _dt = new DataTable();
        //_dt = objClassAdmin.GetLatLong(Convert.ToInt32(ddlFromCity.SelectedValue), Convert.ToInt32(ddlToCity.SelectedValue));

        try
        {
            int result = objClassAdmin.SaveStagePlan(Convert.ToInt32(hdnStagePlanId.Value), Convert.ToInt32(hdnClassId.Value),
             Convert.ToInt32(ddlFromCity.SelectedValue), Convert.ToInt32(ddlToCity.SelectedValue));

            if (result > 0)
            {

                _BindData();
                string popupScript = "alert('Etappe erfolgreich hinzugefügt');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //grdStagePlan.DataBind();
            }
            else
            {
                string popupScript = "alert('Operation failed!');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }

            totalDistance = 0;
            totalDistanceCovered = 0;
            grdStagePlan.DataBind();
        }
        catch (Exception)
        {}
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        try
        {

            Response.Redirect("~/ControlPanel/Home.aspx");
        }
        catch (Exception)
        {}
    }

    protected void ddlFromCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e); 
        ViewStateUserKey = Session.SessionID;
    }

    private void _BindToCity(string fromCityId, string classId)
    {
        try
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
        catch (Exception)
        {}
    }

    protected void ddlRadius_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlRadius.SelectedIndex != 0)
                _BindToCity(ddlFromCity.SelectedValue, hdnClassId.Value);
            else
                ddlToCity.Items.Clear();

            ddlToCity.Items.Insert(0, new ListItem(" Stadt", "0"));
        }
        catch (Exception)
        {}
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlClass.SelectedIndex != 0)
            {
                Session["SchoolId"] = ddlSchool.SelectedValue;
                Session["ClassId"] = ddlClass.SelectedValue;
                _BindData();
            }
            else
            {
                pnlContent.Visible = false;
            }
        }
        catch (Exception)
        {
         }
    }

    private void _BindData()
    {
        try
        {
            lblClassHeader.Text = ddlSchool.SelectedItem.Text + " - " + ddlClass.SelectedItem.Text;
            pnlContent.Visible = true;
            hdnClassId.Value = ddlClass.SelectedValue;
            totalDistance = 0;
            totalDistanceCovered = 0;
            grdStagePlan.DataBind();
            if (grdStagePlan != null && grdStagePlan.Rows.Count > 0)
            {
                GridViewRow lRow = grdStagePlan.Rows[grdStagePlan.Rows.Count - 1];
                //string fromCityId = (lRow.FindControl("lblFromCityId") as Label).Text;
                string toCityId = (lRow.FindControl("lblToCityId") as Label).Text;
                Remove();
                BindMap();
                ddlFromCity.SelectedValue = toCityId;
                ddlFromCity.DataTextField = "CityName";
                ddlFromCity.DataValueField = "CityId";
                ddlFromCity.DataBind();
                btnDeleteLastLeg.Visible = true;

            }
            else
            {
                string cityId = objClassAdmin.GetCityIdFromClassId(ddlClass.SelectedValue);
                if (ddlFromCity.Items.FindByValue(cityId) != null)
                    ddlFromCity.SelectedValue = cityId;
                Remove();
                BindMap();
                if (grdStagePlan.Rows.Count == 0)
                {
                    SetStartCity();
                }
                btnDeleteLastLeg.Visible = false;
            }

            ddlFromCity.Enabled = false;
            ddlRadius.ClearSelection();
            ddlToCity.Items.Clear();
            ddlToCity.Items.Insert(0, new ListItem(" Stadt", "0"));
            ddlToCity.ClearSelection();

        }
        catch (Exception ex)
        {}

            
      
    }

    public string setcomm(object prs)
    
    {
        string price = Convert.ToString(prs);
        price.Replace(",", ".");
          return price;
    }

    
    private void BindMap()
    {
        GoogleMapForASPNet1.GoogleMapObject.APIKey = ConfigurationManager.AppSettings["GoogleAPIKey"];
        //Specify width and height for map. You can specify either in pixels or in percentage relative to it's container.
        GoogleMapForASPNet1.GoogleMapObject.Width = "620px"; // You can also specify percentage(e.g. 80%) here
        GoogleMapForASPNet1.GoogleMapObject.Height = "350px";
        DataTable dat1 = new DataTable();
        GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 5;
        GooglePoint GP = new GooglePoint();
        dat1.Columns.Add("Lattitude", typeof(double));
        dat1.Columns.Add("Longitude", typeof(double));
        GooglePolyline PL1 = new GooglePolyline();
        PL1.Width = 5;
        PL1.ColorCode = "Blue";
        int i = Convert.ToInt32(grdStagePlan.Rows.Count.ToString()) + 1;
        GooglePoint[] Gpoint = new GooglePoint[i + 1];
        List<string> City = new List<string>();
        bool frmCity = false;
        bool toCity = false;
        int objCont = 0;
      
        if (grdStagePlan.Rows.Count > 0)
        {
            for (int Count = 0; Count < grdStagePlan.Rows.Count; Count++)
            {
                string FromCity, ToCity = string.Empty;
                float FromCitylat, FromCitylon, ToCitylog, ToCitylat = 0;
                try
                {

                    FromCity = ((Label)grdStagePlan.Rows[Count].FindControl("lblFromCity")).Text;
                    ToCity = ((Label)grdStagePlan.Rows[Count].FindControl("lblToCity")).Text;
                    FromCitylat = float.Parse(grdStagePlan.Rows[Count].Cells[6].Text);
                    FromCitylon = float.Parse(grdStagePlan.Rows[Count].Cells[7].Text);
                    ToCitylat = float.Parse(grdStagePlan.Rows[Count].Cells[8].Text);
                    ToCitylog = float.Parse(grdStagePlan.Rows[Count].Cells[9].Text);
                    if (FromCity != null && !City.Contains(FromCity))
                    {

                        City.Add(FromCity);
                        Gpoint[objCont] = new GooglePoint();
                        Gpoint[objCont].InfoHTML = FromCity;
                        Gpoint[objCont].Latitude = FromCitylat;
                        Gpoint[objCont].Longitude = FromCitylon;
                        GoogleMapForASPNet1.GoogleMapObject.Points.Add(Gpoint[objCont]);
                        dat1.NewRow();
                        dat1.Rows.Add(Gpoint[objCont].Latitude, Gpoint[objCont].Longitude);
                        PL1.Points.Add(Gpoint[objCont]);
                        frmCity = true;
                        objCont++;
                    }
                    if (ToCity != null && !City.Contains(ToCity))
                    {

                        Gpoint[objCont] = new GooglePoint();
                        Gpoint[objCont].InfoHTML = ToCity;
                        Gpoint[objCont].Latitude = ToCitylat;
                        Gpoint[objCont].Longitude = ToCitylog;
                        GoogleMapForASPNet1.GoogleMapObject.Points.Add(Gpoint[objCont]);
                        dat1.NewRow();
                        City.Add(ToCity);
                        dat1.Rows.Add(Gpoint[objCont].Latitude, Gpoint[objCont].Longitude);
                        PL1.Points.Add(Gpoint[objCont]);
                        frmCity = false;
                        objCont++;

                    }



                }
                catch (Exception ex)
                { }
                GoogleMapForASPNet1.GoogleMapObject.Polylines.Add(PL1);


            }
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
        else
        {
            GooglePoint GP0 = new GooglePoint();
            GP0.Latitude = 51.165691;
            GP0.Longitude = 10.451526;
            GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 5;
            GoogleMapForASPNet1.GoogleMapObject.CenterPoint = new GooglePoint("1", GP0.Latitude, GP0.Longitude);
        }
   

    }

    private void CoordinatesGeocode(string FromCity)
    {
        if (string.IsNullOrEmpty(FromCity))
            throw new ArgumentNullException("FromCity");
        string requestUriString = string.Format(ServiceUri, Uri.EscapeDataString(FromCity));
        HttpWebRequest request = (HttpWebRequest)HttpWebRequest.Create(requestUriString);
        try
        {
            WebResponse response = request.GetResponse();
            XDocument xdoc = XDocument.Load(response.GetResponseStream());
            // Verify the GeocodeResponse status
            string status = xdoc.Element("GeocodeResponse").Element("status").Value;
            XElement locationElement = xdoc.Element("GeocodeResponse").Element("result").Element("geometry").Element("location");
            double latitude = (double)locationElement.Element("lat");
            double longitude = (double)locationElement.Element("lng");




        }
        catch (WebException ex)
        {
            switch (ex.Status)
            {
                //case WebExceptionStatus.NameResolutionFailure:
                //    throw new ServiceOfflineException("The Google Maps geocoding service appears to be offline.", ex);
                //default:
                //    throw;
            }
        }
    }

    public void  BindGermayMap()
    {
         GooglePoint GP0 = new GooglePoint();
            GP0.Latitude = 51.165691;
            GP0.Longitude = 10.451526;
            GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 5;
            GoogleMapForASPNet1.GoogleMapObject.CenterPoint = new GooglePoint("1", GP0.Latitude, GP0.Longitude);
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

    private void ValidateGeocodeResponseStatus(string status, string address)
        {
      //  switch (status)
      //  {
      //  //case "ZERO_RESULTS":
      //  string message = string.Format("No coordinates found for address \"{0}\".", address);
      // // throw new UnknownAddressException(message);
      //  case "OVER_QUERY_LIMIT":
      ////  throw new OverQueryLimitException();
      //  case "OK":
      //  break;
      //  default:
      //  throw new Exception("Unkown status code: " + status + ".");
      //  }
        }

    
    
    protected void grdStagePlan_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            totalDistance += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Distance"));
            totalDistanceCovered += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Distance_Covered"));
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[2].Text = "Gesamtstrecke:";
            e.Row.Cells[3].Text =  (totalDistanceCovered.ToString() + " Km / "+ totalDistance.ToString() + " Km").Replace(",",".").ToString();
            e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Left;
            e.Row.Font.Bold = true;

            e.Row.Cells[4].CssClass = "hide";
            e.Row.Cells[5].CssClass = "hide";
        }

        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[4].CssClass = "hide";
            e.Row.Cells[5].CssClass = "hide";
        }
    }
}