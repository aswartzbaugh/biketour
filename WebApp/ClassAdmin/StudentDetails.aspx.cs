using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ClassAdmin_StudentDetails : System.Web.UI.Page
{
    BCStudent objStudent = new BCStudent();
    DOLUser objUser = new DOLUser();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {

            try
            {
                int StudentId = 0;
                if (Request.QueryString["StudentId"] != null)
                {
                    StudentId = Convert.ToInt32(Request.QueryString["StudentId"]);
                }
                if (StudentId != 0)
                {
                    pnl_MyProfile.Visible = true;
                    DataTable dtCityAdmin = objStudent.GetMyProfileInfo(StudentId);

                    if (dtCityAdmin.Rows.Count > 0)
                    {
                        txt_FirstName.Text = dtCityAdmin.Rows[0]["FirstName"].ToString();
                        txt_LastName.Text = dtCityAdmin.Rows[0]["LastName"].ToString();

                        hdn_CityID.Value = dtCityAdmin.Rows[0]["CityId"].ToString();
                        txtCity.Text = dtCityAdmin.Rows[0]["CityName"].ToString();

                        hdn_SchoolID.Value = dtCityAdmin.Rows[0]["SchoolId"].ToString();
                        txtSchool.Text = dtCityAdmin.Rows[0]["School"].ToString();

                        txtClass.Text = dtCityAdmin.Rows[0]["Class"].ToString();
                        hdn_ClassID.Value = dtCityAdmin.Rows[0]["ClassId"].ToString();

                        txtUsername.Text = dtCityAdmin.Rows[0]["UserName"].ToString();

                        txtEmail.Text = dtCityAdmin.Rows[0]["Email"].ToString();
                    }

                }
                else
                {
                    Response.Redirect("ParticipantList.aspx");
                }

                _BindGrid();
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }

        }
    }
    protected void grdStudentDetails_RowCommand(object sender, GridViewCommandEventArgs e)
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
    protected void grdStudentDetails_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    case "NAME":
                        PlaceHolder placeholderNAME = (PlaceHolder)e.Row.FindControl("placeholderNAME");
                        placeholderNAME.Controls.Add(ImgSort);
                        break;
                    case "FileName":
                        PlaceHolder placeholderFileName = (PlaceHolder)e.Row.FindControl("placeholderFileName");
                        placeholderFileName.Controls.Add(ImgSort);
                        break;
                    case "Kilometer":
                        PlaceHolder placeholderKilometer = (PlaceHolder)e.Row.FindControl("placeholderKilometer");
                        placeholderKilometer.Controls.Add(ImgSort);
                        break;
                    case "Time":
                        PlaceHolder placeholderTime = (PlaceHolder)e.Row.FindControl("placeholderTime");
                        placeholderTime.Controls.Add(ImgSort);
                        break;
                }
            }
        }
    }
    protected void grdStudentDetails_Sorting(object sender, GridViewSortEventArgs e)
    {

    }

    private void _BindGrid()
    {
        BCClassAdmin objClassAdmin = new BCClassAdmin();

        DataTable dt = objClassAdmin.GetStudentList(Convert.ToInt32(Request.QueryString["StudentId"].ToString()));

        if (dt == null || dt.Rows.Count == 0)
        {
            dt = _CreateEmptyTable();
        }

        DataView dv = dt.DefaultView;
        if (this.ViewState["SortExp"] == null)
        {
            this.ViewState["SortExp"] = "NAME";
            this.ViewState["SortOrder"] = "ASC";
        }

        if (dv.Count > 0)
            btnDeleteFile.Visible = true;
        else
            btnDeleteFile.Visible = false;

        dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];

        grdStudentDetails.DataSource = dv;
        grdStudentDetails.DataBind();
    }

    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("StudentId");

        dt.Columns.Add("NAME");
        dt.Columns.Add("FileName");
        dt.Columns.Add("Kilometer");
        dt.Columns.Add("time");
        dt.Columns.Add("Uploadeddate");
        dt.Columns.Add("IsNoVisible");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        try
        {
            if (lblDuplicateUsername.Visible)
            {
                lblDuplicateUsername.Visible = false;
                return;
            }
            int result = _SaveUpdate();
            if (result > 0)
            {
                //Record saved successfully
                string popupScript = "";
                if (hdn_MyProfileId.Value == "0")
                    popupScript = "alert('Informationen gespeichert');";
                else
                    popupScript = "alert('Profil aktualisiert');";

                //grdStudentDetails.DataBind();

                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                Response.Redirect("~/ClassAdmin/ParticipantList.aspx");
            }
            else if (result == 0)
            {
                //Record already exists
                string popupScript = "alert('Schüler bereits vorhanden');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //txtEmail.Focus();
            }
                        
            //_BindGrid();
            
        }
        catch { }
    }

    private int _SaveUpdate()
    {
        int StudentId = 0;
        if (Request.QueryString["StudentId"] != null)
        {
            StudentId = Convert.ToInt32(Request.QueryString["StudentId"]);
        }

        objUser.UserId = StudentId;
        objUser.FirstName = txt_FirstName.Text;
        objUser.LastName = txt_LastName.Text;
        objUser.Email = txtEmail.Text;
        objUser.Password = "";
        objUser.CityId = Convert.ToInt16(hdn_CityID.Value);
        objUser.SchoolId = Convert.ToInt16(hdn_SchoolID.Value);
        objUser.ClassId = Convert.ToInt16(hdn_ClassID.Value);
        objUser.UserName = txtUsername.Text.Trim();
        return objStudent.InsertStudent(objUser);
    }

    protected void txtUsername_TextChanged(object sender, EventArgs e)
    {
        int StudentId = 0;
        if (Request.QueryString["StudentId"] != null)
        {
            StudentId = Convert.ToInt32(Request.QueryString["StudentId"]);
        }

        if (objStudent.IsDuplicateUsername(txtUsername.Text, StudentId))
        {
            lblDuplicateUsername.Visible = true;
            txtUsername.Text = "";
            txtUsername.Focus();
        }
        else
        {
            lblDuplicateUsername.Visible = false;
        }
    }

    protected void grdStudentDetails_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

    }
    protected void grdStudentDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdStudentDetails.PageIndex = e.NewPageIndex;
            _BindGrid();
        }
        catch (Exception)
        { }
    }
    protected void btnDeleteStudent_Click(object sender, EventArgs e)
    {
        try
        {
            int StudentUploadId = Convert.ToInt32(hdnDeleteId.Value);//Convert.ToInt32(((Button)sender).CommandArgument.ToString());
            objStudent.DeleteStudentUpload(StudentUploadId);
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "successDelete();", true);
            //grdStudentDetails.PageIndex = e.NewPageIndex;
            _BindGrid();
        }
        catch (Exception)
        { }
    }

    protected void btnDeleteFile_Click(object sender, EventArgs e)
    {
        string popupScript = "'" + (string)GetLocalResourceObject("DeleteFile.ConfirmMessage") + "'";
        ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "ConfirmAll(" + popupScript + ");", true);
    }
    protected void btnDeleteSelectedFiles_Click(object sender, EventArgs e)
    {
        List<String> selectedFiles = new List<string>();
        int StudentId = 0;

        try
        {
            if (Request.QueryString["StudentId"] != null)
            {
                StudentId = Convert.ToInt32(Request.QueryString["StudentId"]);
            }

            objUser.SchoolId = Convert.ToInt16(hdn_SchoolID.Value);
            objUser.ClassId = Convert.ToInt16(hdn_ClassID.Value);
            
            string folderPath = Server.MapPath("../GPXFiles/" + objUser.SchoolId + "/" + objUser.ClassId + "/" + StudentId);
            string[] uploadedFiles = System.IO.Directory.GetFiles(folderPath, "*.xml");
            int deleteById = Convert.ToInt32(Session["LoginId"]);
            foreach (GridViewRow rw in grdStudentDetails.Rows)
            {
                CheckBox chk_Delete = rw.FindControl("chk_Delete") as CheckBox;
                Label lblFileName = rw.FindControl("lblFileName") as Label;
                if (chk_Delete.Checked)
                {
                    //selectedFiles.Add(lblFileName.Text);
                    if (System.IO.File.Exists(folderPath + "/" + lblFileName.Text))
                    {
                        System.IO.File.Delete(folderPath + "/" + lblFileName.Text);

                        objStudent.UpdateFileDeleteFlag(objUser.SchoolId, objUser.ClassId, StudentId, lblFileName.Text, deleteById);
                    }
                }
            }
            _BindGrid();
            string popupScript = "'" + (string)GetLocalResourceObject("DeleteFile.SuccessMessage") + "'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "successDelete(" + popupScript + ");", true);
        }
        catch
        {
            string popupScript = "'" + (string)GetLocalResourceObject("DeleteFile.ErrorMessage") + "'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "successDelete(" + popupScript + ");", true);

        }
    }
}