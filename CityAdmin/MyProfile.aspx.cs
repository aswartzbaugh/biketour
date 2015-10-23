using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class AppAdmin_MyProfile : System.Web.UI.Page
{
    BCCityAdmin objCityAdmin = new BCCityAdmin();
    DOLUser objUser = new DOLUser();
    BCStudent objStudent = new BCStudent();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());
        if (!IsPostBack)
        {
            ProfileContent();
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

                dlstCity.DataSource = null;
                dlstCity.DataBind();
                dlstCity.Visible = true;
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                ProfileContent();
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
                txtEmail.Focus();
            }
        }
    }

    private int _SaveUpdate()
    {
        objUser.UserId = Convert.ToInt32(Session["UserId"].ToString());
        objUser.FirstName = txt_FirstName.Text;
        objUser.LastName = txt_LastName.Text;
        objUser.Email = txtEmail.Text;
        objUser.Address = txtAddress.Text;
        objUser.Password = "";

        return objStudent.InsertUpdateStudent(objUser);
    }
    private void ProfileContent()
    {
            DataSet ds = objCityAdmin.GetMyProfileContent(Convert.ToInt32(Session["UserId"].ToString()));
            if (ds != null && ds.Tables.Count > 0)
            {
                if (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0)
                {
                    txt_FirstName.Text = ds.Tables[0].Rows[0]["FirstName"].ToString();
                    txt_LastName.Text = ds.Tables[0].Rows[0]["LastName"].ToString();
                    txtAddress.Text = ds.Tables[0].Rows[0]["Address"].ToString();
                    txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();

                }
                if (ds.Tables[1] != null && ds.Tables[1].Rows.Count > 0)
                {
                    dlstCity.DataSource = ds.Tables[1];
                    dlstCity.DataBind();
                }
            }
        
    }
}