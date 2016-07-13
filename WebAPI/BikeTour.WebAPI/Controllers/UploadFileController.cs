using BikeTourBusinessAccessLayer;
using BikeTourCore.Definition;
using BikeTourCore.Entity;
using BikeTourCore.ServiceMessage;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace BikeTour.WebAPI.Controllers
{
    public class UploadController : ApiController
    {
        IUploadFile uploadBusinessProvider = null;
        [HttpPost]
        public HttpResponseMessage UploadFile([FromBody]UploadRequestMessage requestMessage)
        {
           
            uploadBusinessProvider = new UploadFileBusinessAccessLayer();

            //UploadResponseMessage response =
            //uploadBusinessProvider.UploadFile(requestMessage, System.Web.Hosting.HostingEnvironment.MapPath("~\\FileUpload\\"));

            UploadResponseMessage response =
            uploadBusinessProvider.UploadFile(requestMessage, System.Configuration.ConfigurationManager.AppSettings["GPXWebPath"]);

            HttpResponseMessage tempResponse = Request.CreateResponse(HttpStatusCode.OK,response);

            return tempResponse;
        }
    }
}
