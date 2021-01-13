<%@ Page Title="" Language="C#" AutoEventWireup="true" CodeBehind="EmpleadosAdmin.aspx.cs"
    Inherits="IntraTecApp.EmpleadosAdmin" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE HTML>
<html>
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
</head>
<body>
    <script type="text/javascript">

        function Desabilitar() {
            document.getElementById('<%=afuFoto.ClientID %>').setAttribute("disabled", "disabled");
        }

        function Habilitar() {
            document.getElementById('<%=afuFoto.ClientID %>').removeAttribute("disabled");
        }

        function ObtenerNumeroAleatorio() {
            var NumeroAleatorio = Math.random(10000);
            return NumeroAleatorio;
        }
        function OnClientAsyncFileUploadComplete(sender, args) {
            var PaginaVistaPrevia = '<%=Page.ResolveClientUrl("ImagenVistaPrevia.ashx")%>';
            var QueryString = '?randomno=' + ObtenerNumeroAleatorio();
            var OrigenImagen = PaginaVistaPrevia + QueryString;
            var IDEmpleado = '<%=imgVistaPrevia.ClientID %>';
            document.getElementById(IDEmpleado).setAttribute("src", OrigenImagen);
            return false;
        }

    </script>
    <form id="frmEmpleado" runat="server">
    <div class="container ui-corner-all">
        <div class="content">
            <asp:ScriptManager ID="smgEmpleadosAdmin" runat="server" EnableScriptGlobalization="true"
                EnablePartialRendering="true">
            </asp:ScriptManager>
            <asp:Panel ID="pnlConsulta" runat="server" CssClass="Panel Cabecera Titulos ui-state-default ui-corner-all"
                Width="100%">
                <asp:Label ID="lblEmpleados" runat="server" Text="Empleados" />
            </asp:Panel>
            <asp:UpdateProgress ID="ugpEditarEmpleado" runat="server" AssociatedUpdatePanelID="udpEditarEmpleado"
                DisplayAfter="0" DynamicLayout="True">
                <ProgressTemplate>
                    <div class="pnlProgressBar">
                        <img alt="" src="../images/imgBarraProgreso.gif" />
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="Div10">
            </div>
            <asp:UpdatePanel runat="server" ID="udpEditarEmpleado" UpdateMode="Conditional" ChildrenAsTriggers="true">
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
                                    <asp:GridView ID="gvwConsulta" runat="server" AllowPaging="true" 
                                        AllowSorting="true" AlternatingRowStyle-BackColor="#CCCCCC" 
                                        AutoGenerateColumns="false" BorderColor="#CCCCCC" BorderStyle="Solid" 
                                        BorderWidth="1px" CellPadding="0" CurrentSortDir="ASC" 
                                        SortedAscendingHeaderStyle-ForeColor="White"  
                                        SortedDescendingHeaderStyle-ForeColor = "White"
                                        CurrentSortField="IDEmpleado" DataKeyNames="IDEmpleado" EmptyDataText="..." 
                                        Height="18px" HorizontalAlign="Center" GridLines="Horizontal"
                                        OnPageIndexChanging="gvwConsulta_PageIndexChanging" 
                                        OnRowCommand="gvwConsulta_RowCommand" Font-Size="10px" 
                                        OnSelectedIndexChanged="gvwConsulta_SelectedIndexChanged" 
                                        OnSorting="gvwConsulta_Sorting" PagerSettings-Visible="true" 
                                        PagerStyle-CssClass="Titulos10" PageSize="25" ShowHeaderWhenEmpty="true" 
                                        style="margin-top: 0px; margin-left: 0px;" Width="100%">
                                        <Columns>
                                            <asp:TemplateField ControlStyle-CssClass="CamposGrid" HeaderStyle-CssClass="TitulosGrid" 
                                                ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <img alt="" src="images/IconoGrid.png" />
                                                    <asp:Label ID="lblTipoID" runat="server" Visible="false" Text='<%# Eval("TipoID") %>'></asp:Label>
                                                    <asp:Label ID="lblIDNumero" runat="server" Visible="false" Text='<%# Eval("IDNumero") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle CssClass="CamposGrid" Width="3%" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="Identificacion" HeaderText="ID" 
                                                SortExpression="Identificacion">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="10%" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" SortExpression="Nombre">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="10%" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Sexo" HeaderText="Sexo" SortExpression="Sexo">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="5%" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="FechaNacimiento" HeaderText="Fec.Nac." 
                                                SortExpression="FechaNacimiento">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="10%" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="NumSeguroSocial" HeaderText="Seg.Social" 
                                                SortExpression="NumSeguroSocial">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="10%" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DescCargo" HeaderText="Cargo" 
                                                SortExpression="DescCargo">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="10%" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="FecIngreso" HeaderText="Ingreso" 
                                                SortExpression="FecIngreso">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="10%" HorizontalAlign="Center" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Status" HeaderText="Estado" SortExpression="Status">
                                            <HeaderStyle CssClass="TitulosGrid" HorizontalAlign="Center" />
                                            <ItemStyle CssClass="CamposGrid" Width="5%" />
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
                    <fieldset id="flsEditar" runat="server" class="FieldSet FieldSetClaro ui-corner-all">
                        <legend></legend>
                        <table class="tablaContenidoFormulario">
                            <tr>
                                <td class="col100_100 TitulosGrid" colspan="4">
                                    <label> INCLUIR / EDITAR</label>
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    &nbsp;
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100" height="150px;">
                                </td>
                                <td class="col40_100" height="150px;" style="text-align: left;">
                                    <asp:HiddenField ID="hdnVerFileUpload" runat="server" />
                                </td>
                                <td class="col40_100" height="150px;" align="center" rowspan="2">
                                    <asp:Panel ID="pnlFoto" runat="server">
                                        <asp:Image ID="imgVistaPrevia" runat="server" Height="139px" Width="107px" CssClass="Foto" />
                                        <asp:ImageButton ID="btnEliminarFoto" runat="server" AlternateText="Borrar foto"
                                            CausesValidation="false" CssClass="BotonLBBuscar ui-state-active ui-corner-all"
                                            ImageUrl="~/images/cancel.png" OnClick="btnEliminarFoto_Click" ToolTip="Quitar Foto" />
                                        <br />
                                        <div id="DeshabilitarFileUpload" runat="server">                                                                      
                                            <ajaxToolkit:AsyncFileUpload ID="afuFoto" runat="server" AllowedFileTypes="gif,png,jpg,jpeg"
                                                CssClass="BotonLB ui-state-active ui-corner-all AlaIzquierda" ErrorBackColor="Red"
                                                Height="18px" OnClientUploadComplete="OnClientAsyncFileUploadComplete" OnUploadedComplete="OnAsyncFileUploadComplete"
                                                PersistFile="true" UploaderStyle="Traditional" UploadingBackColor="#d4f897" Width="80%" />
                                        </div>
                                    </asp:Panel>
                                </td>
                                <td class="col10_100" height="150px;">
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblNoIdentificacion" runat="server" CssClass="Etiquetas" Text="N° Identificación"></asp:Label>
                                    <br />
                                    <asp:Panel ID="pnlEmpleando" runat="server" DefaultButton="btnBuscarEmpleado" Style="vertical-align: middle;">
                                        <table>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList ID="cmbTipoID" CssClass="Campos" runat="server" Height="20px" Width="41px">
                                                        <asp:ListItem>I</asp:ListItem>
                                                        <asp:ListItem>P</asp:ListItem>
                                                        <asp:ListItem>V</asp:ListItem>
                                                        <asp:ListItem>E</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtNumIdentificacion" runat="server" Width="125px" CssClass="Campos" style="text-align:right;" 
                                                        Height="18px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Button ID="btnBuscarEmpleado" Text="..." CssClass="BotonLBBuscar ui-state-active ui-corner-all"
                                                        OnClick="btnBuscarEmpleado_Click" ToolTip="Buscar" runat="server" CausesValidation="false"
                                                        Height="24px" Width="24px" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="btnLimpiar" runat="server" Height="24px" Width="24px" AlternateText="Borrar foto"
                                                        CausesValidation="false" CssClass="BotonLBBuscar ui-state-active ui-corner-all"
                                                        ImageUrl="~/images/icoLimpiar.png" OnClick="btnLimpiar_Click" ToolTip="Limpiar Campos" />
                                                </td>
                                                <td>
                                                    <asp:ImageButton ID="btnBusquedaAvanzada" runat="server" Height="24px" Width="24px" AlternateText="Borrar foto"
                                                        CausesValidation="false" CssClass="BotonLBBuscar ui-state-active ui-corner-all"
                                                        ImageUrl="~/images/btnBusquedaAvanzada.png" OnClick="btnBuscarAvanzada_Click" ToolTip="Busqueda Avanzada" />
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                    <asp:RequiredFieldValidator ID="rqvtxtNumIdentificacion" runat="server" ControlToValidate="txtNumIdentificacion"
                                        CssClass="Validator" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="rqvNumIdentificacion" runat="server" ControlToValidate="txtNumIdentificacion"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;</td>
                                <td class="col80_100" align="center" colspan="2">
                                    <asp:Label ID="lblResultado" runat="server" CssClass="Resultado" Width="100%"></asp:Label>
                                </td>
                                <td class="col10_100">
                                    &nbsp;</td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblNombres" runat="server" CssClass="Etiquetas" Text="Nombres"></asp:Label>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblApellidos" runat="server" CssClass="Etiquetas" 
                                        Text="Apellidos"></asp:Label>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:TextBox ID="txtNombre" runat="server" CssClass="Campos" Height="18px" Width="250px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtApellido"
                                        CssClass="Validator" InitialValue="" Text="↑ Requerido" />
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:TextBox ID="txtApellido" runat="server" CssClass="Campos" Height="18px" Width="250px"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido"
                                        CssClass="Validator" InitialValue="" Text="↑ Requerido" />
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="blSexo" runat="server" CssClass="Etiquetas" Text="Sexo"></asp:Label>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblFechaNacimiento" runat="server" CssClass="Etiquetas" Text="Fecha Nacimiento"></asp:Label>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:DropDownList ID="cmbSexo" runat="server" CssClass="Campos" Height="18px" OnSelectedIndexChanged="cmbSexo_SelectedIndexChanged"
                                        Width="120px">
                                        <asp:ListItem Value="N">Seleccionar...</asp:ListItem>
                                        <asp:ListItem Value="F">Femenino</asp:ListItem>
                                        <asp:ListItem Value="M">Masculino</asp:ListItem>
                                    </asp:DropDownList>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="cmbSexo"
                                        CssClass="Validator" InitialValue="N" Text="↑ Requerido" />
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:TextBox ID="txtFecNac" runat="server" CssClass="Campos AlaDerecha" Height="18px" style="text-align:right;"
                                        Width="125px"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="cletxtFecNac" runat="server" CssClass="CalendarioPopUp"
                                        FirstDayOfWeek="Monday" Format="dd/MM/yyyy" PopUpPosition="BottomLeft" TargetControlID="txtFecNac" />
                                    <ajaxToolkit:MaskedEditExtender ID="meeFecNac" runat="server" Enabled="True" Mask="99/99/9999"
                                        MaskType="Date" TargetControlID="txtFecNac">
                                    </ajaxToolkit:MaskedEditExtender>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvFecNac" runat="server" ControlToValidate="txtFecNac"
                                        CssClass="Validator" InitialValue="" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="cmvFecNac" runat="server" ControlToValidate="txtFecNac"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblNoSeguroSocial" runat="server" CssClass="Etiquetas" Text="N° Seguro Social"></asp:Label>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblFecIngreso" runat="server" CssClass="Etiquetas" Text="Fecha de Ingreso"></asp:Label>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:TextBox ID="txtNumSegSocial" runat="server" CssClass="Campos AlaIzquierda" Height="18px"
                                        MaxLength="10"></asp:TextBox>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvNoSeguroSocial" runat="server" ControlToValidate="txtNumSegSocial"
                                        CssClass="Validator" InitialValue="" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="cpvNoSeguroSocial" runat="server" ControlToValidate="txtNumSegSocial"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:TextBox ID="txtFecIngreso" runat="server" CssClass="Campos AlaDerecha" Height="18px" style="text-align:right;" 
                                        Width="125px"></asp:TextBox>
                                    <ajaxToolkit:CalendarExtender ID="cexFechaIngreso" runat="server" CssClass="CalendarioPopUp"
                                        FirstDayOfWeek="Monday" Format="dd/MM/yyyy" PopUpPosition="BottomLeft" TargetControlID="txtFecIngreso" />
                                    <ajaxToolkit:MaskedEditExtender ID="meeFecIngreso" runat="server" Enabled="True"
                                        Mask="99/99/9999" MaskType="Date" TargetControlID="txtFecIngreso">
                                    </ajaxToolkit:MaskedEditExtender>
                                    <br />
                                    <asp:RequiredFieldValidator ID="rfvFecIngreso" runat="server" ControlToValidate="txtFecIngreso"
                                        CssClass="Validator" InitialValue="" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="cpvFecIngreso" runat="server" ControlToValidate="txtFecIngreso"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Date"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblCargo" runat="server" CssClass="Etiquetas" Text="Cargo"></asp:Label>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    &nbsp;
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col80_100" colspan="2">
                                    <asp:TextBox ID="txtCargo" runat="server" CssClass="Campos" Height="60px" MaxLength="300"
                                        TextMode="MultiLine" Width="100%"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCargo" runat="server" ControlToValidate="txtCargo"
                                        CssClass="Validator" InitialValue="" Text="↑ Requerido" />
                                    <asp:CompareValidator ID="cmvCargo" runat="server" ControlToValidate="txtCargo" CssClass="Validator"
                                        ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="String"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblTlfMovil" runat="server" CssClass="Etiquetas" Text="Tlf. Móvil"></asp:Label>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblTlfOficina" runat="server" CssClass="Etiquetas" Text="Tlf. Oficina"></asp:Label>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:TextBox ID="txtCodAreaMovil" runat="server" CssClass="Campos AlaDerecha" Height="18px" style="text-align:right;" 
                                        MaxLength="4" Width="45px"></asp:TextBox>
                                    <strong><span class="style1">-</span></strong>
                                    <asp:TextBox ID="txtNumTlfMovil" runat="server" CssClass="Campos AlaDerecha" Height="18px" style="text-align:right;" 
                                        MaxLength="12" Width="100px"></asp:TextBox>
                                    <br />
                                    <asp:CompareValidator ID="cpvCodAreaMovil" runat="server" ControlToValidate="txtCodAreaMovil"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                                    <asp:CompareValidator ID="cpvNumTlfMovil" runat="server" ControlToValidate="txtNumTlfMovil"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:TextBox ID="txtCodAreaOficina" runat="server" CssClass="Campos AlaDerecha" Height="18px" style="text-align:right;" 
                                        MaxLength="4" Width="41px"></asp:TextBox>
                                    <strong>&nbsp;-&nbsp;</strong><asp:TextBox ID="txtNumTlfLocal" runat="server" CssClass="Campos" style="text-align:right;" 
                                        Height="18px" MaxLength="12" Width="100px"></asp:TextBox>
                                    <br />
                                    <asp:CompareValidator ID="cpvCodAreaLocal" runat="server" ControlToValidate="txtCodAreaOficina"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                                    <asp:CompareValidator ID="cpvNumTlfLocal" runat="server" ControlToValidate="txtNumTlfLocal"
                                        CssClass="Validator" ErrorMessage="↑ No Valido" Operator="DataTypeCheck" Type="Integer"></asp:CompareValidator>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:Label ID="lblStatus" runat="server" CssClass="Etiquetas" Text="Estado"></asp:Label>
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    &nbsp;
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:RadioButtonList ID="rblStatus" runat="server" AutoPostBack="False" CssClass="Etiquetas"
                                        Height="16px" OnSelectedIndexChanged="rblStatus_SelectedIndexChanged" RepeatDirection="Horizontal"
                                        Width="189px">
                                        <asp:ListItem Value="1">Activo</asp:ListItem>
                                        <asp:ListItem Value="0">Inactivo</asp:ListItem>
                                    </asp:RadioButtonList>
                                    <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ControlToValidate="rblStatus"
                                        CssClass="Validator" InitialValue="" Text="↑ Requerido" />
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    <asp:CheckBoxList ID="chkStatusPubDatos" runat="server" CssClass="Etiquetas" Height="16px"
                                        TextAlign="Left" Width="177px">
                                        <asp:ListItem Value="1">Publicar en Intranet</asp:ListItem>
                                    </asp:CheckBoxList>
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col80_100" align="center" colspan="2">
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col80_100" align="center" colspan="2">
                                    
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col80_100" align="center" colspan="2">
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" align="center">
                                    <asp:Button ID="btnGuardar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all"
                                        Height="18px" OnClick="btnGuardar_Click" Text="Guardar" Width="100px" />
                                </td>
                                <td class="col40_100" align="center">
                                    <asp:Button ID="btnEliminar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all"
                                        Height="18px" OnClick="btnEliminar_Click" Text="Eliminar"
                                        Width="100px" />
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    &nbsp;
                                </td>
                                <td class="col40_100" style="text-align: left;">
                                    &nbsp;
                                </td>
                                <td class="col10_100">
                                    &nbsp;
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </ContentTemplate>
                <Triggers>
                    <asp:PostBackTrigger ControlID="btnBuscarEmpleado" />
                    <asp:AsyncPostBackTrigger ControlID="btnGuardar" />
                    <asp:AsyncPostBackTrigger ControlID="btnEliminar" />
                    <asp:AsyncPostBackTrigger ControlID="cmbSexo" />
                    <asp:AsyncPostBackTrigger ControlID="rblStatus" />
                    <asp:AsyncPostBackTrigger ControlID="chkStatusPubDatos" />
                    <asp:AsyncPostBackTrigger ControlID="afuFoto" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
    </div>
    </form>
</body>
</html>
