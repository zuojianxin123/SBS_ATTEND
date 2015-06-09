using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class SBSLogin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["permission"] != null)
        {
            int pm = (int)Session["permission"];
            switch (pm)
            {
                case 0:
                    Response.Redirect("~/staff.aspx");        //员工
                    break;
                case 1:
                    Response.Redirect("~/admin.aspx");        //领导
                    break;
            }
        }
    }
    protected void btn_login_Click(object sender, EventArgs e)
    {
        string usrname = tb_name.Text;
        string pwd = tb_pwd.Text;

        workDBDataContext db = new workDBDataContext();
      
        var query = from a in db.permission
                    where (a.pwd == pwd && a.userid == usrname)
                    select a;

        if (query.Count() != 1)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('登录失败!');location.href='Default.aspx'", true);
        }
        else
        {
            int pm = (int)query.First().permission1;
            Session["permission"] = pm;
            Session["name"] = query.First().username;

            switch (pm)
            {
                case 0:
                    Response.Redirect("~/staff.aspx");        //员工
                    break;
                case 1:
                    Response.Redirect("~/admin.aspx");        //领导
                    break;
                default:
                    Response.Write("<script>alert('登录失败!');location.href='Default.aspx'</script>");           //非法员工
                    break;
            }
        }
    }
    protected void btn_quit_Click(object sender, EventArgs e)
    {
        Session["permission"] = null;
        Session["name"] = null;
        Response.Redirect("~/Default.aspx");
    }
}