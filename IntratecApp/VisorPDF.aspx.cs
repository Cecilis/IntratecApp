using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Net;

namespace IntraTecApp
{
    public partial class VisorPDF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strNombreArchivo = Request.QueryString["filename"];
            string strRuta = Request.QueryString["path"];

            DirectoryInfo oDirectoryInfo = new DirectoryInfo(strRuta);
            
            lblNombreArchivo.Text = Path.GetFileNameWithoutExtension(strNombreArchivo);

            string strRutaArchivo = "DocumentoPDF.aspx?RutaArchivo=" + Path.Combine(oDirectoryInfo.FullName, strNombreArchivo);

            hlkPDFViewer.NavigateUrl = strRutaArchivo; // oDistrRutaArchivorectoryInfo.Name + "/" + strNombreArchivo + "#toolbar=0&navpanes=0&scrollbar=0&messages=0";

            //pvwVerPDF.FilePath = strRutaArchivo;
            ifrmVisorPDF.Attributes.Add("src", strRutaArchivo);

        }
    }
}