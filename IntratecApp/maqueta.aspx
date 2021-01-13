<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="maqueta.aspx.cs" Inherits="IntraTecApp.maqueta" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor" TagPrefix="cc1" %>
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

 <%--  

    <link href="styles/PaginaContenido.css" rel="stylesheet" type="text/css" media="screen" />--%> 
    <link href="styles/TablaContenido.css" rel="stylesheet" type="text/css" />
    <link href="styles/Formularios.css" rel="stylesheet" type="text/css" />
    <link href="styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

    <script src="scripts/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
    <!--script src="scripts/Desabilita_Edicion.js" type="text/javascript"></script-->
    <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>  
<body>

        <form id="form1" runat="server">

        <table class="tablaContenidoFormulario">
            <tr>
                <td class="col100_100 TitulosGrid" colspan="3">                   
                    <label>Editar</label>
                </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3" style="text-align:left;">                  
                    <asp:Button ID="btnBuscarEditar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                    onclick="btnBuscarEditar_Click" Text="Buscar - Editar Posts" /> 
                </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3">
                    <asp:Label ID="lblTitulo" runat="server" CssClass="Etiquetas" Text="Título"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3">
                    <asp:TextBox ID="edtTitulo" runat="server" CssClass="Campos" Height="26px" 
                        Width="97%"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3">
                    <asp:Label ID="lblPosteadoPor" runat="server" CssClass="Etiquetas" 
                        Text="Posteado por"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3">
                    <asp:TextBox ID="txtPosteadoPor" runat="server" Width="97%" CssClass="Campos" 
                        Height="18px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3">
                    <asp:Label ID="lblDescripcion" runat="server" CssClass="Etiquetas" 
                        Text="Descripción"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3">
                    <asp:TextBox ID="txtDescripcion" runat="server" Rows="3" TextMode="MultiLine" 
                        Width="100%" CssClass="Campos" Height="45px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="col100_100" colspan="3">
                    <asp:Label ID="lblContenido" runat="server" CssClass="Etiquetas" 
                        Text="Contenido"></asp:Label>                
                </td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    <asp:Image ID="previewImage" runat="server" Height="200px" Width="300px" BorderWidth="1px" BorderStyle="solid" BorderColor="#999999" BackColor="#CCCCCC" />
                    <asp:ImageButton ID="btnEliminarFoto" runat="server" 
                        AlternateText="Borrar foto" CausesValidation="false" Height="18px" 
                        ImageUrl="~/images/cancel.png" onclick="btnEliminarFoto_Click" />
                    <ajaxToolkit:AsyncFileUpload ID="asyncFileUpload" runat="server" AllowedFileTypes="gif,png,jpg,jpeg"
                        CssClass="BotonLB ui-state-active ui-corner-all AlaIzquierda" ErrorBackColor="Red"
                        Height="18px" OnClientUploadComplete="OnClientAsyncFileUploadComplete" OnUploadedComplete="OnAsyncFileUploadComplete"
                        PersistFile="true" UploaderStyle="Traditional" UploadingBackColor="#d4f897" Width="80%" />                                             
                </td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    <cc1:Editor ID="txtContenido" CssClass="Campos" width="100%" Height="200px" 
                            runat="server" />
                </td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    <asp:Label ID="lblListaCategorias" runat="server" CssClass="Etiquetas" Text="Categorías"></asp:Label>                
                </td>
            </tr>
            <tr>
                <td class="col40_100 AlCentro" rowspan="2">

                    <asp:ListBox ID="listaCat" runat="server" Rows="6" CssClass="Campos" SelectionMode="Multiple" 
                        Width="180px" Height="80px"></asp:ListBox>
                </td>
                <td class="col20_100 AlCentro">
                        <asp:LinkButton CssClass="Etiquetas" ID="AgregarCategoria" runat="server" 
                            onclick="AgregarCategoria_Click"><img alt="Agregar" src="images/bnext.gif" /></asp:LinkButton>
                </td> 
                <td class="col40_100 AlCentro" rowspan="2">
                    <asp:ListBox ID="listaCatFinal" runat="server" Rows="6" Width="180px" CssClass="Campos"
                        Height="80px">
                    </asp:ListBox>
                </td>
            </tr>
            <tr>
                <td class="col20_100 AlCentro">
                        <asp:LinkButton CssClass="Etiquetas" ID="EliminarCategoria" runat="server" 
                            onclick="EliminarCategoria_Click"><img alt="Quitar" src="images/bback.gif" /></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    <asp:Label ID="lblFecha" runat="server" CssClass="Etiquetas" Text="Fecha"></asp:Label>
                    <asp:TextBox ID="txtFecha" runat="server" Height="18px" CssClass="Campos" 
                        Width="187px"></asp:TextBox>
                    <asp:LinkButton ID="btnInsertar" runat="server" CssClass="Etiquetas" 
                        onclick="btnInsertar_Click"><img alt="Actualizar" src="images/brefresh.png" /></asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    <asp:CheckBox ID="Publicado" runat="server" Text="¿Publicar?" CssClass="Etiquetas"  />
                </td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    <asp:Button ID="btnGuardar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                        onclick="btnGuardar_Click" Text="Guardar" />                
                    <asp:Button ID="btnEliminar" runat="server" CssClass="BotonLB ui-state-active ui-corner-all" Height="18px" 
                        onclick="btnEliminar_Click" Text="Eliminar" /> 
                </td>
            </tr>
            <tr>
                <td class="col100_100 AlCentro" colspan="3">
                    <asp:Label ID="lblResultado" CssClass="Resultado" runat="server" />
                </td>
            </tr>
        </table>

        </form>

</body> 
</html>
