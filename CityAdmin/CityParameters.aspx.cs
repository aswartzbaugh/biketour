using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AppAdmin_CityParameters : System.Web.UI.Page
{
    BCCityAdmin objCityAdmin = new BCCityAdmin();
    DataTable result = null;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());
        if (!IsPostBack)
        {
            LoadCityParameter();
        }
        
    }

    private void LoadCityParameter()
    {
        if (!string.IsNullOrEmpty(ddlClass.SelectedValue))
        {
            result = objCityAdmin.GetCityContent(Convert.ToInt32(ddlClass.SelectedValue));

            if (result != null && result.Rows.Count > 0)
            {
                txt_Date.Text = (result.Rows[0]["CityStartDate"] != null ? Convert.ToString(result.Rows[0]["CityStartDate"]) : string.Empty);
                chkMarkInvalid.Checked = (result.Rows[0]["IsAllFileInvalid"] != null ? Convert.ToBoolean(result.Rows[0]["IsAllFileInvalid"]) : false);
            }
        }
    }
    
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Helper.ClearInputs(this.Controls);
        Response.Redirect("~/ControlPanel/Home.aspx");
       
    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        if (chkMarkInvalid.Checked)
        {
            string popupScript = "'" + (string)GetLocalResourceObject("Message.Confirm") + "'";
            ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), "ConfirmAll(" + popupScript + ")", true);
        }
        else
        {
            Update();
        }
    }

    private int _SaveUpdate()
    {
        return objCityAdmin.UpdateCityContent(txt_Date.Text, chkMarkInvalid.Checked, Convert.ToInt32(ddlClass.SelectedValue));

    }


    public void btnUpdateSettings_Click(object sender, EventArgs e)
    {
        Update();        
    }

    private void Update()
    {
        string popupScript = string.Empty;

        int result = _SaveUpdate();
        if (result > 0)
        {
            //Record saved successfully  
            if (chkMarkInvalid.Checked)
            {
                objCityAdmin.DeleteUploadedFilesBeforeSetDate(Convert.ToInt32(ddlClass.SelectedValue),
                Convert.ToDateTime(txt_Date.Text));
            }

            popupScript = "alert('" + (string)GetLocalResourceObject("Message.Success") + "');";
        }
        else if (result == 0)
        {
            //Record already exists
            popupScript = "alert('" + (string)GetLocalResourceObject("Message.Error") + "');";
        }
        ScriptManager.RegisterStartupScript(this, this.GetType(), Guid.NewGuid().ToString(), popupScript, true);
    }
}