using BikeTourCore.ServiceMessage.LoginMessage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourCore.Definition
{
    public interface ILogin
    {
        LoginResponseMessage AuthenticateUser(LoginRequestMessage RequestMessage);
    }
}
