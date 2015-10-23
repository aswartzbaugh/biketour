using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Security;

public partial class Login : System.Web.UI.Page
{
    BCUser objUser = new BCUser();
    BCStudent objStudent = new BCStudent();

    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetCacheability(HttpCacheability.NoCache);
        txt_UserName.Focus();
        if (!Page.IsPostBack)
        {
            if (Request.Cookies["cookiename"] != null)
            {
                txt_UserName.Text = Request.Cookies["cookiename"]["LoginName"].ToString();
                 txt_Password.Text = Request.Cookies["cookiename"]["Password"].ToString();
              
                 txt_Password.Attributes.Add("value", txt_Password.Text);
               
            }
            
        }
        
    }

    protected void btn_Login_Click(object sender, EventArgs e)
    {
        try
        {
            DataTable _dt = new DataTable();
            _dt = objUser.GetLoginInfo(txt_UserName.Text.Trim(), txt_Password.Text);

            if (chkRMe.Checked == true)
            {
                HttpCookie cookie = new HttpCookie("cookiename");
                cookie.Values.Add("LoginName",(txt_UserName.Text.Trim()));
                cookie.Values.Add("Password",txt_Password.Text);
                cookie.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Add(cookie);
            }

            if (_dt != null && _dt.Rows.Count > 0)
            {
                _dt = objUser.GetUserInfo(Convert.ToInt32(_dt.Rows[0]["Loginid"].ToString()));
                if (_dt != null && _dt.Rows.Count > 0)
                {
                    if (_dt.Rows[0]["RoleId"].ToString() == "5")
                    {
                        DataTable dtStud = objStudent.GetStudentInfo(Convert.ToInt32(_dt.Rows[0]["UserId"]));
                        if (Convert.ToInt32(dtStud.Rows[0]["IsStatusActive"]) == 1)
                        {
                            Session["LoginId"] = _dt.Rows[0]["LoginId"].ToString();
                            Session["UserId"] = _dt.Rows[0]["UserId"].ToString();
                            Session["UserRole"] = _dt.Rows[0]["UserRole"].ToString();
                            Session["UserRoleId"] = _dt.Rows[0]["RoleId"].ToString();
                            Session["UserEmail"] = _dt.Rows[0]["UserEmail"].ToString();
                            Session["UserName"] = _dt.Rows[0]["UserName"].ToString();
                            Session["UserCityId"] = dtStud.Rows[0]["CityId"].ToString();// dt.Rows[0]["UserCityId"].ToString()

                            Response.Redirect(ConfigurationManager.AppSettings[_dt.Rows[0]["UserRole"].ToString()].ToString());
                        }
                        else
                        {
                            string popupScript = "alert('Your account is Temporarily inactive!');";
                            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                        }
                    }
                    else
                    {
                        Session["LoginId"] = _dt.Rows[0]["LoginId"].ToString();
                        Session["UserId"] = _dt.Rows[0]["UserId"].ToString();
                        Session["UserRole"] = _dt.Rows[0]["UserRole"].ToString();
                        Session["UserRoleId"] = _dt.Rows[0]["RoleId"].ToString();
                        Session["UserEmail"] = _dt.Rows[0]["UserEmail"].ToString();
                        Session["UserName"] = _dt.Rows[0]["UserName"].ToString();

                        objUser.UpdateFirstLogin(Convert.ToInt32(_dt.Rows[0]["Loginid"].ToString()), Convert.ToInt32(_dt.Rows[0]["RoleId"].ToString()));

                        Response.Redirect(ConfigurationManager.AppSettings[_dt.Rows[0]["UserRole"].ToString()].ToString());
                    }
                }
                else
                {
                    string popupScript = "alert('You are not confirmed by class admin. Cannot login.');";
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                }
            }
            else
            {
                div_LoginFailed.Visible = true;
                txt_Password.Text = "";
            }
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }
}