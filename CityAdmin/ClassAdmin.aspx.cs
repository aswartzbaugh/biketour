using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;

public partial class ClassAdmin_ClassAdmin : System.Web.UI.Page
{
    DOLUser objUser = new DOLUser();
    BCSchoolAdmin objSchoolAdmin = new BCSchoolAdmin();

    public DataTable dtClasses
    {
        get
        {
            object o = this.ViewState["dtClasses"];
            return o as DataTable;
        }
        set { this.ViewState["dtClasses"] = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if(Session["UserId"] == null )
            Response.Redirect(System.Web.Security.FormsAuthentication.LoginUrl.ToString() + "?ReturnUrl=" + Request.RawUrl.ToString());

        if (!IsPostBack)
        {
            try
            {
                this.dtClasses = new DataTable();

                //ddl_School.DataBind();
                //ddl_School.Items.Insert(0, new ListItem("Select School", "0"));
            }
            catch (Exception)
            {}
        }

        try
        {
            if (Request.QueryString["Ref"] != null)
            {
                if (Request.QueryString["Ref"].ToString() == "Transfer")
                {
                    string popupScript = "alert('Responsibilities Tansfered Successfully!');";
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                }
            }
        }
        catch { }
    }

    protected void btn_AddNew_Click(object sender, EventArgs e)
    {
        try
        {
            btn_Save.Text = (string)GetLocalResourceObject("btn_Save.Text");
            btnAddClass.Text = (string)GetLocalResourceObject("ButtonAdd");
            hdn_ClassAdminId.Value = "0";
            pnl_AdminList.Visible = false;
            pnl_AddAdmin.Visible = true;
            rfvConfirmPassword.Enabled = true;
            rfvPassword.Enabled = true;
            tr_password.Visible = true;
            tr_Conpassword.Visible = true;
            ddlSchool.Enabled = true;
            Helper.RebindDropDown(ddlSchool);
            this.dtClasses = new DataTable();
            grdClasses.DataSource = null;
            grdClasses.DataBind();
           
          
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Add Class");        
        }
    }

    protected void btn_Save_Click(object sender, EventArgs e)
    {
       // bool Notselected = false;
        try
        {
            if (grdClasses.Rows.Count > 0)
            {
                _SaveclassAdmin();
               
            }
            else
            {
                string popupScript = "alert('" + (string)GetLocalResourceObject("NoClassPresent") + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
            }

        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Save ClassAdmin");
        }
    }

    private void _SaveclassAdmin()
    {
        try
        {
            int result = _SaveUpdate();
            if (result > 0)
            {
                //Record saved successfully
                _SaveUpdateMapping(result);

                string popupScript = "";
                if (hdn_ClassAdminId.Value == "0")
                    popupScript = "alert('" + (string)GetLocalResourceObject("ClassAdminSaved") + "');";
                else
                    popupScript = "alert('" + (string)GetLocalResourceObject("ClassAdminUpdated") + "');";

                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                Helper.ClearInputs(this.Controls);
                hdn_ClassAdminId.Value = "0";
                pnl_AdminList.Visible = true;
                pnl_AddAdmin.Visible = false;
                grd_ClassAdminList.DataBind();
            }
            else if (result == 0)
            {
                //Record already exists
                string popupScript = "alert('" + (string)GetLocalResourceObject("ClassAdminExists") + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                txtEmail.Focus();
            }
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Class admin");
        }
    }

    private int _SaveUpdate()
    {
        try
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
        catch (Exception)
        {  
           return objSchoolAdmin.InsertUpdateClassAdmin(objUser);
        }
    }

    protected void btn_Cancel_Click(object sender, EventArgs e)
    {
        try
        {
            Helper.ClearInputs(this.Controls);
            btnAddClass.Text = (string)GetLocalResourceObject("ButtonAdd");
            ddlSchool.Enabled = true;
            Helper.RebindDropDown(ddlSchool);
            hdn_ClassAdminId.Value = "0";
            pnl_AdminList.Visible = true;
            pnl_AddAdmin.Visible = false;
            this.dtClasses = new DataTable();
            grdClasses.DataSource = null;
            grd_ClassAdminList.DataBind();

           
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Cancel Class Admn Save ");
        }
       
    }

    protected void btnEdit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            try
            {
               // objSchoolAdmin.DeleteClassAdmin(Convert.ToInt32(hdn_ClassAdminId.Value));
                hdn_ClassAdminId.Value = ((Button)sender).CommandArgument.ToString();
                DataSet dsCityAdmin = objSchoolAdmin.GetClassAdminInfo(Convert.ToInt32(hdn_ClassAdminId.Value), Convert.ToInt32(Session["UserId"]));
                if (dsCityAdmin != null && dsCityAdmin.Tables.Count > 0)
                {
                    if (dsCityAdmin.Tables[0].Rows.Count > 0)
                    {
                        txtAddress.Text = dsCityAdmin.Tables[0].Rows[0]["Address"].ToString();
                        txtEmail.Text = dsCityAdmin.Tables[0].Rows[0]["Email"].ToString();
                        txt_FirstName.Text = dsCityAdmin.Tables[0].Rows[0]["FirstName"].ToString();
                        txt_LastName.Text = dsCityAdmin.Tables[0].Rows[0]["LastName"].ToString();
                        //txtConfirmPassword.Text = _dt.Rows[0]["Password"].ToString();
                        //txtPassword.Text = _dt.Rows[0]["Password"].ToString();

                    }

                    if (dsCityAdmin.Tables[1].Rows.Count > 0)
                    {
                        grdClasses.DataSource = dsCityAdmin.Tables[1];
                        grdClasses.DataBind();
                        this.dtClasses = dsCityAdmin.Tables[1];
                    }

                    tr_password.Visible = false;
                    tr_Conpassword.Visible = false;

                    pnl_AddAdmin.Visible = true;
                    pnl_AdminList.Visible = false;
                    btn_Save.Text = (string)GetLocalResourceObject("ButtonUpdate");
                    btnAddClass.Text = (string)GetLocalResourceObject("ButtonAdd");
                    ddlSchool.Enabled = true;
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
                objSchoolAdmin.DeleteClassAdmin(Convert.ToInt32(hdn_ClassAdminId.Value));
                string popupScript = "alert('" + (string)GetLocalResourceObject("ClassAdminDeleted") + "');";
                ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                grd_ClassAdminList.DataBind();

                //Response.Redirect("TransferResponsibility.aspx?oldAdmin=" + hdn_ClassAdminId.Value.ToString() + "");
            }
            catch (Exception ex)
            {
                //Helper.errorLog(ex, Server.MapPath(@"~/ImpTemp/Log.txt"));
            }
        }
    }

    private int _SaveUpdateMapping(int classAdminId)
    {
        int result = 0;
        try
        {
            objSchoolAdmin.DeleteAllSchoolsOfClassAdmin(Convert.ToInt32(classAdminId));
            foreach (GridViewRow lRow in grdClasses.Rows)
            {
                int schoolId = Convert.ToInt32(grdClasses.DataKeys[lRow.RowIndex]["SchoolId"].ToString());
                string classIdList = grdClasses.DataKeys[lRow.RowIndex]["ClassIds"].ToString();
                objSchoolAdmin.SaveClassAdminMapping(Convert.ToInt32(classAdminId), schoolId, classIdList);
            }

            return result;
        }
        catch (Exception ex)
        {
            return result;
        }
    }

    protected void btnAddClass_Click(object sender, EventArgs e)
    {
        try
        {
            if (this.dtClasses != null && this.dtClasses.Rows.Count > 0 && (btnAddClass.Text != "Update" || btnAddClass.Text != "aktualisieren"))
            {
                DataRow[] lRowSelect = dtClasses.Select("SchoolId=" + ddlSchool.SelectedValue);
                if (lRowSelect.Length > 0)
                {
                    ddlSchool.SelectedIndex = 0;
                    ddl_Class.DataBind();
                    string popupScript = "alert('" + (string)GetLocalResourceObject("ClassAlreadyAdded") + "');";
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                    return;
                }
            }

            DataTable dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[]{new DataColumn("SchoolId"), 
                                    new DataColumn("School"),new DataColumn("Classes"), new DataColumn("ClassIds")});
            if (dtClasses != null && dtClasses.Rows.Count > 0)
            //{
                dt = dtClasses;

                string classes = "", classIds = "";
                if (ddl_Class.Items.Count > 0)
                {
                    foreach (ListItem item in ddl_Class.Items)
                    {
                        if (item.Selected)
                        {
                            if (classes == "" && classIds == "")
                            {
                                classes = item.Text.Trim();
                                classIds = item.Value.Trim();
                            }
                            else
                            {
                                classes = item.Text.Trim() + "," + classes;
                                classIds = item.Value.Trim() + "," + classIds;
                            }
                        }

                    }


                    DataRow lRow = null;

                    if (btnAddClass.Text == "Add" || btnAddClass.Text == "hinzufügen")
                    {
                        lRow = dt.NewRow();
                        lRow["SchoolId"] = ddlSchool.SelectedValue;
                        lRow["School"] = ddlSchool.SelectedItem.Text;
                        lRow["Classes"] = classes;
                        lRow["ClassIds"] = classIds;
                        dt.Rows.Add(lRow);
                    }
                    else
                    {
                        lRow = dtClasses.Select("SchoolId=" + ddlSchool.SelectedValue)[0];
                        lRow["SchoolId"] = ddlSchool.SelectedValue;
                        lRow["School"] = ddlSchool.SelectedItem.Text;
                        lRow["Classes"] = classes;
                        lRow["ClassIds"] = classIds;
                    }

                    dt.AcceptChanges();
                    this.dtClasses = dt;
                    grdClasses.DataSource = dtClasses;
                    grdClasses.DataBind();
                    ddlSchool.SelectedIndex = 0;
                    ddl_Class.DataBind();
                    ddlSchool.Enabled = true;
                    btnAddClass.Text = (string)GetLocalResourceObject("ButtonAdd");
                }
                else
                {
                    string popupScript = "alert('" + (string)GetLocalResourceObject("NoClassPresent") + "');";
                    ClientScript.RegisterStartupScript(Page.GetType(), "script", popupScript, true);
                }

               
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Class Add in School");
        }
    }

    protected void btnDeleteClass_Click(object sender, EventArgs e)
    {

        
    }

    protected void btnEditClass_Click(object sender, EventArgs e)
    {

        try
        {
            Button btnEditClass = (sender as Button);
            int schoolId = Convert.ToInt32(btnEditClass.CommandArgument.Split('|')[0]);
            string classIds = btnEditClass.CommandArgument.Split('|')[1];

            ddlSchool.DataBind();
            ddlSchool.SelectedValue = schoolId.ToString();

            ddl_Class.DataBind();
            ddlSchool.Enabled = false;

            foreach (ListItem item in ddl_Class.Items)
            {
                foreach (string s in classIds.Split(','))
                {
                    if (item.Value == s.Trim())
                        item.Selected = true;
                }
            }

            btnAddClass.Text = (string)GetLocalResourceObject("ButtonUpdate");
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Update Class in School");
        }
    }
    protected void grd_ClassAdminList_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Label lblName = (Label)e.Row.FindControl("lblName");
                Label lblEmail = (Label)e.Row.FindControl("lblEmail");
                Label lblAddress = (Label)e.Row.FindControl("lblAddress");
                Button btn_Edit = (Button)e.Row.FindControl("btn_Edit");
                Button btn_Delete = (Button)e.Row.FindControl("btn_Delete");

                string strval = ((Label)(lblName)).Text;
                string name = (string)ViewState["name"];
                if (name == strval && e.Row.RowIndex != 0)
                {
                    lblName.Visible = false;
                    lblAddress.Visible = false;
                    btn_Edit.Visible = false;
                    btn_Delete.Visible = false;
                    lblEmail.Visible = false;
                    lblName.Text = string.Empty;
                }
                else
                {
                    name = strval;
                    ViewState["name"] = name;
                    lblName.Visible = true;
                    lblName.Text = "<b>" + name + "</b>";
                    lblAddress.Visible = true;
                    lblEmail.Visible = true;
                    btn_Edit.Visible = true;
                    btn_Delete.Visible = true;
                }
            }
        }
        catch (Exception)
        {}
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {
        try
        {
            grd_ClassAdminList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Search ");
        }
    }

    protected void btn_SearchCancel_Click(object sender, EventArgs e)
    {
        try
        {
            txt_SearchName.Text = "";
            ddl_School.SelectedIndex = 0;
            grd_ClassAdminList.DataBind();
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Search Cancel ");
        }
    }
    protected void btnClassDelete_Click(object sender, EventArgs e)
    {
        try
        {
            Button btnDeleteClass = (sender as Button);
            int schoolId = Convert.ToInt32(hdnSchoolId.Value);

            // delete from datatable

            DataRow lRowSelect = dtClasses.Select("SchoolId=" + schoolId)[0];
            if (lRowSelect != null)
                lRowSelect.Delete();
            grdClasses.DataSource = dtClasses;
            grdClasses.DataBind();

            //Delete from database
            objSchoolAdmin.DeleteSchoolOfClassAdmin(Convert.ToInt32(hdn_ClassAdminId.Value), schoolId);
        }
        catch (Exception ex)
        {
            Helper.Log(ex.Message, "Delete Class ");
        }
    }
    protected void grd_ClassAdminList_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grd_ClassAdminList.PageIndex = e.NewPageIndex;
            grd_ClassAdminList.DataBind();
        }
        catch (Exception)
        {}

    }
    protected void grdClasses_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            grdClasses.PageIndex = e.NewPageIndex;
            grdClasses.DataBind();
        }
        catch (Exception)
        {}
    }
    protected void grd_ClassAdminList_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void grd_ClassAdminList_Sorting(object sender, GridViewSortEventArgs e)
    {

    }
}