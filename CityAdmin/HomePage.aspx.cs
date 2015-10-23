using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CityAdmin_HomePage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());
        if (Request.Cookies["result"] != null)
        {
            if (Request.Cookies["result"].Value == "Passwordchange")
            {
                HttpCookie ce = Request.Cookies["result"];
                ce.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(ce);
                string popupScript = "alert('Passwort geändert Erfolgreich');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

            }

        }
    }
}