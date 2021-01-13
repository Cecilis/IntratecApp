using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace IntraTecApp 
{
    public static class cFoto
    {
        private static string sBDIntraTec = "BD_IntraTec";

        public static byte[] Foto(string pIDFoto, string pTipoFoto)
        {
            string sProcAlmacenado = string.Empty;

            switch (pTipoFoto)
            {
                case "E":
                    sProcAlmacenado = "spImagenEmpleado";
                    break;
                case "N":
                    sProcAlmacenado = "spImagenNoticia";
                    break;
            }

            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            
            byte[] imagen = { };

            try
            {
                lock ("Bloqueo") {

                    SqlConnection oSqlConnection = new SqlConnection(ConfigurationManager.ConnectionStrings[sBDIntraTec].ConnectionString);
                    oSqlConnection.Open();

                    SqlCommand oSqlCommand = new SqlCommand();
                    oSqlCommand.Connection = oSqlConnection;
                    oSqlCommand.CommandType = CommandType.StoredProcedure;
                    oSqlCommand.CommandText = sProcAlmacenado;

                    oSqlCommand.Parameters.AddWithValue("@IDEmpleado", pIDFoto);

                    SqlDataReader oSqlDataReader = oSqlCommand.ExecuteReader();

                    if (oSqlDataReader.HasRows)
                    {
                        if (oSqlDataReader.Read())
                        {
                            imagen = (byte[])oSqlDataReader[0];
                        }
                    }

                    ListaParametros.Clear();

                    oSqlDataReader.Close();
                    oSqlDataReader = null;

                    if (oSqlConnection.State != ConnectionState.Closed)
                        oSqlConnection.Close();
                    oSqlConnection = null;

                    return imagen;
                } 
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}