<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeedAdmin.aspx.cs" Inherits="IntraTecApp.FeedAdmin"  MaintainScrollPositionOnPostback="true" %>
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

    <link href="styles/PaginaContenido.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="styles/TablaContenido.css" rel="stylesheet" type="text/css" />
    <link href="styles/Formularios.css" rel="stylesheet" type="text/css" />
    <link href="styles/FeedEk.css" rel="stylesheet" type="text/css" />
    <link href="styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

     <!--[if lt IE 9]>
        <script type="text/javascript" src="scripts/jquery-1.9.1.js"></script>
    <![endif]-->
    <!--[if gte IE 9]><!-->
        <script src="scripts/jquery-2.0.0.min.js" type="text/javascript"></script>
    <!--<![endif]-->

    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></script-->
    
    <script src="scripts/FeedEk.js" type="text/javascript"></script>

    <script type="text/javascript">
        var BuscarFeed = function () {
            $("#flsDetalleFeeds").show();
            $('#divRss').FeedEk({
                FeedUrl: $('#txtURLFeed').val(),
                MaxCount: 5,
                ShowDesc: true,
                ShowPubDate: true,
                DescCharacterLimit: 8000,
                TitleLinkTarget: '_blank'
            });
        }

</script>
</head>
<body>
<form runat="server" id="frmFeeds">
<div class="container ui-corner-all">
    <div class="content">
        <asp:ScriptManager ID="smgFeeds" runat="server" EnableScriptGlobalization="true" EnablePartialRendering="true"  >
        </asp:ScriptManager>
        <asp:Panel ID="pnlFeedAdmin" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
            <asp:Label ID="lblFeedAdmin" runat="server" Text="Canales RSS / Atom" />
        </asp:Panel>     
        <asp:UpdateProgress ID="upgFeedAdminw" runat="server" AssociatedUpdatePanelID="udpFeedAdmin"
            DisplayAfter="0" DynamicLayout="True">
            <ProgressTemplate>
                <div class="pnlProgressBar">
                    <img alt="" src="../images/imgBarraProgreso.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <div class="Div10"></div>
        <asp:UpdatePanel ID="udpFeedAdmin" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <fieldset id="flsFeedsActuales" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                    <legend></legend>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col100_100 TitulosGrid">
                                    <label> Canales actuales: </label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100">
                                    <asp:TreeView runat="server" id="tvwRSSFeeds" NodeStyle-CssClass="CamposSinFondo" 
                                        OnSelectedNodeChanged="tvwRSSFeeds_SelectedNodeChanged" 
                                        NodeIndent="10" NodeStyle-HorizontalPadding="10"
                                        NodeStyle-ImageUrl="~/images/IconoGrid.png"  >
                                    </asp:TreeView>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100 CamposGrid">                                   
                                </td>
                            </tr>
                        </table>
                </fieldset>
                <div class="Div10"></div>
                <fieldset id="flsAgregarFeeds" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                    <legend></legend>
                        <input type="hidden" id="hdnIDFeedActual" name="hdnIDFeedActual" value="" runat="server" />
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col100_100 TitulosGrid" style="text-align:center;" colspan="4">  
                                    <label> Agregar </label>                             
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                    &nbsp;</td>
                                <td class="col80_100 CamposGrid" style="text-align:left;" colspan="2">
                                    <label class="Etiquetas">URL Canal</label>
                                    <br />
                                    <table style="width:100%">
                                        <tr>
                                            <td class="col90_100">                                            
                                                <input id="txtURLFeed" runat="server" type="text" class="Campos" placeholder="Indique URL del canal RSS/ATOM" style="width:90%;" />
                                            </td>
                                            <td class="col10_100">
                                                <asp:Button runat="server" ID="btnBuscarFeed" OnClientClick="BuscarFeed()" 
                                                Text="..." CssClass="BotonLBBuscar ui-state-active ui-corner-all" 
                                                CausesValidation="false" Width="24px" Height="24px" />                            
                                            </td>                                                    
                                        </tr>
                                    </table>
                                </td>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                            </tr>
                            <tr>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                                <td class="col40_100 CamposGrid" style="text-align:left;">
                                    <label class="Etiquetas">Título</label>
                                    <br />
                                    <input type="text" runat="server" id="txtTituloFeeds" class="Campos" style="width:90%;" />
                                    <br />
                                    <asp:RequiredFieldValidator ID="rqvtxtTituloFeeds" runat="server" 
                                        ControlToValidate="txtTituloFeeds" CssClass="Validator" InitialValue="" 
                                        Text="↑ Requerido" />
                                </td>
                                <td class="col40_100 CamposGrid" style="text-align:left;">
                                    <label class="Etiquetas">
                                    Tipo Canal</label>
                                    <br />
                                    <asp:DropDownList ID="ddlTipoFeed" runat="server" CssClass="Campos">
                                        <asp:ListItem Selected="True" Value="">Seleccionar</asp:ListItem>
                                        <asp:ListItem Value="RSS">RSS</asp:ListItem>
                                        <asp:ListItem Value="ATOM">ATOM</asp:ListItem>
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvddlTipoFeed" runat="server" 
                                        ControlToValidate="ddlTipoFeed" CssClass="Validator" InitialValue="" 
                                        Text="↑ Requerido" />
                                </td>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                            </tr>
                            <tr>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                                <td class="col40_100 CamposGrid" style="text-align:left;">
                                    <label class="Etiquetas">Tipo Feed</label>
                                    <br />
                                    <asp:RadioButtonList runat="server" ID="rblPropiedad" RepeatDirection="Horizontal" CssClass="CamposSinFondo" >
                                        <asp:ListItem Value="1">Propio</asp:ListItem>
                                        <asp:ListItem Value="0" Selected="True">Tercero</asp:ListItem>
                                    </asp:RadioButtonList>
                                    </td>
                                <td class="col40_100 CamposGrid" style="text-align:left;">
                                    <label class="Etiquetas">Estado</label>
                                    <br />
                                    <asp:RadioButtonList runat="server" ID="rblEstado" RepeatDirection="Horizontal" CssClass="CamposSinFondo" >
                                        <asp:ListItem Value="1" Selected="True">Activo</asp:ListItem>
                                        <asp:ListItem Value="0">Inactivo</asp:ListItem>
                                    </asp:RadioButtonList>                            
                                </td>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                            </tr>
                            <tr>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                                <td class="col40_100 CamposGrid" style="text-align:left;">
                                    <div style="display: none;">
                                        <asp:Button ID="btnTextBoxEventHandler" runat="server"
                                        OnClick="btnTextBoxEventHandler_Click" />
                                    </div>                             
                                </td>
                                <td class="col40_100 CamposGrid" style="text-align:left;">
                                </td>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                            </tr>
                            <tr>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                                <td class="col40_100 CamposGrid" style="text-align:center;">
                                    <asp:Button ID="btnGuardar" runat="server" 
                                    CssClass="BotonLB ui-state-active ui-corner-all" Height="27px" 
                                    onclick="btnGuardar_Click" 
                                    Text="Guardar" Width="100px" />                                
                                </td>
                                <td class="col40_100 CamposGrid" style="text-align:center;">
                                    <asp:Button ID="btnEliminar" runat="server" CausesValidation="false" 
                                    CssClass="BotonLB ui-state-active ui-corner-all" Height="27px" 
                                    onclick="btnEliminar_Click" 
                                    Text="Eliminar" Width="100px" />  
                                </td>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                            </tr>
                            <tr>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                                <td class="col80_100 CamposGrid" style="text-align:center;" colspan="2">
                                    <asp:Label ID="lblMensaje" runat="server" CssClass="Resultado" ></asp:Label>
                                </td>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                            </tr>
                            <tr>
                                <td class="col10_100 CamposGrid" style="text-align:center;">                                
                                </td>                         
                                <td class="col80_100 CamposGrid" style="text-align:center;" colspan="2">                                
                                    &nbsp;</td>
                            </tr>
                        </table>
                    </fieldset>
                <div class="Div10"></div>
                <fieldset id="flsDetalleFeeds" runat="server" class="FieldSet FieldSetClaro ui-corner-all" visible="false" >
                    <legend></legend>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col100_100 TitulosGrid">
                                    <label> Detalle </label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100 CamposGrid" style="text-align:center;">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100">
                                    <div style="width:100%">
                                        <div id="divRss" style="text-align:justify; position:static; display:block; height:500px; margin: 0px 10px 0px 10px; background:#FFFFFFF; overflow:auto; ">
                                        </div>
                                    </div>                                
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100 CamposGrid">
                                
                                </td>
                            </tr>
                        </table>                                         
                </fieldset>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="tvwRSSFeeds" />
            </Triggers>
        </asp:UpdatePanel> 
    </div>
</div>
</form>
</body>
</html>
