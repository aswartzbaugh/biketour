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
    DataTable dt = new DataTable();
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
                //ddlCity.DataBind();
              //  ddlSchool.DataBind();
             //   ddlSchool.DataBind();
                ddlCity.DataBind();
                //_Bind();
                ddlCity.Items.Insert(0, new ListItem("Stadt", "0"));
                ddlSchool.Items.Insert(0, new ListItem("Schule", "0"));
                ddl_SearchCity.DataBind();
                ddl_SearchCity.Items.Insert(0, new ListItem("Stadt", "0"));
            }
            catch (Exception)
            {}
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
                    popupScript = "alert('" + (string)GetLocalResourceObject("MsgClassSaved") + "');";//Class saved successfully.
                else
                    popupScript = "alert('" + (string)GetLocalResourceObject("MsgClassUpdate") + "');";//Class updated successfully.

                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                Helper.ClearInputs(this.Controls);
                hdnClassId.Value = "0";
                pnlAddNew.Visible = false;
                pnlGrid.Visible = true;
                //grdClass.DataBind();
                ddl_SearchCity.DataBind();
                ddl_SearchCity.Items.Insert(0, new ListItem("Stadt", "0"));
                _Bind();
            }
            else if (result == 0)
            {
                //Record already exists
                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgAlreadyExist") + "');";//Class with same parameters already exists!
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }
            
        }
        catch (Exception)
        {}
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
            _Bind();
        }
        catch (Exception)
        {}
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

                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgClassDeleted") + "');";//Class deleted successfully.
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //grdClass.DataBind();
                _Bind();
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
                DataTable _dt = objSchoolAdmin.GetClassData(Convert.ToInt32(hdnClassId.Value), 0, schoolId);

                if (_dt != null && _dt.Rows.Count > 0)
                {
                    ddlCity.DataBind();
                    ddlCity.SelectedValue = _dt.Rows[0]["CityId"].ToString();
                    ddlSchool.DataBind();
                    ddlSchool.SelectedValue = _dt.Rows[0]["SchoolId"].ToString();
                   
                    txtClass.Text = _dt.Rows[0]["Class"].ToString();
                    txtClassYear.Text = _dt.Rows[0]["ClassYear"].ToString();
                    pnlAddNew.Visible = true;
                    pnlGrid.Visible = false;
                    btnSave.Text = (string)GetLocalResourceObject("Update"); //"Update";
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
            ddlSchool.DataBind();
            ddlCity.DataBind();
            ddlCity.Items.Insert(0, new ListItem("Stadt", "0"));
            //ddlCity.SelectedValue = "0";
            hdnClassId.Value = "0";
            pnlAddNew.Visible = true;
            pnlGrid.Visible = false;
            btnSave.Text = (string)GetLocalResourceObject("Save"); //"Save";
        }
        catch (Exception)
        {}
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
        try
        {
          //  ddl_School.SelectedIndex = 0;
            txtschool.Text = "";
            ddl_SearchCity.SelectedValue = "0";
            //grdClass.DataBind();
            _Bind();
        }
        catch (Exception)
        { }
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        try
        {
            //grdClass.DataBind();
            _Bind();
        }
        catch (Exception)
        {}
    }

    protected void grdClass_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdClass.PageIndex = e.NewPageIndex;
            //grdClass.DataBind();
            _Bind();
        }
        catch (Exception)
        {}
    }
    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void grdClass_Sorting(object sender, GridViewSortEventArgs e)
    {
        string s = e.SortExpression.ToString();
        string s2 = e.SortDirection.ToString();
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

            _Bind();
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

                switch (this.ViewState["SortExp"].ToString())
                {
                    case "School":
                        PlaceHolder placeholderSchool = (PlaceHolder)e.Row.FindControl("phtgrdSchool");
                        placeholderSchool.Controls.Add(ImgSort);
                        break;
                    case "Class":
                        PlaceHolder placeholderClass = (PlaceHolder)e.Row.FindControl("phtgrdClass");
                        placeholderClass.Controls.Add(ImgSort);
                        break;
                    case "CityName":
                        PlaceHolder placeholderCity = (PlaceHolder)e.Row.FindControl("phtgrdCity");
                        placeholderCity.Controls.Add(ImgSort);
                        break;
                }
            }

        }

    }

    private void _Bind()
    {
        try
        {
            if (grdClass.DataSourceID.Length >= 1)
                grdClass.DataSourceID.Remove(0, grdClass.DataSourceID.Length);

            objSchoolAdmin.SchoolName = txtschool.Text;
            objSchoolAdmin.CityName = Convert.ToInt32(ddl_SearchCity.SelectedValue);

            dt = objSchoolAdmin.GetSchoolClassMasterDetails(objSchoolAdmin);


            grdClass.DataSourceID = "";

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

            grdClass.DataSource = dv;
            grdClass.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "SchoolClassMaster/_Bind()");
        }

    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("School");
        dt.Columns.Add("Class");
        dt.Columns.Add("City");
        dt.Columns.Add("Year");
        dt.Columns.Add("Edit");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }


}