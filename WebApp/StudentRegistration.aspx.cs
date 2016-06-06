using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

public partial class StudentRegistration : System.Web.UI.Page
{
    BCStudent objStudent = new BCStudent();
    DOLUser objUser = new DOLUser();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            try
            {
                pnlAddNew.Visible = true;
                hdnStudentId.Value = "0";
                ddlCity.DataBind();
                ddlCity.Items.Insert(0, new ListItem("Stadt", "0"));
            }
            catch (Exception)
            {}
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (lblDuplicateUsername.Visible)
        {
            lblDuplicateUsername.Visible = false;
            return;
        }
        int result = _SaveUpdate();
        if (result > 0)
        {
            ////Record saved successfully
            //string popupScript = "";
            //if (hdnStudentId.Value == "0")
            //    popupScript = "alert('Registration Complete.');";
            //else
            //    popupScript = "alert('Student updated successfully.');";

            //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            pnlAddNew.Visible = false;
            pnlMessage.Visible = true;
        }
        else if (result == 0)
        {
            //Record already exists
            string popupScript = "alert('Student already exists.');";
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
        Helper.ClearInputs(this.Controls);
        hdnStudentId.Value = "0";
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Helper.ClearInputs(this.Controls);
        Response.Redirect("Login.aspx");
    }

    private int _SaveUpdate()
    {
        objUser.UserId = Convert.ToInt32(hdnStudentId.Value);
        objUser.FirstName = txtFirstName.Text;
        objUser.LastName = txtLastName.Text;
        objUser.Password = txtPassword.Text;
        objUser.Email = txtEmail.Text;
        objUser.CityId = Convert.ToInt32(ddlCity.SelectedValue);
        objUser.SchoolId = Convert.ToInt32(ddlSchool.SelectedValue);
        objUser.ClassId = Convert.ToInt32(ddlClass.SelectedValue);
        objUser.UserName = txtUsername.Text.Trim();

        int res = objStudent.InsertStudent(objUser);
        if (res > 0)
        {
            DataTable studInfo = objStudent.GetMyProfileInfo(res);
            if (studInfo.Rows.Count > 0)
            {
                try
                {
                    string ClassAdminEmail = studInfo.Rows[0]["ClassAdminEmail"].ToString();
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<p>Dear " + studInfo.Rows[0]["ClassAdminName"].ToString() + ",</p>");
                    sb.Append("<p>New registration in your Class: <b>" + studInfo.Rows[0]["Class"].ToString() + "</b><p>");
                    sb.Append("<p>Student Name: " + txtFirstName.Text + " " + txtLastName.Text + " ,</p>");
                    sb.Append("<p>School Name: " + studInfo.Rows[0]["School"].ToString() + "</p>");
                    Helper.sendMail("BikeTour - New Student Registration", ClassAdminEmail, sb.ToString());
                }
                catch (Exception ex)
                {

                }
            }
        }

        return res;
    }
    protected void txtUsername_TextChanged(object sender, EventArgs e)
    {
        if (objStudent.IsDuplicateUsername(txtUsername.Text, 0))
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
}