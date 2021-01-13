using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace IntraTecApp
{
    public class cURLFeedsMetodos
    {
        private static string sBDIntraTec = "BD_IntraTec";

        public static List<cURLFeeds> ObtenerTodosActivos(int intNroIntentosMaximos, cConexionDatosGenerica oConexionDatosGenerica = null)
        { 
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spURLFeedsBuscarNRegistros";   
            List<cURLFeeds> lstURLFeeds = new List<cURLFeeds>();
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            bool bTransaccionActiva = false;
            cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);

            try
            {

                if (oConexionDatosGenerica == null)
                    oConBDIntraTec.getConnection(sBDIntraTec);
                else
                {
                    oConBDIntraTec = oConexionDatosGenerica;
                    bTransaccionActiva = true;
                }


                System.Data.IDataParameter idpintNroIntentosMaximos;
                idpintNroIntentosMaximos = new SqlParameter("@NroRegistros", intNroIntentosMaximos);
                ListaParametros.Add(idpintNroIntentosMaximos);

                if (bTransaccionActiva)
                    oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReaderWithTransaction(sProcAlmacenado, ListaParametros);
                else
                    oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                if (oSqlDataReader.HasRows)
                {
                    while (oSqlDataReader.Read())
                    {
                        cURLFeeds oURLFeeds = new cURLFeeds();
                        oURLFeeds.IDURLFeed = (int)oSqlDataReader["IDURLFeed"];
                        oURLFeeds.Titulo = (string)oSqlDataReader["Titulo"];
                        oURLFeeds.URLFeed = (string)oSqlDataReader["URLFeed"];
                        oURLFeeds.TipoFeed = (string)oSqlDataReader["TipoFeed"];
                        oURLFeeds.Propietario = (string)oSqlDataReader["Propietario"];
                        oURLFeeds.Estado = (string)oSqlDataReader["Estado"];
                        lstURLFeeds.Add(oURLFeeds);
                    }
                }
                oSqlDataReader.Close();
                if (!bTransaccionActiva)
                    oConBDIntraTec.closeConnection();

                return lstURLFeeds;
            }
            catch (Exception ex)
            {
                throw ex;
            }        
        }
    }
}