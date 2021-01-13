<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Documentos.aspx.cs" Inherits="IntraTecApp.Documentos"  MaintainScrollPositionOnPostback="true" %>
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

    <script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

    <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></scr>pt-->
</head>
<body>
    <form id="frmDocumentos" runat="server">
        <div class="container ui-corner-all">
            <div class="content">
            <asp:ScriptManager ID="smgDocumentos" runat="server">
            </asp:ScriptManager>
            <asp:Panel ID="pnlDocumento" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                <asp:Label ID="lblTipoDocumento" runat="server"></asp:Label>
            </asp:Panel>
            <div class="Div10"></div>   
            <asp:UpdateProgress ID="udpDocumento" runat="server" AssociatedUpdatePanelID="udpDocumentos"
                DisplayAfter="0" DynamicLayout="True">
                <ProgressTemplate>
                    <div class="pnlProgressBar">
                        <img alt="" src="../images/imgBarraProgreso.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>  
            <asp:UpdatePanel ID="udpDocumentos" runat="server" Width="100%" CssClass="PanelNoBorde">
                <ContentTemplate>
                    <asp:HiddenField ID="hdnTipoConsulta" runat="server" />
                    <fieldset id="flsDocumentos" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                        <asp:GridView CssClass="GridDirectorio" ID="gvwArchivos" runat="server" 
                            AutoGenerateColumns="False" CellPadding="0" ForeColor="#333333"  
                            EmptyDataRowStyle-CssClass="CamposGrid"
                            ShowHeaderWhenEmpty="true" EmptyDataText="No hay archivos en esta ubicación." 
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
                                <asp:TemplateField HeaderText="Archivo" >
                                    <ItemTemplate>
                                        <span style="vertical-align:middle;">                                   
                                            <asp:HyperLink ID="nombre" runat="server" Text='<%# Eval("Name") %>' CssClass="CamposGrid">
                                            </asp:HyperLink>
                                        </span>
                                    </ItemTemplate>
                                    <ItemStyle Width="82%" CssClass="CamposGrid" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Length" HeaderText="Tamaño KB">
                                    <ItemStyle Width="10%" CssClass="CamposGrid" />
                                </asp:BoundField>                        
                                <asp:TemplateField HeaderText="" >
                                    <ItemTemplate>
                                        <asp:HyperLink ID="descarga" runat="server" NavigateUrl='<%# Eval("Name", "~/VisorPDF.aspx?path=" + Eval("Directory") + "&filename={0}") %>'>
                                            <img src="images/btnVistaPrevia.png" alt='<%# Eval("Name") %>' style="border-width:0px;" />
                                        </asp:HyperLink>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" CssClass="CamposGrid AlCentro" />
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle CssClass="TitulosGrid" />
                            <EditRowStyle BackColor="#2461BF" CssClass="CamposGrid" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                    </fieldset>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
</body>
</html>
