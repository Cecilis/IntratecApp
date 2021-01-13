using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;

namespace IntraTecApp
{
    public class cComentario
    {
        private int _comentarioID;
        private int _postID;
        private DateTime _fecha;
        private string _nombre;
        private string _url;
        private string _contenido;

        public cComentario()
        {
            Default();
        }

        private void Default()
        {
            _postID = 0;
            _fecha = new DateTime(2000, 1, 1);
            _nombre = String.Empty;
            _url = String.Empty;
            _contenido = String.Empty;
        }

        public int ComentarioID
        { get { return _comentarioID; } set { _comentarioID = value; } }

        public int PostID
        { get { return _postID; } set { _postID = value; } }

        public DateTime Fecha
        { get { return _fecha; } set { _fecha = value; } }

        public string Nombre
        { get { return _nombre; } set { _nombre = value; } }

        public string Url
        { get { return _url; } set { _url = value; } }

        public string Contenido
        { get { return _contenido; } set { _contenido = value; } }

        public static string _conString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["BD_IntraTec"].ConnectionString;
            }
        }


        public cComentario(int comentarioID)
        {
            HttpContext contexto = HttpContext.Current;
            if ((contexto.Cache["comentario" + _comentarioID.ToString()] == null))
            {
                SqlConnection conexion = new SqlConnection(_conString);
                conexion.Open();
                SqlCommand command = new SqlCommand("SELECT ComentarioID, PostID, Fecha, Nombre, Url, Contenido FROM Comentario WHERE ComentarioID = @ComentarioID", conexion);
                command.Parameters.AddWithValue("@ComentarioID", _comentarioID);
                SqlDataReader reader = command.ExecuteReader();
                if (reader.Read())
                {
                    _comentarioID = reader.GetInt32(0);
                    _postID = reader.GetInt32(1);
                    _fecha = reader.GetDateTime(2);
                    _nombre = reader.GetString(3);
                    _url = reader.GetString(4);
                    _contenido = reader.GetString(5);
                }
                else Default();
                reader.Close();
                conexion.Close();
                contexto.Cache.Insert("comentario" + _comentarioID.ToString(), this, null, DateTime.Now.AddMinutes(5), TimeSpan.Zero);
            }
            else
            {
                cComentario comentario = (cComentario)contexto.Cache["comentario" + _comentarioID.ToString()];
                _postID = comentario.PostID;
                _nombre = comentario.Nombre;
                _url = comentario.Url;
                _contenido = comentario.Contenido;
            }
        }


        private void BorrarCache()
        {
            HttpContext context = HttpContext.Current;
            if (context.Cache["comentario" + _comentarioID.ToString()] != null)
                context.Cache.Remove("comentario" + _comentarioID.ToString());
            if (context.Cache["nuevaCategoria" + _postID.ToString()] != null)
                context.Cache.Remove("nuevaCategoria" + _postID.ToString());
            if (context.Cache["nuevoComentario" + _postID.ToString()] != null)
                context.Cache.Remove("nuevoComentario" + _postID.ToString());
            if (context.Cache["3posts"] != null)
                context.Cache.Remove("3posts");
        }

        public int Crear()
        {
            BorrarCache();
            SqlConnection conexion = new SqlConnection(_conString);
            conexion.Open();
            SqlCommand cmd = new SqlCommand("INSERT INTO Comentario(PostID, Fecha, Nombre, Url, Contenido) VALUES (@PostID, @Fecha, @Nombre, @Url, @Contenido)", conexion);
            cmd.Parameters.AddWithValue("@PostID", _postID);
            cmd.Parameters.AddWithValue("@Fecha", _fecha);
            cmd.Parameters.AddWithValue("@Nombre", _nombre);
            cmd.Parameters.AddWithValue("@Url", _url);
            cmd.Parameters.AddWithValue("@Contenido", _contenido);
            cmd.ExecuteNonQuery();
            cmd.Parameters.Clear();
            cmd.CommandText = "SELECT @@IDENTITY";
            int comentarioID = Convert.ToInt32(cmd.ExecuteScalar());
            conexion.Close();
            _comentarioID = comentarioID;
            return comentarioID;
        }

        public bool Actualizar()
        {
            BorrarCache();
            SqlConnection conexion = new SqlConnection(_conString);
            conexion.Open();
            SqlCommand cmd = new SqlCommand("UPDATE Comentario SET PostID = @PostID, Fecha = @Fecha, Nombre = @Nombre, Url = @Url, Contenido = @Contenido WHERE ComentarioID = @ComentarioID", conexion);
            cmd.Parameters.AddWithValue("@ComentarioID", _comentarioID);
            cmd.Parameters.AddWithValue("@PostID", _postID);
            cmd.Parameters.AddWithValue("@Fecha", _fecha);
            cmd.Parameters.AddWithValue("@Nombre", _nombre);
            cmd.Parameters.AddWithValue("@Url", _url);
            cmd.Parameters.AddWithValue("@Contenido", _contenido);
            bool resultado = false;
            if (cmd.ExecuteNonQuery() > 0) resultado = true;
            conexion.Close();
            return resultado;
        }

        public void Eliminar()
        {
            BorrarCache();
            SqlConnection conexion = new SqlConnection(_conString);
            conexion.Open();
            SqlCommand cmd = new SqlCommand("DELETE FROM Comentario WHERE ComentarioID = @ComentarioID", conexion);
            cmd.Parameters.AddWithValue("@ComentarioID", _comentarioID);
            cmd.ExecuteNonQuery();
            conexion.Close();
        }


    }
}