using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AppAdmin_SchoolClassMaster : System.Web.UI.Page
{
    BCSchoolAdmin objSchoolAdmin = new BCSchoolAdmin();
    BCCityAdmin objCityAdmin = new BCCityAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            try
            {
                pnlAddNew.Visible = false;
                pnlGrid.Visible = true;
                //_DisplaySchool();
                ddlCity.DataBind();
                ddlCity.Items.Insert(0, new ListItem(" Stadt", "0"));

                ddl_SearchCity.DataBind();
                ddl_SearchCity.Items.Insert(0, new ListItem(" Stadt", "0"));
                _BindGrid();
            }
            catch (Exception)
            { }
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            int result = _SaveUpdate();
            if (result > 0)
            {
                //Record saved successfully
                string popupScript = "";
                if (hdnClassId.Value == "0")
                    popupScript = "alert('" + (string)GetLocalResourceObject("ClassSaved") + "');";
                else
                    popupScript = "alert('" + (string)GetLocalResourceObject("ClassUpdated") + "');";

                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                Helper.ClearInputs(this.Controls);
                hdnClassId.Value = "0";
                pnlAddNew.Visible = false;
                pnlGrid.Visible = true;
                _BindGrid();
                //grdClass.DataBind();

                ddl_SearchCity.DataBind();
                ddl_SearchCity.Items.Insert(0, new ListItem(" Stadt", "0"));
            }
            else if (result == 0)
            {
                //Record already exists
                string popupScript = "alert('" + (string)GetLocalResourceObject("ClassExists") + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }

        }
        catch (Exception)
        { }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            hdnClassId.Value = "0";
            Response.Redirect("SchoolClassMaster.aspx");
            //pnlAddNew.Visible = false;
            //pnlGrid.Visible = true;
            //grdClass.DataBind();
            //Helper.ClearInputs(this.Controls);
        }
        catch (Exception)
        { }
    }

    private int _SaveUpdate()
    {
        return objSchoolAdmin.InsertUpdateClass(Convert.ToInt16(hdnClassId.Value), Convert.ToInt16(ddlSchool.SelectedValue), txtClass.Text, txtClassYear.Text.Trim());
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                objSchoolAdmin.DeleteClass(Convert.ToInt32(hdnClassId.Value));

                string popupScript = "alert('" + (string)GetLocalResourceObject("ClassDeleted") + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                _BindGrid();
            }
            catch (Exception ex)
            {

                Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                hdnClassId.Value = ((Button)sender).CommandArgument.Split('|')[0];
                int schoolId = Convert.ToInt32(((Button)sender).CommandArgument.Split('|')[1]);
                DataTable _dt = objSchoolAdmin.GetClassInfo(Convert.ToInt32(hdnClassId.Value));
                if (_dt != null && _dt.Rows.Count > 0)
                {
                    ddlCity.DataBind();
                    ddlCity.SelectedValue = _dt.Rows[0]["cityid"].ToString();
                    ddlSchool.DataBind();
                    ddlSchool.SelectedValue = _dt.Rows[0]["schoolid"].ToString();
                    txtClass.Text = _dt.Rows[0]["class"].ToString();
                    txtClassYear.Text = _dt.Rows[0]["ClassYear"].ToString();
                    pnlAddNew.Visible = true;
                    pnlGrid.Visible = false;
                    btnSave.Text = (string)GetLocalResourceObject("ButtonUpdate");
                }
            }
            catch (Exception ex)
            {

                Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        try
        {
            hdnClassId.Value = "0";
            pnlAddNew.Visible = true;
            pnlGrid.Visible = false;
            btnSave.Text = (string)GetLocalResourceObject("ButtonSave");
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem(" Stadt", "0"));
        }
        catch (Exception)
        { }
    }

    //private void _DisplaySchool()
    //{
    //    DataTable dt = objSchoolAdmin.GetSchool();
    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        lblSchoolName.Text = dt.Rows[0]["School"].ToString();
    //        hdnSchoolId.Value = dt.Rows[0]["SchoolId"].ToString();
    //    }
    //}

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        txtschool.Text = "";
        ddl_SearchCity.SelectedValue = "0";
        _BindGrid();
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        _BindGrid();
    }

    protected void grdClass_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdClass.PageIndex = e.NewPageIndex;
            _BindGrid();
        }
        catch (Exception)
        { }
    }
    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {

        ddlSchool.DataBind();
    }


    private void _BindGrid()
    {
        objCityAdmin.CityAdminId = Convert.ToInt32(Session["UserId"]);
        objCityAdmin.CityId = Convert.ToInt32(ddl_SearchCity.SelectedValue);
        objCityAdmin.School = txtschool.Text;
        DataTable dt = objCityAdmin.GetSchoolClassMaster(objCityAdmin);
        if (dt == null || dt.Rows.Count == 0)
        {
            dt = _CreateEmptyTable();
        }
        DataView dv = dt.DefaultView;
        if (this.ViewState["SortExp"] == null)
        {
            this.ViewState["SortExp"] = "School";
            this.ViewState["SortOrder"] = "ASC";
        }
        dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];
        grdClass.DataSource = dv;
        grdClass.DataBind();
        grdClass.PageIndex = 0;

    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("School");
        dt.Columns.Add("Class");
        dt.Columns.Add("City");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }


    protected void grdClass_RowCommand(object sender, GridViewCommandEventArgs e)
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
    protected void grdClass_RowDataBound(object sender, GridViewRowEventArgs e)
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

                switch (this.ViewState["SortExp"].ToString().ToLower())
                {
                    case "School":
                        PlaceHolder placeholderSchool = (PlaceHolder)e.Row.FindControl("placeholderSchool");
                        placeholderSchool.Controls.Add(ImgSort);
                        break;
                    case "Class":
                        PlaceHolder placeholderClass = (PlaceHolder)e.Row.FindControl("placeholderClass");
                        placeholderClass.Controls.Add(ImgSort);
                        break;

                    case "CityName":
                        PlaceHolder placeholderCityName = (PlaceHolder)e.Row.FindControl("placeholderCityName");
                        placeholderCityName.Controls.Add(ImgSort);
                        break;
                }
            }
        }
    }
    protected void grdClass_Sorting(object sender, GridViewSortEventArgs e)
    {
        string s = e.SortExpression.ToString();
        string s2 = e.SortDirection.ToString();
    }
}
