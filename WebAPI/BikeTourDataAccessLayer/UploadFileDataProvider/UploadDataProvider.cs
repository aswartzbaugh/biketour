using BikeTourCore.Definition;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BikeTourDataAccessLayer.EF;
using BikeTourCore.ServiceMessage;
using System.Data;
using System.Configuration;
using System.Xml.Linq;
using System.IO;
using Common;
using BikeTourDataAccessLayer.Common;
using BikeTourCore.Entity;

namespace BikeTourDataAccessLayer.UploadFileDataProvider
{
    public class UploadDataProvider : IUploadFile
    {        
        BCStudent objStudent = new BCStudent();
        Int32 UserRoleId = 0;
        Int32 UserId = 0;
        Int32 studentId = 0;
        string UserName = string.Empty;
        Int32 schoolId = 0;
        Int32 classId = 0;
        Int32 cityId = 0;
        public UploadResponseMessage UploadFile(UploadRequestMessage requestMessage, string filePath ="")
        {
            UploadResponseMessage response = new UploadResponseMessage();
            try
            {
                StringBuilder sqlString = new StringBuilder();

                sqlString.Append("select * from LoginDtls where LoginName='");
                sqlString.Append(requestMessage.LoginName);
                sqlString.Append("' and cast(Password as varbinary(20))=cast('");
                sqlString.Append(requestMessage.Password);
                sqlString.Append("' as varbinary(50)) and IsActive=1");

                var login = DataAccessLayer.ReturnDataTable(sqlString.ToString());

                if (login != null)
                {
                    UserRoleId = Convert.ToInt32(login.Rows[0]["RoleId"]);
                    UserId = Convert.ToInt32(login.Rows[0]["LoginId"]);
                    UserName = Convert.ToString(login.Rows[0]["LoginName"]);

                    if (UserRoleId == 5)
                    {
                        sqlString = new StringBuilder();
                        sqlString.Append("Select * FROM StudentMaster Where LoginId = ");
                        sqlString.Append(UserId);

                        var student = DataAccessLayer.ReturnDataTable(sqlString.ToString());
                        if (student!=null && student.Rows.Count>0)
                        {
                            schoolId = Convert.ToInt32(student.Rows[0]["SchoolId"]);
                            classId = Convert.ToInt32(student.Rows[0]["ClassId"]);
                            cityId = Convert.ToInt32(student.Rows[0]["CityId"]);
                            studentId = Convert.ToInt32(student.Rows[0]["StudentId"]);
                        }
                    }
                    else
                    {
                        ErrorLogManager.WriteLog(response, "013", "Only Student can upload  file.");
                        return response;
                    }
                    //response.UploadFileStatus = new List<UploadFileStatus>();
                    //var item = requestMessage.FileData;
                            //foreach (var item in requestMessage.FileList)
                            //{
                            //var schoolClassDetail = GetSchoolClassMasterDetails(item.SchoolName, item.ClassName);

                            //if (schoolClassDetail != null &&
                            //    schoolClassDetail.Rows.Count>0)
                            //{

                            Upload(requestMessage, response, filePath);
                            //foreach (var reqFile in requestMessage.gpxFiles)
                            //{
                                //response.Log = response.Log;
                            //}
                        //}
                        //else
                        //{
                        //    var fileStatus = (new UploadFileStatus
                        //    {
                        //        FileName = item.FileName,
                        //        Status = false,                                
                        //    });
                        //    fileStatus.Error = new List<ErrorMessage>();
                        //    ErrorMessage err = new ErrorMessage { Code = "015", Message = "School /Class does not exist." };
                        //    response.UploadFileStatus.Add(fileStatus);
                        //}
                       // response.Log = null;
                    //}
                }
                else
                {
                    ErrorLogManager.WriteLog(response, "000", "Unable to find user.");
                }
            }
            catch (Exception ex)
            {
                ErrorLogManager.WriteLog(response, "999", ex.Message);
            }
            return response;
        }

        #region Private Methods
        protected void Upload(UploadRequestMessage requestFiles,
            UploadResponseMessage response, string filePath)
        {
            try
            {
                BCCityAdmin cityContent = new BCCityAdmin();
                DateTime cityStartDate = new DateTime();
                DataTable _dtTrkpts = new DataTable();
                DataTable studInfo = null;

                foreach(var PostedFile in requestFiles.gpxFiles)
                { 
                 string FileName = PostedFile.FileName;
                string NewFile = "";
                string NewFileName = "";
                string FilePath = string.Empty;
                //if (UserRoleId == 5)
                //{

                    studInfo = objStudent.GetMyProfileInfo(studentId);
                    schoolId = Convert.ToInt32(studInfo.Rows[0]["SchoolId"]);
                    classId = Convert.ToInt32(studInfo.Rows[0]["ClassId"]);

                    FilePath = filePath + schoolId + @"\" +
                    classId + @"\" + studentId.ToString() + @"\".ToString();
                //}
                //else
                //{
                //    FilePath = ConfigurationManager.AppSettings["GPXWebPath"].ToString() + schoolId + @"\" +
                //    classId + @"\".ToString();
                //}
                
                

                System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(FilePath);
                if (!(dir.Exists))
                {
                    System.IO.Directory.CreateDirectory(FilePath);
                }
                //string extension = System.IO.Path.GetExtension(FileName).ToLower();
                string[] extention = FileName.Split('.');
                if (extention != null && extention.Count() >0) FileName = extention[0];

                //if ((extension == ".gpx") | (extension == ".GPX"))
                //{
                if (IsFileUploaded(FilePath + FileName + ".xml"))
                    {
                        ErrorLogManager.WriteLog(response, "008", "File already uploaded!", PostedFile.FileName);
                    }
                    else
                    {
                    #region Save file on server for evaluation


                       File.WriteAllBytes(FilePath + FileName + ".xml", PostedFile.FileData);
                        //fu_UploadGpx.SaveAs(FilePath + FileName.Replace(".gpx", ".xml"));
                        DataTable dt = cityContent.GetCityContent(cityId, 0);
                        XElement root = null;
                        DateTime DateOfFile = new DateTime();
                        try
                        {
                            root = XElement.Load(FilePath + FileName + ".xml");
                            DateOfFile = DateTime.Parse(root.Elements().Skip(1).Take(1).Elements().Take(1).ToList()[0].Value);
                        }
                        catch (Exception ex)
                        {
                            ErrorLogManager.WriteLog(response, "009", "Uploaded File does not have Time Information, Please check the file and re-upload", PostedFile.FileName);
                            File.Delete(FilePath + FileName + ".xml");
                            return;
                        }
                        if (dt != null && dt.Rows.Count > 0)
                        {
                            cityStartDate = (dt.Rows[0]["CityStartDate"] != DBNull.Value ? Convert.ToDateTime(dt.Rows[0]["CityStartDate"]) : new DateTime());

                            if (cityStartDate != new DateTime() &&
                                DateOfFile != new DateTime() &&
                                DateOfFile.Date <= cityStartDate.Date)
                            {
                                ErrorLogManager.WriteLog(response, "010", "File can not be uploaded prior to Batch Start Date.", PostedFile.FileName);
                                File.Delete(FilePath + FileName + ".xml");
                                return;
                            }
                        }
                        try
                        {
                            string TimeStamp = DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() +
                            DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + "";

                            NewFileName = UserRoleId.ToString() + "_" + UserId.ToString() + "_" + TimeStamp + ".xml";
                            File.Move(FilePath + FileName + ".xml", FilePath + NewFileName); // Try to move
                            NewFile = FilePath + NewFileName;
                        }
                        catch (IOException ex)
                        {
                            NewFile = FilePath + FileName + ".xml";
                            NewFileName = FileName;
                        }

                        #endregion

                        DataTable dtNew = new DataTable();
                        dtNew = LoadGPXWaypoints(NewFile);

                       
                        _dtTrkpts = dtNew;
                        int trackCount = (dtNew.Rows.Count / 5) + 1;
                        double highestSpeed = 0;

                        DataTable dtNewRows = CheckPreviousGPXTrackPoints(UserId, 
                            schoolId,
                            classId, CloneDataTableForGPXUpload(dtNew));

                        if (dtNewRows.Rows.Count > 0)
                        {
                            
                            double distance = CalculateTotalDistance(dtNewRows);
                            double time = CalculateTotalTime(dtNewRows);
                            double timeAvg = CalculateAvgTime(dtNewRows);
                            
                            #region Calculate Average Speed

                            if (timeAvg > 0)
                            {
                                time = timeAvg;
                            }

                            double avgSpeed = 0.0;
                            if (time > 0) { avgSpeed = distance / time; }

                            #endregion

                            int speedLimit = 15;

                            if (ConfigurationManager.AppSettings["SpeedLimit"].ToString() != "")
                            {
                                speedLimit = Convert.ToInt32(ConfigurationManager.AppSettings["SpeedLimit"]);
                            }
                            
                            if (avgSpeed == 0)
                            {
                                ErrorLogManager.WriteLog(response, "011", "Invalid file!", PostedFile.FileName);
                                File.Delete(NewFile);
                            }
                            else
                            {
                                highestSpeed = GetHighestSpeedInGPX(dtNewRows);

                                #region Check ongoing stage information

                                int stagePlanId = 0;
                                double stageDistance = 0;
                                double distCovered = 0;
                                DataSet _dtStage = objStudent.GetCurrentStageInfo((studentId>0?studentId:UserId), 
                                    UserRoleId, classId);
                                if (_dtStage.Tables[0].Rows.Count > 0)
                                {
                                    stagePlanId = Convert.ToInt32(_dtStage.Tables[0].Rows[0]["StagePlanId"]);
                                    stageDistance = Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance"]);
                                    distCovered = double.Parse(_dtStage.Tables[0].Rows[0]["Distance_Covered"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                    //Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance_Covered"]);
                                }

                            #endregion
                            if (avgSpeed > speedLimit)
                            {
                                ErrorLogManager.WriteLog(response, "016", "Speed Limit Crossed!",  PostedFile.FileName);
                            }
                            else if (avgSpeed <= speedLimit && highestSpeed <= speedLimit)
                            {

                                //Save data in Student Uploads

                                #region Save data in Student Uploads

                                // Check for similar track points


                                int res = objStudent.StudentsUpload(
                                    UserRoleId, UserId,
                                    0, studentId,
                                    stagePlanId, stageDistance, distCovered, (NewFile), NewFileName,
                                    DateTime.Now, distance, time, classId, 1, trackCount);
                                if (res > 0)
                                {
                                    _SaveTrackPoints(_dtTrkpts, res);
                                    ErrorLogManager.WriteLog(response, "012", "File uploaded successfully!", PostedFile.FileName, true);
                                }
                                else
                                {
                                    ErrorLogManager.WriteLog(response, "008", "File already uploaded!", PostedFile.FileName);
                                    File.Delete(NewFile);
                                }

                                #endregion

                            }
                            else // Upload file out of speed limit. No change in stage distance.
                            {
                                #region Save data in Student Uploads
                                int res = objStudent.StudentsUploadExtraSpeed(
                                    UserRoleId, UserId,
                                    0,
                                    studentId, stagePlanId,
                                    stageDistance, distCovered, (NewFile), NewFileName,
                                    DateTime.Now, distance, time, classId, 0, trackCount);
                                if (res > 0)
                                {
                                    //if (UserRoleId == 5)
                                    //{
                                        _SaveTrackPoints(_dtTrkpts, res);
                                        #region Send email to Class Admin & City Admin for speed limit

                                        if (avgSpeed > speedLimit || highestSpeed > speedLimit)
                                        {
                                            try
                                            {
                                                string ClassAdminEmail = studInfo.Rows[0]["ClassAdminEmail"].ToString();
                                                string CityAdminEmail = studInfo.Rows[0]["CityAdminEmail"].ToString();

                                                StringBuilder sb = new StringBuilder();
                                                sb.Append("<p>Dear " + studInfo.Rows[0]["ClassAdminName"].ToString() + ",</p>");
                                                sb.Append("<p><b>" + UserName + " (Student in " + studInfo.Rows[0]["School"].ToString() + ", " + studInfo.Rows[0]["Class"].ToString() + ")</b> have uploaded a GPX file (" + NewFileName + ") with speed <b>" + avgSpeed.ToString() + " Kmph and heighest speed being " + highestSpeed + "</b>.</p>");
                                                sb.Append("<p>Kindly approve or reject file manually.</p>");
                                                Helper.sendMailMoreThanAvgSpeed("BikeTour - Speed Limit Crossed!", ClassAdminEmail, sb.ToString());

                                                StringBuilder sb2 = new StringBuilder();
                                                sb2.Append("<p>Dear " + studInfo.Rows[0]["CityAdminName"].ToString() + ",</p>");
                                                sb.Append("<p><b>" + UserName + " (Student in " + studInfo.Rows[0]["School"].ToString() + ", " + studInfo.Rows[0]["Class"].ToString() + ")</b> have uploaded a GPX file (" + NewFileName + ") with speed <b>" + avgSpeed.ToString() + "Kmph and heighest speed being " + highestSpeed + "</b>.</p>");
                                                sb.Append("<p>Kindly approve or reject file manually.</p>");
                                                Helper.sendMailMoreThanAvgSpeed("BikeTour - Speed Limit Crossed!", ClassAdminEmail, sb2.ToString());
                                            }
                                            catch (Exception ex)
                                            {

                                            }
                                        }

                                        #endregion
                                    //}
                                
                                    ErrorLogManager.WriteLog(response, "012", "File uploaded successfully!", PostedFile.FileName, true);
                                }
                                else
                                {
                                    ErrorLogManager.WriteLog(response, "008", "File already uploaded!", PostedFile.FileName);
                                    File.Delete(NewFile);
                                }

                                #endregion
                            }
                            }
                        }
                        else
                        {                            
                            ErrorLogManager.WriteLog(response, "008", "File already uploaded!", PostedFile.FileName);
                        }
                    }
                //}
                //else
                //{
                //    //string popupScript = "alert('" + (string)GetLocalResourceObject("MsgSelectGPX") + "');";//Select GPX file!
                //    //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //    ErrorLogManager.WriteLog(response, "010", "Select GPX file!");
                //}
                }
            }
            catch (Exception ex)
            {
                //string popupScript = "alert('" + (string)GetLocalResourceObject("MsgUploadException") + "');";//Select GPX file!
                //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                ErrorLogManager.WriteLog(response, "013", "Select GPX file!" + ex.Message);
            }
        }

        private bool checkGPXWayPoints(DataTable dt)
        {


            return false;
        }



        private int _SaveTrackPoints(DataTable _dtTrkpts, int studentuploadid)
        {
            _dtTrkpts.Columns.Add("StudId");
            _dtTrkpts.Columns.Add("StudUploadId");
            _dtTrkpts.Columns["time"].ColumnName = "TrackTime";
            for (int i = 0; i < _dtTrkpts.Rows.Count; i++)
            {
                _dtTrkpts.Rows[i]["StudId"] = UserId;
                _dtTrkpts.Rows[i]["StudUploadId"] = studentuploadid;
            }
            _dtTrkpts.Columns["StudId"].SetOrdinal(0);
            _dtTrkpts.Columns["StudUploadId"].SetOrdinal(1);
            _dtTrkpts.Columns["ele"].SetOrdinal(2);
            _dtTrkpts.Columns["TrackTime"].SetOrdinal(3);
            _dtTrkpts.Columns["lat"].SetOrdinal(4);
            _dtTrkpts.Columns["lon"].SetOrdinal(5);
            _dtTrkpts.Columns["TrkSeg_Id"].SetOrdinal(6);

            DataTable _newTable;
            _newTable = CloneDataTableForGPXUpload(_dtTrkpts);

            return objStudent.InsertGpxTrackPoints(_newTable);
        }

        public DataTable CloneDataTableForGPXUpload(DataTable _dtTrkpts)
        {
            DataTable _newTable;
            _newTable = _dtTrkpts.Clone();

            for (int i = 0; i < _dtTrkpts.Rows.Count; i += 5)
            {
                _newTable.ImportRow(_dtTrkpts.Rows[i]);
            }
            return _newTable;
        }


        public DataTable CheckPreviousGPXTrackPoints(int UserId, int SchoolId, int ClassId, DataTable dtNew)
        {
            DataTable result = new DataTable();
            //int similarrows = 0;

            //bool IsOverlapping = false;
            
            DataTable dtPrv = objStudent.GetGpxTractPoints(UserId, UserRoleId, ClassId);
            if (dtPrv.Rows.Count > 0)
            {
                for (int i = 0; i < dtPrv.Rows.Count; i++)
                {
                    DataRow[] _dr;
                    _dr = dtNew.Select("Lat='" + dtPrv.Rows[i]["lat"].ToString() + "' AND Lon='" + 
                        dtPrv.Rows[i]["lon"].ToString() + "' AND Time='" + dtPrv.Rows[i]["TrackTime"].ToString() + "'");
                    if (_dr.Length != 0)
                    {
                        int oldRows = 0;
                        if (dtPrv.Rows[i]["TrackPointCount"].ToString() != "")
                        {
                            oldRows = Convert.ToInt32(dtPrv.Rows[i]["TrackPointCount"]);
                        }

                        int newRows = dtNew.Rows.Count;

                        if (newRows > oldRows)
                        {
                            for (int j = 0; j < (newRows - (newRows - oldRows)) - 1; j++)
                            {
                                dtNew.Rows[0].Delete();
                            }
                            result = dtNew;
                            for (int j = 0; j < dtPrv.Rows.Count; j++)
                            {
                                DataRow[] _drNew;
                                _drNew = dtNew.Select("Lat='" + dtPrv.Rows[j]["lat"].ToString() + "' AND Lon='" + 
                                    dtPrv.Rows[j]["lon"].ToString() + "' AND Time='" + dtPrv.Rows[j]["TrackTime"].ToString() + "'");
                                if (_drNew.Length != 0)
                                {
                                    result = new DataTable();
                                    break;
                                }
                            }

                        }

                        break;
                    }
                    else
                    {
                        if (!objStudent.CheckGPXFile(dtNew, ClassId, UserId))
                        {
                            dtNew.Clear();
                            return dtNew;
                        }
                        result = dtNew;
                    }

                }
            }
            else
            {
                if (!objStudent.CheckGPXFile(dtNew, ClassId, UserId))
                {
                    dtNew.Clear();
                    return dtNew;
                }
                result = dtNew;
            }
            return result;
        }

        public DataTable CheckPreviousGPX(int UserId, int SchoolId, 
                                    int ClassId, DataTable dtNew)
        {
            // Check if the same file is previously uploaded
            // and if there are updated trackpoints in file

            DataTable result = new DataTable();
            DataTable dtPrv = objStudent.GetPreviousUploadedFile(UserId, UserRoleId);
            if (dtPrv.Rows.Count > 0)
            {
                for (int i = 0; i < dtPrv.Rows.Count; i++)
                {
                    string FilePath = ConfigurationManager.AppSettings["GPXWebPath"].ToString() + SchoolId.ToString() + "/" + ClassId.ToString() + "/" + 
                        UserId.ToString() + "/" + dtPrv.Rows[i]["FileName"].ToString();
                    if (File.Exists(FilePath))
                    {
                        DataTable dtOld = new DataTable();
                        dtOld = LoadGPXWaypoints(FilePath);

                        if (dtOld.Rows.Count > 1 && dtNew.Rows.Count > 1)
                        {
                            int similarrows = MatchingFile(dtOld, dtNew);

                            if (similarrows > 0)
                            {
                                int oldRows = dtOld.Rows.Count;
                                int newRows = dtNew.Rows.Count;

                                if (newRows > oldRows)
                                {
                                    for (int j = 0; j < (newRows - oldRows) - 1; j++)
                                    {
                                        dtNew.Rows[0].Delete();
                                    }
                                    result = dtNew;
                                }

                                break;
                            }
                            else
                            {
                                result = dtNew;
                            }
                        }
                    }
                    else
                    {
                        result = dtNew;
                    }
                }
            }
            else
            {
                result = dtNew;
            }

            return result;
        }

        public int MatchingFile(DataTable dtOld, DataTable dtNew)
        {
            int similarrows = 0;
            if ((dtNew.Rows[0]["lat"].ToString() == dtOld.Rows[0]["lat"].ToString()) && (dtNew.Rows[0]["lon"].ToString() == dtOld.Rows[0]["lon"].ToString()) && (dtNew.Rows[0]["time"].ToString() == dtOld.Rows[0]["time"].ToString()))
            {
                similarrows++;
            }
            if ((dtNew.Rows[1]["lat"].ToString() == dtOld.Rows[1]["lat"].ToString()) && (dtNew.Rows[1]["lon"].ToString() == dtOld.Rows[1]["lon"].ToString()) && (dtNew.Rows[1]["time"].ToString() == dtOld.Rows[1]["time"].ToString()))
            {
                similarrows++;
            }

            return similarrows;
        }

        public bool IsFileUploaded(string fileName)
        {
            bool exists = false;
            if (File.Exists(fileName))
            {
                exists = true;
            }
            return exists;
        }

        public double CalculateTotalDistance(DataTable _dt)
        {
            //DataTable _dt = new DataTable();
            //_dt = LoadGPXWaypoints(gpxFile);
            double totalDist = 0.0;
            if (_dt != null && _dt.Rows.Count > 0)
            {
                for (int i = 0; i < _dt.Rows.Count - 1; i++)
                {
                    double d = 0.0;

                    double lat1 = double.Parse(_dt.Rows[i]["lat"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                    double lon1 = double.Parse(_dt.Rows[i]["lon"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                    double lat2 = double.Parse(_dt.Rows[i + 1]["lat"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                    double lon2 = double.Parse(_dt.Rows[i + 1]["lon"].ToString(), System.Globalization.CultureInfo.InvariantCulture);

                    d = getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2);
                    totalDist += d;
                }
            }
            return totalDist;
        }

        public double CalculateAvgTime(DataTable _dt)
        {
            double avgTime = 0.0;
            double avgTotalTime = 0.0;
            int totalSegments = 1;
            //DataTable _dt = new DataTable();
            //_dt = LoadGPXWaypoints(gpxFile);
            try
            {
                if (_dt != null && _dt.Rows.Count > 0)
                {
                    totalSegments = _dt.Rows.Count;
                    if (_dt.Columns.Contains("time"))
                    {
                        int trkseg = 0;
                        int oldtrkseg = 0;

                        for (int i = 1; i < _dt.Rows.Count - 1; i++)
                        {
                            if (_dt.Columns.Contains("trkseg_Id"))
                            {
                                if (trkseg != Convert.ToInt32(_dt.Rows[i]["trkseg_Id"]))
                                {
                                    oldtrkseg = trkseg;
                                    trkseg = Convert.ToInt32(_dt.Rows[i]["trkseg_Id"]);
                                }
                            }

                            if (trkseg == oldtrkseg)
                            {
                                DateTime dtStart = Convert.ToDateTime(_dt.Rows[i - 1]["time"]);
                                DateTime dtEnd = Convert.ToDateTime(_dt.Rows[i]["time"].ToString());
                                avgTime += (dtEnd - dtStart).TotalHours;
                            }
                            else
                            {
                                avgTotalTime += avgTime;
                                avgTime = 0;
                            }

                            if (oldtrkseg != trkseg)
                            {
                                oldtrkseg = trkseg;
                            }

                        }
                    }
                }
            }
            catch { }

            return avgTotalTime;
        }

        public double CalculateTotalTime(DataTable _dt)
        {
            double totalTime = 0.0;
            //DataTable _dt = new DataTable();
            //_dt = LoadGPXWaypoints(gpxFile);

            if (_dt != null && _dt.Rows.Count > 0)
            {
                if (_dt.Columns.Contains("time"))
                {
                    if (_dt.Rows[0]["time"].ToString() != "" && _dt.Rows[_dt.Rows.Count - 1]["time"].ToString() != "")
                    {
                        DateTime dtStart = Convert.ToDateTime(_dt.Rows[0]["time"].ToString());
                        DateTime dtEnd = Convert.ToDateTime(_dt.Rows[_dt.Rows.Count - 1]["time"].ToString());

                        totalTime = (dtEnd - dtStart).TotalHours;




                    }
                }
            }

            return totalTime;
        }

        public double GetHighestSpeedInGPX(DataTable _dt)
        {
            double highestSpeed = 0;
            double totalTime = 0;
            double distance = 0;

            DataTable _dtFiltered = _dt.Copy();
            if (_dt != null && _dt.Rows.Count > 0)
            {
                if (_dt.Columns.Contains("time"))
                {

                    for (int i = 0; i < _dt.Rows.Count; i++)
                    {
                        if (_dt.Rows[i]["time"].ToString() == "")
                            _dtFiltered.Rows.Remove(_dt.Rows[i]);
                    }



                    for (int i = 0; i < _dtFiltered.Rows.Count - 1; i++)
                    {

                        DateTime dtStart = Convert.ToDateTime(_dt.Rows[i]["time"].ToString());
                        DateTime dtEnd = Convert.ToDateTime(_dt.Rows[i + 1]["time"].ToString());

                        totalTime = (dtEnd - dtStart).TotalHours;

                        double lat1 = double.Parse(_dt.Rows[i]["lat"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                        double lon1 = double.Parse(_dt.Rows[i]["lon"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                        double lat2 = double.Parse(_dt.Rows[i + 1]["lat"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                        double lon2 = double.Parse(_dt.Rows[i + 1]["lon"].ToString(), System.Globalization.CultureInfo.InvariantCulture);

                        distance = getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2);

                        if (highestSpeed < (distance / totalTime))
                            highestSpeed = distance / totalTime;

                    }
                }

            }

            return highestSpeed;
        }

        public DataTable LoadGPXWaypoints(string sFile)
        {
            DataSet _ds = new DataSet("MyDataSet");
            _ds.ReadXml(sFile);

            DataTable _dt = new DataTable();
            _dt = _ds.Tables["trkpt"];
            return _dt;
        }

        public double getDistanceFromLatLonInKm(double lat1, double lon1, double lat2, double lon2)
        {
            /* REF: stackoverflow.com/questions/27928/how-do-i-calculate-distance-between-two-latitude-longitude-points
            */
            double R = 6371;
            double dLat = deg2rad(lat2 - lat1);  // deg2rad below
            double dLon = deg2rad(lon2 - lon1);
            double a = Math.Sin(dLat / 2) * Math.Sin(dLat / 2) +
                       Math.Cos(deg2rad(lat1)) * Math.Cos(deg2rad(lat2)) *
                       Math.Sin(dLon / 2) * Math.Sin(dLon / 2);
            double c = 2 * Math.Atan2(Math.Sqrt(a), Math.Sqrt(1 - a));
            double d = R * c; // Distance in km
            return d;
        }

        public double deg2rad(double deg)
        {
            return deg * (Math.PI / 180);
        }
        #endregion

        private DataTable GetSchoolClassMasterDetails(Int32 schoolId, Int32 classId)
        {
            StringBuilder sqlString = new StringBuilder();
            DataTable _dt = null;
            try
            {
                sqlString.Append(" select SM.School,SM.SchoolId, SM.CityId, SCM.Class,SCM.ClassYear, ");
                sqlString.Append(" SCM.ClassId from SchoolClassMaster SCM inner join SchoolMaster SM on SCM.SchoolId = SM.SchoolId");
                sqlString.Append(" where SCM.IsActive = 1");
                sqlString.Append(" AND SM.SchoolId =");
                sqlString.Append(schoolId);
                sqlString.Append(" AND SCM.ClassId = ");
                sqlString.Append(classId);                

               _dt = DataAccessLayer.ReturnDataTable(sqlString.ToString());
            }
            catch { }
            return _dt;
        }
    }
}
