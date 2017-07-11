using BikeTourCore.Entity;
using BikeTourCore.ServiceMessage;
using System;
using System.Collections.Generic;
using System.IO;
using System.Text;

namespace Common
{
    public static class ErrorLogManager
    {
        public static string FilePath = string.Empty;
        /// <summary>
        /// 
        /// </summary>
        /// <param name="response"></param>
        /// <param name="errorMessage"></param>
        public static void WriteLog(ResponseBase response, string errorCode, string errorMessage,bool isError=true,Exception ex=null)
        {
            if (response.Error == null) response.Error = new List<ErrorMessage>();
            ErrorMessage error = new ErrorMessage { Code = errorCode, Message = errorMessage,IsError=isError };
            response.Error.Add(error);

            if (error.Code== "999")
            {
                WriteLogToFile(ex, FilePath);
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="response"></param>
        /// <param name="errorMessage"></param>
        public static void WriteLog(UploadResponseMessage response, string fileName,
            string errorCode, string errorMessage, bool isError = true, Exception ex = null)
        {
            if (response==null)
            {
                response = new UploadResponseMessage();
                response.Log = new List<UploadFileStatus>();
            }
            UploadFileStatus msg = new UploadFileStatus
            {
                FileName = fileName,
                Code = errorCode,
                Message = errorMessage,
                Status = isError,
                Separator="-"
            };
            response.Log.Add(msg);
            if (msg.Code == "999")
            {
                WriteLogToFile(ex, FilePath);
            }
        }


        private static void WriteLogToFile(Exception ex, string filepath)
        {
            var stream = File.Create(filepath + "APIError.txt", 32000, FileOptions.Asynchronous);
            
            stream.Flush();
            stream.Close();

            StringBuilder errorMessage = new StringBuilder();
            errorMessage.AppendLine("Message : " + ex.Message);
            errorMessage.AppendLine("Source  : ");
            errorMessage.AppendLine(ex.StackTrace);
            errorMessage.AppendLine("-------------------------------------------------------------------------------");

            File.WriteAllText(filepath + "APIError.txt", errorMessage.ToString());
        }
    }
}
