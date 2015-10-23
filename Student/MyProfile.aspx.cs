using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Student_MyProfile : System.Web.UI.Page
{
    DOLUser objUser = new DOLUser();
    BCSchoolAdmin objSchoolAdmin = new BCSchoolAdmin();
    BCStudent objStudent = new BCStudent();

    protected void Page_Load(object sender, EventArgs e)
    {
            try
            {
                if (Session["UserId"] == null)
                    Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

                if(!IsPostBack){
                pnl_MyProfile.Visible = true;
                DataTable dtCityAdmin = objStudent.GetMyProfileInfo(Convert.ToInt32(Session["UserId"].ToString()));

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

                    txtEmail.Text = dtCityAdmin.Rows[0]["Email"].ToString();
                }
                 
                }
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }

    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("HtmlForum.aspx");
    }

    protected void btn_Update_Click(object sender, EventArgs e)
    {
        try
        {
            //int result = _SaveUpdate();
            //if (result > 0)
            //{
            //    //Record saved successfully
            //    string popupScript = "";
            //    if (hdn_MyProfileId.Value == "0")
            //        popupScript = "alert('Student saved successfully.');";
            //    else
            //        popupScript = "alert('Profile updated successfully.');";

            //    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);

            //}
            //else if (result == 0)
            //{
            //    //Record already exists
            //    string popupScript = "alert('Student already exists.');";
            //    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            //    txtEmail.Focus();
            //}
        }
        catch { }
    }
    private int _SaveUpdate()
    {
        //objUser.UserId = Convert.ToInt32(Session["UserId"].ToString());
        //objUser.FirstName = txt_FirstName.Text;
        //objUser.LastName = txt_LastName.Text;
        //objUser.Email = txtEmail.Text;
        //objUser.Password = "";
        //objUser.CityId = Convert.ToInt16(hdn_CityID.Value);
        //objUser.SchoolId = Convert.ToInt16(hdn_SchoolID.Value);
        //objUser.ClassId = Convert.ToInt16(hdn_ClassID.Value);
        
        //return objStudent.InsertStudent(objUser);
        return 0;
    }
}