using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using IntraTecApp;

namespace IntraTecApp
{
    public class cCategoria
    {
        private int _categoriaID;
        private string _nombre;

        public int CategoriaID
        {get{return _categoriaID;}set{_categoriaID=value;}}

        public string Nombre
        {get{return _nombre;}
        set{_nombre=value;}}

        public cCategoria()
        {
            _categoriaID = 0;
            _nombre = String.Empty;
        }

        public static string _conString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["BD_IntraTec"].ConnectionString;
            }
        }


        public cCategoria(int categoriaID)
        {
            SqlConnection conexion = new SqlConnection(_conString);
            conexion.Open();
            string consulta = "SELECT CategoriaID, Nombre FROM Categoria WHERE CategoriaID=@CategoriaID";
            SqlCommand cmd = new SqlCommand(consulta, conexion);
            cmd.Parameters.AddWithValue("@CategoriaID", categoriaID);
            SqlDataReader reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                _categoriaID = reader.GetInt32(0);
                _nombre = reader.GetString(1);
            }
            reader.Close();
            conexion.Close();
        }


        public void Crear()
        {
            SqlConnection conexion = new SqlConnection(_conString);
            conexion.Open();
            string consulta="INSERT INTO Categoria (Nombre) VALUES (@Nombre)";
            SqlCommand cmd = new SqlCommand(consulta, conexion);
            cmd.Parameters.AddWithValue("@Nombre", _nombre);
            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            cmd.CommandText = "SELECT @@IDENTITY";
            _categoriaID = Convert.ToInt32(cmd.ExecuteScalar());
            conexion.Close();
        }

        public void Actualizar()
        {
            SqlConnection conexion = new SqlConnection(_conString);
            conexion.Open();
            string consulta = "UPDATE Categoria SET Nombre=@Nombre WHERE CategoriaID=@CategoriaID";
            SqlCommand cmd = new SqlCommand(consulta, conexion);
            cmd.Parameters.AddWithValue("@Nombre", _nombre);
            cmd.Parameters.AddWithValue("CategoriaID", _categoriaID);
            cmd.ExecuteNonQuery();
            conexion.Close();
        }

        public void Eliminar()
        {
            SqlConnection oConnection = new SqlConnection(_conString);
            oConnection.Open();
            SqlTransaction oTransaction = oConnection.BeginTransaction();
            try
            {
                string consulta = "DELETE FROM PostCategoria WHERE CategoriaID=@CategoriaID";
                SqlCommand oCommand = new SqlCommand(consulta, oConnection);
                oCommand.Parameters.AddWithValue("CategoriaID", _categoriaID);
                oCommand.Transaction = oTransaction;
                oCommand.ExecuteNonQuery();
                oCommand.CommandText = "DELETE FROM Categoria WHERE CategoriaID = @CategoriaID";
                oCommand.ExecuteNonQuery();
                oTransaction.Commit();
            }
            catch (Exception ex)
            {
                oTransaction.Rollback();
            }
            finally { 
                oConnection.Close();
                _categoriaID = 0;
                _nombre = String.Empty;            
            }
        }

        public static List<cCategoria> ObtenerTodasCategorias()
        {
            SqlConnection conexion = new SqlConnection(_conString);
            conexion.Open();
            List<cCategoria> oListaCategoria = new List<cCategoria>();
            SqlCommand cmd = new SqlCommand("SELECT CategoriaID,Nombre FROM Categoria ORDER BY Nombre", conexion);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                cCategoria oCategoria = new cCategoria();
                oCategoria.CategoriaID = reader.GetInt32(0);
                oCategoria.Nombre = reader.GetString(1);
                oListaCategoria.Add(oCategoria);
            }
            reader.Close();
            conexion.Close();
            return oListaCategoria;
        }
    }
}