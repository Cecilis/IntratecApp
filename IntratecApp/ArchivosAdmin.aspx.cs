using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Configuration;
using System.Configuration;

namespace IntraTecApp
{
    public partial class ArchivosAdmin : System.Web.UI.Page
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
            if (Session["Accesos"]  == null)
                Response.Redirect("LogOut.aspx");

            if (!IsPostBack)
            {
                lblResultados.Text = "";
                hdnUbicacion.Value = "";

                gvwArchivos.DataSource = null;
                gvwArchivos.DataBind();

                rblUbicacion.SelectedIndex = 0;
                rblUbicacion_SelectedIndexChanged(null, e: null);
            }

            if(!string.IsNullOrEmpty(hdnUbicacion.Value.ToString().Trim()))
            {
                rblUbicacion.SelectedValue = hdnUbicacion.Value;
            }
        }

        protected void gvwArchivos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            try
            {
                lblResultados.Text = "";
                LinkButton oLinkButton = e.Row.FindControl("lnkEliminar") as LinkButton;
                if (oLinkButton != null)
                {
                    if(ScriptManager.GetCurrent(this).Controls.Contains(oLinkButton))
                        smgArchivosAdmin.RegisterPostBackControl(oLinkButton);         
                }
            }
            catch (Exception ex)
            {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = ex.Message.ToString();
            }
        }  

        protected void gvwArchivos_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                lblResultados.Text = "";

                LinkButton oLinkButton = e.Row.FindControl("lnkDownload") as LinkButton;
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    smgArchivosAdmin.RegisterPostBackControl(oLinkButton);         
                }

                oLinkButton = e.Row.FindControl("lnkEliminar") as LinkButton;
                if (e.Row.RowType == DataControlRowType.DataRow)
                {
                    smgArchivosAdmin.RegisterPostBackControl(oLinkButton);
                }
            }
            catch (Exception ex)
            {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = ex.Message.ToString();
            }
        }

        protected void UploadFile(object sender, EventArgs e)
        {
            try
            {
                lblResultados.Text = "";

                string strRuta = string.Empty;
                string strOpcion = rblUbicacion.SelectedValue.ToString().Trim();

                if (rblUbicacion.SelectedValue != null)
                {
                    switch (rblUbicacion.SelectedValue)
                    {
                        case "G":
                            strRuta = Server.MapPath(ConfigurationManager.AppSettings["CarpetaImagenesGaleria"].ToString());
                            break;
                        case "N":
                            strRuta = ConfigurationManager.AppSettings["CarpetaNormativas"].ToString();
                            break;
                        case "P":
                            strRuta = ConfigurationManager.AppSettings["CarpetaProcedimientos"].ToString();
                            break;
                        case "D":
                            strRuta = ConfigurationManager.AppSettings["CarpetaDocumentos"].ToString();
                            break;
                        case "M":
                            strRuta = ConfigurationManager.AppSettings["CarpetaManuales"].ToString();
                            break;
                        case "R":
                            strRuta = ConfigurationManager.AppSettings["CarpetaReportes"].ToString();
                            break;
                        default:
                            throw new Exception("Debe seleccionar una Ubicación para el archivo.");
                    }

                    string NombreArchivo = Path.GetFileName(fulReportes.PostedFile.FileName);
                    if (string.IsNullOrEmpty(NombreArchivo))
                        throw new Exception("No ha seleccionado un archivo.");

                    string RutaCompleta = Path.Combine(strRuta, NombreArchivo);
                    fulReportes.PostedFile.SaveAs(RutaCompleta);
                    Response.Redirect(Request.Url.AbsoluteUri);

                    udpArchivosAdmin.Update();
                }
                else
                {
                    lblResultados.CssClass = "EResultado";
                    lblResultados.Text = "Debe indicar el tipo de archivo a subir.";
                }

            }
            catch (Exception ex)
            {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = ex.Message.ToString();
            }

        }

        protected void DownloadFile(object sender, EventArgs e)
        {
            try
            {
                lblResultados.Text = "";
                string strRutaCompleta = (sender as LinkButton).CommandArgument;
                Response.ContentType = ContentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + Path.GetFileName(strRutaCompleta));
                Response.TransmitFile(strRutaCompleta);
                Response.End();
            }
            catch (Exception ex)
            {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = ex.Message.ToString();
            }
        }

        protected void DeleteFile(object sender, EventArgs e)
        {
            try
            {
                lblResultados.Text = "";

                string filePath = (sender as LinkButton).CommandArgument;
                File.Delete(filePath);
                rblUbicacion_SelectedIndexChanged(null, e: null);
                udpArchivosAdmin.Update();
            }
            catch (Exception ex)
            {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = ex.Message.ToString();
            }
        }

        protected void rblUbicacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                lblResultados.Text = "";

                string strRuta = "";
                if (rblUbicacion.SelectedValue != null)
                {
                    switch (rblUbicacion.SelectedValue)
                    {
                        case "G":
                            strRuta = Server.MapPath(ConfigurationManager.AppSettings["CarpetaImagenesGaleria"].ToString());
                            break;
                        case "N":
                            strRuta = ConfigurationManager.AppSettings["CarpetaNormativas"].ToString();
                            break;
                        case "P":
                            strRuta = ConfigurationManager.AppSettings["CarpetaProcedimientos"].ToString();
                            break;
                        case "D":
                            strRuta = ConfigurationManager.AppSettings["CarpetaDocumentos"].ToString();
                            break;
                        case "M":
                            strRuta = ConfigurationManager.AppSettings["CarpetaManuales"].ToString();
                            break;
                        case "R":
                            strRuta = ConfigurationManager.AppSettings["CarpetaReportes"].ToString();
                            break;
                    }

                    gvwArchivos.DataSource = null;
                    gvwArchivos.DataBind();

                    lblNombreCarpeta.InnerText = rblUbicacion.SelectedItem.ToString().Trim();
                    string[] filePaths = Directory.GetFiles(@strRuta);
                    List<ListItem> files = new List<ListItem>();
                    foreach (string filePath in filePaths)
                    {
                        files.Add(new ListItem(Path.GetFileName(filePath), filePath));
                    }
                    gvwArchivos.DataSource = files;
                    gvwArchivos.DataBind();

                    udpArchivosAdmin.Update();
                }
            }
            catch (Exception ex)
            {
                lblResultados.CssClass = "EResultado";
                lblResultados.Text = ex.Message.ToString();
            }
        }
    }
}