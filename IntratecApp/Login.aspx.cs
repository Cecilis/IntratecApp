using System;
using System.Threading;
using System.Web.UI;

namespace IntraTecApp
{
    public partial class Login : System.Web.UI.Page
    {


        protected void btnEntrar_Click(object sender, EventArgs e)
        {
            string strUsuario;
            string strClave;

            string strEncriptClave;
            string strEncriptClaveAlmacenada;

            strUsuario = ((string)(txtUsuario.Text)).Trim().ToUpperInvariant();
            strClave = ((string)(pwdClave.Value)).Trim();
                
            cUsuario oUsuario = new cUsuario(strUsuario);

            cEncriptacion oCryptorEngine = new cEncriptacion();

            if (!(oUsuario == null)) {
                
                strEncriptClave = oCryptorEngine.Encriptar(strClave);
                strEncriptClaveAlmacenada = oUsuario.Clave;

                if (oUsuario.Status == "0")
                {
                    Session["oUsuario"] = null;
                    lblResultado.CssClass = "EResultado";
                    lblResultado.Text = "Usuario Inactivo.";                        
                }
                else if (oUsuario.StatusBloqueo == "1")
                {
                    Session["oUsuario"] = null;
                    lblResultado.CssClass = "EResultado";
                    lblResultado.Text = "Usuario Bloqueado.";
                }
                else if (oUsuario.ClaveReseteada == "1") {
                    Session["oUsuario"] = oUsuario;
                    Response.Redirect("CambioClave.aspx");
                }
                else if (string.Equals(strEncriptClave, strEncriptClaveAlmacenada))
                {
                    Session["oUsuario"] = oUsuario;
                    Session["Accesos"] = "OK";
                    Thread.Sleep(1000);
                    Page.ClientScript.RegisterStartupScript(GetType(), "Reload", "parent.location.reload();", true);
                }
                else
                {
                    Session["Accesos"] = "NOTOK";
                    Session["oUsuario"] = null;
                    if (oUsuario.IntentosFallidosIncrementados())
                    {
                        lblResultado.CssClass = "EResultado";
                        if (oUsuario.StatusBloqueo.Trim() == "0")
                        {
                            lblResultado.Text = "Datos incorrectos." + "</br>" + "Al tercer intento su usuario será bloqueado.";
                        }
                        else
                        {
                            lblResultado.Text = "Datos incorrectos." + "</br>" + "Su usuario ha sido bloqueado.";
                        }
                    }
                    else {
                            lblResultado.CssClass = "EResultado";
                            lblResultado.Text = "Error accediendo al registro de usuarios. Compruebe que el usuario existe.";                     
                        } 
                    }
            }                
            else {
                Session["oUsuario"] = null;
                Session["Accesos"] = "NOTOK";
                lblResultado.CssClass = "EResultado";
                lblResultado.Text = "Usuario No Existe.";                
            }
        }

        protected void btnCerrar_Click(object sender, EventArgs e)
        {
            Page.ClientScript.RegisterStartupScript(GetType(), "Reload", "parent.location.reload();", true);

        }
    }
}