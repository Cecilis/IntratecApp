<%@ Page Language="C#" AutoEventWireup="true"
    Inherits="DialogContentPage" Codebehind="DialogContentPage.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div id="MainContentDiv">
        Dynamic Dialog Page loaded!
        <asp:PlaceHolder ID="DynamicPlaceholder" runat="server"></asp:PlaceHolder>
        <input type="button" id="EvaluateButton" value="Evaluate" class="ButtonStyle" />
        <br /><br />
        <div>
            <asp:Label ID="ResultLabel" runat="server" Height="60px" Width="400px" Style="display: none"></asp:Label>
        </div>
    </div>
    </form>
</body>
</html>
