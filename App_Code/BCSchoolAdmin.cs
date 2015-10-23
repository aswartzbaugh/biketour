using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BCSchoolAdmin
/// </summary>
public class BCSchoolAdmin
{
    DataTable _dt = new DataTable();
    DataSet _ds = new DataSet();

    private int _classAdminId;

    public int ClassAdminId
    {
        get { return _classAdminId; }
        set { _classAdminId = value; }
    }
    private string _adminName;

    public string AdminName
    {
        get { return _adminName; }
        set { _adminName = value; }
    }
    private int _schoolId;

    public int SchoolId
    {
        get { return _schoolId; }
        set { _schoolId = value; }
    }
    private int _cityAdminId;

    public int CityAdminId
    {
        get { return _cityAdminId; }
        set { _cityAdminId = value; }
    }

    private string _schoolName;

    public string SchoolName
    {
        get { return _schoolName; }
        set { _schoolName = value; }
    }
    private int _cityName;

    public int CityName
    {
        get { return _cityName; }
        set { _cityName = value; }
    }

	public BCSchoolAdmin()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Class  :: Add/Update/Delete
    public int InsertUpdateClass(int classId, int schoolId, string className, string ClassYear)
    {
        int result = 0;
        try
        {

            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@classid",classId),
            new SqlParameter("@SchoolId", schoolId),
            new SqlParameter("@class",className),
            new SqlParameter("@ClassYear",ClassYear),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERTUPDATE_class", "@RESULT");

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return result;
    }

    public DataTable GetClassInfo(int classid){
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select SM.School, SM.SchoolId, SCM.Class, SCM.ClassYear, SCM.ClassId, SM.CityId from SchoolClassMaster SCM inner join SchoolMaster SM on SCM.SchoolId = SM.SchoolId where sCm.IsActive = 1  and SCM.ClassId=" + classid + " ");
        }
        catch { }
        return _dt;
    }

    public DataTable GetClassData(int classId, int cityAdminId, int schoolId)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@ClassId", classId),
            new SqlParameter("@CityAdminId", cityAdminId),
            new SqlParameter("@SchoolId", schoolId)}
                , "SP_GET_SCHOOLClass");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public int DeleteClass(int ClassId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteNonQuery("delete from SchoolclassMaster where classId= " + ClassId);
        }
        catch (Exception ex)
        {
        }

        return result;
    }

   
    #endregion

    #region Class Admin   :: Add/Update/Delete
    public int InsertUpdateClassAdmin(DOLUser objUser)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@ClassAdminId", objUser.UserId),
            new SqlParameter("@FirstName",objUser.FirstName),
            new SqlParameter("@LastName",objUser.LastName),
            new SqlParameter("@Address",objUser.Address),
            new SqlParameter("@Email",objUser.Email),
            new SqlParameter("@Password",objUser.Password),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_UPDATE_CLASSADMIN", "@RESULT");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return result;
    }

    public DataSet GetClassAdminInfo(int ClassAdminId, int CityAdminId)
    {
        try
        {
            _ds = DataAccessLayer.ExecuteStoredProcedureToRetDataSet(new SqlParameter[] { 
                new SqlParameter("@ClassAdminId", ClassAdminId), 
                new SqlParameter("@AdminName", DBNull.Value), 
                new SqlParameter("@SchoolId", "0"),
                new SqlParameter("@CityAdminId", CityAdminId),
            }, "SP_GETCLASSADMINS");
            return _ds;
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _ds;
    }

    public DataSet GetClassAdminInfoWithClasses(int ClassAdminId)
    {
        try
        {
            _ds = DataAccessLayer.ExecuteStoredProcedureToRetDataSet(new SqlParameter[] { 
                new SqlParameter("@ClassAdminId", ClassAdminId), 
            }, "SP_GET_CLASSADMIN_WITHCLASSES");
            return _ds;
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _ds;
    }

    public DataTable GetClassAdminList(BCSchoolAdmin objSchoolAdmin)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { 
                new SqlParameter("@ClassAdminId", (objSchoolAdmin.ClassAdminId == 0 ? 0 : objSchoolAdmin.ClassAdminId)), 
                new SqlParameter("@AdminName", (objSchoolAdmin.AdminName == "" ? " " : objSchoolAdmin.AdminName)), 
                new SqlParameter("@SchoolId", (objSchoolAdmin.SchoolId == 0 ? 0 : objSchoolAdmin.SchoolId)),
                new SqlParameter("@CityAdminId", (objSchoolAdmin.CityAdminId == 0 ? 0 : objSchoolAdmin.CityAdminId)),
            }, "SP_GETCLASSADMINS");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public DataTable GetSchoolClassMasterDetails(BCSchoolAdmin objSchoolAdmin)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select SM.School,SM.SchoolId, CM.CityName,SCM.Class,SCM.ClassYear, SCM.ClassId from SchoolClassMaster SCM inner join SchoolMaster SM on SCM.SchoolId = SM.SchoolId left join CityMaster CM on SM.CityId=CM.CityId where sCm.IsActive = 1 and SM.CityId=(case '"+ (objSchoolAdmin.CityName == 0 ? 0 : objSchoolAdmin.CityName) +"' when 0 then SM.CityId else '"+ objSchoolAdmin.CityName +"' end) and SM.School like (CASE '"+ (objSchoolAdmin.SchoolName == "" ? "0" : objSchoolAdmin.SchoolName) +"' WHEN ' ' THEN SM.School ELSE '"+ objSchoolAdmin.SchoolName +"' END)+'%' order by School Asc ");
        }
        catch { }
        return _dt;
    }

    public int DeleteClassAdmin(int ClassAdminId)
    {
        int result = 0;
        try
        {
           result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] {new SqlParameter("@classAdminId", ClassAdminId) }, "SP_DELETE_CLASSADMIN");
        }
        catch (Exception ex)
        {
        }

        return result;
    }

    public int DeleteSchoolOfClassAdmin(int classAdminId, int schoolId)
    {
        return DataAccessLayer.ExecuteNonQuery("delete from ClassAdminClasses where SchoolId=" + schoolId + " and ClassAdminId = " + classAdminId);
    }

    public int DeleteAllSchoolsOfClassAdmin(int classAdminId)
    {
        return DataAccessLayer.ExecuteNonQuery("delete from ClassAdminClasses where ClassAdminId = " + classAdminId);
    }

    public int SaveClassAdminMapping(int classAdminId, int schoolId, string classIdList)
    {
        return DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@CLASSADMINID", classAdminId),
        new SqlParameter("@SCHOOLID", schoolId),
        new SqlParameter("@CLASSIDLIST", classIdList)
        }, "SP_INSERT_CLASSADMINMAPPING");
    }

    #endregion

    public DataTable GetSchool()
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("SELECT [SchoolId], [School] FROM [SchoolMaster] WHERE ([IsActive] = 1) and  " + 
                "SchoolId =(select SchoolId from SchoolAdminMaster where SchoolAdminId = " + HttpContext.Current.Session["UserId"] + ")");

        }
        catch (Exception ex)
        {
            throw ex;
        }
        return _dt;
    }

    public int TansferResponsibility(int oldClassAdminId, int newClassAdminId)
    {
        return DataAccessLayer.ExecuteNonQuery("Update ClassAdminClasses set ClassAdminId=" + newClassAdminId + " where ClassAdminId=" + oldClassAdminId + " ");
    }

    public int DeleteClassAdminClasses(int classAdminId, int schoolId, int MappingId)
    {
        return DataAccessLayer.ExecuteNonQuery("delete from ClassAdminClasses where SchoolId=" + schoolId + " and ClassAdminId = " + classAdminId + " and MappingId=" + MappingId + "");
    }
}