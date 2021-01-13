using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;
using IntraTecApp;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Text.RegularExpressions;

namespace IntraTecApp
{
    public partial class PopUpAdmin : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["BD_IntraTec"].ToString());

        byte[] btsImagen = { };
        String strNombreImagen = String.Empty;
        int LongImagen = 0;

        cPopUp oPopUp = new cPopUp();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Accesos"]  == null)
                Response.Redirect("LogOut.aspx");

            if (!Page.IsPostBack)
            {               
                String DinamicLanguage = ConfigurationManager.AppSettings["Culture"].ToString();
                Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(DinamicLanguage);

                hdnIDPopUpActual.Value = "0";

                DataSet oDataSet = new DataSet();
                DataView oDataView = new DataView();
                ViewState["sortexp"] = "";
                ViewState["orderby"] = "ASC";
                
                oDataView = gdvPopUp_Bind();
                gdvPopUp.DataSource = oDataView;
                gdvPopUp.DataBind();

                InicializarHora();

                CargarFotoPorDefecto(true);
            }
            
        }

        private DataView gdvPopUp_Bind()
        {
            DataSet oDataSet = new DataSet();
            DataView oDataView;        

            oDataSet = oPopUp.BuscarMensajes();
            
            if (ViewState["sortexp"] != null)
            {
                oDataView = new DataView(oDataSet.Tables[0]);
                oDataView.Sort = (string)ViewState["sortexp"];
            }
            else
                oDataView = oDataSet.Tables[0].DefaultView;

            foreach (DataRowView oDataRowView in oDataView)
            {
                DataRow oDataRowViewAux = oDataRowView.Row;

                string strTituloAux = oDataRowViewAux["Titulo"].ToString();
                strTituloAux = HttpUtility.HtmlDecode(strTituloAux);
                strTituloAux = cFunciones.QuitarHTML(strTituloAux);
                oDataRowViewAux["Titulo"] = strTituloAux;
            }
            return oDataView;
         }

        protected void gdvPopUp_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gdvPopUp.PageIndex = e.NewPageIndex;
            gdvPopUp.DataSource = gdvPopUp_Bind();
            gdvPopUp.DataBind();
        }

        protected void gdvPopUp_Sorting(object sender, GridViewSortEventArgs e)
        {
            ViewState["sortexp"] = e.SortExpression;
            gdvPopUp.DataSource = gdvPopUp_Bind();
            gdvPopUp.DataBind();
        }

        public void EditarPopUpInfo(string strIdPopUp) {
            try
            {
                if (oPopUp.ExisteMensaje(strIdPopUp))
                {

                    hdnIDPopUpActual.Value = strIdPopUp;
                    oPopUp.IDPopUp = Convert.ToInt32(strIdPopUp);
                    edtTitulo.InitialCleanUp = true;
                    edtTitulo.ActiveMode = AjaxControlToolkit.HTMLEditor.ActiveModeType.Design;
                
                    string strTitulo = System.Web.HttpUtility.HtmlDecode(oPopUp.Titulo);
                    edtTitulo.Content = strTitulo; 

                    if ((oPopUp.ImgFondo != null) && (oPopUp.ImgFondo.Length != 0))
                    {
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = oPopUp.ImgFondo;
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = oPopUp.NombreImagenFondo;
                        Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = oPopUp.ImgFondoLong;
                    }
                    else
                    {
                        CargarFotoPorDefecto(true);
                    }
                    

                    edtContenido.InitialCleanUp = true;
                    edtContenido.ActiveMode = AjaxControlToolkit.HTMLEditor.ActiveModeType.Design;

                    string strContenido = System.Web.HttpUtility.HtmlDecode(oPopUp.Contenido);
                    edtContenido.Content = strContenido; 

                    txtDesde.Text = String.Format("{0:dd/MM/yyyy}", oPopUp.FechaDesde);
                    ddlHoraDesde.SelectedValue = (((oPopUp.FechaDesde.Hour + 11) % 12) + 1).ToString().PadLeft(2, '0');
                    ddlMinDesde.SelectedValue = (oPopUp.FechaDesde.Minute % 60).ToString().PadLeft(2, '0');
                    ddlAMPMDesde.SelectedValue = oPopUp.FechaDesde.ToString("tt").Replace(".", "").ToUpper();

                    txtHasta.Text = String.Format("{0:dd/MM/yyyy}", oPopUp.FechaHasta);
                    ddlHoraHasta.SelectedValue = (((oPopUp.FechaHasta.Hour + 11) % 12) + 1).ToString().PadLeft(2, '0');
                    ddlMinHasta.SelectedValue = oPopUp.FechaHasta.Minute.ToString().PadLeft(2, '0');
                    ddlAMPMHasta.SelectedValue = oPopUp.FechaHasta.ToString("tt").Replace(".", "").ToUpper();
                    Session["oPopUp"] = oPopUp;
                    rblStatus.SelectedValue = oPopUp.Status;                    
                }
                else
                { //No existe el mensaje Pop UP
                    Session["oPopUp"] = null;
                    lblResultados.CssClass = "EResultado";
                    lblResultados.Text = "Error al buscar Pop Up.";
                }
            }

           catch (Exception ex) {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = "Error: Al cargar datos: " + ex.Message.ToString();
            }
        }

        public void EliminarPopUpInfo(string strIdPopUp)
        {
            lblResultadoBusqueda.CssClass = "Resultado";
            lblResultados.CssClass = "Resultado";
            lblResultadoBusqueda.Text = string.Empty;
            lblResultados.Text = string.Empty;

            try
            {
                if (oPopUp.ExisteMensaje(strIdPopUp))
                {
                    string strResultados = string.Empty;
                    oPopUp.ActualizarMensajePopUp("E", ref strResultados);

                    if (strResultados == "OK")
                    {
                        btnActivarBusquedaPopUp_Click(null, e:null);
                        Session["oPopUp"] = null;            
                        lblResultados.CssClass = "Resultado";
                        lblResultados.Text = "Actualización Exitosa.";
                    }
                    else
                    {
                        lblResultados.CssClass = "EResultado";
                        lblResultados.Text = "Error al Actualizar.";
                    }           
                }
                else
                { 
                    Session["oPopUp"] = null;
                }
            }

           catch (Exception ex) {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = "Error: Al cargar datos: " + ex.Message.ToString();
            }
        }

        protected void gdvPopUp_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                lblResultados.Text = "";
                lblResultadoBusqueda.Text = "";

                LinkButton oLinkButton = e.Row.FindControl("lnkEditar") as LinkButton;
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    smgPopUpAdmin.RegisterPostBackControl(oLinkButton);
                }

                oLinkButton = e.Row.FindControl("lnkEliminar") as LinkButton;
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    smgPopUpAdmin.RegisterPostBackControl(oLinkButton);
                }
            }
            catch (Exception ex)
            {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = "Error: Al actualizar datos: " + ex.Message.ToString();
            }
        }

        protected void gdvPopUp_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            try
            {
                lblResultados.CssClass = "Resultado";
                lblResultadoBusqueda.CssClass = "Resultado";
                lblResultados.Text = "";
                lblResultadoBusqueda.Text = "";

                LinkButton oLinkButton = (LinkButton)e.CommandSource;    // the button
                GridViewRow oGridViewRow = (GridViewRow)oLinkButton.Parent.Parent;  // the row
                GridView oGridView = (GridView)sender; // the gridview
                string strIDPopUp = oGridView.DataKeys[oGridViewRow.RowIndex].Value.ToString(); // value of the datakey 
                
                if (e.CommandName == "Editar")
                {                    
                    EditarPopUpInfo(strIDPopUp);
                    flsBuscar.Visible = false;
                    flsEditar.Visible = true;
                    udpBuscarPopUp.Update();
                }
                else if (e.CommandName == "Eliminar")
                {
                    EliminarPopUpInfo(strIDPopUp);
                    flsBuscar.Visible = true;
                    flsEditar.Visible = false; 
                    udpBuscarPopUp.Update();
                }
                else
                {
                    flsBuscar.Visible = true;
                    flsEditar.Visible = false;
                    throw new Exception("Comando no válido");
                }
                
            }
            catch (Exception ex)
            {
                lblResultadoBusqueda.CssClass = "EResultado";
                lblResultadoBusqueda.Text = "Error: Al actualizar datos: " + ex.Message.ToString();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            string strResultados = string.Empty;
            string strAccion = string.Empty;

            lblResultados.CssClass = "Resultado";
            lblResultadoBusqueda.CssClass = "Resultado";
            lblResultados.Text = "";
            lblResultadoBusqueda.Text = "";

            oPopUp = (cPopUp)Session["oPopUp"];

            if (oPopUp == null)
            {
                oPopUp = new cPopUp();
                Session["oPopUp"] = oPopUp;
            }

            oPopUp.IDPopUp = Convert.ToInt32(hdnIDPopUpActual.Value);

            if (oPopUp.IDPopUp == 0)
            {
                strAccion = "I";
            }
            else {
                strAccion = "M";
            }
            try
            {
                //Validaciones de fechas

                string strFechaDesde = txtDesde.Text;
                string strHoraDesde = ddlHoraDesde.SelectedValue;
                string strMinDesde = ddlMinDesde.SelectedValue;
                string strAMPMDesde = ddlAMPMDesde.SelectedValue;
  
                string strFechaHoraDesde = strFechaDesde.Replace("/","-") + " " + strHoraDesde + ":" + strMinDesde + strAMPMDesde;
                DateTime dtFechaHoraDesde = Convert.ToDateTime(strFechaHoraDesde);

                string strFechaHasta = txtHasta.Text;
                string strHoraHasta = ddlHoraHasta.SelectedValue;
                string strMinHasta = ddlMinHasta.SelectedValue;
                string strAMPMHasta = ddlAMPMHasta.SelectedValue;

                string strFechaHoraHasta = strFechaHasta.Replace("/", "-") + " " + strHoraHasta + ":" + strMinHasta + strAMPMHasta;
                DateTime dtFechaHoraHasta = Convert.ToDateTime(strFechaHoraHasta); 

                DateTime dtFechaDesde = Convert.ToDateTime(txtDesde.Text);
                DateTime dtFechaHasta = Convert.ToDateTime(txtHasta.Text);
                DateTime dtFechaActual = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy"));
                DateTime dtHoraDesde = Convert.ToDateTime(txtHasta.Text);

                if (dtFechaHoraHasta == dtFechaHoraDesde)
                {
                    throw new Exception("Fechas desde y hasta no pueden ser iguales");
                }

                if (dtFechaHoraHasta < dtFechaHoraDesde) {
                    throw new Exception("Fecha desde inferior a fecha hasta.");
                }

                if ((dtFechaHoraDesde < dtFechaActual) && (strAccion == "I")) {
                    throw new Exception("Fecha desde no puede ser inferior a la fecha actual.");
                }

                if (dtFechaHoraHasta < dtFechaActual)
                {
                    throw new Exception("Fecha hasta no puede ser inferior a la fecha actual.");
                }

                if (Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] == null) //No hay datos de la Imagen 
                {
                    CargarFotoPorDefecto(false);
                }

                oPopUp.Titulo = HttpUtility.HtmlDecode(edtTitulo.Content);
                oPopUp.Contenido = HttpUtility.HtmlDecode(edtContenido.Content);

                oPopUp.FechaDesde = dtFechaHoraDesde;
                oPopUp.FechaHasta = dtFechaHoraHasta;

                oPopUp.ImgFondo = (byte[])Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE];
                oPopUp.NombreImagenFondo = (string)Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME];
                oPopUp.ImgFondoLong = (int)Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH];

                oPopUp.Status = rblStatus.SelectedValue;

                oPopUp.ActualizarMensajePopUp(strAccion, ref strResultados);

                if (strResultados == "OK")
                {
                    Session["oPopUp"] = null;
                    btnActivarBusquedaPopUp_Click(sender, e);
                    lblResultados.CssClass = "Resultado";
                    lblResultados.Text = "Actualización Exitosa.";
                }

                udpBuscarPopUp.Update();
                udpBuscarPopUp.Update();
            }
            catch (Exception ex) {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = "Error: Al actualizar datos: " + ex.Message.ToString();
            }
  
        }

        protected void btnActivarBusquedaPopUp_Click(object sender, EventArgs e)
        {
            lblResultados.CssClass = "Resultado";
            lblResultadoBusqueda.CssClass = "Resultado";
            lblResultados.Text = "";
            lblResultadoBusqueda.Text = "";

            hdnIDPopUpActual.Value = "0";
            edtTitulo.Content = string.Empty;
            edtContenido.Content = string.Empty;
            txtDesde.Text = string.Empty;
            txtHasta.Text = string.Empty;
            rblStatus.SelectedValue = "0";
            edtTitulo.Focus();
            InicializarHora();
            CargarFotoPorDefecto(true);
        }

        private void InicializarHora() {

            ddlHoraDesde.Items.Clear();
            ddlHoraHasta.Items.Clear();
            for (int i = 0; i <= 12; i++)
            {
                ddlHoraDesde.Items.Add(i.ToString().PadLeft(2, '0'));
                ddlHoraHasta.Items.Add(i.ToString().PadLeft(2, '0'));
            }

            ddlHoraDesde.SelectedIndex = 12;
            ddlHoraHasta.SelectedIndex = 12;

            ddlMinDesde.Items.Clear();
            ddlMinHasta.Items.Clear();

            for (int i = 0; i <= 59; i++)
            {
                ddlMinDesde.Items.Add(i.ToString().PadLeft(2, '0'));
                ddlMinHasta.Items.Add(i.ToString().PadLeft(2, '0'));
            }
            ddlMinDesde.SelectedIndex = 0;
            ddlMinHasta.SelectedIndex = 0;

            ddlAMPMDesde.Items.Clear();
            ddlAMPMDesde.Items.Add("AM");
            ddlAMPMDesde.Items.Add("PM");
            ddlAMPMDesde.SelectedIndex = 0;

            ddlAMPMHasta.Items.Clear();
            ddlAMPMHasta.Items.Add("AM");
            ddlAMPMHasta.Items.Add("PM");
            ddlAMPMHasta.SelectedIndex = 0;
        }

        protected void OnAsyncFileUploadComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            if (asyncFileUpload.HasFile)
            {
                try
                {
                    HttpPostedFile file = asyncFileUpload.PostedFile;

                    btsImagen = ReadFile(file);
                    strNombreImagen = obtenerNombreArchivo((String)hdnIDPopUpActual.Value, (String)file.FileName);
                    LongImagen = file.ContentLength;

                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

                }
                catch (Exception ex)
                {
                    lblResultados.CssClass = "EResultado";
                    lblResultados.Text = "997 - No se pudo adjuntar la imagen. Detalles: " + ex.Message.ToString();
                }
            }
        }

        private void CargarFotoPorDefecto(bool bMostrar)
        {
            String tmpRutaFoto =  "~/images/bg.png";           
            String RutaFoto = MapPath(tmpRutaFoto);

            cManejaImagenes oManejaImagenes = new cManejaImagenes();
            oManejaImagenes.Imagen2Bytes(RutaFoto, ref btsImagen, ref LongImagen);
            strNombreImagen = obtenerNombreArchivo((String)hdnIDPopUpActual.Value, RutaFoto);

            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

            if (bMostrar)
            {
                previewImage.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
                udpBuscarPopUp.Update();
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

        protected void gdvPopUp_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnBuscarAvanzada_Click(object sender, ImageClickEventArgs e)
        {
            flsEditar.Visible = false;
            flsBuscar.Visible = true;
            udpBuscarPopUp.Update();
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            flsEditar.Visible = true;
            flsBuscar.Visible = false;
            udpBuscarPopUp.Update();
        }
     
    }
}