using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;

public partial class CityAdmin_SchoolAdmin : System.Web.UI.Page
{
    DOLUser objUser = new DOLUser();
    BCCityAdmin objCityAdmin = new BCCityAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            pnlAddNew.Visible = false;
            pnlGrid.Visible = true;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        int result = _SaveUpdate();
        if (result > 0)
        {
            //Record saved successfully
            string popupScript = "";
            if (hdnSchoolAdminId.Value == "0")
                popupScript = "alert('School admin saved successfully.');";
            else
                popupScript = "alert('School admin updated successfully.');";

            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

            Helper.ClearInputs(this.Controls);
            hdnSchoolAdminId.Value = "0";
            pnlAddNew.Visible = false;
            pnlGrid.Visible = true;
            grdSchoolAdmin.DataBind();
        }
        else if (result == 0)
        {
            //Record already exists
            string popupScript = "alert('School admin already exists.');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            txtEmail.Focus();
        }
        
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        hdnSchoolAdminId.Value = "0";
        pnlAddNew.Visible = false;
        pnlGrid.Visible = true;
        rfvConfirmPassword.Enabled = true;
        rfvPassword.Enabled = true;
        Helper.ClearInputs(this.Controls);
        grdSchoolAdmin.DataBind();
    }

    private int _SaveUpdate()
    {

        objUser.UserId = Convert.ToInt16(hdnSchoolAdminId.Value);
        objUser.FirstName = txtFirstName.Text;
        objUser.LastName = txtLastName.Text;
        objUser.Address = txtAddress.Text;
        objUser.Email = txtEmail.Text;
        objUser.Password = txtPassword.Text;
        objUser.SchoolId = Convert.ToInt16(ddlSchool.SelectedValue);

        return objCityAdmin.InsertUpdateSchoolAdmin(objUser);

    }
    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        hdnSchoolAdminId.Value = "0";
        pnlAddNew.Visible = true;
        pnlGrid.Visible = false;
        btnSave.Text = "Save";
        rfvConfirmPassword.Enabled = true;
        rfvPassword.Enabled = true;
        tr_password.Visible = true;
        tr_conpassword.Visible = true;
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                objCityAdmin.DeleteSchoolAdmin(Convert.ToInt32(hdnSchoolAdminId.Value));

                string popupScript = "alert('School Admin deleted successfully.');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                grdSchoolAdmin.DataBind();
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
                hdnSchoolAdminId.Value = ((Button)sender).CommandArgument.ToString();
                DataTable _dt = objCityAdmin.GetSchoolAdminData(Convert.ToInt32(hdnSchoolAdminId.Value));
                if (_dt != null && _dt.Rows.Count > 0)
                {
                    ddlSchool.DataBind();
                    ddlSchool.SelectedValue = _dt.Rows[0]["SchoolId"].ToString();
                    txtAddress.Text = _dt.Rows[0]["Address"].ToString();
                    txtEmail.Text = _dt.Rows[0]["Email"].ToString();
                    txtFirstName.Text = _dt.Rows[0]["FirstName"].ToString();
                    txtLastName.Text = _dt.Rows[0]["LastName"].ToString();
                    //txtConfirmPassword.Text = _dt.Rows[0]["Password"].ToString();
                    //txtPassword.Text = _dt.Rows[0]["Password"].ToString();
                    tr_password.Visible = false;
                    tr_conpassword.Visible = false;

                    pnlAddNew.Visible = true;
                    pnlGrid.Visible = false;
                    btnSave.Text = "Update";
                    rfvConfirmPassword.Enabled = false;
                    rfvPassword.Enabled = false;
                }
            }
            catch (Exception ex)
            {

                Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }
    protected void grdSchoolAdmin_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        
        
    }
    protected void grdSchoolAdmin_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdSchoolAdmin.PageIndex = e.NewPageIndex;
            grdSchoolAdmin.DataBind();

        }
        catch (Exception ex)
        {}
    }

    private void _BindGrid()
    {
        objCityAdmin.SchoolAdminId = 0;
        DataTable dt = objCityAdmin.GetSchoolAdminTable(objCityAdmin);
        if (dt == null || dt.Rows.Count == 0)
        {
            dt = _CreateEmptyTable();
        }
        DataView dv = dt.DefaultView;
        if (this.ViewState["SortExp"] == null)
        {
            this.ViewState["SortExp"] = "PolicyName";
            this.ViewState["SortOrder"] = "ASC";
        }
        dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];
        grdSchoolAdmin.DataSource = dv;
        grdSchoolAdmin.DataBind();
        grdSchoolAdmin.PageIndex = 0;
    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("School");
        dt.Columns.Add("FirstName");
        dt.Columns.Add("LastName");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }
    protected void grdSchoolAdmin_RowCommand(object sender, GridViewCommandEventArgs e)
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
    protected void grdSchoolAdmin_RowDataBound(object sender, GridViewRowEventArgs e)
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
                        PlaceHolder placeholderSubDeptName = (PlaceHolder)e.Row.FindControl("placeholderSchool");
                        placeholderSubDeptName.Controls.Add(ImgSort);
                        break;
                }
            }
        }
    }
}