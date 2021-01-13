using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using System.Web.SessionState;
using IntraTecApp;
using System.Threading;

namespace IntraTecApp
{

    public class ImagenCargador : IHttpHandler
    {

        public void ProcessRequest(HttpContext oHttpContext)
        {
            oHttpContext.Response.Clear();
            if (oHttpContext.Request.QueryString["IDEmpleado"] != null)
            {
                BuscarImagenBD(oHttpContext, oHttpContext.Request.QueryString["IDEmpleado"], "E");
            }

            if (oHttpContext.Request.QueryString["IDNoticia"] != null)
            {
                BuscarImagenBD(oHttpContext, oHttpContext.Request.QueryString["IDNoticia"], "N");
            }
        }

        private void BuscarImagenBD(HttpContext oHttpContext, string strIDFoto, string strTipoFoto)
        {
            byte[] oArrBytesImagen = cFoto.Foto(strIDFoto, strTipoFoto);

            Image oImage = ObtenerImagen(oArrBytesImagen);
            if (oImage != null)
            {
                ImageFormat oImageFormat = cAuxiliarImagen.ObtenerTipoContenido(oArrBytesImagen);
                oHttpContext.Response.ContentType = cAuxiliarImagen.ObtenerNombreFormato(oImageFormat);
                oImage.Save(oHttpContext.Response.OutputStream, ImageFormat.Jpeg);
            }
        }

        private Image ObtenerImagen(byte[] ImagenAlmacenada)
        {
            if (ImagenAlmacenada.Length != 0)
            {
                var oMemoryStream = new MemoryStream(ImagenAlmacenada);
                return Image.FromStream(oMemoryStream);
            }
            else return null;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }

    }
}
