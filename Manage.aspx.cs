using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;

public partial class Manage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btGenerate_Click(object sender, EventArgs e)
    {
        DateTime dateFrom = DateTime.Parse(txtFrom.Text);
        DateTime dateTo = DateTime.Parse(txtTo.Text);
        workDBDataContext db = new workDBDataContext();
        var queryWorker = from a in db.worker
                          select a.username;

        List<string> al = queryWorker.ToList();
        var queryWorkerOne = from a in db.workhistory
                             where a.worktime == dateFrom.AddDays(-1)
                             select a.worker;
        int s = -1;//从al[s]的后一个开始排班，共al.Count个人
        if (queryWorkerOne != null && queryWorkerOne.Count() == 1)
        {
            for (int i = 0; i < al.Count; i++)
            {
                if (al[i].ToString() == queryWorkerOne.First())
                {
                    s = i;
                    break;
                }
            }   //s=i
        }
        int p;//判断是更新还是插入，0插入，1更新
        int kongi = 0;//轮空
        while (true)
        {
            switch (ddlSchedule.SelectedValue)
            {
                case "0":
                    //按人员顺序排列
                    s = (s + 1) % al.Count;//对al[s]进行排班
                    break;
                case "1":
                    //每人向前一天（7个人）
                    s = (s + 1) % al.Count;
                    if (dateFrom.DayOfWeek == DayOfWeek.Sunday)
                        s = (s + 1) % al.Count;
                    break;
                case "2":
                    //每人向前二天（7个人）
                    s = (s + 1) % al.Count;
                    if (dateFrom.DayOfWeek == DayOfWeek.Monday)
                        s = (s + 2) % al.Count;
                    break;
                case "3":
                    //每轮轮空一人
                    s = (s + 1) % al.Count;
                    if (s == kongi)
                    {
                        s = (s + 1) % al.Count;
                        kongi = (kongi + 1) % al.Count;
                    }
                    break;
                case "4":
                    //周四、五同一人值班
                    if (dateFrom.DayOfWeek != DayOfWeek.Friday)
                        s = (s + 1) % al.Count;
                    break;
                case "5":
                    //依次排列早晚班
                    s = (s + 2) % al.Count;
                    break;
            }
            var queryCurrent = from a in db.workhistory
                               where a.worktime == dateFrom
                               select a;
            p = queryCurrent.Count();//0插入，1更新

            if (p == 1)
            {
                queryCurrent.First().worker = al[s];
                if (ddlSchedule.SelectedValue == "5")
                    queryCurrent.First().worker1 = al[(s + 1) % al.Count];
                db.SubmitChanges();
            }
            if (p == 0)
            {
                workhistory workIns = new workhistory();
                workIns.worktime = dateFrom;
                workIns.worker = al[s];
                if (ddlSchedule.SelectedValue == "5")
                    workIns.worker1 = al[(s + 1) % al.Count];
                workIns.workstatus = "0";
                db.workhistory.InsertOnSubmit(workIns);
                db.SubmitChanges();
            }

            if (dateFrom == dateTo)
                break;

            dateFrom = dateFrom.AddDays(1);
        }
        Response.Redirect("Default.aspx");
    }
    protected void btAdd_Click(object sender, EventArgs e)
    {
        workDBDataContext db = new workDBDataContext();
        worker workerQuery = new worker();
        workerQuery.username = txtWorker.Text.Trim();
        db.worker.InsertOnSubmit(workerQuery);
        db.SubmitChanges();
        Response.Redirect(HttpContext.Current.Request.RawUrl);
    }
}
