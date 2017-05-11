
namespace BikeTourCore.ServiceMessage.LoginMessage
{
    public class LoginResponseMessage:ResponseBase
    {
        public string SecurityToken { get; set; }
        public bool Success { get; set; }
    }
}
