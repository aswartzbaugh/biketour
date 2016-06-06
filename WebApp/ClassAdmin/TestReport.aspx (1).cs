using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ClassAdmin_TestReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null)
                Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

            if (!IsPostBack)
            {
                if (Session["SchoolId"] != null && Session["ClassId"] != null)   
                {
                    ddlSchool.SelectedValue = Session["SchoolId"].ToString();
                    ddlSchool.DataTextField = "School";
                    ddlSchool.DataValueField = "SchoolId";
                    ddlSchool.DataBind();
                    ddlClass.SelectedValue = Session["ClassId"].ToString();
                    ddlClass.DataTextField = "ClassName";
                    ddlClass.DataValueField = "classid";
                    ddlClass.DataBind();
                    ddlClass_SelectedIndexChanged(sender, e);
                    if (Session["StageLeg"] != null)
                    {
                        ddl_Stage.SelectedValue = Session["StageLeg"].ToString();
                        ddl_Stage.DataTextField = "StageLeg";
                        ddl_Stage.DataValueField = "tocityid";
                        ddl_Stage.DataBind();
                        ddl_Stage_SelectedIndexChanged(sender, e);
                    }
                }

               
            }
        }
        catch (Exception)
        { }
    }

    protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        _BindGrid();
    }

    protected void ddl_Stage_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddl_Stage.SelectedIndex != 0)
            {
                Session["SchoolId"] = ddlSchool.SelectedValue;
                Session["ClassId"] = ddlClass.SelectedValue;
                Session["StageLeg"] = ddl_Stage.SelectedValue;
            }
        }
        catch (Exception ex)
        { }
    }

    protected void grd_Report_RowCommand(object sender, GridViewCommandEventArgs e)
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

            _BindGrid();
        }
    }

    protected void grd_Report_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    case "StudentName":
                        PlaceHolder placeholderStudentName = (PlaceHolder)e.Row.FindControl("placeholderStudentName");
                        placeholderStudentName.Controls.Add(ImgSort);
                        break;
                    case "CityName":
                        PlaceHolder placeholderFileCityName = (PlaceHolder)e.Row.FindControl("placeholderFileCityName");
                        placeholderFileCityName.Controls.Add(ImgSort);
                        break;
                    case "OutofScore":
                        PlaceHolder placeholderOutofScore = (PlaceHolder)e.Row.FindControl("placeholderOutofScore");
                        placeholderOutofScore.Controls.Add(ImgSort);
                        break;
                    case "PassingScore":
                        PlaceHolder placeholderPassingScore = (PlaceHolder)e.Row.FindControl("placeholderPassingScore");
                        placeholderPassingScore.Controls.Add(ImgSort);
                        break;
                    case "StudentScore":
                        PlaceHolder placeholderStudentScore = (PlaceHolder)e.Row.FindControl("placeholderStudentScore");
                        placeholderStudentScore.Controls.Add(ImgSort);
                        break;
                    case "Result":
                        PlaceHolder placeholderResult = (PlaceHolder)e.Row.FindControl("placeholderResult");
                        placeholderResult.Controls.Add(ImgSort);
                        break;
                    case "ResultDate":
                        PlaceHolder placeholderResultDate = (PlaceHolder)e.Row.FindControl("placeholderResultDate");
                        placeholderResultDate.Controls.Add(ImgSort);
                        break;
                }
            }
        }
    }

    protected void grd_Report_Sorting(object sender, GridViewSortEventArgs e)
    {

    }

    private void _BindGrid()
    {
        BCClassAdmin objClassAdmin = new BCClassAdmin();

        DataTable dt = objClassAdmin.GetTestReport(Convert.ToInt32(ddl_Stage.SelectedValue), Convert.ToInt32(ddlClass.SelectedValue));

        if (dt == null || dt.Rows.Count == 0)
        {
            dt = _CreateEmptyTable();
        }

        DataView dv = dt.DefaultView;
        if (this.ViewState["SortExp"] == null)
        {
            this.ViewState["SortExp"] = "StudentName";
            this.ViewState["SortOrder"] = "ASC";
        }

        dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];

        grd_Report.DataSource = dv;
        grd_Report.DataBind();
    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        
        dt.Columns.Add("StudentId");
        dt.Columns.Add("ClassId");
        dt.Columns.Add("CityId");
        dt.Columns.Add("OutofScore");
        dt.Columns.Add("PassingScore");
        dt.Columns.Add("StudentScore");
        dt.Columns.Add("Result");
        dt.Columns.Add("ResultDate");
        dt.Columns.Add("StudentName");
        dt.Columns.Add("CityName");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }
}