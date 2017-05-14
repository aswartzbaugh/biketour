using BikeTourBusinessAccessLayer;
using BikeTourCore.Definition;
using BikeTourCore.ServiceMessage;
using System.Data;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;

namespace BikeTour.WebAPI.Controllers
{
    public class UploadController : ApiController
    {
        IUploadFile uploadBusinessProvider = null;
        [HttpPost]
        public HttpResponseMessage UploadFile([FromBody]UploadRequestMessage requestMessage)
        {
            string filepath = System.Web.Hosting.HostingEnvironment.MapPath("~\\FileUpload\\");

            uploadBusinessProvider = new UploadFileBusinessAccessLayer(filepath);
                        
            UploadResponseMessage response = uploadBusinessProvider.UploadFile(requestMessage, filepath);
            //string jsStartTag="{Log:[";
            //string jsEndTag = "]}";
            //StringBuilder jsString = new StringBuilder();
            //if (response!=null)
            //{
            //    jsString.Append(jsStartTag);
            //    for (int i = 0; i < response.Log.Count; i++)
            //    {
            //        jsString.Append(@"{""FileName:" + response.Log[i].FileName+@"""-");
            //        jsString.Append(@"""Code:" + response.Log[i].Code + @"""-");
            //        jsString.Append(@"""Message:" + response.Log[i].Message + @"""-");
            //        jsString.Append(@"""Status:" + response.Log[i].Status.ToString() + @"""}");
            //        if (i < response.Log.Count - 1) jsString.Append(",");
            //    }
            //    //foreach (var item in response.Log)
            //    //{
            //    //    jsString.Append(@"{\" + "FileName" + @"\" + @":\" + item.FileName+@"\-");
            //    //    jsString.Append(@"\" + "Code" + @"\" + @":\" + item.Code + @"\-");
            //    //    jsString.Append(@"\" + "Message" + @"\" + @":\" + item.Message + @"\-");
            //    //    jsString.Append(@"\" + "Status" + @"\" + @":\" + item.Status.ToString() + @"\}");
            //    //}
            //    jsString.Append(jsEndTag);
            //}
            //string responsResult = jsString.ToString();
            HttpResponseMessage tempResponse = Request.CreateResponse(HttpStatusCode.OK, response);

            ParseResponse(tempResponse);
            return tempResponse;
        }

        private void ParseResponse(HttpResponseMessage response)
        {
            DataSet ds = null;
            var json = response.Content.ToString();
                        

        }
    }
}
