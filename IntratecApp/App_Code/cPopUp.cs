using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace IntraTecApp
{
    public class cPopUp
    {

        private static string sBD_IntraTec = "BD_IntraTec";

        public int IDPopUp { get; set; }
        public string Titulo { get; set; }
        public string TituloNoHTML{ get; set; }
        public string Contenido { get; set; }
        public DateTime FechaDesde { get; set; }
        public DateTime FechaHasta { get; set; }
        public byte[] ImgFondo { get; set; }
        public string NombreImagenFondo { get; set; }
        public int ImgFondoLong { get; set; }
        public string Status { get; set; }
        public string Enlace{ get; set; }    

        private void Cargar(SqlDataReader oSqlDataReader)
        {
            IDPopUp = (int)oSqlDataReader.GetSqlInt32(0);
            Titulo = ((string)oSqlDataReader.GetSqlString(1)).Trim();
            TituloNoHTML = cFunciones.QuitarHTML(Titulo);
            Contenido = ((string)oSqlDataReader.GetSqlString(2)).Trim();
            FechaDesde = oSqlDataReader.GetDateTime(3);
            FechaHasta = oSqlDataReader.GetDateTime(4);


            if (oSqlDataReader[5] != DBNull.Value)
            {
                ImgFondo = (byte[])oSqlDataReader[5];
                NombreImagenFondo = ((string)oSqlDataReader.GetSqlString(6)).Trim().ToUpperInvariant();
                ImgFondoLong = (int)oSqlDataReader.GetInt32(7);
            }
            else {
                ImgFondo = null;
                NombreImagenFondo = String.Empty;
                ImgFondoLong = 0;               
            }
            Status = ((string)oSqlDataReader.GetSqlString(8)).Trim().ToUpperInvariant();
        }

        public bool ExisteMensaje(string pIDPopUp)
        {
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            bool bExisteMensaje = false;

            String sProcAlmacenadoBPUT = "spBuscarPopUpxID";
            try
            {
                lock ("Bloqueo")
                {
                    cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                    oConBDIntraTec.getConnection(sBD_IntraTec);

                    System.Data.IDataParameter oIDataParameter;

                    oIDataParameter = new SqlParameter("@IDPopUp", pIDPopUp);
                    ListaParametros.Add(oIDataParameter);

                    oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenadoBPUT, ListaParametros);

                    if (oSqlDataReader.HasRows)
                    {
                        if (oSqlDataReader.Read())
                        {
                            bExisteMensaje = true;
                            Cargar(oSqlDataReader);
                        }
                    }

                    ListaParametros.Clear();
                    oSqlDataReader = null;
                    oConBDIntraTec.closeConnection();
                    return bExisteMensaje;
                }
            }
            catch (Exception ex)
            {
                throw new Exception("Error al consultar datos de PopUp. Detalles: " + ex.Message.ToString());
            }
        }

        public DataSet BuscarMensajes()
        {
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            DataSet oDataSet = new DataSet();

            String sProcAlmacenadoBPUT = "spBuscarPopUpTodos";
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBD_IntraTec);
                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenadoBPUT, ListaParametros);
                oDataSet.Load(oSqlDataReader, LoadOption.OverwriteChanges, new string[] { "PopUp" });
                if (!oSqlDataReader.IsClosed) {
                    oSqlDataReader.Close();
                }
                oConBDIntraTec.closeConnection();
                return oDataSet;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al consultar datos de PopUp. Detalles: " + ex.Message.ToString());
            }
        }

        public void ActualizarMensajePopUp(string strAccion, ref string strResultados)
        {
            String sProcAlmacenado;
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            int intTotalFilas = 0;

            try
            {
                if (strAccion == "I")
                {
                    sProcAlmacenado = "spIncluirPopUp";
                }
                else if (strAccion == "M")
                {
                    sProcAlmacenado = "spModificarPopUp";
                }
                else if (strAccion == "E")
                {
                    sProcAlmacenado = "spEliminarPopUp";
                }
                else
                {
                    throw new Exception("800 - Tipo de Acción no definida.");
                }

                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBD_IntraTec);

                System.Data.IDataParameter oIDataParameter;

                oIDataParameter = new SqlParameter("@Titulo", Titulo);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@Contenido", Contenido);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@FechaDesde", FechaDesde);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@FechaHasta", FechaHasta);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@ImgFondo", ImgFondo);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@NombreImagenFondo", NombreImagenFondo);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@ImgFondoLong", ImgFondoLong);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@Status", Status);
                ListaParametros.Add(oIDataParameter);
                oIDataParameter = new SqlParameter("@IDPopUp", IDPopUp);
                ListaParametros.Add(oIDataParameter);

                if ((strAccion == "M") || (strAccion == "E"))
                {
                    oIDataParameter = new SqlParameter("@TotalFilas", intTotalFilas);
                    oIDataParameter.Direction = ParameterDirection.Output;
                    ListaParametros.Add(oIDataParameter);
                }

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                if (oSqlDataReader.HasRows)
                {
                    while (oSqlDataReader.Read())
                    {
                        if (strAccion == "I")
                        {
                            IDPopUp = oSqlDataReader.GetInt32(0);
                        }
                        else if ((strAccion == "M") || (strAccion == "E"))
                        {
                            intTotalFilas = oSqlDataReader.GetInt32(0);
                        }
                    }
                }

                ListaParametros.Clear();
                oSqlDataReader.Close();
                oConBDIntraTec.closeConnection();
                strResultados = "OK";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public bool MensajesActivos()
        {
            SqlDataReader oSqlDataReader;
            string sProcAlmacenadoBMA = "spBuscarPopUpRandom";
            bool bMensajesActivos = false;
            try
            {
                SqlConnection oSqlConnection = new SqlConnection();
                oSqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings[sBD_IntraTec].ToString();

                oSqlConnection.Open();

                SqlCommand oSqlCommand = new SqlCommand();
                oSqlCommand.Connection = oSqlConnection;
                oSqlCommand.CommandType = CommandType.StoredProcedure;
                oSqlCommand.CommandText = sProcAlmacenadoBMA;

                oSqlDataReader = oSqlCommand.ExecuteReader();

                if (oSqlDataReader.HasRows)
                {
                    if (oSqlDataReader.Read())
                    {
                        bMensajesActivos = true;
                        Cargar(oSqlDataReader);
                    }
                }
                oSqlDataReader = null;
                oSqlConnection.Close();
                return bMensajesActivos;
            }
            catch (Exception ex)
            {
                 throw ex;
            }

        }

        public DataTable MensajesAutoComplete(string strPrefijo) {
            DataTable oDataTable = new DataTable();
            SqlDataReader oSqlDataReader;
            string sProcAlmacenado = "spBuscarPopUpTodosAutoComplete";

            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                List<IDataParameter> ListaParametros = new List<IDataParameter>();
                System.Data.IDataParameter oIDataParameter;

                oIDataParameter = new SqlParameter("@Titulo", "%" + strPrefijo + "%");
                ListaParametros.Add(oIDataParameter); 
                
                oConBDIntraTec.getConnection(sBD_IntraTec);
                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);
                oDataTable.Load(oSqlDataReader);
                
                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();

                return oDataTable;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        
        }
    }
}