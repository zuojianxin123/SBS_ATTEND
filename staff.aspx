<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="staff.aspx.cs" Inherits="staff" StylesheetTheme="Blue"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div align="left">
        <asp:Label ID="lb_name" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="Red" Text="姓名+角色"></asp:Label>
&nbsp;<asp:LinkButton ID="lbtn_logout" runat="server" Font-Size="Large" 
            onclick="lbtn_logout_Click">注销</asp:LinkButton>
        <br />
    <br />
        <asp:Label ID="lb_name0" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="#3366FF" Text="本月调休审批结果"></asp:Label>
        <br />
    <br />
    <asp:GridView ID="gv_overresult" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin"  Width="1000px" >
        <Columns>
            <asp:BoundField DataField="origin" HeaderText="原始调休时间" />
            <asp:BoundField DataField="current" HeaderText="当前调休时间" />
            <asp:BoundField DataField="result" HeaderText="主管审核结果">
            <ItemStyle ForeColor="#FF6600" />
            </asp:BoundField>
        </Columns>
    </asp:GridView>
    <br />
        <asp:Label ID="lb_name1" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="#3366FF" Text="本月请假审批结果"></asp:Label>
        <br />
        <br />
        <asp:GridView ID="gv_leaveresult" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin"  Width="1000px" >
            <Columns>
                <asp:BoundField DataField="starttime" HeaderText="开始时间" />
                <asp:BoundField DataField="endtime" HeaderText="结束时间" />
                <asp:BoundField DataField="result" HeaderText="审批结果">
                <ItemStyle ForeColor="#FF6600" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <br />
    <asp:Label ID="Label1" runat="server" Text="本月调整休息人员表" Font-Bold="True" 
        Font-Italic="False" Font-Size="X-Large" ForeColor="#3366FF"></asp:Label>
        <br />
    <br />
    <asp:Calendar ID="cal_shift" runat="server" Width="100%" Height="500px" 
        ondayrender="calshift_DayRender" BorderColor="#98BF2F" BorderWidth="1px">
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
    <asp:Calendar ID="cal_leave" runat="server" Width="100%" Height="500px" 
        ondayrender="calleave_DayRender" BorderColor="#98BF2F" BorderWidth="1px" 
         Font-Size="22px">
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

