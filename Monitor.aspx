<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Monitor.aspx.cs" Inherits="Monitor" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>生产网监控</title>
    <style type="text/css"> 
        body{
        text-align:center;
        font-family:arial,verdana,sans-serif;
        }
        #header{
        width:1330px;
        margin-right: auto;
        margin-left: auto; 
        padding: 10px;
        height:66px;
        text-align:left;
        font-size:40pt;
        text-align:center;
        }
        #contain{
        margin-right: auto;
        margin-left: auto;
        width: 1330px;
        }
        #mainbg{
        width:1330px;
        padding: 0px;
        float: left;
        }
        .right{
        float: right; 
        padding:2px; 
        width: 1052px; 
        text-align:left;
        }
        .left{
        float: left; 
        padding: 2px; 
        width: 270px;
        text-align:left;
        }
        #footer{
        clear:both;
        width:1330px;
        padding-top: 20px;
        margin-right: auto;
        margin-left: auto; 
        height:68px;
        text-align:right;}
        .text{margin:2px;padding:2px;border-style:outset; border-width:1px; font-size:small;}
    </style> 
    <script type="text/javascript">
        function showLocale(objD) {
            var str, colorhead, colorfoot;
            var yy = objD.getYear();
            if (yy < 1900) yy = yy + 1900;
            var MM = objD.getMonth() + 1;
            if (MM < 10) MM = '0' + MM;
            var dd = objD.getDate();
            if (dd < 10) dd = '0' + dd;
            var hh = objD.getHours();
            if (hh < 10) hh = '0' + hh;
            var mm = objD.getMinutes();
            if (mm < 10) mm = '0' + mm;
            var ss = objD.getSeconds();
            if (ss < 10) ss = '0' + ss;
            var ww = objD.getDay();
            if (ww == 0) colorhead = "<font color=\"#FF0000\">";
            if (ww > 0 && ww < 6) colorhead = "<font color=\"#373737\">";
            if (ww == 6) colorhead = "<font color=\"#008000\">";
            if (ww == 0) ww = "星期日";
            if (ww == 1) ww = "星期一";
            if (ww == 2) ww = "星期二";
            if (ww == 3) ww = "星期三";
            if (ww == 4) ww = "星期四";
            if (ww == 5) ww = "星期五";
            if (ww == 6) ww = "星期六";
            colorfoot = "</font>"
            str = yy + "-" + MM + "-" + dd + "  " + ww + "</br><div style='font-size:65px;'>" + hh + ":" + mm + ":" + ss + "</div>";
            return (str);
        }
        function tick() {
            var today;
            today = new Date();
            document.getElementById("localtime").innerHTML = showLocale(today);
            window.setTimeout("tick()", 1000);
        }

        function SetRefresh(value) {
            var int = document.getElementById("selRefresh").options[document.getElementById("selRefresh").selectedIndex].value;
            if (int != 0)
                location = "Monitor.aspx?interval=" + int;
            else
                clearTimeout(timeout);
        }

        var timeout;
        function AutoRefresh() {
            var int = GetQueryString("interval");
            if (int == 5)
                document.getElementById("selRefresh").selectedIndex = 0;
            else
                if (int == 30 || int == null)
                    document.getElementById("selRefresh").selectedIndex = 1;
                else
                    if (int == 60)
                        document.getElementById("selRefresh").selectedIndex = 2;
                    else
                        if (int == 180)
                            document.getElementById("selRefresh").selectedIndex = 3;
                        else
                            document.getElementById("selRefresh").selectedIndex = 4;
            if (int == null || int == 0)
                timeout = setTimeout("ManualRefresh()", 30 * 1000);
            else
                timeout = setTimeout("ManualRefresh()", int * 1000);
        }

        function ManualRefresh(value) {
            var int = document.getElementById("selRefresh").options[document.getElementById("selRefresh").selectedIndex].value;
            location = "Monitor.aspx?interval=" + int;
        }

        function setErr(guid) {
            PageMethods.setErr(guid, ManualRefresh);
        }

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return r[2]; return null;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
<%--<div id="header">生产网监控</div>--%>
<div id="contain">
<div id="mainbg">
<div class="right">

<div class="text" style="overflow:auto;height:141px;">
    <asp:GridView ID="GridViewyitao" runat="server" AutoGenerateColumns="False" 
        Width="1700px" onrowdatabound="GridView_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="任务状态">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("task_process") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Bind("task_err") %>' />
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("task_process") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" 
                        Value='<%# Bind("err_tag") %>' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="400px" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="时间" DataField="createtime" DataFormatString="{0:T}">
            <HeaderStyle Width="100px" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="任务名称">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("task_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# CutString(Eval("task_name")) %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="700px" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="GUID" DataField="task_guid">
            <HeaderStyle Width="500px" HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <div style="font-size:15pt;">一套流程</div>
        </EmptyDataTemplate>
        <HeaderStyle Font-Size="Small" />
        <RowStyle Font-Size="12pt" />
    </asp:GridView>
</div>

<div class="text"style="overflow:auto;height:141px;">
    <asp:GridView ID="GridViewertao" runat="server" AutoGenerateColumns="False" 
        Width="1700px" onrowdatabound="GridView_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="任务状态">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("task_process") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Bind("task_err") %>' />
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("task_process") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" 
                        Value='<%# Bind("err_tag") %>' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="400px" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="时间" DataField="createtime" DataFormatString="{0:T}">
            <HeaderStyle Width="100px" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="任务名称">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("task_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# CutString(Eval("task_name")) %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="700px" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="GUID" DataField="task_guid">
            <HeaderStyle Width="500px" HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <div style="font-size:15pt;">二套流程</div>
        </EmptyDataTemplate>
        <HeaderStyle Font-Size="Small" />
        <RowStyle Font-Size="12pt" />
    </asp:GridView>
</div>

<div class="text"style="overflow:auto;height:141px;">
    <asp:GridView ID="GridViewesb" runat="server" AutoGenerateColumns="False" 
        Width="1700px" onrowdatabound="GridView_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="任务状态">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("task_process") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Bind("task_err") %>' />
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("task_process") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" 
                        Value='<%# Bind("err_tag") %>' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="400px" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="时间" DataField="createtime" DataFormatString="{0:T}">
            <HeaderStyle Width="100px" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="任务名称">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("task_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# CutString(Eval("task_name")) %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="700px" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="GUID" DataField="task_guid">
            <HeaderStyle Width="500px" HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <div style="font-size:15pt;">媒资下载流程</div>
        </EmptyDataTemplate>
        <HeaderStyle Font-Size="Small" />
        <RowStyle Font-Size="12pt" />
    </asp:GridView>
</div>

<div class="text"style="overflow:auto;height:141px;">
    <asp:GridView ID="GridViewshangzai" runat="server" AutoGenerateColumns="False" 
         Width="1700px" onrowdatabound="GridView_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="任务状态">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("task_process") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Bind("task_err") %>' />
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("task_process") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" 
                        Value='<%# Bind("err_tag") %>' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="400px" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="时间" DataField="createtime" DataFormatString="{0:T}">
            <HeaderStyle Width="100px" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="任务名称">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("task_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# CutString(Eval("task_name")) %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="700px" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="GUID" DataField="task_guid">
            <HeaderStyle Width="500px" HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <div style="font-size:15pt;">媒资上载流程</div>
        </EmptyDataTemplate>
        <HeaderStyle Font-Size="Small" />
        <RowStyle Font-Size="12pt" />
    </asp:GridView>
</div>

<div class="text"style="overflow:auto;height:141px;">
    <asp:GridView ID="GridViewemb" runat="server" AutoGenerateColumns="False" 
        Width="1700px" onrowdatabound="GridView_RowDataBound">
        <Columns>
            <asp:TemplateField HeaderText="任务状态">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("task_process") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Bind("task_err") %>' />
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("task_process") %>'></asp:Label>
                    <asp:HiddenField ID="HiddenField1" runat="server" 
                        Value='<%# Bind("err_tag") %>' />
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="400px" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="时间" DataField="createtime" DataFormatString="{0:T}">
            <HeaderStyle Width="100px" HorizontalAlign="Left" />
            </asp:BoundField>
            <asp:TemplateField HeaderText="任务名称">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("task_name") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" 
                        Text='<%# CutString(Eval("task_name")) %>'></asp:Label>
                </ItemTemplate>
                <HeaderStyle HorizontalAlign="Left" Width="700px" />
                <ItemStyle Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField HeaderText="GUID" DataField="task_guid">
            <HeaderStyle Width="500px" HorizontalAlign="Left" />
            </asp:BoundField>
        </Columns>
        <EmptyDataTemplate>
            <div style="font-size:15pt;">EMB流程</div>
        </EmptyDataTemplate>
        <HeaderStyle Font-Size="Small" />
        <RowStyle Font-Size="12pt" />
    </asp:GridView>
</div>
</div>
<div class="left">
<div class="text"style="height:141px; text-align:center;vertical-align:middle;">
    <span id="localtime" style="font-size:30px;"></span>
</div>

<div class="text"style="height:588px;">
    <asp:TreeView ID="TreeView1" runat="server" Font-Size="XX-Large" 
        ImageSet="BulletedList2" ShowExpandCollapse="False">
        <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />
        <NodeStyle Font-Names="Verdana" Font-Size="22pt" ForeColor="Black" 
            HorizontalPadding="0px" NodeSpacing="0px" VerticalPadding="0px" />
        <ParentNodeStyle Font-Bold="False" />
        <SelectedNodeStyle Font-Underline="True" ForeColor="#5555DD" 
            HorizontalPadding="0px" VerticalPadding="0px" />
    </asp:TreeView>
</div>

</div>

</div>
</div>
<div id="footer">
<select id="selRefresh" onchange="SetRefresh(this.value)">  
  <option value ="5">5S</option>  
  <option value ="30" selected="selected">30S</option>  
  <option value="60">1min</option>  
  <option value="180">3min</option>
  <option value="0">不刷新</option> 
</select>
    <input id="btRefresh" type="button" value="手动刷新" onclick="ManualRefresh();" />
<script type="text/javascript">
    AutoRefresh();
    tick();
</script>
    <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True">
    </asp:ScriptManager>
</div>
</form>
</body>
</html>
