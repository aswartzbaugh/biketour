using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Net;
using System.Data;
using System.Xml.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Web.Services;

public partial class Student_Forum : System.Web.UI.Page
{
    BCUser objUser = new BCUser();
    BCStudent objStudent = new BCStudent();
    BCAppAdmin objAdmin = new BCAppAdmin();
    GooglePoint GP2 = new GooglePoint();
    BCAppAdmin bcadmin = new BCAppAdmin();
    string ServiceUri, ServiceUri2;
    decimal totalDistance = 0;
    decimal totalDistanceCovered = 0;
    protected void Page_Load(object sender, EventArgs e)
    {

       

        Session["LoginId"] = "245";
        Session["UserId"] = "226";
        Session["UserRole"] = "Student";
        Session["UserRoleId"] = "5";
        Session["UserEmail"] = "";
        Session["UserName"] = "Aaron Plum";
        Session["UserCityId"] = "12";
        div_QuizTest.Visible = false;
        lt_Quiz.Text = "";

        

        if (Session["result"] != null)
        {
            if (Session["result"].ToString() == "pass")
            {
                lbl_TestResult.Text = "Congratulations! Your class have passed the test!";
                lbl_TestResult.Visible = true;
                div_Congrats.Visible = false;

                div_NextStage.Visible = false;
              
            }
        }
        else
        {
            div_NextStage.Visible = true;
           
        }
        if (Session["UserId"] == null)
        {
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());
        }
        else
        {
            DataTable _dt = new DataTable();
            int UserId = Convert.ToInt32(Session["UserId"]);
            _dt = objStudent.GetMyProfileInfo(UserId);
            HdnClassId.Value = Convert.ToString(_dt.Rows[0]["ClassId"]);
            HdnstudId.Value = UserId.ToString();//Convert.ToString(_dt.Rows[0]["StudentId"]);
            
            SqlParameter param = new SqlParameter();

            
        }

        if (!IsPostBack)
        {
            try
            {
                //if (Session["UserRoleId"].ToString() == "5")
                //{
                //    DataTable dt = objStudent.GetSchoolInfo(Convert.ToInt32(Session["UserId"]));
                //    if (dt.Rows.Count > 0)
                //    {
                //        h1_ClassForum.InnerHtml += "- " + dt.Rows[0]["Class"].ToString() + " " + dt.Rows[0]["School"].ToString();
                //    }
                //}


                ddlCompetitionCity.DataBind();
                ddlCompetitionCity.SelectedValue = Session["UserCityId"].ToString();
                GetData(ddlCompetitionCity.SelectedValue.ToString());

                _BindData();


                ScriptManager.RegisterStartupScript(Page, this.GetType(), "Temp", "ScrollPosition();", true);
              //  lbtnAllScore.Visible = false;
               
            }
            catch (Exception ex)
            {
            }

        }
    }

   

   

    private void _BindData()
    {
        try
        {
            double percentage = 0.0;

            DataTable dsStud = objStudent.GetStudentInfo(Convert.ToInt32(Session["UserId"]));
            int classId = Convert.ToInt32(dsStud.Rows[0]["ClassId"].ToString());
            int CompleteLegs = objStudent.GetCompleteLegCount(classId);

            DataTable dsPrevStage = objStudent.GetLastCompleteLeg(classId);
            int showOld = 0;
            DataSet ds = objStudent.GetCurrentStageInfo(Convert.ToInt32(Session["UserId"].ToString()), Convert.ToInt32(Session["UserRoleId"].ToString()),classId);
            if ((ds != null && ds.Tables[0].Rows.Count > 0) || (CompleteLegs > 0))
            {
                divForumBlog.Style.Add("Width", "700px");
                DataTable dtm = new DataTable();
                dtm = objStudent.GetVisitedCity(classId.ToString());
                if (dtm.Rows.Count > 0)
                {
                    ddlcity.DataSource = dtm;
                    ddlcity.DataTextField = "CityName";
                    ddlcity.DataValueField = "CityId";
                    ddlcity.DataBind();
                    ddlcity.Items.Insert(0,new ListItem(" Stadt", "0"));
                }
                else
                {
                    ddlcity.Items.Add(new ListItem(" Stadt", "0"));
                }
                if (dtm.Rows.Count > 0)
                {
                    ddlcity.SelectedValue = dtm.Rows[dtm.Rows.Count-1]["CityId"].ToString();
                }

                lblCongratulations1.Visible = false;
                lblCongratulations3.Visible = false;

                if ((ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0))
                {
                    //lblCurrentStage.Text = (string)GetLocalResourceObject("CurrentStage") + "<br/>" + ds.Tables[0].Rows[0]["StartCity"].ToString() +
                    //    " => " + ds.Tables[0].Rows[0]["EndCity"].ToString();
                    hdn_StartCity.Value = ds.Tables[0].Rows[0]["StartCityId"].ToString();
                    hdn_EndCity.Value = ds.Tables[0].Rows[0]["EndCityId"].ToString();
                   // QuizTest(Convert.ToInt32(hdn_StartCity.Value));
                    string FromCity = "../CityImages/" + ds.Tables[0].Rows[0]["FromCityimage"].ToString();
                    string ToCity = "../CityImages/" + ds.Tables[0].Rows[0]["ToCityimage"].ToString();

                    if (ds.Tables[0].Rows[0]["FromCityimage"].ToString() != "")
                    {
                        imgFromCity.ImageUrl = FromCity;
                    }
                    else
                    {
                        imgFromCity.ImageUrl = "../CityImages/noImageBig.png";
                    }

                    imgFromCity.ToolTip = ds.Tables[0].Rows[0]["StartCity"].ToString();

                    if (ds.Tables[0].Rows[0]["ToCityimage"].ToString() != "")
                    {
                        imgToCity.ImageUrl = ToCity;
                    }
                    else
                    {
                        imgToCity.ImageUrl = "../CityImages/noImageBig.png";
                    }

                    imgToCity.ToolTip = ds.Tables[0].Rows[0]["EndCity"].ToString();

                    if (hdn_StartCity.Value.ToString() != "0" || CompleteLegs == 0)
                    {

                     //   QuizTest(Convert.ToInt32(hdn_StartCity.Value));
                        
                        Session["StartCity"] = hdn_StartCity.Value.ToString();
                        Session["CurrentClass"] = classId.ToString();
                        DataTable dt = objStudent.GetQuizResult(classId, Convert.ToInt32(hdn_StartCity.Value));
                        dt.DefaultView.RowFilter = " IsPassed =1";
                        int isPassed = dt.DefaultView.Count;
                        dt.DefaultView.RowFilter = string.Empty;
                        if ((isPassed == 1 || dt.Rows.Count > 5) || CompleteLegs == 0)
                        {
                            if (objStudent.GetNextStageFiles(classId) == 0 && CompleteLegs != 0)
                            {
                                lbl_TestResult.Text = (string)GetLocalResourceObject("PassedTest") + "<br/>" + (string)GetLocalResourceObject("ContinueToNextStage") + "<br/>";
                                lbl_TestResult.Visible = true;
                                div_Congrats.Visible = false;
                            }
                        }
                        else
                        {
                            #region Change : Show Old Leg till Quiz passed
                            try
                            {
                                showOld = 1;
                                if (dsPrevStage.Rows.Count > 0)
                                {
                                    lblCurrentStage.Text = (string)GetLocalResourceObject("CurrentStage") + "<br/>" + dsPrevStage.Rows[0]["StartCity"].ToString() +
                                        " => " + dsPrevStage.Rows[0]["EndCity"].ToString();
                                    hdn_StartCity.Value = dsPrevStage.Rows[0]["FromCityId"].ToString();
                                    hdn_EndCity.Value = dsPrevStage.Rows[0]["ToCityId"].ToString();

                                    FromCity = "../CityImages/" + dsPrevStage.Rows[0]["FromCityimage"].ToString();
                                    ToCity = "../CityImages/" + dsPrevStage.Rows[0]["ToCityimage"].ToString();

                                    if (dsPrevStage.Rows[0]["FromCityimage"].ToString() != "")
                                    {
                                        imgFromCity.ImageUrl = FromCity;
                                    }
                                    else
                                    {
                                        imgFromCity.ImageUrl = "../CityImages/noImageBig.png";
                                    }

                                    imgFromCity.ToolTip = dsPrevStage.Rows[0]["StartCity"].ToString();

                                    if (dsPrevStage.Rows[0]["ToCityimage"].ToString() != "")
                                    {
                                        imgToCity.ImageUrl = ToCity;
                                    }
                                    else
                                    {
                                        imgToCity.ImageUrl = "../CityImages/noImageBig.png";
                                    }

                                    imgToCity.ToolTip = dsPrevStage.Rows[0]["EndCity"].ToString();
                                }
                            }
                            catch { showOld = 0; }
                            #endregion

                            div_NextStage.Visible = true;
                            div_RightCol.Visible = false;
                        }
                    }
                    else
                    {
                        div_QuizTest.Visible = false;
                    }

                    if (ds.Tables[0].Rows[0]["lastreachedcity"].ToString() != "")
                    {
                        lblCongratulations2.Text = ds.Tables[0].Rows[0]["lastreachedcity"].ToString();
                        lblCongratulations1.Visible = true;
                        lblCongratulations3.Visible = true;
                        //lblFromCityName.Text = ds.Tables[0].Rows[0]["lastreachedcity"].ToString();
                    }
                    else
                    {
                        //lblFromCityName.Text = ds.Tables[0].Rows[0]["StartCity"].ToString();
                    }

                    try
                    {
                        double sm2 = 0;
                        double sm3 = 0;
                        if (showOld == 0)
                        {
                            sm2 = double.Parse(ds.Tables[0].Rows[0]["Distance_Covered"].ToString().Replace(@",", "."), System.Globalization.CultureInfo.InvariantCulture);
                            sm3 = double.Parse(ds.Tables[0].Rows[0]["Distance"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                            percentage = ((sm2 * 100) / Convert.ToDouble(ds.Tables[0].Rows[0]["Distance"]));
                        }
                        else
                        {
                            sm2 = double.Parse(dsPrevStage.Rows[0]["Distance_Covered"].ToString().Replace(@",", "."), System.Globalization.CultureInfo.InvariantCulture);
                            sm3 = double.Parse(dsPrevStage.Rows[0]["Distance"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                            percentage = ((sm2 * 100) / Convert.ToDouble(dsPrevStage.Rows[0]["Distance"]));
                        }

                        lblDistanceCovered.Text = (Math.Round(sm2, 2).ToString() + " km " + (string)GetLocalResourceObject("From") + " " +
                        Math.Round(sm3, 2).ToString() + " km " + (string)GetLocalResourceObject("driven") + "").Replace(",", ".").ToString();
                    }
                    catch (Exception ex)
                    { }
                    //Remove();
                    //if (showOld == 0)
                    //{
                    //    _BindMap(ds.Tables[0].Rows[0]["StartCity"].ToString(), ds.Tables[0].Rows[0]["EndCity"].ToString(), percentage, Convert.ToDouble(ds.Tables[0].Rows[0]["FromCityLat"].ToString()), Convert.ToDouble(ds.Tables[0].Rows[0]["FromCityLong"].ToString()), Convert.ToDouble(ds.Tables[0].Rows[0]["ToCityLat"].ToString()), Convert.ToDouble(ds.Tables[0].Rows[0]["ToCityLong"].ToString()));
                    //}
                    //else
                    //{
                    //    _BindMap(dsPrevStage.Rows[0]["StartCity"].ToString(), dsPrevStage.Rows[0]["EndCity"].ToString(), percentage, Convert.ToDouble(dsPrevStage.Rows[0]["FromCityLat"].ToString()), Convert.ToDouble(dsPrevStage.Rows[0]["FromCityLong"].ToString()), Convert.ToDouble(dsPrevStage.Rows[0]["ToCityLat"].ToString()), Convert.ToDouble(dsPrevStage.Rows[0]["ToCityLong"].ToString()));
                    //}
                }
                else
                {
                    if (CompleteLegs > 0)
                    {
                        DataTable dtLStage = objStudent.GetLastCompleteStageInfo(Convert.ToInt32(Session["UserId"].ToString()), Convert.ToInt32(Session["UserRoleId"].ToString()), classId);
                        if (dtLStage.Rows.Count > 0)
                        {
                         //   lblCurrentStage.Text = (string)GetLocalResourceObject("LastStage") + "<br/>" + dtLStage.Rows[0]["StartCity"].ToString() +
                        //" => " + dtLStage.Rows[0]["EndCity"].ToString();
                            hdn_StartCity.Value = dtLStage.Rows[0]["StartCityId"].ToString();
                            hdn_EndCity.Value = dtLStage.Rows[0]["EndCityId"].ToString();

                            string FromCity = "../CityImages/" + dtLStage.Rows[0]["FromCityimage"].ToString();
                            string ToCity = "../CityImages/" + dtLStage.Rows[0]["ToCityimage"].ToString();

                            if (dtLStage.Rows[0]["FromCityimage"].ToString() != "")
                            {
                                imgFromCity.ImageUrl = FromCity;
                            }
                            else
                            {
                                imgFromCity.ImageUrl = "../CityImages/noImageBig.png";
                            }

                            imgFromCity.ToolTip = dtLStage.Rows[0]["FromCityimage"].ToString();

                            if (dtLStage.Rows[0]["ToCityimage"].ToString() != "")
                            {
                                imgToCity.ImageUrl = ToCity;
                            }
                            else
                            {
                                imgToCity.ImageUrl = "../CityImages/noImageBig.png";
                            }
                            imgToCity.ToolTip = dtLStage.Rows[0]["ToCityimage"].ToString();

                            div_QuizTest.Visible = false;

                            //lblFromCityName.Text = dtLStage.Rows[0]["StartCity"].ToString();

                            try
                            {
                                double sm2 = double.Parse(dtLStage.Rows[0]["Distance_Covered"].ToString().Replace(@",", "."), System.Globalization.CultureInfo.InvariantCulture);
                                double sm3 = double.Parse(dtLStage.Rows[0]["Distance"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
                                percentage = ((sm2 * 100) / Convert.ToDouble(dtLStage.Rows[0]["Distance"]));

                                lblDistanceCovered.Text = (Math.Round(sm2, 2).ToString() + " km von " +
                                Math.Round(sm3, 2).ToString() + " km " + (string)GetLocalResourceObject("driven") + "").Replace(",", ".").ToString();
                            }
                            catch (Exception ex)
                            { }
                            //Remove();
                            //_BindMap(dtLStage.Rows[0]["StartCity"].ToString(), dtLStage.Rows[0]["EndCity"].ToString(), percentage, Convert.ToDouble(dtLStage.Rows[0]["FromCityLat"].ToString()), Convert.ToDouble(dtLStage.Rows[0]["FromCityLong"].ToString()), Convert.ToDouble(dtLStage.Rows[0]["ToCityLat"].ToString()), Convert.ToDouble(dtLStage.Rows[0]["ToCityLong"].ToString()));
                        }
                    }
                }

                if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {
                    ltlClassForum.Text += " - " + ds.Tables[1].Rows[0]["School"].ToString();
                    //h1_ClassForum.InnerHtml += " - " + ds.Tables[1].Rows[0]["School"].ToString();
                   // BindGermanyMap();

                }
                if (ds.Tables[2] != null && ds.Tables[2].Rows.Count > 0)
                {
                    div_RightCol.Visible = true;
                    lbtnCityInfo.Visible = true;
                    div_QuizTest.Visible = true;
                    lbtnCityInfo.PostBackUrl = "~/Student/CityInfo.aspx?cityid=" + ds.Tables[2].Rows[0]["cityInfoCityId"].ToString() +
                        "&cityname=" + ds.Tables[2].Rows[0]["cityname"].ToString() + "&parent=student";
                }
            }
            else
            {
              //  BindGermanyMap();
                div_NoStagePlan.Visible = true;
                div_Content.Visible = false;
                divForumBlog.Style.Add("Width", "100%");
            }
        }
        catch (Exception ex)
        { }

    }


    public void QuizTest(int CityId)
    {
        #region QuizTest
        StringBuilder sb = new StringBuilder();
         
        DataTable dt = objAdmin.GetQuizTest(CityId);
        if (dt != null && dt.Rows.Count > 0)
        {
            sb.Append("<h3>" + dt.Rows[0]["QuizName"].ToString() + "</h3>");
            sb.Append("<table cellpadding='0' cellspacing='0'>");
            sb.Append("<tr>");
            sb.Append("<td align='center' valign='middle'>");
            sb.Append("<object id='quiz' width='720' height='470' classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' align='middle'>");
            //sb.Append("<param name='allowScriptAccess' value='sameDomain' />");
            //sb.Append("<param name='movie' value='../QuizTests/" + dt.Rows[0]["QuizFile"].ToString() + "' />");
            sb.Append("<param name='movie' value='../QuizTests/HtmlQuiz1/" + "index.html" + "' />");
            sb.Append("<param name='quality' value='high' />");
            sb.Append("<param name='bgcolor' value='#ffffff' />");
            sb.Append("<param name='allowFullScreen' value='true' />");
            sb.Append("<embed id='embedQuiz' src='../QuizTests/HtmlQuiz1/" + "index.html" + "' bgcolor='#ffffff' width='720' height='470' name='quiz' align='middle' ");
            // sb.Append("<embed id='embedQuiz' src='../QuizTests/" + dt.Rows[0]["QuizFile"].ToString() + "' quality='high' bgcolor='#ffffff' width='720' height='470' name='quiz' align='middle' ");
            //sb.Append(" allowScriptAccess='sameDomain' type='application/x-shockwave-flash' pluginspage='http://www.adobe.com/go/getflashplayer' allowFullScreen='true' />");
            sb.Append("</object>");
            sb.Append("</td>");
            sb.Append("</tr>");
            sb.Append("</table>");
            
            //  btnQuizNext.Visible = true;


            if (!ClientScript.IsStartupScriptRegistered("JSScript"))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "JSScript", sb.ToString());
            }
            else
            {
                div_QuizTest.Visible = false;
                sb.Append("<b>" + (string)GetLocalResourceObject("NoQuizCreated") + "</b><br/>" + (string)GetLocalResourceObject("ContactAdmin") + "<br/><br/>");
                btnQuizNext.Visible = false;
            }
            lt_Quiz.Text= sb.ToString();
            lt_Quiz.Visible = false;
        #endregion
        }
    }
    

    protected void lbtnUpload_Click(object sender, EventArgs e)
    {

    }

    protected void btnQuizNext_Click(object sender, EventArgs e)
    {
        Response.Redirect("Forum.aspx");
    }

    protected void ddlcity_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlcity.SelectedIndex != 0)
        {
            lbtnCityInfo.PostBackUrl = "~/Student/CityInfo.aspx?cityid=" + ddlcity.SelectedValue +
                            "&cityname=" + ddlcity.SelectedItem.ToString() + "&parent=student";
            lbtnCityInfo.Enabled = true;

            //DataTable dt = objStudent.GetCityInfo(Convert.ToInt16(ddlcity.SelectedValue));
            //if (dt != null && dt.Rows.Count > 0)
            //{
            //    double sm2 = double.Parse(dt.Rows[0]["Distance_Covered"].ToString().Replace(@",", "."), System.Globalization.CultureInfo.InvariantCulture);
            //    double sm3 = double.Parse(dt.Rows[0]["Distance"].ToString(), System.Globalization.CultureInfo.InvariantCulture);
            //    double percentage = ((sm2 * 100) / Convert.ToDouble(dt.Rows[0]["Distance"]));

            //    lbtnCityInfo.PostBackUrl = "~/Student/CityInfo.aspx?cityid=" + ddlcity.SelectedValue +
            //                "&cityname=" + dt.Rows[0]["tocity"].ToString() + "&parent=student";
            //    Remove();
            //    _BindMap(dt.Rows[0]["FromCity"].ToString(), dt.Rows[0]["ToCity"].ToString(), 
            //        percentage,
            //        Convert.ToDouble(dt.Rows[0]["FromCityLat"].ToString()),
            //        Convert.ToDouble(dt.Rows[0]["FromCityLong"].ToString()), 
            //        Convert.ToDouble(dt.Rows[0]["ToCityLat"].ToString()),
            //        Convert.ToDouble(dt.Rows[0]["ToCityLong"].ToString()));
            //}
        }
        else
        {
            lbtnCityInfo.Enabled = false;
        }
    }

    protected void ddlCompetitionCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Request.Cookies["ForumCity"] != null)
        {
            HttpCookie ce = Request.Cookies["ForumCity"];
            ce.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(ce);
        }

        HttpCookie ce12 = new HttpCookie("ForumCity");
        ce12.Value = ddlCompetitionCity.SelectedValue.ToString();
        Response.Cookies.Add(ce12);
        GetData(ddlCompetitionCity.SelectedValue.ToString());

    }

    public void GetData(String Id)
    {
        DataTable dt = new DataTable();
        dt = bcadmin.HighScore(Convert.ToInt32(Id));
        if (dt.Rows.Count > 0)
        {
            lblmsg.Visible = false;
         //   dlsore.DataSource = dt;
           // dlsore.DataBind();
        }
        else
        {
          //  dlsore.DataSource = null;
          //  dlsore.DataBind();
            lblmsg.Visible = true;
            lblmsg.Text = "No High Score For This City";
        }
        lblNoRecord.Visible = false;
        if (ddlCompetitionCity.SelectedValue == "0")
        {
            lblmsg.Text = "";
            lblNoRecord.Visible = true;
        }
    }

    public string GetVisible(object IsDefault)
    {
        try
        {
            if (Convert.ToInt32(IsDefault) == 0)
            {
                return "true";
            }
            else
            {
                return "false";
            }
        }
        catch (Exception ex)
        {
            throw;
        }
    }
}