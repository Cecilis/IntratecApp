using System;
using System.Text;
using System.Security.Cryptography;
using System.Threading;

namespace IntraTecApp
{
    public partial class CambioClave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if ((Session["oUsuario"] == null))
                Response.Redirect("LogOut.aspx");

            cUsuario oUsuario = new cUsuario();
            oUsuario = (cUsuario)(Session["oUsuario"]);

            if (oUsuario != null) {
                txtUsuarioActual.Text = oUsuario.Usuario.Trim();
            }

            if (string.IsNullOrEmpty(txtUsuarioActual.Text)){
                Session["oUsuario"] = null;
                txtUsuarioActual.Enabled = true;
                pwdClaveActual.Focus();
            }                
            else 
            {
                txtUsuarioActual.Enabled = false;
                txtUsuarioActual.Focus();
            }
        }

        protected void btnCambiarClave_Click(object sender, EventArgs e)
        {

            try
            {                
                string strClaveActual;
                string strClaveAlmacenada;
                string strClaveNueva;                
                string strClaveConfirmacion;

                string strEncriptClaveActual;
                string strEncriptClaveNueva;
                string strEncriptClaveConfirmacion;
                
                this.pnlAutenticacion.Visible = false;
                this.pnlCambioClaveDatos.Visible = true;

                strClaveActual = ((string)(pwdClaveActual.Value)).Trim();
                strClaveNueva = ((string)(pwdClaveNueva.Value)).Trim();
                strClaveConfirmacion = ((string)(pwdConfirmacion.Value)).Trim();

                if (strClaveNueva.Trim() != strClaveConfirmacion.Trim())
                {
                    lblResultado.CssClass = "EResultado";
                    lblResultado.Text = "Nueva Clave y Confirmación no coinciden";
                }

                cUsuario oUsuario = new cUsuario();             

                if (oUsuario.Existe(txtUsuarioActual.Text.Trim())){
                    
                    cEncriptacion oCryptorEngine = new cEncriptacion();

                    strClaveAlmacenada = oUsuario.Clave;
                    strEncriptClaveActual = oCryptorEngine.Encriptar(strClaveActual);
                    strEncriptClaveNueva = oCryptorEngine.Encriptar(strClaveNueva);
                    strEncriptClaveConfirmacion = oCryptorEngine.Encriptar(strClaveConfirmacion);

                    if (string.Equals(strEncriptClaveActual, strClaveAlmacenada))
                    {
                        oUsuario.ClaveReseteada = "0";
                        oUsuario.actualizaClave(strEncriptClaveNueva);
                        Session["oUsuario"] = oUsuario;
                        lblResultado.CssClass = "Resultado";
                        lblResultado.Text = "Clave Actualizada.";
                        Thread.Sleep(1000);
                        Page.ClientScript.RegisterStartupScript(GetType(), "Reload", "parent.location.reload();", true);
                        Session.Abandon();
                        Session.Clear();
                    }
                    else
                    
                        if (oUsuario.IntentosFallidosIncrementados())
                        {
                            lblResultado.CssClass = "EResultado";
                            if (oUsuario.StatusBloqueo == "1")
                            {
                                lblResultado.Text = "Usuario bloqueado";
                                //Si el usuario bloqueado es el actual se cierra su sesion
                                if (oUsuario.Usuario.Trim().ToUpper() == txtUsuarioActual.Text.Trim().ToUpper())
                                {
                                    Thread.Sleep(1000);
                                    Page.ClientScript.RegisterStartupScript(GetType(), "Reload", "parent.location.reload();", true);
                                    Session.Abandon();
                                    Session.Clear();
                                }
                            }
                            else
                            {
                                lblResultado.Text = "Clave actual invalida. </ br> Al tercer intento fallido su usuario será boqueado.";
                            }
                        }
                        else {
                            lblResultado.CssClass = "EResultado";
                            lblResultado.Text = "Clave actual invalida.";
                        }
                }
                else
                {
                    this.pnlCambioClaveDatos.Visible = false;
                    lblResultado.Text = "Usuario no existe.";
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }
    }
}