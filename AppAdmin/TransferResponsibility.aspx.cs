using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AppAdmin_TransferResponsibility : System.Web.UI.Page
{
    DOLUser objUser = new DOLUser();
    BCAppAdmin objCityAdmin = new BCAppAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

    }
    protected void btn_SaveAdmin_Click(object sender, EventArgs e)
    {
        int result = Convert.ToInt32(ddl_CityAdmins.SelectedValue);
        if (result > 0)
        {
            int res = objCityAdmin.TansferResponsibility(Convert.ToInt32(Request.QueryString["oldAdmin"]), result);
            objCityAdmin.DeleteCityAdmin(Convert.ToInt32(Request.QueryString["oldAdmin"]));

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
            int res = objCityAdmin.TansferResponsibility(Convert.ToInt32(Request.QueryString["oldAdmin"]), result);
            objCityAdmin.DeleteCityAdmin(Convert.ToInt32(Request.QueryString["oldAdmin"]));

            Helper.ClearInputs(this.Controls);
            hdn_ClassAdminId.Value = "0";

            Response.Redirect("CityAdmin.aspx?Ref=Transfer");
        }
        else if (result == 0)
        {
            //Record already exists
            string popupScript = "alert('City admin already exists.');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            txtEmail.Focus();
        }
    }
    private int _SaveUpdate()
    {
        objUser.UserId = Convert.ToInt32(hdn_ClassAdminId.Value);
        objUser.FirstName = txt_FirstName.Text;
        objUser.LastName = txt_LastName.Text;
        objUser.Address = txtAddress.Text;
        objUser.Email = txtEmail.Text;
        objUser.Password = txtPassword.Text;
        //objUser.ClassId = Convert.ToInt16(ddl_Class.SelectedValue);
        return objCityAdmin.InsertUpdateCityAdmin(objUser);
    }

}