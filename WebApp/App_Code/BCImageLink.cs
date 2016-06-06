using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// Summary description for BCImageLink
/// </summary>
public class BCImageLink
{
    DataTable _dt = new DataTable();
    DataSet _ds = new DataSet();
	public BCImageLink()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    #region Properties

    string action;

    public string Action
    {
        get { return action; }
        set { action = value; }
    }
    int imageLinkId;

    public int ImageLinkId
    {
        get { return imageLinkId; }
        set { imageLinkId = value; }
    }

    string imageName;

    public string ImageName
    {
        get { return imageName; }
        set { imageName = value; }
    }

    string imageLink;

    public string ImageLink
    {
        get { return imageLink; }
        set { imageLink = value; }
    }

    string imageText;

    public string ImageText
    {
      get { return imageText; }
      set { imageText = value; }
    }

    

    #endregion

    #region Methods

    public int MaageImageLink(BCImageLink objImageLink)
    {
        int result = 0;
        result = DataAccessLayer.ExecuteStoredProcedure(new SqlParameter[]{new SqlParameter("@ACTION",objImageLink.Action),
             new SqlParameter("@IMAGELINKID",objImageLink.ImageLinkId == null ? 0 : objImageLink.ImageLinkId),
             new SqlParameter("@IMAGENAME",objImageLink.ImageName == null ? "" : objImageLink.ImageName),
             new SqlParameter("@IMAGELINK",objImageLink.ImageLink == null ? "" : objImageLink.ImageLink),
             new SqlParameter("@IMAGETEXT",objImageLink.ImageText == null ? "" : objImageLink.ImageText),
             new SqlParameter("@RESULT",SqlDbType.Int,4,ParameterDirection.Output,false,0,0,"",DataRowVersion.Proposed,result)},
             "SP_INSERT_UPDATE_DELETE_IMAGELINK", "@RESULT");
        return result;
    }

    public BCImageLink GetImageLink(BCImageLink objImageLink)
    {
        _dt = DataAccessLayer.ExecuteStoredProcedureToRetDataTable(new SqlParameter[]{new SqlParameter("@ImageLinkId",objImageLink.ImageLinkId)},
            "SP_GET_IMAGELINK");

        if (_dt != null && _dt.Rows.Count > 0)
        {
            objImageLink.ImageLinkId = Convert.ToInt32(_dt.Rows[0]["ImageLinkId"]);
            objImageLink.ImageName = Convert.ToString(_dt.Rows[0]["ImageName"]);
            objImageLink.ImageLink = Convert.ToString(_dt.Rows[0]["ImageLink"]);            
            objImageLink.ImageText = Convert.ToString(_dt.Rows[0]["ImageText"]);
        }
        return objImageLink;

    }

    public DataTable RotateImageLink()
    {
        _dt = DataAccessLayer.ExecuteStoredProcedure("SP_GET_IMAGELINKDATA");

        return _dt;
    }

    #endregion
}