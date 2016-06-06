using BikeTourCore.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourCore.ServiceMessage
{
    public class UploadResponseMessage: ResponseBase
    {
        public List<UploadFileStatus> UploadFileStatus { get; set; }
    }
}
