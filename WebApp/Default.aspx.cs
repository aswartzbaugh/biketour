﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default : System.Web.UI.Page
{
    BCAppAdmin bcadmin = new BCAppAdmin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Request.Cookies["selectedCity"] != null)
            {
                ddlCity.SelectedValue = Request.Cookies["selectedCity"].Value;
                GetData(Request.Cookies["selectedCity"].Value.ToString());
            } else
            {
                GetData("0");
            }
        }
    }

    public void GetData(String Id)
    {
        DataTable dt = new DataTable();
        dt = bcadmin.HighScore(Convert.ToInt32(Id));
        if (dt!=null &&
            dt.Rows.Count > 0)
        {
            //lblmsg.Visible = false;
            dlsore.DataSource = dt;
            dlsore.DataBind();
        }
        else
        {
            dlsore.DataSource = null;
            dlsore.DataBind();
        //    lblmsg.Visible = true;
          //  lblmsg.Text = "No High Score For This City";
        }
       



    }

    protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
    {
        Response.Cookies["selectedCity"].Value = ddlCity.SelectedValue;
        this.GetData(ddlCity.SelectedValue);
    }

  }