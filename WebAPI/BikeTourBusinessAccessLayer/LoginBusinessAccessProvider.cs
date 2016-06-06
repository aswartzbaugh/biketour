using BikeTourCore.Definition;
using System;
using System.Collections.Generic;
using BikeTourCore.ServiceMessage.LoginMessage;
using BikeTourDataAccessLayer;
using Common;

namespace BikeTourBusinessAccessLayer
{
    public class LoginBusinessAccessProvider : ILogin
    {
        ILogin loginDataProvider = null;
        public LoginResponseMessage AuthenticateUser(LoginRequestMessage RequestMessage)
        {
            LoginResponseMessage response = null;
            try
            {
                response = ValidateAuthenticateUser(RequestMessage);

                if (response != null && response.Error==null)
                {
                    loginDataProvider = new LoginDataProvider();
                    response = loginDataProvider.AuthenticateUser(RequestMessage);

                    if (response != null && response.Error == null)
                    {
                        //Generate token
                        response.Success = true;
                    }
                }
            }
            catch(Exception ex)
            {
                ErrorLogManager.WriteLog(response, "999", ex.Message);
            }
            return response;
        }

        #region Validation

        private LoginResponseMessage ValidateAuthenticateUser(LoginRequestMessage RequestMessage)
        {
            LoginResponseMessage response = new LoginResponseMessage();
            
            if (RequestMessage==null)
            {
                ErrorLogManager.WriteLog(response, "002", "Request message should not be empty.");               
            }
            else 
            {
                if (string.IsNullOrEmpty(RequestMessage.LoginName))
                    ErrorLogManager.WriteLog(response, "003", "Login name is mandatory.");                

                if (string.IsNullOrEmpty(RequestMessage.Password))
                    ErrorLogManager.WriteLog(response, "004", "Password is mandatory.");                
            }
            return response;
        }

        #endregion
    }
}
