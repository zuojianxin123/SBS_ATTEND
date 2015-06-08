<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Change.aspx.cs" Inherits="Change" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style type="text/css"> 
        .modalBackground{background-color:#000;filter:alpha(opacity=80);opacity:0.8;}
        .modalPopup {background-color:#FFF;
            border:3px solid Gray;
            padding:3px;
            width:300px;}
    </style> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
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

    <asp:Panel ID="PanelChange" runat="server" CssClass="modalPopup" Width="300px">
        <div class="normalform">
            <div class="item2">
                <asp:Literal ID="liFormer" runat="server"></asp:Literal>
            </div>
            <div class="item2">
                <asp:DropDownList ID="ddlWorker" runat="server" 
                    Width="200px">
                </asp:DropDownList>
            </div>
            <div class="item2">
                <asp:Literal ID="liFormer1" runat="server"></asp:Literal>
            </div>
            <div class="item2">
                <asp:DropDownList ID="ddlWorker1" runat="server" 
                    Width="200px">
                </asp:DropDownList>
            </div>
            <div class="item2">
                <asp:Button ID="btSave" runat="server" Text="确定" onclick="btSave_Click" 
                    Height="30px" Width="80px" />&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btCancel" runat="server" Text="取消" Height="30px" Width="80px" />
            </div>
        </div>
    </asp:Panel>
    <asp:ModalPopupExtender ID="PanelChange_ModalPopupExtender" runat="server" 
        DynamicServicePath="" Enabled="True" TargetControlID="HiddenFieldDate"
        BackgroundCssClass="modalBackground" PopupControlID="PanelChange"
        CancelControlID="btCancel">
    </asp:ModalPopupExtender>
    <asp:HiddenField ID="HiddenFieldDate" runat="server" />
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
    </asp:ToolkitScriptManager>
</asp:Content>

