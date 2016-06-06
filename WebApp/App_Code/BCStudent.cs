using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;

/// <summary>
/// Summary description for BCStudent
/// </summary>
/// 

public class BCStudent
{
    DataTable _dt = new DataTable();
    DataSet _ds = new DataSet();

    public BCStudent()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public void UpdateFileDeleteFlag(int schoolId, int classId, int studentId, string fileName, int deletedById)
    {
        string sqlScript = "SELECT StagePlanId, Kilometer FROM StudentUpload"+
              " WHERE FileName = '" + fileName + "'" +
            " AND ClassId = " + classId +
            " AND StudentId = " + studentId;

        _dt = DataAccessLayer.ReturnDataTable(sqlScript);

        if (_dt != null && _dt.Rows != null &&
            _dt.Rows.Count > 0)
        {
            int CompletedStageId = Convert.ToInt32(_dt.Rows[0]["StagePlanId"]);
            int Kilometer = Convert.ToInt32(_dt.Rows[0]["Kilometer"]);

            sqlScript = "UPDATE StagePlan " +
                " SET Distance_Covered = Distance_Covered - " + Kilometer +
              " WHERE StagePlanId = " + CompletedStageId;

            DataAccessLayer.ExecuteNonQuery(sqlScript);

            sqlScript = "UPDATE StudentUpload SET  " +
           " ISDeleted = 1 ," +
           " DeleteDate = '" + System.DateTime.Now + "'," +
           " DeletedBy = " + deletedById +
           " WHERE FileName = '" + fileName + "'" +
           " AND ClassId = " + classId +
           " AND StudentId = " + studentId;

            DataAccessLayer.ExecuteNonQuery(sqlScript);
        }

       
    }

    #region Student   :: Insert
    public int InsertStudent(DOLUser objUser)
    {
        int result = 0;
        try
        {

            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@StudentId", objUser.UserId),
            new SqlParameter("@SchoolId", objUser.SchoolId),
            new SqlParameter("@ClassId",objUser.ClassId),
            new SqlParameter("@CityId",objUser.CityId),
            new SqlParameter("@FirstName",objUser.FirstName),
            new SqlParameter("@LastName",objUser.LastName),
            new SqlParameter("@Email",objUser.Email),
            new SqlParameter("@Password",objUser.Password),
            new SqlParameter("@UserName",objUser.UserName),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERTUPDATE_STUDENT", "@RESULT");

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return result;
    }
    #endregion
    public DataTable GetMyProfileInfo(int UserID)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@StudentID", UserID) }, "SP_GET_STUDENT");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public DataTable GetPreviousUploadedFile(int UserId, int RoleId)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { 
                new SqlParameter("@UserId", UserId),
                new SqlParameter("@RoleId", RoleId)
            }, "SP_GET_PREVIOUS_UPLOADEDFILE");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public int InsertUpdateStudent(DOLUser objUser)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@CityAdminId", objUser.UserId),
            
            new SqlParameter("@FirstName",objUser.FirstName),
            new SqlParameter("@LastName",objUser.LastName),
            new SqlParameter("@Address", objUser.Address),
            new SqlParameter("@Email", objUser.Email),
            new SqlParameter("@Password",objUser.Password),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_UPDATE_CITYADMIN", "@RESULT");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return result;
    }

    public int StudentsUpload(int StudentUploadId, int StudentId, int StagePlanId, double StagePlanDistance, double DistanceCovered, string FilePath, string FileName, DateTime Uploadeddate, double Kilometer, double Time, int ClassId, int IsValid, int trackCount)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(
            new SqlParameter[] { 
            new SqlParameter("@RoleId", HttpContext.Current.Session["UserRoleId"]),
            new SqlParameter("@UserId", HttpContext.Current.Session["UserId"]),
            new SqlParameter("@StudentUploadId", StudentUploadId),
            new SqlParameter("@StudentId",StudentId),
            new SqlParameter("@StagePlanId",StagePlanId),
            new SqlParameter("@StagePlanDistance",StagePlanDistance),
            new SqlParameter("@DistanceCovered",DistanceCovered),
            new SqlParameter("@CalculateDistance","0"),
            new SqlParameter("@FilePath", FilePath),
            new SqlParameter("@FileName", FileName),
            new SqlParameter("@Uploadeddate",Uploadeddate),
            new SqlParameter("@Kilometer",Kilometer),
            new SqlParameter("@Time",Time),
            new SqlParameter("@ClassId",ClassId),
            new SqlParameter("@IsValid",IsValid),
            new SqlParameter("@TrackCount",trackCount),
            new SqlParameter("@result",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_STUDENTUPLOADS", "@result");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public int StudentsUploadExtraSpeed(int StudentUploadId, int StudentId, int StagePlanId, double StagePlanDistance, double DistanceCovered, string FilePath, string FileName, DateTime Uploadeddate, double Kilometer, double Time, int ClassId, int IsValid, int trackCount)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(
            new SqlParameter[] { 
            new SqlParameter("@RoleId", HttpContext.Current.Session["UserRoleId"]),
            new SqlParameter("@UserId", HttpContext.Current.Session["UserId"]),
            new SqlParameter("@StudentUploadId", StudentUploadId),
            new SqlParameter("@StudentId",StudentId),
            new SqlParameter("@StagePlanId",StagePlanId),
            new SqlParameter("@StagePlanDistance",StagePlanDistance),
            new SqlParameter("@DistanceCovered",DistanceCovered),
            new SqlParameter("@CalculateDistance","0"),
            new SqlParameter("@FilePath", FilePath),
            new SqlParameter("@FileName", FileName),
            new SqlParameter("@Uploadeddate",Uploadeddate),
            new SqlParameter("@Kilometer",Kilometer),
            new SqlParameter("@Time",Time),
            new SqlParameter("@ClassId",ClassId),
            new SqlParameter("@IsValid",IsValid),
            new SqlParameter("@TrackCount",trackCount),
            new SqlParameter("@result",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_STUDENTUPLOADS_EXTRA_SPEED", "@result");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }


    public DataTable GetSchoolInfo(int UserId)
    {
        _dt = DataAccessLayer.ReturnDataTable("Select CM.Class, SM.School from SchoolClassMaster CM LEFT JOIN SchoolMaster SM ON CM.SchoolId=SM.SchoolId WHERE CM.ClassId=(Select ClassId from StudentMaster where StudentId=" + UserId + ")");
        return _dt;
    }

    public DataSet GetCurrentStageInfo(int userId, int userRoleId, int classId)
    {
        _ds = DataAccessLayer.ExecuteStoredProcedureToRetDataSet(new SqlParameter[]{new SqlParameter("@userid",userId),
        new SqlParameter("@UserRoleId",userRoleId),
        new SqlParameter("@ClassId",classId)}, "SP_GET_CURRENTSTAGE");

        return _ds;
    }


    public DataTable GetLastCompleteStageInfo(int userId, int userRoleId, int classId)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[]{new SqlParameter("@UserId",userId),
        new SqlParameter("@RoleId",userRoleId),
        new SqlParameter("@ClassId",classId)}, "SP_GET_LAST_COMPLETE_STAGE");

        return _dt;
    }


    public DataTable GetStudentInfo(int userId)
    {
        _dt = DataAccessLayer.ReturnDataTable("Select * from StudentMaster Where StudentId=" + userId + "");

        return _dt;
    }

    public int GetCompleteLegCount(int classId)
    {
        int res = 0;
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select * from StagePlan where ClassId=" + classId + " and StatusId=3 and IsActive=1");
            res = _dt.Rows.Count;
        }
        catch { }
        return res;
    }

    public int SaveUploadedFileStatus(int StudentUploadId, int IsValid)
    {
        int result = 0;
        try
        {
            string selQry = "select SU.StagePlanId, SU.ClassId, SU.Kilometer, SU.IsValid, SP.Distance_Covered ";
            selQry += " from StudentUpload SU LEFT JOIN StagePlan SP ON SU.StagePlanId=SP.StagePlanId ";
            selQry += " Where SU.StudentUploadId=" + StudentUploadId + " ";
            DataTable _dt = DataAccessLayer.ReturnDataTable(selQry);

            double ExistingDistance = double.Parse((_dt.Rows[0]["Kilometer"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
            double DistanceCovered = double.Parse((_dt.Rows[0]["Distance_Covered"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
            double TotalDistance = 0;
            if (_dt.Rows.Count > 0)
            {
                int CurrentStageId = 0;
                double CurrentStageDistance = 0;
                double CurrentStageCovered = 0;
                int CompletedStageId = 0;
                double CompletedStageOrgDistance = 0;
                double CompletedStageDistance = 0;
                double CompletedStageExtraDist = 0;

                double CalculateDist = 0;
                double ExtraDistDifference = 0;

                DataTable dtLastStage = GetLastCompleteStageInfo(0, 0, Convert.ToInt32(_dt.Rows[0]["ClassId"]));
                DataTable dtCurrentStage = GetCurrentRunningStageByClass(Convert.ToInt32(_dt.Rows[0]["ClassId"]));

                if (dtLastStage.Rows.Count > 0)
                {
                    CompletedStageId = Convert.ToInt32(dtLastStage.Rows[0]["StagePlanId"]);
                    CompletedStageOrgDistance = double.Parse((dtLastStage.Rows[0]["Distance"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
                    CompletedStageDistance = double.Parse((dtLastStage.Rows[0]["Distance_Covered"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
                    CompletedStageExtraDist = double.Parse((dtLastStage.Rows[0]["Distance_Extra"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
                }

                if (dtCurrentStage.Rows.Count > 0)
                {
                    CurrentStageId = Convert.ToInt32(dtCurrentStage.Rows[0]["StagePlanId"]);
                    CurrentStageDistance = double.Parse((dtCurrentStage.Rows[0]["Distance"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
                    CurrentStageCovered = double.Parse((dtCurrentStage.Rows[0]["Distance_Covered"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
                }

                if ((_dt.Rows[0]["IsValid"].ToString().ToLower() == "true" || _dt.Rows[0]["IsValid"].ToString().ToLower() == "") && IsValid == 0)
                {
                    if (dtCurrentStage.Rows.Count > 0)
                    {
                        //string qry = "";
                        //string qry2 = "";

                        //CalculateDist = CurrentStageCovered - ExistingDistance;

                        //if (CalculateDist < 0)
                        //{
                        //    //update current & last leg dist
                        //    qry2 = "Update StagePlan Set Distance_Covered=0 Where StagePlanId=" + CurrentStageId + "";
                        //    DataAccessLayer.ExecuteNonQuery(qry2);

                        //    CalculateDist = Math.Abs(CalculateDist);
                        //    double distCovered = CompletedStageDistance - CalculateDist;
                        //    if (distCovered < 0) { distCovered = 0; }
                        //    qry = "Update StagePlan Set Distance_Covered='" + distCovered.ToString().Replace(",", ".") + "' Where StagePlanId=" + CompletedStageId + "";
                        //    DataAccessLayer.ExecuteNonQuery(qry);

                        //    if (dtLastStage.Rows.Count > 0)
                        //    {
                        //        int ToCityId = Convert.ToInt32(dtLastStage.Rows[0]["EndCityId"]);
                        //        string updQuizResults = "update QuizResult Set IsDeleted=1 Where ClassId=" + Convert.ToInt32(_dt.Rows[0]["ClassId"]) + " and CityId=" + ToCityId + "";
                        //        int resQuizResults = DataAccessLayer.ExecuteNonQuery(updQuizResults);
                        //    }
                        //}
                        //else
                        //{
                        //    //update current leg dist only
                        //    qry2 = "Update StagePlan Set Distance_Covered='" + CalculateDist.ToString().Replace(",", ".") + "' Where StagePlanId=" + CurrentStageId + "";
                        //    DataAccessLayer.ExecuteNonQuery(qry2);
                        //}
                    }
                    else if (dtLastStage.Rows.Count > 0)
                    {
                        // update last leg
                        // Check Distance_Extra for last leg
                        string qry = "";
                        string qry2 = "";
                        if (CompletedStageId != 0)
                        {
                            ExtraDistDifference = CompletedStageExtraDist - ExistingDistance;
                            if (ExtraDistDifference < 0)
                            {
                                CalculateDist = CompletedStageDistance + (ExtraDistDifference);
                                // update Distance_Extra to Zero & also update Distance_Coverd
                                qry = "Update StagePlan Set Distance_Extra=0 Where StagePlanId=" + CompletedStageId + "";
                                qry2 = "Update StagePlan Set Distance_Covered='" + CalculateDist.ToString().Replace(",", ".") + "' Where StagePlanId=" + CompletedStageId + "";

                                DataAccessLayer.ExecuteNonQuery(qry);
                                DataAccessLayer.ExecuteNonQuery(qry2);

                                if (dtLastStage.Rows.Count > 0)
                                {
                                    int ToCityId = Convert.ToInt32(dtLastStage.Rows[0]["EndCityId"]);
                                    string updQuizResults = "Update QuizResult Set IsDeleted=1 Where ClassId=" + Convert.ToInt32(_dt.Rows[0]["ClassId"]) + " and CityId=" + ToCityId + "";
                                    int resQuizResults = DataAccessLayer.ExecuteNonQuery(updQuizResults);
                                }
                            }
                            else
                            {
                                // only update Distance_Extra
                                CalculateDist = CompletedStageExtraDist + (ExistingDistance);
                                qry = "Update StagePlan Set Distance_Extra='" + ExtraDistDifference.ToString().Replace(",", ".") + "' Where StagePlanId=" + CompletedStageId + "";
                                DataAccessLayer.ExecuteNonQuery(qry);
                            }
                        }
                    }
                    else
                    {
                        DataTable dtFirst = GetFirstStageByClass(Convert.ToInt32(_dt.Rows[0]["ClassId"]));
                    }
                }

                else if ((_dt.Rows[0]["IsValid"].ToString().ToLower() == "false" || _dt.Rows[0]["IsValid"].ToString().ToLower() == "") && IsValid == 1)
                {

                    if (dtCurrentStage.Rows.Count > 0)
                    {
                        string qry = "";
                        int testRestlt = IsTestForLegIsPassed(CurrentStageId, Convert.ToInt32(_dt.Rows[0]["ClassId"]));
                        CalculateDist = CurrentStageCovered + ExistingDistance;
                        if (CalculateDist > CurrentStageDistance)
                        {
                            //update Distance_covered to Distance & add Remaining Dist to Distance_Extra
                            double distExtra = CalculateDist - CurrentStageDistance;
                            qry = "Update StagePlan Set Distance_Covered='" + CurrentStageDistance.ToString().Replace(",", ".") + "', Distance_Extra='" + distExtra.ToString().Replace(",", ".") + "' where StagePlanId=" + CurrentStageId + "";
                            DataAccessLayer.ExecuteNonQuery(qry);
                        }
                        else
                        {
                            qry = "Update StagePlan Set Distance_Covered='" + CalculateDist.ToString().Replace(",", ".") + "' where StagePlanId=" + CurrentStageId + "";
                            DataAccessLayer.ExecuteNonQuery(qry);
                        }
                    }
                    else if (dtLastStage.Rows.Count > 0)
                    {
                        // update last leg
                        string qry2 = "";
                        if (CompletedStageId != 0)
                        {
                            CalculateDist = CompletedStageDistance + ExistingDistance;
                            if (CalculateDist > CompletedStageOrgDistance)
                            {
                                double distExtra = CompletedStageExtraDist + ExistingDistance;
                                qry2 = "Update StagePlan Set Distance_Extra='" + distExtra.ToString().Replace(",", ".") + "' Where StagePlanId=" + CompletedStageId + "";
                                DataAccessLayer.ExecuteNonQuery(qry2);
                            }
                            else
                            {
                                qry2 = "Update StagePlan Set Distance_Covered='" + CalculateDist.ToString().Replace(",", ".") + "' Where StagePlanId=" + CompletedStageId + "";
                                DataAccessLayer.ExecuteNonQuery(qry2);
                            }
                        }
                    }
                    else
                    {
                        DataTable dtFirst = GetFirstStageByClass(Convert.ToInt32(_dt.Rows[0]["ClassId"]));
                        if (dtFirst.Rows.Count > 0)
                        {
                            CurrentStageId = Convert.ToInt32(dtFirst.Rows[0]["StagePlanId"]);
                            CurrentStageDistance = double.Parse((dtFirst.Rows[0]["Distance"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);
                            CurrentStageCovered = double.Parse((dtFirst.Rows[0]["Distance_Covered"].ToString()).Replace(",", "."), System.Globalization.CultureInfo.InvariantCulture);

                            if (CurrentStageId != 0)
                            {
                                string qry = "";
                                CalculateDist = CurrentStageCovered + ExistingDistance;
                                if (CalculateDist > CurrentStageDistance)
                                {
                                    //update Distance_covered to Distance & add Remaining Dist to Distance_Extra
                                    double distExtra = CalculateDist - CurrentStageDistance;
                                    qry = "Update StagePlan Set Distance_Covered='" + CurrentStageDistance.ToString().Replace(",", ".") + "', Distance_Extra=Distance_Extra+'" + distExtra.ToString().Replace(",", ".") + "' where StagePlanId=" + CurrentStageId + "";
                                    DataAccessLayer.ExecuteNonQuery(qry);
                                }
                                else
                                {
                                    qry = "Update StagePlan Set Distance_Covered='" + CalculateDist.ToString().Replace(",", ".") + "' where StagePlanId=" + CurrentStageId + "";
                                    DataAccessLayer.ExecuteNonQuery(qry);
                                }
                            }
                        }
                    }
                }

                string qry3 = "Update StudentUpload set IsValid=" + IsValid + " where StudentUploadId=" + StudentUploadId + " ";
                result = DataAccessLayer.ExecuteNonQuery(qry3);
            }
        }
        catch { }
        return result;
    }

    public DataTable GetScoreBoard(int classId)
    {
        return DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@ClassId", classId) }, "SP_GET_SCOREBOARD");
    }

    public DataTable GetVisitedCity(string classId)
    {
        return DataAccessLayer.ReturnDataTable("Select cm.CityName,cm.CityId from StagePlan sp,StagePlanStatus sps,CityMaster cm where sp.StatusId=sps.StatusId and cm.CityId=sp.ToCityId and sp.ClassId='" + classId + "' and sp.StatusId=3");
    }

    public DataTable GetCityInfo(int cityId)
    {
        return DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("CityId", cityId) }, "SP_GET_VISITED_CITYINFO");
    }

    public bool IsDuplicateUsername(string userName, int userId)
    {
        if (userId == 0)
            _dt = DataAccessLayer.ReturnDataTable("select 1 from LoginDtls where LoginName = '" + userName + "' and LoginId <>" + userId);
        else
            _dt = DataAccessLayer.ReturnDataTable("select 1 from LoginDtls where LoginName = '" + userName + "' and LoginId <>(select loginid from StudentMaster where StudentId= " + userId + ")");
        if (_dt != null && _dt.Rows.Count > 0)
            return true;
        else
            return false;
    }


    public int InsertGpxTrackPoints(DataTable dt)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { 
                new SqlParameter("@myTableType", dt),
            }, "SP_MANAGE_GPXTRACKPOINTS");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return result;
    }

    public bool CheckGPXFile(DataTable dt, int classid, int studentId)
    {
        bool result = true;
        object val;
        try
        {
            val = (DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { 
                new SqlParameter("@myTableType", dt), new SqlParameter("@classId",classid), new SqlParameter("@studentId", studentId) }, "SP_CHECK_GPXTRACKPOINTSOVERLAP").Rows[0][0]);
            if (val != null)
                if (Convert.ToInt32(val) > 0)
                    result = false;
                else
                    result = true;
            return result;
        }
        catch (Exception ex)
        {
            throw ex;
        }

    }

    public int DeleteStudentUpload(int StudentUploadId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { 
                new SqlParameter("@StudentUploadId", StudentUploadId)}, "SP_DELETE_STUDENT_UPLOADS");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }


    public DataTable GetGpxTractPoints(int StudentId, int roleid, int classid)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { 
                new SqlParameter("@StudentId", StudentId),new SqlParameter("@RoleId", roleid),new SqlParameter("@ClassId", classid)
            }, "SP_GET_GPXTRACKPOINTS");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public DataTable GetStudentStagePlan(string classid, string studid)
    {
        DataTable dtt = new DataTable();
        try
        {
            dtt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@ClassId", classid) , new SqlParameter("@StudentId",studid)
            }, "SP_GET_STUDENTSTAGEPLAN");
        }
        catch
        { }
        return dtt;
    }

    #region Quiz Result

    public int InsertQuizResult(int ResultId, int StudentId, int ClassId, int CityId, double OutofScore, double PassingScore, double StudentScore, int IsPassed)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] {
            new SqlParameter("@ResultId", ResultId),
            new SqlParameter("@StudentId",StudentId),
            new SqlParameter("@ClassId",ClassId),
            new SqlParameter("@CityId",CityId),
            new SqlParameter("@OutofScore",OutofScore),
            new SqlParameter("@PassingScore",PassingScore),
            new SqlParameter("@StudentScore",StudentScore),
            new SqlParameter("@IsPassed",IsPassed),
            new SqlParameter("@result",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_QUIZRESULT", "@result");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public DataTable GetQuizResult(int classid, int cityid)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select * from QuizResult where ClassId=" + classid + " and CityId=" + cityid + " and IsPassed=1 and IsDeleted=0");
        }
        catch (Exception ex)
        {
        }
        return _dt;
    }

    public int GetNextStageFiles(int Classid)
    {
        int res = 0;
        try
        {
            string Qry = "select * from StudentUpload where ClassId=" + Classid + " and Uploadeddate > (select ResultDate from QuizResult where ClassId=" + Classid + " and IsPassed=1)";
            _dt = DataAccessLayer.ReturnDataTable(Qry);
            res = _dt.Rows.Count;
        }
        catch (Exception ex)
        {
        }
        return res;
    }

    public DataTable GetLastCompleteLeg(int classId)
    {
        try
        {
            string qry = "select top 1 SP.*, ";
            qry += " StartCity = (select CityName from CityMaster where CityId=SP.FromCityId),";
            qry += " EndCity = (select CityName from CityMaster where CityId=SP.ToCityId), ";
            qry += " FromCityimage=(select CityImage From CityMaster where CityId=SP.FromCityId),";
            qry += " ToCityimage=(select CityImage From CityMaster where CityId=SP.ToCityId), ";
            qry += " FromCityLat=(select lat from CityMaster where CityId=SP.FromCityId), ";
            qry += " FromCityLong=(select long from CityMaster where CityId=SP.FromCityId), ";
            qry += " ToCityLat=(select lat from CityMaster where CityId=SP.ToCityId),  ";
            qry += " ToCityLong=(select long from CityMaster where CityId=SP.ToCityId) ";
            qry += " from [StagePlan] SP where SP.StatusId=3 and SP.IsActive=1 ";
            qry += " and SP.ClassId=" + classId + " order by SP.StagePlanId desc";
            _dt = DataAccessLayer.ReturnDataTable(qry);
        }
        catch { }

        return _dt;
    }

    public DataTable GetNextStageLeg(int classId)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select top 1 * from [StagePlan] where StatusId=1 and IsActive=1 and ClassId=" + classId + " order by StagePlanId asc");
        }
        catch { }

        return _dt;
    }

    public int StartNextLeg(double Distance, double ExtraDistace, int StagePlanId)
    {
        int res = 0;
        try
        {
            string tDistance = Distance.ToString().Replace(",", ".");
            string tExtraDistace = ExtraDistace.ToString().Replace(",", ".");
            res = DataAccessLayer.ExecuteNonQuery("update [StagePlan] set Distance_Covered=" + tDistance + ", Distance_Extra=" + tExtraDistace + " where StagePlanId=" + StagePlanId + " ");
        }
        catch (Exception ex)
        {
        }
        return res;
    }

    public int ClearExtraLegDistance(int StagePlanId)
    {
        int res = 0;
        try
        {
            res = DataAccessLayer.ExecuteNonQuery("update [StagePlan] set Distance_Extra=0 where StagePlanId=" + StagePlanId + " ");
        }
        catch (Exception ex)
        {
        }
        return res;
    }

    public DataTable GetCurrentStageByClass(int ClassId)
    {
        _dt = DataAccessLayer.ReturnDataTable("select top 1 * from StagePlan where ClassId=" + ClassId + " and IsActive=1 and StatusId=1 order by StagePlanId asc");
        return _dt;
    }

    public DataTable GetCurrentRunningStageByClass(int ClassId)
    {
        _dt = DataAccessLayer.ReturnDataTable("select top 1 * from StagePlan where ClassId=" + ClassId + " and IsActive=1 and StatusId=2 order by StagePlanId desc");
        return _dt;
    }

    public DataTable GetFirstStageByClass(int ClassId)
    {
        _dt = DataAccessLayer.ReturnDataTable("select top 1 * from StagePlan where ClassId=" + ClassId + " and IsActive=1 order by StagePlanId asc");
        return _dt;
    }

    public int IsTestForLegIsPassed(int StagePlanId, int ClassId)
    {
        int res = 0;
        string qry = "select COUNT(*) as ResCount from QuizResult where IsPassed=1 and ClassId=" + ClassId + " ";
        qry += "and CityId=(select FromCityId from StagePlan where ClassId = " + ClassId + " ";
        qry += "and StagePlanId =" + StagePlanId + ") and IsDeleted=0";
        _dt = DataAccessLayer.ReturnDataTable(qry);

        if (_dt.Rows.Count > 0)
        {
            res = Convert.ToInt32(_dt.Rows[0]["ResCount"]);
        }
        return res;
    }

    #endregion
}