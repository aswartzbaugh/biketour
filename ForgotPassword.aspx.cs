using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Web.Security;

public partial class ForgotPassword : System.Web.UI.Page
{
    BCUser objUser = new BCUser();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            pnlMessage.Visible = false;
            pnlRequest.Visible = true;
        }
    }
    protected void btnRequest_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                DataTable _dt = objUser.GetNewPassword(txtEmail.Text);

                if (_dt != null && _dt.Rows.Count > 0)
                {
                    string newPassword = _dt.Rows[0]["NewPassword"].ToString();
                    string userName = _dt.Rows[0]["UserName"].ToString();
                    string email = _dt.Rows[0]["UserEmail"].ToString();
                    string subject = ConfigurationManager.AppSettings["ForgotPasswordMailSubject"];
                    string emailBody = "Hello @UserName," +
                                "<br /><br />" +
                                "A new password was just generated for your account." +
                                "<br /><br />" +
                                "Your account details are:<br />" +
                                "Email: @Email<br />" +
                                "Password: @Password" +
                                "<br /><br />" +
                                "In the interest of your own security you should change<br />" +
                                "your password immediately after logging in the next time.";

                    emailBody = emailBody.Replace("@UserName", userName);
                    emailBody = emailBody.Replace("@Email", email);
                    emailBody = emailBody.Replace("@Password", newPassword);

                    //Helper.SendMail(subject, emailBody, "284manali@gmail.com");
                    Helper.SendSupportMail(subject, emailBody, email, "no-reply@tourdeeurope.eu");

                    pnlMessage.Visible = true;
                    pnlRequest.Visible = false;
                }
                else
                {
                    string popupScript = "alert('Please Enter Correct Email ID');";
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

                }
            }
            catch (Exception)
            {}
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect(FormsAuthentication.LoginUrl);
    }
}