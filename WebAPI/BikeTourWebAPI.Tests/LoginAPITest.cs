using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Collections.Generic;
using System.IO;

namespace BikeTourWebAPI.Tests
{
    [TestClass]
    public class LoginAPITest
    {
              
        [TestMethod]
        public void LoginWithValidUser()
        {
            string apiUrl = "http://localhost:49916//api//Login//AuthenticateUser";

            var client = new HttpClient();

            

            var values = new Dictionary<string, string>()
            {
                {"LoginName", "6"},
                {"Password", "Skis"},
                
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
        [TestMethod]
        public void LoginWithEmptyRequest()
        {
        }
        [TestMethod]
        public void LoginWithInvalidUser()
        {
        }
        [TestMethod]
        public void LoginWithEmptyLoginName()
        {
        }
        [TestMethod]
        public void LoginWithEmptyPassword()
        {
        }
    }
}
