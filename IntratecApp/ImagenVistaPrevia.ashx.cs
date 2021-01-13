using System.Drawing;
using System.Drawing.Imaging;
using System.IO;
using System.Web;
using IntraTecApp;
using System.Web.SessionState;

namespace IntraTecApp
{

    public class ImagenVistaPrevia : IHttpHandler, IRequiresSessionState 
    {

        public void ProcessRequest(HttpContext oHttpContext)
        {
            oHttpContext.Response.Clear();

            if (oHttpContext.Request.QueryString.Count != 0)
            {
                var oArrBytesImagen = oHttpContext.Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE] as byte[];
                if (oArrBytesImagen != null)
                {
                    string nombre = oHttpContext.Session[IntraTecApp.cAuxiliarImagen.STORED_IMAGE_NAME] as string;

                    Image oImagen = ObtenerImagen(oArrBytesImagen);
                    if (oImagen != null)
                    {
                        ImageFormat oImageFormat = cAuxiliarImagen.ObtenerTipoContenido(oArrBytesImagen);
                        oHttpContext.Response.ContentType = cAuxiliarImagen.ObtenerNombreFormato(oImageFormat);
                        oImagen.Save(oHttpContext.Response.OutputStream, ImageFormat.Png);
                    }
                }
            }
        }

        private Image ObtenerImagen(byte[] oArrBytesImagen)
        {
            var oMemoryStream = new MemoryStream(oArrBytesImagen);
            return Image.FromStream(oMemoryStream);
        }

        public bool IsReusable
        {
            get { return false; }
        }
    }
}