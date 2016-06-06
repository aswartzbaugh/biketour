using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Xml;
using System.IO;
using System.Xml.XPath;
using System.Xml.Linq;

public partial class AppAdmin_ParticipatingCityAdmin : System.Web.UI.Page
{
    BCAppAdmin objAdmin = new BCAppAdmin();
    BCAppAdmin objAppAdmin = new BCAppAdmin();
    DataTable dt = new DataTable();

    //DOLUser objUser = new DOLUser();
    //BCStudent objStudent = new BCStudent();
    string ServiceUri;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            txt_City.Visible = false;
            //rfv_City.Enabled = false;
        }
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        try
        {
            string imageName = "";
            int CityId = 0, res = 0;
            string action = "Insert";
            string FromCity = string.Empty;
            if (hdn_CityId.Value != "")
            {
                CityId = Convert.ToInt32(hdn_CityId.Value);
                action = "Update";
                // ddlCity.SelectedItem.Value = hdn_CityId.Value;
            }

            if (txt_City.Text.Trim() != null)
            {
                //FromCity = txt_City.Text.Trim() +",Germany";
                double latitude = 0;
                double longitude = 0;

                if (hdnLatitude.Value != "")
                {
                    latitude = double.Parse(hdnLatitude.Value, System.Globalization.CultureInfo.InvariantCulture);
                }
                if (hdnLongitude.Value != "")
                {
                    longitude = double.Parse(hdnLongitude.Value, System.Globalization.CultureInfo.InvariantCulture);
                }

                if (action == "Update")
                {
                    if (fuCityImage.HasFile)
                    {
                        imageName = fuCityImage.PostedFile.FileName;
                        fuCityImage.SaveAs(Server.MapPath("../CityImages/" + imageName));
                    }
                    else
                    {
                        imageName = hdnImageName.Value;
                    }
                }
                else
                {
                    if (fuCityImage.HasFile)
                    {
                        imageName = fuCityImage.PostedFile.FileName;
                        fuCityImage.SaveAs(Server.MapPath("../CityImages/" + imageName));
                    }
                }
                if (latitude > 0 && longitude > 0)
                {
                    //InsertUpdateParicipatingCities(int CityId, string CityName, string CityNameGerman, bool isPartcipating, double lat, double longt)
                    res = objAdmin.InsertUpdateParicipatingCities(Convert.ToInt32(CityId), txt_City.Text.Trim(), txt_CityGer.Text.Trim(), imageName, chkIsParticipating.Checked, latitude, longitude, txtMapText.Text);

                    if (res > 0)
                    {
                        if (CityId == 0)
                        {
                            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgAddCity") + "');";//City added successfully!
                            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                        }
                        else
                        {
                            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgUpdateCity") + "');";//City details updated successfully!
                            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                        }

                        if (action == "Insert")
                        {
                            DataTable dtCities = objAppAdmin.GetCitiesList(res);

                            if (dtCities.Rows.Count > 0)
                            {
                                try
                                {
                                    for (int i = 0; i < dtCities.Rows.Count; i++)
                                    {
                                        //double dist = CalculateDistance(dtCities.Rows[i]["CityName"].ToString() + ", Germany", txt_City.Text + ", Germany");
                                        double dist = CalculateDistance(dtCities.Rows[i]["lat"].ToString().Replace(",", ".") + "," + dtCities.Rows[i]["long"].ToString().Replace(",", "."), hdnLatitude.Value.ToString() + "," + hdnLongitude.Value.ToString());

                                        if (dist > 0)
                                        {
                                            int opt = objAppAdmin.InsertCityDistance(Convert.ToInt32(dtCities.Rows[i]["CityId"]), res, Convert.ToInt32(dist));
                                        }
                                    }
                                }
                                catch (Exception ex) { }
                            }
                        }
                        //grd_CityList.DataBind();
                        _Bind();
                        hdn_CityId.Value = "";
                        pnl_CityList.Visible = true;
                        pnl_AddCity.Visible = false;
                        imgImage.Visible = false;
                        imgImage.ImageUrl = "";
                        txtSearchBox.Text = "";
                        _Bind();
                    }
                    else
                    {
                        string popupScript = "alert('" + (string)GetLocalResourceObject("MsgAlreadyCity") + "');";//City already exits!
                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript + "GetLocations();", true);
                    }
                }
                else
                {
                    string popupScript = "alert('" + (string)GetLocalResourceObject("MsgInvalidCity") + "');";//Invalid city name!
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                }
            }
        }
        catch { }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        try
        {
            pnl_AddCity.Visible = false;
            pnl_CityList.Visible = true;
            hdn_CityId.Value = "";
            txt_City.Text = "";
            txt_CityGer.Text = "";
            txtSearchBox.Text = "";
            _Bind();
        }
        catch (Exception)
        { }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                hdn_CityId.Value = ((Button)sender).CommandArgument.ToString();
                DataTable dtCity = objAdmin.GetParticipatingCityInfo(Convert.ToInt32(hdn_CityId.Value));
                if (dtCity.Rows.Count > 0)
                {
                    txt_City.Visible = true;
                    ddlCity.Visible = false;
                    txt_City.Text = dtCity.Rows[0]["CityName"].ToString();
                    txtLatitude.Text = dtCity.Rows[0]["lat"].ToString();
                    hdnLatitude.Value = dtCity.Rows[0]["lat"].ToString();
                    txtLongitude.Text = dtCity.Rows[0]["long"].ToString();
                    hdnLongitude.Value = dtCity.Rows[0]["long"].ToString();
                    txtMapText.Text = dtCity.Rows[0]["MapText"].ToString();
                    txt_CityGer.Text = dtCity.Rows[0]["CityNameGerman"].ToString();
                    hdnImageName.Value = dtCity.Rows[0]["CityImage"].ToString();
                    if (dtCity.Rows[0]["IsParticipatingCity"].ToString() == "True")
                        chkIsParticipating.Checked = true;
                    else
                        chkIsParticipating.Checked = false;
                    btn_Save.Text = (string)GetLocalResourceObject("Update"); //"Update";
                    pnl_AddCity.Visible = true;
                    pnl_CityList.Visible = false;
                    lblCurrentImage.Visible = true;
                    imgImage.Visible = true;
                    imgImage.ImageUrl = "../CityImages/" + hdnImageName.Value;
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", "GetLocations();", true);
                }
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                objAdmin.DeleteParticipatingCity(Convert.ToInt32(hdn_CityId.Value));
                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgDelete") + "');";//City deleted successfully.
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //grd_CityList.DataBind();
                _Bind();
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    protected void btn_AddNew_Click(object sender, EventArgs e)
    {
        try
        {
            txt_CityGer.Text = "";
            btn_Save.Text = (string)GetLocalResourceObject("btn_Save.Text"); //"Save";
            hdn_CityId.Value = "";
            txt_City.Text = "";
            ddlCity.Visible = false;
            txt_City.Visible = true;
            pnl_AddCity.Visible = true;
            pnl_CityList.Visible = false;
            lbtnAddCity.Visible = false;
            // btn_AddNew.Visible = false;
            //   txt_City.Visible = false;
            // rfv_City.Enabled = false;
            // ddlCity.ClearSelection();
            //  ddlCity.Visible = true;
            //  rfvCityDdl.Enabled = true;
        }
        catch (Exception)
        { }

    }
    protected void lbtnAddCity_Click(object sender, EventArgs e)
    {
        try
        {
            txt_City.Visible = true;
            // rfv_City.Enabled = true;
            ddlCity.ClearSelection();
            ddlCity.Visible = false;
            rfvCityDdl.Enabled = false;
        }
        catch (Exception)
        { }
    }
    protected void txtSearchCity_Click(object sender, EventArgs e)
    {
        try
        {
            //grd_CityList.DataBind();
            _Bind();
        }
        catch (Exception)
        { }
    }


    #region Search App Admin Autocomplete
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetCityNames(string prefixText)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BikeTourConnectionString"].ToString());
        con.Open();
        SqlCommand cmd = new SqlCommand("select CityName from CityMaster where CityName like @Name+'%' and IsActive = 1 order by CityName", con);
        cmd.Parameters.AddWithValue("@Name", prefixText);
        SqlDataAdapter da = new SqlDataAdapter(cmd);
        DataTable dt = new DataTable();
        da.Fill(dt);
        List<string> CityNames = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            CityNames.Add(dt.Rows[i][0].ToString());
        }
        return CityNames;
    }
    #endregion
    protected void btn_SearchCancel_Click(object sender, EventArgs e)
    {
        try
        {
            txtSearchBox.Text = "";
            //grd_CityList.DataBind();
            _Bind();
        }
        catch (Exception)
        { }
    }

    private double CalculateDistance(string fromCity, string toCity)
    {
        double output = 0.0;
        try
        {
            string xmlResult = null;

            //Pass request to google api with orgin and destination details
            //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" + TextBox1.Text + "&destinations=" + TextBox2.Text + "&mode=Car&language=us-en&sensor=false");
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" + fromCity + "&destinations=" + toCity + "&mode=Car&language=us-en&sensor=false");

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            //Get response as stream from httpwebresponse
            StreamReader resStream = new StreamReader(response.GetResponseStream());

            //Create instance for xml document
            XmlDocument doc = new XmlDocument();

            //Load response stream in to xml result
            xmlResult = resStream.ReadToEnd();

            //Load xmlResult variable value into xml documnet
            doc.LoadXml(xmlResult);

            //Get specified element value using select single node method and verify it return OK (success ) or failed
            if (doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/status").InnerText.ToString().ToUpper() != "OK")
            {
                //lblResult.Text = "Invalid City Name please try again";
                //return;
            }

            //Get DistanceMatrixResponse element and its values
            XmlNodeList xnList = doc.SelectNodes("/DistanceMatrixResponse");
            foreach (XmlNode xn in xnList)
            {
                if (xn["status"].InnerText.ToString() == "OK")
                {
                    output = double.Parse(doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/distance/text").InnerText.Split(' ')[0], System.Globalization.CultureInfo.InvariantCulture);
                }
            }
        }
        catch (Exception ex)
        {
        }

        return output;
    }

    //protected void btntest_Click(object sender, EventArgs e)
    //{
    //    double dist = CalculateDistance("Mainz, Germany", "Wiesbaden, Germany");
    //}

    protected void grd_CityList_Sorting(object sender, GridViewSortEventArgs e)
    {

    }
    protected void grd_CityList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToLower().Equals("sort"))
        {
            if (this.ViewState["SortExp"] == null)
            {
                this.ViewState["SortExp"] = e.CommandArgument.ToString();
                this.ViewState["SortOrder"] = "ASC";
            }
            else
            {
                if (this.ViewState["SortExp"].ToString() == e.CommandArgument.ToString())
                {
                    if (this.ViewState["SortOrder"].ToString() == "ASC")
                        this.ViewState["SortOrder"] = "DESC";
                    else
                        this.ViewState["SortOrder"] = "ASC";
                }
                else
                {
                    this.ViewState["SortOrder"] = "ASC";
                    this.ViewState["SortExp"] = e.CommandArgument.ToString();
                }
            }

            _Bind();
        }

    }
    protected void grd_CityList_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField ctrl = e.Row.FindControl("hdnisPatrcipating") as HiddenField;
            Label lblIsParticipating = new Label();
            PlaceHolder plcisParticipating = e.Row.FindControl("plcisParticipating") as PlaceHolder;
            if (ctrl.Value.ToLower() == "no")
            {
                lblIsParticipating.Text = GetLocalResourceObject("IsParticipatingNo").ToString();
            }
            if (ctrl.Value.ToLower() == "yes")
            {
                lblIsParticipating.Text = GetLocalResourceObject("IsParticipatingYes").ToString();
            }
            plcisParticipating.Controls.Add(lblIsParticipating);
        }

        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (this.ViewState["SortExp"] != null)
            {
                Image ImgSort = new Image();
                if (this.ViewState["SortOrder"].ToString() == "ASC")
                    ImgSort.ImageUrl = "~/_images/ArrowDown.png";
                else
                    ImgSort.ImageUrl = "~/_images/ArrowUp.png";

                switch (this.ViewState["SortExp"].ToString())
                {
                    case "CityName":
                        PlaceHolder placeholderCityName = (PlaceHolder)e.Row.FindControl("phtgrdCity");
                        placeholderCityName.Controls.Add(ImgSort);
                        break;
                }
            }

        }

    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Image Name");
        dt.Columns.Add("City");
        dt.Columns.Add("Is Participating City");
        dt.Columns.Add("Edit");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }

    private void _Bind()
    {
        try
        {
            if (grd_CityList.DataSourceID.Length >= 1)
                grd_CityList.DataSourceID.Remove(0, grd_CityList.DataSourceID.Length);

            objAppAdmin.CityName = txtSearchBox.Text;
            objAppAdmin.IsParticipating = chkIsParticipatingCity.Checked;

            dt = objAdmin.GetCityListCityMaster(objAppAdmin);


            grd_CityList.DataSourceID = "";

            if (dt == null || dt.Rows.Count == 0)
            {
                dt = _CreateEmptyTable();
            }

            DataView dv = dt.DefaultView;
            if (this.ViewState["SortExp"] == null)
            {
                //this.ViewState["SortExp"] = "make";
                //this.ViewState["SortOrder"] = "ASC";
            }
            else
            {
                dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];
            }

            grd_CityList.DataSource = dv;
            grd_CityList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "CityMaster/_Bind()");
        }

    }

    protected void grd_CityList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grd_CityList.PageIndex = e.NewPageIndex;
            grd_CityList.DataBind();
        }
        catch { }
    }

    protected void btnDeleteCity_Click(object sender, EventArgs e)
    {


        if (Page.IsValid)
        {
            try
            {
                int CityId = Convert.ToInt32(hdn_CityId.Value); // Convert.ToInt32(((Button)sender).CommandArgument.ToString());
                objAdmin.DeleteCity(CityId, Convert.ToInt32(Session["UserId"]));

                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgDelete") + "');";//City deleted successfully.
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //grd_CityList.DataBind();
                _Bind();
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }
}
