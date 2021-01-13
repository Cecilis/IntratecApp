using System;
using System.Configuration;
using System.Data;
using System.Threading;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace IntraTecApp
{
    public partial class Index : System.Web.UI.Page
    {
        private static string sBDIntraTec = "BD_IntraTec";
        public static string strLEC = string.Empty;

        public HtmlControl framePrincipal
        {
            get
            {
                return (HtmlControl)this.framePrincipal;
            }
        }

        public void Inicializar(Control oContenedorControl)
        {
            foreach (Control oControl in oContenedorControl.Controls)
            {
                if (oControl.HasControls())
                {
                    Inicializar(oControl);
                }
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {

            String DinamicLanguage = ConfigurationManager.AppSettings["Culture"].ToString();
            Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(DinamicLanguage);

            cPopUp oPopUp = new cPopUp();

            if ((string)Session["Accesos"] == "OK")
            {
                if (lnkLogIn.Visible == true)
                {
                    lnkLogIn.Visible = false;
                    lnkLogOut.Visible = true;
                    cUsuario oUsuario = (cUsuario)Session["OUsuario"];
                    if (oUsuario != null)
                        lblNombreUsuario.InnerText = oUsuario.Usuario;
                }
            }
            else
            {
                if (lnkLogIn.Visible == false)
                {
                    lnkLogIn.Visible = true;
                    lnkLogOut.Visible = false;
                    lblNombreUsuario.InnerText = "";
                }
            }

            if (!IsPostBack) //--> Primera vez
            {
                if ((oPopUp.MensajesActivos()) && (!(hdnMostrarPopUp.Value == "1")))
                {
                    int intTotalChar = (oPopUp.Titulo.Trim().Length + oPopUp.Contenido.Trim()).Length;

                    double dAncho = 0;
                    double dAlto = 0;

                    double x = Math.Round(intTotalChar / 500.0 ); //2.64

                    dAlto = Math.Round(x * 2);
                    dAncho = Math.Round(x * 4);

                    if (dAlto < 300) dAlto = 300;
                    if (dAncho < 500) dAncho = 500;

                    dialog.Style.Add("width", string.Concat(dAncho.ToString(),"px"));
                    dialog.Style.Add("height", string.Concat(dAlto.ToString(), "px"));
                    dialog.Style.Add("background-repeat", "no-repeat");

                    //pnlPopUp.Width = new Unit(dAncho * 0.9, UnitType.Pixel);
                    //pnlPopUp.Height = new Unit(dAlto * 0.9, UnitType.Pixel); 
                   
                    hdnAlto.Value = dAlto.ToString();
                    hdnAncho.Value = dAncho.ToString();

                    //pnlPopUp.Style.Add("height", "auto");
                    tblPopUpContenido.Style.Add("width", string.Concat(dAncho.ToString(),"px"));
                    tblPopUpContenido.Style.Add("height", string.Concat((dAlto * 1.1).ToString(), "px"));

                    hdnMostrarPopUp.Value = "1";

                    lblTitPopUp.Text = oPopUp.Titulo.Trim();
                    lblContenidoPopUp.Text = oPopUp.Contenido.Trim();

                    if ((oPopUp.ImgFondo != null) && (oPopUp.ImgFondo.Length != 0))
                    {
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = oPopUp.ImgFondo;
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = oPopUp.NombreImagenFondo;
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = oPopUp.ImgFondoLong;
                        //previewImage.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
                    }
                    else
                    {
                        CargarFotoPorDefecto(true);
                    }

                    //pnlPopUp.BackImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);

                    dialog.Style.Add("background-image", "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond));
                    dialog.Style.Add("background-repeat", "no-repeat");
                    dialog.Style.Add("width", string.Concat(dAncho.ToString(), "px"));
                    dialog.Style.Add("height", "auto");
                }


                hdnAppOnBase.Value = cConfiguracion.ObtenerAppSettings("AppOnBase");
                hdnAppAssist.Value = cConfiguracion.ObtenerAppSettings("AppAssist");
                hdnAppQlickView.Value = cConfiguracion.ObtenerAppSettings("AppQlickView");
                hdnAppCorreoElectronico.Value = cConfiguracion.ObtenerAppSettings("AppCorreoElectronico");
                hdnAppMasterData.Value = cConfiguracion.ObtenerAppSettings("AppMasterData");

                hdnCuentaGoogle.Value = cConfiguracion.ObtenerAppSettings("CuentaGoogle");
                hdnUsuarioTwitter.Value = cConfiguracion.ObtenerAppSettings("UsuarioTwitter");
                hdnPaginaFB.Value = cConfiguracion.ObtenerAppSettings("PaginaFB");

                hdnRutaDirectorio.Value = cConfiguracion.ObtenerAppSettings("CarpetaDocumentos");
                hdnRutaOrganigrama.Value = cConfiguracion.ObtenerAppSettings("CarpetaDocumentos");


                string strNumRegxFeeds = cConfiguracion.ObtenerAppSettings("NumRegxFeeds");
                if (strNumRegxFeeds.Trim() == "") strNumRegxFeeds = "0";
                int intNumRegxFeeds = Int32.Parse(strNumRegxFeeds);
                hdnNumRegxFeeds.Value = intNumRegxFeeds.ToString();

                ProximosCumpleanios();
                ProximosAniversarios();

            }
        }

        private void CargarFotoPorDefecto(bool bMostrar)
        {
            String tmpRutaFoto = "~/images/bg.png";
            String RutaFoto = MapPath(tmpRutaFoto);

            byte[] btsImagen = { };
            String strNombreImagen = String.Empty;
            int LongImagen = 0;

            cManejaImagenes oManejaImagenes = new cManejaImagenes();
            oManejaImagenes.Imagen2Bytes(RutaFoto, ref btsImagen, ref LongImagen);
            strNombreImagen = obtenerNombreArchivo("PopUpImagen", RutaFoto);

            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;
        }

        private String obtenerNombreArchivo(String numID, String strNombreArchivo)
        {
            return (numID).PadLeft(15, '0') + (strNombreArchivo).Substring(strNombreArchivo.Length - 4, 4);
        }

        public void ProximosCumpleanios()
        {
            cEmpleado oEmpleado = new cEmpleado();
            try
            {
                DataSet oDataSet = oEmpleado.ProximosCumpleanios();
                rptCumpleaniosFechas.DataSource = oDataSet.Tables["FechasCumpleanios"];
                rptCumpleaniosFechas.DataBind();
                oDataSet.Clear();
                oDataSet = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oEmpleado = null;
            }
        }

        public void ProximosAniversarios()
        {
            cEmpleado oEmpleado = new cEmpleado();
            try
            {
                DataSet oDataSet = oEmpleado.ProximosAniversarios();
                rptAniversariosFechas.DataSource = oDataSet.Tables["FechasAniversarios"];
                rptAniversariosFechas.DataBind();
                oDataSet.Clear();
                oDataSet = null;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oEmpleado = null;
            }
        }
    }
}