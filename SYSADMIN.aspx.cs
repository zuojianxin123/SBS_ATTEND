using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SYSADMIN : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        if (Session["name"] != null)
            HttpContext.Current.Response.Redirect("~/Admin.aspx");
        else
            HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
    }
}