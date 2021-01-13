using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntraTecApp
{
    public partial class NoHttpErrorPage : System.Web.UI.Page
    {
        protected Exception oException = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            string strMensajeError = string.Empty;
            if (Server.GetLastError() != null)
            {
                oException = (Exception)Server.GetLastError();               
                if (oException.InnerException != null)
                    strMensajeError = oException.InnerException.Message;
                else
                    strMensajeError = oException.Message;
            }
            else
                oException = new HttpException("Error desconocido.");

            // Registro en Archivo de Log
            cGestionaExcepciones.RegistrarLog(oException, "Generado en página por defecto");
            //Notificación
            cGestionaExcepciones.GenerarNotificacion(oException);

            exMessage.Text = strMensajeError;

            // Limpia el error del server.
            Server.ClearError();
        }
    }
}