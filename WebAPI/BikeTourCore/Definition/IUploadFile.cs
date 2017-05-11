using BikeTourCore.ServiceMessage;

namespace BikeTourCore.Definition
{
    public interface IUploadFile
    {
        UploadResponseMessage UploadFile(UploadRequestMessage requestMessage, string filePath = "");
    }
}
