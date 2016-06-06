using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class _SiteMaster_AdminMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["UserId"] != null && Session["UserId"].ToString() != "")
        {
            lblUname.Text = Session["UserName"].ToString();
        }
        else 
        {
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());
        }
        //else
        //{
        //    //lbl_UserName.Text = Session["UserName"].ToString();
        //}

        if (Session["UserRoleId"] != null && Session["UserRoleId"].ToString() == "1")
            appAdminMenu.Visible = true; 
        if (Session["UserRoleId"] != null && Session["UserRoleId"].ToString() == "2")
            cityAdminMenu.Visible = true;
        if (Session["UserRoleId"] != null && Session["UserRoleId"].ToString() == "3")
            schoolAdminMenu.Visible = true;
        if (Session["UserRoleId"] != null && Session["UserRoleId"].ToString() == "4")
            classAdminMenu.Visible = true;
        if (Session["UserRoleId"] != null && Session["UserRoleId"].ToString() == "5")
            studentMenu.Visible = true;
    }

    protected void lnkLogout_Click(object sender, EventArgs e)
    {
        FormsAuthentication.SignOut();
        Session["UserId"] = "";
        Session.Abandon();
        Response.Redirect(FormsAuthentication.LoginUrl);
    }
}
