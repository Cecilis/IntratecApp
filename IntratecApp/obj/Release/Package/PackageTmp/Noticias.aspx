<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Noticias.aspx.cs" Inherits="IntraTecApp.Noticias"  MaintainScrollPositionOnPostback="true" %>
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
    <script type="text/javascript">
        function getRandomNumber() {
            var randomnumber = Math.random(10000);
            return randomnumber;
        }
        function OnClientAsyncFileUploadComplete(sender, args) {
            var handlerPage = '<%=Page.ResolveClientUrl("ImagenVistaPrevia.ashx")%>';
            var queryString = '?randomno=' + getRandomNumber();
            var src = handlerPage + queryString;
            var clientId = '<%=previewImage.ClientID %>';
            document.getElementById(clientId).setAttribute("src", src);
        }
    </script>
<form runat="server" id="frmNoticiasAdmin">
    <div class="container ui-corner-all">
        <div class="content">
            <asp:ScriptManager ID="smgBuscarArchivo" EnableScriptGlobalization="true" runat="server" EnablePartialRendering="true" >
            </asp:ScriptManager>
            <asp:Panel ID="pnlArchivo" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                <label>Noticias</label>
            </asp:Panel> 
            <asp:UpdateProgress ID="upgBuscarArchivo" runat="server" AssociatedUpdatePanelID="udpBuscarArchivo"
                DisplayAfter="0" DynamicLayout="True">
                <ProgressTemplate>
                    <div class="pnlProgressBar">
                        <img alt="" src="../images/imgBarraProgreso.gif"  />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>            
            <div class="Div10"></div>
            <asp:UpdatePanel runat="server" ID="udpBuscarArchivo" UpdateMode="Conditional">
                <ContentTemplate>
                    <fieldset id="flsBusqueda" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                        <legend></legend>
                        <table class="tablaContenidoFormulario">   
                            <tr>
                                <td class="col100_100 TitulosGrid">
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100 AlaIzquierda" style="text-align:left;">
                                    <asp:Button ID="btnVolver" runat="server" 
                                        CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                        onclick="btnVolver_Click" Text="Volver" />
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100 AlaIzquierda" style="text-align:left;">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100" >
                                    <asp:Panel Id="pnlNoticias" runat="server" DefaultButton="btnBuscar" style="vertical-align:middle;">                                                              
                                        <table class="tablaContenido">
                                            <tr>
                                                <td class="col90_100 AlCentro" style="vertical-align:middle;">
                                                     <asp:TextBox ID="txtBusqueda" runat="server" Width="100%" Height="18px" 
                                                        CssClass="Campos" style="margin-bottom: 7px"  ></asp:TextBox>                                            
                                                </td>
                                                <td class="col10_100 AlCentro" style="vertical-align:middle;">
                                                    <asp:Button ID="btnBuscar" Text="..." CssClass="BotonLBBuscar ui-state-active ui-corner-all"
                                                        OnClick="btnBusqueda_Click" ToolTip="Buscar" runat="server" CausesValidation="false"
                                                        Height="24px" Width="24px" />                                            
                                                </td>
                                            </tr>
                                        </table>   
                                    </asp:Panel>               
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100">
                                    <asp:Label ID="lblInfo" runat="server" Width="343%" CssClass="Info" 
                                        Text="* Seleccione una noticia para verla en detalle." Height="16px"></asp:Label>
                                </td>
                            </tr>            
                            <tr>
                                <td class="col100_100">
                                    <asp:ListBox ID="listaBusqueda" runat="server" Height="200px" Width="100%" 
                                        CssClass="Campos" AutoPostBack="true" 
                                        onselectedindexchanged="listaBusqueda_SelectedIndexChanged"/>                
                                </td>
                            </tr>                   
                            <tr>
                                <td class="col100_100">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </fieldset>
                    <fieldset id="flsEditar" runat="server"  class="FieldSet FieldSetClaro ui-corner-all" >
                        <legend></legend>
                         <table class="tablaContenidoFormulario">  
                            <tr>
                                <td class="col100_100 TitulosGrid" colspan="2">                   
                                    En detalle</td>
                            </tr>
                            <tr>
                                <td class="col100_100 AlaIzquierda" colspan="2" style="text-align:left;">                   
                                <asp:Button ID="btnBuscarEditar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                    onclick="btnBuscarEditar_Click" Text="Más Noticias"  />                    
                                </td>
                            </tr>
                             <tr>
                                 <td class="col100_100 AlaIzquierda" colspan="2" style="text-align:left;">
                                     &nbsp;</td>
                             </tr>
                            <tr>
                                <td class="col50_100" style="text-align: center">
                                    <asp:Label ID="lblTitulo" runat="server"  Text="Título" CssClass="Etiquetas" ></asp:Label>
                                </td>
                                <td class="col50_100" style="text-align: center" rowspan="5">
                                    <asp:Image ID="previewImage" runat="server"  Width="300px" BorderWidth="1px" BorderStyle="solid" BorderColor="#999999" BackColor="#CCCCCC" />
                                </td>
                            </tr>
                            <tr>
                                <td class="col50_100" style="text-align: center">
                                    <asp:Label ID="lblPosteadoPor" runat="server" CssClass="Etiquetas"  ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col50_100" style="text-align: center">
                                    <asp:Label ID="lblDescripcion" runat="server" CssClass="Etiquetas"  ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col50_100" style="text-align: center">
                                    <asp:HiddenField ID="hdnIDNoticiaActual" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td class="col50_100" style="text-align: center">
                                    <asp:Label ID="lblContenido" runat="server" Text="Contenido" CssClass="Etiquetas" ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" style="text-align: center" colspan="2">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2">
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2">
                                    <asp:Label ID="lblFecha" runat="server" CssClass="Etiquetas"  Text="Fecha" ></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2">
                                    &nbsp;</td>
                            </tr>
                        </table>   
                    </fieldset>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnBuscarEditar"  EventName="Click"/>
                    <asp:AsyncPostBackTrigger ControlID="btnVolver"  EventName="Click"/>                    
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
</form>
</body>
</html>
