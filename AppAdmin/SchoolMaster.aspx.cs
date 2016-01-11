using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AppAdmin_SchoolMaster : System.Web.UI.Page
{
    BCCityAdmin objCityAdmin = new BCCityAdmin();
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
                //_DisplayCity();
                ddl_City.DataBind();
                ddlCity.Items.Insert(0, new ListItem("Stadt", "0"));
                _Bind();
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
                if (hdnSchoolId.Value == "0")
                    popupScript = "alert('" + (string)GetLocalResourceObject("MsgSchoolSave") + "');";//School saved successfully.
                else
                    popupScript = "alert('" + (string)GetLocalResourceObject("MsgSchoolUpdate") + "');";//School updated successfully.

                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

                Helper.ClearInputs(this.Controls);
                hdnSchoolId.Value = "0";
                pnlAddNew.Visible = false;
                pnlGrid.Visible = true;
                _Bind();
            }
            else if (result == 0)
            {
                //Record already exists
                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgSchoolExist") + "');";//School already exists.
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
            hdnSchoolId.Value = "0";
            pnlAddNew.Visible = false;
            pnlGrid.Visible = true;
            _Bind();
            Helper.ClearInputs(this.Controls);
        }
        catch (Exception)
        { }
    }

    private int _SaveUpdate()
    {
        return objCityAdmin.InsertUpdateSchool(Convert.ToInt16(hdnSchoolId.Value), Convert.ToInt16(ddlCity.SelectedValue), txtSchoolName.Text, txtAddress.Text);
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                objCityAdmin.DeleteSchool(Convert.ToInt32(hdnSchoolId.Value), Convert.ToInt32(Session["UserId"]));

                string popupScript = "alert('" + (string)GetLocalResourceObject("MsgSchoolDeleted") + "');";//School deleted successfully.
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
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
                hdnSchoolId.Value = ((Button)sender).CommandArgument.ToString();
                DataTable _dt = objCityAdmin.GetSchoolData(Convert.ToInt32(hdnSchoolId.Value), Convert.ToInt32(Session["UserId"].ToString()));
                if (_dt != null && _dt.Rows.Count > 0)
                {
                    ddlCity.DataBind();
                    try
                    {
                        ddlCity.SelectedValue = _dt.Rows[0]["cityid"].ToString();
                    }
                    catch { }
                    txtSchoolName.Text = _dt.Rows[0]["school"].ToString();
                    txtAddress.Text = _dt.Rows[0]["schooladdress"].ToString();

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
            ddlCity.DataBind();
            ddlCity.Items.Add(new ListItem("Select City", "0"));
            hdnSchoolId.Value = "0";
            pnlAddNew.Visible = true;
            pnlGrid.Visible = false;
            btnSave.Text = (string)GetLocalResourceObject("Save"); //"Save";
        }
        catch (Exception)
        { }
    }

    //private void _DisplayCity()
    //{
    //    DataTable dt = objCityAdmin.GetCity();
    //    if (dt != null && dt.Rows.Count > 0)
    //    {
    //        lblCityName.Text = dt.Rows[0]["Cityname"].ToString();
    //        hdnCityId.Value = dt.Rows[0]["Cityid"].ToString();
    //    }
    //}

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        try
        {
            ddl_City.SelectedIndex = 0;
            txt_SearchSchoolName.Text = "";
            _Bind();
        }
        catch (Exception)
        { }
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        try
        {
            _Bind();
        }
        catch (Exception)
        { }
    }
    protected void grdScools_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdScools.PageIndex = e.NewPageIndex;
            _Bind();
        }
        catch (Exception)
        { }
    }
    protected void grdScools_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void grdScools_Sorting(object sender, GridViewSortEventArgs e)
    {
        string s = e.SortExpression.ToString();
        string s2 = e.SortDirection.ToString();
    }
    protected void grdScools_RowCommand(object sender, GridViewCommandEventArgs e)
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
    protected void grdScools_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    case "City":
                        PlaceHolder placeholderCity = (PlaceHolder)e.Row.FindControl("phtgrdHeaderCity");
                        placeholderCity.Controls.Add(ImgSort);
                        break;
                    case "school":
                        PlaceHolder placeholderSchool = (PlaceHolder)e.Row.FindControl("phtgrdSchool");
                        placeholderSchool.Controls.Add(ImgSort);
                        break;
                }
            }

        }

    }

    private void _Bind()
    {
        try
        {
            if (grdScools.DataSourceID.Length >= 1)
                grdScools.DataSourceID.Remove(0, grdScools.DataSourceID.Length);

            objCityAdmin.SchoolId = 0;
            objCityAdmin.CityAdminId = 0;
            objCityAdmin.CityId = Convert.ToInt32(ddl_City.SelectedValue);
            objCityAdmin.School = txt_SearchSchoolName.Text;

            dt = objCityAdmin.GetSchoolMasterData(objCityAdmin);


            grdScools.DataSourceID = "";

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

            grdScools.DataSource = dv;
            grdScools.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "SchoolMaster/_Bind()");
        }

    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("City");
        dt.Columns.Add("School");
        dt.Columns.Add("Edit");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }

    protected void btnDeleteSchool_Click(object sender, EventArgs e)
    {
        try
        {
            int SchoolId = Convert.ToInt32(hdnSchoolId.Value);
            //Convert.ToInt32(((Button)sender).CommandArgument.ToString());
            string msg = (string)GetLocalResourceObject("SchoolDeleted");
            string popupScript = "alert('" + msg + "');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            objCityAdmin.DeleteSchool(SchoolId, Convert.ToInt32(Session["UserId"]));
            _Bind();
        }
        catch (Exception ex)
        {
            //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
        }
    }
}