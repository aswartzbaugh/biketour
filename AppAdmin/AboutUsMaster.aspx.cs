using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AppAdmin_AddCityContent : System.Web.UI.Page
{
    BCAppAdmin objBCApp = new BCAppAdmin();
    int Success;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            DataTable dtAbout = new DataTable();
            dtAbout = objBCApp.GetAboutUs();
            if (dtAbout.Rows.Count > 0)
            {
                txtEDescription.Content = dtAbout.Rows[0]["Description"].ToString();
            }
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Success = objBCApp.InsertDiscription(txtEDescription.Content.Replace("'", "&#39;").Trim());
        lblMessage.Text = (string)GetLocalResourceObject("AboutUsMessage"); //"Description Updated Successfully!";
    }
}