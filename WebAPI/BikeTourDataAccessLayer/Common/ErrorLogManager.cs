using BikeTourCore.ServiceMessage;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Common
{
    public static class ErrorLogManager
    {
        /// <summary>
        /// 
        /// </summary>
        /// <param name="response"></param>
        /// <param name="errorMessage"></param>
        public static void WriteLog(ResponseBase response, string errorCode, string errorMessage)
        {
            if (response.Log == null) response.Log = new List<ErrorMessage>();
            ErrorMessage error = new ErrorMessage { Code = errorCode, Message = errorMessage };
            response.Log.Add(error);
        }

        public static void WriteLog(ResponseBase response, string errorCode, string errorMessage, string fileName, bool status = false)
        {
            if (response.Log == null) response.Log = new List<ErrorMessage>();
            ErrorMessage error = new ErrorMessage { Code = errorCode, Message = errorMessage, FileName = fileName, Status = status };
            response.Log.Add(error);
        }

    }
}
