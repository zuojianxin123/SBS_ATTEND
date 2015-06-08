using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Change : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        if (e.Day.IsOtherMonth)
            e.Cell.Controls.Clear();
        else
        {
            DateTime dateToday = e.Day.Date;
            workDBDataContext db = new workDBDataContext();
            var query = from a in db.workhistory
                        where a.worktime == dateToday
                        select a;
            if (query.Count() == 1)
            {
                e.Cell.Text = "<a title=\"" + dateToday.ToString("MM月dd日") + "\" style=\"color: #0b67a9;\" href=\"javascript:__doPostBack('ctl00$ContentPlaceHolder1$Calendar1','" + (dateToday - DateTime.Parse("2000.1.1")).Days + "')\">"
                    + "<div>" + e.Day.Date.Day + "</br >"
                    + "<div style='font-size:22px; color:#676767;'>早班："
                    + query.First().worker + "</br >晚班：" + query.First().worker1 + "</div></div></a>";
            }
        }

    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        DateTime dateToday = Calendar1.SelectedDate;
        workDBDataContext db = new workDBDataContext();
        var query = from a in db.workhistory
                    where a.worktime == dateToday
                    select a;
        var queryWorker = from a in db.worker
                          select new
                          {
                              id = a.ID,
                              username = a.username
                          };
        if (query.Count() == 1)
        {
            liFormer.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd") + "早班&nbsp;&nbsp;" + query.First().worker + "&nbsp;&nbsp;变更为";
            liFormer1.Text = Calendar1.SelectedDate.ToString("yyyy-MM-dd") + "晚班&nbsp;&nbsp;" + query.First().worker1 + "&nbsp;&nbsp;变更为";
            ddlWorker.DataSource = queryWorker;
            ddlWorker.DataValueField = "id";
            ddlWorker.DataTextField = "username";
            ddlWorker.DataBind();
            ddlWorker1.DataSource = queryWorker;
            ddlWorker1.DataValueField = "id";
            ddlWorker1.DataTextField = "username";
            ddlWorker1.DataBind();
            ddlWorker.Items.FindByText(query.First().worker).Selected = true;
            ddlWorker1.Items.FindByText(query.First().worker1).Selected = true;
            PanelChange_ModalPopupExtender.Show();
        }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        DateTime dateToday = Calendar1.SelectedDate;
        workDBDataContext db = new workDBDataContext();
        var query = from a in db.workhistory
                    where a.worktime == dateToday
                    select a;
        if (query.Count() == 1)
        {
            query.First().worker = ddlWorker.SelectedItem.Text;
            query.First().worker1 = ddlWorker1.SelectedItem.Text;
            db.SubmitChanges();
        }
    }
}
