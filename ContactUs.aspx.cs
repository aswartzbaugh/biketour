using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Configuration;

public partial class ContactUs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblEmail.Text = ConfigurationManager.AppSettings["AdminEmail"].ToString();
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
            Helper.SendMail("Contact Us Enquiry - BikeTour", SbSendMailBody.ToString(), ConfigurationManager.AppSettings["AdminEmail"]);
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