<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Http404ErrorPage.aspx.cs" Inherits="IntraTecApp.Http404ErrorPage" %>
<!DOCTYPE HTML>
<html class="no-js">
<head id="Encabezado" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>:: First Central International Bank ::</title>

	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="description" content="First Central International Bank" />
	<meta name="keywords" content="" />
	<meta name="robots" content="index, follow" />
    
	<link href="../images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
    <link rel="shorcut icon" href="../images/favicon.ico" />  

    <link href="../Content/normalize.css" rel="stylesheet" type="text/css" />

    <link href="../styles/PaginaContenido.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="../styles/TablaContenido.css" rel="stylesheet" type="text/css" />
    <link href="../styles/Formularios.css" rel="stylesheet" type="text/css" />
    <link href="../styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

     <!--[if lt IE 9]>
        <script type="text/javascript" src="../scripts/jquery-1.9.1.js"></script>
    <![endif]-->
    <!--[if gte IE 9]><!-->
        <script src="../scripts/jquery-2.0.0.min.js" type="text/javascript"></script>
    <!--<![endif]-->

    <script src="../scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <!--script src="../scripts/Desabilita_Edicion.js" type="text/javascript"></script-->
    <script src="../scripts/modernizr-2.6.2.js" type="text/javascript"></script>    
</head>
<body>
    <form id="frmHttp404ErrorPage" runat="server">
        <div class="container ui-corner-all">
            <div class="content">
                <asp:ScriptManager ID="smgHttp404ErrorPage" runat="server" EnableScriptGlobalization="false" EnablePartialRendering="true" >
                </asp:ScriptManager>
                <asp:Panel ID="pnlDocumento" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                    <asp:Label ID="lblTipoDocumento" runat="server">Error</asp:Label>
                </asp:Panel>
                <asp:UpdateProgress ID="ugpHttp404ErrorPage" runat="server" AssociatedUpdatePanelID="udpHttp404ErrorPage"
                DisplayAfter="0" DynamicLayout="True">
                <ProgressTemplate>
                    <div class="pnlProgressBar">
                        <img alt="" src="../images/imgBarraProgreso.gif" />
                    </div>
                </ProgressTemplate>
                </asp:UpdateProgress>
                <div class="Div10"></div>   
                <asp:UpdatePanel runat="server" ID="udpHttp404ErrorPage" UpdateMode="Conditional" ChildrenAsTriggers="False" >
                    <ContentTemplate>
                        <table class="tablaContenidoFormularioFondoTransparente">
                            <tr>
                                <td class="col100_100 AlCentro" style="background:#FFFFFF;">
                                    <img alt="" src="../images/error-404.jpg" />
                                    <br />
                                    <asp:Label ID="exMessage" runat="server" Font-Bold="true" Font-Size="Large">
                                        Página no encontrada.
                                    </asp:Label>
                                    <br />
                                </td>
                            </tr>  
                            <tr>
                                <td class="col100_100 TitulosGrid">
                                    <label>Ir a <a href="../Index.aspx" target="_top" style="color:#FFFFFF; font-size:12px; font-family:Verdana;">Inicio</a></label>
                                </td>
                            </tr>
                        </table>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </div>
    </form>
</body>
</html>
