using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IntraTecApp;

namespace IntraTecApp
{
    public partial class Noticias : System.Web.UI.Page
    {
        byte[] btsImagen = { };
        String strNombreImagen = String.Empty;
        int LongImagen = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                flsEditar.Visible = true;
                flsBusqueda.Visible = false;
                string strIDNoticias = Request.QueryString["ID"];
                if (string.IsNullOrEmpty(strIDNoticias)) strIDNoticias = "0";
                int intIDNoticias = 0;
                bool bEsNumero = Int32.TryParse(strIDNoticias, out intIDNoticias);

                if ((!string.IsNullOrEmpty(strIDNoticias)) && (bEsNumero))
                {
                    flsEditar.Visible = true;
                    flsBusqueda.Visible = false;
                    cPost item = new cPost(Convert.ToInt32(strIDNoticias));
                    if (item != null)
                    {

                        lblTitulo.Text = item.Titulo;
                        lblPosteadoPor.Text = item.PosteadoPor;
                        lblDescripcion.Text = item.Descripcion;
                        lblContenido.Text = item.Contenido;
                        lblFecha.Text = item.Fecha.ToString();
                        hdnIDNoticiaActual.Value = item.PostID.ToString();

                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = item.ImgFondo;
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = item.NombreImagenFondo;
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = item.ImgFondoLong;

                        previewImage.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
                    }
                    else {
                        lblTitulo.Text = "";
                        lblPosteadoPor.Text = "";
                        lblDescripcion.Text = "";
                        lblContenido.Text = "Aún no se han creado noticias.";
                        lblFecha.Text = "";
                        lblFecha.Text = DateTime.UtcNow.ToString();
                        lblPosteadoPor.Text = Page.User.Identity.Name;
                        CargarFotoPorDefecto();
                    }
                }
                else
                {
                    lblTitulo.Text = "";
                    lblPosteadoPor.Text = "";
                    lblDescripcion.Text = "";
                    lblContenido.Text = "";
                    lblFecha.Text = "";
                    lblFecha.Text = DateTime.UtcNow.ToString();
                    lblPosteadoPor.Text = Page.User.Identity.Name;
                    CargarFotoPorDefecto();
                }
            }
        }

        protected void btnBusqueda_Click(object sender, EventArgs e)
        {
            listaBusqueda.Items.Clear();
            listaBusqueda.DataSource = null;
            listaBusqueda.DataBind();
            listaBusqueda.DataSource = cPost.BuscarPostPorTitulo(txtBusqueda.Text);
            listaBusqueda.DataTextField = "Titulo";
            listaBusqueda.DataValueField = "PostID";
            listaBusqueda.DataBind();
        }

        protected void listaBusqueda_SelectedIndexChanged(object sender, EventArgs e)
        {
            flsEditar.Visible = true;
            flsBusqueda.Visible = false;
            cPost item = new cPost(Convert.ToInt32(listaBusqueda.SelectedItem.Value));
            lblTitulo.Text = item.Titulo;
            lblPosteadoPor.Text = item.PosteadoPor;
            lblDescripcion.Text = item.Descripcion;
            lblContenido.Text = item.Contenido;
            lblFecha.Text = item.Fecha.ToString();

            if (Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] == null)
            {
                CargarFotoPorDefecto();
            }

            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = item.ImgFondo;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = item.NombreImagenFondo;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = item.ImgFondoLong;

            previewImage.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
        }

        protected void BuscarxID(string strIDPost) 
        {
            flsEditar.Visible = true;
            flsBusqueda.Visible = false;
            cPost item = new cPost(Convert.ToInt32(strIDPost));
            lblTitulo.Text = item.Titulo;
            lblPosteadoPor.Text = item.PosteadoPor;
            lblDescripcion.Text = item.Descripcion;
            lblContenido.Text = item.Contenido;
            lblFecha.Text = item.Fecha.ToString();

            if (Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] == null)
            {
                CargarFotoPorDefecto();
            }

            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = item.ImgFondo;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = item.NombreImagenFondo;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = item.ImgFondoLong;

            previewImage.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
        

        }

        protected void btnBuscarEditar_Click(object sender, EventArgs e)
        {
            flsEditar.Visible = false;
            flsBusqueda.Visible = true;
            btnBusqueda_Click(sender, e);
        }


        private void CargarFotoPorDefecto()
        {
            String tmpRutaFoto = "~/images/bg.png";
            String RutaFoto = MapPath(tmpRutaFoto);

            cManejaImagenes oManejaImagenes = new cManejaImagenes();
            oManejaImagenes.Imagen2Bytes(RutaFoto, ref btsImagen, ref LongImagen);
            strNombreImagen = obtenerNombreArchivo((string)hdnIDNoticiaActual.Value, RutaFoto);

            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

            previewImage.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
      
        }

        private String obtenerNombreArchivo(String numID, String strNombreArchivo)
        {
            return (numID).PadLeft(15, '0') + (strNombreArchivo).Substring(strNombreArchivo.Length - 4, 4);
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            flsEditar.Visible = true;
            flsBusqueda.Visible = false;
            udpBuscarArchivo.Update();
        }

    }
}