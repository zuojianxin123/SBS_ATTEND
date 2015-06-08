using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.Common;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            ddlType_SelectedIndexChanged(null, null);
        }
    }
    protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
    {
        if (e.Day.IsOtherMonth)
            //e.Cell.ForeColor = System.Drawing.Color.LightGray;
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
                var query1 = from a in db.workhistory
                            where a.worktime == dateToday.AddDays(1)
                            select a;
                string riban = "";
                if (query1.Count() > 0)
                    riban = query1.First().worker;

                e.Cell.Text = "<div style = 'font-size:22px;" + (e.Day.Date.Day == DateTime.Now.Day ? "background-color:#C6E7FF; color:#0B67A9'>" : "'>") + e.Day.Date.Day + "</br>"
                        + "<div style='font-size:16px; color:#676767;'>早班："
                        + query.First().worker + "</br >晚班：" + query.First().worker1 + "</br >白班：" + query1.First().worker + "</div></div>";
                /*
                string strContent;
                if (query.First().workstatus == '0')
                    strContent = "未完成";
                else
                {
                    e.Cell.BackColor = System.Drawing.Color.LightGray;
                    strContent = "值班工作：" + CutString(query.First().workcontent) + "</br>制作网：" + CutString(query.First().workcontent1);
                }
                if (dateToday > DateTime.Now.Date)
                    e.Cell.Text = "<DIV TITLE='header=[工作记录] body=[" + strContent + "]'>"
                        + "<a title=\"" + dateToday.ToString("MM月dd日") + "\" style=\"color: #0b67a9;\" href=\"#\">"
                        + "<div OnClick=\"alert('不能写今天以后的日志！')\">" + e.Day.Date.Day + "</br >"
                        + "<div style='font-size:12px; color:#676767;'>"
                        + query.First().worker + "&nbsp;&nbsp;" + (query.First().workstatus == '0' ? "未完成" : "已完成") + "</div></div></a></DIV>";
                else
                    e.Cell.Text = "<DIV TITLE='header=[工作记录] body=[" + strContent + "]'>"
                        + "<a title=\"" + dateToday.ToString("MM月dd日") + "\" style=\"color: #0b67a9;\" href=\"javascript:__doPostBack('ctl00$ContentPlaceHolder1$Calendar1','"+(dateToday-DateTime.Parse("2000.1.1")).Days+"')\">"
                        + "<div>" + e.Day.Date.Day + "</br >"
                        + "<div style='font-size:12px; color:#676767;'>"
                        + query.First().worker + "&nbsp;&nbsp;" + (query.First().workstatus == '0' ? "未完成" : "已完成") + "</div></div></a></DIV>";
            
                 */
            }
        }
    }
    private void showPanel(DateTime dateToday)
    {
        workDBDataContext db = new workDBDataContext();
        var query = from a in db.workhistory
                    where a.worktime == dateToday
                    select a;
        if (query.Count() == 1)
        {

            liWorker.Text = query.First().worker;
            liDate.Text = dateToday.ToString("yyyy年MM月dd日");
            txtContent.Text = query.First().workcontent;
            txtContent1.Text = query.First().workcontent1;
            if (dateToday.AddDays(3)>DateTime.Now.Date)
            {
                btSave.Visible = true;
                btCancel.Text = "取消";
            }
            else
            {
                btSave.Visible = false;
                btCancel.Text = "关闭";
            }
            PanelLog_ModalPopupExtender.Show();
        }
    }
    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        DateTime dateToday = Calendar1.SelectedDate;
        showPanel(dateToday);
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            DateTime dateToday = DateTime.Parse(GridView1.SelectedRow.Cells[1].Text);
            showPanel(dateToday);
        }
        catch (Exception) { }
    }
    protected void btSave_Click(object sender, EventArgs e)
    {
        workDBDataContext db = new workDBDataContext();
        var workquery = from a in db.workhistory
                        where a.worktime == DateTime.Parse(liDate.Text)
                        select a;
        workquery.First().workcontent = txtContent.Text;
        workquery.First().workcontent1 = txtContent1.Text;
        workquery.First().workstatus = "1";
        db.SubmitChanges();
        GridView1.DataBind();
    }
    protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Cells[2].Text = e.Row.Cells[2].Text.Replace(" ", "&nbsp;&nbsp;&nbsp;&nbsp;");
            string strWK = e.Row.Cells[0].Text;
            if (strWK == "星期日" || strWK == "星期六")
            {
                e.Row.BackColor = System.Drawing.Color.FromArgb(254, 214, 210);
            }
            if (DateTime.Parse(e.Row.Cells[1].Text) == DateTime.Now.Date)
            {
                e.Row.BackColor = System.Drawing.Color.FromArgb(198, 231, 255);
            }

            workDBDataContext db = new workDBDataContext();
            var query1 = from a in db.workhistory
                         where a.worktime == DateTime.Parse(e.Row.Cells[1].Text).AddDays(1)
                         select a;
            string riban = "";
            if (query1.Count() > 0)
                riban = query1.First().worker;
            e.Row.Cells[2].Text += "　白班：" + riban;

            if (e.Row.Cells[4].Text == "0")
                e.Row.Cells[4].Text = "未完成";
            else
            {
                e.Row.Cells[4].Text = "已完成";
                //e.Row.BackColor = System.Drawing.Color.LightGray;
            }
            //当鼠标停留时更改背景色
            e.Row.Attributes.Add("onmouseover", "c=this.style.backgroundColor;this.style.backgroundColor='#7B98E1'");
            //当鼠标移开时还原背景色
            e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor=c");
            //设置悬浮鼠标指针形状为"小手"
            e.Row.Attributes["style"] = "Cursor:hand";
            //单击/双击 事件
            /*
            DateTime datestr;
            DateTime.TryParse(e.Row.Cells[1].Text, out datestr);
            
            if (datestr > DateTime.Now.Date)
                e.Row.Attributes.Add("OnClick", "alert('不能写今天以后的日志！')");
            //注：OnClick参数是指明为鼠标单击时间，后个是调用javascript的ClickEvent函数
            else
            {
                //string strTT = "window.showModalDialog('log_r.aspx?date=" + e.Row.Cells[1].Text + "',window,'dialogWidth:600px;status:no;dialogHeight:650px')==1?window.location.reload():window.location.reload()";
                //e.Row.Attributes.Add("onclick", strTT);
                //e.Row.Attributes["href"] = "javascript:__doPostBack('ctl00$ContentPlaceHolder1$Calendar1','" + (DateTime.Parse(e.Row.Cells[1].Text) - DateTime.Parse("2000.1.1")).Days + "')";
                
                e.Row.Attributes["OnClick"] = ClientScript.GetPostBackEventReference(e.Row.Parent.Parent, "Select$" + e.Row.RowIndex);
            }*/
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (ddlType.SelectedValue)
        {
            case "0":
                Calendar1.Visible = true;
                Panel1.Visible = false;
                break;
            case "1":
                Calendar1.Visible = false;
                Panel1.Visible = true;
                ddlYear.SelectedValue = DateTime.Now.Year.ToString();
                ddlMonth.SelectedValue = DateTime.Now.Month.ToString();
                break;
        }
    }
    public static string NoHTML(string Htmlstring)
    {
        //删除脚本
        Htmlstring = Regex.Replace(Htmlstring, @"<script[^>]*?>.*?</script>", "",
          RegexOptions.IgnoreCase);
        //删除HTML
        Htmlstring = Regex.Replace(Htmlstring, @"<(.[^>]*)>", "",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"([\r\n])[\s]+", "",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"-->", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"<!--.*", "", RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(quot|#34);", "\"",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(amp|#38);", "&",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(lt|#60);", "<",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(gt|#62);", ">",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(nbsp|#160);", "   ",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(iexcl|#161);", "\xa1",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(cent|#162);", "\xa2",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(pound|#163);", "\xa3",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&(copy|#169);", "\xa9",
          RegexOptions.IgnoreCase);
        Htmlstring = Regex.Replace(Htmlstring, @"&#(\d+);", "",
          RegexOptions.IgnoreCase);

        Htmlstring.Replace("<", "");
        Htmlstring.Replace(">", "");
        Htmlstring.Replace("\r\n", "");
        Htmlstring = HttpContext.Current.Server.HtmlEncode(Htmlstring).Trim();

        return Htmlstring;
    }
    protected string CutString(object obj)
    {
        string str;
        if (obj != null)
        {
            str = NoHTML(obj.ToString());
            if (str.Length > 25)
                return str.Substring(0, 25) + "…";
            else
                return str;
        }
        else
            return null;
    }
    protected string StatuStr(object str)
    {
        if (!string.IsNullOrEmpty(str.ToString()))
        {
            if (str.ToString() == "1")
                return "已完成";
            if (str.ToString() == "0")
                return "未完成";
        }
        return str.ToString();
    }
}
