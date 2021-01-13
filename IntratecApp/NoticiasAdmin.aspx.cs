using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IntraTecApp;

namespace IntraTecApp
{
    public partial class NoticiasAdmin : System.Web.UI.Page
    {
        byte[] btsImagen = { };
        String strNombreImagen = String.Empty;
        int LongImagen = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Accesos"]  == null)
                Response.Redirect("LogOut.aspx");

            if (!Page.IsPostBack)
            {
                flsEditar.Visible = true;
                flsBusqueda.Visible = false;
                flsAdmnCategorias.Visible = true;

                listaCat.Items.Clear();
                listaCat.DataSource = cCategoria.ObtenerTodasCategorias();
                listaCat.DataTextField = "Nombre";
                listaCat.DataValueField = "CategoriaID";
                listaCat.DataBind();

                txtFecha.Text = DateTime.UtcNow.ToString();
                txtPosteadoPor.Text = Page.User.Identity.Name;

                //Categorias
                ddlCategorias.Items.Clear();
                ddlCategorias.DataSource = cCategoria.ObtenerTodasCategorias();
                ddlCategorias.DataTextField = "Nombre";
                ddlCategorias.DataValueField = "CategoriaID";
                ddlCategorias.DataBind();

                lblResultado.CssClass = "Resultado";
                lblResultado.Text = string.Empty;

                lblResultadoCategorias.CssClass = "Resultado";
                lblResultadoCategorias.Text = string.Empty;

                CargarFotoPorDefecto(true);
            }
           
            if (listaBusqueda.SelectedIndex < 0) btnEliminar.Visible = false;
            else btnEliminar.Visible = true;
        }

        protected void OnAsyncFileUploadComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            if (asyncFileUpload.HasFile)
            {
                try
                {
                    previewImage.ImageUrl = null;
                    HttpPostedFile file = asyncFileUpload.PostedFile;

                    btsImagen = ReadFile(file);
                    strNombreImagen = obtenerNombreArchivo((String)hdnIDNoticiasAdmin.Value, (String)file.FileName);
                    LongImagen = file.ContentLength;

                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

                }
                catch (Exception ex)
                {
                    lblResultado.CssClass = "EResultado";
                    lblResultado.Text = "997 - No se pudo adjuntar la imagen. Detalles: " + ex.Message.ToString();
                }
            }
        }

        private void CargarFotoPorDefecto(bool bMostrar)
        {
            String tmpRutaFoto = "~/images/bg.png";
            String RutaFoto = MapPath(tmpRutaFoto);

            cManejaImagenes oManejaImagenes = new cManejaImagenes();
            oManejaImagenes.Imagen2Bytes(RutaFoto, ref btsImagen, ref LongImagen);
            strNombreImagen = obtenerNombreArchivo((String)hdnIDNoticiasAdmin.Value, RutaFoto);

            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

            if (bMostrar)
            {
                previewImage.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
            }
        }

        protected void btnEliminarFoto_Click(object sender, ImageClickEventArgs e)
        {
            CargarFotoPorDefecto(true);
        }

        private String obtenerNombreArchivo(String numID, String strNombreArchivo)
        {
            return (numID).PadLeft(15, '0') + (strNombreArchivo).Substring(strNombreArchivo.Length - 4, 4);
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
            flsAdmnCategorias.Visible = true;
            cPost item = new cPost(Convert.ToInt32(listaBusqueda.SelectedItem.Value));
            edtTitulo.Text = item.Titulo;
            txtPosteadoPor.Text = item.PosteadoPor;
            txtDescripcion.Text = item.Descripcion;
            txtContenido.InitialCleanUp = true;

            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = item.ImgFondo;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = item.NombreImagenFondo;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = item.ImgFondoLong;

            txtContenido.ActiveMode = AjaxControlToolkit.HTMLEditor.ActiveModeType.Design;
            //string strTextoHTMLyy = HttpUtility.HtmlEncode(oNoticiasAdmin.Contenido);
            //strTextoHTML = HttpUtility.HtmlDecode(oNoticiasAdmin.Contenido);
            txtContenido.Content = HttpUtility.HtmlDecode(item.Contenido);

            //txtContenido.Text = item.Contenido;
            txtFecha.Text = item.Fecha.ToString();
            Publicado.Checked = item.Publicado;
            listaCatFinal.Items.Clear();
            listaCatFinal.DataSource = item.ObtenerCategorias();
            listaCatFinal.DataTextField = "Nombre";
            listaCatFinal.DataValueField = "CategoriaID";
            listaCatFinal.DataBind();
        }

        protected void btnBuscarEditar_Click(object sender, EventArgs e)
        {
            flsEditar.Visible = false;
            flsBusqueda.Visible = true;
            panelCategorias.Visible = false;
            flsAdmnCategorias.Visible = false;

            lblResultado.CssClass = "Resultado";
            lblResultado.Text = string.Empty;

            lblResultadoCategorias.CssClass = "Resultado";
            lblResultadoCategorias.Text = string.Empty;

            btnBusqueda_Click(sender, e);

        }

        protected void AgregarCategoria_Click(object sender, EventArgs e)
        {
            if (listaCat.SelectedIndex > -1)
            {
                foreach (int item in listaCat.GetSelectedIndices())
                {
                    listaCatFinal.Items.Add(listaCat.Items[item]);
                    listaCatFinal.ClearSelection();
                    listaCat.ClearSelection();
                }
            }
        }

        protected void EliminarCategoria_Click(object sender, EventArgs e)
        {
            if (listaCatFinal.SelectedIndex > -1)
            {
                listaCatFinal.Items.Remove(listaCatFinal.SelectedItem);
            }
        }

        protected void btnInsertar_Click(object sender, EventArgs e)
        {
            txtFecha.Text = DateTime.UtcNow.ToString();
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                cPost oPost;
                if (listaBusqueda.SelectedIndex < 0) oPost = new cPost();
                else oPost = new cPost(Convert.ToInt32(listaBusqueda.SelectedItem.Value));
                oPost.Titulo = edtTitulo.Text;
                oPost.PosteadoPor = txtPosteadoPor.Text;
                oPost.Descripcion = txtDescripcion.Text;

                if (Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] == null) //No hay datos de la Imagen 
                {
                    CargarFotoPorDefecto(true);
                }

                oPost.ImgFondo = (byte[])Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE];
                oPost.NombreImagenFondo = (string)Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME];
                oPost.ImgFondoLong = (int)Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      

                oPost.Contenido = HttpUtility.HtmlDecode(txtContenido.Content); //txtContenido.Text;
                oPost.Fecha = Convert.ToDateTime(txtFecha.Text);
                oPost.Publicado = Publicado.Checked;

                if ((string.IsNullOrEmpty(oPost.Titulo.Trim())) ||
                    (string.IsNullOrEmpty(oPost.PosteadoPor.Trim())) ||
                    (string.IsNullOrEmpty(oPost.Descripcion.Trim())) ||
                    (string.IsNullOrEmpty(oPost.Contenido.Trim())) ||
                    (string.IsNullOrEmpty(oPost.Fecha.ToString().Trim())))
                {
                    throw new Exception("Los campos marcados con * son obligatorios");
                }

                if (listaBusqueda.SelectedIndex < 0) oPost.Crear();
                else oPost.Actualizar();
                oPost.BorrarCategorias();
                foreach (ListItem catItem in listaCatFinal.Items)
                {
                    oPost.AgregarCategoria(new cCategoria(Convert.ToInt32(catItem.Value)));
                }

                lblResultado.CssClass = "Resultado";
                lblResultado.Text = "Noticia Guardada.";             
            }
            catch (Exception ex)
            {
                lblResultado.CssClass = "EResultado";
                lblResultado.Text = "Error al guardar. Detalles: " + ex.Message.ToString();
            }
    
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                cPost oPost = new cPost(Convert.ToInt32(listaBusqueda.SelectedItem.Value));
                oPost.Eliminar();
                oPost = null;
                lblResultado.CssClass = "Resultado";
                lblResultado.Text = "Noticia Eliminada.";
            }
            catch (Exception ex)
            {
                lblResultado.CssClass = "EResultado";
                lblResultado.Text = "Error al eliminar. Detalles: " + ex.Message.ToString();
            }

        }

        //ultimos agregados

        protected void btnAgregarCategorias_Click(object sender, EventArgs e)
        {
            if (txtNombreCategoria.Text.Trim() != "")
            {
                cCategoria oCategoria = new cCategoria();
                oCategoria.Nombre = txtNombreCategoria.Text.Trim();
                oCategoria.Crear();
                oCategoria = null;
            }

            ddlCategorias.Items.Clear();
            ddlCategorias.DataSource = cCategoria.ObtenerTodasCategorias();
            ddlCategorias.DataTextField = "Nombre";
            ddlCategorias.DataValueField = "CategoriaID";
            ddlCategorias.DataBind();

            //Actuliza la lista de Posteos
            listaCat.Items.Clear();
            listaCat.DataSource = cCategoria.ObtenerTodasCategorias();
            listaCat.DataTextField = "Nombre";
            listaCat.DataValueField = "CategoriaID";
            listaCat.DataBind();

            lblResultadoCategorias.CssClass = "Resultado";
            lblResultadoCategorias.Text = "Categoría Agregada.";

        }


        protected void btnEliminarCategorias_Click(object sender, EventArgs e)
        {
            if (ddlCategorias.SelectedIndex > -1)
            {
                cCategoria oCategoria = new cCategoria(Convert.ToInt32(ddlCategorias.SelectedItem.Value));
                oCategoria.Eliminar();
                oCategoria = null;

            }

            ddlCategorias.Items.Clear();
            ddlCategorias.DataSource = cCategoria.ObtenerTodasCategorias();
            ddlCategorias.DataTextField = "Nombre";
            ddlCategorias.DataValueField = "CategoriaID";
            ddlCategorias.DataBind();

            //Actuliza la lista de Posteos
            listaCat.Items.Clear();
            listaCat.DataSource = cCategoria.ObtenerTodasCategorias();
            listaCat.DataTextField = "Nombre";
            listaCat.DataValueField = "CategoriaID";
            listaCat.DataBind();

            lblResultadoCategorias.CssClass = "Resultado";
            lblResultadoCategorias.Text = "Categoría Eliminada.";

        }

        private byte[] ReadFile(HttpPostedFile file)
        {
            byte[] data = new Byte[file.ContentLength];
            file.InputStream.Read(data, 0, file.ContentLength);
            return data;
        }

        public byte[] FileToByteArray(string _FileName)
        {
            byte[] _Buffer = null;
            try
            {
                // Open file for reading
                System.IO.FileStream _FileStream = new System.IO.FileStream(_FileName, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                // attach filestream to binary pXmlReader
                System.IO.BinaryReader _BinaryReader = new System.IO.BinaryReader(_FileStream);
                // get total byte length of the file
                long _TotalBytes = new System.IO.FileInfo(_FileName).Length;
                // read entire file into buffer
                _Buffer = _BinaryReader.ReadBytes((Int32)_TotalBytes);
                // close file pXmlReader
                _FileStream.Close();
                _FileStream.Dispose();
                _BinaryReader.Close();
            }
            catch (Exception _Exception)
            {
                // Error
                Console.WriteLine("Exception caught in process: {0}", _Exception.ToString());
            }
            return _Buffer;
        }

        protected void btnAgregarPost_Click(object sender, EventArgs e)
        {
            flsEditar.Visible = true;
            flsBusqueda.Visible = false;
            panelCategorias.Visible = true;
            flsAdmnCategorias.Visible = true;
            lblResultado.CssClass = "Resultado";
            lblResultado.Text = string.Empty;
        }
    }
}