using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Configuration;

public partial class Support : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            mailLink.HRef = "mailto:" + ConfigurationManager.AppSettings["SupportEmail"].ToString();
            mailLink.InnerText = ConfigurationManager.AppSettings["SupportEmail"].ToString();
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        try
        {
            StringBuilder SbSendMailBody = new StringBuilder();
            SbSendMailBody.Append("<p>Dear Admin,</p>");
            SbSendMailBody.Append("<p>" + txtEmail.Text + " Wrote:</p>");
            SbSendMailBody.Append("<p>    - " + txtComments.Text.Trim() + ",</p>");
            Helper.SendSupportMail("Support Query - BikeTour", SbSendMailBody.ToString(), ConfigurationManager.AppSettings["SupportEmail"], txtEmail.Text);
            lblMessage.Visible = true;
            txtEmail.Text = "";
            txtComments.Text = "";
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message);
            Response.End();
        }
    }
}