using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net;
using System.Data;
using System.Xml.Linq;

public partial class ClassAdmin_Forum : System.Web.UI.Page
{
    BCUser objUser = new BCUser();
    BCStudent objStudent = new BCStudent();
    GooglePoint GP2 = new GooglePoint();
    string ServiceUri, ServiceUri2;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null)
                Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

            if (!IsPostBack)
            {
                if (Session["SchoolId"] != null && Session["ClassId"] != null)   //Application["SchoolId"] != null && Application["ClassId"] != null)
                {
                    ddlSchool.SelectedValue = Session["SchoolId"].ToString();
                    ddlSchool.DataTextField = "School";
                    ddlSchool.DataValueField = "SchoolId";
                    ddlSchool.DataBind();
                    ddlClass.SelectedValue = Session["ClassId"].ToString();
                    ddlClass.DataTextField = "Class";
                    ddlClass.DataValueField = "ClassId";
                    ddlClass.DataBind();
                    ddlClass_SelectedIndexChanged(sender, e);
                    //ddlClass.DataBind();
                }
                else
                {
                    divForumBlog.Visible = false;
                }
                // ddlSchool.DataBind();
            }
            //  this.MaintainScrollPositionOnPostBack = true;
        }
        catch (Exception)
        { }
    }

    protected void BlogRefreshTimer_Tick(object sender, EventArgs e)
    {
        try
        {
            _BindBlog();

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
        }
        catch (Exception)
        { }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            objUser.SaveBlog(Convert.ToInt32(ddlClass.SelectedValue), 0, Convert.ToInt32(Session["UserId"].ToString()), Convert.ToInt32(Session["UserRoleId"].ToString()),
               Convert.ToInt32(Session["LoginId"].ToString()), txtBlog.Text, Convert.ToInt32(chkShowOnForum.Checked));

            _BindBlog();

            hdnScrollPosition.Value = "0";
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
            txtBlog.Text = "";
            chkShowOnForum.Checked = false;
        }
        catch (Exception)
        { }
    }

    private void _BindData()
    {

        try
        {
            double percentage = 0.0;

            int classId = Convert.ToInt32(ddlClass.SelectedValue);
            int CompleteLegs = objStudent.GetCompleteLegCount(classId);

            DataSet ds = objStudent.GetCurrentStageInfo(Convert.ToInt32(Session["UserId"].ToString()), Convert.ToInt32(Session["UserRoleId"].ToString()), classId);
            if ((ds != null && ds.Tables[0].Rows.Count > 0) || (CompleteLegs > 0))
            {
                divForumBlog.Visible = true;
                divForumBlog.Style.Add("Width", "700px");
                div_NoStagePlan.Visible = false;
                lblCongratulations1.Visible = false;
                lblCongratulations3.Visible = false;

                if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                {
                    lblStage.Text = (string)GetLocalResourceObject("CurrentStage") + "<br/>";
                    lblCurrentStage.Text = ds.Tables[0].Rows[0]["StartCity"].ToString() +
                        " => " + ds.Tables[0].Rows[0]["EndCity"].ToString();
                    string FromCity = "../CityImages/" + ds.Tables[0].Rows[0]["FromCityimage"].ToString();
                    string ToCity = "../CityImages/" + ds.Tables[0].Rows[0]["ToCityimage"].ToString();

                    if (ds.Tables[0].Rows[0]["FromCityimage"].ToString() != "")
                    {
                        imgFromCity.ImageUrl = FromCity;
                    }
                    else
                    {
                        imgFromCity.ImageUrl = "../CityImages/noImageBig.png";
                    }

                    imgFromCity.ToolTip = ds.Tables[0].Rows[0]["StartCity"].ToString();

                    if (ds.Tables[0].Rows[0]["ToCityimage"].ToString() != "")
                    {
                        imgToCity.ImageUrl = ToCity;
                    }
                    else
                    {
                        imgToCity.ImageUrl = "../CityImages/noImageBig.png";
                    }
                    imgToCity.ToolTip = ds.Tables[0].Rows[0]["EndCity"].ToString();


                    if (ds.Tables[0].Rows[0]["lastreachedcity"].ToString() != "")
                    {
                        lblCongratulations2.Text = ds.Tables[0].Rows[0]["lastreachedcity"].ToString();
                        lblCongratulations1.Visible = true;
                        lblCongratulations3.Visible = true;
                    }

                    double sm2 = double.Parse(ds.Tables[0].Rows[0]["Distance_Covered"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                    double sm3 = double.Parse(ds.Tables[0].Rows[0]["Distance"].ToString(), System.Globalization.CultureInfo.InvariantCulture);

                    lblDistanceCovered.Text = (Math.Round(sm2, 2).ToString() + " km " + (string)GetLocalResourceObject("From") + " " +
                        Math.Round(sm3, 2).ToString() + " km " + (string)GetLocalResourceObject("driven") + "").Replace(",", ".").ToString();

                    percentage = ((sm2 * 100) / sm3);
                    Remove();
                    // _BindMap(ds.Tables[0].Rows[0]["StartCity"].ToString(), ds.Tables[0].Rows[0]["EndCity"].ToString(), percentage);
                    _BindMap(ds.Tables[0].Rows[0]["StartCity"].ToString(), ds.Tables[0].Rows[0]["EndCity"].ToString(), percentage, Convert.ToDouble(ds.Tables[0].Rows[0]["FromCityLat"].ToString()), Convert.ToDouble(ds.Tables[0].Rows[0]["FromCityLong"].ToString()), Convert.ToDouble(ds.Tables[0].Rows[0]["ToCityLat"].ToString()), Convert.ToDouble(ds.Tables[0].Rows[0]["ToCityLong"].ToString()));
                }
                else
                {
                    if (CompleteLegs > 0)
                    {
                        DataTable dtLStage = objStudent.GetLastCompleteStageInfo(Convert.ToInt32(Session["UserId"].ToString()), Convert.ToInt32(Session["UserRoleId"].ToString()), classId);
                        if (dtLStage.Rows.Count > 0)
                        {
                            lblCurrentStage.Text = (string)GetLocalResourceObject("LastStage") + "<br/>" + dtLStage.Rows[0]["StartCity"].ToString() +
                                " => " + dtLStage.Rows[0]["EndCity"].ToString();

                            string FromCity = "../CityImages/" + dtLStage.Rows[0]["FromCityimage"].ToString();
                            string ToCity = "../CityImages/" + dtLStage.Rows[0]["ToCityimage"].ToString();

                            if (dtLStage.Rows[0]["FromCityimage"].ToString() != "")
                            {
                                imgFromCity.ImageUrl = FromCity;
                            }
                            else
                            {
                                imgFromCity.ImageUrl = "../CityImages/noImageBig.png";
                            }

                            imgFromCity.ToolTip = dtLStage.Rows[0]["FromCityimage"].ToString();

                            if (dtLStage.Rows[0]["ToCityimage"].ToString() != "")
                            {
                                imgToCity.ImageUrl = ToCity;
                            }
                            else
                            {
                                imgToCity.ImageUrl = "../CityImages/noImageBig.png";
                            }
                            imgToCity.ToolTip = dtLStage.Rows[0]["ToCityimage"].ToString();

                            try
                            {
                                double sm2 = double.Parse(dtLStage.Rows[0]["Distance_Covered"].ToString().Replace(@",", "."), System.Globalization.CultureInfo.InvariantCulture);
                                double sm3 = double.Parse(dtLStage.Rows[0]["Distance"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                percentage = ((sm2 * 100) / Convert.ToDouble(dtLStage.Rows[0]["Distance"]));

                                lblDistanceCovered.Text = (Math.Round(sm2, 2).ToString() + " km " + (string)GetLocalResourceObject("From") + " " +
                                Math.Round(sm3, 2).ToString() + " km " + (string)GetLocalResourceObject("driven") + "").Replace(",", ".").ToString();
                            }
                            catch (Exception ex)
                            { }
                            Remove();
                            _BindMap(dtLStage.Rows[0]["StartCity"].ToString(), dtLStage.Rows[0]["EndCity"].ToString(), percentage, Convert.ToDouble(dtLStage.Rows[0]["FromCityLat"].ToString()), Convert.ToDouble(dtLStage.Rows[0]["FromCityLong"].ToString()), Convert.ToDouble(dtLStage.Rows[0]["ToCityLat"].ToString()), Convert.ToDouble(dtLStage.Rows[0]["ToCityLong"].ToString()));
                        }
                    }
                }


                if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {

                    h1_ClassForum.InnerHtml = (string)GetLocalResourceObject("ClassForum") + " - " + ds.Tables[1].Rows[0]["School"].ToString();
                    BindGermanyMap(); // Remove();
                }
                if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
                {
                    lbtnCityInfo.Visible = true;
                    lbtnCityInfo.PostBackUrl = "~/Student/CityInfo.aspx?cityid=" + ds.Tables[2].Rows[0]["cityInfoCityId"].ToString() +
                        "&cityname=" + ds.Tables[2].Rows[0]["cityname"].ToString() + "&parent=city";
                    // Remove();
                }
            }
            else
            {
                BindGermanyMap();
                div_NoStagePlan.Visible = true;
                pnlContent.Visible = false;
                divForumBlog.Visible = true;
                divForumBlog.Style.Add("Width", "100%");
            }
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Bind Data");
        }
    }

    private void BindGermanyMap()
    {
        try
        {
            GooglePoint GP0 = new GooglePoint();
            GP0.Latitude = 51.165691;
            GP0.Longitude = 10.451526;
            GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 3;
            GoogleMapForASPNet1.GoogleMapObject.CenterPoint = new GooglePoint("1", GP0.Latitude, GP0.Longitude);
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Bind Google Map Default Germany ");
        }
    }

    private void _BindMap(string startCity, string endCity, double percentage, double startcitylat, double startcitylong, double endCitylat, double endCitylong)
    {
        try
        {
            dlBlog.DataBind();
            GoogleMapForASPNet1.GoogleMapObject.APIKey = ConfigurationManager.AppSettings["GoogleAPIKey"];
            //Specify width and height for map. You can specify either in pixels or in percentage relative to it's container.
            GoogleMapForASPNet1.GoogleMapObject.Width = "700px"; // You can also specify percentage(e.g. 80%) here
            GoogleMapForASPNet1.GoogleMapObject.Height = "350px";
            //Specify initial Zoom level.
            GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 6;
            double centerlat;
            double ceterlong;
            GooglePoint GP1 = new GooglePoint();
            GP1.ID = "GP1";

            if (startCity != null)
            {

                double latitude = startcitylat;
                double longitude = startcitylong;
                GP1.Latitude = latitude;
                GP1.Longitude = longitude;
                GP1.InfoHTML = startCity;
                GoogleMapForASPNet1.GoogleMapObject.Points.Add(GP1);

            }

            GooglePoint GP2 = new GooglePoint();
            GP2.ID = "GP2";
            //Chemnitz
            if (endCity != null)
            {

                double latitude = endCitylat;
                double longitude = endCitylong;
                GP2.Latitude = latitude; //49.8776483;    
                GP2.Longitude = longitude; // 8.6517617;
                GP2.InfoHTML = endCity;
                GoogleMapForASPNet1.GoogleMapObject.Points.Add(GP2);

            }

            GooglePoint Gp3 = new GooglePoint();
            // End City Lat & long Max Test
            if (GP1.Latitude < GP2.Latitude && GP1.Longitude < GP2.Longitude)
            {
                Gp3.Latitude = GP1.Latitude + (Math.Abs(GP2.Latitude - GP1.Latitude) * percentage / 100);
                Gp3.Longitude = GP1.Longitude + (Math.Abs(GP2.Longitude - GP1.Longitude) * percentage / 100);
            }
            else
            { //Start City Lat & Long Max 
                if (GP1.Latitude > GP2.Latitude && GP1.Longitude > GP2.Longitude)
                {
                    Gp3.Latitude = GP1.Latitude - (Math.Abs(GP2.Latitude - GP1.Latitude) * percentage / 100);
                    Gp3.Longitude = GP1.Longitude - (Math.Abs(GP2.Longitude - GP1.Longitude) * percentage / 100);
                }
                else
                {  //Start city Lat max & long Mini  Test
                    if (GP1.Latitude > GP2.Latitude && GP1.Longitude < GP2.Longitude)
                    {
                        Gp3.Latitude = GP1.Latitude - (Math.Abs(GP2.Latitude - GP1.Latitude) * percentage / 100);
                        Gp3.Longitude = GP1.Longitude + (Math.Abs(GP2.Longitude - GP1.Longitude) * percentage / 100);
                    }
                    else
                    {  //start city lat Min & long Max  Test
                        if (GP1.Latitude < GP2.Latitude && GP1.Longitude > GP2.Longitude)
                        {
                            Gp3.Latitude = GP1.Latitude + (Math.Abs(GP2.Latitude - GP1.Latitude) * percentage / 100);
                            Gp3.Longitude = GP1.Longitude - (Math.Abs(GP2.Longitude - GP1.Longitude) * percentage / 100);
                        }
                    }
                }
            }

            Gp3.IconImage = "../_images/cycle.png";
            GoogleMapForASPNet1.GoogleMapObject.Points.Add(Gp3);
            if (GP1.Latitude > GP2.Latitude)
                centerlat = GP2.Latitude;
            else
                centerlat = GP1.Latitude;
            if (GP1.Longitude > GP2.Longitude)
                ceterlong = GP2.Longitude;
            else
                ceterlong = GP1.Longitude;

            //GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 146;
            GoogleMapForASPNet1.GoogleMapObject.CenterPoint = new GooglePoint("1", centerlat, ceterlong);
            GooglePolyline PL1 = new GooglePolyline();
            PL1.ID = "PL1";
            //Give Hex code for line color
            PL1.ColorCode = "#0000FF";
            //Specify width for line
            PL1.Width = 5;

            PL1.Points.Add(GP1);
            PL1.Points.Add(GP2);
            GoogleMapForASPNet1.GoogleMapObject.Polylines.Add(PL1);

        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Bind Google Map & Cycle ");
        }
    }

    private void Remove()
    {
        try
        {
            GoogleMapForASPNet1.GoogleMapObject.Polylines.Clear();
            GooglePoint GP2 = new GooglePoint();

            GoogleMapForASPNet1.GoogleMapObject.Points.Clear();
            string startCity = string.Empty;
            string endCity = string.Empty;
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, " Remove Point From Google Map ");
        }

    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlClass.SelectedIndex != 0)
            {
                Session["SchoolId"] = ddlSchool.SelectedValue;
                Session["ClassId"] = ddlClass.SelectedValue;
                pnlContent.Visible = true;
                _BindData();
                _BindBlog();

                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
            }
            else
            {
                pnlContent.Visible = false;
            }
        }
        catch (Exception ex)
        { }
    }

    protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            pnlContent.Visible = false;
        }
        catch (Exception)
        { }
    }

    private void _BindBlog()
    {
        try
        {
            sdsForum.SelectParameters.Clear();
            sdsForum.SelectCommandType = SqlDataSourceCommandType.StoredProcedure;
            sdsForum.SelectCommand = "SP_GET_FORUMBLOG";
            sdsForum.SelectParameters.Add("UserId", Session["UserId"].ToString());
            sdsForum.SelectParameters.Add("UserRoleId", Session["UserRoleId"].ToString());
            sdsForum.SelectParameters.Add("ClassId", ddlClass.SelectedValue);
            dlBlog.DataSourceID = "sdsForum";
            dlBlog.DataBind();
            if (dlBlog.Items.Count == 0)
                btnDeleteAll.Visible = false;
            else
                btnDeleteAll.Visible = true;
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Bind Blog");
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                try
                {
                    objUser.DeleteBlog(Convert.ToInt32(hdnBlogId.Value));

                    //string popupScript = "alert('Blog deleted successfully.');";
                    //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                    string msg = (string)GetLocalResourceObject("BlogDeleted");
                    string popupScript = "alert('" + msg + "');";
                    ClientScript.RegisterStartupScript(this.GetType(), "script", popupScript, true);
                    _BindBlog();

                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
                    
                }
                catch (Exception ex)
                {
                    Helper.Log(ex.Message, "Delete Blog");
                    //errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
                }
            }
        }
        catch (Exception ex)
        { }

    }
    protected void dlBlog_EditCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            dlBlog.EditItemIndex = e.Item.ItemIndex;
            TextBox txtBlogTextEdit = (TextBox)dlBlog.Items[1].FindControl("txtBlogTextEdit");
            _BindBlog();
            BlogRefreshTimer.Enabled = false;

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
        }
        catch (Exception ex)
        { }
        //txtBlogTextEdit.Focus();
    }
    protected void dlBlog_CancelCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            dlBlog.EditItemIndex = -1;
            _BindBlog();
            BlogRefreshTimer.Enabled = true;

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
        }
        catch (Exception ex)
        { }
    }
    protected void dlBlog_UpdateCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            int blogId = Convert.ToInt32(dlBlog.DataKeys[e.Item.ItemIndex]);
            string blogText = ((TextBox)e.Item.FindControl("txtBlogTextEdit")).Text;
            objUser.UpdateBlog(blogId, blogText);
            dlBlog.EditItemIndex = -1;
            _BindBlog();
            BlogRefreshTimer.Enabled = true;

            ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
        }
        catch (Exception)
        { }
    }

    protected void lbtnUpload_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("UploadGpx.aspx");
        }
        catch (Exception)
        { }
    }


    protected void btnDeleteAllBlogs_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                try
                {
                    // objUser.DeleteAllBlog(Convert.ToInt32(ddlClass.SelectedValue));

                    //string popupScript = "alert('Blog deleted successfully.');";
                    //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                    // _BindBlog();
                    ClientScript.RegisterStartupScript(this.GetType(), "script", "ConfirmAll();", true);
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
                }
                catch (Exception ex)
                {
                    Helper.Log(ex.Message, "All Delete Blog");
                    //errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
                }
            }
        }
        catch (Exception ex)
        { }
    }
    protected void btnDeleteAll_Click(object sender, EventArgs e)
    {
        try
        {
            if (ddlClass.SelectedValue != "0")
            {
                 objUser.DeleteAllBlog(Convert.ToInt32(ddlClass.SelectedValue));
                _BindBlog();
                string msg = (string)GetLocalResourceObject("BlogDeleted");
                string popupScript = "alert('" + msg + "');";
                ClientScript.RegisterStartupScript(this.GetType(), "script", popupScript, true);
            }
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "All Delete Blog");
            //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
        }
    }
}