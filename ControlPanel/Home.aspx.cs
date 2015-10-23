using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!Page.IsPostBack)
            {
                if (Request.Cookies["result"] != null)
                {
                    if (Request.Cookies["result"].Value == "Passwordchange")
                    {
                        HttpCookie ce = Request.Cookies["result"];
                        ce.Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies.Add(ce);
                        string popupScript = "alert('Password Changed Succesfully  ');";
                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

                    }

                }
            }
        }
        catch (Exception)
        { }

    }
}