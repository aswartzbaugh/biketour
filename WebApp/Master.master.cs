using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class Master : System.Web.UI.MasterPage
{
    BCAppAdmin bcadmin = new BCAppAdmin();
    BCImageLink objImageLink = new BCImageLink();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //_bindblog();
            //_GetImage();

           
          //  sLoad();
        }
        
    }
    //private void sLoad()
    //{
    //    #region Featureed Wearouse Gallery
    //    DataTable dt = new DataTable();
    //    dt = objImageLink.RotateImageLink();
    //    if (dt.Rows.Count > 0)
    //    {
    //        //  int HomePageImageId = Convert.ToInt32(dt.Rows[0]["ImageName"]);

    //        StringBuilder sbcrousel = new StringBuilder();

    //        for (int i = 0; i < dt.Rows.Count; i++)
    //        {
    //            //sbcrousel.Append("<li><a href=\"#\"><img  data-large='ImgTemp/GetImages.ashx?ShowHomeImageId=" + Convert.ToInt32(ds.Rows[i]["ShowHomeImageId"]) + "' src='ImgTemp/GetImages.ashx?ShowHomeImageId=" + Convert.ToInt32(ds.Rows[i]["ShowHomeImageId"]) + "' alt='' /></a></li>");
    //            //  if (i % 2 == 0)
    //            sbcrousel.Append("<li><a href=" + dt.Rows[i]["ImageLink"].ToString() + " target=\"_blank \" title=" + dt.Rows[i]["ImageText"].ToString() + "><img src='./LinkImages/" + dt.Rows[i]["ImageName"].ToString() + "  ' alt='' height='100px'/></a></li>");
    //            //<li><a href="+ dt.Rows[i]["ImageLink"].ToString() + " target=\"_blank\"><img src='./LinkImages/" + dt.Rows[i]["ImageName"].ToString() + "  ' alt='' height='100px'/></a></li>");
    //            //   else
    //            //    sbcrousel.Append("<li><a href=\"#\"><img src='./LinkImages/" + dt.Rows[i]["ImageName"].ToString() + " +" + dt.Rows[i]["ImageLink"].ToString() + " + " + dt.Rows[i]["ImageText"].ToString() + "' alt='' height='100px'/></a></li>");
    //            //+ " + dt.Rows[i]["ImageLink"].ToString() + " + " + dt.Rows[i]["ImageText"].ToString() + "
    //        }

    //        LitGalImges.Text = sbcrousel.ToString();
    //    }
      //  #endregion
   // }
    

    
}
