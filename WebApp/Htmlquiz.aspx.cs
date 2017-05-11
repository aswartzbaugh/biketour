using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;
using AjaxControlToolkit;

public partial class quiz : System.Web.UI.Page
{
    BCStudent objStudent = new BCStudent();

    protected void Page_Load(object sender, EventArgs e)
    {


        if (Request.QueryString["pscore"] != null && Request.QueryString["pointsawarded"] != null && Request.QueryString["totalScore"] != null)
        {
            int userid = 0;
            int pass = 0;
            int cityid = 0;
            int classid = 0;

            if (Session["StartCity"] != null)
            {
                cityid = Convert.ToInt32(Session["StartCity"]);
            }
            if (Session["CurrentClass"] != null)
            {
                classid = Convert.ToInt32(Session["CurrentClass"]);
            }

            DataSet ds = objStudent.GetCurrentStageInfo(Convert.ToInt32(Session["UserId"].ToString()), Convert.ToInt32(Session["UserRoleId"].ToString()), 0);

            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                {
                    cityid = Convert.ToInt32(ds.Tables[0].Rows[0]["StartCityId"].ToString());
                    classid = Convert.ToInt32(ds.Tables[0].Rows[0]["ClassId"].ToString());
                }
            }

            try
            {
                double passingscore = Convert.ToDouble(Request.QueryString["pscore"]);
                double outofscore = Convert.ToDouble(Request.QueryString["totalScore"]);
                double studentscore = Convert.ToDouble(Request.QueryString["pointsawarded"]);
                if (studentscore >= passingscore)
                {
                    Session["result"] = "pass";
                    pass = 1;

                }
                else
                {
                    Session["result"] = "fail";
                }

                if (Session["UserId"] != null)
                {
                    userid = Convert.ToInt32(Session["UserId"]);
                }

                try
                {
                    StreamWriter tw = new StreamWriter(Server.MapPath("TestQuiz/result.txt"), true);
                    tw.WriteLine(" Passing: " + passingscore.ToString());
                    tw.WriteLine(" Outof: " + outofscore.ToString());
                    tw.WriteLine(" Score: " + studentscore.ToString());
                    tw.WriteLine(" User: " + userid.ToString());
                    tw.WriteLine(" City: " + cityid.ToString());
                    tw.Close();
                }
                catch { }

                if (userid != 0)
                {

                    int res = objStudent.InsertQuizResult(0, userid, classid, cityid, outofscore, passingscore, studentscore, pass);
                    DataTable dt = objStudent.GetQuizResult(classid, cityid);
                    dt.DefaultView.RowFilter = " IsPassed =1";
                    int isPassed = dt.DefaultView.Count;
                    dt.DefaultView.RowFilter = string.Empty;
                    if (res > 0 && (isPassed == 1 || dt.Rows.Count > 5))
                    {
                        //Deleteting appeared test files from respective folder
                        try
                        {
                            string directoryPath = Server.MapPath("QuizTests/HtmlQuiz1").ToString();
                            string[] filePaths = Directory.GetFiles(directoryPath);
                            foreach (string filePath in filePaths)
                                File.Delete(filePath);
                            string[] dirPaths = Directory.GetDirectories(directoryPath);
                            if (dirPaths != null)
                            {
                                foreach (string dirPath in dirPaths)
                                {
                                    filePaths = Directory.GetFiles(dirPath);
                                    foreach (string filePath in filePaths)
                                    {
                                        File.Delete(filePath);
                                    }
                                    Directory.Delete(dirPath);
                                }
                            }
                        }
                        catch(Exception ex)
                        { }

                        int NextLegId = 0;
                        double RemainingDist = 0;
                        DataTable dtLastComplete = objStudent.GetLastCompleteLeg(classid);
                        DataTable dtNextLeg = objStudent.GetNextStageLeg(classid);
                        if (dtLastComplete.Rows.Count > 0)
                        {
                            int LastLegId = Convert.ToInt32(dtLastComplete.Rows[0]["StagePlanId"]);
                            double ExtraDistance = Convert.ToDouble(dtLastComplete.Rows[0]["Distance_Extra"]);

                            if (dtNextLeg.Rows.Count > 0)
                            {
                                NextLegId = Convert.ToInt32(dtNextLeg.Rows[0]["StagePlanId"]);
                                double DistanceToCover = Convert.ToDouble(dtNextLeg.Rows[0]["Distance"]);
                                if (ExtraDistance > DistanceToCover)
                                {
                                    RemainingDist = ExtraDistance - DistanceToCover;
                                    ExtraDistance = DistanceToCover;
                                }

                                int result = objStudent.StartNextLeg(ExtraDistance, RemainingDist, NextLegId);
                                if (result > 0)
                                {
                                    int result2 = objStudent.ClearExtraLegDistance(LastLegId);
                                }
                            }
                        }
                    }
                }

                //Response.Redirect("~/Student/StudentForm.aspx");
            }
            catch (Exception ex)
            {
                Helper.Log(ex.Message.ToString(), "Error in Saving test result");
                // Response.Redirect("~/Student/HtmlForum.aspx");
            }
        }
        else
        {
            Helper.Log("Null values from php page ", "Invalid values from php page");
            //  Response.Redirect("~/Student/HtmlForum.aspx");
        }
    }
    protected void form1_Load(object sender, EventArgs e)
    {

    }
}