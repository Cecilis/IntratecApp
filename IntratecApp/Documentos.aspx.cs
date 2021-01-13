using System;
using System.IO;

namespace IntraTecApp
{
    public partial class Documentos : System.Web.UI.Page
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

            try
            {
                DirectoryInfo dirInfo;
                String strTipoConsulta = Request.QueryString["td"];
                hdnTipoConsulta.Value = strTipoConsulta;


                if (strTipoConsulta == "M")
                {
                    dirInfo = new DirectoryInfo(cConfiguracion.ObtenerAppSettings("CarpetaManuales"));
                    lblTipoDocumento.Text = "Manuales";
                }
                else if (strTipoConsulta == "N")
                {
                    dirInfo = new DirectoryInfo(cConfiguracion.ObtenerAppSettings("CarpetaNormativas"));
                    lblTipoDocumento.Text = "Normativas";
                }
                else if (strTipoConsulta == "P")
                {
                    dirInfo = new DirectoryInfo(cConfiguracion.ObtenerAppSettings("CarpetaProcedimientos"));
                    lblTipoDocumento.Text = "Procedimientos";
                }
                else if (strTipoConsulta == "R")
                {
                    dirInfo = new DirectoryInfo(cConfiguracion.ObtenerAppSettings("CarpetaReportes"));
                    lblTipoDocumento.Text = "Reportes";
                }
                else
                {
                    throw new Exception("Operación Invalida.");
                }

                FileInfo[] oArrFileInfo;

                if (strTipoConsulta == "R")
                {
                    oArrFileInfo = dirInfo.GetFiles("*.*", SearchOption.AllDirectories);
                }
                else 
                {
                    oArrFileInfo = dirInfo.GetFiles("*.pdf", SearchOption.AllDirectories);
                }              

                gvwArchivos.DataSource = oArrFileInfo;
                gvwArchivos.DataBind();

            }
            catch (Exception ex)
            {

            }
        }
    }
}