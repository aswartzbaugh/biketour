using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data;

public partial class AppAdmin_AddQuizTests : System.Web.UI.Page
{
    BCAppAdmin objAdmin = new BCAppAdmin();
    DataTable dt = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            ddl_City.DataBind();
            ddl_City.Items.Insert(0, new ListItem((string)GetLocalResourceObject("MsgSelectCity"), "0"));
        }
    }

    protected void btn_Upload_Click(object sender, EventArgs e)
    {
        string FileName = fu_UploadQuiz.PostedFile.FileName;
        string NewFile = "";
        string NewFileName = "";
        string FilePath = Server.MapPath("../QuizTests/").ToString();
        string extension = System.IO.Path.GetExtension(FileName).ToLower();
        if ((extension == ".swf") | (extension == ".SWF"))
        {
            System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(FilePath);
            if (!(dir.Exists))
            {
                System.IO.Directory.CreateDirectory(FilePath);
            }
            fu_UploadQuiz.SaveAs(FilePath + FileName);
            try
            {
                string TimeStamp = DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() +
                DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString();

                NewFileName = "Quiz_" + TimeStamp + ".swf";
                File.Move(FilePath + FileName, FilePath + NewFileName); // Try to move
                NewFile = FilePath + NewFileName;
                int res = objAdmin.InsertQuizTest(0, txt_QuizTest.Text.Trim(), NewFileName, Convert.ToInt32(ddl_City.SelectedValue));
                if (res > 0)
                {
                    string popupScript = "alert('" + (string)GetLocalResourceObject("MsgQzSave") + "');";//Quiz Test Saved Successfully!
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                    txt_QuizTest.Text = "";
                    //grd_QuizList.DataBind();
                    _Bind();
                    ddl_City.DataBind();
                    ddl_City.Items.Insert(0, new ListItem((string)GetLocalResourceObject("MsgSelectCity"), "0"));
                }
            }
            catch (IOException ex)
            {
                
            }
        }
        else
        {
            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgInvalidFile") + "');";//Invalid file!
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                int res = objAdmin.DeleteQuiz(Convert.ToInt32(hdnQuizId.Value));
                if (res > 0)
                {
                    string popupScript = "alert('" + (string)GetLocalResourceObject("MsgQzDelete") + "');";//Quiz deleted successfully.
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                    //grd_QuizList.DataBind();
                    _Bind();
                    ddl_City.DataBind();
                    ddl_City.Items.Insert(0, new ListItem((string)GetLocalResourceObject("MsgSelectCity"), "0"));//Select City
                }
            }
            catch (Exception ex)
            {
            }
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        txt_QuizTest.Text = "";
        ddl_City.SelectedValue = "0";
    }
    protected void grd_Sorting(object sender, GridViewSortEventArgs e)
    {
        string s = e.SortExpression.ToString();
        string s2 = e.SortDirection.ToString();
    }

    protected void grd_QuizList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (this.ViewState["SortExp"] != null)
            {
                Image ImgSort = new Image();
                if (this.ViewState["SortOrder"].ToString() == "ASC")
                    ImgSort.ImageUrl = "~/_images/ArrowDown.png";
                else
                    ImgSort.ImageUrl = "~/_images/ArrowUp.png";

                switch (this.ViewState["SortExp"].ToString())
                {
                    case "QuizId":
                        PlaceHolder placeholderQuizID = (PlaceHolder)e.Row.FindControl("pdtQuizID");
                        placeholderQuizID.Controls.Add(ImgSort);
                        break;

                    case "QuizName":
                        PlaceHolder placeholderQuizFile = (PlaceHolder)e.Row.FindControl("pdtQuizFile");
                        placeholderQuizFile.Controls.Add(ImgSort);
                        break;
                    case "QuizFile":
                        PlaceHolder placeholderQuizFile1 = (PlaceHolder)e.Row.FindControl("pdtQuizFile1");
                        placeholderQuizFile1.Controls.Add(ImgSort);
                        break;
                    case "CityName":
                        PlaceHolder placeholderCityName = (PlaceHolder)e.Row.FindControl("pdtCityName");
                        placeholderCityName.Controls.Add(ImgSort);
                        break;

                }
            }

        }
        
    }
    protected void grd_QuizList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToLower().Equals("sort"))
        {
            if (this.ViewState["SortExp"] == null)
            {
                this.ViewState["SortExp"] = e.CommandArgument.ToString();
                this.ViewState["SortOrder"] = "ASC";
            }
            else
            {
                if (this.ViewState["SortExp"].ToString() == e.CommandArgument.ToString())
                {
                    if (this.ViewState["SortOrder"].ToString() == "ASC")
                        this.ViewState["SortOrder"] = "DESC";
                    else
                        this.ViewState["SortOrder"] = "ASC";
                }
                else
                {
                    this.ViewState["SortOrder"] = "ASC";
                    this.ViewState["SortExp"] = e.CommandArgument.ToString();
                }
            }

            _Bind();
        }
    }

    private void _Bind()
    {
        try
        {
            if (grd_QuizList.DataSourceID.Length >= 1)
                grd_QuizList.DataSourceID.Remove(0, grd_QuizList.DataSourceID.Length);

            dt = objAdmin.GetAllDetailsQuiz();


            grd_QuizList.DataSourceID = "";

            if (dt == null || dt.Rows.Count == 0)
            {
                dt = _CreateEmptyTable();
            }

            DataView dv = dt.DefaultView;
            if (this.ViewState["SortExp"] == null)
            {
                //this.ViewState["SortExp"] = "make";
                //this.ViewState["SortOrder"] = "ASC";
            }
            else
            {
                dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];
            }

            grd_QuizList.DataSource = dv;
            grd_QuizList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "AddQuizTest/_Bind()");
        }

    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("QuizId");
        dt.Columns.Add("Quiz File");
        dt.Columns.Add("Quiz File1");
        dt.Columns.Add("City Name");
        dt.Columns.Add("Delete");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }

}