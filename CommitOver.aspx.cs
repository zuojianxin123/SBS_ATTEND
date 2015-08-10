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
            if (Session["name"] == null)
            {
                HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
                return;
            }

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
        if (shift.Equals("上午"))
        {
            work.origin_shift = "明天上午";
            work.origin_week = convertdate(DateTime.Parse(day).AddDays(-1).DayOfWeek.ToString());
            work.originwork = DateTime.Parse(day).AddDays(-1);
        }
        else 
        {
            work.origin_shift = "当天下午";
            work.origin_week = convertdate(DateTime.Parse(day).DayOfWeek.ToString());
            work.originwork = DateTime.Parse(day);
        }       

        work.overwork = DateTime.Parse(this.txtTo.Text);
        work.current_shift = this.drp_end.Text;
        work.current_week = convertdate(DateTime.Parse(this.txtTo.Text).DayOfWeek.ToString());
        work.approve = -1;

        if (work.originwork > work.overwork)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('提交失败，开始日期不得晚于结束日期');location.href='CommitOver.aspx';", true);
            return;
        }
        var query_over = from a in db.overtime
                         where a.originwork == work.originwork && a.name == Session["name"].ToString()
                         select a;
        if (query_over.Count() != 0)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "", "alert('提交失败，您已经把该日调休替换到其他时间了，请检查！！');location.href='CommitOver.aspx';", true);
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
        int lastday = DateTime.DaysInMonth(DateTime.Now.Year,DateTime.Now.Month-1);
        DateTime last = new DateTime(DateTime.Now.Year,DateTime.Now.Month-1,lastday);
        workDBDataContext db = new workDBDataContext();
        var query_morning = from a in db.workhistory
                            where a.worktime.Value.Month == DateTime.Now.Month && a.worktime.Value.Year == DateTime.Now.Year && a.worker == name
                            select a;

        var query_noon = from a in db.workhistory
                         where (a.worktime.Value.Month == DateTime.Now.Month && a.worktime.Value.Year == DateTime.Now.Year || a.worktime.Value == last)&& a.worker1 == name
                            select a;

        if (query_morning.Count() != 0)
        {
            foreach (var work in query_morning)
            {
                temp = work.worktime.ToString().Substring(0, work.worktime.ToString().LastIndexOf(" ")) + " 下午";
                time.Add(temp);
            }
        }

        if (query_noon.Count() != 0)
        {
            foreach (var work in query_noon)
            {
                DateTime time_tmp = DateTime.Parse(work.worktime.ToString()).AddDays(1);
                temp = time_tmp.ToString().Substring(0, time_tmp.ToString().LastIndexOf(" ")) + " 上午";
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

    protected void showshift_DayRender(object sender, DayRenderEventArgs e)
    {
        string morning = "";
        string noon = "";
        string name = Session["name"].ToString();
        int ifday = 0;
        int ifnight = 0;

        if (e.Day.IsOtherMonth)
        {
            e.Cell.Controls.Clear();
        }
        else
        {
            DateTime dateToday = e.Day.Date;
            workDBDataContext db = new workDBDataContext();

            /*根据值班表生成*/
            var query_before = from a in db.workhistory
                               where a.worktime == dateToday.AddDays(-1) && a.worker1 == name
                               select a;
            var query_current = from a in db.workhistory
                                where a.worktime == dateToday && a.worker == name
                                select a;


            /*根据调休申请表生成*/
            var query_leave = from a in db.overtime
                              where ((a.overwork.Value.Year == dateToday.Year && a.overwork.Value.Month == dateToday.Month) || (a.originwork.Value.Year == dateToday.Year && a.originwork.Value.Month == dateToday.Month)) && a.approve == 4 && a.name == name
                              select a;

            if (query_leave.Count() != 0)
            {
                //申请到的调休
                foreach (var work in query_leave)
                {
                    if (work.overwork == dateToday)
                    {
                        if (work.current_shift == "上午")
                        {
                            morning += work.name + ";";
                        }
                        else if (work.current_shift == "下午")
                        {
                            noon += work.name + ";";
                        }
                    }
                }

                // 本来调休
                foreach (var work in query_leave)
                {
                    if (work.originwork == dateToday && work.origin_shift == "当天下午")
                    {
                        ifnight = -1;
                    }
                    if (work.originwork == dateToday.AddDays(-1) && work.origin_shift == "明天上午")
                    {
                        ifday = -1;
                    }
                }
            }

            //原始调休
            if (ifday == 0 && query_before.Count() != 0)
            {
                morning += query_before.First().worker1;
            }
            if (ifnight == 0 && query_current.Count() != 0)
            {
                noon += query_current.First().worker;
            }

            e.Cell.Text = "<div style = 'font-size:22px;" + (e.Day.Date.Day == DateTime.Now.Day ? "background-color:#C6E7FF; color:#0B67A9'>" : "'>") + e.Day.Date.Day + "</br>"
                    + "<div style='font-size:12px; color:#676767;'>上午："
                    + morning + "</br >下午：" + noon + "</div></div>";

        }
    }
}