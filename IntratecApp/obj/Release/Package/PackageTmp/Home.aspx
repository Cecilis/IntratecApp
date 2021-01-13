<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="IntraTecApp.Home"  MaintainScrollPositionOnPostback="true" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" 
class="no-js" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/">
<head id="Encabezado" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>:: First Central International Bank ::</title>

	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<meta name="description" content="First Central International Bank" />
	<meta name="keywords" content="" />
	<meta name="robots" content="index, follow" />

	<link href="images/favicon.ico" type="image/x-icon" rel="shortcut icon" />
    <link rel="shorcut icon" href="images/favicon.ico" />  

    <link href="styles/PaginaContenido.css" rel="stylesheet" type="text/css" />      
    <link href="styles/TablaContenido.css" rel="stylesheet" type="text/css" />
    <link href="styles/Formularios.css" rel="stylesheet" type="text/css" />    
    
    <link href="styles/Galeria.css" rel="stylesheet" type="text/css" />
    <link href="styles/FeedEk.css" rel="stylesheet" type="text/css" />  
    
    <link href="styles/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />         

    <!--[if lt IE 9]>
        <script type="text/javascript" src="scripts/jquery-1.9.1.js"></script>
    <![endif]-->
    <!--[if gte IE 9]><!-->
        <script src="scripts/jquery-2.0.0.min.js" type="text/javascript"></script>
    <!--<![endif]-->
    
    <script src="scripts/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>

<%--    <script src="scripts/Desabilita_Edicion.js" type="text/javascript"></script>--%>
    <script src="scripts/easySlider1.7.js" type="text/javascript"></script>
    <script src="scripts/FeedEk.js" type="text/javascript"></script>

    <script type="text/javascript">
    $(function () {
        $("#accordion").accordion({
            collapsible: false,
            heightStyle: "content"
        });
    });

    var iniciarEfecto;
    function SetSlider() {
        var galeria = function () {
            $("#ulImages").html('');
            if ($("#controls").length > 0) {
                $("#controls").html('');
            }
            $.ajax({
                url: 'Home.aspx/Galeria',
                dataType: 'json',
                type: "POST",
                contentType: "application/json; charset=utf-8",
                error: function (obj, error) {
//                    alert('Se ha producido un error al traer las imágenes');
                },
                success: CrearGaleria
            });
        }

        galeria();

        iniciarEfecto = function () {
            $("#slider").easySlider({
                auto: true,
                continuous: true,
                numeric: true,
                pause: 2000

            });
        }
    }

    function CrearGaleria(data) {
        var elem;
        var windowGalleryWidth; //alto disponible en ventana del explorador
        var imageWidth;
        var imageHeight;
        var nextBtn = $("#nextBtn");
        var slider1next = $("#slider1next");
        var slider_ul_li_a_img = $("#slider ul li a img");
        var slider_li = $("#slider li");
        var nextBtn = $("#nextBtn");

        windowGalleryWidth = document.documentElement.clientWidth;
        windowGalleryWidth = windowGalleryWidth - (windowGalleryWidth * 0.0439);                
        imageWidth = (windowGalleryWidth) + "px";
        imageHeight = (windowGalleryWidth * 0.50) + "px";
        nextBtn.css("left", imageWidth);
        slider1next.css("left", imageWidth);
        $("#slider").css("width", imageWidth);
        $("#slider").css("height", imageHeight);
        $("#ol#controls li a").css("class", "ui-corner-all");
        $("#slider ul li a img").css("width", imageWidth);
        $("#slider ul li a img").css("height", imageHeight);
        $("#slider li").css("width", imageWidth);
        $("#slider li").css("height", imageHeight);

        $("#ulImages").empty();
        $.each(data.d, function (key, val) {
            elem = "<li><a><img src=" + val.rutaImagen + " width=" + imageWidth + " height=" + imageHeight + " /></a></li>";
            $("#ulImages").append(elem);
        });

        iniciarEfecto();

        $(window).resize(function () {
            var windowGalleryWidth = document.documentElement.clientWidth;
            windowGalleryWidth = windowGalleryWidth - (windowGalleryWidth * 0.0439);
            var imageWidth = (windowGalleryWidth) + "px";
            var imageHeight = (windowGalleryWidth * 0.50) + "px";
            nextBtn.css("left", imageWidth);
            slider1next.css("left", imageWidth);
            $("#slider").css("width", imageWidth);
            $("#slider").css("height", imageHeight);
            $("#slider ul li a img").css("width", imageWidth);
            $("#slider ul li a img").css("height", imageHeight);
            $("#slider li").css("width", imageWidth);
            $("#slider li").css("height", imageHeight);
        });
    }

    $(document).ready(function () {
        SetSlider();
    });

    </script>
    <script src="scripts/modernizr-2.6.2.js" type="text/javascript"></script>
</head>
<body>
    <form id="frmHomeGaleria" runat="server">  
    <asp:ScriptManager ID="smgHome" runat="server" >
    </asp:ScriptManager> 
    <div class="Div10"></div>
    <div id="marcoGaleria" class="ui-corner-all">
        <div id="galeria">
            <div id="slider" class="slider">
              <ul id="ulImages" runat="server"></ul>
            </div>
        </div>
    </div>
    <div class="Div10"></div>
    <div id="accordion">
        <asp:Repeater runat="server" ID="rptListaFeeds">
            <ItemTemplate>
                <h3><a target="_blank" href="#"><span style="text-align:center; vertical-align:middle;"><img alt="" src="images/btnRSS.png" style="width:18px; height:18px;" /></span>&nbsp;&nbsp;<%# DataBinder.Eval(Container.DataItem, "Titulo")%></a></h3>                           
                <div id="feed<%# DataBinder.Eval(Container.DataItem, "IDURLFeed")%>" style="overflow:auto; height:450px;" >
                    <script>
                        $('#feed<%# DataBinder.Eval(Container.DataItem, "IDURLFeed")%>').FeedEk({
                            FeedUrl: '<%# DataBinder.Eval(Container.DataItem, "URLFeed")%>',
                            MaxCount: 5,
                            ShowDesc: true,
                            ShowPubDate: true,
                            DescCharacterLimit: 8000,
                            TitleLinkTarget: '_blank'
                        });                            
                    </script>
                </div> 
            </ItemTemplate>
        </asp:Repeater>      
    </div>
    <asp:Label ID="lblResultado" CssClass="Resultado" runat="server" Width="100%" ></asp:Label>
</form>
</body>
</html>
