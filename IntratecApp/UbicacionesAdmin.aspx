<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UbicacionesAdmin.aspx.cs" Inherits="IntraTecApp.UbicacionesAdmin"  MaintainScrollPositionOnPostback="true" %>
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
            <asp:ScriptManager ID="smgUbicacionDatos" EnableScriptGlobalization="true" runat="server" EnablePartialRendering="true" >
            </asp:ScriptManager>
            <asp:Panel ID="pnlUbicacion" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                <Label> Ubicaciones </Label>
            </asp:Panel>
            <asp:UpdateProgress ID="upgUbicacionDatos" runat="server" AssociatedUpdatePanelID="udpUbicacionDatos"
                DisplayAfter="0" DynamicLayout="True">
                <ProgressTemplate>
                    <div class="pnlProgressBar">
                        <img alt="" src="../images/imgBarraProgreso.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>            
            <div class="Div10"></div>
            <asp:Panel ID="pnlUbicacionDatos" runat="server" Width="100%"> 
            <asp:UpdatePanel runat="server" ID="udpUbicacionDatos" UpdateMode="Conditional">
                <ContentTemplate>                       
                    <fieldset id="flsUbicacion" class="FieldSet FieldSetClaro ui-corner-all" >
                    <legend></legend>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col20_100 TitulosGrid">
                                </td>
                                <td class="col60_100 TitulosGrid" colspan="2">
                                    <label> PARÁMETROS</label>
                                </td>
                                <td class="col20_100 TitulosGrid">
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    &nbsp;</td>
                                <td class="col50_100 AlaIzquierda">
                                    &nbsp;</td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblCodigoLenguajePais" runat="server" CssClass="Etiquetas">Lenguaje - Pais</asp:Label>
                                </td>
                                <td class="col50_100 AlaIzquierda">
                                    <asp:DropDownList ID="ddlLenguajePais" runat="server" 
                                        AppendDataBoundItems="true" CssClass="Etiquetas">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvLenguajePais" runat="server" 
                                        ControlToValidate="ddlLenguajePais" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="cpvLenguajePais" runat="server" 
                                        ControlToValidate="ddlLenguajePais" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblNombreLegalOrganizacion" runat="server" CssClass="Etiquetas">Nombre Legal:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtNombreLegal" runat="server" CssClass="Campos" Height="16px" 
                                        type="text" Width="350px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNombreLegal" runat="server" 
                                        ControlToValidate="txtNombreLegal" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNombreLegal" runat="server" 
                                        ControlToValidate="txtNombreLegal" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblNombreComercial" runat="server" CssClass="Etiquetas">Nombre Comercial:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtNombreComercial" runat="server" CssClass="Campos" 
                                        Height="16px" type="text" Width="350px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNombreComercial" runat="server" 
                                        ControlToValidate="txtNombreComercial" CssClass="Validator" 
                                        Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNombreComercial" runat="server" 
                                        ControlToValidate="txtNombreComercial" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblSiglas" runat="server" CssClass="Etiquetas">Siglas:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtSiglas" runat="server" CssClass="Campos" Height="16px" 
                                        type="text" Width="350px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvSiglas" runat="server" 
                                        ControlToValidate="txtSiglas" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvSiglas" runat="server" 
                                        ControlToValidate="txtSiglas" CssClass="Validator" ErrorMessage="↑ No Valido" 
                                        Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblNroRegxFeeds" runat="server" CssClass="Etiquetas">N° Registros por Feeds:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtNroRegxFeeds" runat="server" CssClass="Campos AlaDerecha" 
                                        Height="16px" type="text" Width="350px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNroRegxFeeds" runat="server" 
                                        ControlToValidate="txtNroRegxFeeds" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNroRegxFeeds" runat="server" 
                                        ControlToValidate="txtNroRegxFeeds" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblRSSEmail" runat="server" CssClass="Etiquetas">RSS Email</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtRSSEmail" runat="server" CssClass="Campos" Height="16px" 
                                        type="text" Width="350px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvRSSEmail" runat="server" 
                                        ControlToValidate="txtRSSEmail" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvRSSEmail" runat="server" 
                                        ControlToValidate="txtRSSEmail" CssClass="Validator" ErrorMessage="↑ No Valido" 
                                        Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblNroCtaGoogle" runat="server" CssClass="Etiquetas">Nro Cuenta Google:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtNroCtaGoogle" runat="server" CssClass="Campos" 
                                        Height="16px" type="text" Width="350px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNroCtaGoogle" runat="server" 
                                        ControlToValidate="txtNroCtaGoogle" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNroCtaGoogle" runat="server" 
                                        ControlToValidate="txtNroCtaGoogle" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblEnlaceFacebook" runat="server" CssClass="Etiquetas">Enlace Cuenta Facebook:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtCuentaFaceBook" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="465px" Height="29px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNombreComercial4" runat="server" 
                                        ControlToValidate="txtNombreComercial" CssClass="Validator" 
                                        Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNombreComercial4" runat="server" 
                                        ControlToValidate="txtNombreComercial" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblUsuarioTwitter" runat="server" CssClass="Etiquetas">Usuario Twitter:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUsuarioTwitter" runat="server" CssClass="Campos" 
                                        Height="16px" type="text" Width="350px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNombreComercial5" runat="server" 
                                        ControlToValidate="txtUsuarioTwitter" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNombreComercial5" runat="server" 
                                        ControlToValidate="txtUsuarioTwitter" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblUbicImagenesGaleria" runat="server" CssClass="Etiquetas">Ubicación Imágenes Galeria:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUbicGalleriaImgenes" runat="server" CssClass="Campos" Enabled="false"
                                        TextMode="MultiLine" type="text" Width="465px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvUbicGalleriaImgenes" runat="server" 
                                        ControlToValidate="txtUbicGalleriaImgenes" CssClass="Validator" 
                                        Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvUbicGalleriaImgenes" runat="server" 
                                        ControlToValidate="txtUbicGalleriaImgenes" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblUbicDocumentos" runat="server" CssClass="Etiquetas">Ubicación Documentos:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUbicDocumentos" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="478px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvUbicDocumentos" runat="server" 
                                        ControlToValidate="txtUbicDocumentos" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvUbicDocumentos" runat="server" 
                                        ControlToValidate="txtUbicDocumentos" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblUbicProcedimientos0" runat="server" CssClass="Etiquetas">Ubicación Manuales:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUbicManuales" runat="server" CssClass="Campos" 
                                        ontextchanged="txtUbicManuales_TextChanged" TextMode="MultiLine" type="text" 
                                        Width="478px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNombreComercial8" runat="server" 
                                        ControlToValidate="txtNombreComercial" CssClass="Validator" 
                                        Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNombreComercial8" runat="server" 
                                        ControlToValidate="txtNombreComercial" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblUbicNormativas" runat="server" CssClass="Etiquetas">Ubicación Normativas:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUbicNormativas" runat="server" accept="UbicNormativas" 
                                        CssClass="Campos" TextMode="MultiLine" type="text" Width="475px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvUbicNormativas" runat="server" 
                                        ControlToValidate="txtUbicNormativas" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNombreComercial9" runat="server" 
                                        ControlToValidate="txtNombreComercial" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblUbicProcedimientos" runat="server" CssClass="Etiquetas">Ubicación Procedimientos:</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUbicProcedimientos" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="474px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvUbicProcedimientos" runat="server" 
                                        ControlToValidate="txtUbicProcedimientos" CssClass="Validator" 
                                        Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvUbicProcedimientos" runat="server" 
                                        ControlToValidate="txtUbicProcedimientos" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblUbicReportes" runat="server" CssClass="Etiquetas">Ubicación Reportes</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtUbicReportes" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="474px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvUbicReportes" runat="server" 
                                        ControlToValidate="txtUbicReportes" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvUbicReportes" runat="server" 
                                        ControlToValidate="txtUbicReportes" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblAppOnBase" runat="server" CssClass="Etiquetas">Enlace On Base</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtAppOnBase" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="474px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvAppOnBase" runat="server" 
                                        ControlToValidate="txtAppOnBase" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvAppOnBase" runat="server" 
                                        ControlToValidate="txtAppOnBase" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="QlickView" runat="server" CssClass="Etiquetas">Enlace QlickView</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtAppQlickView" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="474px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvAppQlickView" runat="server" 
                                        ControlToValidate="txtAppQlickView" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvAppQlickView" runat="server" 
                                        ControlToValidate="txtAppQlickView" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="Assist" runat="server" CssClass="Etiquetas">Enlace Assist</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtAppAssist" runat="server" CssClass="Campos" 
                                        ontextchanged="txtAppAssist_TextChanged" TextMode="MultiLine" type="text" 
                                        Width="474px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvAppAssist" runat="server" 
                                        ControlToValidate="txtAppAssist" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvAppAssist" runat="server" 
                                        ControlToValidate="txtAppAssist" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblAppCorreoElectronico" runat="server" CssClass="Etiquetas">Enlace Correo</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtAppCorreoElectronico" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="474px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvAppCorreoElectronico" runat="server" 
                                        ControlToValidate="txtAppCorreoElectronico" CssClass="Validator" 
                                        Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvAppCorreoElectronico" runat="server" 
                                        ControlToValidate="txtAppCorreoElectronico" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    <asp:Label ID="lblAppMasterData" runat="server" CssClass="Etiquetas">Enlace Master Data</asp:Label>
                                </td>
                                <td class="col50_100" style="text-align:left;">
                                    <asp:TextBox ID="txtAppMasterData" runat="server" CssClass="Campos" 
                                        TextMode="MultiLine" type="text" Width="474px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvAppMasterData" runat="server" 
                                        ControlToValidate="txtAppMasterData" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvAppMasterData" runat="server" 
                                        ControlToValidate="txtAppMasterData" CssClass="Validator" 
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;">
                                    &nbsp;</td>
                                <td class="col50_100" style="text-align:left;">
                                    &nbsp;</td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:center;" colspan="2">
                                    <asp:Label ID="lblResultado" runat="server" CssClass="Resultado AlCentro" Width="100%"></asp:Label>
                                </td>
                                <td class="col10_100">
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:center;" colspan="2">
                                    <asp:Button ID="btnGuardar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all AlCentro" Height="18px" 
                                        onclick="btnGuardar_Click" Text="Guardar" Width="100px" />
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col30_100" style="text-align:left;" colspan="2">
                                    &nbsp;</td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </fieldset>
                </ContentTemplate>
                <Triggers>
                     <asp:AsyncPostBackTrigger ControlID="btnGuardar" />
                </Triggers>
            </asp:UpdatePanel>
            </asp:Panel>
        </div>
    </div>
</form>
</body>
</html>
