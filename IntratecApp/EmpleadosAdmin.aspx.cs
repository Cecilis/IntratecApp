using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace IntraTecApp
{
    public partial class EmpleadosAdmin : System.Web.UI.Page
    {
        string strNombreArchivo = String.Empty;
        Int32 cnt = 0;
        Int32 i = 0;
        string pth = String.Empty;
        FileInfo oFileInfo = null;

        private cEmpleado oEmpleado;
        private string strResultados;
        private string strAccion;

        byte[] btsImagen = {};
        String strNombreImagen = String.Empty;
        int LongImagen = 0;

        public string strUbicacionArchivo() {
            return ConfigurationManager.AppSettings["CarpetaFotos"].ToString();
        }

        public void Limpiar_Campos(Control oContenedorControl) {
            foreach (Control oControl in oContenedorControl.Controls)
            {
                if (oControl is TextBox)
                {
                    ((TextBox)oControl).Text = "";
                }
                if (oControl is DropDownList)
                {
                    ((DropDownList)oControl).SelectedIndex = 0;
                }
                if (oControl.HasControls()) {
                    Limpiar_Campos(oControl);
                }
            }    
            
        }


        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            Limpiar_Campos(this);
            HabilitarCampos(false);
            btnGuardar.Enabled = false;
            btnEliminar.Enabled = false;
            cmbTipoID.Enabled = true;
            txtNumIdentificacion.Enabled = true;
            txtNumIdentificacion.Focus();
            CargarFotoPorDefecto();
            chkStatusPubDatos.SelectedValue = null;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Accesos"]  == null)
                Response.Redirect("LogOut.aspx");

            if (!IsPostBack) {

                strResultados = string.Empty;
                strAccion = string.Empty;
                
                String DinamicLanguage = ConfigurationManager.AppSettings["Culture"].ToString();
                Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo(DinamicLanguage);
                
                Limpiar_Campos(this);
                HabilitarCampos(false);
                btnGuardar.Enabled = false;
                btnEliminar.Enabled = false;
                CargarFotoPorDefecto();

                cmbTipoID.Enabled = true;
                txtNumIdentificacion.Enabled = true;
                txtNumIdentificacion.Focus();
                chkStatusPubDatos.SelectedValue = null;
            }
        }

    protected void btnEliminar_Click(object sender, EventArgs e)
    {
        try
        {
            string strResultado = "NOTOK";
            oEmpleado = (cEmpleado)Session["oEmpleado"];
            oEmpleado.Eliminar(ref strResultado);
            if (strResultado != "OK")
                throw new Exception("Error al eliminar empleado");
            lblResultado.CssClass = "Resultado";
            lblResultado.Text = "Empleado eliminado.";
        } 
        catch (Exception ex)
        {
            strResultados = ex.Message.ToString();
            lblResultado.CssClass = "EResultado";
            lblResultado.Text = strResultados;
        }
        finally
        {
            udpEditarEmpleado.Update();
        }
        
    }

    protected void btnGuardar_Click(object sender, EventArgs e)
    {
        try
        {
            oEmpleado = (cEmpleado)Session["oEmpleado"];

            if (oEmpleado == null)
                oEmpleado = new cEmpleado();

            if (Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] == null) //No hay datos de la Imagen 
            {

                String tmpRutaFoto = string.Empty;
                if (cmbSexo.SelectedValue == "F")
                {
                    tmpRutaFoto = "../images/AvatarF.png";
                }
                else
                {
                    tmpRutaFoto = "../images/AvatarM.png";
                }

                String RutaFoto = MapPath(tmpRutaFoto);

                cManejaImagenes oManejaImagenes = new cManejaImagenes();
                oManejaImagenes.Imagen2Bytes(RutaFoto, ref btsImagen, ref LongImagen);
                strNombreImagen = obtenerNombreArchivo((String)txtNumIdentificacion.Text, RutaFoto);

                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

            }


            if (oEmpleado.IDEmpleado == 0)
            {
                strAccion = "I";
            }
            else
            {
                strAccion = "M";
            }

            oEmpleado.TipoID = cmbTipoID.Text;
            oEmpleado.IDNumero = txtNumIdentificacion.Text;
            oEmpleado.Nombre = txtNombre.Text;
            oEmpleado.Apellido = txtApellido.Text;
            oEmpleado.Sexo = cmbSexo.Text;

            oEmpleado.FechaNacimiento = Convert.ToDateTime(String.Format("{0:dd/MM/yyyy}", txtFecNac.Text));
            oEmpleado.NumSeguroSocial = txtNumSegSocial.Text;
            oEmpleado.ImgFoto = (byte[])Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE];
            oEmpleado.NombreFoto = (string)Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME];
            oEmpleado.ImgFotoLong = (int)Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH];
            oEmpleado.CodCargo = txtCargo.Text;
            oEmpleado.StatusPubDatos = chkStatusPubDatos.SelectedValue;
            oEmpleado.CodTipoEmpleado = "1";
            oEmpleado.CodAreaTlfOficina = txtCodAreaOficina.Text;
            oEmpleado.NumTlfOficina = txtNumTlfLocal.Text;
            oEmpleado.CodAreaTlfMovil = txtCodAreaMovil.Text;
            oEmpleado.NumTlfMovil = txtNumTlfMovil.Text;
            oEmpleado.DescCargo = txtCargo.Text;
            oEmpleado.FecIngreso = Convert.ToDateTime(String.Format("{0:dd/MM/yyyy}", txtFecIngreso.Text));

            if (rblStatus.Items[0].Selected)
            {
                oEmpleado.Status = "1";
            }
            else
            {
                oEmpleado.Status = "0";
            }

            oEmpleado.ActualizarDatosEmpleado(strAccion, ref strResultados);
            if (strResultados.Trim() == "OK")
            {
                Session["oEmpleado"] = null;
                Limpiar_Campos(Page);
                HabilitarCampos(false);
                strResultados = "Empleado actualizado.";
                lblResultado.CssClass = "Resultado";
                lblResultado.Text = strResultados;
                txtNumIdentificacion.Focus();
                btnGuardar.Enabled = false;
                btnEliminar.Enabled = false;
                cmbTipoID.Enabled = true;
                txtNumIdentificacion.Enabled = true;
                CargarFotoPorDefecto();
                txtNumIdentificacion.Focus();
            }
            else
            {
                lblResultado.CssClass = "EResultado";
                lblResultado.Text = strResultados;
            }

        }
        catch (Exception ex)
        {
            strResultados = ex.Message.ToString();
            lblResultado.CssClass = "EResultado";
            lblResultado.Text = strResultados;
        }
        finally { 
            udpEditarEmpleado.Update();         
        }

    }

    protected void OnAsyncFileUploadComplete(object sender, AjaxControlToolkit.AsyncFileUploadEventArgs e)
        {
            if (afuFoto.HasFile)
            {
                try
                {
                    imgVistaPrevia.ImageUrl = null;
                    HttpPostedFile file = afuFoto.PostedFile;
                            
                    btsImagen = ReadFile(file);
                    strNombreImagen = obtenerNombreArchivo((String)txtNumIdentificacion.Text, (String)file.FileName);
                    LongImagen = file.ContentLength;

                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
                    Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

                }
                catch (Exception ex){
                    lblResultado.CssClass = "EResultado";
                    lblResultado.Text = "997 - No se pudo adjuntar la imagen. Detalles: "+ ex.Message.ToString();
                }
            }
            
        }

        private String obtenerNombreArchivo (String numID, String strNombreArchivo) {
            return (numID).PadLeft(15, '0') + (strNombreArchivo).Substring(strNombreArchivo.Length - 4, 4);
        }

        private byte[] ReadFile(HttpPostedFile oHttpPostedFile)
        {
            byte[] oArrBytes = new Byte[oHttpPostedFile.ContentLength];
            oHttpPostedFile.InputStream.Read(oArrBytes, 0, oHttpPostedFile.ContentLength);
            return oArrBytes;
        }


        public byte[] ObtenerBytes(string strNombreArchivo)
        {
            byte[] oArrByte = null;
            try
            {
                System.IO.FileStream oFileStream = new System.IO.FileStream(strNombreArchivo, System.IO.FileMode.Open, System.IO.FileAccess.Read);
                System.IO.BinaryReader oBinaryReader = new System.IO.BinaryReader(oFileStream);
                long lngTotalBytes = new System.IO.FileInfo(strNombreArchivo).Length;
                oArrByte = oBinaryReader.ReadBytes((Int32)lngTotalBytes);
                oFileStream.Close();
                oFileStream.Dispose();
                oBinaryReader.Close();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return oArrByte;
        }


        protected void btnBuscarEmpleado_Click(object sender, EventArgs e)
        {

            try
            {
                string strTipoId = cmbTipoID.SelectedValue;
                string strNumIdentificacion = txtNumIdentificacion.Text;
                Limpiar_Campos(Page);
                btnGuardar.Enabled = true;
                btnEliminar.Enabled = true;

                if ((!String.IsNullOrEmpty(strTipoId.Trim())) && (!String.IsNullOrEmpty(strNumIdentificacion.Trim())))
                {
                    oEmpleado = new cEmpleado();
                    if (oEmpleado.ExisteEmpleado(strTipoId, strNumIdentificacion))
                    {
                        cmbTipoID.SelectedValue = oEmpleado.TipoID;
                        txtNumIdentificacion.Text = oEmpleado.IDNumero;
                        txtNombre.Text = oEmpleado.Nombre;
                        txtApellido.Text = oEmpleado.Apellido;
                        cmbSexo.SelectedValue = oEmpleado.Sexo;
                        txtFecNac.Text = String.Format("{0:dd/MM/yyyy}", oEmpleado.FechaNacimiento);
                        txtNumSegSocial.Text = oEmpleado.NumSeguroSocial;
                        cmbTipoID.Enabled = false;
                        txtNumIdentificacion.Enabled = false;

                        if ((oEmpleado.ImgFoto != null) && (oEmpleado.ImgFoto.Length != 0))
                        {
                            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = oEmpleado.ImgFoto;
                            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = oEmpleado.NombreFoto;
                            Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = oEmpleado.ImgFotoLong;
                        }
                        else
                        {
                            CargarFotoPorDefecto();
                        }

                        imgVistaPrevia.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);

                        if (oEmpleado.StatusPubDatos == "1")
                        {
                            chkStatusPubDatos.SelectedValue = "1";
                        }


                        if (oEmpleado.Status == "1")
                        {
                            rblStatus.Items[0].Selected = true;
                        }
                        else
                        {
                            rblStatus.Items[0].Selected = false;
                        }

                        txtCodAreaOficina.Text = oEmpleado.CodAreaTlfOficina;
                        txtNumTlfLocal.Text = oEmpleado.NumTlfOficina;
                        txtCodAreaMovil.Text = oEmpleado.CodAreaTlfMovil;
                        txtNumTlfMovil.Text = oEmpleado.NumTlfMovil;

                        txtFecIngreso.Text = String.Format("{0:dd/MM/yyyy}", oEmpleado.FecIngreso);
                        txtCargo.Text = oEmpleado.DescCargo;
                        Session["oEmpleado"] = oEmpleado;
                        HabilitarCampos(true);
                    }
                    else
                    { //Empleado no existe

                        cmbTipoID.SelectedValue = strTipoId;
                        txtNumIdentificacion.Text = strNumIdentificacion;
                        cmbTipoID.Enabled = false;
                        txtNumIdentificacion.Enabled = false;
                        txtNombre.Focus();
                        Session["oEmpleado"] = oEmpleado;
                        HabilitarCampos(true);
                        CargarFotoPorDefecto();
                    }
                }
                else
                { // Numero de cedula o tipo de identificación esta vacio

                    cmbTipoID.SelectedValue = strTipoId;
                    txtNumIdentificacion.Text = strNumIdentificacion;
                    txtNumIdentificacion.Focus();
                    HabilitarCampos(false);
                    Session["oEmpleado"] = null;
                    CargarFotoPorDefecto();
                    lblResultado.CssClass = "EResultado";
                    lblResultado.Text = "Debe indicar tipo y numero de identificacion.";
                }
            }
            catch (Exception ex)
            {
                strResultados = ex.Message.ToString();
                lblResultado.CssClass = "EResultado";
                lblResultado.Text = strResultados;
            }
            finally
            {
                udpEditarEmpleado.Update();
            }
        }

        private void HabilitarCampos(bool Accion) {
            if (Accion) 
            {
                txtNombre.Enabled = true;
                txtApellido.Enabled = true;
                cmbSexo.Enabled = true;
                txtFecNac.Enabled = true;
                txtNumSegSocial.Enabled = true;

                chkStatusPubDatos.Enabled = true;

                txtCodAreaOficina.Enabled = true;
                txtNumTlfLocal.Enabled = true;
                txtCodAreaMovil.Enabled = true;
                txtNumTlfMovil.Enabled = true;

                txtFecIngreso.Enabled = true;
                txtCargo.Enabled = true;

                btnEliminarFoto.Enabled = true;
                DeshabilitarFileUpload.Visible = true;

                btnBuscarEmpleado.Enabled = true;
                lblResultado.Text = String.Empty;

            }
            else 
            {
                txtNombre.Enabled = false;
                txtApellido.Enabled = false;
                cmbSexo.Enabled = false;
                txtFecNac.Enabled = false;
                txtNumSegSocial.Enabled = false;

                chkStatusPubDatos.Enabled = false;

                txtCodAreaOficina.Enabled = false; 
                txtNumTlfLocal.Enabled = false;
                txtCodAreaMovil.Enabled = false;
                txtNumTlfMovil.Enabled = false;

                txtFecIngreso.Enabled = false;
                txtCargo.Enabled = false;

                btnBuscarEmpleado.Enabled = true;
                btnEliminarFoto.Enabled = false;
                DeshabilitarFileUpload.Visible = false;                

                lblResultado.Text = String.Empty;

                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = null;
                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = null;
                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = null;

            }
        }

        private void CargarFotoPorDefecto() {

            try
            {
                String tmpRutaFoto = string.Empty;
                if (cmbSexo.SelectedValue == "F")
                {
                    tmpRutaFoto = "~/images/AvatarF.png";
                }
                else
                {
                    tmpRutaFoto = "~/images/AvatarM.png";
                }

                String RutaFoto = MapPath(tmpRutaFoto);

                cManejaImagenes oManejaImagenes = new cManejaImagenes();
                oManejaImagenes.Imagen2Bytes(RutaFoto, ref btsImagen, ref LongImagen);
                strNombreImagen = obtenerNombreArchivo((String)txtNumIdentificacion.Text, RutaFoto);

                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] = btsImagen;
                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] = strNombreImagen;
                Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_LENGTH] = LongImagen;

                imgVistaPrevia.ImageUrl = "~/ImagenVistaPrevia.ashx?randomno=" + new Random(DateTime.Now.Millisecond);
            }
            catch (Exception ex)
            {
                lblResultado.CssClass = "EResultado";
                lblResultado.Text = ex.Message.ToString();
            }
        }

        protected void btnEliminarFoto_Click(object sender, ImageClickEventArgs e)
        {
            CargarFotoPorDefecto();
            udpEditarEmpleado.Update();
        }

        protected void cmbSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] == null) //No hay datos de la Imagen 
                CargarFotoPorDefecto();
            txtFecNac.Focus();
            udpEditarEmpleado.Update();
        }

        protected void rblStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!rblStatus.Items[0].Selected) //Inactivo
            {
                chkStatusPubDatos.SelectedValue = null; //No se publica en Intranet
            }
        }

        protected void btnBuscarAvanzada_Click(object sender, ImageClickEventArgs e)
        {
            flsEditar.Visible = false;
            flsBuscar.Visible = true;
            CargarGridConsultaEmpleados();
            lblResultado.CssClass = "Resultado";
            lblResultado.Text = string.Empty;
            udpEditarEmpleado.Update();
        }

        public DataTable ObtenerDatosEmpleados()
        {

            cEmpleado oEmpleado = new cEmpleado();
            try
            {
                DataSet oDataSet = oEmpleado.ObtenerTodos();
                DataTable oDataTable = oDataSet.Tables["Todos"];
                return oDataTable;
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

        public void CargarGridConsultaEmpleados()
        {
            try
            {
                gvwConsulta.DataSource = ObtenerDatosEmpleados();
                gvwConsulta.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }


        protected void gvwConsulta_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvwConsulta.PageIndex = e.NewPageIndex;
            CargarGridConsultaEmpleados();
        }

        protected void gvwConsulta_Sorting(object sender, GridViewSortEventArgs e)
        {
            var opSortExpression = e.SortExpression;
            var opSortDirection = e.SortDirection;

            if (gvwConsulta.Attributes["CurrentSortField"] != null && gvwConsulta.Attributes["CurrentSortDir"] != null)
            {
                if (opSortExpression == gvwConsulta.Attributes["CurrentSortField"])
                {
                    opSortDirection = SortDirection.Descending;
                    if (gvwConsulta.Attributes["CurrentSortDir"] == "ASC")
                        opSortDirection = SortDirection.Ascending;
                    
                }
                gvwConsulta.Attributes["CurrentSortField"] = opSortExpression;
                var opSort = (opSortDirection == SortDirection.Ascending ? "DESC" : "ASC");
                gvwConsulta.Attributes["CurrentSortDir"] = opSort;

                DataTable oDataTable = ObtenerDatosEmpleados();
                DataView oDataView = new DataView(oDataTable);
                oDataView.Sort = e.SortExpression + " " + opSort;
                gvwConsulta.SortedAscendingHeaderStyle.CssClass = "TitulosGrid";
                gvwConsulta.SortedDescendingHeaderStyle.CssClass = "TitulosGrid";
                gvwConsulta.DataSource = oDataView;
                gvwConsulta.DataBind();

            }
        }

        protected void gvwConsulta_RowCommand(Object sender, GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName == "VerDetalle")
                {
                    GridViewRow oGridViewRow = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                    Label lblTipoID = (Label)oGridViewRow.FindControl("lblTipoID");
                    Label lblIDNumero = (Label)oGridViewRow.FindControl("lblIDNumero");
                    ImageButton btnVerDetalle = (ImageButton)oGridViewRow.FindControl("btnVerDetalle");

                    if (!(string.IsNullOrEmpty(lblTipoID.Text.Trim())) && (!(string.IsNullOrEmpty(lblIDNumero.Text.Trim()))))
                    {
                        cmbTipoID.Text = lblTipoID.Text.Trim();
                        txtNumIdentificacion.Text = lblIDNumero.Text.Trim();
                        btnBuscarEmpleado_Click(null, e: null);
                        lblResultadoConsulta.CssClass = "Resultado";
                        lblResultadoConsulta.Text = "";
                        flsBuscar.Visible = false;
                        flsEditar.Visible = true;
                    }
                    else
                    {
                        lblResultadoConsulta.CssClass = "EResultado";
                        lblResultadoConsulta.Text = "Error al cargar los datos de trabajador";
                        flsBuscar.Visible = true;
                        flsEditar.Visible = false;
                    }
                    btnVolver_Click(null, e: null);
                    udpEditarEmpleado.Update();
                }
            }
            catch (Exception ex)
            {
                lblResultadoConsulta.CssClass = "EResultado";
                lblResultadoConsulta.Text = "Error al cargar los datos de trabajador.</br> Detalle: </br>" + ex.InnerException.Message.ToString().Trim();
                flsBuscar.Visible = true;
                flsEditar.Visible = false;
            }
        }

        protected void gvwConsulta_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow oGridViewRow = gvwConsulta.SelectedRow;
        }

        protected void btnVerDetalle_DataBinding(object sender, System.EventArgs e)
        {

        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            flsEditar.Visible = true;
            flsBuscar.Visible = false;
            lblResultado.CssClass = "Resultado";
            lblResultado.Text = string.Empty;
            udpEditarEmpleado.Update();
        }

    }
}