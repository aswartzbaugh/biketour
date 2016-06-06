using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Collections;

public partial class SiteMaster_Start : System.Web.UI.MasterPage
{
    BCAppAdmin bcadmin = new BCAppAdmin();
    BCImageLink objImageLink = new BCImageLink();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            _bindblog();
            _GetImage();
        }
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
        bindHighScore();
    }
    private void bindHighScore()
    {
        DataTable dt = new DataTable();
       
        dt = bcadmin.HighScore(Convert.ToInt32(ddlCity.SelectedItem.Value));
        if (dt.Rows.Count > 0)
        {
            dlsore.DataSource = dt;
            dlsore.DataBind();
        }
        else
        {
            lblmsg.Visible = true;
            lblmsg.Text = "No Data ";
        }

    }

    private void _GetImage()
    {
       
        DataTable _dt = new DataTable();
        _dt = objImageLink.RotateImageLink();
   
        dlImages.DataSource = _dt;
        dlImages.DataBind();

        
    }
}
