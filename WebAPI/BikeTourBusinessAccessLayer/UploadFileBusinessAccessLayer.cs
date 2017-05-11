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
        public UploadFileBusinessAccessLayer(string filePath)
        {
            ErrorLogManager.FilePath = filePath;
        }
        IUploadFile uploadFileDataProvider = null;
        public UploadResponseMessage UploadFile(UploadRequestMessage requestMessage, string filePath = "")
        {
            UploadResponseMessage response = new UploadResponseMessage();
            try
            {
                response = ValidateFile(requestMessage);

                if (response != null && response.Log ==null)
                {
                    uploadFileDataProvider = new UploadDataProvider();
                    response = uploadFileDataProvider.UploadFile(requestMessage, filePath);
                }                
            }            
            catch(Exception ex)
            {
                ErrorLogManager.WriteLog(response,"TestFile", "999", ex.Message, ex: ex);
            }
            return response;
        }

        private UploadResponseMessage ValidateFile(UploadRequestMessage requestMessage)
        {
            UploadResponseMessage response = new UploadResponseMessage();
            
            if (requestMessage == null)
            {
                ErrorLogManager.WriteLog(response, "TestFile", "002", "Request message should not be empty.");
            }
            else
            {
                if (string.IsNullOrEmpty(requestMessage.LoginName))
                    ErrorLogManager.WriteLog(response, "TestFile", "003", "Login name is mandatory.");

                if (string.IsNullOrEmpty(requestMessage.Password))
                    ErrorLogManager.WriteLog(response, "TestFile", "004", "Password is mandatory.");

                
                if (requestMessage.gpxFiles == null)
                {
                    ErrorLogManager.WriteLog(response, "TestFile", "005", "File list should not be empty.");
                }
                else
                {
                    //var item = requestMessage.FileList;
                    foreach (var item in requestMessage.gpxFiles)
                    {
                        if (string.IsNullOrEmpty(item.FileName))
                            ErrorLogManager.WriteLog(response,item.FileName, "006", "File name is mandatory.");

                        if (item.FileData == null)
                            ErrorLogManager.WriteLog(response,item.FileName, "007", "File data should not be empty.");

                        if (item.FileData != null && item.FileData.Length == 0)
                            ErrorLogManager.WriteLog(response,item.FileName, "007", "File data should not be empty.");
                    }
                }
                
            }
            return response;
        }
    }
}
