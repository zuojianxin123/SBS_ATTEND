<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="SBSLogin.aspx.cs" Inherits="SBSLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div style="text-align:center">
  
    <table ID="Table1" runat="server" 
        style="width:300px;margin:auto; z-index: auto;">
    <tr align="justify">
        <td style="width:100px" align="right">
        <asp:Label ID="Label1" runat="server" Text="用户名:"></asp:Label>  
        </td>
        <td>
        <asp:TextBox ID="tb_name" runat="server" Width="180px"></asp:TextBox>
        </td>
    </tr>
    <tr align="justify">
        <td style="width:100px" align="right">
        <asp:Label ID="Label2" runat="server" Text="密码:"></asp:Label>  
        </td>
        <td>
        <asp:TextBox ID="tb_pwd" runat="server" Width="180px" TextMode="Password"></asp:TextBox>
        </td>
    </tr>
    <tr>
    <td colspan="2" align="center">

        <asp:Button ID="btn_login" runat="server" Text="登录" onclick="btn_login_Click" />
        &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btn_quit" runat="server" Text="返回" onclick="btn_quit_Click" />

    </td>
    </tr>
    </table>
  

    </div>
</asp:Content>

