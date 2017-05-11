using BikeTourCore.ServiceMessage;
using System.Collections.Generic;

namespace BikeTourCore.Entity
{
    public class UploadFile:Base.BaseEntity
    {        
        public string FileName { get; set; }
        public byte[] FileData { get; set; }
        //public string SchoolName { get; set; }
        //public string ClassName { get; set; }
        public List<ErrorMessage> Error { get; set; }
    }
}
