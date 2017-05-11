using BikeTourCore.Definition;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BikeTourCore.ServiceMessage.LoginMessage;
using BikeTourDataAccessLayer.EF;
using Common;

namespace BikeTourDataAccessLayer
{
    public class LoginDataProvider : ILogin
    {
        
        public LoginResponseMessage AuthenticateUser(LoginRequestMessage RequestMessage)
        {
            LoginResponseMessage response = new LoginResponseMessage();
            try
            {
                StringBuilder sqlString = new StringBuilder();

                sqlString.Append("select Loginid from LoginDtls where LoginName='");
                sqlString.Append(RequestMessage.LoginName);
                sqlString.Append("' and cast(Password as varbinary(20))=cast('");
                sqlString.Append(RequestMessage.Password);
                sqlString.Append("' as varbinary(50)) and IsActive=1");

                var login = DataAccessLayer.ExecuteScalar(sqlString.ToString());                

                if (login != null)
                {                    
                    response.SecurityToken = "G";
                }
                else
                {
                    ErrorLogManager.WriteLog(response, "000", "Unable to find user.");                    
                }
            }
            catch (Exception ex)
            {
                //ErrorLogManager.WriteLog(response, "999", ex.Message,ex:ex);                
                ErrorLogManager.WriteLog(response, "012", ex.Message, ex: ex);                
            }
            return response;
        }
    }
}
