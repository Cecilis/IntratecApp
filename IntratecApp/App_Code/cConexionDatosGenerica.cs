using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Data.Odbc;
using System.Data.OleDb;
using System.Configuration;

namespace IntraTecApp
{
    public class cConexionDatosGenerica
    {
        public const string PROVIDER_SQLCLIENT = "Provider_SqlClient";
	    public const string PROVIDER_OLEDB = "Provider_OleDb";
	    public const string PROVIDER_ODBC = "Provider_Odbc";
	    private static string _providerType = string.Empty;
	    private static string _sqlQuery = string.Empty;
	    private static string _connectionString = string.Empty;
	    private static string _servidorSQL = string.Empty;
	    private static string _BD = string.Empty;
	    private static string _seguridadIntegrada = string.Empty;
	    private static string _userBD = string.Empty;
	    private static string _pwdBD = string.Empty;
        private static IDbConnection _Connection;
        private static IDbTransaction _Transaction;
        private IDataParameter oParameter;

	    public cConexionDatosGenerica(string pProviderType)
	    {
		    _providerType = pProviderType;
	    }

	    public cConexionDatosGenerica(string pProviderType, string pServidorSQL, string pBD, bool pSeguridadIntegrada, string pUserBD, string pPwdBD)
	    {
		    _connectionString = "Server=" + pServidorSQL + "; initial Catalog=" + pBD + ";Integrated Security=" + pSeguridadIntegrada + ";UID=" + pUserBD + ";PWD=" + pPwdBD;
		    _providerType = pProviderType;
	    }

	    public IDbConnection getConnection(string sNameConnection = null)
	    {
		    switch (_providerType) {
			    case PROVIDER_SQLCLIENT:
				    if ((sNameConnection != null)) {
					    _Connection = new SqlConnection();
                        _Connection.ConnectionString = ConfigurationManager.ConnectionStrings[sNameConnection].ToString();
				    } else {
					    throw (new Exception("Conexión no definida.")); 
				    }
				    break;
			    case PROVIDER_OLEDB:
				    _Connection = new OleDbConnection(_connectionString);
				    break;
			    case PROVIDER_ODBC:
				    _Connection = new OdbcConnection(_connectionString);
				    break;
			    default:
				    throw (new Exception("Tipo invalido de proveedor."));
		    }

            closeConnection();
		    _Connection.Open();
		    return (_Connection);
	    }

        public void setTransaction() {
            _Transaction = _Connection.BeginTransaction();
        }

        public void executeTransaction(bool bAccion) {
            if (bAccion)
            {
                _Transaction.Commit();  
            }
            else {
                _Transaction.Rollback();
            }
        }

	    private IDbCommand createCommand()
	    {
		    IDbCommand objectCmd = null;
		    switch (_providerType) {
			    case "Provider_SqlClient":
				    objectCmd = new SqlCommand();
				    break;
			    case "Provider_OleDb":
				    objectCmd = new OleDbCommand();
				    break;
			    case "Provider_Odbc":
				    objectCmd = new OdbcCommand();
				    break;
			    default:
				    throw (new Exception("Invalid provider type"));
		    }
		    return (objectCmd);
	    }

	    public IDataReader executeReaderGetDataSet(string pNameStoredProcedure, List<IDataParameter> parametros = null)
	    {
            try
            {
		        IDbCommand cmd = createCommand();
		        IDataAdapter da = null;
		        DataSet ds = new DataSet();

		        switch (_providerType) {
			        case "Provider_SqlClient":
				        da = new SqlDataAdapter((SqlCommand)cmd);
				        break;
			        case "Provider_OleDb":
				        da = new OleDbDataAdapter((OleDbCommand)cmd);
				        break;
			        case "Provider_Odbc":
				        da = new OdbcDataAdapter((OdbcCommand)cmd);
				        break;
			        default:
				        throw (new Exception("Invalid provider type"));
		        }

		        cmd.Connection = _Connection;
		        cmd.CommandText = pNameStoredProcedure;
		        cmd.CommandType = CommandType.StoredProcedure;

                if (parametros.Count > 0)
                {
                    IDataParameter param = cmd.CreateParameter();

                    foreach (IDataParameter param_loopVariable in parametros)
                    {
                        param = param_loopVariable;
                        cmd.Parameters.Add(param);
                    }
                }
		        da.Fill(ds);
                return (IDataReader)ds.Tables[0].CreateDataReader();
                }
            catch (SqlException sqlEx)
            {
                switch (sqlEx.Number)
                {
                    case 2601:
                        throw sqlEx;
                    case 547:
                        throw new Exception("No puede eliminar este registro, ya que otro registro depende de este", sqlEx);
                    case 2627:
                        throw new Exception("No se permite agregar registros duplicados", sqlEx);
                    default:
                        throw sqlEx;
                }
            }
            catch (Exception ex) {
                throw ex;
            }
	    }


	    public IDataReader executeReaderGetDataReader(string pNameStoredProcedure,  List<IDataParameter> pListaParametros = null)
	    {
            try
            {
                IDbCommand oCommand = createCommand();
                IDataReader oDataReader = null;

                oCommand.Connection = _Connection;
                oCommand.CommandText = pNameStoredProcedure;
                oCommand.CommandType = CommandType.StoredProcedure;

                if (!(pListaParametros == null) && (pListaParametros.Count > 0))
                {
                    IDataParameter oParameter = oCommand.CreateParameter();
                    foreach (IDataParameter tmpParameter in pListaParametros)
                    {
                        oParameter = tmpParameter;
                        oCommand.Parameters.Add(oParameter);
                    }

                    oParameter = null;
                }

                oDataReader = oCommand.ExecuteReader();
                oCommand.Parameters.Clear();
                oCommand = null;
                return oDataReader;
            }
            catch (SqlException sqlEx)
            {
                switch (sqlEx.Number)
                {
                    case 2601:
                        throw sqlEx;
                    case 547:
                        throw new Exception("No puede eliminar este registro, ya que otro registro depende de este", sqlEx);
                    case 2627:
                        throw new Exception("No se permite agregar registros duplicados", sqlEx);
                    default:
                        throw sqlEx;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
	    }

        public IDataReader executeReaderGetDataReaderWithTransaction(string pNameStoredProcedure, List<IDataParameter> pListaParametros = null)
        {
            try
            {
                IDbCommand oCommand = createCommand();
                IDataReader oDataReader = null;

                oCommand.Connection = _Connection;
                oCommand.CommandText = pNameStoredProcedure;
                oCommand.CommandType = CommandType.StoredProcedure;
                oCommand.Transaction = _Transaction;

                if (!(pListaParametros == null) && (pListaParametros.Count > 0))
                {
                    IDataParameter oParameter = oCommand.CreateParameter();
                    foreach (IDataParameter tmpParameter in pListaParametros)
                    {
                        oParameter = tmpParameter;
                        oCommand.Parameters.Add(oParameter);
                    }

                    oParameter = null;
                }

                oDataReader = oCommand.ExecuteReader();
                oCommand.Parameters.Clear();
                oCommand = null;
                return oDataReader;
            }
            catch (SqlException sqlEx)
            {
                switch (sqlEx.Number)
                {
                    case 2601:
                        throw sqlEx;
                    case 547:
                        throw new Exception("No puede eliminar este registro, ya que otro registro depende de este", sqlEx);
                    case 2627:
                        throw new Exception("No se permite agregar registros duplicados", sqlEx);
                    default:
                        throw sqlEx;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


	    public IDataReader executeReaderGetDataReader(string pNameStoredProcedure,  ref List<IDataParameter> pListaParametros)
	    {
            try
            {
                IDbCommand oCommand = createCommand();
                IDataReader oDataReader = null;

                oCommand.Connection = _Connection;
                oCommand.CommandText = pNameStoredProcedure;
                oCommand.CommandType = CommandType.StoredProcedure;

                if (!(pListaParametros == null) && (pListaParametros.Count > 0))
                {
                    //IDataParameter oParameter = oCommand.CreateParameter();
                    foreach (IDataParameter tmpParameter in pListaParametros)
                    {
                        //oParameter = tmpParameter;
                        oCommand.Parameters.Add(tmpParameter);
                    }
                }

                oDataReader = oCommand.ExecuteReader();


                oCommand.Parameters.Clear();
                oCommand = null;
                return oDataReader;
            }
            catch (SqlException sqlEx)
            {
                switch (sqlEx.Number)
                {
                    case 2601:
                        throw sqlEx;
                    case 547:
                        throw new Exception("No puede eliminar este registro, ya que otro registro depende de este", sqlEx);
                    case 2627:
                        throw new Exception("No se permite agregar registros duplicados", sqlEx);
                    default:
                        throw sqlEx;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
	    }
       
	    public void executeNonQuery(string pNameStoredProcedure, ref int regAfectados, List<IDataParameter> parametros = null)
	    {
            try
            {
                IDbCommand cmd = createCommand();

                cmd.Connection = _Connection;
                cmd.CommandText = pNameStoredProcedure;
                cmd.CommandType = CommandType.StoredProcedure;

                if (parametros.Count > 0)
                {
                    IDataParameter param = cmd.CreateParameter();

                    foreach (IDataParameter param_loopVariable in parametros)
                    {
                        param = param_loopVariable;
                        cmd.Parameters.Add(param);
                    }
                }
                regAfectados = 0;
                regAfectados = cmd.ExecuteNonQuery();
            }
            catch (SqlException sqlEx)
            {
                switch (sqlEx.Number)
                {
                    case 2601:
                        throw sqlEx;
                    case 547:
                        throw new Exception("No puede eliminar este registro, ya que otro registro depende de este", sqlEx);
                    case 2627:
                        throw new Exception("No se permite agregar registros duplicados", sqlEx);
                    default:
                        throw sqlEx;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

	    }

	    public void executeNonQueryWithTransaction(string pNameStoredProcedure, List<IDataParameter> parametros, ref int regAfectados)
	    {
		    IDbCommand cmd = createCommand();

		    cmd.Connection = _Connection;
		    cmd.CommandText = pNameStoredProcedure;
		    cmd.CommandType = CommandType.StoredProcedure;
            cmd.Transaction = _Transaction;

            try 
            {
                if (parametros.Count > 0)
                {
                    IDataParameter param = cmd.CreateParameter();
                    foreach (IDataParameter param_loopVariable in parametros)
                    {
                        param = param_loopVariable;
                        cmd.Parameters.Add(param);
                    }
                }
                regAfectados = 0;
                regAfectados = cmd.ExecuteNonQuery();            
            }
            catch (SqlException sqlEx)
            {
                switch (sqlEx.Number)
                {
                    case 2601:
                        throw sqlEx;
                    case 547:
                        throw new Exception("No puede eliminar este registro, ya que otro registro depende de este", sqlEx);
                    case 2627:
                        throw new Exception("No se permite agregar registros duplicados", sqlEx);
                    default:
                        throw sqlEx;
                }
            }
            catch (Exception ex) {
                throw ex;
            }
	    }

        
        public Object executeScalar(string pNameStoredProcedure, List<IDataParameter> parametros)
	    {
            try
            {
                Object oResultado;
                IDbCommand oCommand = createCommand();

                oCommand.Connection = _Connection;
                oCommand.CommandText = pNameStoredProcedure;
                oCommand.CommandType = CommandType.StoredProcedure;

                if (parametros.Count > 0)
                {
                    IDataParameter param = oCommand.CreateParameter();

                    foreach (IDataParameter param_loopVariable in parametros)
                    {
                        param = param_loopVariable;
                        oCommand.Parameters.Add(param);
                    }
                }
                oResultado = oCommand.ExecuteScalar();
                oCommand.Dispose();
                return oResultado;
            }
            catch (SqlException sqlEx)
            {
                switch (sqlEx.Number)
                {
                    case 2601:
                        throw sqlEx;
                    case 547:
                        throw new Exception("No puede eliminar este registro, ya que otro registro depende de este", sqlEx);
                    case 2627:
                        throw new Exception("No se permite agregar registros duplicados", sqlEx);
                    default:
                        throw sqlEx;
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

	    }

	    public void closeConnection()
	    {
		    if (_Connection.State != ConnectionState.Closed) {
			    _Connection.Close();
		    } 
	    }
    }
}