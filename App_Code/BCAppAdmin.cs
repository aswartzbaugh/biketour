using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BCAppAdmin
/// </summary>
public class BCAppAdmin
{
    DataTable _dt = new DataTable();
    DataSet _ds = new DataSet();

	public BCAppAdmin()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private int _cityId;

    public int CityId
    {
        get { return _cityId; }
        set { _cityId = value; }
    }

    private string _adminName;

    public string AdminName
    {
        get { return _adminName; }
        set { _adminName = value; }
    }

    private string _cityName;

    public string CityName
    {
        get { return _cityName; }
        set { _cityName = value; }
    }

    private bool _isParticipating;

    public bool IsParticipating
    {
        get { return _isParticipating; }
        set { _isParticipating = value; }
    }

    #region School  :: Add/Update/Delete
    public int InsertUpdateSchool(int schoolId, int cityId, string schoolName)
    {
        int result = 0;
        try
        {

            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@schoolId",schoolId),
            new SqlParameter("@cityId", cityId),
            new SqlParameter("@school",schoolName),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERTUPDATE_SCHOOLS", "@RESULT");

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return result;
    }

    public DataTable GetSchoolData(int schoolId)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@SchoolId", schoolId) }
                , "SP_GET_SCHOOL");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public int DeleteSchool(int schoolId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteNonQuery("delete from SchoolMaster where schoolId= " + schoolId);
        }
        catch (Exception ex)
        {
        }

        return result;
    }
    #endregion

    #region Class  :: Add/Update/Delete
    public int InsertUpdateClass(int classId, int schoolId, string className)
    {
        int result = 0;
        try
        {

            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@classid",classId),
            new SqlParameter("@SchoolId", schoolId),
            new SqlParameter("@class",className),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERTUPDATE_class", "@RESULT");

        }
        catch (Exception ex)
        {
            throw ex;
        }

        return result;
    }

    public DataTable GetClassData(int classId)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@ClassId", classId) }
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


    #region Paricipating Cities :: Add/Update/Delete

    public int InsertUpdateParicipatingCities(int CityId, string CityName, string CityNameGerman, string ImageName, bool isPartcipating, double lat, double longt, string MapText)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] {
                new SqlParameter("@CityId",CityId  ),
                new SqlParameter("@City", CityName),
                new SqlParameter("@CityGerman", CityNameGerman),
                new SqlParameter("@CityImage",ImageName),
                new SqlParameter("@Lat", lat),
                new SqlParameter("@Long", longt),
                new SqlParameter("@MapText", MapText),
                new SqlParameter("@isParticipating", isPartcipating),
                new SqlParameter("@result",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_CITIES", "@result");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public DataTable GetCitiesList(int CityId)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select * from CityMaster where IsActive=1 and CityId<>" + CityId + "");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return _dt;
    }

    public int InsertCityDistance(int fromcity, int tocity, int dist)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteNonQuery("insert into citydistancemaster(fromcity, tocity, distance) values(" + fromcity + "," + tocity + "," + dist + ")");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public DataTable GetParticipatingCityInfo(int CityId)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select cityid,Cityname,CityNameGerman,CityImage,lat, long,IsParticipatingCity,MapText From CityMaster where cityid=" + CityId + " ");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return _dt;
    }

    public DataTable HighScore(int CityId)
    {
        try
        {
            //_dt = DataAccessLayer.ReturnDataTable("Select Distinct  Top 3  MAX(round(sp.Distance_Covered,2)) As score ,sp.StagePlanId,scm.Class,sm.School from StagePlan  sp , SchoolClassMaster scm,SchoolMaster sm, CityMaster cm where  sp.ClassId = scm.ClassId  and scm.SchoolId = sm.SchoolId  and sp.ToCityId='" + CityId + "'  and sp.IsActive=1  group by scm.Class,sm.School ,sp.Distance_Covered ,sp.StagePlanId  order by score  Desc"); 
            //SELECT Top 3 rank() OVER(ORDER BY sum(Distance_Covered) DESC) AS [RANK], sp.classid,sp.StagePlanId, classname=(sm.School ), scm.class , round(sum(Distance_Covered),2) as score ,cm.CityName from stageplan sp inner join SchoolClassMaster scm  on sp.ClassId = scm.ClassId inner join SchoolMaster sm on scm.SchoolId = sm.SchoolId  inner join CityMaster cm on cm.CityId=sm.CityId  where sm.CityId='" + CityId + "'  group by sp.classid,scm.class,sm.School ,cm.CityName ,sp.StagePlanId ");
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@CITYID", CityId) }, "SP_GETSCORE_FOR_STARTPAGE");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return _dt;
    }


    public DataTable ClassBlog()
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select fb.BlogId, BlogWrittenBy =(case when FB.UserRoleId=4 then (select (FirstName + ' ' + LastName) from ClassAdminMaster CM where CM.ClassAdminId = fb.UserId)  when FB.UserRoleId=2 then (select (FirstName + ' ' + LastName) from CityAdminMaster CAM where CAM.CityAdminId = FB.UserId) else '' end) , blogtext  from forumblog FB  where  Isactive = 1  order by FB.blogid DESC  ");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return _dt;
    }
    public int DeleteParticipatingCity(int CityId)
    {
        int res =0;
        try
        {
            res = DataAccessLayer.ExecuteNonQuery("Update ParticipatingCityMaster set IsActive=0 where CityId=" + CityId + " ");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return res;
    }

    #endregion

    #region City Admin :: Add/Update/Delete

    public int InsertUpdateCityAdmin(DOLUser objUser)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@CityAdminId", objUser.UserId),
            //new SqlParameter("@CityId", objUser.CityId),
            new SqlParameter("@FirstName",objUser.FirstName),
            new SqlParameter("@LastName",objUser.LastName),
            new SqlParameter("@Address",objUser.Address),
            new SqlParameter("@Email",objUser.Email),
            new SqlParameter("@Password",objUser.Password),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_UPDATE_CITYADMIN", "@RESULT");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public DataTable GetCityAdminInfo(int CityAdminId)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select * from CityAdminMaster where CityAdminId=" + CityAdminId + " ");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public int DeleteCityAdmin(int CityAdminId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@cityAdminId", CityAdminId) }, "SP_DELETE_CityADMIN");
        }
        catch (Exception ex)
        {
        }

        return result;
    }

    public int SaveCityAdminMapping(int CityAdminId, int CityId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { 
            new SqlParameter("@CityAdminId", CityAdminId),
            new SqlParameter("@CityId", CityId),
            new SqlParameter("@result",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_CITYADMIN_MAPPING", "@result");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    public DataTable GetCityAdminMapping(int CityAdminId)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select CityId from CityAdminCities where CityAdminId=" + CityAdminId + " ");
        }
        catch { }
        return _dt;
    }

    public DataTable GetAllAdminDetails(BCAppAdmin objAppAdmin)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] 
            { 
                new SqlParameter("@AdminName", (objAppAdmin.AdminName == null ? " " : objAppAdmin.AdminName )),
                new SqlParameter("@CityId", (objAppAdmin.CityId == 0 ? 0 : objAppAdmin.CityId)) 
            
            }, "SP_GET_ALLCITY_ADMINS");
        }
        catch (Exception ex)
        {
        }

        return _dt;
    }
    public DataTable GetCityList(BCAppAdmin objAppAdmin)
    {
        try
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] 
            { 
                new SqlParameter("@CityName", (objAppAdmin.CityName == null ? " " : objAppAdmin.CityName ))
            }, "SP_GET_CITYLIST");
        }
        catch (Exception ex)
        {
        }

        return _dt;
    }

    public DataTable GetCityListCityMaster(BCAppAdmin objAppAdmin)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select cityid,Cityname,CityImage,IsParticipatingCity = (case IsParticipatingCity when 1 then 'yes' else 'No' end) from  CityMaster where IsActive = 1 and CityName LIKE '%'+(CASE '" + (objAppAdmin.CityName == "" ? "0" : objAppAdmin.CityName) + "' WHEN '0' THEN Cityname ELSE '" + objAppAdmin.CityName + "' END)+'%' and IsParticipatingCity = '" 
                + objAppAdmin.IsParticipating + "' order by Cityname");
        }
        catch { }
        return _dt;
    }

    #endregion

    #region CityContent
    public int DeleteImage(int cityId, string imageName)
    {
        return DataAccessLayer.ExecuteNonQuery("delete from cityimages where CityId=" + cityId + " and imagename='" + imageName + "'");
    }

    public int InsertUpdateCityContents(int cityId, string cityInfo, string videoURL)
    {
        int result = 0;
        result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@CityId", cityId),
        new SqlParameter("@CityInfo", cityInfo),
        new SqlParameter("@VideoURL", videoURL)},
        "SP_INSERTUPDATE_CITYCONTENTS");
        return result;
    }

    public int InsertUpdateImages(int cityId, string imageName, string imagePath, string imageText)
    {
        int result = 0;
        result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@CityId", cityId),
            new SqlParameter("@ImageName", imageName),
        new SqlParameter("@ImagePath", imagePath),
        new SqlParameter("@ImageText", imageText)},
        "SP_INSERTUpdate_CITYIMAGES");
        return result;
    }
    public int DeleteVideocity(int cityId, string videoURL)
    {
        return DataAccessLayer.ExecuteNonQuery("UPDATE CityContents   SET VideoURL = '" + videoURL + "'  WHERE CityId ='" + cityId + "'");
    }

    public DataSet GetCityContents(int cityId)
    {
        _ds = DataAccessLayer.ExecuteStoredProcedureToRetDataSet(new SqlParameter[] { new SqlParameter("@CityId", cityId) }, "SP_GET_CITYCONTENTS");
        return _ds;
    }
    #endregion

    #region
    public int TansferResponsibility(int oldCityAdminId, int newCityAdminId)
    {
        return DataAccessLayer.ExecuteNonQuery("Update CityAdminCities set CityAdminId=" + newCityAdminId + " where CityAdminId=" + oldCityAdminId + " ");
    }
    #endregion

    public int InsertDiscription(string Description)
    {
        return DataAccessLayer.ExecuteNonQuery("Update AboutUs set Description='" + Description + "' where AboutUsId=1");
    }

    public DataTable GetAboutUs()
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select Description from AboutUs Where AboutUsId=1");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return _dt;
    }

    #region Add QuizTest

    public int InsertQuizTest(int QuizId, string QuizName, string QuizFile, int CityId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] {
            new SqlParameter("@QuizId", QuizId),
            new SqlParameter("@QuizName",QuizName),
            new SqlParameter("@QuizFile",QuizFile),
            new SqlParameter("@CityId",CityId),
            new SqlParameter("@result",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_QUIZTEST", "@result");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }

    //Waseem Start :: Added Function to Check and Insert Quiz Test
    public int InsertCheckQuizTest(int QuizId, string QuizName, string QuizFile, int CityId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] {
            new SqlParameter("@QuizId", QuizId),
            new SqlParameter("@QuizName",QuizName),
            new SqlParameter("@QuizFile",QuizFile),
            new SqlParameter("@CityId",CityId),
            new SqlParameter("@result",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERT_CHECK_QUIZTEST", "@result");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return result;
    }
    //Waseem End :: Added Function to Check and Insert Quiz Test

    public int DeleteQuiz(int QuizId)
    {
        int result = 0;
        try
        {
            result = DataAccessLayer.ExecuteNonQuery("Update QuizTests Set IsActive=0 where QuizId= " + QuizId);
        }
        catch (Exception ex)
        {
        }
        return result;
    }

    public DataTable GetQuizTest(int CityId)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("Select * from QuizTests where CityId=" + CityId +" and IsActive=1");
        }
        catch (Exception ex)
        {
        }
        return _dt;
    }

    public DataTable GetAllDetailsQuiz()
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("SELECT QT.QuizId, QT.QuizName, QT.QuizFile, CM.CityName FROM QuizTests QT LEFT OUTER JOIN CityMaster CM ON QT.CityId=CM.CityId WHERE QT.IsActive=1");
        }
        catch (Exception ex)
        {
        }
        return _dt;
    }


    #endregion

}
