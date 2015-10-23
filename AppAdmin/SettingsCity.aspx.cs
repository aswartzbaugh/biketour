using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Xml;
using System.Net;
using System.IO;

public partial class AppAdmin_SettingsCity : System.Web.UI.Page
{
    BCAppAdmin objAdmin = new BCAppAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            double latitude = 0;
            double longitude = 0;

            if (txtLongitude.Text != "")
            {
                latitude = double.Parse(txtLongitude.Text.Replace(',', '.'), System.Globalization.CultureInfo.InvariantCulture);
            }
            if (txtLongitude.Text != "")
            {
                longitude = double.Parse(txtLongitude.Text.Replace(',', '.'), System.Globalization.CultureInfo.InvariantCulture);
            }

            DataTable dtCities = objAdmin.GetCitiesList(Convert.ToInt32(ddlCity.SelectedValue));

            if (dtCities.Rows.Count > 0)
            {
                try
                {
                    int cnt = 0;
                    for (int i = 0; i < dtCities.Rows.Count; i++)
                    {
                        //double dist = CalculateDistance(dtCities.Rows[i]["CityName"].ToString() + ", Germany", txt_City.Text + ", Germany");
                        double dist = CalculateDistance(dtCities.Rows[i]["lat"].ToString().Replace(",", ".") + "," + dtCities.Rows[i]["long"].ToString().Replace(",", "."), txtLatitude.Text.Replace(',', '.') + "," + txtLongitude.Text.Replace(',', '.'));

                        if (dist > 0)
                        {
                            int opt = objAdmin.InsertCityDistance(Convert.ToInt32(dtCities.Rows[i]["CityId"]), Convert.ToInt32(ddlCity.SelectedValue), Convert.ToInt32(dist));
                            if (opt > 0) { cnt++; }
                        }
                    }

                    if (cnt > 0)
                    {
                        string popupScript = "alert('" + cnt.ToString() + " Saved!');";//City deleted successfully.
                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                    }
                }
                catch (Exception ex) { }
            }

        }
        catch { }
    }


    private double CalculateDistance(string fromCity, string toCity)
    {
        double output = 0.0;
        try
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

            //Get specified element value using select single node method and verify it return OK (success ) or failed
            if (doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/status").InnerText.ToString().ToUpper() != "OK")
            {
                //lblResult.Text = "Invalid City Name please try again";
                //return;
            }

            //Get DistanceMatrixResponse element and its values
            XmlNodeList xnList = doc.SelectNodes("/DistanceMatrixResponse");
            foreach (XmlNode xn in xnList)
            {
                if (xn["status"].InnerText.ToString() == "OK")
                {
                    output = double.Parse(doc.DocumentElement.SelectSingleNode("/DistanceMatrixResponse/row/element/distance/text").InnerText.Split(' ')[0], System.Globalization.CultureInfo.InvariantCulture);
                }
            }
        }
        catch (Exception ex)
        {
        }

        return output;
    }

    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        DataTable dtCity = objAdmin.GetParticipatingCityInfo(Convert.ToInt32(ddlCity.SelectedValue));
        if (dtCity.Rows.Count > 0)
        {
            txtLatitude.Text = dtCity.Rows[0]["lat"].ToString();
            txtLongitude.Text = dtCity.Rows[0]["long"].ToString();
        }
    }
}