using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntraTecApp
{
    public partial class FeedAdmin : System.Web.UI.Page
    {

        private static string sBDIntraTec = "BD_IntraTec";

       protected void Page_Load(object sender, System.EventArgs e)
        {
            if (!IsPostBack)
            {
                txtURLFeed.Attributes.Add("onblur", this.Page.ClientScript.GetPostBackEventReference(this.btnTextBoxEventHandler, ""));
                CargarCanalesActuales();
                
            }
        }

       protected void btnTextBoxEventHandler_Click(object sender, EventArgs e)
       {
           txtTituloFeeds.Value = "";
           ddlTipoFeed.ClearSelection();
           rblPropiedad.ClearSelection();
           rblEstado.ClearSelection();
           flsDetalleFeeds.Visible = false;
           hdnIDFeedActual.Value = "";
           lblMensaje.Text = "";
       }

       protected void btnGuardar_Click(object sender, EventArgs e)
       {
          
           SqlDataReader oSqlDataReader;
           string strProcAlmacenado = "";
           string strAccion = "";

           int intNumRegxFeeds = Int32.Parse(cConfiguracion.ObtenerAppSettings("NumRegxFeeds"));

           lblMensaje.Text = "";

           if ((hdnIDFeedActual.Value.Trim() == "") ||(hdnIDFeedActual.Value.Trim() == "0"))
           {
               strProcAlmacenado = "spURLFeedsIncluir";
               strAccion = "I";
               hdnIDFeedActual.Value = "0";
           }
           else
           {
               strProcAlmacenado = "spURLFeedsModificar";
               strAccion = "M";
           }
           
           cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
           List<IDataParameter> ListaParametros = new List<IDataParameter>();

           try
           {

               oConBDIntraTec.getConnection(sBDIntraTec);

               oConBDIntraTec.setTransaction();

               System.Data.IDataParameter idpTitulo;
               idpTitulo = new SqlParameter("@Titulo", txtTituloFeeds.Value.ToString().Trim());
               ListaParametros.Add(idpTitulo);

               System.Data.IDataParameter idpURLFeed;
               idpURLFeed = new SqlParameter("@URLFeed", txtURLFeed.Value.ToString().Trim());
               ListaParametros.Add(idpURLFeed);

               System.Data.IDataParameter idpTipoFeed;
               idpTipoFeed = new SqlParameter("@TipoFeed", ddlTipoFeed.SelectedValue);
               ListaParametros.Add(idpTipoFeed);

               System.Data.IDataParameter idpPropietario;
               idpPropietario = new SqlParameter("@Propietario", rblPropiedad.SelectedValue);
               ListaParametros.Add(idpPropietario);

               if (strAccion == "M")
               {
                   System.Data.IDataParameter idpEstado;
                   idpEstado = new SqlParameter("@Estado", rblEstado.SelectedValue);
                   ListaParametros.Add(idpEstado);
               }

               int intIDURLFeed = Int32.Parse(hdnIDFeedActual.Value.Trim());
               System.Data.IDataParameter idpIDURLFeed;
               idpIDURLFeed = new SqlParameter("@IDURLFeed", intIDURLFeed);

               int intTotalFilas = 0;
               System.Data.IDataParameter idpTotalFilas;
               idpTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);
               
               if (strAccion == "I")
               {
                   idpIDURLFeed.Direction = ParameterDirection.Output;
                   ListaParametros.Add(idpIDURLFeed);
               }
               else
               {
                   ListaParametros.Add(idpIDURLFeed);

                   idpTotalFilas.Direction = ParameterDirection.Output;
                   ListaParametros.Add(idpTotalFilas);
               }

               oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReaderWithTransaction(strProcAlmacenado, ListaParametros);

               int intResultado = 0;
               string strMensaje = "";

               switch (strAccion)
               {
                    case "I":
                        intResultado = Int32.Parse(idpIDURLFeed.Value.ToString());
                        hdnIDFeedActual.Value = intResultado.ToString();
                        strMensaje = "Canal Agregado.";
                    break;
                    case "M":
                        intResultado = Int32.Parse(idpTotalFilas.Value.ToString());
                        strMensaje = "Canal Actualizado.";
                    break;
                    default:
                        throw new Exception("");
               }

               if (intResultado <= 0)
                   throw new Exception("No se pudo ejecutar la transacción.");

               ListaParametros.Clear();
               oSqlDataReader = null;

                int intTotalActivos = 0;
                ContadorActivosActuales(ref intTotalActivos);

                if (intTotalActivos > intNumRegxFeeds)
                    throw new Exception("Ha superado el limite máximo de feeds que puede mostrar.");
                else
                    CargarCanalesActuales(oConBDIntraTec);

               oConBDIntraTec.executeTransaction(true);

               oConBDIntraTec.closeConnection();

               lblMensaje.Attributes.Add("class", "Resultado");
               lblMensaje.Text = strMensaje;

               udpFeedAdmin.Update();

           }
           catch (Exception ex)
           {
               oConBDIntraTec.executeTransaction(false);
               lblMensaje.Attributes.Add("class", "EResultado");
               lblMensaje.Text = "Error: Actualizando datos canal Rss/Atom. Detalles: " + ex.Message.ToString();
           }
           finally {
               ListaParametros.Clear();
               oSqlDataReader = null;
               oConBDIntraTec.closeConnection();           
           }
       }

       protected void btnEliminar_Click(object sender, EventArgs e)
       { 

           SqlDataReader oSqlDataReader;
           string strProcAlmacenado = "";

           lblMensaje.Text = "";

           strProcAlmacenado = "spURLFeedsEliminar";

           cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
           List<IDataParameter> ListaParametros = new List<IDataParameter>();

           try
           {
               
                oConBDIntraTec.getConnection(sBDIntraTec);

                if (hdnIDFeedActual.Value.Trim() == "")
                    throw new Exception("Debe seleccionar un canal.");

                int intIDURLFeed = Int32.Parse(hdnIDFeedActual.Value);
                System.Data.IDataParameter idpIDURLFeed;
                idpIDURLFeed = new SqlParameter("@IDURLFeed", intIDURLFeed);
                ListaParametros.Add(idpIDURLFeed);

                int intTotalFilas = 0;
                System.Data.IDataParameter idpTotalFilas;
                idpTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);
                idpTotalFilas.Direction = ParameterDirection.Output;
                ListaParametros.Add(idpTotalFilas);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(strProcAlmacenado, ListaParametros);

                int intResultado = 0;
                string strMensaje = "";

                txtTituloFeeds.Value = "";
                txtURLFeed.Value = "";
                ddlTipoFeed.ClearSelection();
                rblEstado.ClearSelection();
                rblPropiedad.ClearSelection();

                intResultado = Int32.Parse(idpTotalFilas.Value.ToString());
                strMensaje = "Canal Eliminado.";

                if (intResultado <= 0)
                throw new Exception("No se pudo ejecutar la transacción.");

                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();

                hdnIDFeedActual.Value = "";

                CargarCanalesActuales();

                lblMensaje.Attributes.Add("class", "EResultado");
                lblMensaje.Text = strMensaje;

                udpFeedAdmin.Update();
           }
           catch (Exception ex)
           {
               lblMensaje.Attributes.Add("class", "EResultado");
               lblMensaje.Text = "Error: Eliminando datos canal Rss/Atom." + Environment.NewLine + "Detalles: " + ex.Message.ToString();
           }
           finally
           {
               ListaParametros.Clear();
               oSqlDataReader = null;
               oConBDIntraTec.closeConnection();
           }
       }

       private void CargarCanalesActuales(cConexionDatosGenerica oConexionDatosGenerica = null)
       {
           List<cURLFeeds> lstURLFeeds = new List<cURLFeeds>();
           lstURLFeeds = cURLFeedsMetodos.ObtenerTodosActivos(100, oConexionDatosGenerica); 
        
           lblMensaje.Text = "";
           flsDetalleFeeds.Visible = false;

           if (lstURLFeeds != null)
           {
               this.tvwRSSFeeds.Nodes.Clear();

               foreach (cURLFeeds oURLFeedsTemp in lstURLFeeds)
               {
                   try
                   {
                       if (oURLFeedsTemp.URLFeed.ToString() != null)
                       {
                           string strTexto = oURLFeedsTemp.Titulo;
                           string strValor = oURLFeedsTemp.IDURLFeed.ToString().Trim() + "|" + oURLFeedsTemp.Titulo.ToString().Trim() + "|" + oURLFeedsTemp.URLFeed.ToString().Trim() + "|" + oURLFeedsTemp.Propietario.ToString().Trim() + "|" + oURLFeedsTemp.TipoFeed.ToString().Trim() + "|" + oURLFeedsTemp.Estado.ToString().Trim();

                           TreeNode oTreeNode = new TreeNode(strTexto, strValor);
                           if (oURLFeedsTemp.Estado.ToString().Trim() == "1")
                               
                           this.tvwRSSFeeds.Nodes.Add(oTreeNode);
                       }
                   }
                   catch (Exception ex)
                   {
                       throw;
                   }
               }
           }
           Session["lstURLFeeds"] = lstURLFeeds;

           udpFeedAdmin.Update();
       }

       public void ContadorActivosActuales(ref int intActivos)
       {
           intActivos = 0;
           foreach (TreeNode oTreeNode in tvwRSSFeeds.Nodes)
           {
               string Valores = oTreeNode.Value;

               string[] oArrValores = Valores.Split('|');

               if (oArrValores[5].Trim() == "1")
                   intActivos = intActivos + 1;

           }
       }

       protected void tvwRSSFeeds_SelectedNodeChanged(object sender, System.EventArgs e)
       {
           try
           {
               List<cURLFeeds> lstURLFeeds = new List<cURLFeeds>();

               lstURLFeeds = (List<cURLFeeds>)Session["lstURLFeeds"];

               string strValores = tvwRSSFeeds.SelectedNode.Value.ToString();

               string[] arrValores = strValores.Split('|');
               hdnIDFeedActual.Value = arrValores[0];
               txtTituloFeeds.Value = arrValores[1];
               txtURLFeed.Value = arrValores[2];
               ddlTipoFeed.SelectedValue = arrValores[4].Trim();
               rblPropiedad.SelectedValue = arrValores[3].Trim();
               rblEstado.SelectedValue = arrValores[5].Trim();

               flsDetalleFeeds.Visible = true;

               ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "BuscarFeedsScript", "BuscarFeed();", true);

               udpFeedAdmin.Update();
           }
           catch (Exception ex)
           {
               lblMensaje.Attributes.Add("class", "EResultado");
               lblMensaje.Text = "Error: cargando canales Rss/Atom." + Environment.NewLine + "Detalles: " + ex.Message.ToString();
           }
       }

    }
}
