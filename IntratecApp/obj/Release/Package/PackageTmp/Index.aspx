<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="IntraTecApp.Index"  MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html class="no-js" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="es-ES">
<head id="Encabezado" runat="server">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>:: First Central International Bank ::</title>
    
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="description" content="First Central International Bank" />
	<meta name="keywords" content="" />
	<meta name="robots" content="index, follow" />

	<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
    <link rel="shorcut icon" href="images/favicon.ico" />  

    <link href="./styles/Index.css" rel="stylesheet" type="text/css" media="screen" />
    <link href="./styles/Formularios.css" rel="stylesheet" type="text/css" />
    <link href="./styles/MenuFCIB.css" rel="stylesheet" type="text/css" />

    <link href="./styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />

    <script src="scripts/html5shiv.js" type="text/javascript"></script>

    <!--[if lt IE 9]>
        <script type="text/javascript" src="scripts/jquery-1.9.1.js"></script>
    <![endif]-->
    <!--[if gte IE 9]><!-->
        <script src="scripts/jquery-2.0.0.min.js" type="text/javascript"></script>
    <!--<![endif]-->

    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>    
    <script src="scripts/jquery.blockUI.js" type="text/javascript"></script>  
    <script src="scripts/Desabilita_Edicion.js" type="text/javascript"></script>
   
    <style type="text/css">

/* Z-index of #mask must lower than #boxes .window */

#mask {
  position:relative;
  z-index:9800;
  background-color:#000;
  display:none;
  margin:-6%;
  padding:0px;
  height:100%;  
}

#boxes
{
    margin:0px;
    padding:0px;    
}
  
#boxes .window {
  position:fixed;
  display:none;
  z-index:9999;
  padding:20px; 
}

/* Customize your modal window here, you can add background image too */
#boxes #dialog {
  background:#FFFFFF;   
  }

.stop-scrolling {
  height: 100%;
  overflow: hidden;
}

</style>

</head>
<body id="Body">
<script type="text/javascript"> 
        var selTab;
        $(function () {
            var tabs = $("#tabPanel").tabs({
                show: function () {
                    selTab = $('#tabPanel').tabs('option', 'selected');
                }
            });
        });
        $("#tabPanel > ul > li").each(function (i) {
            if (i < 2) {
                $(this).removeClass("ui-state-disabled");
            }
        });
        function pageLoad(sender, args) {
            if (args.get_isPartialLoad()) {
                $("#tabPanel").tabs({ show: function () {
                    selTab = $('#tabPanel').tabs('option', 'selected');
                }, selected: selTab
                });
            }
        };
        function txtNroTrabajadores_onclick() {
            $('#txtNroTrabajadoresSolicitados').val() = $('#txtNroTrabajadores').val()
        }
        $(function () {
            $("#datepicker").datepicker();
        });
        $(document).ready(function () {
            initIframe();
        });
        function initIframe() {
            var nMaxFeeds = $('#<%= hdnNumRegxFeeds.ClientID%>').val();
            var altoFeeds = (nMaxFeeds * 20) + 500;
            var alto = $(window).width() * 0.5;
            var alto = alto + altoFeeds;
            $("iframe").height(alto);
        }
</script>

<form id="frmIndex" runat="server">
<asp:HiddenField ID="hdnNumRegxFeeds" runat="server" />  
<asp:HiddenField ID="hdnAncho" runat="server" />
<asp:HiddenField ID="hdnAlto" runat="server" />
<asp:HiddenField ID="hdnCuentaGoogle" runat="server" />
<asp:HiddenField ID="hdnUsuarioTwitter" runat="server" />
<asp:HiddenField ID="hdnPaginaFB" runat="server" />
<asp:HiddenField ID="hdnRutaOrganigrama" runat="server" />
<asp:HiddenField ID="hdnAppOnBase" runat="server" />
<asp:HiddenField ID="hdnAppAssist" runat="server" />
<asp:HiddenField ID="hdnAppQlickView" runat="server" />
<asp:HiddenField ID="hdnAppCorreoElectronico" runat="server" />
<asp:HiddenField ID="hdnAppMasterData" runat="server" />
<asp:HiddenField ID="hdnRutaDirectorio" runat="server" />
<div id="header">
	<h1 ><a href="http://grupointecsoluciones.com"><img alt="Intratec"  src="images/IntraTecLogoMR.jpg" /></a></h1>
    <div class="loginDisplay">
        <table style="width:100%;">
            <tr>
                <td align="center" >
                    <span style="vertical-align:middle;">
                        <label id="lblNombreUsuario" runat="server" class="EtiquetaLBFT" style="width:250px; text-align:center;"></label>
                    </span>  
                </td>
                <td align="right">
                    <div class="ui-button ui-button-text-only ui-widget ui-state-active" style="width:150px;">
                       <span class="ui-button-text">
                            <a target="ifmPrincipal" id="lnkLogIn" runat="server" href="Login.aspx" style="cursor:pointer; font-size:11px; color:#FFFFFF; width:50px;">INICIAR SESIÓN</a>
                            <a target="ifmPrincipal" id="lnkLogOut" runat="server" href="LogOut.aspx" visible="false" style="cursor:pointer; font-size:11px; color:#FFFFFF; width:500px;">CERRAR SESIÓN</a>            
                       </span>
                    </div>
                </td>
            </tr>
        </table>
    </div>
	<h3><a href="#" class="fltlft"><img alt="Intratec"  src="images/log.png" style="width:100%; height:auto;" /></a></h3>
	<div id="layoutdims">
        <applet codebase="http://www.panabolsa.com/sys/classes/led" code="LED.class" 
                    width="100%" 
                    height="24"                                                            
                    align="center">
            <param name="script" value="http://www.panabolsa.com/sys/classes/led/test.led" />
            <param name="border" value="1" />
            <param name="bordercolor" value="0,0,0" />
            <param name="spacewidth" value="3" />
            <param name="wth" value="652" />
            <param name="ledsize" value="1" />
            <param name="font" value="http://www.panabolsa.com/sys/classes/led/default.font" />
        </applet>    
    </div>
</div>
<div class="colmask threecol">    
    <asp:ScriptManager ID="smgIndex" runat="server" EnableScriptGlobalization="true" EnableScriptLocalization="true">
    </asp:ScriptManager>
	<div class="colmid">
		<div class="colleft">
			<!-- Column 1 Inicio -->
            <div class="col1">			
                <iframe runat="server" name="ifmPrincipal" id="ifmPrincipal" src="Home.aspx" width="100%" height="100%" frameborder="0"></iframe>
			</div>
            <!-- Columna 1 Fin -->
            <!-- Columna 2 Inicio --> 
			<div class="col2">                    
                <asp:HiddenField ID="hdnOpcionMenu" runat="server" EnableViewState="false"  />
                <asp:HiddenField ID="hdnMostrarPopUp" Value="0" runat="server" EnableViewState="false"  />	
                <nav>
                    <div class="menu-item">
                        <h4><a id="OM0000" target="ifmPrincipal" runat="server" href="Home.aspx"><span><img alt="" src="Images/LogoFCIB.jpg" />&nbsp; INICIO</span></a></h4>
                    </div>
                    <div class="menu-item alpha">
                        <h4><a href="#"><span><img alt="" src="Images/LogoFCIB.jpg" />&nbsp; APLICACIONES</span></a></h4>
                        <ul id="aplicaciones">
                            <li><a id="OA1" target="_blank" href="<%=hdnAppOnBase.Value%>"><span><img alt="" src="Images/OnBaseProducts.png" />&nbsp; OnBase</span></a></li>
                            <li><a id="OA2" target="_blank" href="<%=hdnAppAssist.Value%>"><span><img alt="" src="Images/Experian01.png" />&nbsp; ASSIST//ck®</span></a></li>
                            <li><a id="OA3" target="_blank" href="<%=hdnAppQlickView.Value%>"><span><img alt="" src="Images/Qlikview.png" />&nbsp; Qlick View</span></a></li>
                            <li><a id="OA4" target="_blank" href="<%=hdnAppCorreoElectronico.Value%>"><span><img alt="" src="Images/AtSymbol.png" />&nbsp; Correo</span></a></li>
                            <li><a id="OA5" target="_blank" href="<%=hdnAppMasterData.Value%>"><span><img alt="" src="Images/MasterData01.png" />&nbsp; Master Data</span></a></li>
                            <li><a id="OA6" target="ifmPrincipal" runat="server" href="Noticias.aspx"><span><img alt="" src="Images/newsletter.png" />&nbsp; Noticias</span></a></li>
                        </ul>
                    </div>
                    <div class="menu-item">
                        <h4><a href="#"><span><img alt="" src="Images/LogoFCIB.jpg" />&nbsp; FAMILIA FIRST</span></a></h4>
                        <ul id="personal">
                            <li><a id="OB1" target="ifmPrincipal" href="VisorPDF.aspx?path=<%=hdnRutaOrganigrama.Value%>&filename=Organigrama.pdf"><span><img alt="" src="Images/organigrama.png" />&nbsp; Organigrama</span></a></li>
                            <li><a id="OB2" target="ifmPrincipal" href="Personal.aspx"><span><img alt="" src="Images/Empleados.png" />&nbsp; Empleados</span></a></li>
                            <li><a id="OB3" target="ifmPrincipal" href="VisorPDF.aspx?path=<%=hdnRutaOrganigrama.Value%>&filename=Directorio.pdf"><span><img alt="" src="Images/phone.png" />&nbsp; Directorio</span></a></li>
                        </ul>
                    </div>       
                    <div class="menu-item">
                        <h4><a href="#"><span><img alt="" src="Images/LogoFCIB.jpg" />&nbsp; DOCUMENTOS</span></a></h4>
                        <ul id="documentos">
                            <li><a id="OC1" target="ifmPrincipal" href="Documentos.aspx?td=M"><span><img alt="" src="Images/Manuales.png" />&nbsp; Manuales</span></a></li>
                            <li><a id="OC2" target="ifmPrincipal" href="Documentos.aspx?td=N"><span><img alt="" src="Images/normativas.png" />&nbsp; Normativas</span></a></li>
                            <li><a id="OC3" target="ifmPrincipal" href="Documentos.aspx?td=P"><span><img alt="" src="Images/Procedimientos.png" />&nbsp; Procedimientos</span></a></li>
                        </ul>
                    </div>
                    <div class="menu-item">
                        <h4><a id="OD1" target="ifmPrincipal" href="Reportes.aspx?td=R"><span><img alt="" src="Images/LogoFCIB.jpg" />&nbsp; REPORTES</span></a></h4>
                    </div>
                    <%if (Session["Accesos"] == "OK")
                    { 
                    %>      
                    <div class="menu-item">
                        <h4><a href="#"><span><img alt="" src="Images/LogoFCIB.jpg" />&nbsp; CONFIGURACIÓN</span></a></h4>
                        <ul id="configuracion">
                            <li><a id="OE5" target="ifmPrincipal" href="CambioClave.aspx"><span><img alt="" src="Images/cambioClave.png" />&nbsp; Cambio de Clave</span></a></li>
                            <li><a id="OE1" target="ifmPrincipal" href="PopUpAdmin.aspx"><span><img alt="" src="Images/PopUp.png" />&nbsp; Pop Up</span></a></li>
                            <li><a id="OE2" target="ifmPrincipal" href="EmpleadosAdmin.aspx"><span><img alt="" src="Images/EmployeeFolder.png" />&nbsp; Empleados</span></a></li>
                            <li><a id="OE3" target="ifmPrincipal" href="NoticiasAdmin.aspx"><span><img alt="" src="Images/AddNews.png" />&nbsp; Noticias</span></a></li>
                            <li><a id="OE4" target="ifmPrincipal" href="FeedAdmin.aspx"><span><img alt="" src="Images/Website-RSS-25.png" />&nbsp; Canales RSS / Atom </span></a></li>
                            <li><a id="OE6" target="ifmPrincipal" href="UsuariosAdmin.aspx"><span><img alt="" src="Images/usuariosAdmin.png" />&nbsp; Usuarios</span></a></li>
                            <li><a id="OE7" target="ifmPrincipal" href="UbicacionesAdmin.aspx"><span><img alt="" src="Images/UbicacionesAdmin.png" />&nbsp; Parámetros</span></a></li>
                            <li><a id="OE8" target="ifmPrincipal" href="ArchivosAdmin.aspx"><span><img alt="" src="Images/ArchivosAdmin.png" />&nbsp; Archivos</span></a></li>
                        </ul>
                    </div>
                    <%
                    } 
                    %>   
                </nav>
                <div class="Div30"></div>	
                <div class="fb-like-box ui-corner-all" data-href="<%=hdnPaginaFB.Value%>" data-width="190" data-show-faces="true" data-colorscheme="light" data-stream="false" data-header="false" style="background:#ecf8fb;border:3px solid #568456"></div>
                <div class="Div30"></div>
<%--                <div id="GoogleFeeds">
                    <iframe id="iframeGoogle" 
                        frameborder="0" 
                        style="border:0; 
                        background:#568456;">
                    </iframe>                  
			    </div>--%>
            </div>
            <!-- Columna 2 - Fin    -->
            <!-- Columna 3 - Inicio -->
			<div class="col3">			
                <div id="FCIB_WebPage">
                    <h1 class="FCIB_WebPage_Link"><a href="http://www.firstcentralib.com" target="_blank">FirstNet</a></h1>
                </div>
                <div class="Div30"></div>
                <div class="Eventos" > 
                    <asp:HiddenField ID="hdnTabSeleccionado" runat="server" />
                    <asp:Panel ID="tabPanel" runat="server">
                        <ul>
                            <li><a title="Aniversario" href="#Panel1"><img alt="Aniversario" src="images/btnCondecoracion.png" /></a></li>                     
                            <li><a title="Cumpleaños" href="#Panel2"><img alt="Cumpleaños" src="images/btnTarjeta.png" /></a></li>
                        </ul>
                        <asp:Panel ID="Panel1" runat="server">
                            <fieldset id="flsAniversarios" runat="server"  style="border:none; text-align:center; height:250px; padding-top:0px; left:10px;">
                                <legend></legend>
                                <div class="Div30 TitulosGridMin">
                                    <label style="font-size:11"><b>PRÓXIMOS<br />ANIVERSARIOS</b></label>
                                </div>                                 
                                <marquee direction="up" behavior="scroll" scrolldelay="230" height:"100px" width:"100%" style="text-align:left; margin-top:5px;">                                    
                                    <asp:Repeater ID="rptAniversariosFechas" runat="server">
                                        <ItemTemplate>
                                            <div class="Div10"></div>
                                            <label class="CamposSinFondo" style="margin-left:5px;"><b><%# DataBinder.Eval(Container.DataItem, "DiaMesAniversario")%></b></label>
                                            <ul style="text-decoration:none; list-style:none; text-align:center;">
                                                <asp:Repeater id="rptAniversariosItems" datasource='<%# ((DataRowView)Container.DataItem).Row.GetChildRows("relFechaProximosAniversarios") %>' runat="server">
                                                    <ItemTemplate>
                                                    <li>
                                                        <div style="width:90%; margin-left:10px; text-align:center; vertical-align:middle; background:#055545; padding:5px;">
                                                            <table  border="0" class="CamposGrid" style="width:90%; background:#ecf8fb;">                                                                 <tr>
                                                                <td rowspan="2" style="text-align:center; vertical-align:top;">
                                                                    <img src='<%# "ImagenCargador.ashx?IDEmpleado=" + DataBinder.Eval(Container.DataItem, "[\"IDEmpleado\"]")%>'  alt="Nuestra Gente" Height="35px" Width="28px"/>
                                                                </td>
                                                                <td style="text-align:center; vertical-align:top;" ><b>
                                                                    <%# ((string)(DataBinder.Eval(Container.DataItem, "[\"Nombre\"]"))).ToUpperInvariant() + " " + ((string)(DataBinder.Eval(Container.DataItem, "[\"Apellido\"]"))).ToUpperInvariant()%></b>                                        
                                                                </td>
                                                                </tr>
                                                                <tr>
                                                                <td colspan="2" style="text-align:center; vertical-align:top;" >
                                                                    <%# ((string)(DataBinder.Eval(Container.DataItem, "[\"DescCargo\"]"))).ToLowerInvariant()%>  
                                                                </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <br />
                                                    </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ul>  
                                            <div class="Div10"></div>                                  
                                        </ItemTemplate>                                       
                                    </asp:Repeater>                               
                                </marquee>                              
                            </fieldset>                      
                        </asp:Panel>                        
                        <asp:Panel ID="Panel2" runat="server">
                            <fieldset id="flsCumpleanios" runat="server"  style="border:none; text-align:center; height:250px; padding-top:0px;">
                                <legend></legend>
                                <div class="Div30 TitulosGridMin">
                                    <label style="font-size:11"><b>PRÓXIMOS<br />CUMPLEAÑOS</b></label>                             
                                </div>
                                <marquee direction="up" behavior="scroll" scrolldelay="230" height:"200px" width:"100%" style="text-align:left; margin-top:5px;">                                    
                                    <asp:Repeater ID="rptCumpleaniosFechas" runat="server">                                  
                                        <ItemTemplate>
                                            <div class="Div10"></div>
                                            <label class="CamposSinFondo" style="margin-left:5px;"><b><%# DataBinder.Eval(Container.DataItem, "DiaMesCumpleanios")%></b></label>
                                            <ul style="text-decoration:none; list-style:none; margin:0px;">
                                                <asp:Repeater id="rptCumpleaniosItems" datasource='<%# ((DataRowView)Container.DataItem).Row.GetChildRows("relFechaProximosCumpleanios") %>' runat="server">
                                                    <ItemTemplate>
                                                    <li>

                                                    </li>
                                                    </ItemTemplate>
                                                </asp:Repeater>
                                            </ul> 
                                            <div class="Div10"></div>                          
                                        </ItemTemplate>
                                    </asp:Repeater>                           
                                </marquee>
                            </fieldset>
                    </asp:Panel>
                    </asp:Panel>
                </div>
                <div class="Div30"></div>
                <div id="Twitter" class="ui-corner-all">
                    <a class="twitter-timeline" 
                        href="https://twitter.com/FirstCIB" 
                        data-widget-id="347528376690544640"                        
                        data-theme="light" 
                        data-link-color="#006f58"  
                        data-aria-polite="assertive"
                        data-chrome="nofooter noheader noborders"
                        width="190" 
                        border-color="#568456"
                        lang="ES" style="backcolor:#568456; color:#FFFFFF;" >Tweets por @FirstCIB</a>
        	    </div>             
			</div> 
            <!-- Columna 3 - Fin  -->
		</div>
    </div>
</div>
<div id="footer">
	<p><a href="http://grupointecsoluciones.com"><img alt="GIS"  src="images/Logo_GIS_FB.png" style="background:#FFFFFF;" /></a></p>
</div> 

<div id="boxes">  
    <div style="display:none; background-repeat: no-repeat; background-position:center; padding:15px; border:1px solid #CCC;"  id="dialog" class="window" runat="server" >
        <div style="top:-10px; left:-10px; text-align:left; display:block; position:absolute;">
            <a href="#" class="close fltrt" style="text-decoration:none; text-align:right; vertical-align:top;">
                <img alt="PopUp" src="images/btnCerrar.png" class="fltrt" />
            </a>
        </div>  
        <table runat="server" ID="tblPopUpContenido" style="background:#FFFFFF; opacity:0.4; width:100%; height:100%; margin-top:0px;">
            <tr>
                <td style="width:100%; text-align:center;">
                    <div style="background:#FFFFFF;">                    
                        <asp:Literal ID="lblTitPopUp" runat="server" ></asp:Literal>
                    </div>
                </td>
            </tr>
            <tr>
                <td style="width:100%; text-align:center;">
                    <div style="background:#FFFFFF;">   
                        <asp:Literal ID="lblContenidoPopUp" runat="server" ></asp:Literal> 
                    </div>
                </td>
            </tr>                                
        </table>        
    </div>
    <!-- Capa que cubre toda la ventana - Pop Up -->
    <div style="width:100%; height:100%; display:none; opacity:0.8;" id="mask">
    </div>    
</div>

 <script type="text/javascript" charset="utf-8">

     $('#Body').ready(function () {
         var isPostBackOccured = document.getElementById('hdnMostrarPopUp');
         if (isPostBackOccured.value == '1') {
             var id = '#dialog';
             $('body').addClass('stop-scrolling');

             isPostBackOccured.value = '0';
             var maskHeight = $(document).height()*2;
             var maskWidth = $(window).width() * 1.1;

             $('#mask').css({ 'width': maskWidth, 'height': maskHeight });

             $('#mask').fadeIn(1000);
             $('#mask').fadeTo("slow", 0.8);

             var winH = $(window).height();
             var winW = $(window).width();

             $(id).css('top', winH / 2 - $(id).height() / 2);
             $(id).css('left', winW / 2 - $(id).width() / 2);

             $(id).fadeIn(2000);

             $('.window .close').click(function (e) {
                 e.preventDefault();
                 $('#mask').hide();
                 $('.window').hide();
                 $('body').removeClass('stop-scrolling')
             });

//            $('#mask').click(function () {
//                $(this).hide();
//                $('.window').hide();
//                $('body').removeClass('stop-scrolling')
//            });
         }
     });

     $(window).ready(function () {
         // <![CDATA[
         (function (d, s, id) {
             var js, fjs = d.getElementsByTagName(s)[0];
             if (d.getElementById(id)) return;
             js = d.createElement(s); js.id = id;
             js.async = true;
             js.src = "//connect.facebook.net/es_LA/all.js#xfbml=1";
             fjs.parentNode.insertBefore(js, fjs);
         } (document, 'script', 'facebook-jssdk'));
         // ]]>
     });

     $(window).ready(function () {
         // <![CDATA[
        !function (d, s, id) {
            var js, fjs = d.getElementsByTagName(s)[0], p = /^http:/.test(d.location) ? 'http' : 'https';
            if (!d.getElementById(id)) {
                    js = d.createElement(s);
                    js.id = id;
                    js.async = true;
                    js.src = p + "://platform.twitter.com/widgets.js";
                    fjs.parentNode.insertBefore(js, fjs);
                }
            }
        (document, "script", "twitter-wjs");
        // ]]>
     });

     $(window).ready(function () {
         var CuentaGoogle = $('#hdnCuentaGoogle').val();
         if ($('#iframeGoogle').length <= 0) { return; }
         $('#iframeGoogle').attr('src', 'http://stream.pluswidget.com/google-plus-widget/iframe/' + CuentaGoogle + '/?width=210&height=350&shell_bg=006f58&shell_text=445c52&shell_links=FFFFFF&post_bg=ecf8fb&post_text=445c52&post_links=4D90FE&scroll_bg=ecf8fb&scroll_handle_text=aaa');
         
     });
    </script>  
</form>
</body>
</html>
