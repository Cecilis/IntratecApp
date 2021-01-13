<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ArchivosAdmin.aspx.cs" Inherits="IntraTecApp.ArchivosAdmin"  MaintainScrollPositionOnPostback="true" %>
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
    <form id="frmDocumentos" runat="server">
    <div class="container ui-corner-all">
        <div class="content">
            <asp:ScriptManager ID="smgArchivosAdmin" runat="server" EnableScriptGlobalization="false" EnablePartialRendering="true" >
            </asp:ScriptManager>
            <asp:Panel ID="pnlDocumento" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                <asp:Label ID="lblTipoDocumento" runat="server">Archivos</asp:Label>
            </asp:Panel>
            <asp:UpdateProgress ID="ugpArchivosAdmin" runat="server" AssociatedUpdatePanelID="udpArchivosAdmin"
            DisplayAfter="0" DynamicLayout="True">
            <ProgressTemplate>
                <div class="pnlProgressBar">
                    <img alt="" src="../images/imgBarraProgreso.gif" />
                </div>
            </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="Div10"></div>     
            <asp:HiddenField ID="hdnTipoConsulta" runat="server" />
            <asp:HiddenField ID="hdnUbicacion" runat="server" />
            <asp:UpdatePanel runat="server" ID="udpArchivosAdmin" UpdateMode="Conditional" ChildrenAsTriggers="False" >
                <ContentTemplate>
                    <fieldset id="flsArchivos" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                    <legend> </legend>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col100_100 TitulosGrid" colspan="4">
                                    <label runat="server" id="lblUbicacion">Administración</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td class="col20_100 CamposGrid">
                                    <label class="Etiquetas">Ubicación</label>
                                </td>
                                <td class="col40_100 CamposGrid">
                                    <asp:RadioButtonList ID="rblUbicacion" runat="server" AutoPostBack="true" 
                                        CssClass="CamposGrid" 
                                        onselectedindexchanged="rblUbicacion_SelectedIndexChanged">
                                        <asp:ListItem Value="G">Galería de Imagenes</asp:ListItem>
                                        <asp:ListItem Value="N">Normativas</asp:ListItem>
                                        <asp:ListItem Value="P">Procedimientos</asp:ListItem>
                                        <asp:ListItem Value="D">Documentos</asp:ListItem>
                                        <asp:ListItem Value="M">Manuales</asp:ListItem>
                                        <asp:ListItem Value="R">Reportes</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="3">                                
                                </td>
                            </tr>
                            <tr>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td align="center" class="col50_100 CamposGrid" colspan="2">
                                    <ajaxToolkit:AsyncFileUpload ID="fulReportes" runat="server" Height="18px"
                                        ThrobberID="loader" 
                                        CssClass="BotonLB ui-state-active ui-corner-all AlaIzquierda"
                                        UploadingBackColor="#d4f897" ErrorBackColor="Red"    
                                        UploaderStyle="Traditional" PersistFile="true" Width="80%"/> 
                                </td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="3">                                
                                </td>
                            </tr>                            
                            <tr>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                                <td class="col25_100 CamposGrid">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100 CamposGrid" style="text-align:center;" colspan="4">
                                    <asp:Button ID="btnUpload" runat="server" Text="Subir archivo" 
                                    OnClick="UploadFile" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" Width="183px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100 CamposGrid" style="text-align:center;" colspan="4">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100 CamposGrid" style="text-align:center;" colspan="4">
                                    <asp:Label ID="lblResultados" runat="server" CssClass="Resultado"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100 CamposGrid" colspan="4" style="text-align:center;">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100 TitulosGrid" style="text-align:center;" colspan="4">
                                    <label runat="server" id="lblNombreCarpeta"></label>
                                </td>
                            </tr>                            
                            <tr>
                                <td class="col100_100 CamposGrid" style="text-align:center;" colspan="4">
                                    <asp:GridView ID="gvwArchivos" CssClass="GridDirectorio" runat="server"
                                        AutoGenerateColumns="False" CellPadding="0" ForeColor="#333333" 
                                        OnRowCreated="gvwArchivos_RowCreated" ShowHeader="false"
                                        ShowHeaderWhenEmpty="true" EmptyDataText="No hay archivos" 
                                        SortedAscendingHeaderStyle-ForeColor="White"  
                                        SortedDescendingHeaderStyle-ForeColor = "White"                                        
                                        GridLines="Horizontal" Width="100%" Height="16px" BorderColor="#CCCCCC">
                                    <HeaderStyle />
                                    <RowStyle BackColor="#EFF3FB"/>
                                    <Columns>
                                        <asp:TemplateField ControlStyle-CssClass=" CamposGrid AlaIzquierda">
                                            <ItemTemplate>
                                                <img alt="" src="images/IconoGrid.png" />
                                            </ItemTemplate>
                                            <ItemStyle Width="3%" CssClass="CamposGrid" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Text" HeaderText="">
                                            <ItemStyle Width="87%" CssClass="CamposGrid" />
                                        </asp:BoundField>  
                                        <asp:TemplateField ControlStyle-CssClass="AlaIzquierda">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkDownload" CommandArgument = '<%# Eval("Value") %>' runat="server" OnClick = "DownloadFile" style="text-align='center';">
                                                    <img src="images/btnDownLoad.png" alt='<%# Eval("Value") %>' title="Descargar" width="25px" Height="18px" style="border-width:0px;" />
                                                </asp:LinkButton>                            
                                            </ItemTemplate>
                                            <ItemStyle CssClass="CamposGrid" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lnkEliminar" CommandArgument = '<%# Eval("Value") %>' runat = "server" OnClick = "DeleteFile">
                                                    <img src="images/Eliminar.png" alt='<%# Eval("Value") %>' width="25px" title="Eliminar" Height="18px" style="border-width:0px;" />
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="CamposGrid" Width="5%" />
                                        </asp:TemplateField>                            
                                        </Columns>
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle CssClass="TitulosGrid" />
                                        <EditRowStyle BackColor="#2461BF" CssClass="CamposGrid" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                </td>
                            </tr>                        
                        </table>
                        <br />
                    </fieldset>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="fulReportes" />
                    <asp:AsyncPostBackTrigger ControlID="rblUbicacion" EventName="SelectedIndexChanged"  />
                    <asp:AsyncPostBackTrigger ControlID="btnUpload" />  
                    <asp:AsyncPostBackTrigger ControlID="gvwArchivos"/>                          
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
</body>
</html>
