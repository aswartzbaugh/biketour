using BikeTourCore.Definition;
using System;
using System.Collections.Generic;
using BikeTourCore.ServiceMessage;
using Common;
using BikeTourDataAccessLayer.UploadFileDataProvider;

namespace BikeTourBusinessAccessLayer
{
    public class UploadFileBusinessAccessLayer : IUploadFile
    {
        IUploadFile uploadFileDataProvider = null;
        public UploadResponseMessage UploadFile(UploadRequestMessage requestMessage, string filePath = "")
        {
            UploadResponseMessage response = new UploadResponseMessage();
            try
            {
                response = ValidateFile(requestMessage);

                if (response != null && response.Error ==null)
                {
                    uploadFileDataProvider = new UploadDataProvider();
                    response = uploadFileDataProvider.UploadFile(requestMessage, filePath);
                }                
            }            
            catch(Exception ex)
            {
                ErrorLogManager.WriteLog(response, "999", ex.Message);
            }
            return response;
        }

        private UploadResponseMessage ValidateFile(UploadRequestMessage requestMessage)
        {
            UploadResponseMessage response = new UploadResponseMessage();
            
            if (requestMessage == null)
            {
                ErrorLogManager.WriteLog(response, "002", "Request message should not be empty.");
            }
            else
            {
                if (string.IsNullOrEmpty(requestMessage.LoginName))
                    ErrorLogManager.WriteLog(response, "003", "Login name is mandatory.");

                if (string.IsNullOrEmpty(requestMessage.Password))
                    ErrorLogManager.WriteLog(response, "004", "Password is mandatory.");

                
                if (requestMessage.FileData == null)
                {
                    ErrorLogManager.WriteLog(response, "005", "File list should not be empty.");
                }
                else
                {
                    //var item = requestMessage.FileList;
                    //foreach (var item in requestMessage.FileList)
                    //{                        
                        if (string.IsNullOrEmpty(requestMessage.FileName))
                            ErrorLogManager.WriteLog(response, "006", "File name is mandatory.");

                        if (requestMessage.FileData == null)
                            ErrorLogManager.WriteLog(response, "007", "File data should not be empty.");

                        if (requestMessage.FileData != null && requestMessage.FileData.Length == 0)
                            ErrorLogManager.WriteLog(response, "007", "File data should not be empty.");
                    //}
                }
                
            }
            return response;
        }
    }
}
