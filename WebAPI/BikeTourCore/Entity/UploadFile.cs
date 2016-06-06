using BikeTourCore.ServiceMessage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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
