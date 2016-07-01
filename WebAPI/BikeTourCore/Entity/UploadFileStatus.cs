using BikeTourCore.ServiceMessage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourCore.Entity
{
    public class UploadFileStatus
    {
        public List<ErrorMessage> Error { get; set; }
        
    }
}
