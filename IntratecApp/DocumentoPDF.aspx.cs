using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Net;

namespace IntraTecApp
{
    public partial class DocumentoPDF : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string strRutaArchivo = Request.QueryString["RutaArchivo"];

            WebClient client = new WebClient();
            Byte[] buffer = client.DownloadData(strRutaArchivo);
            Response.ContentType = "application/pdf";
            Response.AddHeader("content-length", buffer.Length.ToString());
            Response.BinaryWrite(buffer);

        }
    }
}