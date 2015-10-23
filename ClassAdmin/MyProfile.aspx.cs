using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ClassAdmin_myProfile : System.Web.UI.Page
{
    DOLUser objUser = new DOLUser();
    BCClassAdmin objClassAdmin = new BCClassAdmin();
    BCSchoolAdmin objSchoolAdmin = new BCSchoolAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
            _BindData();
    }
   
   
    protected void btn_Update_Click(object sender, EventArgs e)
    {
        int result = _SaveUpdate();
        if (result > 0)
        {
            //Record saved successfully
            string popupScript = "";
            if (hdn_MyProfileId.Value == "0")
                popupScript = "alert('Class admin saved successfully.');";
            else
                popupScript = "alert('Profile updated successfully.');";

            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            //Helper.ClearInputs(this.Controls);
            //hdn_MyProfileId.Value = "0";
            //Helper.ClearInputs(this.Controls);
            //Response.Redirect("~/ControlPanel/Home.aspx");
        }
        else if (result == 0)
        {
            //Record already exists
            string popupScript = "alert('Class admin already exists.');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            txtEmail.Focus();
        }
    }

    private int _SaveUpdate()
    {
        objUser.UserId = Convert.ToInt32(Session["UserId"].ToString());
        objUser.FirstName = txt_FirstName.Text;
        objUser.LastName = txt_LastName.Text;
        objUser.Address = txtAddress.Text;
        objUser.Email = txtEmail.Text;
        objUser.Password = "";

        return objSchoolAdmin.InsertUpdateClassAdmin(objUser);
    }

    protected void btn_GetInfo(object sender, EventArgs e)
    {
        
        
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Helper.ClearInputs(this.Controls);
        Response.Redirect("~/ControlPanel/Home.aspx");
    }

    private void _BindData()
    {
        try
        {
            pnl_MyProfile.Visible = true;
            DataSet dsCityAdmin = objClassAdmin.GetMyProfileInfo(Convert.ToInt32(Session["UserId"].ToString()));

            if (dsCityAdmin != null && dsCityAdmin.Tables.Count > 0)
            {
                if (dsCityAdmin.Tables[0].Rows.Count > 0)
                {
                    txt_FirstName.Text = dsCityAdmin.Tables[0].Rows[0]["FirstName"].ToString();
                    txt_LastName.Text = dsCityAdmin.Tables[0].Rows[0]["LastName"].ToString();
                    txtAddress.Text = dsCityAdmin.Tables[0].Rows[0]["Address"].ToString();
                    txtEmail.Text = dsCityAdmin.Tables[0].Rows[0]["Email"].ToString();
                    pnl_MyProfile.Visible = true;
                }
                if (dsCityAdmin.Tables[1].Rows.Count > 0)
                {
                    grdClasses.DataSource = dsCityAdmin.Tables[1];
                    grdClasses.DataBind();
                }

            }
        }
        catch (Exception ex)
        {
            //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
        }
    }
}