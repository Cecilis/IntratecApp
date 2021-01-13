<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IntraTecApp.Login"  MaintainScrollPositionOnPostback="true" %>
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
    <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></scr>pt-->
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
                                <td class="col30_100 TitulosGrid">
                                    &nbsp;</td>
                                <td class="col30_100 TitulosGrid">
                                    &nbsp;</td>
                                <td class="col20_100 TitulosGrid">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col20_100">
                                    &nbsp;</td>
                                <td class="col30_100">
                                    &nbsp;</td>
                                <td class="col30_100 AlaIzquierda">
                                    &nbsp;</td>
                                <td class="col20_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col20_100">
                                    &nbsp;</td>
                                <td class="col30_100">
                                    <label class="Etiquetas">
                                    Usuario</label>&nbsp;&nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUsuario" runat="server" CssClass="Campos" Height="18px" 
                                        Width="200px"></asp:TextBox>
                                    <br />
                                    <asp:CompareValidator ID="cpvUsuario" runat="server" 
                                        ControlToValidate="txtUsuario" CssClass="Validator" ErrorMessage="↑ No Valido" 
                                        Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" 
                                        ControlToValidate="txtUsuario" CssClass="Validator" Text="↑ Requerido" />
                                </td>
                                <td class="col20_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col20_100">
                                    &nbsp;</td>
                                <td class="col30_100">
                                    <label class="Etiquetas">
                                    Clave:</label>&nbsp;</td>
                                <td class="col30_100" style="text-align: left">
                                    <input id="pwdClave" type="password" runat="server" CssClass="Campos"/>
                                    <br />
                                    <asp:CompareValidator ID="rqvClave" runat="server" ControlToValidate="pwdClave" 
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" 
                                        Type="String"></asp:CompareValidator>
                                    <asp:RequiredFieldValidator ID="rfvClave" runat="server" 
                                        ControlToValidate="pwdClave" CssClass="Validator" Text="↑ Requerido" />
                                </td>
                                <td class="col20_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col20_100">
                                    &nbsp;</td>
                                <td class="col30_100 AlCentro" colspan="2">
                                    &nbsp;</td>
                                <td class="col20_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col20_100">
                                    &nbsp;</td>
                                <td class="col30_100 AlCentro" colspan="2">
                                    <asp:Button ID="btnEntrar" runat="server" 
                                        CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                        onclick="btnEntrar_Click" Text="Entrar" Width="100px" />
                                    &nbsp;<asp:Button ID="btnCerrar" runat="server" 
                                        CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                        onclick="btnCerrar_Click" Text="ReCargar" Visible="false" />
                                </td>
                                <td class="col20_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col20_100">
                                    &nbsp;</td>
                                <td class="col30_100 AlCentro" colspan="2">
                                    <asp:Label ID="lblResultado" runat="server" CssClass="Resultado" Height="16px" 
                                        Width="99%"></asp:Label>
                                </td>
                                <td class="col20_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col20_100">
                                    &nbsp;</td>
                                <td class="col30_100" colspan="2">
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
</html>
