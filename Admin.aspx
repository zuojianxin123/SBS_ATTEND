<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" StylesheetTheme="Blue"%>

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
         <asp:GridView ID="gv_over" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin"  Width="1000px" >
            <Columns>
                <asp:TemplateField HeaderText="审核">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chb_reivew" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="姓名" DataField="name" />
                <asp:BoundField HeaderText="原始调休" DataField="origin" />
                <asp:BoundField HeaderText="当前调休" DataField="current" />
                <asp:BoundField HeaderText="调休理由" DataField="reason" />
            </Columns>
        </asp:GridView>
        <br />
        <asp:Label ID="lb_over" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="#FF3300" Text="无审批记录！！" Visible="False"></asp:Label>
        <br />
        <br />
        <asp:Button ID="btn_overtime" runat="server" Text="审批调休" Font-Bold="True" 
            Font-Size="Large" onclick="btn_overtime_Click" />
        <br />
        <br />
        <asp:Label ID="lb_name1" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="#3366FF" Text="审批请假"></asp:Label>
        <br />
        <br />
        <asp:GridView ID="gv_leave" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin"  Width="1000px">
            <Columns>
                <asp:TemplateField HeaderText="审核">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="cb_leave" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="name" HeaderText="姓名" />
                <asp:BoundField DataField="starttime" HeaderText="开始时间" />
                <asp:BoundField DataField="endtime" HeaderText="结束时间" />
                <asp:BoundField DataField="reason" HeaderText="请假理由" />
            </Columns>
        </asp:GridView>
        <br />
        <asp:Label ID="lb_leave" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="#FF3300" Text="无审批记录！！" Visible="False"></asp:Label>
        <br />
        <br />
        <asp:Button ID="btn_leave" runat="server" Text="审批请假" Font-Bold="True" 
            Font-Size="Large" onclick="btn_overtime_Click" />
        <br />
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

