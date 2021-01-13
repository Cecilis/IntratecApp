<%@ Page Title="" Language="C#"  AutoEventWireup="true" CodeBehind="NoticiasAdmin.aspx.cs" Inherits="IntraTecApp.NoticiasAdmin"  MaintainScrollPositionOnPostback="true" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit.HTMLEditor" tagprefix="cc1" %>
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
    <link href="styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

     <!--[if lt IE 9]>
        <script type="text/javascript" src="scripts/jquery-1.9.1.js"></script>
    <![endif]-->
    <!--[if gte IE 9]><!-->
        <script src="scripts/jquery-2.0.0.min.js" type="text/javascript"></script>
    <!--<![endif]-->

    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></script-->
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
        <asp:ScriptManager ID="smgNoticiasAdmin" runat="server" EnableScriptGlobalization="true"
                EnablePartialRendering="true">
        </asp:ScriptManager>
        <asp:Panel ID="pnlNoticiasAdmin" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
            <asp:Label ID="lblFileName" runat="server"> Noticias </asp:Label>
        </asp:Panel>
        <asp:UpdateProgress ID="ugpEditarEmpleado" runat="server" AssociatedUpdatePanelID="udpEditarEmpleado"
            DisplayAfter="0" DynamicLayout="True">
            <ProgressTemplate>
<%--                <div class="pnlProgressBar">
                    <img alt="" src="../images/imgBarraProgreso.gif" />
                </div>--%>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <div class="Div10">
        </div>
        <asp:UpdatePanel runat="server" ID="udpEditarEmpleado" UpdateMode="Conditional" ChildrenAsTriggers="true">
            <ContentTemplate>
                <fieldset id="flsBusqueda" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                <legend></legend>
                    <table class="tablaContenidoFormulario">            
                        <tr>
                            <td class="col100_100 TitulosGrid">
                                <label>Buscar</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100" align="left">
                                <asp:Button ID="btnAgregarPost" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                onclick="btnAgregarPost_Click" Text="Ir a Editar"  /> 
                                <asp:HiddenField ID="hdnIDNoticiasAdmin" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="col100_100">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col100_100" align="center" valign="middle" >
                             <asp:Panel Id="pnlNoticias" runat="server" DefaultButton="btnBuscar"> 
                                <table class="tablaContenido">
                                    <tr>
                                        <td class="col90_100 AlCentro" align="right">
                                            <asp:TextBox ID="txtBusqueda" runat="server" Width="93%" Height="18px" 
                                                CssClass="Campos" style="margin-bottom: 7px"  ></asp:TextBox>  
                                        </td>
                                        <td class="col10_100 AlCentro" align="left">
                                            <asp:Button ID="btnBuscar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" 
                                                onclick="btnBusqueda_Click" Text="..." ToolTip="Buscar" CausesValidation="false"
                                                Height="18px" Width="18px" /> 
                                        </td>
                                    </tr>
                                </table>                             
                             </asp:Panel>               
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100" align="left">
                                <asp:Label ID="lblInfo" runat="server" Width="343%" CssClass="Info" 
                                    Text="* Seleccione una noticia para verla en detalle." Height="16px"></asp:Label>
                            </td>
                        </tr> 
                        <tr>       
                            <td class="col100_100" align="center">
                                <asp:ListBox ID="listaBusqueda" runat="server" Height="200px" Width="80%" 
                                    CssClass="Campos" AutoPostBack="true" 
                                    onselectedindexchanged="listaBusqueda_SelectedIndexChanged"/>                
                            </td>
                        </tr>                 
                        <tr>
                            <td class="col100_100">
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <div class="Div10"></div>
                <fieldset id="flsEditar" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                    <legend></legend>
                    <table class="tablaContenidoFormulario">
                        <tr>
                            <td class="col100_100 TitulosGrid" colspan="3">                   
                                <label>Editar</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlaIzquierda" colspan="3" style="text-align:left;" 
                                align="left">                  
                                <asp:Button ID="btnBuscarEditar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                onclick="btnBuscarEditar_Click" Text="Buscar" /> 
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="col100_100 AlaIzquierda" colspan="3" 
                                style="text-align:left;">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlaIzquierda" colspan="3" align="left">
                                <asp:Label ID="lblTitulo" runat="server" CssClass="Etiquetas" Text="Título"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:TextBox ID="edtTitulo" runat="server" CssClass="Campos" Height="18px" 
                                    Width="80%"></asp:TextBox>
                                &nbsp;
                                <label class="EResultado">
                                *</label></td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlaIzquierda" colspan="3" align="left">
                                <asp:Label ID="lblPosteadoPor" runat="server" CssClass="Etiquetas" 
                                    Text="Posteado por"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:TextBox ID="txtPosteadoPor" runat="server" Width="80%" CssClass="Campos" 
                                    Height="18px"></asp:TextBox>
                                &nbsp;
                                <label class="EResultado">
                                *</label></td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlaIzquierda" colspan="3" align="left">
                                <asp:Label ID="lblDescripcion" runat="server" CssClass="Etiquetas" 
                                    Text="Descripción"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:TextBox ID="txtDescripcion" runat="server" Rows="3" TextMode="MultiLine" 
                                    Width="80%" CssClass="Campos" Height="54px"></asp:TextBox>
                                &nbsp;
                                <label class="EResultado">
                                *</label></td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlaIzquierda" colspan="3" align="left">
                                <asp:Label ID="lblContenido" runat="server" CssClass="Etiquetas" 
                                    Text="Contenido"></asp:Label>                
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:Image ID="previewImage" runat="server" Height="200px" Width="300px" BorderWidth="1px" BorderStyle="solid" BorderColor="#999999" BackColor="#CCCCCC" />
                                <asp:ImageButton ID="btnEliminarFoto" runat="server" 
                                    AlternateText="Borrar foto" CausesValidation="false" Height="18px" 
                                    ImageUrl="~/images/cancel.png" onclick="btnEliminarFoto_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <ajaxToolkit:AsyncFileUpload ID="asyncFileUpload" runat="server" AllowedFileTypes="gif,png,jpg,jpeg"
                                    CssClass="BotonLB ui-state-active ui-corner-all AlaIzquierda" ErrorBackColor="Red"
                                    Height="18px" OnClientUploadComplete="OnClientAsyncFileUploadComplete" OnUploadedComplete="OnAsyncFileUploadComplete"
                                    PersistFile="true" UploaderStyle="Traditional" UploadingBackColor="#d4f897" Width="60%" />                                             
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3">
                                <cc1:Editor ID="txtContenido" CssClass="Campos" width="100%" Height="200px" NoUnicode="true"
                                        runat="server" /><label class="EResultado">*</label></td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="left">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="left">
                                <label class="Etiquetas">Categorías</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col45_100 AlCentro" rowspan="2" align="right">
                                <asp:ListBox ID="listaCat" runat="server" Rows="6" CssClass="Campos" SelectionMode="Multiple" 
                                    Width="90%" Height="80px"></asp:ListBox>
                            </td>
                            <td class="col10_100 AlCentro" align="center" valign="middle">
                                    <asp:LinkButton CssClass="Etiquetas" ID="AgregarCategoria" runat="server" ToolTip="Agregar" Height="16px" 
                                        onclick="AgregarCategoria_Click"><img alt="Agregar" src="images/bnext.gif" /></asp:LinkButton>
                            </td> 
                            <td class="col45_100 AlCentro" rowspan="2" align="left">
                                <asp:ListBox ID="listaCatFinal" runat="server" Rows="6" Width="90%" CssClass="Campos"
                                    Height="80px">
                                </asp:ListBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="col10_100 AlCentro" align="center" valign="middle">
                                    <asp:LinkButton CssClass="Etiquetas" ID="EliminarCategoria" runat="server" ToolTip="Remover" Height="16px" 
                                        onclick="EliminarCategoria_Click"><img alt="Quitar" src="images/bback.gif" /></asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="left">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="left">
                                <label class="Etiquetas">Fecha</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3">  
                                <table class="tablaContenido">
                                    <tr>
                                        <td class="col100_100 AlCentro">
                                            <asp:TextBox ID="txtFecha" runat="server" Height="18px" CssClass="Campos" 
                                                Width="187px"></asp:TextBox>
                                            <asp:LinkButton ID="btnInsertar" runat="server" CssClass="Etiquetas" 
                                                onclick="btnInsertar_Click"><img alt="Actualizar" src="images/brefresh.png" height="18px" width="18px" /></asp:LinkButton>
                                            &nbsp;
                                            <label class="EResultado">*</label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="col100_100 AlCentro">
                                            &nbsp;</td>
                                    </tr>
                                </table>                      
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:CheckBox ID="Publicado" runat="server" Text="¿Publicar?" CssClass="Etiquetas"  />
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="col100_100 AlCentro" colspan="3">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:Button ID="btnGuardar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                    onclick="btnGuardar_Click" Text="Guardar" />                
                                <asp:Button ID="btnEliminar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                    onclick="btnEliminar_Click" Text="Eliminar" /> 
                            </td>
                        </tr>
                        <tr>
                            <td align="center" class="col100_100 AlCentro" colspan="3">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:Label ID="lblResultado" CssClass="Resultado" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <div class="Div10" align="center"></div>
                <asp:Panel ID="panelCategorias" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                    <asp:Label ID="lblCategorias" runat="server">Categorias</asp:Label>
                </asp:Panel> 
                <fieldset id="flsAdmnCategorias" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                <legend></legend>
                    <table class="tablaContenidoFormulario">
                        <tr>
                            <td class="style13 TitulosGrid" colspan="2">                   
                                <label>Editar</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="2" align="left">
                                <label class="Etiquetas">Categoría</label>            
                            </td>
                        </tr>
                        <tr>
                            <td class="col50_100 AlCentro" align="center">
                                <asp:TextBox ID="txtNombreCategoria" runat="server" CssClass="Campos" Height="18px" Width="50%" />
                                &nbsp;<asp:Button ID="btnAgregarCategorias" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" 
                                    onclick="btnAgregarCategorias_Click" Text="+" Font-Bold="True" 
                                    Font-Size="Small" Height="18px" Width="18px" />                       
                            </td>
                            <td class="col50_100 AlCentro" align="center">
                                <asp:DropDownList ID="ddlCategorias" runat="server" CssClass="Campos" Height="18px" 
                                        Width="50%" />         
                                &nbsp;<asp:Button ID="btnEliminarCategorias" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" 
                                    onclick="btnEliminarCategorias_Click" Text="-" Font-Bold="True" 
                                    Font-Size="Small" Height="18px" Width="18px"   /> 
                            </td> 
                        </tr>
                        <tr>
                            <td class="col100_100 AlCentro" colspan="3" align="center">
                                <asp:Label ID="lblResultadoCategorias" CssClass="Resultado" runat="server" />
                            </td>
                        </tr>
                    </table>
                </fieldset> 
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnBuscarEditar" />
                <asp:AsyncPostBackTrigger ControlID="btnAgregarPost" />
                <asp:AsyncPostBackTrigger ControlID="btnGuardar" />
                <asp:AsyncPostBackTrigger ControlID="btnEliminar" />
                <asp:AsyncPostBackTrigger ControlID="btnInsertar" />
                <asp:AsyncPostBackTrigger ControlID="AgregarCategoria" />
                <asp:AsyncPostBackTrigger ControlID="EliminarCategoria" />
                <asp:AsyncPostBackTrigger ControlID="asyncFileUpload" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
</div>
</form>
</body>
</html>
