using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

public partial class Monitor : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Bind();
    }

    private void Bind()
    {
        DataClassesDataContext db = new DataClassesDataContext();

        //绑定左边的tree
        TreeView1.Nodes.Clear();
        TreeView1.Nodes.Add(new TreeNode("一套完成情况", "1"));
        TreeView1.Nodes.Add(new TreeNode("二套完成情况", "2"));
        TreeView1.Nodes.Add(new TreeNode("ESB完成情况", "ESB"));
        TreeView1.Nodes.Add(new TreeNode("EMB完成情况", "EMB"));
        foreach (TreeNode i in TreeView1.Nodes)
            i.SelectAction = TreeNodeSelectAction.None;

        var queryleftyitao = from a in db.wall_complete_task
                             where a.Memo.StartsWith("一套")
                             select a;
        foreach (var i in queryleftyitao)
        {
            TreeNode tn = new TreeNode(i.Memo.Replace("一套","") + " " + i.count.ToString(), "");
            tn.SelectAction = TreeNodeSelectAction.None;
            TreeView1.Nodes[0].ChildNodes.Add(tn);
        }
        var queryyitaobeibo = from a in db.beibo
                              where a.type == 0
                              select a.beibo_count;
        TreeNode tn1bei = new TreeNode("备播迁移 " + queryyitaobeibo.First().ToString(), "");
        tn1bei.SelectAction = TreeNodeSelectAction.None;
        TreeView1.Nodes[0].ChildNodes.Add(tn1bei);


        var queryleftertao = from a in db.wall_complete_task
                             where a.Memo.StartsWith("二套")
                             select a;
        foreach (var i in queryleftertao)
        {
            TreeNode tn = new TreeNode(i.Memo.Replace("二套", "") + " " + i.count.ToString(), "");
            tn.SelectAction = TreeNodeSelectAction.None;
            TreeView1.Nodes[1].ChildNodes.Add(tn);
        }
        var queryertaobeibo = from a in db.beibo
                              where a.type == 1
                              select a.beibo_count;
        TreeNode tn2bei = new TreeNode("备播迁移 " + queryertaobeibo.First().ToString(), "");
        tn2bei.SelectAction = TreeNodeSelectAction.None;
        TreeView1.Nodes[1].ChildNodes.Add(tn2bei);

        var queryleftesb = from a in db.wall_complete_task
                             where a.Memo.StartsWith("媒资")
                             select a;
        foreach (var i in queryleftesb)
        {
            TreeNode tn = new TreeNode(i.Memo + " " + i.count.ToString(), "");
            tn.SelectAction = TreeNodeSelectAction.None;
            TreeView1.Nodes[2].ChildNodes.Add(tn);
        }

        var queryleftemb = from a in db.wall_complete_task
                          where a.Memo.StartsWith("EMB")
                          select a;
        foreach (var i in queryleftemb)
        {
            TreeNode tn = new TreeNode(i.Memo + " " + i.count.ToString(), "");
            tn.SelectAction = TreeNodeSelectAction.None;
            TreeView1.Nodes[3].ChildNodes.Add(tn);
        }

        //绑定右边的一套流程
        var queryrightyitaoErr = from a in db.wall_task_erro_info
                               where a.task_type.StartsWith("一套") && a.createtime > DateTime.Today && a.description != "Audit_01"
                               select new
                               {
                                   task_err = "images/xx.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = a.status
                               };
        var queryrightyitaoRun = from a in db.wall_task_running_info
                               where a.task_type.StartsWith("一套") && a.createtime > DateTime.Today
                               select new
                               {
                                   task_err = "images/run.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = 1
                               };

        GridViewyitao.DataSource = queryrightyitaoErr.Concat(queryrightyitaoRun).OrderBy(m => m.err_tag).ThenByDescending(m => m.createtime);
        GridViewyitao.DataBind();


        //绑定右边的二套流程
        var queryrightertaoErr = from a in db.wall_task_erro_info
                                 where a.task_type.StartsWith("二套") && a.createtime > DateTime.Today && a.description != "Audit_01"
                               select new
                               {
                                   task_err = "images/xx.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = a.status
                               };
        var queryrightertaoRun = from a in db.wall_task_running_info
                               where a.task_type.StartsWith("二套") && a.createtime > DateTime.Today
                               select new
                               {
                                   task_err = "images/run.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = 1
                               };

        GridViewertao.DataSource = queryrightertaoErr.Concat(queryrightertaoRun).OrderBy(m => m.err_tag).ThenByDescending(m => m.createtime);
        GridViewertao.DataBind();

        //绑定右边的媒资下载流程
        var queryrightesbErr = from a in db.wall_task_erro_info
                                 where a.task_type.StartsWith("ESB") && a.createtime > DateTime.Today
                                 select new
                                 {
                                     task_err = "images/xx.ico",
                                     task_process = a.task_type + "-" + a.description,
                                     createtime = a.createtime,
                                     task_name = a.task_name,
                                     task_guid = a.task_guid,
                                     err_tag = a.status
                                 };
        var queryrightesbRun = from a in db.wall_task_running_info
                                 where a.task_type.StartsWith("ESB") && a.createtime > DateTime.Today
                                 select new
                                 {
                                     task_err = "images/run.ico",
                                     task_process = a.task_type + "-" + a.description,
                                     createtime = a.createtime,
                                     task_name = a.task_name,
                                     task_guid = a.task_guid,
                                     err_tag = 1
                                 };

        GridViewesb.DataSource = queryrightesbErr.Concat(queryrightesbRun).OrderBy(m => m.err_tag).ThenByDescending(m => m.createtime);
        GridViewesb.DataBind();

        //绑定右边的媒资上载流程
        var queryrightshangzaiErr = from a in db.wall_task_erro_info
                               where a.task_type.StartsWith("上载") && a.createtime > DateTime.Today
                               select new
                               {
                                   task_err = "images/xx.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = a.status
                               };
        var queryrightshangzaiRun = from a in db.wall_task_running_info
                               where a.task_type.StartsWith("上载") && a.createtime > DateTime.Today
                               select new
                               {
                                   task_err = "images/run.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = 1
                               };

        GridViewshangzai.DataSource = queryrightshangzaiErr.Concat(queryrightshangzaiRun).OrderBy(m => m.err_tag).ThenByDescending(m => m.createtime);
        GridViewshangzai.DataBind();


        //绑定右边的EMB流程
        var queryrightembErr = from a in db.wall_task_erro_info
                               where a.task_type.StartsWith("EMB") && a.createtime > DateTime.Today
                               select new
                               {
                                   task_err = "images/xx.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = a.status
                               };
        var queryrightembRun = from a in db.wall_task_running_info
                               where a.task_type.StartsWith("EMB") && a.createtime > DateTime.Today
                               select new
                               {
                                   task_err = "images/run.ico",
                                   task_process = a.task_type + "-" + a.description,
                                   createtime = a.createtime,
                                   task_name = a.task_name,
                                   task_guid = a.task_guid,
                                   err_tag = 1
                               };

        GridViewemb.DataSource = queryrightembErr.Concat(queryrightembRun).OrderBy(m => m.err_tag).ThenByDescending(m => m.createtime);
        GridViewemb.DataBind();

    }

    protected void GridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (((HiddenField)e.Row.Cells[0].Controls[2].FindControl("HiddenField1")).Value == "0")
            {
                e.Row.BackColor = System.Drawing.Color.Red;
                e.Row.Attributes["style"] = "Cursor:hand";
                e.Row.Attributes.Add("onclick", "setErr('" + e.Row.Cells[3].Text + "');");

                System.Media.SoundPlayer player = new System.Media.SoundPlayer(AppDomain.CurrentDomain.BaseDirectory + "images\\xx1.wav");
                player.Play();
            }
        }
    }

    [WebMethod]
    public static bool setErr(string guid)
    {
        DataClassesDataContext db = new DataClassesDataContext();
        var query = from a in db.wall_task_erro_info
                    where a.task_guid.ToString() == guid
                    select a;
        if (query.Count() == 1)
        {
            query.First().status = 1;
            db.SubmitChanges();
            return true;
        }
        else
            return false;
    }


    protected string CutString(object obj)
    {
        string inputString = obj.ToString().Trim();
        System.Text.ASCIIEncoding ascii = new System.Text.ASCIIEncoding();
        int tempLen = 0;
        int len = 82;
        string tempString = "";
        byte[] s = ascii.GetBytes(inputString);
        for (int i = 0; i < s.Length; i++)
        {
            if ((int)s[i] == 63)
            {
                tempLen += 2;
            }
            else
            {
                tempLen += 1;
            }
            try
            {
                tempString += inputString.Substring(i, 1);
            }
            catch
            {
                break;
            }
            if (tempLen > len)
                break;
        }
        //如果截过则加上个省略号
        byte[] mybyte = System.Text.Encoding.Default.GetBytes(inputString);
        if (mybyte.Length > len)
            tempString += "…";
        return tempString;
    }

}