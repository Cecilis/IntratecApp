<%@ Page Language="C#" AutoEventWireup="true" Inherits="_Default" Codebehind="Parent.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

     <script src="scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
  

    <script src="scripts/jquery-ui-1.8.17.custom.min.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

    <script src="scripts/ModalSearchPopUp.js" type="text/javascript"></script>

    <link href="styles/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css" />
    <link href="styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />


    <style type="text/css">
        .ButtonStyle
        {
            border: thin solid #C6C3DE;
            background-color: #ECEBFA;
            margin-left: 5px;
            width: auto;
            height: 25px;
            padding-left: 5px;
            padding-right: 5px;
            font-size: 13px;
            font-weight: bold;
            padding-top: 3px;
            padding-bottom: 3px;
            text-align: center;
            color: #636363;
            border-radius: 5px;
            -webkit-border-radius: 5px;
            -moz-border-radius: 5px;
        }
        .ButtonStyle:hover
        {
            border-color: #726E96;
            color: #636363;
            cursor: pointer;
        }
        .DynamicDialogStyle
        {
            background-color: #F7FAFE;
            font-size: small;
        }
        label
        {
            width: 100px;
        }
    </style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>
            
            <div>
                <label for="Input1">
                    Rows
                    <input type="text" id="Input1" value="1" />
                </label>
                <label for="Input2">
                    Columns
                    <input type="text" id="Input2" value="2" />
                </label>
                <br />
                <br />
                <input type="button" id="LoadDialogButton" value="Open Dialog" class="ButtonStyle" />
                <asp:Button ID="ServerButton" Text="Server Dummy Button" runat="server" OnClick="DoSomethingOnServer"
                    CssClass="ButtonStyle" />
                <input type="button" id="LoadLocalDialog" value="Open Local Dialog" class="ButtonStyle" />
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
    <div id='LocalDialogModal' style="display: none">
        <span style="font-style: italic; font-size: x-small; color: Gray;">Note: This is a
            jQuery modal dialog which does not have dynamic content but this content has server
            side elements, and is defined in the parent page
            <br />
            <asp:Label ID="lblNewName" runat="server" AssociatedControlID="TextBox_NewEmployeeName"
                Text="Employee Name: "></asp:Label>
            <asp:TextBox ID="TextBox_NewEmployeeName" runat="server" Width="100%"></asp:TextBox><br />
            <br />
            <asp:Button ID="SaveEmployee_Button" OnClick="SaveEmployeeBtn_Click" runat="server"
                Text="Save" CssClass="ButtonStyle" Style="margin: 0px;" /><br />
    </div>
    </form>
</body>
</html>
