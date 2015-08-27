using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class staff : System.Web.UI.Page
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
            gridviewoverbind();
            gridviewleavebind();
            gridviewworkbind();
        }   
    }
    public void gridviewworkbind()
    {
        workDBDataContext db = new workDBDataContext();
        var query = from a in db.jiaban
                    where (a.starttime.Value.Month == DateTime.Now.Month) && (a.name == Session["name"].ToString() && (a.starttime.Value.Year == DateTime.Now.Year))
                    select a;
        if (query.Count() != 0)
        {
            DataSet ds = new DataSet();
            DataTable tb = ds.Tables.Add("reivew_jiaban");
            tb.Columns.Add(new DataColumn("starttime", typeof(string)));
            tb.Columns.Add(new DataColumn("endtime", typeof(string)));
            tb.Columns.Add(new DataColumn("result", typeof(string)));

            foreach (var leave in query)
            {
                string origin_str = leave.starttime.ToString().Substring(0, leave.starttime.ToString().LastIndexOf(" ")) + "," + leave.startweek + "," + leave.startshift;
                string current_str = leave.endtime.ToString().Substring(0, leave.endtime.ToString().LastIndexOf(" ")) + "," + leave.endweek + "," + leave.endshift;
                string result = "";
                switch (leave.approve)
                {
                    case 4: result = "通过"; break;
                    case 5: result = "未通过"; break;
                    default: result = "未审批"; break;
                }
                tb.Rows.Add(new object[] { origin_str, current_str, result });
            }
            this.gv_jiaban.DataSource = ds;
            this.gv_jiaban.DataBind();
        }
    }
    public void gridviewleavebind()
    {
        workDBDataContext db = new workDBDataContext();
        var query = from a in db.workoff
                    where (a.starttime.Value.Month == DateTime.Now.Month) && (a.name == Session["name"].ToString() && (a.starttime.Value.Year == DateTime.Now.Year))
                    select a;
        if (query.Count() != 0)
        {
            DataSet ds = new DataSet();
            DataTable tb = ds.Tables.Add("reivew_overtime");
            tb.Columns.Add(new DataColumn("starttime", typeof(string)));
            tb.Columns.Add(new DataColumn("endtime", typeof(string)));
            tb.Columns.Add(new DataColumn("result", typeof(string)));

            foreach (var leave in query)
            {
                string origin_str = leave.starttime.ToString().Substring(0, leave.starttime.ToString().LastIndexOf(" ")) + "," + leave.originweek + "," + leave.originshift;
                string current_str = leave.endtime.ToString().Substring(0, leave.endtime.ToString().LastIndexOf(" ")) + "," + leave.currentweek + "," + leave.currentshift;
                string result = "";
                switch (leave.approve)
                {
                    case 4: result = "通过"; break;
                    case 5: result = "未通过"; break;
                    default: result = "未审批"; break;
                }
                tb.Rows.Add(new object[] { origin_str, current_str, result });
            }
            this.gv_leaveresult.DataSource = ds;
            this.gv_leaveresult.DataBind();
        }
    }

    public void gridviewoverbind()
    {
        workDBDataContext db = new workDBDataContext();
        int lastday = DateTime.DaysInMonth(DateTime.Now.Year,DateTime.Now.Month-1);
        DateTime last = new DateTime(DateTime.Now.Year,DateTime.Now.Month-1,lastday);
        var query = from a in db.overtime
                    where ((a.originwork.Value.Month == DateTime.Now.Month && a.originwork.Value.Year == DateTime.Now.Year) || a.originwork.Value == last) && a.name == Session["name"].ToString()
                    select a;
        if (query.Count() != 0)
        {
            DataSet ds = new DataSet();
            DataTable tb = ds.Tables.Add("reivew_overtime");
            tb.Columns.Add(new DataColumn("origin", typeof(string)));
            tb.Columns.Add(new DataColumn("current", typeof(string)));
            tb.Columns.Add(new DataColumn("result", typeof(string)));

            foreach (var over in query)
            {
                string origin_str = over.originwork.ToString().Substring(0, over.originwork.ToString().LastIndexOf(" ")) + "," + over.origin_week + "," + over.origin_shift;
                string current_str = over.overwork.ToString().Substring(0, over.overwork.ToString().LastIndexOf(" ")) + "," + over.current_week + "," + over.current_shift;
                string result = "";
                switch (over.approve)
                {
                    case 4: result = "通过"; break;
                    case 5: result = "未通过"; break;
                    default: result = "未审批"; break;
                }
                tb.Rows.Add(new object[] { origin_str, current_str, result});
            }
            this.gv_overresult.DataSource = ds;
            this.gv_overresult.DataBind();
        }
    }

    protected void lbtn_logout_Click(object sender, EventArgs e)
    {
        Session["permission"] = null;
        Session["name"] = null;
        HttpContext.Current.Response.Redirect("~/Default.aspx");
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
                              where ((a.overwork.Value.Year == dateToday.Year && a.overwork.Value.Month == dateToday.Month) || (a.originwork.Value.Year == dateToday.Year && a.originwork.Value.Month == dateToday.Month)) && a.approve == 4
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
    protected void calleave_DayRender(object sender, DayRenderEventArgs e)
    {
        string morning = "";
        string noon = "";

        if (e.Day.IsOtherMonth)
        {
            e.Cell.Controls.Clear();
        }
        else
        {
            DateTime dateToday = e.Day.Date;
            workDBDataContext db = new workDBDataContext();
            var query_leave = from a in db.workoff
                              where (a.starttime <= dateToday && a.endtime >= dateToday) && a.approve == 4
                              select a;
            if (query_leave.Count() != 0)
            {
                foreach (var work in query_leave)
                {
                    if (work.starttime < dateToday && work.endtime > dateToday)     //中间日期
                    {
                        morning += work.name + ";";
                        noon += work.name + ";";
                    }
                    else if (work.starttime == dateToday && work.endtime != dateToday) //正好开始日期
                    {
                        if (work.originshift == "上午")
                        {
                            morning += work.name + ";";
                            noon += work.name + ";";
                        }
                        else
                        {
                            noon += work.name + ";";
                        }
                    }
                    else if (work.endtime == dateToday && work.starttime != dateToday)  //正好结束日期
                    {
                        if (work.currentshift == "下午")
                        {
                            morning += work.name + ";";
                            noon += work.name + ";";
                        }
                        else
                        {
                            morning += work.name + ";";
                        }
                    }
                    else if (work.endtime == dateToday && work.starttime == dateToday)  //正好当天
                    {
                        if (work.originshift == "上午")
                        {
                            morning += work.name + ";";
                            if (work.currentshift == "下午")
                            {
                                noon += work.name + ";";
                            }
                        }
                        else
                        {
                            noon += work.name + ";";
                        }
                    }
                }
            }
            e.Cell.Text = "<div style = 'font-size:22px;" + (e.Day.Date.Day == DateTime.Now.Day ? "background-color:#C6E7FF; color:#0B67A9'>" : "'>") + e.Day.Date.Day + "</br>"
                   + "<div style='font-size:12px; color:#676767;'>上午："
                   + morning + "</br >下午：" + noon + "</div></div>";
        }
    }

    protected void caljiaban_DayRender(object sender, DayRenderEventArgs e)
    {
        string morning = "";
        string noon = "";

        if (e.Day.IsOtherMonth)
        {
            e.Cell.Controls.Clear();
        }
        else
        {
            DateTime dateToday = e.Day.Date;
            workDBDataContext db = new workDBDataContext();
            var query_leave = from a in db.jiaban
                              where (a.starttime <= dateToday && a.endtime >= dateToday) && a.approve == 4
                              select a;
            if (query_leave.Count() != 0)
            {
                foreach (var work in query_leave)
                {
                    if (work.starttime < dateToday && work.endtime > dateToday)     //中间日期
                    {
                        morning += work.name + ";";
                        noon += work.name + ";";
                    }
                    else if (work.starttime == dateToday && work.endtime != dateToday) //正好开始日期
                    {
                        if (work.startshift == "上午")
                        {
                            morning += work.name + ";";
                            noon += work.name + ";";
                        }
                        else
                        {
                            noon += work.name + ";";
                        }
                    }
                    else if (work.endtime == dateToday && work.starttime != dateToday)  //正好结束日期
                    {
                        if (work.endshift == "下午")
                        {
                            morning += work.name + ";";
                            noon += work.name + ";";
                        }
                        else
                        {
                            morning += work.name + ";";
                        }
                    }
                    else if (work.endtime == dateToday && work.starttime == dateToday)  //正好当天
                    {
                        if (work.startshift == "上午")
                        {
                            morning += work.name + ";";
                            if (work.endshift == "下午")
                            {
                                noon += work.name + ";";
                            }
                        }
                        else
                        {
                            noon += work.name + ";";
                        }
                    }
                }
            }
            e.Cell.Text = "<div style = 'font-size:22px;" + (e.Day.Date.Day == DateTime.Now.Day ? "background-color:#C6E7FF; color:#0B67A9'>" : "'>") + e.Day.Date.Day + "</br>"
                   + "<div style='font-size:12px; color:#676767;'>上午："
                   + morning + "</br >下午：" + noon + "</div></div>";
        }
    }
    protected void lbtn_request_Click(object sender, EventArgs e)
    {
        if (Session["name"] != null)
            HttpContext.Current.Response.Redirect("~/CommitLeave.aspx");
        else
            HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
    }

    protected void lbtn_overtime_Click(object sender, EventArgs e)
    {
        if (Session["name"] != null)
            HttpContext.Current.Response.Redirect("~/CommitOver.aspx");
        else
            HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
    }
    protected void lbtn_jiaban_Click(object sender, EventArgs e)
    {
        if (Session["name"] != null)
            HttpContext.Current.Response.Redirect("~/CommitWork.aspx");
        else
            HttpContext.Current.Response.Redirect("~/SBSLogin.aspx");
    }
}