using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntraTecApp
{
    public partial class Http404ErrorPage : System.Web.UI.Page
    {
        protected HttpException oHttpException = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            oHttpException = new HttpException("HTTP 404");
            cGestionaExcepciones.RegistrarLog(oHttpException, "Generada en: Http404ErrorPage");
            cGestionaExcepciones.GenerarNotificacion(oHttpException);
        }
    }
}