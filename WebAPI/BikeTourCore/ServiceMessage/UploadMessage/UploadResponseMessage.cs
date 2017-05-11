using BikeTourCore.Entity;
using System.Collections.Generic;

namespace BikeTourCore.ServiceMessage
{
    public class UploadResponseMessage
    {
        public List<UploadFileStatus> Log { get; set; }
    }
}
