<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogOut.aspx.cs" Inherits="IntraTecApp.LogOut" %>
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

    <script type='text/javascript'>
        $(document).ready(function () {
            $("#btnReIngresar").click(function () {
                document.location.href = 'Login.aspx';
            });
        });
    </script>

   <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>
</head>
<body>
    <form id="frmLogin" runat="server">
    <div class="container ui-corner-all">
        <div class="content">
        <asp:Panel ID="pnlUbicacion" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
            <asp:Label ID="lblSesion" runat="server"> Autenticación </asp:Label>
        </asp:Panel>
        <asp:Panel ID="pnlUbicacionDatos" runat="server" Width="100%" CssClass="PanelNoBorde">
        <div class="Div10"></div>
        <fieldset id="flsUbicacion" class="FieldSet FieldSetClaro ui-corner-all" >
            <legend></legend>
                <table class="tablaContenidoFormulario">
                    <tr>
                        <td class="col20_100 TitulosGrid">
                            &nbsp;</td>
                        <td class="col60_100 TitulosGrid">
                            &nbsp;</td>
                        <td class="col20_100 TitulosGrid">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100">
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100">
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100">
                            <label id="Label1" runat="server" class="Resultado">Su sesión ha finalizado.</label>
                        </td>
                        <td class="col20_100">
                        </td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100 AlCentro" >
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100 AlCentro">
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                        </td>
                        <td class="col60_100 AlCentro">
                            <input type="button" value="Ingresar Nuevamente" id="btnReIngresar" class="BotonLB ui-state-active ui-corner-all" style="width:300px;" />
                        </td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100 AlCentro">
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100 AlCentro">
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100" style="text-align:center;">
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td class="col20_100">
                            &nbsp;</td>
                        <td class="col60_100">
                            &nbsp;</td>
                        <td class="col20_100">
                            &nbsp;</td>
                    </tr>
                </table>
        </fieldset>
        </asp:Panel>
        </div>
    </div>
    </form>
</body>
