using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BCClassAdmin
/// </summary>
public class BCClassAdmin
{
    DataTable _dt = new DataTable();
    DataSet _ds = new DataSet();

	public BCClassAdmin()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataSet GetMyProfileInfo(int UserID)
    {
        try
        {
            _ds = DataAccessLayer.ExecuteStoredProcedureToRetDataSet(new SqlParameter[] { new SqlParameter("@ClassAdminID", UserID) }, "SP_GET_CLASSAdmin");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _ds;
    }

    public int DeleteLastLeg(int stagePlanId)
    {
        return DataAccessLayer.ExecuteNonQuery("update stageplan set isactive = 0 where stageplanid=" + stagePlanId);
    }
   
    public string GetCityIdFromClassId(string classId)
    {
        object result = DataAccessLayer.ExecuteScalar("select sm.CityId from SchoolClassMaster scm inner join SchoolMaster sm " +
            "on scm.SchoolId = sm.SchoolId " +
            "where scm.ClassId = " + classId);
        return result.ToString();
    }

    public DataTable GetLatLong(int fromCityId, int toCityId)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select lat As FromCitylat,long As FromCitylog from CityMaster where  CityId='" + fromCityId + "'  union Select lat As ToCitylat,long As ToCitylog from CityMaster where CityId='" + toCityId + "'");
            return _dt;
        }
        catch (Exception)
        {
            return null;
        }
    }

    public int SaveStagePlan(int stagePlanId, int classId, int fromCityId, int toCityId)
    {
        int result = 0;
        result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@StagePlanId", stagePlanId),
        new SqlParameter("@ClassId", classId),
        new SqlParameter("@FromCityId", fromCityId),
        new SqlParameter("@ToCityId", toCityId)}, "SP_INSERTUPDATE_STAGEPLAN");
        return result;
    }
    //public int SaveStagePlan(int stagePlanId, int classId, int fromCityId, int toCityId, double FromCitylat1, double FromCitylog1, double FromCitylat2, double FromCitylog2)
    //{
    //    int result = 0;
    //    result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@StagePlanId", stagePlanId),
    //    new SqlParameter("@ClassId", classId),
    //    new SqlParameter("@FromCityId", fromCityId),
    //    new SqlParameter("@ToCityId", toCityId),
    //    new SqlParameter ("@FromCitylat" ,FromCitylat1),
    //    new SqlParameter("@FromCitylog",FromCitylog1),
    //    new SqlParameter("@ToCitylat",FromCitylat2),
    //     new SqlParameter("@ToCitylog",FromCitylog2)
    //    }, "SP_INSERTUPDATE_STAGEPLAN");
    //    return result;
    //}

    public int GetStartCity(int classId)
    {
        int result = 0;
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select SCM.Class, SM.CityId from SchoolClassMaster SCM LEFT JOIN SchoolMaster SM ON SCM.SchoolId=SM.SchoolId where SCM.ClassId="+classId+" ");
            if (_dt.Rows.Count > 0)
            {
                result = Convert.ToInt32(_dt.Rows[0]["CityId"]);
            }
        }
        catch { }

        return result;
    }

    public DataTable GetParticipantsList(int classAdminId, int classId)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[]{new SqlParameter("@ClassAdminId", classAdminId),
        new SqlParameter("@classid", classId)}, "SP_GET_ClassParticipantsList");

        return _dt;
    }

    public DataTable GetStagePlan(int classAdminId, int classId)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[]{new SqlParameter("@ClassAdminId", classAdminId),
        new SqlParameter("@classid", classId)}, "SP_GET_STAGEPLAN");

        return _dt;
    }

    public DataTable GetStudentList(int studentId)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[]{new SqlParameter("@STUDENTID", studentId)}, 
            "SP_GET_STUDENTDETAILS");

        return _dt;
    }

    public DataTable GetTestReport(int cityId, int classId)
    {
        _dt = DataAccessLayer.ReturnDataTable("SELECT QR.StudentId, QR.ClassId, QR.CityId, QR.OutofScore, QR.PassingScore,"+
                "QR.StudentScore, Result=(CASE QR.IsPassed when '1' then 'Pass' else 'Fail' end), "+
                "QR.ResultDate, SM.FirstName+' '+SM.LastName as StudentName, CM.CityName"+
                "FROM QuizResult QR LEFT JOIN StudentMaster SM on QR.StudentId=SM.StudentId"+ 
                "LEFT JOIN CityMaster CM ON QR.CityId=CM.CityId"+
                "WHERE QR.CityId=cityId and QR.ClassId=classId");

        return _dt;
    }

    public DataTable GetStudentUploads(int roleId, int classAdminId, int classId, double speed)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@RoleId", roleId) ,
        new SqlParameter("@StudentId", "0") ,
        new SqlParameter("@ClassAdminId", classAdminId) ,
        new SqlParameter("@ClassId", classId),
        new SqlParameter("@Speed", speed)},
            "SP_GET_STUDENT_UPLOADS");

        return _dt;
    }

    //Waseem:: Delete Students
    public int DeleteStudent(int StudentId, int ClassId, int UserId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@StudentId", StudentId), 
                new SqlParameter("@ClassId", ClassId), 
                new SqlParameter("@UserId", UserId) }, "SP_SET_DELETE_STUDENT");
        }
        catch { }

        return result;
    }
}