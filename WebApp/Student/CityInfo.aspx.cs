using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Student_CityInfo : System.Web.UI.Page
{
    BCAppAdmin objAdmin = new BCAppAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if(!IsPostBack)
        {
            if (Request.QueryString["cityname"] != null && Request.QueryString["cityid"] != null)
            {
                lblCityName.Text = Request.QueryString["cityname"].ToString();
                _BindCityContents(Convert.ToInt32(Request.QueryString["cityid"]));
            }
        }
    }

    private void _BindCityContents(int cityId)
    {
        DataSet ds = objAdmin.GetCityContents(cityId);
        if (ds != null && ds.Tables.Count > 0)
        {
            if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
            {
                txtLatitude.Text = ds.Tables[0].Rows[0]["lat"].ToString().Replace(",", ".");
                txtLongitude.Text = ds.Tables[0].Rows[0]["long"].ToString().Replace(",", ".");
                lblCityInfo.Text = ds.Tables[0].Rows[0]["CityInfo"].ToString().Replace(System.Environment.NewLine, "<br/>");

                if (ds.Tables[0].Rows[0]["VideoURL"].ToString() != "")
                {
                    string code = ds.Tables[0].Rows[0]["VideoURL"].ToString().Split('=')[1];
                    string url = "https://www.youtube.com/embed/" + code;// +"?autoplay=1";
                    ifrm.Attributes["src"] = url;
                }
            }
            if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
            {
                dlPictures.DataSource = ds.Tables[1];
                dlPictures.DataBind();
            }
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        string parent = Request.QueryString["parent"].ToString();
        if (parent == "student")
        {
            Response.Redirect("~/Student/Forum.aspx");
        }
        else if (parent == "city")
        {
            Response.Redirect("~/CityAdmin/Forum.aspx");
        }
        else if (parent == "class")
        {
            Response.Redirect("~/ClassAdmin/Forum.aspx");
        }
    }
}