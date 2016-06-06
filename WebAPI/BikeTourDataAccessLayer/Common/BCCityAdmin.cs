using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
namespace Common
{
    /// <summary>
    /// Summary description for BCCityAdmin
    /// </summary>
    public class BCCityAdmin
    {
        DataTable _dt = new DataTable();
        DataSet _ds = new DataSet();

        public BCCityAdmin()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        int classAdminId;

        public int ClassAdminId
        {
            get { return classAdminId; }
            set { classAdminId = value; }
        }

        int classId;

        public int ClassId
        {
            get { return classId; }
            set { classId = value; }
        }

        int schoolId;

        public int SchoolId
        {
            get { return schoolId; }
            set { schoolId = value; }
        }

        int schoolAdminId;

        public int SchoolAdminId
        {
            get { return schoolAdminId; }
            set { schoolAdminId = value; }
        }

        int cityAdminId;

        public int CityAdminId
        {
            get { return cityAdminId; }
            set { cityAdminId = value; }
        }

        int cityId;

        public int CityId
        {
            get { return cityId; }
            set { cityId = value; }
        }

        string school;

        public string School
        {
            get { return school; }
            set { school = value; }
        }

        #region School Admin   :: Add/Update/Delete
        //public int InsertUpdateSchoolAdmin(DOLUser objUser)
        //{
        //    int result = 0;
        //    try
        //    {

        //        result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@SchoolAdminId", objUser.UserId),
        //        new SqlParameter("@SchoolId", objUser.SchoolId),
        //        new SqlParameter("@FirstName",objUser.FirstName),
        //        new SqlParameter("@LastName",objUser.LastName),
        //        new SqlParameter("@Address",objUser.Address),
        //        new SqlParameter("@Email",objUser.Email),
        //        new SqlParameter("@Password",objUser.Password),
        //        new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERTUPDATE_SCHOOLADMIN", "@RESULT");

        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex;
        //    }

        //    return result;
        //}

        public DataTable GetSchoolAdminData(int schoolAdminId)
        {
            try
            {
                _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@schoolAdminId", schoolAdminId) }
                    , "SP_GET_SCHOOLADMIN");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return _dt;
        }

        public int DeleteSchoolAdmin(int schoolAdminId)
        {
            int result = 0;
            try
            {
                _dt = DataAccessLayer.ReturnDataTable("Select LoginId from SchoolAdminMaster where SchoolAdminId= " + schoolAdminId);
                result = DataAccessLayer.ExecuteNonQuery("delete from SchoolAdminMaster where SchoolAdminId= " + schoolAdminId);
                int res = DataAccessLayer.ExecuteNonQuery("delete from LoginDtls where LoginId=" + Convert.ToInt32(_dt.Rows[0]["LoginID"]) + " ");
            }
            catch (Exception ex)
            {
            }

            return result;
        }

        #endregion

        #region School  :: Add/Update/Delete
        public int InsertUpdateSchool(int schoolId, int cityId, string schoolName, string schoolAddress)
        {
            int result = 0;
            try
            {
                result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@schoolId",schoolId),
            new SqlParameter("@cityId", cityId),
            new SqlParameter("@school",schoolName),
            new SqlParameter("@address",schoolAddress),
            new SqlParameter("@RESULT",SqlDbType.Int, 4, ParameterDirection.Output, false, 0,0,"",DataRowVersion.Proposed,result)}, "SP_INSERTUPDATE_SCHOOLS", "@RESULT");

            }
            catch (Exception ex)
            {
                throw ex;
            }

            return result;
        }

        public DataTable GetSchoolData(int schoolId, int cityAdminId)
        {
            try
            {
                _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@SchoolId", schoolId),
            new SqlParameter("@CityAdminId", cityAdminId),
            new SqlParameter("@CityId", "0"),
            new SqlParameter("@SchoolName", DBNull.Value)}
                    , "SP_GET_SCHOOL");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return _dt;
        }

        public DataTable GetSchoolMasterData(BCCityAdmin objCityAdmin)
        {
            try
            {
                _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] {

            new SqlParameter("@SchoolId", (objCityAdmin.SchoolId == 0 ? 0 : objCityAdmin.SchoolId)),
            new SqlParameter("@CityAdminId", (objCityAdmin.CityAdminId == 0 ? 0 : objCityAdmin.CityAdminId)),
            new SqlParameter("@CityId", (objCityAdmin.CityId == 0 ? 0 : objCityAdmin.CityId)),
            new SqlParameter("@SchoolName", (objCityAdmin.School == null ? " " : objCityAdmin.School))

            }
                    , "SP_GET_SCHOOL");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            return _dt;
        }

        public int DeleteSchool(int schoolId, int userId)
        {
            int result = 0;
            try
            {
                //Waseem:: Commented the below to not to allow any physical delete from the database
                //  result = DataAccessLayer.ExecuteNonQuery("delete from SchoolMaster where schoolId= " + schoolId);

                result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@SchoolId", schoolId),
                new SqlParameter("@UserId",userId)}, "SP_SET_DELETE_SCHOOL");
            }
            catch (Exception ex)
            {
            }

            return result;
        }
        #endregion

        public DataTable GetCity(Int32 UserId)
        {
            try
            {
                _dt = DataAccessLayer.ReturnDataTable("SELECT [CityId], [Cityname] FROM [CityMaster] WHERE ([IsActive] = 1) " +
                    " and CityId=(select CityId from CityAdminMaster where CityAdminId = " + UserId + ")");

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return _dt;
        }

        public DataTable GetClassParticipantsList(BCCityAdmin objCityAdmin)
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@ClassAdminId", objCityAdmin.ClassAdminId),
            new SqlParameter("@classid",objCityAdmin.ClassId) },
                "SP_GET_ClassParticipantsList");

            return _dt;
        }

        public DataTable GetSchoolAdminTable(BCCityAdmin objCityAdmin)
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@SchoolAdminId", objCityAdmin.SchoolAdminId) },
                "SP_GET_SCHOOLADMIN");

            return _dt;
        }

        public DataTable GetSchoolClassMaster(BCCityAdmin objCityAdmin)
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@CityAdminId", objCityAdmin.CityAdminId),
        new SqlParameter("@CityId", objCityAdmin.CityId),new SqlParameter("@School", objCityAdmin.School)},
                "sp_SchoolClassMaster");

            return _dt;
        }

        public DataTable GetSchoolMaster(BCCityAdmin objCityAdmin)
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@SchoolId", objCityAdmin.SchoolId),
            new SqlParameter("@CityAdminId", objCityAdmin.CityAdminId),new SqlParameter("@CityId", objCityAdmin.CityId),
            new SqlParameter("@SchoolName", objCityAdmin.School)},
                "SP_GET_SCHOOL");

            return _dt;
        }

        public DataTable GetTestPlan(BCCityAdmin objCityAdmin)
        {
            _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] {
            new SqlParameter("@CityId", objCityAdmin.CityId),
            new SqlParameter("@ClassId", objCityAdmin.ClassId)},
                "sp_TestReport");

            return _dt;
        }

        #region MyProfile
        public DataTable GetMyProfileInfo(int UserID)
        {
            try
            {
                _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@CityAdminID", UserID) }, "SP_GET_CITYADMINID");

            }
            catch (Exception ex)
            {
                throw ex;
            }

            return _dt;
        }

        public DataSet GetMyProfileContent(int UserID)
        {
            _ds = DataAccessLayer.ExecuteStoredProcedureToRetDataSet(new SqlParameter[] { new SqlParameter("@CityAdminID", UserID) }, "SP_GET_CITYADMINID");
            return _ds;
        }

        #endregion


        //Waseem:: Delete Students
        public int DeleteStudent(int StudentId, int ClassId, int UserId)
        {
            int result = 0;
            try
            {
                result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@StudentId", StudentId),
                new SqlParameter("@ClassId", ClassId), new SqlParameter("@UserId", UserId) }, "SP_SET_DELETE_STUDENT");
            }
            catch { }

            return result;
        }

        #region Set parameters
        public DataTable GetCityContent(int cityId, int schoolId)
        {
            string sqlScript = string.Empty;

            if (cityId > 0)
            {
                sqlScript = "SELECT [CityContentId]" +
              ",[CityId]" +
              ",[CityInfo]" +
              ",[VideoURL]" +
              ",[CityStartDate]" +
              ",[IsAllFileInvalid]" +
          "FROM [dbo].[CityContents]" +
          " WHERE CityId = " + cityId;
            }
            else
            {
                sqlScript = "SELECT [CityContentId]" +
             ",[CityId]" +
             ",[CityInfo]" +
             ",[VideoURL]" +
             ",[CityStartDate]" +
             ",[IsAllFileInvalid]" +
         "FROM [dbo].[CityContents]" +
         " WHERE CityId = ( " +

         " Select CityId FROM SchoolMaster WHERE SchoolId = "
         + schoolId + ")";
            }
            try
            {
                _dt = DataAccessLayer.ReturnDataTable(sqlScript);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return _dt;
        }
        public int UpdateCityContent(string startDate, bool isInvalid, int cityId)
        {
            DateTime temp = Convert.ToDateTime(startDate);

            int result = 0;
            string sqlScript = "UPDATE CityContents SET" +
          " [CityStartDate] = '" + temp.Year + "-" + temp.Month + "-" + temp.Day + " 00:00:00.400'" +
          ",[IsAllFileInvalid] = '" + isInvalid +
            "' WHERE CityId = " + cityId;
            try
            {
                result = DataAccessLayer.ExecuteNonQuery(sqlScript);

            }
            catch (Exception ex)
            {
                throw ex;
            }
            return result;
        }


        #endregion
    }
}