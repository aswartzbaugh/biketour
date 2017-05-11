using BikeTourCore.Entity;

namespace BikeTourCore.ServiceMessage
{
    public class UploadRequestMessage:RequestBase
    {
        public UploadFile[] gpxFiles { get; set; }
        //public string FileName { get; set; }
        //public byte[] FileData { get; set; }
    }
}
