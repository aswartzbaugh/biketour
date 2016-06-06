using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ChangePassword_ChangePassword : System.Web.UI.Page
{

    BCUser objUser = new BCUser();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());
        try
        {
            lblmsg.Visible = false;
        }
        catch (Exception)
        {}
    }
    protected void BtnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable _dt = objUser.GetUserInfo(Convert.ToInt32(Session["LoginId"].ToString()));
            if (_dt != null && _dt.Rows.Count > 0)
            {
                if (txtCurrentPassword.Text.Trim() == _dt.Rows[0]["Password"].ToString())
                {
                    int result = objUser.ChangePassword(txtConfirm.Text, Convert.ToInt32(Session["LoginId"].ToString()));
                    if (result > 0)
                    {

                        HttpCookie ce = new HttpCookie("result");
                        ce.Value = "Passwordchange";
                        Response.Cookies.Add(ce);
                        Response.Redirect("HomePage.aspx");

                    } 
                    else
                    {
                        lblmsg.Visible = true;
                        lblmsg.Text = (string)GetLocalResourceObject("PasswordChangeFailed");
                       
                    }
                }
                else
                {
                    lblmsg.Visible = true;
                    lblmsg.Text = (string)GetLocalResourceObject("PasswordWarning");
                    
                }
            }
            else
            {
              
                lblmsg.Visible = true;
                lblmsg.Text = (string)GetLocalResourceObject("PasswordWarning");
            }
        }
        catch (Exception ex)
        {}
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Response.Redirect("~/ControlPanel/Home.aspx");
        }
        catch (Exception)
        {}
    }
    protected void txtCurrentPassword_TextChanged(object sender, EventArgs e)
    {
        try
        {
            lblmsg.Visible = false;
        }
        catch (Exception)
        {}
    }
}