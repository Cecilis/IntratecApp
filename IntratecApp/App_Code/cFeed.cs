using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.ServiceModel.Syndication;
using System.Xml;

namespace IntraTecApp
{
    public class cFeed
    {
        private static string sBDIntraTec = "BD_IntraTec";

        public int IDFeed { get; private set; }
        public string URLFeed { get; set; }
        public string TipoFeed { get; private set; }
        public SyndicationFeed SyndicationFeeds { get; set; }              

        public cFeed()
        {
            IDFeed = 0;
            URLFeed = String.Empty;
            TipoFeed = string.Empty;
        }

        public cFeed(int pID, string pURL, string pTipoFeed)
        {
            
            IDFeed = pID;
            URLFeed = pURL;
            TipoFeed = pTipoFeed;
            ObtenerSyndicationFeed();  
        }

        private void Cargar(SqlDataReader pSqlDataReader)
        {
            try
            {
                ObtenerSyndicationFeed();                
                IDFeed = (int)pSqlDataReader.GetSqlInt32(0);
                URLFeed = ((string)pSqlDataReader.GetSqlString(1)).Trim().ToUpperInvariant();                
                TipoFeed = ((string)pSqlDataReader.GetSqlString(2)).Trim().ToUpperInvariant();                
            }
            catch (Exception ex)
            {
            }       
        }

        private void ObtenerSyndicationFeed()
        {
            try
            {

                XmlReaderSettings settings = new XmlReaderSettings
                {
                    IgnoreWhitespace = true,
                    CheckCharacters = true,
                    CloseInput = true,
                    IgnoreComments = true,
                    IgnoreProcessingInstructions = true,
                    XmlResolver = null,
                   // DtdProcessing = DtdProcessing.Parse() // --> originalmente en Prohibit.NET 4.0 option
                };

                if (String.IsNullOrEmpty(URLFeed))
                {
                    TipoFeed = null;
                    return;
                }

                using (XmlReader reader = XmlReader.Create(URLFeed, settings))
                {
                    if (reader.ReadState == ReadState.Initial)
                        reader.MoveToContent();

                    //Se intenta leer en el formato ATOM 10
                    Atom10FeedFormatter oAtom10FeedFormatter = new Atom10FeedFormatter();
                    if (oAtom10FeedFormatter.CanRead(reader))
                    {
                        oAtom10FeedFormatter.ReadFrom(reader);
                        SyndicationFeeds = oAtom10FeedFormatter.Feed;
                        return;
                    }

                    Rss20FeedFormatter oRss20FeedFormatter = new Rss20FeedFormatter();
                    // Se intenta leer en el formato RSS 20
                    if (oRss20FeedFormatter.CanRead(reader))
                    {
                        oRss20FeedFormatter.ReadFrom(reader);
                        SyndicationFeeds = oRss20FeedFormatter.Feed;
                        return;
                    }
                    SyndicationFeeds = null;
                }
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public bool Existe(string pURLFeed)
        {
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            bool bExiste = false;

            String sProcAlmacenadoBE = "spBuscarEmpleado";
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter oIDataParameter;
                oIDataParameter = new SqlParameter("@pURLFeed", pURLFeed);
                ListaParametros.Add(oIDataParameter);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenadoBE, ListaParametros);

                if (oSqlDataReader.HasRows)
                {
                    if (oSqlDataReader.Read())
                    {
                        bExiste = true;
                        Cargar(oSqlDataReader);                       
                    }
                }
                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                return bExiste;
            }
            catch (Exception ex) {
                throw new Exception("Error al consultar. Detalles: " + ex.Message.ToString());
            }
        }

        public void Crear()
        {
            String sProcAlmacenado;
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;

            try
            {
                sProcAlmacenado = "spIncluirURLFeed";
                int IDURLFeed = 0;

                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter idpIDURLFeed;
                idpIDURLFeed = new SqlParameter("@IDURLFeed", IDURLFeed);
                idpIDURLFeed.Direction = ParameterDirection.Output;
                ListaParametros.Add(idpIDURLFeed);

                System.Data.IDataParameter idpURLFeed;
                idpURLFeed = new SqlParameter("@URLFeed", URLFeed);
                ListaParametros.Add(idpURLFeed);

                System.Data.IDataParameter idpTipoFeed;
                idpTipoFeed = new SqlParameter("@TipoFeed", TipoFeed);
                ListaParametros.Add(idpTipoFeed);                                                        
                
                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                IDFeed = int.Parse(idpIDURLFeed.Value.ToString());

                ListaParametros.Clear();
                oSqlDataReader.Close();
                oConBDIntraTec.closeConnection();

            }
            catch (Exception ex)
            {
                throw ex;
            }
       }

        public bool Modificar()
        {
            try
            {
                string sProcAlmacenado;
                List<IDataParameter> ListaParametros = new List<IDataParameter>();
                SqlDataReader oSqlDataReader;
                int intTotalFilas = 0;
                bool bActualizado = false;

                sProcAlmacenado = "spModificarURLFeed";

                System.Data.IDataParameter idpIDURLFeed;
                idpIDURLFeed = new SqlParameter("@IDFeed", IDFeed);
                ListaParametros.Add(idpIDURLFeed);

                System.Data.IDataParameter idpURLFeed;
                idpURLFeed = new SqlParameter("@URLFeed", URLFeed);
                ListaParametros.Add(idpURLFeed);

                System.Data.IDataParameter idpTotalFilas;
                idpTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);
                ListaParametros.Add(idpTotalFilas);

                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                intTotalFilas = int.Parse(idpTotalFilas.Value.ToString());
                if (intTotalFilas > 0)
                {
                    bActualizado = true;
                }

                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                return bActualizado;
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public bool Eliminar()
        {
            try
            {
                string sProcAlmacenado;
                List<IDataParameter> ListaParametros = new List<IDataParameter>();
                SqlDataReader oSqlDataReader;
                int intTotalFilas = 0;
                bool bActualizado = false;

                sProcAlmacenado = "spEliminarURLFeed";

                System.Data.IDataParameter idpIDURLFeed;
                idpIDURLFeed = new SqlParameter("@IDURLFeed", IDFeed);
                ListaParametros.Add(idpIDURLFeed);

                System.Data.IDataParameter idpTotalFilas;
                idpTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);
                ListaParametros.Add(idpTotalFilas);

                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                intTotalFilas = int.Parse(idpTotalFilas.Value.ToString());
                if (intTotalFilas > 0)
                {
                    bActualizado = true;
                }

                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                return bActualizado;
            }
            catch (Exception ex) {
                throw ex;
            }

        }
    }
}