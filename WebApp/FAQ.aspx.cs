using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using AjaxControlToolkit.HTMLEditor;

public partial class FAQ : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                _BindFAQ();
            }
            //  this.MaintainScrollPositionOnPostBack = true;
        }
        catch (Exception)
        { }
    }

    private void _BindFAQ()
    {
        try
        {
            sdsForum.SelectParameters.Clear();
            sdsForum.SelectCommandType = SqlDataSourceCommandType.Text;
            sdsForum.SelectCommand = "Select * FrOM FAQ WHERE ISActive=1";
            grd_FAQList.DataSourceID = "sdsForum";
            grd_FAQList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Bind Blog");
        }
    }

    protected void grd_FAQList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grd_FAQList.PageIndex = e.NewPageIndex;
            _BindFAQ();
        }
        catch (Exception)
        { }
    }
   
}