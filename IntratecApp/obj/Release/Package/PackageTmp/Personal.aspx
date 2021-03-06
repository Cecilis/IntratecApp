﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Personal.aspx.cs" Inherits="IntraTecApp.Personal"  MaintainScrollPositionOnPostback="true" %>
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
    <link href="styles/Slider.css" rel="stylesheet" type="text/css" />
    <link href="styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

     <!--[if lt IE 9]>
        <script type="text/javascript" src="scripts/jquery-1.9.1.js"></script>
    <![endif]-->
    <!--[if gte IE 9]><!-->
        <script src="scripts/jquery-2.0.0.min.js" type="text/javascript"></script>
    <!--<![endif]-->

    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<%--    <script src="scripts/Slider.js" type="text/javascript"></script>--%>
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></scr>pt-->
</head>
<body>
<form id="frmEmpleados" runat="server">
    <div class="container ui-corner-all">
        <div class="content">
        <asp:Panel ID="pnlEmpleados" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
            <asp:Label ID="lblEmpleados" runat="server"> Nuestra Gente </asp:Label>
        </asp:Panel>  
        <div class="Div10"></div>
        <fieldset runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
            <legend></legend>
            <table class="tablaContenidoFormulario">
                <tr>
                    <td class="col100_100" align="center">
                        <div class="carrusel" >   
                            <ul class="bloque-imagenes" >
                                <asp:Repeater ID="rptPersona" runat="server" >
                                <ItemTemplate>                         
                                    <li>  
                                    <div class="FondoFicha">
                                        <div class="Div10"></div>
                                            <table class="Ficha tablaContenido">                                
                                                <tr>
                                                    <td class="col20_100">
                                                    </td>                                     
                                                    <td class="col20_100" colspan="2">
                                                    </td>                                     
                                                    <td class="col40_100" rowspan="6">                        
                                                        <img src='<%# "ImagenCargador.ashx?IDEmpleado=" + Eval("IDEmpleado")%>'  alt="Nuestra Gente" class="ui-corner-all" Height="139px" Width="107px" style="border-bottom:2px solid #CCCCCC; border-right:1px solid #CCCCCC;"/>
                                                    </td>                                     
                                                    <td class="col20_100">
                                                    </td>                                     
                                                </tr>                                
                                                <tr>
                                                    <td class="col20_100">
                                                    </td>                                     
                                                    <td class="col20_100" colspan="2">
                                                        <asp:Label ID="lblNombre" runat="server" Text='<%# ((string)(Eval("Nombre"))).ToUpperInvariant() + " " + ((string)(Eval("Apellido"))).ToUpperInvariant() %>' CssClass="Etiquetas"></asp:Label>
                                                    </td>                                     
                                                    <td class="col20_100">
                                                    </td>                                                                 
                                                </tr>                                
                                                <tr>
                                                    <td class="col20_100">
                                                    </td>                                     
                                                    <td class="col20_100" colspan="2"><asp:Label ID="lblCargo" runat="server" Text='<%# ((string)(Eval("DescCargo"))).ToUpperInvariant() %>' CssClass="CamposSinFondo"></asp:Label></td>                                     
                                                    <td class="col20_100">
                                                    </td>                                     
                                                </tr>                                
                                                <tr>
                                                    <td class="col20_100">
                                                    </td>                                     
                                                    <td class="col20_100" colspan="2">
                                                        </td>                                     
                                                    <td class="col20_100">
                                                    </td>                                     
                                                </tr>                                
                                                <tr>
                                                    <td class="col20_100">
                                                    </td>                                     
                                                    <td class="col10_100" rowspan="2">
                                                        <img alt="Teléfonos" src="images/btnTelefono.png" />
                                                    </td>                                     
                                                    <td class="col30_100">
                                                        <asp:Label ID="lblTelefonos" CssClass="CamposSinFondo" runat="server" Text='<%# Eval("CodAreaTlfOficina") + " " + Eval("NumTlfOficina") %>'></asp:Label>
                                                    </td>                                     
                                                    <td class="col20_100">
                                                    </td>                                     
                                                </tr>                                
                                                <tr>
                                                    <td class="col10_100">
                                                    </td>                                     
                                                    <td class="col30_100">
                                                        <asp:Label ID="lblCelular" CssClass="CamposSinFondo" runat="server" Text='<%# Eval("CodAreaTlfMovil") + " " + Eval("NumTlfMovil") %>'></asp:Label>
                                                    </td>                                     
                                                    <td class="col20_100">
                                                    </td>                                     
                                                </tr>                                   
                                                <tr>
                                                    <td class="col20_100">
                                                    </td>                                     
                                                    <td class="col20_100" colspan="2">
                                                    </td>                                     
                                                    <td class="col40_100">
                                                    </td>                                     
                                                    <td class="col20_100">
                                                    </td>                                     
                                                </tr>                                                
                                            </table>   
                                        </div>                     
                                    </li>                         
                                </ItemTemplate>
                            </asp:Repeater>
                            </ul>                                           
                        </div>                    
                    </td>
                </tr>
            </table>
        </fieldset>
    </div>
</div>
</form>
</body>
</html>
