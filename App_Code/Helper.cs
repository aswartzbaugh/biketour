using System;
using System.Web;
using System.Configuration;
using System.IO;
using System.Web.UI;
using System.Net.Mail;
using System.Net;
using System.Web.UI.WebControls;
//using Telerik.Web.UI.GridExcelBuilder;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Collections.Generic;
using System.Text;

public class Helper
{
    static int Notifcount = 0;
    static int RecentActcount = 0;
    static int DefaultRecentActcount = 0;
    public static Dictionary<string, string> diLoc = new Dictionary<string, string>();
    static public string FromText = "";
    static public string ToText = "";
    static public string SubjectText = "";
    static public string TitleText = "";
    static public string mailBodyText = "";
 

    public static string ConnectionString()
    {
        return ConfigurationManager.ConnectionStrings["BikeTourConnectionString"].ConnectionString;
    }
    public Helper()
    { }
    public static void Show(string message)
    {
        // Cleans the message to allow single quotation marks
        string cleanMessage = message.Replace("'", "\\'");
        string script = "<script type=\"text/javascript\">alert('" + cleanMessage + "');</script>";
        // Gets the executing web page

        Page page = HttpContext.Current.CurrentHandler as Page;
        // Checks if the handler is a Page and that the script isn't allready on the Page
        if (page != null && !page.ClientScript.IsClientScriptBlockRegistered("alert"))
        {
            page.ClientScript.RegisterClientScriptBlock(typeof(Helper), "alert", script);
        }
    }

    public static object SelectRows(DataTable _DataTable, int rows)
    {
        DataTable dtn = _DataTable.Clone();

        for (int i = 0; i < rows; i++)
        {
            dtn.ImportRow(_DataTable.Rows[i]);
        }
        return dtn;
    }


  
    public static bool checkNotif(int rowscount)
    {

        if (Notifcount == 0)
        {
            Notifcount = rowscount;
            return true;
        }
        else
        {
            if (Notifcount < rowscount)
            {
                Notifcount = rowscount;
                return true;
            }
            else
                return false;
        }
    }

    public static bool checkRecentAct(int rowscount)
    {

        if (RecentActcount == 0)
        {
            RecentActcount = rowscount;
            return true;
        }
        else
        {
            if (RecentActcount < rowscount)
            {
                RecentActcount = rowscount;
                return true;
            }
            else
                return false;
        }
    }

    public static bool checkDefaultRecentAct(int rowscount)
    {

        if (DefaultRecentActcount == 0)
        {
            DefaultRecentActcount = rowscount;
            return true;
        }
        else
        {
            if (DefaultRecentActcount < rowscount)
            {
                DefaultRecentActcount = rowscount;
                return true;
            }
            else
                return false;
        }
    }

    public static void sendMail(string Subject, string toEmail, string EmailBody)
    {
        try
        {
            string path = "";
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

        }
    }

    public void sendRegMail(string mailid, string emailbody)
    {
        try
        {
            string body = emailbody;
            SmtpClient sm = new SmtpClient("smtp.gmail.com");
            NetworkCredential NetCry = new NetworkCredential("Dextdumy2011@gmail.com", "dumy2011");
            sm.Credentials = NetCry;
            sm.EnableSsl = true;
            MailMessage mm = new MailMessage("dextdumy2011@gmail.com", mailid, "", body);
            mm.IsBodyHtml = true;
            sm.Send(mm);
        }
        catch (Exception ex)
        {
            throw;
        }
    }

    public static void sendMailMoreThanAvgSpeed(string Subject, string toEmail, string EmailBody)
    {
        try
        {
            string path = "";
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

    public static void ClearInputs(ControlCollection ctrls)
    {
        foreach (Control ctrl in ctrls)
        {
            if (ctrl is TextBox)
                ((TextBox)ctrl).Text = string.Empty;
            ClearInputs(ctrl.Controls);
        }
        foreach (Control item in ctrls)
        {
            if (item is DropDownList)
            {
                ((DropDownList)item).ClearSelection();
                ((DropDownList)item).DataBind();
            }
        }
        foreach (Control item in ctrls)
        {
            if (item is RadioButtonList)
            {
                ((RadioButtonList)item).ClearSelection();
                ((RadioButtonList)item).DataBind();
            }
        }
       
    }


    public static void RebindDropDown(DropDownList _drp)
    {
        if (_drp is DropDownList)
        {
            ((DropDownList)_drp).ClearSelection();
            ((DropDownList)_drp).DataBind();
        }
    }

    public static void Log(string _Exception, string Comment)
    {
        try
        {
            string appPath = HttpContext.Current.Request.ApplicationPath;
            string mypath = HttpContext.Current.Request.MapPath(appPath);
            mypath = mypath + "\\App_Data\\Log.txt";
            FileStream fs = new FileStream(mypath, FileMode.Open, FileAccess.ReadWrite, FileShare.ReadWrite);
            StreamWriter sw = new StreamWriter(fs);
            sw.WriteLine(Comment + " : " + DateTime.Now.ToString() + " " + _Exception + "\\n\\n");
            sw.Close();
            fs.Close();
        }
        catch (Exception ex)
        {
            
        }
    }
    public static void LogDoubel(double _Exception, string Comment)
    {
        try
        {
            string appPath = HttpContext.Current.Request.ApplicationPath;
            string mypath = HttpContext.Current.Request.MapPath(appPath);
            mypath = mypath + "\\App_Data\\Log.txt";

            FileStream aFile = new FileStream(mypath, FileMode.Append, FileAccess.Write);
            StreamWriter sw = new StreamWriter(aFile);
            sw.Write(DateTime.Now.ToString() + " - " + Comment + " : " + _Exception + "\n");
            sw.Close();
            aFile.Close();
        }
        catch (Exception ex)
        {

        }
    }


    public static System.Drawing.Image ResizeImage(System.Drawing.Image image, Size size, bool preserveAspectRatio = true)
    {
        int newWidth;
        int newHeight;
        if (preserveAspectRatio)
        {
            int originalWidth = image.Width;
            int originalHeight = image.Height;
            float percentWidth = (float)size.Width / (float)originalWidth;
            float percentHeight = (float)size.Height / (float)originalHeight;
            float percent = percentHeight < percentWidth ? percentHeight : percentWidth;
            newWidth = (int)(originalWidth * percent);
            newHeight = (int)(originalHeight * percent);
        }
        else
        {
            newWidth = size.Width;
            newHeight = size.Height;
        }
        System.Drawing.Image newImage = new Bitmap(newWidth, newHeight);
        using (Graphics graphicsHandle = Graphics.FromImage(newImage))
        {
            graphicsHandle.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphicsHandle.DrawImage(image, 0, 0, newWidth, newHeight);
        }
        return newImage;
    }

    public static string StripHTML(string source)
    {
        try
        {
            string result;

            // Remove HTML Development formatting
            // Replace line breaks with space
            // because browsers inserts space
            result = source.Replace("\r", " ");
            // Replace line breaks with space
            // because browsers inserts space
            result = result.Replace("\n", " ");
            // Remove step-formatting
            result = result.Replace("\t", string.Empty);
            // Remove repeating spaces because browsers ignore them
            result = System.Text.RegularExpressions.Regex.Replace(result,
                                                                  @"( )+", " ");

            // Remove the header (prepare first by clearing attributes)
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*head([^>])*>", "<head>",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"(<( )*(/)( )*head( )*>)", "</head>",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(<head>).*(</head>)", string.Empty,
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // remove all scripts (prepare first by clearing attributes)
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*script([^>])*>", "<script>",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"(<( )*(/)( )*script( )*>)", "</script>",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            //result = System.Text.RegularExpressions.Regex.Replace(result,
            //         @"(<script>)([^(<script>\.</script>)])*(</script>)",
            //         string.Empty,
            //         System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"(<script>).*(</script>)", string.Empty,
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // remove all styles (prepare first by clearing attributes)
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*style([^>])*>", "<style>",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"(<( )*(/)( )*style( )*>)", "</style>",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(<style>).*(</style>)", string.Empty,
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // insert tabs in spaces of <td> tags
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*td([^>])*>", "\t",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // insert line breaks in places of <BR> and <LI> tags
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*br( )*>", "\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*li( )*>", "\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // insert line paragraphs (double line breaks) in place
            // if <P>, <DIV> and <TR> tags
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*div([^>])*>", "\r\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*tr([^>])*>", "\r\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<( )*p([^>])*>", "\r\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // Remove remaining tags like <a>, links, images,
            // comments etc - anything that's enclosed inside < >
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"<[^>]*>", string.Empty,
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // replace special characters:
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @" ", " ",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&bull;", " * ",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&lsaquo;", "<",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&rsaquo;", ">",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&trade;", "(tm)",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&frasl;", "/",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&lt;", "<",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&gt;", ">",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&copy;", "(c)",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&reg;", "(r)",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            // Remove all others. More can be added, see
            // http://hotwired.lycos.com/webmonkey/reference/special_characters/
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     @"&(.{2,6});", string.Empty,
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // for testing
            //System.Text.RegularExpressions.Regex.Replace(result,
            //       this.txtRegex.Text,string.Empty,
            //       System.Text.RegularExpressions.RegexOptions.IgnoreCase);

            // make line breaking consistent
            result = result.Replace("\n", "\r");

            // Remove extra line breaks and tabs:
            // replace over 2 breaks with 2 and over 4 tabs with 4.
            // Prepare first to remove any whitespaces in between
            // the escaped characters and remove redundant tabs in between line breaks
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(\r)( )+(\r)", "\r\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(\t)( )+(\t)", "\t\t",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(\t)( )+(\r)", "\t\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(\r)( )+(\t)", "\r\t",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            // Remove redundant tabs
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(\r)(\t)+(\r)", "\r\r",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            // Remove multiple tabs following a line break with just one tab
            result = System.Text.RegularExpressions.Regex.Replace(result,
                     "(\r)(\t)+", "\r\t",
                     System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            // Initial replacement target string for line breaks
            string breaks = "\r\r\r";
            // Initial replacement target string for tabs
            string tabs = "\t\t\t\t\t";
            while (result.Contains(breaks))
            {
                result = result.Replace(breaks, "\r\r");
            }
            while (result.Contains(tabs))
            {
                result = result.Replace(tabs, "\t\t\t\t");
            }

            // That's it.
            return result;
        }
        catch
        {
            // MessageBox.Show("Error");
            return source;
        }
    }

    public static void errorLog(Exception ex, string path)
    {
       
    }

    public static string CreateRandomPassword()
    {
        string _allowedChars = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ0123456789@#$^!";
        Random randNum = new Random();
        char[] chars = new char[6];
        int allowedCharCount = _allowedChars.Length;

        for (int i = 0; i < 6; i++)
        {
            chars[i] = _allowedChars[(int)((_allowedChars.Length) * randNum.NextDouble())];
        }

        return new string(chars);
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
            sb1.Append("<img src='http://biketour.testyourprojects.com/_images/NewImages/logo_adfc.png' />");
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


    public static void SendMail(string Subject, string EmailBody, string toEmail)
    {
        try
        {
            string path = "";
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
            string str= ex.Message.ToString(); 
                          
        }
    }

    public static void SendSupportMail(string Subject, string EmailBody, string toEmail)
    {
        try
        {
            string path = "";
            string eBody = "";

            SmtpClient sm = new SmtpClient(ConfigurationManager.AppSettings["SupportSMTP"]);           
            sm.Credentials = new System.Net.NetworkCredential(ConfigurationManager.AppSettings["SupportEmail"], ConfigurationManager.AppSettings["SupportPassword"]);
            sm.DeliveryMethod = SmtpDeliveryMethod.Network;
            //sm.Port = 587;
            sm.EnableSsl = bool.Parse(ConfigurationManager.AppSettings["EnableSsl"]);
            MailMessage objMailMessage = new MailMessage();
            objMailMessage.IsBodyHtml = true;

            objMailMessage.From = new System.Net.Mail.MailAddress(ConfigurationManager.AppSettings["SupportEmail"], ConfigurationManager.AppSettings["EmailDisplayName"]);
            objMailMessage.To.Add(new System.Net.Mail.MailAddress("nick.laddha@gmail.com"));
            objMailMessage.Subject = Subject;

            eBody += MailHeader(ConfigurationManager.AppSettings["SupportEmail"].ToString(), toEmail).ToString();
            eBody += EmailBody;
            eBody += MailFooter().ToString();

            objMailMessage.Body = eBody;
            sm.Send(objMailMessage);

        }
        catch (Exception ex)
        {
            throw ex;
            
        }
    }
}

public enum Priority
{
    Low = 1,
    Normal = 2,
    High = 3
}

public enum ListingCategory
{
    Bungalow = 1,
    BiLevel = 2,
    TwoStorey = 3
}


public static class ACTION
{

}

public static class QueryTypes
{
    const int _all = 1;
    const int _wherePK = 2;
    const int _whereFK = 3;
    const int _whereDetailWithPk = 4;

    public static int WhereDetailWithPk
    {
        get { return _whereDetailWithPk; }
    }


    public static int WhereFK
    {
        get { return _whereFK; }
    }

    public static int WherePK
    {
        get { return _wherePK; }
    }

    public static int All
    {
        get { return _all; }
    }

}
