using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppAdmin_TransferResponsibility : System.Web.UI.Page
{
    DOLUser objUser = new DOLUser();
    BCAppAdmin objAppAdmin = new BCAppAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

    }
    protected void btn_SaveAdmin_Click(object sender, EventArgs e)
    {
        int result = Convert.ToInt32(ddl_ClassAdmins.SelectedValue);
        if (result > 0)
        {
            int res = objAppAdmin.TansferResponsibilityClass(Convert.ToInt32(Request.QueryString["oldAdmin"]), result);
            Helper.ClearInputs(this.Controls);
            hdn_ClassAdminId.Value = "0";
            Response.Redirect("CityAdmin.aspx?Ref=Transfer");
        }
    }
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {

        Response.Redirect("CityAdmin.aspx");
    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        int result = _SaveUpdate();
        if (result > 0)
        {
            int res = objAppAdmin.TansferResponsibilityClass(Convert.ToInt32(Request.QueryString["oldAdmin"]), result);
            //objAppAdmin.DeleteCityAdmin(Convert.ToInt32(Request.QueryString["oldAdmin"]));

            Helper.ClearInputs(this.Controls);
            hdn_ClassAdminId.Value = "0";

            Response.Redirect("CityAdmin.aspx?Ref=Transfer");
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
        BCSchoolAdmin objSchoolAdmnin = new BCSchoolAdmin();
        objUser.UserId = Convert.ToInt32(hdn_ClassAdminId.Value);
        objUser.FirstName = txt_FirstName.Text;
        objUser.LastName = txt_LastName.Text;
        objUser.Address = txtAddress.Text;
        objUser.Email = txtEmail.Text;
        objUser.Password = txtPassword.Text;
        return objSchoolAdmnin.InsertUpdateClassAdmin(objUser);
        //objUser.ClassId = Convert.ToInt16(ddl_Class.SelectedValue);
        //objAppAdmin.InsertUpdateCityAdmin(objUser);
    }
    BCSchoolAdmin objSchoolAdmin = new BCSchoolAdmin();
    protected void btnSetDefault_Click(object sender, EventArgs e)
    {
        try
        {
            objSchoolAdmin.DeleteClassAdmin(Convert.ToInt32(Request.QueryString["oldAdmin"]), Convert.ToInt32(Session["UserId"]));
            string msg = (string)GetLocalResourceObject("ClassAdminTransferred");
            ClientScript.RegisterStartupScript(Page.GetType(), "script", msg, true);

            objAppAdmin.TansferResponsibilityToDefaultClassAdmin(Convert.ToInt32(Request.QueryString["oldAdmin"]));
            
            Response.Redirect("ClassAdmin.aspx?Ref=Transfer");
        }
        catch (Exception)
        {
            throw;
        }
    }
}