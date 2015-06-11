<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="CommitLeave.aspx.cs" Inherits="Commit" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<div align="left">
 <asp:Label ID="lb_name" runat="server" Font-Bold="True" Font-Size="X-Large" 
            ForeColor="Red" Text="姓名+角色"></asp:Label>
&nbsp;<asp:LinkButton ID="lbtn_back" runat="server" Font-Size="Large" 
            onclick="lbtn_back_Click">返回</asp:LinkButton>
    <br />
</div>
<asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" 
        EnableScriptGlobalization="True">
    </asp:ToolkitScriptManager>
<div class="normalform" style="text-align:left; width:400px; margin-left:auto; margin-right:auto;">
    <div class="titleh1" style="width:400px; margin-left:auto; margin-right:auto;">
    <h1>请假申请表</h1>
    </div>
        <div class="item">
            <label class="lab">开始日期：</label>
            <asp:TextBox ID="txtFrom" runat="server" AutoPostBack="true" 
                ontextchanged="txtFrom_TextChanged"></asp:TextBox>
            &nbsp;
            <asp:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" 
                Enabled="True" Format="yyyy-MM-dd" TargetControlID="txtFrom">
            </asp:CalendarExtender>
            <asp:DropDownList ID="drp_start" runat="server">
                <asp:ListItem Value="上午">上午</asp:ListItem>
                <asp:ListItem Value="下午">下午</asp:ListItem>
            </asp:DropDownList>
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
            <label class="lab">请假理由：</label>
          
            <asp:TextBox ID="tb_leave" runat="server" MaxLength="50" TextMode="MultiLine" 
                Width="213px"></asp:TextBox>
          
        </div>
        <div class="item">
            <asp:Button ID="btleave" runat="server" Text="提交" Width="80px" Height="30px" 
                onclick="btleave_Click" ValidationGroup="1" />
        </div>
    </div>
</asp:Content>

