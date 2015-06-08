<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Manage.aspx.cs" Inherits="Manage" StylesheetTheme="Blue" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" 
        EnableScriptGlobalization="True">
    </asp:ToolkitScriptManager>
<div style = "text-align:center; margin-left:auto; margin-right:auto;">
    <div class="titleh1" style="width:400px; margin-left:auto; margin-right:auto;">
    <h1>生成值班表</h1>
    <p>已生成部分将被重新生成</p>
    </div>
    <div class="normalform" style="text-align:left; width:400px; margin-left:auto; margin-right:auto;">
        <div class="item">
            <label class="lab">开始日期：</label>
            <asp:TextBox ID="txtFrom" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" 
                Enabled="True" Format="yyyy-MM-dd" TargetControlID="txtFrom">
            </asp:CalendarExtender>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtFrom" Display="Dynamic" ErrorMessage="开始日期不能为空！" 
                ValidationGroup="1"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToValidate="txtFrom" ErrorMessage="请输入正确的日期格式！" 
                Operator="DataTypeCheck" Display="Dynamic" ValidationGroup="1"></asp:CompareValidator>
        </div>
        <div class="item">
            <label class="lab">结束日期：</label>
            <asp:TextBox ID="txtTo" runat="server"></asp:TextBox>
            <asp:CalendarExtender ID="txtTo_CalendarExtender" runat="server" Enabled="True" 
                Format="yyyy-MM-dd" TargetControlID="txtTo">
            </asp:CalendarExtender>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtTo" Display="Dynamic" ErrorMessage="结束日期不能为空！" 
                ValidationGroup="1"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator2" runat="server" 
                ControlToValidate="txtTo" ErrorMessage="请输入正确的日期格式！" Type="Date" 
                Operator="DataTypeCheck" Display="Dynamic" ValidationGroup="1"></asp:CompareValidator>
        </div>
        <div class="item">
            <label class="lab">算法选择：</label>
            <asp:DropDownList ID="ddlSchedule" runat="server">
                <asp:ListItem Value="0">按人员顺序排列</asp:ListItem>
                <asp:ListItem Value="1">每人向前一天（7个人）</asp:ListItem>
                <asp:ListItem Value="2">每人向前二天（7个人）</asp:ListItem>
                <asp:ListItem Value="3">每轮轮空一人</asp:ListItem>
                <asp:ListItem Value="4">周四、五同一人值班</asp:ListItem>
                <asp:ListItem Value="5">依次排列早晚班</asp:ListItem>
            </asp:DropDownList>
        </div>
        <div class="item">
            <asp:Button ID="btGenerate" runat="server" Text="生成" Width="80px" Height="30px" 
                onclick="btGenerate_Click" ValidationGroup="1" />
        </div>
    </div>
    <br />
    <div class="line_l"></div>
    <br />
    <div class="titleh1" style="width:500px; margin-left:auto; margin-right:auto;">
        <h1>管理值班人员</h1>
        <p></p>
    </div>
    <div class="normalform" style="text-align:left; width:500px; margin-left:auto; margin-right:auto;">
        <div class="item2">
            <asp:GridView ID="GridView1" runat="server" SkinID="gridviewskin" 
                AutoGenerateColumns="False" DataKeyNames="ID" 
                DataSourceID="SqlDataSource1" Width="100%">
                <Columns>
                    <asp:BoundField DataField="username" HeaderText="姓名" SortExpression="username">
                    <HeaderStyle Width="200px" />
                    <ItemStyle Width="200px" />
                    </asp:BoundField>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True">
                    <HeaderStyle Width="200px" />
                    <ItemStyle Width="200px" />
                    </asp:CommandField>
                </Columns>
            </asp:GridView>
        </div>
        <div class="item">
            <label class="lab">增加人员：</label>
            <asp:TextBox ID="txtWorker" runat="server"></asp:TextBox>&nbsp;&nbsp;<asp:Button 
                ID="btAdd" runat="server" Text="增加" Width="50px" onclick="btAdd_Click" 
                ValidationGroup="2" />
        </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConflictDetection="CompareAllValues" 
        ConnectionString="<%$ ConnectionStrings:WorkFlowConnectionString %>" 
        DeleteCommand="DELETE FROM [worker] WHERE [ID] = @original_ID AND (([username] = @original_username) OR ([username] IS NULL AND @original_username IS NULL))" 
        InsertCommand="INSERT INTO [worker] ([username]) VALUES (@username)" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT * FROM [worker] ORDER BY [ID]" 
        UpdateCommand="UPDATE [worker] SET [username] = @username WHERE [ID] = @original_ID AND (([username] = @original_username) OR ([username] IS NULL AND @original_username IS NULL))">
        <DeleteParameters>
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_username" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="original_ID" Type="Int32" />
            <asp:Parameter Name="original_username" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="username" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>
    </div>
</div>
</asp:Content>

