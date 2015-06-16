using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CommitOver : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            this.lb_name.Text = "欢迎 " + Session["name"] + " 同志登录！";
            List<string> time = getOver(Session["name"].ToString());
            if (time.Count != 0)
            {
                foreach (string hehe in time)
                {
                    this.drp_orgin.Items.Add(new ListItem(hehe,hehe));
                }
            }
        }
    }
    protected void lbtn_back_Click(object sender, EventArgs e)
    {
        if (Session["name"] != null)
            HttpContext.Current.Response.Redirect("~/staff.aspx");
        else
            HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
    }
    protected void btleave_Click(object sender, EventArgs e)
    {
        workDBDataContext db = new workDBDataContext();
        overtime work = new overtime();
        
        if (Session["name"] == null)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('登录已过期');location.href='SBSLogin.aspx';", true);
            return;
        }

        work.name = Session["name"].ToString();
        work.reason = this.tb_leave.Text;

        string day = this.drp_orgin.Text.Substring(0, this.drp_orgin.Text.LastIndexOf(" "));
        string shift = this.drp_orgin.Text.Substring(day.Length+1);
        work.origin_shift = shift;
        work.origin_week = convertdate(DateTime.Parse(day).DayOfWeek.ToString());
        work.originwork = DateTime.Parse(day);

        work.overwork = DateTime.Parse(this.txtTo.Text);
        work.current_shift = this.drp_end.Text;
        work.current_week = convertdate(DateTime.Parse(this.txtTo.Text).DayOfWeek.ToString());
        work.approve = -1;

        if (work.originwork > work.overwork)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('开始日期不得晚于结束日期');location.href='CommitOver.aspx';", true);
            return;
        }
        db.overtime.InsertOnSubmit(work);
        db.SubmitChanges();
        Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('申请提交成功!');location.href='staff.aspx';", true);
    }

    //获取本月调休信息
    private List<string> getOver(String name)
    {
        List<string> time = new List<string>();
        string temp = "";
        workDBDataContext db = new workDBDataContext();
        var query_morning = from a in db.workhistory
                            where a.worktime.Value.Month == DateTime.Now.Month && a.worktime.Value.Year == DateTime.Now.Year && a.worker == name
                            select a;

        var query_noon = from a in db.workhistory
                         where a.worktime.Value.Month == DateTime.Now.Month && a.worktime.Value.Year == DateTime.Now.Year && a.worker1 == name
                            select a;

        if (query_morning.Count() != 0)
        {
            foreach (var work in query_morning)
            {
                temp = work.worktime.ToString().Substring(0, work.worktime.ToString().LastIndexOf(" ")) + " 当天下午";
                time.Add(temp);
            }
        }

        if (query_noon.Count() != 0)
        {
            foreach (var work in query_noon)
            {
                temp = work.worktime.ToString().Substring(0, work.worktime.ToString().LastIndexOf(" ")) + " 明天上午";
                time.Add(temp);
            }
        }
        return time;
    }
    protected void drp_orgin_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.txtTo.Text = drp_orgin.Text.Substring(0, drp_orgin.Text.LastIndexOf(" "));
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
}