using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

public partial class AppAdmin_CityList : System.Web.UI.Page
{
    BCAppAdmin objAppAdmin = new BCAppAdmin();
    DataTable dt = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            _SetCookies();
            _Bind();
        }
    }
    protected void txtSearchCity_Click(object sender, EventArgs e)
    {
        try
        {
            //grdCityList.DataBind();
            _Bind();
        }
        catch (Exception ex)
        {}
            
    }
    #region Search App Admin Autocomplete
    [System.Web.Script.Services.ScriptMethod()]
    [System.Web.Services.WebMethod]
    public static List<string> GetCityNames(string prefixText)
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BikeTourConnectionString"].ToString());
        con.Open();
        SqlCommand cmd = new SqlCommand("select CityName from CityMaster where CityName like +@Name+'%' and IsActive = 1", con);
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
        txtSearchBox.Text = "";
        //grdCityList.DataBind();
        _Bind();
    }

    private void _SetCookies()
    {
        if (Request.Cookies["ContentSaved"] != null)
        {
            HttpCookie ce = Request.Cookies["ContentSaved"];
            ce.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(ce);
            string popupScript = "alert('" + ce.Value + "');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
    }

    protected void grdCityList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
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
                        PlaceHolder placeholderCityName = (PlaceHolder)e.Row.FindControl("phtgrdCityName");
                        placeholderCityName.Controls.Add(ImgSort);
                        break;
                }
            }

        }

    }

    protected void grdCityList_RowCommand(object sender, GridViewCommandEventArgs e)
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

    protected void grdCityList_Sorting(object sender, GridViewSortEventArgs e)
    {
        string s = e.SortExpression.ToString();
        string s2 = e.SortDirection.ToString();
    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("City Name");
        dt.Columns.Add("Content");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }

    private void _Bind()
    {
        try
        {
            if (grdCityList.DataSourceID.Length >= 1)
                grdCityList.DataSourceID.Remove(0, grdCityList.DataSourceID.Length);

            objAppAdmin.CityName = txtSearchBox.Text;

            dt = objAppAdmin.GetCityList(objAppAdmin);


            grdCityList.DataSourceID = "";

            if (dt == null || dt.Rows.Count == 0)
            {
                dt = _CreateEmptyTable();
            }

            DataView dv = dt.DefaultView;
            if (this.ViewState["SortExp"] == null)
            {
                this.ViewState["SortExp"] = "CityName";
                this.ViewState["SortOrder"] = "ASC";
            }
            else
            {
                dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];
            }

            grdCityList.DataSource = dv;
            grdCityList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "CityList/_Bind()");
        }

    }

    protected void grdCityList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdCityList.PageIndex = e.NewPageIndex;
        _Bind();
    }
}