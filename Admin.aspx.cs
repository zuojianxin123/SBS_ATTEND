using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        this.lb_name.Text = "欢迎" + Session["name"] + "领导登录！";
    }
    protected void calshift_DayRender(object sender, DayRenderEventArgs e)
    {
        string morning = "";
        string noon = "";
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
                        where a.worktime == dateToday.AddDays(-1)
                        select a;
            var query_current = from a in db.workhistory
                        where a.worktime == dateToday
                        select a;
           

            /*根据调休申请表生成*/
            var query_leave = from a in db.overtime
                              where (a.overwork == dateToday || a.originwork == dateToday) && a.approve == 4
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
                        }else if(work.current_shift == "下午")
                        {
                            noon += work.name + ";";
                        }
                    }
                }

                // 本来调休
                foreach (var work in query_leave)
                {
                    if (work.originwork == dateToday)
                    {
                        if (work.origin_shift == "明天上午")
                        {
                            ifday = -1;
                            break;
                        }
                        else if (work.origin_shift == "当天下午")
                        {
                            ifnight = -1;
                            break;
                        }
                    }
                }
            }
            
            //原始调休
            if (ifday == 0)
            {
                morning += query_before.First().worker1;
            }
            if (ifnight == 0)
            {
                noon += query_current.First().worker;
            }

            e.Cell.Text = "<div style = 'font-size:22px;" + (e.Day.Date.Day == DateTime.Now.Day ? "background-color:#C6E7FF; color:#0B67A9'>" : "'>") + e.Day.Date.Day + "</br>"
                    + "<div style='font-size:12px; color:#676767;'>上午："
                    + morning + "</br >下午：" + noon + "</div></div>";
           
        }

    }
    protected void calshift_SelectionChanged(object sender, EventArgs e)
    {

    }
    protected void calleave_DayRender(object sender, DayRenderEventArgs e)
    {
        if (e.Day.IsOtherMonth)
        {
            e.Cell.Controls.Clear();
        }
        else
        {
            e.Cell.Text = e.Day.Date.Day+"";
        }
    }
    protected void calleave_SelectionChanged(object sender, EventArgs e)
    {

    }

    protected void lbtn_logout_Click(object sender, EventArgs e)
    {
        Session["permission"] = null;
        Session["name"] = null;
        HttpContext.Current.Response.Redirect("~/Default.aspx");
    }
}