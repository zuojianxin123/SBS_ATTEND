<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SYSADMIN.aspx.cs" Inherits="SYSADMIN" StylesheetTheme="Blue"%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div align="left">
<asp:Label ID="lb_name" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="Red" Text="管理员登录"></asp:Label>
&nbsp;<asp:LinkButton ID="lbtn_back" runat="server" Font-Size="Large" 
            onclick="lbtn_back_Click">返回</asp:LinkButton>
    <br />
    <br />
    <asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Size="Large" 
        ForeColor="#3366FF" Text="请假表格："></asp:Label>
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin"  Width="1000px"  DataKeyNames="ID" 
        DataSourceID="SqlDataSource1" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="编号" InsertVisible="False" 
                ReadOnly="True" SortExpression="ID" />
            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
            <asp:BoundField DataField="starttime" HeaderText="开始时间" 
                SortExpression="starttime" DataFormatString="{0:D}" HtmlEncode="False" />
            <asp:BoundField DataField="originweek" HeaderText="开始星期几" 
                SortExpression="originweek" />
            <asp:BoundField DataField="originshift" HeaderText="开始班次" 
                SortExpression="originshift" />
            <asp:BoundField DataField="endtime" HeaderText="结束时间" 
                SortExpression="endtime" DataFormatString="{0:D}" HtmlEncode="False" />
            <asp:BoundField DataField="currentweek" HeaderText="结束星期几" 
                SortExpression="currentweek" />
            <asp:BoundField DataField="currentshift" HeaderText="结束班次" 
                SortExpression="currentshift" />
            <asp:BoundField DataField="reason" HeaderText="请假理由" SortExpression="reason" />
            <asp:BoundField DataField="approve" HeaderText="审批结果" 
                SortExpression="approve" />
            <asp:CommandField ShowEditButton="True" />
            <asp:CommandField ShowDeleteButton="True" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:WorkFlowConnectionString %>" 
        SelectCommand="SELECT * FROM [workoff]" DeleteCommand="delete from workoff
where ID=@ID" 
        
            UpdateCommand="UPDATE workoff SET name = @name, starttime = @starttime, endtime = @endtime, originshift = @originshift, currentshift = @currentshift, originweek = @originweek, currentweek = @currentweek, reason = @reason, approve = @approve WHERE (ID = @ID)">
        <DeleteParameters>
            <asp:ControlParameter ControlID="GridView1" Name="ID" 
                PropertyName="SelectedValue" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="name" />
            <asp:Parameter Name="starttime" />
            <asp:Parameter Name="endtime" />
            <asp:Parameter Name="originshift" />
            <asp:Parameter Name="currentshift" />
            <asp:Parameter Name="originweek" />
            <asp:Parameter Name="currentweek" />
            <asp:Parameter Name="reason" />
            <asp:Parameter Name="approve" />
            <asp:Parameter Name="ID" />
        </UpdateParameters>
    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WorkFlowConnectionString %>" 
            DeleteCommand="DELETE FROM overtime WHERE (ID = @ID)" 
            SelectCommand="SELECT ID, name, originwork, overwork, origin_shift, current_shift, origin_week, current_week, reason, approve FROM overtime" 
            UpdateCommand="UPDATE overtime SET name = @name, originwork = @originwork, overwork = @overwork, origin_shift = @origin_shift, current_shift = @current_shift, origin_week = @origin_week, current_week = @current_week, reason = @reason, approve = @approve WHERE (ID = @ID)">
            <DeleteParameters>
                <asp:ControlParameter ControlID="GridView2" Name="ID" 
                    PropertyName="SelectedValue" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" />
                <asp:Parameter Name="originwork" />
                <asp:Parameter Name="overwork" />
                <asp:Parameter Name="origin_shift" />
                <asp:Parameter Name="current_shift" />
                <asp:Parameter Name="origin_week" />
                <asp:Parameter Name="current_week" />
                <asp:Parameter Name="reason" />
                <asp:Parameter Name="approve" />
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Large" 
        ForeColor="#3366FF" Text="调休表格："></asp:Label>
        <br />
        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin"  Width="1000px" AllowPaging="True" 
            AllowSorting="True" DataKeyNames="ID" DataSourceID="SqlDataSource2">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="编号" InsertVisible="False" 
                    ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
                <asp:BoundField DataField="originwork" DataFormatString="{0:D}" 
                    HeaderText="原始调休日期" HtmlEncode="False" SortExpression="originwork" />
                <asp:BoundField DataField="origin_week" HeaderText="原始星期几" 
                    SortExpression="origin_week" />
                <asp:BoundField DataField="origin_shift" HeaderText="原始调休班次" 
                    SortExpression="origin_shift" />
                <asp:BoundField DataField="overwork" DataFormatString="{0:D}" 
                    HeaderText="当前调休日期" HtmlEncode="False" SortExpression="overwork" />
                <asp:BoundField DataField="current_week" HeaderText="当前星期几" 
                    SortExpression="current_week" />
                <asp:BoundField DataField="current_shift" HeaderText="当前调休班次" 
                    SortExpression="current_shift" />
                <asp:BoundField DataField="reason" HeaderText="调休理由" SortExpression="reason" />
                <asp:BoundField DataField="approve" HeaderText="调休审批结果" 
                    SortExpression="approve" />
                <asp:CommandField ShowEditButton="True" />
                <asp:CommandField ShowDeleteButton="True" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
            ConnectionString="<%$ ConnectionStrings:WorkFlowConnectionString %>" 
            DeleteCommand="DELETE FROM jiaban WHERE (ID = @ID)" 
            SelectCommand="SELECT * FROM [jiaban]" 
            
            UpdateCommand="UPDATE jiaban SET name = @name, starttime = @starttime, endtime = @endtime, startshift = @startshit, endshift = @endshift, startweek = @startweek, [content] = @content, endweek = @endweek, approve = @approve WHERE (ID = @ID)">
            <DeleteParameters>
                <asp:Parameter Name="ID" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="name" />
                <asp:Parameter Name="starttime" />
                <asp:Parameter Name="endtime" />
                <asp:Parameter Name="startshit" />
                <asp:Parameter Name="endshift" />
                <asp:Parameter Name="startweek" />
                <asp:Parameter Name="content" />
                <asp:Parameter Name="endweek" />
                <asp:Parameter Name="approve" />
                <asp:Parameter Name="ID" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <br />
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False"
            SkinID="gridviewskin"  Width="1000px" AllowPaging="True" 
            AllowSorting="True" DataKeyNames="ID" DataSourceID="SqlDataSource3">
            <Columns>
                <asp:BoundField DataField="ID" HeaderText="编号" InsertVisible="False" 
                    ReadOnly="True" SortExpression="ID" />
                <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
                <asp:BoundField DataField="starttime" 
                    HeaderText="加班起始时间" SortExpression="starttime" />
                <asp:BoundField DataField="endtime" HeaderText="加班结束时间" 
                    SortExpression="endtime" />
                <asp:BoundField DataField="startshift" HeaderText="加班起始班次" 
                    SortExpression="startshift" />
                <asp:BoundField DataField="endshift" 
                    HeaderText="加班结束班次" SortExpression="endshift" />
                <asp:BoundField DataField="startweek" HeaderText="原始星期几" 
                    SortExpression="startweek" />
                <asp:BoundField DataField="endweek" HeaderText="当前星期几" 
                    SortExpression="endweek" />
                <asp:BoundField DataField="content" HeaderText="工作内容" 
                    SortExpression="content" />
                <asp:BoundField DataField="approve" HeaderText="加班审批结果" 
                    SortExpression="approve" />
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
            </Columns>
        </asp:GridView>
</div>
</asp:Content>

