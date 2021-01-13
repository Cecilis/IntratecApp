<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisorPDF.aspx.cs" Inherits="IntraTecApp.VisorPDF"  MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="PdfViewer" Namespace="PdfViewer" TagPrefix="pdfViewer" %>
<!DOCTYPE HTML>
<html class="no-js">
<head id="Encabezado" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>:: First Central International Bank ::</title>

	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="description" content="First Central International Bank" />
	<meta name="keywords" content="" />
	<meta name="robots" content="index, follow" />

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
    
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></scr>pt-->
    <script type="text/javascript">
        $(document).ready(function () {
            var ancho = $(window).width();
            var alto = $(window).height();
            $("#container").css("width", ancho * 0.97);
            $("#container").css("height", alto * 0.99);

            $("#content").css("width", ancho * 0.97);
            $("#content").css("height", alto * 0.95);

            $("#flsDocumentos").css("height", alto * 0.94);

            $("#pvwVerPDF div").css("width", ancho);
            $("#pvwVerPDF div").css("height", alto * 0.94);

        });
    </script>

    <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>
</head>
<body >
<form id="frmVisorPDF" runat="server" >
    <div class="container ui-corner-all" id="container">
        <div class="content ui-corner-all" id="content">
        <asp:ScriptManager ID="smgVisorPDF" runat="server">
        </asp:ScriptManager>
        <asp:Panel ID="pnlVisorPDF" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="99%">
            <asp:Label ID="lblNombreArchivo" runat="server"></asp:Label>
            <asp:HyperLink ID="hlkPDFViewer" target="_newtab"  runat="server" CssClass="fltrt">
                <img alt="Ver en otra pagina" style="left:10px; width:25px; height:25px;" src="images/fullsize.png" title='Ver en otra pagina' />
            </asp:HyperLink>
        </asp:Panel>
        <asp:UpdateProgress ID="udpDocumento" runat="server" AssociatedUpdatePanelID="udpDocumentos"
            DisplayAfter="0" DynamicLayout="True">
            <ProgressTemplate>
                <div class="pnlProgressBar">
                    <img alt="" src="../images/imgBarraProgreso.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>        
    <div class="Div10"></div>     
        <asp:UpdatePanel ID="udpDocumentos" runat="server" Width="100%" CssClass="PanelNoBorde">
            <ContentTemplate>
                <asp:HiddenField ID="hdnTipoConsulta" runat="server" />
                <fieldset id="flsDocumentos" class="FieldSet FieldSetClaro ui-corner-all" style="height:100%;" >
                    <iframe runat="server" id="ifrmVisorPDF" src="<%=hlkPDFViewer.NavigateUrl %>" style="border:1px solid #CCCCCC; margin-bottom:10px;" frameborder="1" scrolling="auto" height="100%" width="100%" ></iframe>                     
                </fieldset>
            </ContentTemplate>
        </asp:UpdatePanel>
        </div>
    </div>
</form>
</body>
</html>
