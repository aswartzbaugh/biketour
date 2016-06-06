using BikeTourCore.ServiceMessage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourCore.Definition
{
    public interface IUploadFile
    {
        UploadResponseMessage UploadFile(UploadRequestMessage requestMessage, string filePath = "");
    }
}
