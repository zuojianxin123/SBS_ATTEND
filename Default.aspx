<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" EnableEventValidation="false" ValidateRequest="false" StyleSheetTheme="Blue"%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script src="js/boxover.js" type="text/javascript"></script>
    <script src="js/ckeditor/ckeditor.js" type="text/javascript"></script>
    <style type="text/css"> 
        .modalBackground{background-color:#000;filter:alpha(opacity=80);opacity:0.8;}
        .modalPopup {background-color:#FFF;
            border:3px solid Gray;
            padding:3px;
            width:500px;}
    </style> 
    <script type="text/javascript">
        function doPrint() {
            var newWin = window.open('printer', '', '');
            var titleHTML = document.getElementById("printdiv").innerHTML;
            newWin.document.write("<br/><br/>" + titleHTML);
            newWin.document.location.reload();
            newWin.print();
            newWin.close();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="True" 
        onselectedindexchanged="ddlType_SelectedIndexChanged">
        <asp:ListItem Value="0">日历样式</asp:ListItem>
        <asp:ListItem Value="1">列表样式</asp:ListItem>
    </asp:DropDownList>&nbsp;&nbsp;
    <input id="btPrint" type="button" value="打印" onclick="doPrint()" style="width:50px" />
    <br />
    <div id = "printdiv">
    <asp:Calendar ID="Calendar1" runat="server" Width="100%" Height="500px" 
        ondayrender="Calendar1_DayRender" BorderColor="#98BF2F" BorderWidth="1px" 
        onselectionchanged="Calendar1_SelectionChanged">
        <SelectedDayStyle BackColor="#D3EBF6" BorderColor="#98CBF2"  
            BorderStyle="Solid" BorderWidth="2px"
            ForeColor="Black" />
        <WeekendDayStyle BackColor="#FED6D2" ForeColor="#0B67A9" />
        <TodayDayStyle
            BackColor="#C6E7FF" ForeColor="Red" Font-Bold="True" Font-Size="18px" />
        <DayStyle ForeColor="#0B67A9" Font-Bold="True" Font-Size="16px" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" />
        <DayHeaderStyle BackColor="#F6FAFF" ForeColor="#4D90C0" />
        <TitleStyle BackColor="#66BFEE" BorderColor="#EAF0F7" BorderStyle="Solid" BorderWidth="3px"
            Font-Bold="True" Font-Size="16px" ForeColor="White" />
    </asp:Calendar>

    <asp:Panel ID="Panel1" runat="server" style="text-align:center;">
        <asp:DropDownList ID="ddlYear" runat="server" DataSourceID="SqlDataSource1" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True">
        </asp:DropDownList>年 &nbsp&nbsp&nbsp;
        <asp:DropDownList ID="ddlMonth" runat="server" AutoPostBack="True">
            <asp:ListItem>1</asp:ListItem>
            <asp:ListItem>2</asp:ListItem>
            <asp:ListItem>3</asp:ListItem>
            <asp:ListItem>4</asp:ListItem>
            <asp:ListItem>5</asp:ListItem>
            <asp:ListItem>6</asp:ListItem>
            <asp:ListItem>7</asp:ListItem>
            <asp:ListItem>8</asp:ListItem>
            <asp:ListItem>9</asp:ListItem>
            <asp:ListItem>10</asp:ListItem>
            <asp:ListItem>11</asp:ListItem>
            <asp:ListItem>12</asp:ListItem>
        </asp:DropDownList>月<br />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:WorkFlowConnectionString %>" SelectCommand="SELECT distinct DATEPART(year,[worktime]) FROM [WorkFlow].[dbo].[workhistory]"></asp:SqlDataSource>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin" OnRowDataBound="GridView1_RowDataBound1" 
            DataSourceID="SqlDataSource2" Width="1000px" 
            onselectedindexchanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="星期" HeaderText="星期" SortExpression="星期">
                    <ItemStyle HorizontalAlign="Center" Width="200px" Font-Size="Large" />
                    <HeaderStyle HorizontalAlign="Center" Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="日期" HeaderText="日期" SortExpression="日期">
                    <ItemStyle HorizontalAlign="Center" Width="200px" Font-Size="Large" />
                    <HeaderStyle HorizontalAlign="Center" Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="值班人员" HeaderText="值班人员" SortExpression="值班人员" >
                    <ItemStyle HorizontalAlign="Left" Width="400px" Font-Size="Large" />
                    <HeaderStyle HorizontalAlign="Center" Width="400px" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="值班内容记录" SortExpression="值班内容记录" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("值班内容记录") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label2" runat="server" Text='<%# CutString(Eval("值班内容记录")) %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Left" Width="400px" />
                    <HeaderStyle HorizontalAlign="Center" Width="400px" />
                </asp:TemplateField>
                <asp:BoundField DataField="状态" HeaderText="状态" SortExpression="状态" 
                    Visible="False" >
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                    <HeaderStyle HorizontalAlign="Center" Width="50px" />
                </asp:BoundField>
            </Columns>
            <RowStyle Height="35px" />
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:WorkFlowConnectionString %>"
            
            SelectCommand="select id,datename(weekday,worktime) '星期',convert(varchar(10),worktime,120)'日期','早班：'+ISNULL(worker, '')+'　晚班：'+ISNULL(worker1, '') as '值班人员','制作网：'+isnull(workcontent1,'')+' ；日常：'+isnull(workcontent,'') '值班内容记录',workstatus '状态'from workhistory WHERE YEAR(WORKTIME)=@year and month(worktime)=@month ORDER BY [worktime], [id]">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlYear" Name="year" 
                    PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="ddlMonth" Name="month" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
    </asp:Panel>
    </div>
    <asp:Panel ID="PanelLog" runat="server" CssClass="modalPopup" Width="500px">
        <div class="normalform" style="text-align:left;">
        <div class="item">
            <label class="lab">值班者：</label>
            <asp:Literal ID="liWorker" runat="server"></asp:Literal>
        </div>
        <div class="item">
            <label class="lab">日期：</label>
            <asp:Literal ID="liDate" runat="server"></asp:Literal>
        </div>
        <div class="item">
            <label class="lab">业务网：</label>
            <asp:TextBox ID="txtContent1" runat="server" TextMode="MultiLine"></asp:TextBox>
            <script type="text/javascript">
                CKEDITOR.replace('ctl00_ContentPlaceHolder1_txtContent1', { toolbar: 'Basic' });
            </script>
        </div>
        <div class="item">
            <label class="lab">值班工作：</label>
            <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine"></asp:TextBox>
            <script type="text/javascript">
                CKEDITOR.replace('ctl00_ContentPlaceHolder1_txtContent', { toolbar: 'Basic' });
            </script>
        </div>
        <div class="item">
            <asp:Button ID="btSave" runat="server" Text="保存" onclick="btSave_Click" 
                Height="30px" Width="80px" />&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btCancel" runat="server" Text="取消" Height="30px" Width="80px" />
        </div>
        </div>
    </asp:Panel>
    <asp:ModalPopupExtender ID="PanelLog_ModalPopupExtender" runat="server" 
        DynamicServicePath="" Enabled="True" TargetControlID="HiddenFieldDate"
        BackgroundCssClass="modalBackground" PopupControlID="PanelLog"
        CancelControlID="btCancel">
    </asp:ModalPopupExtender>
    <asp:HiddenField ID="HiddenFieldDate" runat="server" />
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
</asp:Content>

