using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default : System.Web.UI.Page
{
    BCAppAdmin bcadmin = new BCAppAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
        GetData("12");
        }
    }

    public void GetData(String Id)
    {
        DataTable dt = new DataTable();
        dt = bcadmin.HighScore(Convert.ToInt32(Id));
        if (dt.Rows.Count > 0)
        {
            //lblmsg.Visible = false;
            dlsore.DataSource = dt;
            dlsore.DataBind();
        }
        else
        {
            dlsore.DataSource = null;
            dlsore.DataBind();
        //    lblmsg.Visible = true;
          //  lblmsg.Text = "No High Score For This City";
        }
       



    }
}