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

                //ddlCity.DataBind();
                //ddl_City.DataBind();
                //ddlCity.Items.Insert(0, new ListItem("Select City", "0"));
                //ddl_City.Items.Insert(0, new ListItem("Select City", "0"));
                _BindGrid(); 

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
                
                string msg = "";
                if (hdnSchoolId.Value == "0")
                {
                    msg = (string)GetLocalResourceObject("SchoolSaved");
                }
                else
                {
                    msg = (string)GetLocalResourceObject("SchoolUpdated");
                }

                string popupScript = "";
                popupScript = "alert('" + msg + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

                Helper.ClearInputs(this.Controls);
                hdnSchoolId.Value = "0";
                pnlAddNew.Visible = false;
                pnlGrid.Visible = true;
                _BindGrid();
            }
            else if (result == 0)
            {
                //Record already exists

                string msg = (string)GetLocalResourceObject("SchoolExists");
                string popupScript = "alert('" + msg + "');";
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
            hdnSchoolId.Value = "0";
            pnlAddNew.Visible = false;
            pnlGrid.Visible = true;
            _BindGrid();
            Helper.ClearInputs(this.Controls);
            Helper.RebindDropDown(ddl_City);
        }
        catch (Exception)
        {}
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
                objCityAdmin.DeleteSchool(Convert.ToInt32(hdnSchoolId.Value));

                string msg = (string)GetLocalResourceObject("SchoolDeleted");
                string popupScript = "alert('" + msg + "');";
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
                hdnSchoolId.Value = ((Button)sender).CommandArgument.ToString();
                DataTable _dt = objCityAdmin.GetSchoolData(Convert.ToInt32(hdnSchoolId.Value), Convert.ToInt32(Session["UserId"].ToString()));
                if (_dt != null && _dt.Rows.Count > 0)
                {
                    ddlCity.DataBind();
                    ddlCity.SelectedValue = _dt.Rows[0]["cityid"].ToString();
                    txtSchoolName.Text = _dt.Rows[0]["school"].ToString();
                    txtAddress.Text = _dt.Rows[0]["schooladdress"].ToString();

                    pnlAddNew.Visible = true;
                    pnlGrid.Visible = false;

                    string msg = (string)GetLocalResourceObject("UpdateButton");
                    btnSave.Text = msg;
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
            hdnSchoolId.Value = "0";
            pnlAddNew.Visible = true;
            pnlGrid.Visible = false;

            string msg = (string)GetLocalResourceObject("SaveButton");
            btnSave.Text = msg;
        }
        catch (Exception)
        {}
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
            ddl_City.SelectedIndex = 0;
            txt_SearchSchoolName.Text = "";
            _BindGrid();
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        _BindGrid();
    }
    protected void grdScools_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdScools.PageIndex = e.NewPageIndex;
            _BindGrid();
        }
        catch (Exception)
        {}
    }
    protected void grdScools_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    private void _BindGrid()
    {
        objCityAdmin.SchoolId = 0;
        objCityAdmin.CityAdminId = Convert.ToInt32(Session["UserId"]);
        if (ddl_City.SelectedValue == "")
            objCityAdmin.CityId = 0;
        else
            objCityAdmin.CityId = Convert.ToInt32(ddl_City.SelectedValue);
        objCityAdmin.School = txt_SearchSchoolName.Text;
        DataTable dt = objCityAdmin.GetSchoolMaster(objCityAdmin);
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
        grdScools.DataSource = dv;
        grdScools.DataBind();
        grdScools.PageIndex = 0;
    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("School");
        dt.Columns.Add("city");        

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
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

            _BindGrid();
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

                switch (this.ViewState["SortExp"].ToString().ToLower())
                {
                    case "City":
                        PlaceHolder placeholderCity = (PlaceHolder)e.Row.FindControl("placeholderCity");
                        placeholderCity.Controls.Add(ImgSort);
                        break;

                    case "School":
                        PlaceHolder placeholderSchool = (PlaceHolder)e.Row.FindControl("placeholderSchool");
                        placeholderSchool.Controls.Add(ImgSort);
                        break;
                }
            }
        }
    }
    protected void grdScools_Sorting(object sender, GridViewSortEventArgs e)
    {

    }
}