using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CommitWork : System.Web.UI.Page
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
        if (Session["name"] != null)
            HttpContext.Current.Response.Redirect("~/staff.aspx");
        else
            HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
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
            case "Friday": temp = "周五"; break;
            case "Saturday": temp = "周六"; break;
            case "Sunday": temp = "周日"; break;
        }
        return temp;
    }
    protected void txtFrom_TextChanged(object sender, EventArgs e)
    {
        if (this.txtFrom.Text != "")
        {
            this.txtTo.Text = this.txtFrom.Text;
        }
    }
    protected void btleave_Click(object sender, EventArgs e)
    {
        workDBDataContext db = new workDBDataContext();
        jiaban myjb = new jiaban();
        
        if (Session["name"] == null)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('登录已过期');location.href='SBSLogin.aspx';", true);
            return;
        }
        myjb.name = Session["name"].ToString();
        myjb.starttime = DateTime.Parse(this.txtFrom.Text);
        myjb.startshift = this.drp_start.Text;
        myjb.startweek = convertdate(Convert.ToDateTime(this.txtFrom.Text).DayOfWeek.ToString());
        myjb.endtime = DateTime.Parse(this.txtTo.Text);
        myjb.endshift = this.drp_end.Text;
        myjb.endweek = convertdate(Convert.ToDateTime(this.txtTo.Text).DayOfWeek.ToString());
        myjb.content = this.tb_leave.Text;
        myjb.approve = -1;

        if (myjb.starttime > myjb.endtime)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('开始日期不得晚于结束日期');location.href='CommitWork.aspx';", true);
            return;
        }
        else if (myjb.starttime == myjb.endtime && myjb.startshift == "下午" && myjb.endshift == "上午")
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('开始日期不得晚于结束日期');location.href='CommitLeave.aspx';", true);
            return;
        }

        db.jiaban.InsertOnSubmit(myjb);
        db.SubmitChanges();
        Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('申请提交成功!');location.href='staff.aspx';", true);
    }
}