<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div align="left">
        <asp:Label ID="lb_name" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="Red" Text="姓名+角色"></asp:Label>
&nbsp;&nbsp;
        <asp:LinkButton ID="lbtn_logout" runat="server" Font-Size="Large" 
            onclick="lbtn_logout_Click">注销</asp:LinkButton>
        <br />
        <br />
        <asp:Label ID="lb_name0" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="#3366FF" Text="审批调休"></asp:Label>
        <br />
        <br />
        <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" 
            GridLines="None">
            <AlternatingRowStyle BackColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <RowStyle BackColor="#EFF3FB" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <SortedAscendingCellStyle BackColor="#F5F7FB" />
            <SortedAscendingHeaderStyle BackColor="#6D95E1" />
            <SortedDescendingCellStyle BackColor="#E9EBEF" />
            <SortedDescendingHeaderStyle BackColor="#4870BE" />
        </asp:GridView>
        <br />
        <asp:Button ID="btn_overtime" runat="server" Text="审批调休" />
        <br />
        <br />
    <asp:Label ID="Label1" runat="server" Text="本月调整休息人员表" Font-Bold="True" 
        Font-Italic="False" Font-Size="X-Large" ForeColor="#3366FF"></asp:Label>
    <br />
    <br />
    <asp:Calendar ID="cal_shift" runat="server" Width="100%" Height="500px" 
        ondayrender="calshift_DayRender" BorderColor="#98BF2F" BorderWidth="1px" 
        onselectionchanged="calshift_SelectionChanged">
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
    <br />
     <asp:Label ID="Label2" runat="server" Text="本月请假人员表" Font-Bold="True" 
        Font-Italic="False" Font-Size="X-Large" ForeColor="#3366FF"></asp:Label>
        <br />
    <br />
    <asp:Calendar ID="cal_leave" runat="server" Width="100%" Height="500px" 
        ondayrender="calleave_DayRender" BorderColor="#98BF2F" BorderWidth="1px" 
        onselectionchanged="calleave_SelectionChanged" Font-Size="22px">
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
</asp:Content>

