using System.Net;
using System.Xml;
using System.Data;
using System.IO;
using System.Xml.XPath;
using System;
using System.Configuration;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load()
    {
        lblResult.Text = "";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        //GoogleMapForASPNet1.GoogleMapObject.APIKey = ConfigurationManager.AppSettings["GoogleAPIKey"]; 
        if (!IsPostBack)
        {
            ddlFromCity.DataBind();
            for (int i = 57; i < ddlFromCity.Items.Count; i++)
            {
                ddlFromCity.SelectedIndex = i;
                ddlToCity.DataBind();
                foreach (ListItem item in ddlToCity.Items)
                {
                    double dist = CalculateDistance(ddlFromCity.Items[i].Text + ", Germany", item.Text + ", Germany");
                    int outp = DataAccessLayer.ExecuteNonQuery("insert into citydistancemaster(fromcity, tocity, distance) values(" + ddlFromCity.Items[i].Value + "," + item.Value + "," + dist + ")");
                }

            }
        }
    }
   
    protected void btnSearch_Click(object sender, System.EventArgs e)
    {
        //Declare variable to store XML result
        try
        {
            string xmlResult = null;

            //Pass request to google api with orgin and destination details
            //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" + TextBox1.Text + "&destinations=" + TextBox2.Text + "&mode=Car&language=us-en&sensor=false");
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" + ddlFromCity.SelectedItem.Text + "&destinations=" + ddlToCity.SelectedItem.Text + "&mode=Car&language=us-en&sensor=false");

            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            //Get response as stream from httpwebresponse
            StreamReader resStream = new StreamReader(response.GetResponseStream());

            //Create instance for xml document
            XmlDocument doc = new XmlDocument();

            //Load response stream in to xml result
            xmlResult = resStream.ReadToEnd();

            //Load xmlResult variable value into xml documnet
            doc.LoadXml(xmlResult);

            string output = "";

            //Get specified element value using select single node method and verify it return OK (success ) or failed
            if (doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/status").InnerText.ToString().ToUpper() != "OK")
            {
                lblResult.Text = "Invalid City Name please try again";
                return;
            }

            //Get DistanceMatrixResponse element and its values
            XmlNodeList xnList = doc.SelectNodes("/DistanceMatrixResponse");
            foreach (XmlNode xn in xnList)
            {
                if (xn["status"].InnerText.ToString() == "OK")
                {
                    //Form a table and bind it orgin, destination place and return distance value, approximate duration
                    output = "<table align='center' width='600' cellpadding='0' cellspacing='0'>";
                    output += "<tr><td height='60' colspan='2' align='center'><b>Travel Details</b></td>";
                    output += "<tr><td height='40' width='30%' align='left'>Orgin Place</td><td align='left'>" + xn["origin_address"].InnerText.ToString() + "</td></tr>";
                    output += "<tr><td height='40' align='left'>Destination Place</td><td align='left'>" + xn["destination_address"].InnerText.ToString() + "</td></tr>";
                    output += "<tr><td height='40' align='left'>Travel Duration (apprx.)</td><td align='left'>" + doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/duration/text").InnerText + "</td></tr>";
                    output += "<tr><td height='40' align='left'>Distance</td><td align='left'>" + doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/distance/text").InnerText + "</td></tr>";
                    output += "</table>";

                    //finally bind it in the result label control
                    lblResult.Text = output;
                    DispalyMap();
                        
                }
            }
        }
        catch (Exception ex)
        { }

        }

    private void DispalyMap()
    {
        try
        {
            //You must specify Google Map API Key for this component. You can obtain this key from http://code.google.com/apis/maps/signup.html
            //For samples to run properly, set GoogleAPIKey in Web.Config file.
            //GoogleMapForASPNet1.GoogleMapObject.APIKey = ConfigurationManager.AppSettings["GoogleAPIKey"];

            //Specify width and height for map. You can specify either in pixels or in percentage relative to it's container.
            //GoogleMapForASPNet1.GoogleMapObject.Width = "800px"; // You can also specify percentage(e.g. 80%) here
            //GoogleMapForASPNet1.GoogleMapObject.Height = "600px";

            //Specify initial Zoom level.
            //GoogleMapForASPNet1.GoogleMapObject.ZoomLevel = 14;

            //Specify Center Point for map. Map will be centered on this point.
            //GoogleMapForASPNet1.GoogleMapObject.CenterPoint = new GooglePoint("1", 43.66619, -79.44268);

            //Add push pins for map. 
            //This should be done with intialization of GooglePoint class. 
            //ID is to identify a pushpin. It must be unique for each pin. Type is string.
            //Other properties latitude and longitude.
            GooglePoint GP1 = new GooglePoint();
            GP1.ID = "1";
            GP1.Latitude = 43.65669;
            GP1.Longitude = -79.44268;
            //Specify bubble text here. You can use standard HTML tags here.
            GP1.InfoHTML = "This is Point 1";

            //Specify icon image. This should be relative to root folder.
            GP1.IconImage = "../_images/RedCar.png";
            //GoogleMapForASPNet1.GoogleMapObject.Points.Add(GP1);

            GooglePoint GP2 = new GooglePoint();
            GP2.ID = "2";
            GP2.Latitude = 43.66619;
            GP2.Longitude = -79.44268;
            GP2.InfoHTML = "This is point 2";
            GP2.IconImage = "../_images/RedCar.png";
            //GoogleMapForASPNet1.GoogleMapObject.Points.Add(GP2);


            GooglePoint GP3 = new GooglePoint();
            GP3.ID = "3";
            GP3.Latitude = 43.67689;
            GP3.Longitude = -79.43270;
            GP3.InfoHTML = "This is point 3";
            GP1.IconImage = "../_images/RedCar.png";
           // GoogleMapForASPNet1.GoogleMapObject.Points.Add(GP3);
        }
        catch (Exception ex)
        {
            
         
        }
    }

    private double CalculateDistance(string fromCity, string toCity)
    {
        string xmlResult = null;

        //Pass request to google api with orgin and destination details
        //HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" + TextBox1.Text + "&destinations=" + TextBox2.Text + "&mode=Car&language=us-en&sensor=false");
        HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://maps.googleapis.com/maps/api/distancematrix/xml?origins=" + fromCity + "&destinations=" + toCity + "&mode=Car&language=us-en&sensor=false");

        HttpWebResponse response = (HttpWebResponse)request.GetResponse();

        //Get response as stream from httpwebresponse
        StreamReader resStream = new StreamReader(response.GetResponseStream());

        //Create instance for xml document
        XmlDocument doc = new XmlDocument();

        //Load response stream in to xml result
        xmlResult = resStream.ReadToEnd();

        //Load xmlResult variable value into xml documnet
        doc.LoadXml(xmlResult);

        double output = 0.0;

        //Get specified element value using select single node method and verify it return OK (success ) or failed
        if (doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/status").InnerText.ToString().ToUpper() != "OK")
        {
            lblResult.Text = "Invalid City Name please try again";
            //return;
        }

        //Get DistanceMatrixResponse element and its values
        XmlNodeList xnList = doc.SelectNodes("/DistanceMatrixResponse");
        foreach (XmlNode xn in xnList)
        {
            if (xn["status"].InnerText.ToString() == "OK")
            {
                ////Form a table and bind it orgin, destination place and return distance value, approximate duration
                //output = "<table align='center' width='600' cellpadding='0' cellspacing='0'>";
                //output += "<tr><td height='60' colspan='2' align='center'><b>Travel Details</b></td>";
                //output += "<tr><td height='40' width='30%' align='left'>Orgin Place</td><td align='left'>" + xn["origin_address"].InnerText.ToString() + "</td></tr>";
                //output += "<tr><td height='40' align='left'>Destination Place</td><td align='left'>" + xn["destination_address"].InnerText.ToString() + "</td></tr>";
                //output += "<tr><td height='40' align='left'>Travel Duration (apprx.)</td><td align='left'>" + doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/duration/text").InnerText + "</td></tr>";
                //output += "<tr><td height='40' align='left'>Distance</td><td align='left'>" + doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/distance/text").InnerText + "</td></tr>";
                //output += "</table>";

                ////finally bind it in the result label control
                //lblResult.Text = output;
               // DispalyMap();

                output = Convert.ToDouble(doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/distance/text").InnerText.Split(' ')[0]);

            }
        }

        return output;
    }
}