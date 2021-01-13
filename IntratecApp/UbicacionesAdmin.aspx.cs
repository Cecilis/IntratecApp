using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Web.Configuration;
using System.Globalization;



namespace IntraTecApp
{
    public partial class UbicacionesAdmin : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Accesos"]  == null)
                Response.Redirect("LogOut.aspx");

            if (!IsPostBack)
            {
                ObtenerListaCultureInfo();
                ObtenerClaves();
            }
        }

        public void ObtenerClaves() { 
            ddlLenguajePais.SelectedValue = cConfiguracion.ObtenerAppSettings("CultureInfo");
            txtNombreComercial.Text = cConfiguracion.ObtenerAppSettings("OrganizacionNombreComercial");
            txtNombreLegal.Text =  cConfiguracion.ObtenerAppSettings("OrganizacionNombreLegal");
            txtSiglas.Text=  cConfiguracion.ObtenerAppSettings("OrganizacionSiglas");
            txtNroRegxFeeds.Text = cConfiguracion.ObtenerAppSettings("NumRegxFeeds");
            txtRSSEmail.Text = cConfiguracion.ObtenerAppSettings("RSSEmail");
            txtNroCtaGoogle.Text = cConfiguracion.ObtenerAppSettings("CuentaGoogle");
            txtUsuarioTwitter.Text = cConfiguracion.ObtenerAppSettings("UsuarioTwitter");
            txtCuentaFaceBook.Text = cConfiguracion.ObtenerAppSettings("PaginaFB");
            txtUbicGalleriaImgenes.Text = cConfiguracion.ObtenerAppSettings("CarpetaImagenesGaleria");
            txtUbicDocumentos.Text = cConfiguracion.ObtenerAppSettings("CarpetaDocumentos");
            txtUbicNormativas.Text = cConfiguracion.ObtenerAppSettings("CarpetaNormativas");
            txtUbicProcedimientos.Text = cConfiguracion.ObtenerAppSettings("CarpetaProcedimientos");
            txtUbicManuales.Text = cConfiguracion.ObtenerAppSettings("CarpetaManuales");
            txtUbicReportes.Text = cConfiguracion.ObtenerAppSettings("CarpetaReportes");   

            txtAppOnBase.Text = cConfiguracion.ObtenerAppSettings("AppOnBase");
            txtAppAssist.Text = cConfiguracion.ObtenerAppSettings("AppAssist");
            txtAppQlickView.Text = cConfiguracion.ObtenerAppSettings("AppQlickView");
            txtAppMasterData.Text = cConfiguracion.ObtenerAppSettings("AppMasterData"); 
            txtAppCorreoElectronico.Text = cConfiguracion.ObtenerAppSettings("AppCorreoElectronico");
        }

        public void ObtenerListaCultureInfo () 
        {
            ListItem oListItem = new ListItem("", "");
            ddlLenguajePais.Items.Clear();
            ddlLenguajePais.Items.Add(oListItem);
            ddlLenguajePais.SelectedIndex = 0;

            CultureInfo[] oCultureInfoArr = CultureInfo.GetCultures(CultureTypes.AllCultures);
            foreach (CultureInfo oCultureInfo in oCultureInfoArr)
            {
                try
                {
                    oListItem = new ListItem(CultureInfo.CreateSpecificCulture(oCultureInfo.Name).Name.ToString().PadRight(10) + " - " + oCultureInfo.DisplayName.ToString().PadLeft(100), CultureInfo.CreateSpecificCulture(oCultureInfo.Name).Name.ToString());
                    ddlLenguajePais.Items.Add(oListItem);
                }
                    catch(Exception) {
                }
           } 
  
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                cConfiguracion.EditarAppSettings("Culture", ddlLenguajePais.SelectedValue.ToString());
                cConfiguracion.EditarAppSettings("CultureInfo", ddlLenguajePais.SelectedValue.ToString());
                cConfiguracion.EditarAppSettings("OrganizacionNombreComercial", txtNombreComercial.Text);
                cConfiguracion.EditarAppSettings("OrganizacionNombreLegal", txtNombreLegal.Text);
                cConfiguracion.EditarAppSettings("OrganizacionSiglas", txtSiglas.Text);
                cConfiguracion.EditarAppSettings("NumRegxFeeds", txtNroRegxFeeds.Text);
                cConfiguracion.EditarAppSettings("RSSEmail", txtRSSEmail.Text);
                cConfiguracion.EditarAppSettings("CuentaGoogle", txtNroCtaGoogle.Text);
                cConfiguracion.EditarAppSettings("UsuarioTwitter", txtUsuarioTwitter.Text);
                cConfiguracion.EditarAppSettings("PaginaFB", txtCuentaFaceBook.Text);
                cConfiguracion.EditarAppSettings("CarpetaImagenesGaleria", txtUbicGalleriaImgenes.Text);
                cConfiguracion.EditarAppSettings("CarpetaDocumentos", txtUbicDocumentos.Text);
                cConfiguracion.EditarAppSettings("CarpetaNormativas", txtUbicNormativas.Text);
                cConfiguracion.EditarAppSettings("CarpetaProcedimientos", txtUbicProcedimientos.Text);
                cConfiguracion.EditarAppSettings("CarpetaManuales", txtUbicManuales.Text);
                cConfiguracion.EditarAppSettings("CarpetaReportes", txtUbicReportes.Text);
                cConfiguracion.EditarAppSettings("AppOnBase", txtAppOnBase.Text);
                cConfiguracion.EditarAppSettings("AppQlickView", txtAppQlickView.Text);
                cConfiguracion.EditarAppSettings("AppAssist", txtAppAssist.Text);
                cConfiguracion.EditarAppSettings("AppCorreoElectronico", txtAppCorreoElectronico.Text);
                cConfiguracion.EditarAppSettings("AppMasterData", txtAppMasterData.Text);

                ObtenerClaves();
                lblResultado.CssClass = "Resultado";
                lblResultado.Text = "Actualización Exitosa";
            }
            catch (Exception ex) {
                lblResultado.CssClass = "EResultado";
                lblResultado.Text = "Error al actualizar parámetros: " + ex.Message.ToString();
            }
        }

        protected void txtUbicManuales_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtAppAssist_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
