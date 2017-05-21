using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Linq;
using System.Xml.Linq;
using System.Text;
using System.Xml;
using System.Data;
using System.IO;
using System.Configuration;

public partial class Student_UploadGpx : System.Web.UI.Page
{
    BCStudent objStudent = new BCStudent();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            try
            {
                if (Session["SchoolId"] != null && Session["ClassId"] != null)   //Application["SchoolId"] != null && Application["ClassId"] != null)
                {
                    ddlSchool.SelectedValue = Session["SchoolId"].ToString();
                    ddlSchool.DataTextField = "School";
                    ddlSchool.DataValueField = "SchoolId";
                    ddlSchool.DataBind();
                    ddlClass.SelectedValue = Session["ClassId"].ToString();
                    ddlClass.DataTextField = "Class";
                    ddlClass.DataValueField = "classid";
                    ddlClass.DataBind();
                    ddlClass_SelectedIndexChanged(sender, e);
                }


                if (Session["UserRoleId"].ToString() == "5")
                {
                    DataTable dt = objStudent.GetSchoolInfo(Convert.ToInt32(Session["UserId"]));
                    if (dt.Rows.Count > 0)
                    {
                        h1_ClassSchool.InnerHtml += "- " + dt.Rows[0]["Class"].ToString() + " " + dt.Rows[0]["School"].ToString();
                    }
                }

                #region Restrict Upload
                //int cityid = 0;
                //int classid = 0;
                //DataTable ds = objStudent.GetCurrentStageByClass(Convert.ToInt32(ddlClass.SelectedValue));
                //int CompleteLegs = 0;
                //if (ds != null && ds.Rows.Count > 0)
                //{
                //    CompleteLegs = objStudent.GetCompleteLegCount(Convert.ToInt32(ds.Rows[0]["ClassId"].ToString()));

                //    if (ds != null && ds.Rows.Count > 0)
                //    {
                //        cityid = Convert.ToInt32(ds.Rows[0]["FromCityId"].ToString());
                //        classid = Convert.ToInt32(ds.Rows[0]["ClassId"].ToString());
                //    }
                //}
                //if (cityid > 0 && classid > 0)
                //{
                //    DataTable dt = objStudent.GetQuizResult(classid, cityid);
                //    if (dt.Rows.Count > 0 || CompleteLegs == 0)
                //    {
                //    }
                //    else
                //    {
                //        btn_Upload.Enabled = false;
                //        btn_Upload.CssClass = "disabled";
                //        lblMessage.Text = "No student have passed test for current leg.<br/>";
                //        lblMessage.Visible = true;
                //    }
                //}
                #endregion

            }
            catch { }
        }
        if (grd_Uploads.Rows.Count > 0)
        {
            btn_SaveGrid.Visible = true;
        }
    }

    int avgSpeedLimit = 0;
    int highSpeedLimit = 0;
    protected void btn_Upload_Click(object sender, EventArgs e)
    {
        if (Convert.ToInt32(ddlSchool.SelectedValue) > 0 && Convert.ToInt32(ddlClass.SelectedValue) > 0)
        {
            BCCityAdmin cityContent = new BCCityAdmin();
            DateTime cityStartDate = new DateTime();
            string FileName = fu_UploadGpx.PostedFile.FileName;
            string NewFile = "";
            string NewFileName = "";
            string FilePath = Server.MapPath("../GPXFiles/" + ddlSchool.SelectedValue.ToString() + "/" + ddlClass.SelectedValue.ToString() + "/0/").ToString();
            string extension = System.IO.Path.GetExtension(FileName).ToLower();

            if ((extension == ".gpx") | (extension == ".GPX"))
            {
                if (IsFileUploaded(FilePath + FileName))
                {
                    string popupScript = "alert('File already uploaded!');";
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                }
                else
                {
                    #region Save file on server for evaluation

                    System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(FilePath);
                    if (!(dir.Exists))
                    {
                        System.IO.Directory.CreateDirectory(FilePath);
                    }
                    fu_UploadGpx.SaveAs(FilePath + FileName.Replace(".gpx", ".xml"));

                    DataTable dt = cityContent.GetCityContent(0, Convert.ToInt32(ddlSchool.SelectedValue));

                    try
                    {
                        string TimeStamp = DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() +
                        DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + ".xml";

                        NewFileName = Session["UserRoleId"].ToString() + "_" + Session["UserId"].ToString() + "_" + TimeStamp + "";
                        File.Move(FilePath + FileName.Replace(".gpx", ".xml"), FilePath + NewFileName); // Try to move
                        NewFile = FilePath + NewFileName;
                    }
                    catch (IOException ex)
                    {
                        NewFile = FilePath + FileName;
                        NewFileName = FileName;
                    }

                    #endregion

                    DataTable dtNew = new DataTable();
                    dtNew = LoadGPXWaypoints(NewFile);
                    DateTime DateOfFile = DateTime.MinValue;
                    try
                    {
                        if (dt != null && dt.Rows.Count > 0 && dtNew != null && dtNew.Rows.Count > 0)
                        {
                            cityStartDate = Convert.ToDateTime(dt.Rows[0]["CityStartDate"]);
                            DateOfFile = Convert.ToDateTime(dtNew.Rows[0]["time"]);
                        }
                        if (cityStartDate != new DateTime() &&
                                DateOfFile <= cityStartDate)
                        {
                            File.Delete(NewFile);
                            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgFileNotForPriorDate") + "');";
                            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                            return;
                        }
                        if (DateOfFile < DateTime.Parse(ConfigurationManager.AppSettings["BatchStartDate"]))
                        {
                            File.Delete(NewFile);
                            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgFileNotForCurrentBatch") + "');";
                            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                            return;
                        }
                    }
                    catch (Exception ex)
                    {
                        string popupScript = "alert('" + (string)GetLocalResourceObject("MsgFileNoHaveTimeStamp") + "');";
                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                        return;
                    }
                    int trackCount = dtNew.Rows.Count;

                    //DataTable dtNewRows = CheckPreviousGPXTrackPoints(Convert.ToInt32(Session["UserId"]), 
                    //    Convert.ToInt32(ddlSchool.SelectedValue), 
                    //    Convert.ToInt32(ddlClass.SelectedValue.ToString()), dtNew);

                    DataTable dtNewRows = CheckPreviousGPXTrackPointsNew
                                            (Convert.ToInt32(Session["UserId"]),
                                            Convert.ToInt32(ddlSchool.SelectedValue),
                                            Convert.ToInt32(ddlClass.SelectedValue.ToString()), dtNew);

                    if (dtNewRows != null &&
                        dtNewRows.Rows.Count > 0)
                    {

                        double distance = CalculateTotalDistance(dtNewRows);
                        double time = CalculateTotalTime(dtNewRows);
                        double timeAvg = CalculateAvgTime(dtNewRows);
                        double highestSpeed = 0;
                        #region Calculate Average Speed
                        if (timeAvg > 0)
                        {
                            time = timeAvg;
                        }

                        double avgSpeed = 0.0;
                        if (time > 0) { avgSpeed = distance / time; }
                        #endregion
                        
                        if (avgSpeed == 0)
                        {
                            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgAvgSpeedIsLow") + "');";
                            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                            File.Delete(NewFile);
                        }
                        else
                        {
                            highestSpeed = GetHighestSpeedInGPX(dtNewRows);
                            
                            string avgMsg = IsAvgSpeedExceed(avgSpeed, out avgSpeedLimit);
                            if (!string.IsNullOrEmpty(avgMsg))
                            {
                                ClientScript.RegisterStartupScript(Page.GetType(), "script", avgMsg, true);
                                return;
                            }
                            string highMsg = IsHighSpeedExceed(highestSpeed, out highSpeedLimit);
                            if (!string.IsNullOrEmpty(highMsg))
                            {
                                ClientScript.RegisterStartupScript(Page.GetType(), "script", highMsg, true);
                                return;
                            }

                            #region Check ongoing stage information

                            int stagePlanId = 0;
                            double stageDistance = 0;
                            double distCovered = 0;
                            DataSet _dtStage = objStudent.GetCurrentStageInfo(Convert.ToInt32(Session["UserId"]), Convert.ToInt32(Session["UserRoleId"]), Convert.ToInt32(ddlClass.SelectedValue));
                            if (_dtStage.Tables[0].Rows.Count > 0)
                            {
                                stagePlanId = Convert.ToInt32(_dtStage.Tables[0].Rows[0]["StagePlanId"]);
                                stageDistance = Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance"]);
                                distCovered = double.Parse(_dtStage.Tables[0].Rows[0]["Distance_Covered"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                //Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance_Covered"]);
                            }
                            else
                            {
                                string popupScript = "alert('No active stage plan!');";
                                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                                return;
                            }
                            #endregion

                            if (avgSpeed > avgSpeedLimit)
                            {
                                string popupScript = "alert('Speed Limit Crossed!');";//Speed Limit Crossed!
                                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                            }
                            else
                            {
                                //Save data in Student Uploads
                                #region Save data in Student Uploads
                                if (stagePlanId != 0)
                                {
                                    int res = objStudent.StudentsUpload(0, 0, stagePlanId, stageDistance, distCovered, (NewFile), NewFileName, DateTime.Now, distance, time, Convert.ToInt32(ddlClass.SelectedValue), 1, trackCount);
                                    if (res > 0)
                                    {
                                        string popupScript = "alert('File uploaded successfully!');";
                                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                                    }
                                    else
                                    {
                                        string popupScript = "alert('" + (string)GetLocalResourceObject("MsgUploadException") + "');";
                                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                                        File.Delete(NewFile);
                                    }
                                    grd_Uploads.DataBind();
                                }
                                else
                                {
                                    string popupScript = "alert('No active stage plan!');";
                                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                                }
                                #endregion
                            }
                        }
                    }
                    else
                    {

                        string popupScript = "alert('File already uploaded!');";//File already uploaded!
                        ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                    }
                }
            }
            else
            {
                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgSelectGPX") + "');";//Select GPX file!                
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }
        }

        else
        {
            string popupScript = "alert('Please select School and Class!');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
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

    private string IsAvgSpeedExceed(double avgSpeed, out Int32 avgSpeedLimit)
    {
        int AvgSpeedLimit = 0;
        avgSpeedLimit = 0;
        string validationMessage = string.Empty;

        if (ConfigurationManager.AppSettings["AvgSpeedLimit"].ToString() != "")
        {
            AvgSpeedLimit = Convert.ToInt32(ConfigurationManager.AppSettings["AvgSpeedLimit"]);
            avgSpeedLimit = AvgSpeedLimit;
        }

        if (avgSpeed > AvgSpeedLimit)
        {
            validationMessage = "alert('" + (string)GetLocalResourceObject("MsgAvgSpeedExceed") + "');";
        }

        return validationMessage;
    }

    private string IsHighSpeedExceed(double highSpeed, out int highSpeedLimit)
    {
        int HighSpeedLimit = 0;
        highSpeedLimit = 0;
        string validationMessage = string.Empty;

        if (ConfigurationManager.AppSettings["HighSpeedLimit"].ToString() != "")
        {
            HighSpeedLimit = Convert.ToInt32(ConfigurationManager.AppSettings["HighSpeedLimit"]);
            highSpeedLimit = HighSpeedLimit;
        }

        if (highSpeed > HighSpeedLimit)
        {
            validationMessage = "alert('" + (string)GetLocalResourceObject("MsgHighSpeedExceed") + "');";
        }
        return validationMessage;
    }

    public DataTable CheckPreviousGPXTrackPoints(int UserId, int SchoolId, int ClassId, DataTable dtNew)
    {
        DataTable result = new DataTable();
        int similarrows = 0;
        DataTable dtPrv = objStudent.GetGpxTractPoints(0, Convert.ToInt32(Session["UserRoleId"]),Convert.ToInt32(ddlClass.SelectedValue));
        if (dtPrv.Rows.Count > 0)
        {
            for (int i = 0; i < dtPrv.Rows.Count; i++)
            {
                DataRow[] _dr;
                _dr = dtNew.Select("Lat='" + dtPrv.Rows[i]["lat"].ToString() + "' AND Lon='" + dtPrv.Rows[i]["lon"].ToString() + "' AND Time='" + dtPrv.Rows[i]["TrackTime"].ToString() + "'");
                if (_dr.Length != 0)
                {
                    int oldRows = 0;
                    if (dtPrv.Rows[i]["TrackPointCount"] != "")
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
                            _drNew = dtNew.Select("Lat='" + dtPrv.Rows[j]["lat"].ToString() + "' AND Lon='" + dtPrv.Rows[j]["lon"].ToString() + "' AND Time='" + dtPrv.Rows[j]["TrackTime"].ToString() + "'");
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

    public DataTable CheckPreviousGPXTrackPointsNew(int UserId, int SchoolId, int ClassId, DataTable dtNew)
    {
        DataTable _dt = null;
        foreach (DataRow item in dtNew.Rows)
        {
            int ele = 0;
            ele = int.Parse(Convert.ToString(item["ele"]), System.Globalization.CultureInfo.InvariantCulture);
            item["ele"] = ele;
        }

        DataTable result = objStudent.CheckGPXFileTable(dtNew, ClassId, UserId);
        if (result != null)
        {
            DataView dv = result.DefaultView;
            dv.Sort = "time asc";
            _dt = dv.ToTable();
        }
        return _dt;
    }

    public DataTable CheckPreviousGPX(int UserId, int SchoolId, int ClassId, DataTable dtNew)
    {
        // Check if the same file is previously uploaded
        // and if there are updated trackpoints in file

        DataTable result = new DataTable();
        DataTable dtPrv = objStudent.GetPreviousUploadedFile(UserId, Convert.ToInt32(Session["UserRoleId"]));
        if (dtPrv.Rows.Count > 0)
        {
            for (int i = 0; i < dtPrv.Rows.Count; i++)
            {
                string FilePath = Server.MapPath("../GPXFiles/" + SchoolId.ToString() + "/" + ClassId.ToString() + "/" + UserId.ToString() + "/" + dtPrv.Rows[i]["FileName"].ToString()).ToString();
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

    public int UpdateStagePlan(int StagePlanId, int ClassId)
    {

        return 0;
    }

    public DataTable LoadGPXWaypoints(string sFile)
    {        
        DataSet _ds = new DataSet("MyDataSet");
        _ds.ReadXml(sFile);

        DataView dv = _ds.Tables["trkpt"].DefaultView;
        dv.Sort = "time asc";
        DataTable _dt = dv.ToTable();

        return _dt;
    }

    protected void btn_SaveGrid_Click(object sender, EventArgs e)
    {
        try
        {
            if (grd_Uploads.Rows.Count > 0)
            {
                foreach (GridViewRow rw in grd_Uploads.Rows)
                {
                    CheckBox chkApproved = rw.FindControl("chk_Approved") as CheckBox;
                    Label lblUploadId = rw.FindControl("lbl_UploadId") as Label;
                    int approved = Convert.ToInt32(chkApproved.Checked);
                    int res = objStudent.SaveUploadedFileStatus(Convert.ToInt32(lblUploadId.Text), approved);
                }
                grd_Uploads.DataBind();
                string popupScript = "alert('Records updated successfully!');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }
            else
            {
                string popupScript = "alert('No records to update.');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }
        }
        catch { }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlClass.SelectedIndex != 0)
        {
            Session["SchoolId"] = ddlSchool.SelectedValue;
            Session["ClassId"] = ddlClass.SelectedValue;
        }
        if (grd_Uploads.Rows.Count > 0)
        {
            btn_SaveGrid.Visible = true;
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Forum.aspx");
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

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        grd_Uploads.DataBind();
    }

    protected void btnClearSearch_Click(object sender, EventArgs e)
    {
        txtSearchSpeed.Text = "";
        grd_Uploads.DataBind();
    }


    protected void btnApprove_Click(object sender, EventArgs e)
    {
        string cmd = (sender as ImageButton).CommandArgument;
        int res = objStudent.SaveUploadedFileStatus(Convert.ToInt32(cmd), 1);

        if (res > 0)
        {
            grd_Uploads.DataBind();
            string popupScript = "alert('" + (string)GetLocalResourceObject("FileApproved") + "');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
    }

    protected void btnReject_Click(object sender, EventArgs e)
    {
        string cmd = (sender as ImageButton).CommandArgument;
        int res = objStudent.SaveUploadedFileStatus(Convert.ToInt32(cmd), 0);

        if (res > 0)
        {
            grd_Uploads.DataBind();
            string popupScript = "alert('" + (string)GetLocalResourceObject("FileRejected") + "');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
    }

    public bool GetBtnsVisibility(object IsValid)
    {
        if (IsValid.ToString() == "")
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public bool GetApprovalStatusVisibility(object IsValid)
    {
        if (IsValid.ToString() == "")
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    public string GetApproveStatusText(object ApproveText)
    {
        if (ApproveText.ToString().ToLower() == "approved")
        {
            return (string)GetLocalResourceObject("Approved");
        }
        else if (ApproveText.ToString().ToLower() == "rejected")
        {
            return (string)GetLocalResourceObject("Rejected");
        }
        else
        {
            return "";
        }
    }
    protected void btnAddKms_Click(object sender, EventArgs e)
    {
        #region Check ongoing stage information

        int stagePlanId = 0;
        double stageDistance = 0;
        double distCovered = 0;
        DataSet _dtStage = objStudent.GetCurrentStageInfo(Convert.ToInt32(Session["UserId"]), Convert.ToInt32(Session["UserRoleId"]), Convert.ToInt32(ddlClass.SelectedValue));
        if (_dtStage.Tables[0].Rows.Count > 0)
        {
            stagePlanId = Convert.ToInt32(_dtStage.Tables[0].Rows[0]["StagePlanId"]);
            stageDistance = Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance"]);
            distCovered = double.Parse(_dtStage.Tables[0].Rows[0]["Distance_Covered"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
            //Convert.ToDouble(_dtStage.Tables[0].Rows[0]["Distance_Covered"]);
        }
        
        #endregion

        //Save data in Student Uploads
        #region Save data in Student Uploads
        if (stagePlanId != 0)
        {
            int res = objStudent.StudentsUpload(0, 0, stagePlanId, stageDistance, distCovered, null, null, DateTime.Now, double.Parse(txtKmsDriven.Text, System.Globalization.CultureInfo.InvariantCulture), 1, Convert.ToInt32(ddlClass.SelectedValue), 0, 0,true);
            if (res > 0)
            {
                string popupScript = "alert('Distance updated successfully! Please wait for approval!');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }
            else
            {
                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgUploadException") + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }
            grd_Uploads.DataBind();
        }
        else
        {
            string popupScript = "alert('No active stage plan!');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
        #endregion
    }
}