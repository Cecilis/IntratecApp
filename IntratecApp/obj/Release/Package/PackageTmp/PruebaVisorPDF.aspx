<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PruebaVisorPDF.aspx.cs" Inherits="IntraTecApp.PruebaVisorPDF" %>
<%@ Register Assembly="PdfViewer" Namespace="PdfViewer" TagPrefix="pdfViewer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>:: First Central International Bank ::</title>

	<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
    <link rel="shorcut icon" href="images/favicon.ico" />  

    <link href="Content/normalize.css" rel="stylesheet" type="text/css" />

    <link href="styles/PaginaContenido.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="styles/TablaContenido.css" rel="stylesheet" type="text/css" />
    <link href="styles/Formularios.css" rel="stylesheet" type="text/css" />
    <link href="styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

     <!--[if lt IE 9]>
        <script type="text/javascript" src="scripts/jquery-1.9.1.js"></script>
    <![endif]-->
    <!--[if gte IE 9]><!-->
        <script src="scripts/jquery-2.0.0.min.js" type="text/javascript"></script>
    <!--<![endif]-->

    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <script src="scripts/Slider.js" type="text/javascript"></script>
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></script-->
    <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>  

    <script type="text/javascript">
        $(document).ready(function () {
            var ancho = $(window).width() * 0.9;
            var alto = $(window).height() * 0.9;
            $(".pvwVerPDF").css("width", ancho);
            $(".pvwVerPDF").css("height", alto);
        });
    </script>

</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0" style="font-family: Calibri" bgcolor="#cccccc">
<form id="form1" runat="server">
    <div class="container ui-corner-all">
        <div class="content">
            <asp:HyperLink ID="hlkPDFViewer" target="_newtab"  runat="server" NavigateUrl="~/Docs/Organigrama.pdf" 
                Style="z-index: 101;right: 24px; position: absolute; top: 96px">
                <img alt="Ver en otra pagina" style="left:10px; width:25px; height:25px;" src="images/fullsize.png" title='Ver en otra pagina' />
            </asp:HyperLink>
            <div>
            <pdfViewer:ShowPdf ID="pvwVerPDF" runat="server" BorderStyle="Inset" BorderWidth="2px" FilePath="~/Docs/Organigrama.pdf"
                Style="z-index: 103; left: 24px; position: absolute; top: 128px" /> 
            </div>
        </div>   
    </div>
</form>
</body>
</html>
