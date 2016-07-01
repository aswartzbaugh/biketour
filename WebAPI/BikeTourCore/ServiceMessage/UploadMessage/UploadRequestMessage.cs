using BikeTourCore.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourCore.ServiceMessage
{
    public class UploadRequestMessage:RequestBase
    {
        //public UploadFile FileList { get; set; }
        public List<GpxFile> gpxFiles { get; set; }
    }

    public class GpxFile
    {
        public string FileName { get; set; }
        public byte[] FileData { get; set; }

        public string statusCode { get; set; }
    }
}
