using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.IO;

public partial class AppAdmin_ImageLinkMaster : System.Web.UI.Page
{
    BCImageLink objImageLink = new BCImageLink();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserId"] == null)
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
             hdnLinkId.Value = "0";
             grdImageLink.DataBind();
        }
    }
    
    protected void lbtnAddLink_Click(object sender, EventArgs e)
    {

    }

    protected void btnAddNew_Click(object sender, EventArgs e)
    {
        pnlAddLink.Visible = true;
        pnlLinkList.Visible = false;
        lnkAddLink.Visible = false;
        Helper.ClearInputs(this.Controls);
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        _SaveUpdate();
        pnlAddLink.Visible = false;
        pnlLinkList.Visible = true;
        grdImageLink.DataBind();
        Response.Redirect(Request.RawUrl);
    }

    private int _SaveUpdate()
    {
        int result = 0;
        string fileName = "";
        string fileExt = "";
        string newFileName = "";
        if (hdnLinkId.Value == "0")
            objImageLink.Action = "INSERT";
        else
            objImageLink.Action = "UPDATE";
        objImageLink.ImageLinkId = Convert.ToInt32(hdnLinkId.Value);
        
        if (txtImageLink.Text.Contains("http"))
        {
            objImageLink.ImageLink = txtImageLink.Text;
        }
        else
        {
            objImageLink.ImageLink = "http://" + txtImageLink.Text;
        }

        objImageLink.ImageText = txtImageText.Text;
        if (objImageLink.Action == "UPDATE")
        {
            if (fuImage.HasFile)
            {
                fileName = Path.GetFileNameWithoutExtension(fuImage.PostedFile.FileName);
                fileExt = Path.GetExtension(fuImage.PostedFile.FileName);
                string TimeStamp = DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() +
                    DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + "";
                newFileName = fileName + "_" + TimeStamp + fileExt;
                fuImage.SaveAs(Server.MapPath("../LinkImages/" + newFileName));
                objImageLink.ImageName = newFileName;
            }
            else
            {
                objImageLink.ImageName = hdnImageName.Value;
            }
        }
        else
        {
            if (fuImage.HasFile)
            {
                fileName = Path.GetFileNameWithoutExtension(fuImage.PostedFile.FileName);
                fileExt = Path.GetExtension(fuImage.PostedFile.FileName);
                string TimeStamp = DateTime.Now.Day.ToString() + DateTime.Now.Month.ToString() + DateTime.Now.Year.ToString() +
                    DateTime.Now.Hour.ToString() + DateTime.Now.Minute.ToString() + DateTime.Now.Second.ToString() + "";
                newFileName = fileName + "_" + TimeStamp + fileExt;
                fuImage.SaveAs(Server.MapPath("../LinkImages/" + newFileName));
                objImageLink.ImageName = newFileName;
            }
        }

        result = objImageLink.MaageImageLink(objImageLink);
        if (hdnLinkId.Value == "0")
        {
            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgLinkAdd") + "');";//Image Link Added successfully!
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
        else
        {
            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgLinkUpdate") + "');";//Image Link Updated successfully!'
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
        }
        return result;
        //if
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        pnlAddLink.Visible = false;
        pnlLinkList.Visible = true;
        Helper.ClearInputs(this.Controls);
        Response.Redirect(Request.RawUrl);
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        imgImage.Visible = true;
        lblCurrentImage.Visible = true;
        rfvImage.Enabled = false;
        hdnLinkId.Value = ((Button)sender).CommandArgument.ToString();
        pnlAddLink.Visible = true;
        pnlLinkList.Visible = false;
        btnSave.Text = (string)GetLocalResourceObject("Update"); //"Update";
        objImageLink.ImageLinkId = Convert.ToInt32(hdnLinkId.Value);
        objImageLink = objImageLink.GetImageLink(objImageLink);

        txtImageLink.Text = objImageLink.ImageLink;
        txtImageText.Text = objImageLink.ImageText;
        hdnImageName.Value = objImageLink.ImageName;
        imgImage.ImageUrl = "../LinkImages/" + hdnImageName.Value;
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        objImageLink.ImageLinkId = Convert.ToInt32(hdnDeleteId.Value);
        objImageLink.Action = "DELETE";
        objImageLink.MaageImageLink(objImageLink);
        grdImageLink.DataBind();
    }

    protected void btnSearchCancel_Click(object sender, EventArgs e)
    {
        Helper.ClearInputs(this.Controls);
        grdImageLink.DataBind();
    }

    protected void grdImageLink_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        grdImageLink.PageIndex = e.NewPageIndex;
        grdImageLink.DataBind();
    }
}