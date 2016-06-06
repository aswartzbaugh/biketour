using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Configuration;

public partial class AppAdmin_AddCityContent : System.Web.UI.Page
{
    BCAppAdmin objAdmin = new BCAppAdmin();

    public DataTable dtImages
    {
        get
        {
            object o = this.ViewState["dtImages"];
            return o as DataTable;
        }
        set { this.ViewState["dtImages"] = value; }
    }

    public string GetImageURL(string imageName, string cityId)
    {
        string s = Request.Url.ToString();
        if (imageName != "")
        {
            if (Request.Url.Host.ToString().ToLower().Contains("localhost"))
                return "http://" + Request.Url.Host + ":" + Request.Url.Port + "/biketour_2203/Pictures/City/" + cityId + "/" + imageName;
            else
                return "http://" + Request.Url.Host + ":" + Request.Url.Port + "/Pictures/City/" + cityId + "/" + imageName;
        }
        else
            return "";
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            if (Request.QueryString["cityname"] != null && Request.QueryString["cityid"] != null)
            {
                lblCityName.Text = Request.QueryString["cityname"].ToString();
                hdnCityId.Value = Request.QueryString["cityid"].ToString();
                this.dtImages = new DataTable();
                _BindCityContents(Convert.ToInt32(Request.QueryString["cityid"]));

            }
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("CityList.aspx");
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        _Save();

        HttpCookie ce = new HttpCookie("ContentSaved");
        ce.Value = (string)GetLocalResourceObject("MsgCitySaved");//City contents saved successfully.
        Response.Cookies.Add(ce);

        Response.Redirect("CityList.aspx");
    }

    protected void btnUploadPicture_Click(object sender, EventArgs e)
    {

        if (fuPictureUpload.FileName != null)
        {
            if (fuPictureUpload.HasFile)
            {
                string imageFileName = fuPictureUpload.FileName;
                FileInfo fi = new FileInfo(imageFileName);
                string ext = fi.Extension;

                if (ext.ToLower().Equals(".png") || ext.ToLower().Equals(".jpg") || ext.ToLower().Equals(".jpeg") || ext.ToLower().Equals(".bmp") || ext.ToLower().Equals(".gif"))
                {
                    string targetPath = Request.MapPath(@"~\\Pictures");//with complete path
                    string NewFileName = hdnCityId.Value.ToString() + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + ext;

                    if (!Directory.Exists(targetPath + "\\City"))
                    {
                        Directory.CreateDirectory(targetPath + "\\City");
                    }

                    targetPath = targetPath + "\\City";

                    if (!Directory.Exists(targetPath + "\\" + hdnCityId.Value))
                    {
                        Directory.CreateDirectory(targetPath + "\\" + hdnCityId.Value);
                    }

                    targetPath = targetPath + "\\" + hdnCityId.Value;

                    if (File.Exists(targetPath + "\\" + NewFileName))
                    {
                        string popupScript = "alert('File already exists.');";
                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                        return;
                    }
                    else
                        fuPictureUpload.PostedFile.SaveAs(targetPath + "\\" + NewFileName);

                    string imagePath = targetPath + "\\" + NewFileName;
                    string s = AppDomain.CurrentDomain.BaseDirectory;
                    imagePath = "~\\" + imagePath.Replace(s, "");

                    DataTable dt = new DataTable();
                    dt.Columns.AddRange(new DataColumn[]{new DataColumn("CityId"), 
                                    new DataColumn("ImageName"),new DataColumn("ImagePath"), new DataColumn("ImageText")});

                    if (dtImages != null && dtImages.Rows.Count > 0)
                        dt = dtImages;

                    DataRow lRow = dt.NewRow();
                    lRow["CityId"] = hdnCityId.Value;
                    lRow["ImagePath"] = imagePath;
                    lRow["ImageText"] = "";
                    lRow["ImageName"] = NewFileName;
                    dt.Rows.Add(lRow);
                    dt.AcceptChanges();
                    this.dtImages = dt;
                    dlPictures.DataSource = dtImages;
                    dlPictures.DataBind();
                }
                else
                {
                    string popupScript = "alert('" + (string)GetLocalResourceObject("MsgUploadFile") + "');";//Please upload valid file.
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                }
            }
            //else
            //{
            //    string popupScript = "alert('Please Select File.');";
            //    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            //}
        }
        else
        {
            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgSelectFile") + "');";//Please Select File.
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
         }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button btnDelete = sender as Button;
        string imageName = btnDelete.CommandArgument.Split(',')[0];
        string imagePath = btnDelete.CommandArgument.Split(',')[1];
        DataRow lRow = dtImages.Select("ImageName='" + imageName + "'")[0];
        lRow.Delete();

        // Delete image row from datatable
        dtImages.AcceptChanges();
        dlPictures.DataSource = dtImages;
        dlPictures.DataBind();

        // Delete image from folder
        imagePath = AppDomain.CurrentDomain.BaseDirectory + imagePath.Replace("~\\", "");
        
        if (File.Exists(imagePath))
            File.Delete(imagePath);

        // Delete image from database
        _DeleteImage(imageName);
    }

    private void _DeleteImage(string imageName)
    {
        objAdmin.DeleteImage(Convert.ToInt32(hdnCityId.Value), imageName);
    }

    private void _Save()
    {
        try
        {
            int result = 0;
            //Save Image contents except images
            result = objAdmin.InsertUpdateCityContents(Convert.ToInt32(hdnCityId.Value), txtCityInfo.Text, txtVideoUrl.Text);

            // Save Images
            foreach (DataListItem item in dlPictures.Items)
            {
                string imageName = (item.FindControl("hdnImageName") as HiddenField).Value;
                string imageInfo = (item.FindControl("txtImageInfo") as TextBox).Text;
                string imageUrl = (item.FindControl("imgCity") as Image).ImageUrl;
                objAdmin.InsertUpdateImages(Convert.ToInt32(hdnCityId.Value), imageName, imageUrl, imageInfo);
            }
        }
        catch (Exception)
        { }
        
    }

    private void _BindCityContents(int cityId)
    {
        try
        {
            DataSet ds = objAdmin.GetCityContents(cityId);
            DataTable CityInfo = objAdmin.GetParticipatingCityInfo(cityId);

            if (CityInfo.Rows.Count > 0)
            {
                float FromCitylat = float.Parse(CityInfo.Rows[0]["lat"].ToString());
                float FromCitylon = float.Parse(CityInfo.Rows[0]["long"].ToString());
                BindMap(FromCitylat, FromCitylon, CityInfo.Rows[0]["CityName"].ToString());
            }

            string targetPath = Request.MapPath(@"~\\Pictures");

            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                {
                    txtCityInfo.Text = ds.Tables[0].Rows[0]["CityInfo"].ToString();
                    txtVideoUrl.Text = ds.Tables[0].Rows[0]["VideoURL"].ToString();

                    if (txtVideoUrl.Text != "")
                    {
                        string code = txtVideoUrl.Text.Split('=')[1];
                        string url = "https://www.youtube.com/embed/" + code;// +"?autoplay=1";
                        ifrm.Attributes["src"] = url;
                        div_Video.Visible = true;
                    }
                }
                if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {
                    dtImages = ds.Tables[1];
                    dlPictures.DataSource = dtImages;
                    dlPictures.DataBind();

                    if (Directory.Exists(Request.MapPath("~\\Pictures\\City\\" + cityId)))
                    {
                        DirectoryInfo di = new DirectoryInfo(Request.MapPath("~\\Pictures\\City\\" + cityId));
                        FileInfo[] files = null;
                        string searchPattern = "*.*";
                        files = di.GetFiles(searchPattern, SearchOption.TopDirectoryOnly);

                        if (files != null)
                        {
                            foreach (FileInfo f in files)
                            {
                                if ((dtImages.Select("ImageName='" + f.Name + "'")).Length == 0)
                                {
                                    //f.Delete();
                                }
                            }
                        }
                    }
                }
                else
                {
                    if (Directory.Exists(Request.MapPath("~\\Pictures\\City\\" + cityId)))
                    {
                        DirectoryInfo di = new DirectoryInfo(Request.MapPath("~\\Pictures\\City\\" + cityId));
                        di.Delete(true);
                    }
                }
            }
        }
        catch (Exception ex)
        {}
        
    }

    protected void btnVideoUpload_Click(object sender, EventArgs e)
    {
        try
        {
            string code = txtVideoUrl.Text.Split('=')[1];
            string url = "https://www.youtube.com/embed/" + code;// +"?autoplay=1";
            ifrm.Attributes["src"] = url;
            div_Video.Visible = true;
        }
        catch (Exception ex)
        {
            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgValidURL") + "');";//Please enter valid URL
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }

    }
    protected void btnDelete_Click1(object sender, EventArgs e)
    {
        try
        {
            hdnCityId.Value = Request.QueryString["cityid"].ToString();
            int cityId = Convert.ToInt32(hdnCityId.Value);
            string videoURL = "";
            int result = 0;
            result = objAdmin.DeleteVideocity(cityId, videoURL);
            if (result == 1)
            {
                txtVideoUrl.Text = "";
                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgDeleteURL") + "');";//URL Delete successfully
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                _BindCityContents(cityId);
            }
            else
            {
                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgTryAgagin") + "');";//Please Try again!
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }
        }
        catch (Exception ex)
        { }

    }

    private void BindMap(float Citylat, float Citylon, string CityName)
    {
        div_Map.Visible = true;
        GoogleMapForASPNet1.GoogleMapObject.APIKey = ConfigurationManager.AppSettings["GoogleAPIKey"];
        //Specify width and height for map. You can specify either in pixels or in percentage relative to it's container.
        GoogleMapForASPNet1.GoogleMapObject.Width = "500px"; // You can also specify percentage(e.g. 80%) here
        GoogleMapForASPNet1.GoogleMapObject.Height = "300px";
        DataTable dat1 = new DataTable();
        GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 5;
        GooglePoint GP = new GooglePoint();
        dat1.Columns.Add("Lattitude", typeof(double));
        dat1.Columns.Add("Longitude", typeof(double));
        GooglePolyline PL1 = new GooglePolyline();
        PL1.Width = 5;
        PL1.ColorCode = "Blue";
        
        GooglePoint[] Gpoint = new GooglePoint[1];
        List<string> City = new List<string>();
        
        Gpoint[0] = new GooglePoint();
        Gpoint[0].InfoHTML = CityName;
        Gpoint[0].Latitude = Citylat;
        Gpoint[0].Longitude = Citylon;
        GoogleMapForASPNet1.GoogleMapObject.Points.Add(Gpoint[0]);

        GoogleMapForASPNet1.GoogleMapObject.CenterPoint = new GooglePoint("1", Citylat, Citylon);
        
    }
}