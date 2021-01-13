<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="IntraTecApp.Reportes"  MaintainScrollPositionOnPostback="true" %>
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
        <asp:ScriptManager ID="smgFeeds" runat="server">
        </asp:ScriptManager>
        <asp:Panel ID="pnlReportes" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
            <asp:Label ID="lblTipoDocumento" runat="server"></asp:Label>
        </asp:Panel>
<%--        <asp:UpdateProgress ID="udpDocumento" runat="server" AssociatedUpdatePanelID="udpDocumentos"
            DisplayAfter="0" DynamicLayout="True">
            <ProgressTemplate>
                <div class="pnlProgressBar">
                    Cargando…
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>  --%>
        <div class="Div10"></div>
<%--        <asp:UpdatePanel ID="udpDocumentos" runat="server" Width="100%" CssClass="PanelNoBorde">
            <ContentTemplate>--%>
                <asp:HiddenField ID="hdnTipoConsulta" runat="server" />
                <fieldset id="flsReportes" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                    <legend> </legend>
                        <asp:GridView ID="gvwReportes" runat="server" 
                            AutoGenerateColumns="False" CellPadding="0" ForeColor="#333333" 
                            GridLines="Horizontal" Width="100%" Height="16px" BorderColor="#CCCCCC">
                            <HeaderStyle />
                            <RowStyle BackColor="#EFF3FB"/>
                            <Columns>
                                <asp:TemplateField ControlStyle-CssClass="CamposGrid AlaIzquierda">
                                    <ItemTemplate>
                                        <img alt="" src="images/IconoGrid.png" />
                                    </ItemTemplate>
                                    <ItemStyle Width="3%" CssClass="CamposGrid" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Text" HeaderText="">
                                    <ItemStyle Width="92%" CssClass="CamposGrid" />
                                </asp:BoundField>  
                                <asp:TemplateField ControlStyle-CssClass="CamposGrid AlaIzquierda">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="lnkDownload" CommandArgument = '<%# Eval("Value") %>' runat="server" OnClick = "DownloadFile">
                                            <img src="images/btnDownLoad.png" alt='<%# Eval("Value") %>' title="Descargar" width="25px" Height="18px" style="border-width:0px;" />
                                        </asp:LinkButton>                                        
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" CssClass="CamposGrid AlCentro"  />                                    
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
<%--            </ContentTemplate>
        </asp:UpdatePanel>--%>
        </div>
    </div>
</form>
</body>
</html>

