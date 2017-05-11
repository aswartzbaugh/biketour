using System.Collections.Generic;
namespace BikeTourCore.ServiceMessage
{
    public class ResponseBase
    {        
        public List<ErrorMessage> Error { get; set; }
    }

    public class ErrorMessage
    {
        public string Code { get; set; }
        public string Message { get; set; }        
        public bool IsError { get; set; }
    }
}
