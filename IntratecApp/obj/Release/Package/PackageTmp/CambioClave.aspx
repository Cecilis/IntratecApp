<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CambioClave.aspx.cs" Inherits="IntraTecApp.CambioClave"  MaintainScrollPositionOnPostback="true" %>
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
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></script-->
    <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>
</head>
<body>
    <form id="frmLogin" runat="server">
    <div class="container ui-corner-all">
        <div class="content">
            <asp:Panel ID="pnlAutenticacion" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                CAMBIO DE CLAVE</asp:Panel>
            <div class="Div10"></div>
            <asp:Panel ID="pnlCambioClaveDatos" runat="server" Width="100%">
            <fieldset id="flsCambioClave"  class="FieldSet FieldSetClaro ui-corner-all" >
                <legend></legend>
                    <table class="tablaContenidoFormulario">
                        <tr>
                            <td class="col100_100 TitulosGrid" colspan="4">
                            </td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:left;">
                                &nbsp;</td>
                            <td class="col40_100" style="text-align:left;">
                                &nbsp;</td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:left;">
                                <asp:Label ID="lblUsuarioActual" runat="server" CssClass="Etiquetas">Usuario Actual:</asp:Label>
                            </td>
                            <td class="col40_100" style="text-align:left;">
                                <asp:TextBox ID="txtUsuarioActual" runat="server" CssClass="Campos" 
                                    Height="18px" Width="188px"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvUsuarioActual" runat="server" 
                                    ControlToValidate="txtUsuarioActual" CssClass="Validator" Text="↑ Requerido" />
                                <asp:CompareValidator ID="cvlUsuarioActual" runat="server" 
                                    ControlToValidate="txtUsuarioActual" CssClass="Validator" 
                                    ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                            </td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:left;">
                                <asp:Label ID="Label2" runat="server" CssClass="Etiquetas">Clave Actual:</asp:Label>
                            </td>
                            <td class="col40_100" style="text-align:left;">
                                <input id="pwdClaveActual" type="password" runat="server" CssClass="Campos"/>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvClaveActual" runat="server" 
                                    ControlToValidate="pwdClaveActual" CssClass="Validator" Text="↑ Requerido" />
                                <asp:CompareValidator ID="cvlClaveActual" runat="server" 
                                    ControlToValidate="pwdClaveActual" CssClass="Validator" 
                                    ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                            </td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:left;">
                                <asp:Label ID="lblClaveNueva" runat="server" CssClass="Etiquetas">Nueva Clave:</asp:Label>
                            </td>
                            <td class="col40_100" style="text-align:left;">
                                <input id="pwdClaveNueva" type="password" runat="server" CssClass="Campos"/>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvClaveNueva" runat="server" 
                                    ControlToValidate="pwdClaveNueva" CssClass="Validator" Text="↑ Requerido" />
                                <asp:CompareValidator ID="cpvClaveNueva" runat="server" 
                                    ControlToValidate="pwdClaveNueva" CssClass="Validator" 
                                    ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                            </td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:left;">
                                <asp:Label ID="Label4" runat="server" CssClass="Etiquetas">Confirmación:</asp:Label>
                            </td>
                            <td class="col40_100" style="text-align:left;">
                                <input id="pwdConfirmacion" type="password" runat="server" CssClass="Campos"/>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvConfirmacion" runat="server" 
                                    ControlToValidate="pwdConfirmacion" CssClass="Validator" Text="↑ Requerido" />
                                <asp:CompareValidator ID="cpvConfirmacion" runat="server" 
                                    ControlToValidate="pwdConfirmacion" CssClass="Validator" 
                                    ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                            </td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:left;">
                                &nbsp;</td>
                            <td class="col40_100" style="text-align:left;">
                                &nbsp;</td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:center;" colspan="2">
                                <asp:Label ID="lblResultado" runat="server" CssClass="Resultado" Width="100%"></asp:Label>
                            </td>
                            <td class="col20_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100" style="text-align:center;" colspan="2">
                                <asp:Button ID="btnCambioClave" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                    onclick="btnCambiarClave_Click" Text="Cambiar" Width="100px" />
                            </td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col20_100">
                                &nbsp;</td>
                            <td class="col30_100&gt;">
                                &nbsp;</td>
                            <td class="col40_100" style="text-align:left;">
                                &nbsp;</td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                    </table>
            </fieldset>
            </asp:Panel>
        </div>
    </div>
    </form>
</body>
</html>
