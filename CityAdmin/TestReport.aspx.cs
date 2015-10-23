using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ClassAdmin_TestReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null)
                Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

            if (!IsPostBack)
            {
                if (Session["SchoolId"] != null && Session["ClassId"] != null)   
                {
                    ddlSchool.SelectedValue = Session["SchoolId"].ToString();
                    ddlSchool.DataTextField = "School";
                    ddlSchool.DataValueField = "SchoolId";
                    ddlSchool.DataBind();
                    ddlClass.SelectedValue = Session["ClassId"].ToString();
                    ddlClass.DataTextField = "Class";
                    ddlClass.DataValueField = "classid";
                    ddlClass.DataBind();
                    ddlClass_SelectedIndexChanged(sender, e);
                    if (Session["StageLeg"] != null)
                    {
                        ddl_Stage.SelectedValue = Session["StageLeg"].ToString();
                        ddl_Stage.DataTextField = "StageLeg";
                        ddl_Stage.DataValueField = "tocityid";
                        ddl_Stage.DataBind();
                        ddl_Stage_SelectedIndexChanged(sender, e);
                    }
                }

               
            }
        }
        catch (Exception)
        { }
    }

    protected void ddlSchool_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void ddl_Stage_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddl_Stage.SelectedIndex != 0)
            {
                Session["SchoolId"] = ddlSchool.SelectedValue;
                Session["ClassId"] = ddlClass.SelectedValue;
                Session["StageLeg"] = ddl_Stage.SelectedValue;
            }
        }
        catch (Exception ex)
        { }
    }
}