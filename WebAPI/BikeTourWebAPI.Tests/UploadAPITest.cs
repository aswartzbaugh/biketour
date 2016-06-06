using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Collections.Generic;
using System.IO;

namespace BikeTourWebAPI.Tests
{
    [TestClass]
    public class UploadAPITest
    {
        [TestMethod]
        public void UploadValidFile()
        {
            string apiUrl = "http://localhost:49916//api//Upload//UploadFile";
            
            var client = new HttpClient();
            string filePath = @"D:\Projects\Nikhil\BikeTourWebAPI\GPXFile\";

            var filedata = "'FileName':'leonie fahrrad.GPX','SchoolName':'Elisabeth-von-Thadden-Schule'," +
                "'ClassName':'6C','FileData':'" +
                File.ReadAllBytes(filePath + "leonie fahrrad.GPX").ToString() +"'";
                                                       
            var values = new Dictionary<string, string>()
            {
                {"LoginName", "6"},
                {"Password", "Skis"},
                {"FileList", filedata},
            };
            var content = new FormUrlEncodedContent(values);

            var response = client.PostAsync(apiUrl, content).Result;
            var success = response.EnsureSuccessStatusCode();
            if (success.IsSuccessStatusCode)
            {
                //Perform your operations
                string jsonMessage;
                using (Stream responseStream = response.Content.ReadAsStreamAsync().Result)
                {
                    jsonMessage = new StreamReader(responseStream).ReadToEnd();
                }
            }
        }
    }
}
