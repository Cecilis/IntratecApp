using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace IntraTecApp
{
    public partial class Reportes : System.Web.UI.Page
    {
        public string FormatearABytes(long lngBytes)
        {
            const int Escala = 1024;
            string[] oArrOrden = new string[] { "GB", "MB", "KB", "Bytes" };
            long lngMaximo = (long)Math.Pow(Escala, oArrOrden.Length - 1);

            foreach (string strOrden in oArrOrden)
            {
                if (lngBytes > lngMaximo)
                    return string.Format("{0:##.##} {1}", decimal.Divide(lngBytes, lngMaximo), strOrden);

                lngMaximo /= Escala;
            }
            return "0 Bytes";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblTipoDocumento.Text = "Reportes";
                string[] filePaths = Directory.GetFiles(cConfiguracion.ObtenerAppSettings("CarpetaReportes"));
                List<ListItem> files = new List<ListItem>();
                foreach (string filePath in filePaths)
                {
                    files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                }
                gvwReportes.DataSource = files;
                gvwReportes.DataBind();
            }
        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            string strRutaCompleta = (sender as LinkButton).CommandArgument;
            Response.ContentType = ContentType;
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(strRutaCompleta));
            Response.TransmitFile(strRutaCompleta);
            Response.End();
        }

        protected void DeleteFile(object sender, EventArgs e)
        {
            string strRutaCompleta = (sender as LinkButton).CommandArgument;
            File.Delete(strRutaCompleta);
            Response.Redirect(Request.Url.AbsoluteUri);
        }
    }
}           
