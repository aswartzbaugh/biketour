using BikeTourBusinessAccessLayer;
using BikeTourCore.Definition;
using BikeTourCore.ServiceMessage.LoginMessage;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BikeTour.WebAPI.Controllers
{
    public class LoginController : ApiController
    {
        ILogin loginBusinessProvider = null;
        
        // GET: api/Login/5
        [HttpPost]
        public HttpResponseMessage AuthenticateUser([FromBody]LoginRequestMessage requestMessage)
        {
            string filepath = System.Web.Hosting.HostingEnvironment.MapPath("~\\FileUpload\\");

            loginBusinessProvider = new LoginBusinessAccessProvider(filepath);
                        
            //requestMessage = new LoginRequestMessage();
            //requestMessage.LoginName = "frankanders";
            //requestMessage.Password = "tourdeeurope123";
            LoginResponseMessage response = loginBusinessProvider.AuthenticateUser(requestMessage);
            HttpResponseMessage tempResponse = Request.CreateResponse(HttpStatusCode.OK, response);

            //string jsonMessage;
            //using (Stream responseStream = tempResponse.Content.ReadAsStreamAsync().Result)
            //{
            //    jsonMessage = new StreamReader(responseStream).ReadToEnd();
            //}
            return tempResponse;
        }        
    }
}
