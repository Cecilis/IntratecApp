using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using IntraTecApp;
using System.Data;
using System.Data.SqlClient;

namespace IntraTecApp
{
    public class cUsuario
    {
        private static string sBDIntraTec = "BD_IntraTec";

        public int IDUsuario { get; set; }
        public string NroID { get; set; }
        public string Usuario { get; set; }
        public string Nombre { get; set; }
        public string Clave { get; set; }
        public string Status { get; set; }
        public string StatusBloqueo { get; set; }
        public int intentosFallidos { get; set; }
        public DateTime FechaUltimaConexion { get; set; }
        public string ClaveReseteada { get; set; }
        
        public cUsuario()
        {
            IDUsuario = 0;
            NroID = string.Empty;
            Usuario = string.Empty;
            Clave = string.Empty;
            Status = string.Empty;
            StatusBloqueo = string.Empty;
            intentosFallidos = 0;
            ClaveReseteada = "1";
        }

        private void Cargar(SqlDataReader oSqlDataReader)
        {
            IDUsuario = (int)oSqlDataReader.GetSqlInt32(0);
            Usuario = ((string)oSqlDataReader.GetSqlString(1)).Trim();
            Nombre = ((string)oSqlDataReader.GetSqlString(2)).Trim();
            Clave = ((string)oSqlDataReader.GetSqlString(3)).Trim();
            Status = ((string)oSqlDataReader.GetSqlString(4)).Trim().ToUpperInvariant();
            StatusBloqueo = ((string)oSqlDataReader.GetSqlString(5)).Trim().ToUpperInvariant();
            intentosFallidos = (int)oSqlDataReader.GetSqlInt32(6);
            FechaUltimaConexion = oSqlDataReader.GetDateTime(7);
            ClaveReseteada = ((string)oSqlDataReader.GetSqlString(8)).Trim();
        }

        public cUsuario (string strUsuario) {

            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;

            cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
            oConBDIntraTec.getConnection(sBDIntraTec);

            string sProcAlmacenado = "spBuscarUsuarios";
            System.Data.IDataParameter oIDataParameter;
            oIDataParameter = new SqlParameter("@Usuario", strUsuario);
            ListaParametros.Add(oIDataParameter);

            oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

            if (oSqlDataReader.HasRows)
            {
                if (oSqlDataReader.Read())
                {
                    Cargar(oSqlDataReader);
                }
            }
            ListaParametros.Clear();
            oSqlDataReader = null;
            oConBDIntraTec.closeConnection();
        }

        public bool actualizaClave(string strNuevaClave) {
            bool bClaveActualizada = false;
            int intTotalFilas  = 0;

            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;

            cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
            oConBDIntraTec.getConnection(sBDIntraTec);

            string sProcAlmacenado = "spModificarUsuariosClave";

            System.Data.IDataParameter idpIDUsuario;
            idpIDUsuario = new SqlParameter("@IDUsuario", IDUsuario);
            ListaParametros.Add(idpIDUsuario);

            System.Data.IDataParameter idpClaveNueva;
            idpClaveNueva = new SqlParameter("@ClaveNueva", strNuevaClave);
            ListaParametros.Add(idpClaveNueva);

            System.Data.IDataParameter idpClaveReseteada;
            idpClaveReseteada = new SqlParameter("@ClaveReseteada", ClaveReseteada);
            ListaParametros.Add(idpClaveReseteada);
            

            System.Data.IDataParameter idpTotalFilas;
            idpTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);
            idpTotalFilas.Direction = ParameterDirection.Output;
            ListaParametros.Add(idpTotalFilas);

            oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

            intTotalFilas = int.Parse(idpTotalFilas.Value.ToString());
            if (intTotalFilas > 0)
            {
                bClaveActualizada = true;
            }

            ListaParametros.Clear();
            oSqlDataReader = null;
            oConBDIntraTec.closeConnection();

            return bClaveActualizada;
        }

        public bool IntentosFallidosIncrementados()
        {
            try
            {
                bool bIntentosFallidosIncrementados = false;
                int intTotalFilasIF = 0;
                int intTotalFilasUB = 0;

                List<IDataParameter> ListaParametros = new List<IDataParameter>();
                SqlDataReader oSqlDataReader;

                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                string sProcAlmacenado = "spModificarUsuariosIncIntentosFallidos";

                System.Data.IDataParameter idpIDUsuario;
                idpIDUsuario = new SqlParameter("@IDUsuario", IDUsuario);
                ListaParametros.Add(idpIDUsuario);

                System.Data.IDataParameter idpTotalFilasIF;
                idpTotalFilasIF = new SqlParameter("@TotalFilasIF", intTotalFilasIF);
                idpTotalFilasIF.Direction = ParameterDirection.Output;
                ListaParametros.Add(idpTotalFilasIF);

                System.Data.IDataParameter idpTotalFilasUB;
                idpTotalFilasUB = new SqlParameter("@TotalFilasUB", intTotalFilasUB);
                idpTotalFilasUB.Direction = ParameterDirection.Output;
                ListaParametros.Add(idpTotalFilasUB);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ref ListaParametros);

                intTotalFilasIF = int.Parse(idpTotalFilasIF.Value.ToString());
                intTotalFilasUB = int.Parse(idpTotalFilasUB.Value.ToString());
                if (intTotalFilasIF > 0)
                {
                    bIntentosFallidosIncrementados = true;
                }
                if (intTotalFilasUB > 0)
                {
                    StatusBloqueo = "1";
                }

                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();

                return bIntentosFallidosIncrementados; 
            }
            catch (Exception ex) {
                throw ex;
            }
        }

        public DataTable FiltroUsuario(string pPalabraClave)
        {
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spFiltrarUsuarios";
            DataTable oDataTable = new DataTable();

            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter oIDataParameter;
                oIDataParameter = new SqlParameter("@PalabraClave", pPalabraClave);
                ListaParametros.Add(oIDataParameter);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                if (oSqlDataReader.HasRows)
                {
                    if (oSqlDataReader.Read())
                    {
                        Cargar(oSqlDataReader);                       
                    }
                }
                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                return oDataTable;
            }
            catch (Exception ex) {
                throw new Exception("Error al consultar datos de usuario. Detalles: " + ex.Message.ToString());
            }
        }

        public bool Existe(string pUsuario)
        {
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            bool bExisteUsuario = false;

            string sProcAlmacenado = "spBuscarUsuarioxNombre";

            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter oIDataParameter;
                oIDataParameter = new SqlParameter("@Usuario", pUsuario);
                ListaParametros.Add(oIDataParameter);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                if (oSqlDataReader.HasRows)
                {
                    if (oSqlDataReader.Read())
                    {
                        bExisteUsuario = true;
                        Cargar(oSqlDataReader);
                    }
                }
                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                return bExisteUsuario;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al consultar datos del usuario. Detalles: " + ex.Message.ToString());
            }
        }

        public void ActualizarDatos(string strAccion, bool bActualizarCompleto, ref string strResultados)
        {
            String sProcAlmacenado;
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            int intTotalFilas = 0;
            strResultados = "NOTOK";

            try
            {
                if (strAccion == "I")
                {
                    sProcAlmacenado = "spIncluirUsuario";
                }
                else if (strAccion == "M")
                {
                    if (!bActualizarCompleto)
                        sProcAlmacenado = "spModificarUsuario";
                    else
                        sProcAlmacenado = "spModificarUsuarioTodo";
                }
                else
                {
                    throw new Exception("800 - Tipo de Acción no definida.");
                }

                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter oIDataParameter;

                oIDataParameter = new SqlParameter("@Usuario", Usuario);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@Nombre", Nombre);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@Status", Status);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@StatusBloqueo", StatusBloqueo);
                ListaParametros.Add(oIDataParameter);

                System.Data.IDataParameter idpUsuario;
                idpUsuario = new SqlParameter("@IDUsuario", IDUsuario);

                System.Data.IDataParameter idpintTotalFilas;
                idpintTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);

                if ((strAccion == "I") ||(bActualizarCompleto))
                {
                    if (bActualizarCompleto)
                    {
                        System.Data.IDataParameter idpIntentosFallidos;
                        idpIntentosFallidos = new SqlParameter("@IntentosFallidos", intentosFallidos);
                        ListaParametros.Add(idpIntentosFallidos);

                        idpintTotalFilas.Direction = ParameterDirection.Output;
                        ListaParametros.Add(idpintTotalFilas);

                        System.Data.IDataParameter idpClaveReseteada;
                        idpClaveReseteada = new SqlParameter("@ClaveReseteada", ClaveReseteada);
                        ListaParametros.Add(idpClaveReseteada);
                    }

                    oIDataParameter = new SqlParameter("@Clave", Clave);
                    ListaParametros.Add(oIDataParameter);

                    if (strAccion == "I")
                        idpUsuario.Direction = ParameterDirection.Output;

                    ListaParametros.Add(idpUsuario);
                }
                else if (strAccion == "M")
                {                                    
                    oIDataParameter = new SqlParameter("@IntentosFallidos", intentosFallidos);
                    ListaParametros.Add(oIDataParameter); 
                                   
                    ListaParametros.Add(idpUsuario);

                    idpintTotalFilas.Direction = ParameterDirection.Output;
                    ListaParametros.Add(idpintTotalFilas);
                }

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);
                if (strAccion == "I")
                {
                    IDUsuario = int.Parse(idpUsuario.Value.ToString());
                    if (IDUsuario > 0) {
                        strResultados = "OK";  
                    }
                }
                else if (strAccion == "M")
                {
                    intTotalFilas = int.Parse(idpintTotalFilas.Value.ToString());
                    if (intTotalFilas > 0) {
                        strResultados = "OK";
                    }
                }

                ListaParametros.Clear();
                oConBDIntraTec.closeConnection();
            }
            catch (Exception ex)
            {
                strResultados = "Error: Al actualizar datos de usuario: " + ex.Message.ToString();
            }
        }


        public DataSet ObtenerTodos()
        {
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spBuscarUsuariosTodos";

            List<cUsuario> oListaUsuarios = new List<cUsuario>();
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, null);
                DataSet oDataSet = new DataSet();

                oDataSet.Load(oSqlDataReader, LoadOption.OverwriteChanges, new string[] { "Todos" });

                oConBDIntraTec.closeConnection();

                return oDataSet;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

    }
}