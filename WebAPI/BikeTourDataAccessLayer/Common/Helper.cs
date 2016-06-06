using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourDataAccessLayer.Common
{
    public static class Helper
    {
        public static void sendMailMoreThanAvgSpeed(string Subject, string toEmail, string EmailBody)
        {
            try
            {
                //string path = "";
                string eBody = "";

                SmtpClient sm = new SmtpClient(ConfigurationManager.AppSettings["Smtp"]);
                sm.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["Email"], ConfigurationManager.AppSettings["Password"]);
                sm.DeliveryMethod = SmtpDeliveryMethod.Network;
                sm.EnableSsl = bool.Parse(ConfigurationManager.AppSettings["EnableSsl"]);
                MailMessage objMailMessage = new MailMessage();
                objMailMessage.IsBodyHtml = true;
                objMailMessage.From = new System.Net.Mail.MailAddress(ConfigurationManager.AppSettings["Email"], ConfigurationManager.AppSettings["EmailDisplayName"]);
                objMailMessage.To.Add(new System.Net.Mail.MailAddress(toEmail));
                objMailMessage.Subject = Subject;

                eBody += MailHeader(ConfigurationManager.AppSettings["Email"].ToString(), toEmail).ToString();
                eBody += EmailBody;
                eBody += MailFooter().ToString();

                objMailMessage.Body = eBody;
                sm.Send(objMailMessage);
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        public static StringBuilder MailHeader(string Fromemail, string ToEmail)
        {
            StringBuilder sb1 = new StringBuilder();
            try
            {
                sb1.Append("<div style=\"background-color: #014B7C; padding:0px; width:100%; margin: 0px auto 0px auto; height:auto;\">");
                sb1.Append("<div style=\"width:100%; \">");
                sb1.Append(" <div >");


                sb1.Append("<div style=\"float:left; width:154px;\">");
                sb1.Append("<img src='http://tourdeeurope.eu/_images/NewImages/logo_adfc.png' />");
                sb1.Append("</div>");
                sb1.Append("<div style=\"clear:both;\">");
                sb1.Append("</div>");
                sb1.Append("</div>");

                sb1.Append("<div style=\"clear:both;\">");
                sb1.Append("</div>");
                sb1.Append("<div style=\"width:88%; height:auto; margin: 0px auto 0px auto; background-color: #fff; padding: 10px;\" >");
                sb1.Append("<span style=\"font-weight:bold;\">From:</span> <span>" + Fromemail + "</span><br />");
                sb1.Append("<span style=\"font-weight:bold;\">To:</span> <span>" + ToEmail + "</span>");
                sb1.Append("<br />");

                return sb1;
            }
            catch (Exception)
            {
                return null;
            }

        }
        public static StringBuilder MailFooter()
        {
            StringBuilder sb1 = new StringBuilder();
            try
            {
                sb1.Append("</div>");
                sb1.Append("</div>");

                sb1.Append("<br />");
                sb1.Append("</div>");
                return sb1;
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
