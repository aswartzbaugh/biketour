using BikeTourCore.Definition;
using System;
using System.Collections.Generic;
using BikeTourCore.ServiceMessage;
using Common;
using BikeTourDataAccessLayer.UploadFileDataProvider;
using System.Linq;

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
                response = ValidateFiles(requestMessage);

                if (response != null)
                {
                    if (response.Log != null && response.Log.Count == requestMessage.gpxFiles.Count
                    && (response.Log.Where(x => x.Code.Contains("002") || x.Code.Contains("003") || x.Code.Contains("004") || x.Code.Contains("005")).ToList().Count != 0))
                    {
                        return response;
                    }
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

        private UploadResponseMessage ValidateFiles(UploadRequestMessage requestMessage)
        {
            UploadResponseMessage response = new UploadResponseMessage();
            
            if (requestMessage == null)
            {
                ErrorLogManager.WriteLog(response, "002", "Request message should not be empty.");
            }
            else
            {
                if (string.IsNullOrEmpty(requestMessage.LoginName))
                {
                    ErrorLogManager.WriteLog(response, "003", "Login name is mandatory.");
                }

                if (string.IsNullOrEmpty(requestMessage.Password))
                {
                    ErrorLogManager.WriteLog(response, "004", "Password is mandatory.");
                }

                
                if (requestMessage.gpxFiles == null)
                {
                    ErrorLogManager.WriteLog(response, "005", "File list should not be empty.");
                }
                else
                {
                    var gpxFilesTemp = new List<GpxFile>(requestMessage.gpxFiles);

                    foreach (var item in requestMessage.gpxFiles)
                    {
                        if (string.IsNullOrEmpty(item.FileName))
                        {
                            ErrorLogManager.WriteLog(response, "006", "File name is mandatory.", item.FileName);
                            gpxFilesTemp.Remove(item);
                        }

                        if (item.FileData == null)
                        {
                            ErrorLogManager.WriteLog(response, "007", "File data should not be empty.", item.FileName);
                            gpxFilesTemp.Remove(item);
                        }

                        if (item.FileData != null && item.FileData.Length == 0)
                        {
                            ErrorLogManager.WriteLog(response, "007", "File data should not be empty.", item.FileName);
                            gpxFilesTemp.Remove(item);
                        }
                    }

                    requestMessage.gpxFiles = gpxFilesTemp;
                }
                
            }
            return response;
        }
    }
}
