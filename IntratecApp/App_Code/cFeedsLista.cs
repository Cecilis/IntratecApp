using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace IntraTecApp
{
    public class cFeedsLista
    {      
  
        private static string sBDIntraTec = "BD_IntraTec";
        private List<cFeed> _ListaFeeds;

        public List<cFeed> Lista
        {
            get { return _ListaFeeds; }
            set { _ListaFeeds = value; }
        }

	    public cFeedsLista()
	    {
            _ListaFeeds = new List<cFeed>() { };
	    }

	    public void Agregar(cFeed pFeed)
	    {
		    _ListaFeeds.Add(pFeed);
	    }

        public cFeed Item(int intID) {
            return _ListaFeeds.Find(delegate(cFeed tmpFeed) {return tmpFeed.IDFeed == intID;});        
        }

	    public int NroItems()
	    {
		    return _ListaFeeds.Count;
	    }


        public void Remover(int IdFeed, ref int intTotalRemovidos)
        {
            intTotalRemovidos = _ListaFeeds.RemoveAll(delegate(cFeed tmpFeed)
            {
                return tmpFeed.IDFeed.Equals(IdFeed);
            });
        }
 
        public void ObtenerTodosRSSFeeds()
        {
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spBuscarURLFeedsTodos";       
            
            try
            {
                //lock ("Bloqueo") { 
                    cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                    oConBDIntraTec.getConnection(sBDIntraTec);
                    oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, null);
                    if (oSqlDataReader.HasRows)
                    {
                        while (oSqlDataReader.Read())
                        {
                            try
                            {
                                int IDFeedAux = (int)oSqlDataReader.GetSqlInt32(0);
                                string URLFeedAux = ((string)oSqlDataReader.GetSqlString(1)).Trim().ToUpperInvariant();
                                string TipoFeedAux = ((string)oSqlDataReader.GetSqlString(2)).Trim().ToUpperInvariant();
                                cFeed oFeed = new cFeed(IDFeedAux, URLFeedAux, TipoFeedAux);                            
                                Agregar(oFeed);
                            }
                            catch (Exception ex) {
                            }
                        }
                    }
                    oSqlDataReader.Close();
                    oConBDIntraTec.closeConnection();
                //}
            }
            catch (Exception ex)
            {
                throw ex;
            }
        
        }

    }    
}