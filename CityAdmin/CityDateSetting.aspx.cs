using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AppAdmin_CityDateSetting : System.Web.UI.Page
{
    BCCityAdmin objCityAdmin = new BCCityAdmin();
    

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());
        if (!IsPostBack)
        {
            //ProfileContent();
        }
    }
    
    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Helper.ClearInputs(this.Controls);
        Response.Redirect("~/ControlPanel/Home.aspx");
       
    }
    protected void btn_Save_Click(object sender, EventArgs e)
    {
        {
            int result = _SaveUpdate();
            if (result > 0)
            {
                //Record saved successfully
                string popupScript = "";
                if (hdn_MyProfileId.Value == "0")
                    popupScript = "alert('" + (string)GetLocalResourceObject("InfoSaved") + "');";
                else
                    popupScript = "alert('" + (string)GetLocalResourceObject("ProfileUpdated") + "');";

                //dlstCity.DataSource = null;
                //dlstCity.DataBind();
                //dlstCity.Visible = true;
                //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //ProfileContent();
                //Helper.ClearInputs(this.Controls);
                //hdn_MyProfileId.Value = "0";
                //Helper.ClearInputs(this.Controls);
                //Response.Redirect("~/CityAdmin/SchoolAdmin.aspx");
            }
            else if (result == 0)
            {
                //Record already exists
                string popupScript = "alert('" + (string)GetLocalResourceObject("AlreadyExists") + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                
            }
        }
    }

    private int _SaveUpdate()
    {
        return 0;
        //objUser.UserId = Convert.ToInt32(Session["UserId"].ToString());
        //objUser.FirstName = txt_FirstName.Text;
        //objUser.LastName = txt_LastName.Text;
        //objUser.Email = txtEmail.Text;
        //objUser.Address = txtAddress.Text;
        //objUser.Password = "";

        //return objStudent.InsertUpdateStudent(objUser);
    }
   
}