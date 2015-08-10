<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CommitOver.aspx.cs" Inherits="CommitOver" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div align="left">
<asp:Label ID="lb_name" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="Red" Text="姓名+角色"></asp:Label>
&nbsp;<asp:LinkButton ID="lbtn_back" runat="server" Font-Size="Large" 
            onclick="lbtn_back_Click">返回</asp:LinkButton>
</div>
<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" 
        EnableScriptGlobalization="True">
    </asp:ToolkitScriptManager>

<div class="normalform" style="text-align:left; width:600px; margin-left:auto; margin-right:auto;">
 <h1>您当月调休的汇总</h1>
 <asp:Calendar ID="show_shift" runat="server" Width="100%" Height="300px" 
        ondayrender="showshift_DayRender" BorderColor="#98BF2F" BorderWidth="1px">
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
    </div>
    <div class="normalform" style="text-align:left; width:400px; margin-left:auto; margin-right:auto;">
    <div class="titleh1" style="width:400px; margin-left:auto; margin-right:auto;">  
    <h1>当月调休申请表</h1>
    </div>
        <div class="item">
            <label class="lab">原始调休：</label>
            &nbsp;<asp:DropDownList ID="drp_orgin" runat="server" Height="20px" 
                Width="138px" onselectedindexchanged="drp_orgin_SelectedIndexChanged" AutoPostBack="true">
            </asp:DropDownList>
&nbsp;</div>
        <div class="item">
            <label class="lab">当前调休：</label>
            <asp:TextBox ID="txtTo" runat="server"></asp:TextBox>
            &nbsp;
            <asp:CalendarExtender ID="txtTo_CalendarExtender" runat="server" Enabled="True" 
                Format="yyyy-MM-dd" TargetControlID="txtTo">
            </asp:CalendarExtender>
            <asp:DropDownList ID="drp_end" runat="server">
                <asp:ListItem Value="上午">上午</asp:ListItem>
                <asp:ListItem Value="下午">下午</asp:ListItem>
            </asp:DropDownList>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtTo" Display="Dynamic" ErrorMessage="结束日期不能为空！" 
                ValidationGroup="1"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator2" runat="server" 
                ControlToValidate="txtTo" ErrorMessage="请输入正确的日期格式！" Type="Date" 
                Operator="DataTypeCheck" Display="Dynamic" ValidationGroup="1"></asp:CompareValidator>
        </div>
        <div class="item">
            <label class="lab">调休理由：</label>
          
            <asp:TextBox ID="tb_leave" runat="server" MaxLength="50" TextMode="MultiLine" 
                Width="213px"></asp:TextBox>
          
        </div>
        <div class="item">
            <asp:Button ID="btleave" runat="server" Text="提交" Width="80px" Height="30px" 
                onclick="btleave_Click" ValidationGroup="1" />
        </div>
    </div>
</asp:Content>

