<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PopUpAdmin.aspx.cs" Inherits="IntraTecApp.PopUpAdmin"  MaintainScrollPositionOnPostback="true" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor" TagPrefix="cc1" %>
<!DOCTYPE HTML>
<!--[if IE 7 ]>		 <html class="no-js ie ie7 lte7 lte8 lte9" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="es-ES"> <![endif]-->
<!--[if IE 8 ]>		 <html class="no-js ie ie8 lte8 lte9" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="es-ES"> <![endif]-->
<!--[if IE 9 ]>		 <html class="no-js ie ie9 lte9>" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="es-ES"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--><html class="no-js" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="es-ES"> <!--<![endif]-->
<head id="Encabezado" runat="server">
    <meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

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
    <form id="frmPopUpAdmin" runat="server"> 
    <div class="container ui-corner-all">
        <div class="content">
            <asp:ScriptManager ID="smgPopUpAdmin" EnableScriptGlobalization="true" runat="server" EnablePartialRendering="true" >
            </asp:ScriptManager>
            <asp:Panel ID="pnlPopUp" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
                <asp:Label ID="lblFileName" runat="server" Text="Mensajes Pop-Up" />
            </asp:Panel> 
            <asp:UpdateProgress ID="upgBuscarPopUp" runat="server" AssociatedUpdatePanelID="udpBuscarPopUp"
                DisplayAfter="0" DynamicLayout="True">
                <ProgressTemplate>
<%--                    <div class="pnlProgressBar">
                        <img alt="" src="../images/imgBarraProgreso.gif" />
                    </div>--%>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="Div10"></div>
            <asp:UpdatePanel runat="server" ID="udpBuscarPopUp" UpdateMode="Conditional">
                <ContentTemplate>
                    <fieldset id="flsBuscar" runat="server" class="FieldSet FieldSetClaro ui-corner-all" visible="false" >
                        <legend></legend>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col100_100 TitulosGrid" colspan="2">
                                    <label>Buscar</label>
                                </td>
                            </tr>                            
                            <tr>
                                <td class="col100_100" align="left">                                
                                    <asp:Button ID="btnVolver" runat="server" 
                                        CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                        onclick="btnVolver_Click" Text="Ir a Editar" />                                
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td style="background:#CCCCCC;">
                                    <asp:GridView ID="gdvPopUp" runat="server" AllowPaging="true" 
                                        AllowSorting="true" AlternatingRowStyle-BackColor="#CCCCCC" 
                                        AutoGenerateColumns="false" BorderColor="#CCCCCC" BorderStyle="Solid" 
                                        BorderWidth="1px" CellPadding="0" CurrentSortDir="ASC" 
                                        SortedAscendingHeaderStyle-ForeColor="White"  
                                        SortedDescendingHeaderStyle-ForeColor = "White"
                                        OnPageIndexChanging="gdvPopUp_PageIndexChanging" 
                                        OnRowCreated="gdvPopUp_RowCreated"
                                        OnSorting="gdvPopUp_Sorting" PagerStyle-CssClass="Titulos10" 
                                        PagerSettings-Visible="true" Width="100%" HorizontalAlign="Center" 
                                        EmptyDataText="..." 
                                        Height="18px" GridLines="Horizontal"
                                        PageSize="15" 
                                        OnRowCommand="gdvPopUp_RowCommand"                                  
                                        DataKeyNames ="IDPopUp" 
                                        OnSelectedIndexChanged="gdvPopUp_SelectedIndexChanged"
                                        ShowHeaderWhenEmpty="true" 
                                        style="margin-top: 0px; margin-left: 0px;" >
                                        <Columns>
                                            <asp:TemplateField ControlStyle-CssClass="CamposGrid" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <img alt="" src="images/IconoGrid.png" />
                                                </ItemTemplate>
                                                <ItemStyle Width="5%" CssClass="CamposGrid" />
                                            </asp:TemplateField> 
                                            <asp:TemplateField HeaderText="Titulo" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Bottom"> 
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTitulo" runat="server" CssClass="CamposGrid" Text='<%# System.Web.HttpUtility.HtmlDecode((string)Eval("Titulo")) %>' />
                                                </ItemTemplate>
                                                <ItemStyle Width="25%" CssClass="CamposGrid" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="FechaDesde" HeaderText="Desde" SortExpression="FechaDesde">
                                                <HeaderStyle CssClass="TitulosGrid" />
                                                <ItemStyle Width="20%" CssClass="CamposGrid" />
                                            </asp:BoundField>  
                                            <asp:BoundField DataField="FechaHasta" HeaderText="Hasta" SortExpression="FechaHasta">
                                                <HeaderStyle CssClass="TitulosGrid" />
                                                <ItemStyle Width="20%" CssClass="CamposGrid" />
                                            </asp:BoundField>  
                                            <asp:BoundField DataField="StatusDesc" HeaderText="Status" SortExpression="Status">
                                                <HeaderStyle CssClass="TitulosGrid" />
                                                <ItemStyle Width="20%" CssClass="CamposGrid" />
                                            </asp:BoundField>  
                                            <asp:TemplateField ControlStyle-CssClass="CamposGrid" ItemStyle-HorizontalAlign="Center" 
                                                ItemStyle-VerticalAlign="NotSet" ItemStyle-Width="8%">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEditar" runat="server" CommandName="Editar" CausesValidation="false" CommandArgument='<%# Eval("IDPopUp") %>'>
                                                        <asp:Image ID="imgLnkEditar" ImageUrl="~/images/edit.png" 
                                                        ToolTip="Editar" Width="20px" Height="20px" runat="server" />
                                                    </asp:LinkButton>
                                                 </ItemTemplate>                                                 
                                                 <ItemStyle Width="5%" CssClass="CamposGrid" />
                                            </asp:TemplateField>
                                            <asp:TemplateField ControlStyle-CssClass="CamposGrid" ItemStyle-HorizontalAlign="Center" 
                                                ItemStyle-VerticalAlign="NotSet" ItemStyle-Width="8%">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lnkEliminar" runat="server" CommandName="Eliminar" CausesValidation="false" CommandArgument='<%# Eval("IDPopUp") %>'>
                                                        <asp:Image ID="imgLnkEliminar" ImageUrl="~/images/deletered.png" 
                                                        ToolTip="Eliminar" Width="20px" Height="20px" runat="server" />
                                                    </asp:LinkButton>
                                                 </ItemTemplate>                                                 
                                                 <ItemStyle Width="5%" CssClass="CamposGrid" />
                                            </asp:TemplateField>
                                        </Columns>    
                                        <EmptyDataRowStyle CssClass="aLaIzquierda" />
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle CssClass="TitulosGrid" Height="18px" />
                                        <SortedAscendingHeaderStyle CssClass="TitulosGrid" ForeColor="White" />
                                        <SortedDescendingHeaderStyle CssClass="TitulosGrid" ForeColor="White"  />
                                        <EditRowStyle BackColor="#2461BF" CssClass="CamposGrid" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                </td>     
                            </tr>
                            <tr>
                                <td class="col100_100" align="center" colspan="3">
                                    <asp:Label ID="lblResultadoBusqueda" runat="server" CssClass="Resultado"></asp:Label>
                                </td>
                            </tr>     
                        </table>
                    </fieldset>        
                    <fieldset id="flsEditar" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                        <legend></legend>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col100_100 TitulosGrid" colspan="2">
                                    <label>Incluir - Editar</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2" align="left">
                                    <asp:HiddenField ID="hdnIDPopUpActual" runat="server" />
                                    <asp:ImageButton ID="btnActivarBusquedaPopUp" runat="server" 
                                        AlternateText="Borrar foto" CausesValidation="false" 
                                        CssClass="BotonLBBuscar ui-state-active ui-corner-all" Height="24px" 
                                        ImageUrl="~/images/icoLimpiar.png" OnClick="btnActivarBusquedaPopUp_Click" 
                                        ToolTip="Limpiar Campos" Width="24px" />
                                    <asp:ImageButton ID="btnBusquedaAvanzada" runat="server" 
                                        AlternateText="Borrar foto" CausesValidation="false" 
                                        CssClass="BotonLBBuscar ui-state-active ui-corner-all" Height="24px" 
                                        ImageUrl="~/images/btnBusquedaAvanzada.png" OnClick="btnBuscarAvanzada_Click" 
                                        ToolTip="Busqueda Avanzada" Width="24px" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" class="col100_100" colspan="2">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2">
                                    <asp:Label ID="lblTitulo" runat="server" CssClass="Etiquetas">Título:</asp:Label>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="col60_100" rowspan="2">
                                    <br />
                                    <cc1:Editor ID="edtTitulo" CssClass="Campos" width="100%" Height="90px" runat="server" NoUnicode="true"  />
                                    <br />
                                </td> 
                                <td text-align:center;" class="col40_100">
                                <asp:Image ID="previewImage" runat="server" Height="200px" Width="300px" 
                                    CssClass="Foto" BorderWidth="1px" BorderStyle="solid" BorderColor="#999999" BackColor="#CCCCCC" />
                                <asp:ImageButton ID="btnEliminarFoto" runat="server" AlternateText="Borrar foto" 
                                    CausesValidation="false" Height="22px" CssClass="BotonLBBuscar ui-state-active ui-corner-all" 
                                    ImageUrl="~/images/cancel.png" onclick="btnEliminarFoto_Click" />
                                </td>
                            </tr>
                            <tr>
                                <td class="col40_100" style="text-align:center;">
                                    <ajaxToolkit:AsyncFileUpload ID="asyncFileUpload" runat="server" Height="18px" 
                                        OnClientUploadComplete="OnClientAsyncFileUploadComplete" 
                                        CssClass="BotonLB ui-state-active ui-corner-all AlaIzquierda" 
                                        OnUploadedComplete="OnAsyncFileUploadComplete" UploaderStyle="Traditional"
                                        Width="100%" />                       
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2">
                                    <asp:RequiredFieldValidator ID="rfvTitulo" runat="server" 
                                        ControlToValidate="edtTitulo" CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="cpvTitulo" runat="server" 
                                        ControlToValidate="edtTitulo" CssClass="Validator" ErrorMessage="↑ No Valido" 
                                        Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2">
                                    <asp:Label ID="lblContenido" runat="server" CssClass="Etiquetas">Texto:</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" colspan="2">
                                    <cc1:Editor ID="edtContenido" CssClass="Campos" width="100%" Height="200px" runat="server" NoUnicode="true" />
                                </td>
                            </tr>
                        </table>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col25_100">
                                        <asp:RequiredFieldValidator ID="rfvContenido" runat="server" 
                                            ControlToValidate="edtContenido" InitialValue="" CssClass="Validator" Text="↑ Requerido" />
                                </td>
                                <td class="col25_100">
                                        <asp:CompareValidator ID="cpvContenido" runat="server" 
                                            ControlToValidate="edtContenido" CssClass="Validator" 
                                            ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col50_100">
                                        &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col50_100" align="left" colspan="2">
                                    <asp:Label ID="lblDesde" runat="server" CssClass="Etiquetas">Desde:</asp:Label>
                                </td>
                                <td class="col50_100" align="left">
                                    <asp:Label ID="lblHasta" runat="server" CssClass="Etiquetas">Hasta:</asp:Label>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="col50_100" colspan="2">
                                    <asp:TextBox ID="txtDesde" runat="server" CssClass=" Campos AlaDerecha" 
                                        Height="18px" Width="100px"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="cletxtDesde" CssClass="CalendarioPopUp" TargetControlID="txtDesde" runat="server" Format="dd/MM/yyyy" PopupPosition="BottomLeft" FirstDayOfWeek="Monday"  />  
                                    <ajaxToolkit:MaskedEditExtender ID="meeDesde" runat="server" Enabled="True" 
                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtDesde">
                                    </ajaxToolkit:MaskedEditExtender>
                                    <asp:DropDownList ID="ddlHoraDesde" runat="server" CssClass="Campos" Height="18px" 
                                        Width="55px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlMinDesde" runat="server" CssClass="Campos" Height="18px" 
                                        Width="55px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlAMPMDesde" runat="server" CssClass="Campos" Height="18px" 
                                        Width="60px">
                                    </asp:DropDownList>
                                </td>
                                <td class="col50_100">
                                    <asp:TextBox ID="txtHasta" runat="server" CssClass="Campos AlaDerecha" 
                                        Height="18px" Width="100px"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="cletxtHasta" runat="server" 
                                        CssClass="CalendarioPopUp" FirstDayOfWeek="Monday" Format="dd/MM/yyyy" 
                                        PopupPosition="BottomLeft" TargetControlID="txtHasta" />
                                    <ajaxToolkit:MaskedEditExtender ID="meeHasta" runat="server" Enabled="True" 
                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtHasta">
                                    </ajaxToolkit:MaskedEditExtender>
                                    <asp:DropDownList ID="ddlHoraHasta" runat="server" CssClass="Campos" 
                                        Height="18px" Width="55px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlMinHasta" runat="server" CssClass="Campos" 
                                        Height="18px" Width="55px">
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlAMPMHasta" runat="server" CssClass="Campos" 
                                        Height="18px" Width="60px">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td class="col50_100" colspan="2">
                                    <asp:RequiredFieldValidator ID="rfvDesde" runat="server" 
                                        ControlToValidate="txtDesde" CssClass="Validator" InitialValue="" 
                                        Text="↑ Requerido" />
                                </td>
                                <td class="col50_100">
                                    <asp:RequiredFieldValidator ID="rfvHasta" runat="server" 
                                        ControlToValidate="txtHasta" CssClass="Validator" InitialValue="" 
                                        Text="↑ Requerido" />
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" align="left" colspan="3">
                                    <asp:Label ID="lblStatus" runat="server" CssClass="Etiquetas">Status:</asp:Label>
                                    &nbsp;&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col50_100" colspan="2">
                                    <asp:RadioButtonList ID="rblStatus" runat="server" CssClass="Etiquetas" 
                                        Height="16px" RepeatDirection="Horizontal" Width="173px">
                                        <asp:ListItem Value="1">Activo</asp:ListItem>
                                        <asp:ListItem Value="0">Inactivo</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td class="col50_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col50_100" colspan="2">
                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                                        ControlToValidate="rblStatus" CssClass="Validator" Text="↑ Requerido" />
                                </td>
                                <td class="col50_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col100_100" align="center" colspan="3">
                                    <asp:Button ID="btnGuardar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                        onclick="btnGuardar_Click" Text="Guardar" Width="100px" />
                                </td>
                            </tr>
                            <tr>
                                <td class="col100_100" align="center" colspan="3">
                                    <asp:Label ID="lblResultados" runat="server" CssClass="Resultado"></asp:Label>
                                </td>
                            </tr>                        
                         </table>
                    </fieldset>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="gdvPopUp" />
                    <asp:AsyncPostBackTrigger ControlID="btnGuardar"  EventName="Click"/>
                    <asp:AsyncPostBackTrigger ControlID="btnActivarBusquedaPopUp" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
</body>
</html>
