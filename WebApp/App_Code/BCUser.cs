using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BCUser
/// </summary>
/// 
[Serializable()]
public class BCUser
{
    DataTable _dt = new DataTable();
    DataSet _ds = new DataSet();

	public BCUser()
	{
		//
		// TODO: Add constructor logic here
		//
    }

    #region User :: Login/Forgot Password

    public DataTable GetLoginInfo(string email, string password)
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select Loginid from LoginDtls where LoginName='" + email + "' and [Password] = '"
                + password + "' and IsActive=1");
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return _dt;
    }

    public string GetUserName(int LoginId, int RoleId)
    {
        string tblName = "";
        if (RoleId == 1)
        {
            tblName = "";
        }
        else if (RoleId == 2)
        {
            tblName = "CityAdminMaster";
        }
        else if (RoleId == 3)
        {
            tblName = "SchoolAdminMaster";
        }
        else if (RoleId == 4)
        {
            tblName = "ClassAdminMaster";
        }
        else if (RoleId == 5)
        {
            tblName = "StudentMaster";
        }

        string uName = "Administrator";
        try
        {
            if (RoleId == 5)
            {
                _dt = DataAccessLayer.ReturnDataTable("Select FirstName, LastName from " + tblName + " Where LoginId=" + LoginId + " and IsStatusConfirmed=1");
            }
            else
            {
                _dt = DataAccessLayer.ReturnDataTable("Select FirstName, LastName from " + tblName + " Where LoginId=" + LoginId + " and IsActive=1");
            }
            if (_dt.Rows.Count > 0)
            {
                uName = _dt.Rows[0]["FirstName"].ToString() + " " + _dt.Rows[0]["LastName"].ToString();
            }
        }
        catch (Exception ex)
        {
            uName = "Administrator";
        }
        return uName;
    }

    public DataTable GetUserInfo(int loginId)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[]{new SqlParameter("@LoginId", loginId),
        }, "SP_GET_USERINFO");
        return _dt;
    }

    //fUNCTION FOR fORGOT PASSWORD
    public DataTable GetNewPassword(string email)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[] { new SqlParameter("@EMAIL", email) },
        "SP_FORGOTPASSWORD");
        return _dt;
    }

    public int ChangePassword(string newPassword, int UserId)
    {
        int Success = 0;
        Success = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@LOGINID", UserId),
       new SqlParameter("@NEWPASSWORD", newPassword)}, "SP_CHANGEPASSWORD");

        return Success;
    }

    public int UpdateFirstLogin(int loginId, int roleId)
    {
        return DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[] { new SqlParameter("@LoginId", loginId),
        new SqlParameter("@RoleId", roleId)}, "SP_UPDATE_IsFirstLoginFlag");
    }

    #endregion
    #region FORUM BLOG
    public int SaveBlog(int classid, int blogId, int userId, int userRoleId, int createdBy, string blogText, int ShowOnHome)
    {
        return DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@ClassId", classid),
        new SqlParameter("@BlogId", blogId),
        new SqlParameter("@UserId", userId),
        new SqlParameter("@UserRoleId", userRoleId),
        new SqlParameter("@BlogText", blogText),
        new SqlParameter("@CreatedBy", createdBy),
        new SqlParameter("@ShowOnHome", ShowOnHome)}, "SP_INSERTUPDATE_FORUMBLOG");
    }


    public int SaveClassBlog(int classid, int blogId, int userId, int userRoleId, int createdBy, string blogText)
    {
        return DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@ClassId", classid),
        new SqlParameter("@BlogId", blogId),
        new SqlParameter("@UserId", userId),
        new SqlParameter("@UserRoleId", userRoleId),
        new SqlParameter("@BlogText", blogText),
        new SqlParameter("@CreatedBy", createdBy)}, "SP_INSERTUPDATE_CLASSBLOG");
    }
    public int DeleteBlog(int blogId)
    {
        return DataAccessLayer.ExecuteNonQuery("delete from ForumBlog where BlogId = " + blogId);
    }

    //Waseem:: Delete Blog
    public int DeleteBlog(int blogId, int UserId)
    {
        return DataAccessLayer.ExecuteNonQuery("Update ForumBlog set IsActive=0, IsDelete=1, DeleteDate=GetDate(), DeletedBy=" + UserId + " where BlogId=" + blogId);
    }

    public int DeleteAllBlog(int ClassId, int UserId)
    {
        return DataAccessLayer.ExecuteNonQuery("Update ForumBlog set IsActive=0, IsDelete=1, DeleteDate=GetDate(), DeletedBy="+ UserId+" where ClassId= " + ClassId);
    }

    public int UpdateBlog(int blogId, string blogText)
    {
        return DataAccessLayer.ExecuteNonQuery("update ForumBlog set BlogText = '" + blogText + "' where BlogId = " + blogId);
    }

    public DataTable GetClassBlog1()
    {
        return DataAccessLayer.ReturnDataTable("SELECT BlogId,UserId,UserRoleId,ClassId,BlogText,CreatedBy,CreatedOn,IsActive FROM ClassBlog");
    }

    //public DataTable GetClassBlog(int UserID,int Roleid,int Classid )
    //{
    //    return DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[]{
    //        new SqlParameter("@UserId",UserID),
    //        new SqlParameter("@UserRoleId",Roleid),
    //        new SqlParameter("@ClassId",Classid),
    //        new SqlParameter("@Result",SqlDbType.d
    //}

    public DataTable GetAllCities()
    {
        try
        {
            _dt = DataAccessLayer.ReturnDataTable("select CityName, lat as latitude, long as longitude, CityImage, MapText from CityMaster where IsActive=1 and IsParticipatingCity=1");
        }
        catch (Exception ex)
        {
            throw ex;
        }
        return _dt;
    }
    #endregion

}