using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Commit : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["name"] == null)
            {
                HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
                return;
            }
            this.lb_name.Text = "欢迎 " + Session["name"] + " 同志登录！";
        }
    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        if(Session["name"] != null)
            HttpContext.Current.Response.Redirect("~/staff.aspx");
        else
            HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
    }
    protected void btleave_Click(object sender, EventArgs e)
    {
        workDBDataContext db = new workDBDataContext();
        workoff mywork = new workoff();

        if (Session["name"] == null)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('登录已过期');location.href='SBSLogin.aspx';",true);
            return;
        }
        mywork.name = Session["name"].ToString();
        mywork.starttime = DateTime.Parse(this.txtFrom.Text);
        mywork.originshift = this.drp_start.Text;
        mywork.originweek = convertdate(Convert.ToDateTime(this.txtFrom.Text).DayOfWeek.ToString());
        mywork.endtime = DateTime.Parse(this.txtTo.Text);
        mywork.currentshift = this.drp_end.Text;
        mywork.currentweek = convertdate(Convert.ToDateTime(this.txtTo.Text).DayOfWeek.ToString());
        mywork.reason = this.tb_leave.Text;
        mywork.approve = -1;

        if (mywork.starttime > mywork.endtime)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('开始日期不得晚于结束日期');location.href='CommitLeave.aspx';", true);
            return;
        }
        else if (mywork.starttime == mywork.endtime && mywork.originshift == "下午" && mywork.currentshift == "上午")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('开始日期不得晚于结束日期');location.href='CommitLeave.aspx';", true);
            return;
        }

        db.workoff.InsertOnSubmit(mywork);
        db.SubmitChanges();
        Page.ClientScript.RegisterStartupScript(GetType(),"","alert('申请提交成功!');location.href='staff.aspx';",true);
    }

    protected void txtFrom_TextChanged(object sender, EventArgs e)
    {
        if (this.txtFrom.Text != "")
        {
            this.txtTo.Text = this.txtFrom.Text;
        }
    }

    private string convertdate(string text)
    {
        string temp = "";
        switch (text)
        {
            case "Monday": temp = "周一"; break;
            case "Tuesday": temp = "周二"; break;
            case "Wednesday": temp = "周三"; break;
            case "Thursday": temp = "周四"; break;
            case "Friday":temp = "周五";break;
            case "Saturday": temp = "周六"; break;
            case "Sunday": temp = "周日"; break;
        }
        return temp;
    }
}