using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;

public partial class CityAdmin_TransferResponsibility : System.Web.UI.Page
{

    DOLUser objUser = new DOLUser();
    BCSchoolAdmin objSchoolAdmin = new BCSchoolAdmin();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null)
                Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

            if (Request.QueryString["oldAdmin"] != null)
            {
                if (Request.QueryString["oldAdmin"].ToString() != "") { }
                else { Response.Redirect("ClassAdmin.aspx"); }
            }
            else { Response.Redirect("ClassAdmin.aspx"); }
        }
        catch (Exception ex) { Response.Redirect("ClassAdmin.aspx"); }
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
        int result = _SaveUpdate();
        if (result > 0)
        {
            int res= objSchoolAdmin.TansferResponsibility(Convert.ToInt32(Request.QueryString["oldAdmin"]), result);
            objSchoolAdmin.DeleteClassAdmin(Convert.ToInt32(Request.QueryString["oldAdmin"]));
            
            Helper.ClearInputs(this.Controls);
            hdn_ClassAdminId.Value = "0";

            Response.Redirect("ClassAdmin.aspx?Ref=Transfer");
        }
        else if (result == 0)
        {
            //Record already exists
            string popupScript = "alert('Class admin already exists.');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            txtEmail.Focus();
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("ClassAdmin.aspx");
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
        return objSchoolAdmin.InsertUpdateClassAdmin(objUser);
    }

    protected void btn_SaveAdmin_Click(object sender, EventArgs e)
    {
        int result = Convert.ToInt32(ddl_ClassAdmins.SelectedValue);
        if (result > 0)
        {
            int res = objSchoolAdmin.TansferResponsibility(Convert.ToInt32(Request.QueryString["oldAdmin"]), result);
            objSchoolAdmin.DeleteClassAdmin(Convert.ToInt32(Request.QueryString["oldAdmin"]));

            Helper.ClearInputs(this.Controls);
            hdn_ClassAdminId.Value = "0";

            Response.Redirect("ClassAdmin.aspx?Ref=Transfer");
        }
    }
}