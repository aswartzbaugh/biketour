using BikeTourCore.ServiceMessage;
using System.Collections.Generic;

namespace BikeTourCore.Entity
{
    public class UploadFileStatus
    {
        public string FileName { get; set; }
        public string Code { get; set; }
        public string Message { get; set; }  
        public bool Status { get; set; }
        public string Separator { get; set; }
    }
}
