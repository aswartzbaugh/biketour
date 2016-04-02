using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using AjaxControlToolkit.HTMLEditor;

public partial class FAQ : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null)
                Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

            if (!IsPostBack)
            {
                _BindFAQ();
            }
            //  this.MaintainScrollPositionOnPostBack = true;
        }
        catch (Exception)
        { }
    }

    private void _BindFAQ()
    {
        try
        {
            sdsForum.SelectParameters.Clear();
            sdsForum.SelectCommandType = SqlDataSourceCommandType.Text;
            sdsForum.SelectCommand = "Select * FrOM FAQ WHERE ISActive=1";
            grd_FAQList.DataSourceID = "sdsForum";
            grd_FAQList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Bind Blog");
        }
    }

    protected void grd_FAQList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grd_FAQList.PageIndex = e.NewPageIndex;
            _BindFAQ();
        }
        catch (Exception)
        { }
    }
    protected void btnEditFAQ_Click(object sender, EventArgs e)
    {
        try
        {
            int FAQId = Convert.ToInt32(((Button)sender).CommandArgument.ToString());
            hdnFAQId.Value = FAQId.ToString();
            if (grd_FAQList.Rows.Count > 0)
            {
                foreach (GridViewRow rw in grd_FAQList.Rows)
                {
                    Label lblFAQId = rw.FindControl("lbl_FAQId") as Label;
                    if (FAQId == Convert.ToInt32(lblFAQId.Text))
                    {
                        Label lblFQAAnswer = rw.FindControl("lbl_FQAAnswer") as Label;
                        Label lblFQAQuestion = rw.FindControl("lbl_FQAQuestion") as Label;

                        txtAnswer.Text = lblFQAAnswer.Text;
                        txtQuestion.Text = lblFQAQuestion.Text;

                        return;
                    }

                }
            }
            //Response.Redirect("StudentDetails.aspx?StudentId=" + StudentID.ToString());
        }
        catch (Exception ex)
        {
            //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            if (!string.IsNullOrEmpty(txtQuestion.Text.Trim()) &&
                !string.IsNullOrEmpty(txtAnswer.Text.Trim()))
            {
                BCAppAdmin appAdmin = new BCAppAdmin();
                if (string.IsNullOrEmpty(hdnFAQId.Value))
                {                    
                    appAdmin.InsertFAQ(txtQuestion.Text,
                        txtAnswer.Text, Convert.ToInt32(Session["UserId"]));
                }
                else
                {
                    appAdmin.UpdateFAQ(Convert.ToInt32(hdnFAQId.Value), txtQuestion.Text,
                        txtAnswer.Text);
                }
                hdnFAQId.Value = string.Empty;
                txtQuestion.Text = string.Empty;
                txtAnswer.Text = string.Empty;
                _BindFAQ();
            }
        }
        catch (Exception)
        {}
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                try
                {
                    BCAppAdmin appAdmin = new BCAppAdmin();
                    appAdmin.DeleteFAQ(Convert.ToInt32(hdnFAQId.Value));

                    string msg = (string)GetLocalResourceObject("FAQDeleted");
                    string popupScript = "alert('" + msg + "');";
                    ScriptManager.RegisterStartupScript(Page, this.GetType(), "script", popupScript, true);
                    _BindFAQ();                    

                }
                catch (Exception ex)
                {
                    Helper.Log(ex.Message, "Delete FAQ");
                    //errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
                }
            }
        }
        catch (Exception ex)
        { }

    }
}