using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BikeTourCore.ServiceMessage.LoginMessage
{
    public class LoginResponseMessage:ResponseBase
    {
        public string SecurityToken { get; set; }
        public bool Success { get; set; }
    }
}
