using BikeTourCore.ServiceMessage.LoginMessage;

namespace BikeTourCore.Definition
{
    public interface ILogin
    {
        LoginResponseMessage AuthenticateUser(LoginRequestMessage RequestMessage);
    }
}
