using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;

namespace IntraTecApp
{
    public class cEmpleado
    {
        private static string sBDIntraTec = "BD_IntraTec";

        public int IDEmpleado { get; set; }
        public string TipoID { get; set; }
        public string IDNumero { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Sexo { get; set; }
        public DateTime FechaNacimiento { get; set; }
        public string NumSeguroSocial { get; set; }
        public byte[] ImgFoto { get; set; }
        public string NombreFoto { get; set; }
        public int ImgFotoLong { get; set; }
        public string CodDepartamento { get; set; }
        public string CodCargo { get; set; }
        public string PinBB { get; set; }
        public string StatusPubDatos { get; set; }
        public string CodTipoEmpleado { get; set; }
        public string CodAreaTlfOficina { get; set; }
        public string NumTlfOficina { get; set; }
        public string CodAreaTlfMovil { get; set; }
        public string NumTlfMovil { get; set; }
        public string DescCargo { get; set; }
        public DateTime FecIngreso { get; set; }
        public String Status { get; set; }

        public cEmpleado() {
            IDEmpleado = 0;
        }

        private void Cargar(SqlDataReader oSqlDataReader)
        {
            IDEmpleado = (int)oSqlDataReader.GetSqlInt32(0);
            TipoID = ((string)oSqlDataReader.GetSqlString(1)).Trim().ToUpperInvariant();
            IDNumero = ((string)oSqlDataReader.GetSqlString(2)).Trim().ToUpperInvariant();
            Nombre = ((string)oSqlDataReader.GetSqlString(3)).Trim().ToUpperInvariant();
            Apellido = ((string)oSqlDataReader.GetSqlString(4)).Trim().ToUpperInvariant();
            Sexo = ((string)oSqlDataReader.GetSqlString(5)).Trim().ToUpperInvariant();
            FechaNacimiento = oSqlDataReader.GetDateTime(6);
            NumSeguroSocial = ((string)oSqlDataReader.GetSqlString(7)).Trim().ToUpperInvariant();
            ImgFoto = (byte[])oSqlDataReader[8];
            NombreFoto = ((string)oSqlDataReader.GetSqlString(9)).Trim().ToUpperInvariant();
            ImgFotoLong = (int)oSqlDataReader.GetInt32(10);
            PinBB = ((string)oSqlDataReader.GetSqlString(11)).Trim().ToUpperInvariant();
            StatusPubDatos = ((string)oSqlDataReader.GetSqlString(12)).Trim().ToUpperInvariant();
            CodTipoEmpleado = ((string)oSqlDataReader.GetSqlString(13)).Trim().ToUpperInvariant();
            CodAreaTlfOficina = ((string)oSqlDataReader.GetSqlString(14)).Trim().ToUpperInvariant();
            NumTlfOficina = ((string)oSqlDataReader.GetSqlString(15)).Trim().ToUpperInvariant();
            CodAreaTlfMovil = ((string)oSqlDataReader.GetSqlString(16)).Trim().ToUpperInvariant();
            NumTlfMovil = ((string)oSqlDataReader.GetSqlString(17)).Trim().ToUpperInvariant();
            DescCargo = ((string)oSqlDataReader.GetSqlString(18)).Trim().ToUpperInvariant();
            FecIngreso = Convert.ToDateTime(oSqlDataReader.GetDateTime(19));
            Status = ((string)oSqlDataReader.GetSqlString(20)).Trim().ToUpperInvariant();
        }

        public bool ExisteEmpleado(string pTipoID, string pIDNumero )
        {
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            bool bExisteEmpleado = false;

            String sProcAlmacenadoBE = "spBuscarEmpleado";
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter oIDataParameter;
                oIDataParameter = new SqlParameter("@TipoID", pTipoID);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@IDNumero", pIDNumero);
                ListaParametros.Add(oIDataParameter);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenadoBE, ListaParametros);

                if (oSqlDataReader.HasRows)
                {
                    if (oSqlDataReader.Read())
                    {
                        bExisteEmpleado = true;
                        Cargar(oSqlDataReader);                       
                    }
                }
                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                return bExisteEmpleado;
            }
            catch (Exception ex) {
                throw new Exception("Error al consultar datos de empleado. Detalles: " + ex.Message.ToString());
            }
        }

        public void ActualizarDatosEmpleado(string strAccion, ref string strResultados)
        {
            String sProcAlmacenado;
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            int intTotalFilas = 0;

            cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);

            try
            {
                if (strAccion == "I")
                {
                    sProcAlmacenado = "spIncluirEmpleados";
                }
                else if (strAccion == "M")
                {
                    sProcAlmacenado = "spModificarEmpleados";
                }
                else
                {
                    throw new Exception("800 - Tipo de Acción no definida.");
                }

                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter oIDataParameter;

                oIDataParameter = new SqlParameter("@TipoID", TipoID);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@IDNumero", IDNumero);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@Nombre", Nombre);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@Apellido", Apellido);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@Sexo", Sexo);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@FechaNacimiento", FechaNacimiento);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@NumSeguroSocial", NumSeguroSocial);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@ImgFoto", System.Data.SqlDbType.Image);
                oIDataParameter.Value = ImgFoto;
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@NombreFoto", NombreFoto);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@ImgFotoLong", ImgFotoLong);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@StatusPubDatos", StatusPubDatos);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@CodTipoEmpleado", "1");
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@CodAreaTlfOficina", CodAreaTlfOficina);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@NumTlfOficina", NumTlfOficina);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@CodAreaTlfMovil", CodAreaTlfMovil);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@NumTlfMovil", NumTlfMovil);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@DescCargo", DescCargo);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@FecIngreso", FecIngreso);
                ListaParametros.Add(oIDataParameter);

                oIDataParameter = new SqlParameter("@Status", Status);
                ListaParametros.Add(oIDataParameter);

                System.Data.IDataParameter idpIDEmpleado;
                idpIDEmpleado = new SqlParameter("@IDEmpleado", IDEmpleado);

                System.Data.IDataParameter idpTotalFilas;
                idpTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);

                if (strAccion == "I")
                {
                    idpIDEmpleado.Direction = ParameterDirection.Output;
                    ListaParametros.Add(idpIDEmpleado);
                }
                else if (strAccion == "M")
                {
                    ListaParametros.Add(idpIDEmpleado);

                    idpTotalFilas.Direction = ParameterDirection.Output;
                    ListaParametros.Add(idpTotalFilas);
                }

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                //if (oSqlDataReader.HasRows) {
                //    while (oSqlDataReader.Read()) {
                if (strAccion == "I")
                {
                    IDEmpleado = int.Parse(idpIDEmpleado.Value.ToString());
                    if (IDEmpleado <= 0)
                    {
                        throw new Exception("Error al ejecutar la acción.");
                    }
                    //oSqlDataReader.GetInt32(0);
                }
                else if (strAccion == "M")
                {
                    intTotalFilas = int.Parse(idpTotalFilas.Value.ToString());
                    if (intTotalFilas <= 0)
                    {
                        throw new Exception("Error al ejecutar la acción.");
                    }
                }
                //    }
                //}

                ListaParametros.Clear();
                oConBDIntraTec.closeConnection();
                strResultados = "OK";
            }
            catch (Exception ex)
            {
                strResultados = "Error: Al actualizar datos de empleado: " + ex.Message.ToString();
            }
            finally
            {
                ListaParametros.Clear();
                oConBDIntraTec.closeConnection();
            }
        }

        public byte[] ObtenerImagen(System.Drawing.Image oImagen)
        {
            MemoryStream oMemoryStream = new MemoryStream();
            oImagen.Save(oMemoryStream, System.Drawing.Imaging.ImageFormat.Gif);
            return oMemoryStream.ToArray();
        }

        public Image ObtenerArrBytes(byte[] oArrByte)
        {
            MemoryStream oMemoryStream = new MemoryStream(oArrByte);
            Image oImage = Image.FromStream(oMemoryStream);
            return oImage;
        }
        
        public static List<cTelefono> TelefonosEmpleado(int pIDEmpleado)
        {

            String sProcAlmacenadoBT = "spBuscarTelefonos";
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            List<cTelefono> oListaTelefonos = new List<cTelefono>();

            SqlDataReader oSqlDataReader;


            cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
            oConBDIntraTec.getConnection(sBDIntraTec);

            System.Data.IDataParameter oIDataParameter;
            oIDataParameter = new SqlParameter("@IDEmpleado", pIDEmpleado);
            ListaParametros.Add(oIDataParameter);

            oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenadoBT, ListaParametros);

            if (oSqlDataReader.HasRows)
            {
                while (oSqlDataReader.Read())
                {
                    cTelefono oTelefono = new cTelefono();
                    oTelefono.IDTelefono = (int)oSqlDataReader.GetSqlInt32(0);
                    oTelefono.CodPais = (string)oSqlDataReader.GetSqlString(1);
                    oTelefono.CodArea = (string)oSqlDataReader.GetSqlString(2);
                    oTelefono.Numero = (string)oSqlDataReader.GetSqlString(3);
                    oTelefono.Extension = (string)oSqlDataReader.GetSqlString(4);
                    oTelefono.IDEmpleado = (int)oSqlDataReader.GetSqlInt32(5);
                    oListaTelefonos.Add(oTelefono);
                    oTelefono = null;
                }
            }
            oConBDIntraTec.closeConnection();
            return oListaTelefonos;
        }

        public DataSet ObtenerTodos()
        {
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spBuscarEmpleadosTodos";

            List<cEmpleado> oListaEmpleados = new List<cEmpleado>();
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


        public DataSet ProximosCumpleanios()
        {
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spBuscarProximosCumpleanios";
                        
            List<cEmpleado> oListaEmpleados = new List<cEmpleado>();
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, null );
                DataSet oDataSet = new DataSet();

                oDataSet.Load(oSqlDataReader, LoadOption.OverwriteChanges, new string[] { "Cumpleanios" });

                DataView oDataView = oDataSet.Tables["Cumpleanios"].DefaultView;
                DataTable oDataTable = oDataView.ToTable(true, "DiaMesCumpleanios");
                oDataTable.TableName = "FechasCumpleanios";

                DataTable oDataTableFechas = oDataTable;

                oDataSet.Tables.Add(oDataTable);

                oDataSet.Relations.Add("relFechaProximosCumpleanios",
                oDataSet.Tables["FechasCumpleanios"].Columns["DiaMesCumpleanios"],
                oDataSet.Tables["Cumpleanios"].Columns["DiaMesCumpleanios"]);

                oConBDIntraTec.closeConnection();

                return oDataSet;

            }
            catch(Exception ex) {
                throw ex;
            }                    
        }

        public DataSet ProximosAniversarios()
        {
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spBuscarProximosAniversarios";

            List<cEmpleado> oListaEmpleados = new List<cEmpleado>();
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, null);
                DataSet oDataSet = new DataSet();

                oDataSet.Load(oSqlDataReader, LoadOption.OverwriteChanges, new string[] { "Aniversarios" });

                DataView oDataView = oDataSet.Tables["Aniversarios"].DefaultView;
                DataTable oDataTable = oDataView.ToTable(true, "DiaMesAniversario");
                oDataTable.TableName = "FechasAniversarios";

                DataTable oDataTableFechas = oDataTable;

                oDataSet.Tables.Add(oDataTable);

                oDataSet.Relations.Add("relFechaProximosAniversarios",
                oDataSet.Tables["FechasAniversarios"].Columns["DiaMesAniversario"],
                oDataSet.Tables["Aniversarios"].Columns["DiaMesAniversario"]);

                oConBDIntraTec.closeConnection();

                return oDataSet;

            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        public static DataSet MostrarEnGaleria() {
            SqlDataReader oSqlDataReader;
            String sProcAlmacenado = "spBuscarEmpleadosMostrarEnGaleria";

            List<cEmpleado> oListaEmpleados = new List<cEmpleado>();
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);


                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, null);

                DataSet oDataSet = new DataSet();
                oDataSet.Load(oSqlDataReader, LoadOption.OverwriteChanges, new string[] { "EmpleadosAdmin" });

                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                oConBDIntraTec = null;

                return oDataSet;

            }
            catch (Exception ex)
            {
                throw ex;
            }           
        }

        public static byte[] Foto(string pIDEmpleado) {
        SqlDataReader oSqlDataReader;
        String sProcAlmacenado = "spImagenEmpleado";
        List<IDataParameter> ListaParametros = new List<IDataParameter>();

        byte[] imagen = { };

        try
        {
            cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
            oConBDIntraTec.getConnection(sBDIntraTec);

            System.Data.IDataParameter oIDataParameter;
            oIDataParameter = new SqlParameter("@IDEmpleado", pIDEmpleado);
            ListaParametros.Add(oIDataParameter);

            oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

            if (oSqlDataReader.HasRows)
            {
                if (oSqlDataReader.Read())
                {
                    imagen = (byte[])oSqlDataReader[0];
                }
            }

            oSqlDataReader.Close();
            oSqlDataReader = null;

            oConBDIntraTec.closeConnection();
            oConBDIntraTec = null;

            return imagen;
        }
        catch (Exception ex)
        {
            throw ex;
        }
    }


        public void Eliminar(ref string strResultados)
        {
            String sProcAlmacenado;
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            int intTotalFilas = 0;
            strResultados = "NOTOK";
            cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);

            try
            {

                sProcAlmacenado = "spEliminarEmpleados";

                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter idpIDEmpleado;
                idpIDEmpleado = new SqlParameter("@IDEmpleado", IDEmpleado);
                ListaParametros.Add(idpIDEmpleado);

                System.Data.IDataParameter idpTotalFilas;                
                idpTotalFilas = new SqlParameter("@TotalFilas", intTotalFilas);
                ListaParametros.Add(idpTotalFilas);
                idpTotalFilas.Direction = ParameterDirection.Output;

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                intTotalFilas = int.Parse(idpTotalFilas.Value.ToString());
                if (intTotalFilas <= 0)
                    throw new Exception("Error al ejecutar la acción.");

                ListaParametros.Clear();
                oConBDIntraTec.closeConnection();
                strResultados = "OK";
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                ListaParametros.Clear();
                oConBDIntraTec.closeConnection();
            }

        }
    }
}