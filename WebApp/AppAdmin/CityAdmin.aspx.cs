using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;

public partial class AppAdmin_CityAdmin : System.Web.UI.Page
{
    DOLUser objUser = new DOLUser();
    BCAppAdmin objAppAdmin = new BCAppAdmin();
    DataTable dt = new DataTable();

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null)
                Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

            if (!IsPostBack)
            {
                ddcb_City.DataBind();
                ddl_SearchCity.DataBind();
                ddl_SearchCity.Items.Insert(0, new ListItem((string)GetLocalResourceObject("MsgSelectCity"), "0"));//Select City
            }

            //City admin add/update message
            string result = "";
            string popupScript = "";
            if (Request.Cookies["CityAdmin"] != null)
            {
                result = Request.Cookies["CityAdmin"].Value;
                if (result == "Saved")
                {
                    popupScript = "alert('" + (string)GetLocalResourceObject("MsgCityAdminSave") + "');";//City admin saved successfully.
                }
                else if (result == "Updated")
                {
                    popupScript = "alert('" + (string)GetLocalResourceObject("MsgCityAdminUpdate") + "');";//City admin updated successfully.
                }
                if (popupScript != "")
                {
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                }

                HttpCookie ce = Request.Cookies["CityAdmin"];
                ce.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(ce);
            }
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "City Admin Load");
        }
    }

    protected void btn_AddNew_Click(object sender, EventArgs e)
    {
        btn_Save.Text = "Speichern";
        foreach (ListItem item in ddcb_City.Items)
        {
            item.Selected = false;
        }
        hdn_CityAdminId.Value = "0";
        pnl_AdminList.Visible = false;
        pnl_AddAdmin.Visible = true;
        rfvConfirmPassword.Enabled = true;
        rfvPassword.Enabled = true;
        tr_password.Visible = true;
        tr_Conpassword.Visible = true;
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {

        int result = _SaveUpdate();
        if (result > 0)
        {
            int res = _SaveMapping(result);
            //Record saved successfully
            HttpCookie ce = new HttpCookie("CityAdmin");
            if (hdn_CityAdminId.Value == "0")
                ce.Value = "Speichern";
            else
                ce.Value = "Aktualisiert";

            Response.Cookies.Add(ce);

            Helper.ClearInputs(this.Controls);
            hdn_CityAdminId.Value = "0";

            Response.Redirect("CityAdmin.aspx");
            //pnl_AdminList.Visible = true;
            //pnl_AddAdmin.Visible = false;
            //grd_CityAdminList.DataBind();
            //_Bind();
        }
        else if (result == 0)
        {
            //Record already exists
            string popupScript = "alert('" + (string)GetLocalResourceObject("MsgCityAdminExist") + "');";//City admin already exists.
            ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            txtEmail.Focus();
        }

    }

    private int _SaveMapping(int CityAdminId)
    {

        int del = DataAccessLayer.ExecuteNonQuery("Delete from CityAdminCities Where CityAdminId=" + CityAdminId + " ");

        foreach (ListItem item in ddcb_City.Items)
        {
            if (item.Selected)
            {
                int CityId = Convert.ToInt32(item.Value);
                int res = objAppAdmin.SaveCityAdminMapping(CityAdminId, CityId);
            }
        }
        return 0;
    }

    private int _SaveUpdate()
    {
        objUser.UserId = Convert.ToInt32(hdn_CityAdminId.Value);
        objUser.FirstName = txt_FirstName.Text;
        objUser.LastName = txt_LastName.Text;
        objUser.Address = txtAddress.Text;
        objUser.Email = txtEmail.Text;
        objUser.Password = txtPassword.Text;
        // objUser.CityId = Convert.ToInt16(ddl_City.SelectedValue);
        objUser.CityId = 0;

        return objAppAdmin.InsertUpdateCityAdmin(objUser);
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        //Helper.ClearInputs(this.Controls);
        //hdn_CityAdminId.Value = "0";
        //pnl_AdminList.Visible = true;
        //pnl_AddAdmin.Visible = false;
        Response.Redirect("CityAdmin.aspx");
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                ddcb_City.DataBind();
                foreach (ListItem item in ddcb_City.Items)
                {
                    item.Selected = false;
                }

                hdn_CityAdminId.Value = ((Button)sender).CommandArgument.ToString();
                ddcb_City.DataBind();

                DataTable dtCityAdmin = objAppAdmin.GetCityAdminInfo(Convert.ToInt32(hdn_CityAdminId.Value));
                if (dtCityAdmin.Rows.Count > 0)
                {
                    DataTable dtCities = new DataTable();
                    dtCities = objAppAdmin.GetCityAdminMapping(Convert.ToInt32(hdn_CityAdminId.Value));

                    foreach (ListItem item in ddcb_City.Items)
                    {
                        var x = from row in dtCities.Select()
                                where row["CityId"].ToString() == item.Value.ToString()
                                select row;

                        if (x.Count() > 0)
                        {
                            if (((DataRow)x.First())["CityId"].ToString() == item.Value.ToString())
                                item.Selected = true;
                        }
                    }

                    //ddl_City.SelectedValue = dtCityAdmin.Rows[0]["CityId"].ToString();
                    txtAddress.Text = dtCityAdmin.Rows[0]["Address"].ToString();
                    txtEmail.Text = dtCityAdmin.Rows[0]["Email"].ToString();
                    txt_FirstName.Text = dtCityAdmin.Rows[0]["FirstName"].ToString();
                    txt_LastName.Text = dtCityAdmin.Rows[0]["LastName"].ToString();
                    //txtConfirmPassword.Text = _dt.Rows[0]["Password"].ToString();
                    //txtPassword.Text = _dt.Rows[0]["Password"].ToString();
                    tr_password.Visible = false;
                    tr_Conpassword.Visible = false;

                    pnl_AddAdmin.Visible = true;
                    pnl_AdminList.Visible = false;
                    btn_Save.Text = "Aktualisiert";
                    rfvConfirmPassword.Enabled = false;
                    rfvPassword.Enabled = false;

                }
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    protected void btnDelete_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                //objAppAdmin.DeleteCityAdmin(Convert.ToInt32(hdn_CityAdminId.Value));
                //string popupScript = "alert('City admin deleted successfully.');";
                //ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                //grd_CityAdminList.DataBind();
                Response.Redirect("TransferResponsibility.aspx?oldAdmin=" + hdn_CityAdminId.Value.ToString() + "");
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        //grd_CityAdminList.DataBind();
        _Bind();
    }

    protected void btn_SearchCancel_Click(object sender, EventArgs e)
    {
        txt_SearchName.Text = "";
        ddl_SearchCity.SelectedIndex = 0;
        //grd_CityAdminList.DataBind();
        _Bind();
    }
    protected void grd_CityAdminList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header)
        {
            if (this.ViewState["SortExp"] != null)
            {
                Image ImgSort = new Image();
                if (this.ViewState["SortOrder"].ToString() == "ASC")
                    ImgSort.ImageUrl = "~/_images/ArrowDown.png";
                else
                    ImgSort.ImageUrl = "~/_images/ArrowUp.png";

                switch (this.ViewState["SortExp"].ToString())
                {
                    case "uName":
                        PlaceHolder placeholderuName = (PlaceHolder)e.Row.FindControl("phtgrduName");
                        placeholderuName.Controls.Add(ImgSort);
                        break;
                    case "Email":
                        PlaceHolder placeholderEmail = (PlaceHolder)e.Row.FindControl("phtgrdEmail");
                        placeholderEmail.Controls.Add(ImgSort);
                        break;
                    case "Address":
                        PlaceHolder placeholderAddress = (PlaceHolder)e.Row.FindControl("phtgrdAddress");
                        placeholderAddress.Controls.Add(ImgSort);
                        break;
                    case "Cities":
                        PlaceHolder placeholderCities = (PlaceHolder)e.Row.FindControl("phtgrdCities");
                        placeholderCities.Controls.Add(ImgSort);
                        break;
                }
            }

        }
    }
    protected void grd_CityAdminList_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.ToLower().Equals("sort"))
        {
            if (this.ViewState["SortExp"] == null)
            {
                this.ViewState["SortExp"] = e.CommandArgument.ToString();
                this.ViewState["SortOrder"] = "ASC";
            }
            else
            {
                if (this.ViewState["SortExp"].ToString() == e.CommandArgument.ToString())
                {
                    if (this.ViewState["SortOrder"].ToString() == "ASC")
                        this.ViewState["SortOrder"] = "DESC";
                    else
                        this.ViewState["SortOrder"] = "ASC";
                }
                else
                {
                    this.ViewState["SortOrder"] = "ASC";
                    this.ViewState["SortExp"] = e.CommandArgument.ToString();
                }
            }

            _Bind();
        }

    }
    protected void grd_CityAdminList_Sorting(object sender, GridViewSortEventArgs e)
    {
        string s = e.SortExpression.ToString();
        string s2 = e.SortDirection.ToString();
    }

    private void _Bind()
    {
        try
        {
            if (grd_CityAdminList.DataSourceID.Length >= 1)
                grd_CityAdminList.DataSourceID.Remove(0, grd_CityAdminList.DataSourceID.Length);

            objAppAdmin.AdminName = txt_SearchName.Text;
            objAppAdmin.CityId = Convert.ToInt32(ddl_SearchCity.SelectedValue);

            dt = objAppAdmin.GetAllAdminDetails(objAppAdmin);


            grd_CityAdminList.DataSourceID = "";

            if (dt == null || dt.Rows.Count == 0)
            {
                dt = _CreateEmptyTable();
            }

            DataView dv = dt.DefaultView;
            if (this.ViewState["SortExp"] == null)
            {
                //this.ViewState["SortExp"] = "make";
                //this.ViewState["SortOrder"] = "ASC";
            }
            else
            {
                dv.Sort = this.ViewState["SortExp"] + " " + this.ViewState["SortOrder"];
            }

            grd_CityAdminList.DataSource = dv;
            grd_CityAdminList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "CityAdmin/_Bind()");
        }

    }
    private DataTable _CreateEmptyTable()
    {
        DataTable dt = new DataTable();
        dt.Columns.Add("Name");
        dt.Columns.Add("Email");
        dt.Columns.Add("Address");
        dt.Columns.Add("Cities");
        dt.Columns.Add("Edit");

        DataRow lRow = dt.NewRow();
        dt.AcceptChanges();
        return dt;
    }


    protected void btnDeleteCityAdmin_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
                //objAppAdmin.DeleteCityAdmin(Convert.ToInt32(hdn_CityAdminId.Value), Convert.ToInt32(Session["UserId"]));

                string popupScript = "alert('City admin deleted successfully.');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                grd_CityAdminList.DataBind();
                Response.Redirect("TransferResponsibility.aspx?oldAdmin=" + hdn_CityAdminId.Value.ToString() + "");
            }
            catch (Exception ex)
            {

                Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }
}