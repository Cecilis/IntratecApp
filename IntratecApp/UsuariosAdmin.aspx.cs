using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntraTecApp
{
    public partial class UsuariosAdmin : System.Web.UI.Page
    {

        private cUsuario oUsuario;
        private string strResultados;
        private string strAccion;

        protected void btnTextBoxEventHandler_Click(object sender, EventArgs e)
        {
            txtNombre.Text = "";
            rblStatus.ClearSelection();
            rblStatusBloqueo.ClearSelection();
            txtNroIntentosFallidos.Text = "";
            txtFechaUltimaConexion.Text = "";
            chkResetearClave.Checked = false;
            btnBuscarUsuario_Click(null, e: null);
        }

        protected void Page_Init(object sender, EventArgs e)
        {
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if(Session["Accesos"] == null)
                Response.Redirect("LogOut.aspx");

            if (!IsPostBack)
            {
                txtUsuario.Attributes.Add("onblur", this.Page.ClientScript.GetPostBackEventReference(this.btnTextBoxEventHandler, ""));

               strResultados = string.Empty;
                strAccion = string.Empty;
                Limpiar_Campos(this);
                HabilitarCampos(false);
                hdnIDUsuario.Value = "0";
                btnGuardar.Enabled = false;
                chkResetearClave.Checked = false;

            }
        }

        public void Limpiar_Campos(Control oContenedorControl)
        {
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
                if (oControl.HasControls())
                {
                    Limpiar_Campos(oControl);
                }                
            }
            chkResetearClave.Checked = false;
        }


        private void HabilitarCampos(bool Accion)
        {
            if (Accion)
            {
                txtNombre.Enabled = true;
                txtFechaUltimaConexion.Enabled = true;
                txtNroIntentosFallidos.Enabled = true;
                rblStatus.Enabled = true;
                rblStatusBloqueo.Enabled = true;
                lblResultado.Text = String.Empty;
                chkResetearClave.Enabled = true;
            }
            else
            {
                txtNombre.Enabled = false;
                txtFechaUltimaConexion.Enabled = false;
                txtNroIntentosFallidos.Enabled = false;
                rblStatus.Enabled = false;
                rblStatusBloqueo.Enabled = false;
                lblResultado.Text = String.Empty;
                chkResetearClave.Enabled = false;
            }
        }

        protected void btnBuscarUsuario_Click(object sender, EventArgs e)
        {

            if (!String.IsNullOrEmpty(txtUsuario.Text.Trim()))
            {

                oUsuario = new cUsuario();
                if (oUsuario.Existe(txtUsuario.Text))
                {
                    hdnIDUsuario.Value = oUsuario.IDUsuario.ToString();
                    txtNombre.Text = oUsuario.Nombre;                    
                    rblStatus.SelectedValue = oUsuario.Status;
                    rblStatusBloqueo.SelectedValue = oUsuario.StatusBloqueo;
                    txtNroIntentosFallidos.Text = oUsuario.intentosFallidos.ToString();
                    txtFechaUltimaConexion.Text = String.Format("{0:dd/MM/yyyy HH:mm:ss tt}", oUsuario.FechaUltimaConexion);
                    Session["oUsuario"] = oUsuario;
                    HabilitarCampos(true);
                    btnGuardar.Enabled = true;
                }
                else { //Usuario no existe
                    string strUsuario = txtUsuario.Text;
                    Limpiar_Campos(this);
                    hdnIDUsuario.Value = "0";                    
                    HabilitarCampos(true);
                    txtUsuario.Text = strUsuario;
                    txtNombre.Focus();
                    Session["oUsuario"] = oUsuario;
                    btnGuardar.Enabled = true;
                }
            }
            else { // Nombre Usuario esta en Blanco
                hdnIDUsuario.Value = "0";
                txtNombre.Text = string.Empty;
                HabilitarCampos(false);
                Session["oUsuario"] = null;
                btnGuardar.Enabled = false;
            }

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {

                string statusBloqueoAnterior = String.Empty;
                string statusAnterior = String.Empty; 

                oUsuario = (cUsuario)Session["oUsuario"];

                hdnIDUsuario.Value = oUsuario.IDUsuario.ToString();
                statusBloqueoAnterior = oUsuario.StatusBloqueo;
                statusAnterior = oUsuario.Status;                               

                if (oUsuario.IDUsuario == 0)
                {
                    strAccion = "I";
                }
                else
                {
                    strAccion = "M";
                }

                oUsuario.Usuario = txtUsuario.Text;
                oUsuario.Nombre = txtNombre.Text;

                if (chkResetearClave.Checked)
                {
                    oUsuario.ClaveReseteada = "1";
                    oUsuario.intentosFallidos = 0;
                }
                else {
                    oUsuario.ClaveReseteada = "0";
                }

                if (strAccion == "I" || chkResetearClave.Checked)
                { 
                    cEncriptacion oCryptorEngine = new cEncriptacion();
                    oUsuario.Clave = oCryptorEngine.Encriptar(txtUsuario.Text.ToString().ToLower());                
                }

                oUsuario.Status = rblStatus.SelectedValue; 

                oUsuario.StatusBloqueo = rblStatusBloqueo.SelectedValue;

                if (statusBloqueoAnterior == "1") //Estaba bloqueado antes
                {
                    oUsuario.intentosFallidos = 0;
                }

                oUsuario.ActualizarDatos(strAccion, chkResetearClave.Checked, ref strResultados);
                if (strResultados.Trim() == "OK")
                {
                    Session["oUsuario"] = null;
                    Limpiar_Campos(Page);
                    HabilitarCampos(false);
                    strResultados = "Usuario actualizado.";
                    lblResultado.CssClass = "Resultado";
                    lblResultado.Text = strResultados;
                    txtNombre.Focus();
                    btnGuardar.Enabled = false;
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

        }

        protected void rblStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rblStatus.Items[0].Selected) {
            }
        }


        //Consulta

        protected void btnBuscarAvanzada_Click(object sender, ImageClickEventArgs e)
        {
            flsEditar.Visible = false;
            flsBuscar.Visible = true;
            CargarGridConsultaUsuarios();
            lblResultado.CssClass = "Resultado";
            lblResultado.Text = string.Empty;
            udpEditarUsuario.Update();
        }

        public DataTable ObtenerDatosUsuarios()
        {
            cUsuario oUsuario = new cUsuario();
            try
            {
                DataSet oDataSet = oUsuario.ObtenerTodos();
                DataTable oDataTable = oDataSet.Tables["Todos"];
                return oDataTable;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                oUsuario = null;
            }
        }

        public void CargarGridConsultaUsuarios()
        {
            try
            {
                gvwConsulta.DataSource = ObtenerDatosUsuarios();
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
            CargarGridConsultaUsuarios();
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

                DataTable oDataTable = ObtenerDatosUsuarios();
                DataView oDataView = new DataView(oDataTable);
                oDataView.Sort = e.SortExpression + " " + opSort;
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
                    Label lblUsuario = (Label)oGridViewRow.FindControl("lblUsuario");

                    if (!(string.IsNullOrEmpty(lblUsuario.Text.Trim())))
                    {
                        txtUsuario.Text = lblUsuario.Text.Trim();
                        btnBuscarUsuario_Click(null, e: null);
                        lblResultadoConsulta.CssClass = "Resultado";
                        lblResultadoConsulta.Text = "";
                        flsBuscar.Visible = false;
                        flsEditar.Visible = true;
                    }
                    else
                    {
                        lblResultadoConsulta.CssClass = "EResultado";
                        lblResultadoConsulta.Text = "Error al cargar los datos del usuario";
                        flsBuscar.Visible = true;
                        flsEditar.Visible = false;
                    }
                    btnVolver_Click(null, e: null);
                    udpEditarUsuario.Update();
                }
            }
            catch (Exception ex)
            {
                lblResultadoConsulta.CssClass = "EResultado";
                lblResultadoConsulta.Text = "Error al cargar los datos del usuario.</br> Detalle: </br>" + ex.InnerException.Message.ToString().Trim();
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
            udpEditarUsuario.Update();
        }

        protected void txtFechaUltimaConexion_TextChanged(object sender, EventArgs e)
        {

        }

   }
}