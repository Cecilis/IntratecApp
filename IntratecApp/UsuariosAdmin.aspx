<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuariosAdmin.aspx.cs" Inherits="IntraTecApp.UsuariosAdmin"  MaintainScrollPositionOnPostback="true" %>
<!DOCTYPE HTML>
<html class="no-js">
<head id="Encabezado" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>:: First Central International Bank ::</title>
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

<script type="text/javascript">
    $(document).load(function () {
        $('#<%= txtUsuario.ClientID%>').focus(function () {
            $('#<%= txtNombre.ClientID%>').val('');
            $('#<%= txtNroIntentosFallidos.ClientID%>').val('');
            $('#<%= txtFechaUltimaConexion.ClientID%>').val('');
        });
    });

    var oPageRequestManager = Sys.WebForms.PageRequestManager.getInstance();

    oPageRequestManager.add_endRequest(function () {
        $('#<%= txtUsuario.ClientID%>').focus(function () {
            $('#<%= txtNombre.ClientID%>').val('');
            $('#<%= txtNroIntentosFallidos.ClientID%>').val('');
            $('#<%= txtFechaUltimaConexion.ClientID%>').val('');
            alert($('#<%= txtNombre.ClientID%>').val());
        });
    });
  
                                                                                                                                                                    
</script>
</head>
<body>
<form id="frmUsuariosAdmin" runat="server">
    <div class="container ui-corner-all">
        <div class="content">
        <asp:ScriptManager ID="smgUsuarioAdmin" runat="server">
        </asp:ScriptManager>  
        <asp:Panel ID="pnlAutenticacion" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all" Width="100%">
            <asp:Label ID="lblSesion" runat="server">Usuarios</asp:Label>
        </asp:Panel>
        <div class="Div10"></div>
        <asp:UpdateProgress ID="ugpEditarUsuario" runat="server" AssociatedUpdatePanelID="udpEditarUsuario"
            DisplayAfter="0" DynamicLayout="True">
            <ProgressTemplate>
                <div class="pnlProgressBar">
                    <img alt="" src="../images/imgBarraProgreso.gif" />
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel runat="server" ID="udpEditarUsuario" UpdateMode="Conditional">
            <ContentTemplate>
                <fieldset id="flsBuscar" runat="server" class="FieldSet FieldSetClaro ui-corner-all" visible="false">
                    <legend></legend>
                    <table class="tablaContenidoFormulario">
                        <tr>
                            <td class="col100_100 TitulosGrid" colspan="3">
                                <label> CONSULTAR</label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col10_100" align="left">
                                <asp:Button ID="btnVolver" runat="server" 
                                    CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                    onclick="btnVolver_Click" Text="Ir a Editar" />
                            </td>
                            <td class="col80_100" >
                                &nbsp;</td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>                                                                             
                        <tr>
                            <td class="col100_100" colspan="3">
                                &nbsp;
                                <asp:GridView ID="gvwConsulta" runat="server" AllowPaging="true" 
                                    AllowSorting="true" AlternatingRowStyle-BackColor="#CCCCCC" 
                                    AutoGenerateColumns="false" BorderColor="#CCCCCC" BorderStyle="Solid" 
                                    BorderWidth="1px" CellPadding="0" CurrentSortDir="ASC" 
                                    CurrentSortField="IDUsuario" DataKeyNames="IDUsuario" EmptyDataText="..." 
                                    Height="18px" HorizontalAlign="Center" GridLines="Horizontal"
                                    OnPageIndexChanging="gvwConsulta_PageIndexChanging" 
                                    OnRowCommand="gvwConsulta_RowCommand" Font-Size="10px" 
                                    SortedAscendingHeaderStyle-ForeColor="White"  
                                    SortedDescendingHeaderStyle-ForeColor = "White"
                                    OnSelectedIndexChanged="gvwConsulta_SelectedIndexChanged" 
                                    OnSorting="gvwConsulta_Sorting" PagerSettings-Visible="true" 
                                    PagerStyle-CssClass="Titulos10" PageSize="25" ShowHeaderWhenEmpty="true" 
                                    style="margin-top: 0px; margin-left: 0px;" Width="100%">
                                    <Columns>
                                        <asp:TemplateField ControlStyle-CssClass="CamposGrid" HeaderStyle-CssClass="TitulosGrid" 
                                            ItemStyle-HorizontalAlign="Center">
                                            <ItemTemplate>
                                                <img alt="" src="images/IconoGrid.png" />
                                                <asp:Label ID="lblUsuario" runat="server" Visible="false" Text='<%# Eval("Usuario") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="CamposGrid" Width="5%" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Usuario" HeaderText="Usuario" 
                                            SortExpression="Usuario">
                                        <HeaderStyle CssClass="TitulosGrid" />
                                        <ItemStyle CssClass="CamposGrid" Width="20%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                                        <HeaderStyle CssClass="TitulosGrid" />
                                        <ItemStyle CssClass="CamposGrid" Width="40%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Status" HeaderText="Estado" SortExpression="Status">
                                        <HeaderStyle CssClass="TitulosGrid" />
                                        <ItemStyle CssClass="CamposGrid" Width="15%" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="StatusBloqueo" HeaderText="Bloqueo" 
                                            SortExpression="StatusBloqueo">
                                        <HeaderStyle CssClass="TitulosGrid" />
                                        <ItemStyle CssClass="CamposGrid" Width="15%" />
                                        </asp:BoundField>
                                        <asp:TemplateField ControlStyle-CssClass="CamposGrid" HeaderText="" HeaderStyle-CssClass="TitulosGrid"
                                            ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="NotSet" 
                                            ItemStyle-Width="8%">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="btnVerDetalle" runat="server" CommandName="VerDetalle" 
                                                    ImageUrl="~/images/edit.png" OnDataBinding="btnVerDetalle_DataBinding" 
                                                    ToolTip="Ver Detalle" />
                                            </ItemTemplate>
                                            <ItemStyle CssClass="CamposGrid AlCentro" Width="5%" />
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
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100" align="center" colspan="3">
                                <asp:Label ID="lblResultadoConsulta" runat="server" CssClass="Resultado" Width="100%"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col10_100">
                                &nbsp;</td>
                            <td class="col80_100">
                                &nbsp;</td>
                            <td class="col10_100">
                                &nbsp;</td>
                        </tr>
                    </table>
                </fieldset>
                <fieldset id="flsEditar" runat="server" class="FieldSet FieldSetClaro ui-corner-all" >
                <legend></legend>
                    <table class="tablaContenidoFormulario">
                        <tr>
                            <td class="col10_100 TitulosGrid" colspan="2">
                                Datos Básicos
                            </td>
                        </tr>
                        <tr>
                            <td class="col50_100" style="text-align:left;" align="left">
                                <asp:Label ID="lblUsuario" runat="server" CssClass="Etiquetas">Usuario:</asp:Label>
                            </td>
                            <td class="col50_100" style="text-align:left;" align="left">
                                &nbsp;</td>
                        </tr>
                        <tr>
                            <td class="col50_100" align="center" valign="middle">
                                <asp:Panel ID="pnlUsuario" runat="server" DefaultButton="btnBuscarUsuario" Style="vertical-align: middle;">
                                    <table>
                                            <tr align="center" valign="middle">
                                                <td align="center" valign="middle" >
                                                        <asp:TextBox ID="txtUsuario" runat="server" Width="125px" CssClass="AlaDerecha Campos"
                                                        Height="18px"></asp:TextBox>
                                                </td>
                                                <td align="center" valign="middle" >
                                                        <asp:Button ID="btnBuscarUsuario" Text="..." CssClass="BotonLBBuscar ui-state-active ui-corner-all"                                              
                                                            OnClick="btnBuscarUsuario_Click" ToolTip="Buscar" runat="server" CausesValidation="false"
                                                            Height="24px" Width="24px" />
                                                </td>
                                                <td align="center" valign="middle" >
                                                        <asp:ImageButton ID="btnBusquedaAvanzada" runat="server" 
                                                        CausesValidation="false" 
                                                        CssClass="BotonLBBuscar ui-state-active ui-corner-all" 
                                                        Height="24px" ImageUrl="~/images/btnBusquedaAvanzada.png" 
                                                        OnClick="btnBuscarAvanzada_Click" ToolTip="Busqueda Avanzada" Width="24px" 
                                                        AlternateText="Busqueda Avanzada" />
                                                 </td>
                                            </tr>
                                            <tr align="center" valign="middle">
                                                <td align="center" valign="middle" >
                                                    <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" 
                                                        ControlToValidate="txtUsuario" CssClass="Validator" Text="↑ Requerido" />
                                                    <asp:CompareValidator ID="cpvUsuario" runat="server" 
                                                        ControlToValidate="txtUsuario" CssClass="Validator" ErrorMessage="↑ No Valido" 
                                                        Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                                </td>
                                                <td align="center"  valign="middle">
                                                    &nbsp;</td>
                                                <td align="center"  valign="middle">
                                                    &nbsp;</td>
                                            </tr>
                                        </table>                                    
                                </asp:Panel>
                            </td>
                            <td class="col50_100" style="text-align:left;">
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td class="col100_100" style="text-align:left;" align="left" colspan="2">
                                <asp:Label ID="lblNombre" runat="server" CssClass="Etiquetas">Nombre:</asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" class="col100_100" colspan="2" style="text-align:left;">
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="Campos" Height="18px" 
                                    Width="90%"></asp:TextBox>
                                <br />
                                <asp:RequiredFieldValidator ID="rfvNombre" runat="server" 
                                    ControlToValidate="txtNombre" CssClass="Validator" Text="↑ Requerido" />
                                &nbsp;<asp:CompareValidator ID="rqvNombre" runat="server" 
                                    ControlToValidate="txtNombre" CssClass="Validator" ErrorMessage="↑ No Valido" 
                                    Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                            </td>
                        </tr>
                        <tr>
                            <td align="left" class="col50_100" style="text-align:left;">
                                <asp:Label ID="lblBloqueo" runat="server" CssClass="Etiquetas">Estado:</asp:Label>
                            </td>
                            <td align="left" class="col50_100" style="text-align:left;">
                                <asp:Label ID="lblStatusBloqueo" runat="server" CssClass="Etiquetas">Bloqueado:</asp:Label>
                            </td>
                        </tr>
                        <tr align="right">
                            <td class="col50_100" align="right">
                                <asp:RadioButtonList ID="rblStatus" runat="server" AutoPostBack="True" 
                                    CssClass="Etiquetas" Height="16px" 
                                    onselectedindexchanged="rblStatus_SelectedIndexChanged" 
                                    RepeatDirection="Horizontal" Width="189px">
                                    <asp:ListItem Value="1">Activo</asp:ListItem>
                                    <asp:ListItem Value="0">Inactivo</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" 
                                    ControlToValidate="rblStatus" CssClass="Validator" InitialValue="" 
                                    Text="↑ Requerido" />
                                <asp:HiddenField ID="hdnStatusAnterior" runat="server" />
                            </td>
                            <td class="col50_100" align="right">
                                <asp:RadioButtonList ID="rblStatusBloqueo" runat="server" AutoPostBack="True" 
                                    CssClass="Etiquetas" Height="16px" RepeatDirection="Horizontal" Width="189px">
                                    <asp:ListItem Value="1">Si</asp:ListItem>
                                    <asp:ListItem Value="0">No</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:RequiredFieldValidator ID="rfvStatusBloqueo" runat="server" 
                                    ControlToValidate="rblStatus" CssClass="Validator" InitialValue="" 
                                    Text="↑ Requerido" />
                            </td>
                        </tr>
                        <tr>
                            <td class="col50_100" style="text-align:left;" align="left">
                                <asp:Label ID="lblNroIntentosFallidos" runat="server" CssClass="Etiquetas">Nro Intentos Fallidos:</asp:Label>
                            </td>
                            <td class="col50_100" style="text-align:left;" align="left">
                                <asp:Label ID="lblFechaUltimaConexion" runat="server" CssClass="Etiquetas">Fecha Última Conexión:</asp:Label>
                            </td>
                        </tr>
                        <tr align="center">
                            <td class="col50_100" align="right">
                                <asp:TextBox ID="txtNroIntentosFallidos" runat="server" CssClass="Campos" style="text-align:right;"
                                    Height="18px" ReadOnly="True" Width="59px"></asp:TextBox>
                                <asp:HiddenField ID="hdnStatusBloqueoAnterior" runat="server" />
                            </td>
                            <td class="col50_100" align="right">
                                <asp:TextBox ID="txtFechaUltimaConexion" runat="server" style="text-align:right;"
                                    CssClass="Campos AlaDerecha" Height="22px" ReadOnly="True" Width="251px" 
                                    ontextchanged="txtFechaUltimaConexion_TextChanged"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="col50_100" style="text-align:left;" align="right">
                                <asp:CheckBox ID="chkResetearClave" runat="server" CssClass="Etiquetas" 
                                    Text="Resetear Clave" TextAlign="Left" />
                                <asp:HiddenField ID="hdnIDUsuario" runat="server" />
                            </td>
                            <td class="col50_100" style="text-align:left;" align="center">
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td class="col50_100" style="text-align:center;" align="center" colspan="2">
                                <asp:Label ID="lblResultado" runat="server" CssClass="Resultado" Width="100%"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td class="col50_100" colspan="2" style="text-align:center;" align="center">
                                <asp:Button ID="btnGuardar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                                    onclick="btnGuardar_Click" Text="Guardar" Width="100px" />
                            </td>
                        </tr>
                        <tr>
                            <td class="col50_100" style="text-align:left;" align="center">
                                <div style="display: none;">
                                    <asp:Button ID="btnTextBoxEventHandler" runat="server"
                                    OnClick="btnTextBoxEventHandler_Click" />
                                </div>                           
                            </td>
                            <td class="col50_100" style="text-align:left;" align="center">
                                &nbsp;</td>
                        </tr>
                    </table>
            </fieldset>
            </ContentTemplate>
            <Triggers>
                <asp:AsyncPostBackTrigger ControlID="btnGuardar" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>
    </div>
    </div>
</form>
</body>
</html>