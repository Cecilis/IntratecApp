using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;


namespace IntraTecApp
{
    public class cPost
    {
        private static string sBDIntraTec = "BD_IntraTec";

        private int _postID;
        private string _titulo;
        private string _posteadoPor;
        private string _descripcion;
        private string _contenido;
        private DateTime _fecha;
        private bool _publicado;
        private int _comentarios;

        public int PostID
        { get { return _postID; } set { _postID = value; } }
        public string Titulo
        { get { return _titulo; } set { _titulo = value; } }
        public string PosteadoPor
        { get { return _posteadoPor; } set { _posteadoPor = value; } }
        public string Descripcion
        { get { return _descripcion; } set { _descripcion = value; } }
        public string Contenido
        { get { return _contenido; } set { _contenido = value; } }
        public DateTime Fecha
        { get { return _fecha; } set { _fecha = value; } }
        public bool Publicado
        { get { return _publicado; } set { _publicado = value; } }
        public int Comentarios
        { get { return _comentarios; } set { _comentarios = value; } }

        public int ImgFondoLong { get; set; }

        public string NombreImagenFondo { get; set; }

        public byte[] ImgFondo { get; set; }

        public cPost()
        {
            _postID = 0;
            _titulo = String.Empty;
            _posteadoPor = String.Empty;
            _descripcion = String.Empty;
            _contenido = String.Empty;
            _fecha = new DateTime(2000, 1, 1);
            _publicado = true;
            _comentarios = 0;
            ImgFondoLong = 0;
            NombreImagenFondo = String.Empty;
            ImgFondo = null;

        }

        public static string _cnString
        {
            get
            {
                return ConfigurationManager.ConnectionStrings["BD_IntraTec"].ConnectionString;
            }
        }

        public static void TopPost(cPost item, SqlDataReader reader)
        {
            item.PostID = reader.GetInt32(0);
            item.Titulo = reader.GetString(1);
            item.PosteadoPor = reader.GetString(2);
            item.Descripcion = reader.GetString(3);
            item.Contenido = reader.GetString(4);
            item.Fecha = reader.GetDateTime(5);
            item.Publicado = reader.GetBoolean(6);
            item.Comentarios = reader.GetInt32(7);

            if (reader[8] != DBNull.Value)
            {
                item.ImgFondo = (byte[])reader[8];
                item.NombreImagenFondo = ((string)reader.GetSqlString(9)).Trim().ToUpperInvariant();
                item.ImgFondoLong = (int)reader.GetInt32(10);
            }
            else
            {
                item.ImgFondo = null;
                item.NombreImagenFondo = String.Empty;
                item.ImgFondoLong = 0;
            }
        }

        public cPost (int postID)
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            try 
            {        
                string SQLQuery = string.Empty;

                conexion.Open();

                if (postID == 0)
                    SQLQuery = "SELECT Top 1 PostID, Titulo, PosteadoPor, Descripcion, Contenido, Fecha, Publicado, Comentarios,  ImgFondo, NombreImagenFondo, ImgFondoLong FROM Post ORDER BY PostID ASC";
                else
                    SQLQuery = "SELECT PostID, Titulo, PosteadoPor, Descripcion, Contenido, Fecha, Publicado, Comentarios,  ImgFondo, NombreImagenFondo, ImgFondoLong FROM Post WHERE PostID = @postID";

                SqlCommand cmd = new SqlCommand(SQLQuery, conexion);
                cmd.Parameters.AddWithValue("@PostID", postID); //le quite el underscore
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    cPost.TopPost(this, reader);
                }
                reader.Close();
                 if (!(conexion.State == System.Data.ConnectionState.Closed))
                {
                    conexion.Close();
                };               
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void Crear()
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            try
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("INSERT INTO Post (Titulo, PosteadoPor, Descripcion, Contenido, Fecha, Publicado, Comentarios, ImgFondo, NombreImagenFondo, ImgFondoLong) VALUES (@Titulo, @PosteadoPor, @Descripcion, @Contenido, @Fecha, @Publicado, @Comentarios, @ImgFondo, @NombreImagenFondo, @ImgFondoLong)", conexion);
                cmd.Parameters.AddWithValue("@Titulo", _titulo);
                cmd.Parameters.AddWithValue("@PosteadoPor", _posteadoPor);
                cmd.Parameters.AddWithValue("@Descripcion", _descripcion);
                cmd.Parameters.AddWithValue("@Contenido", _contenido);
                cmd.Parameters.AddWithValue("@Fecha", _fecha);
                cmd.Parameters.AddWithValue("@Publicado", _publicado);
                cmd.Parameters.AddWithValue("@Comentarios", _comentarios);
                cmd.Parameters.AddWithValue("@ImgFondo", ImgFondo);
                cmd.Parameters.AddWithValue("@NombreImagenFondo", NombreImagenFondo);
                cmd.Parameters.AddWithValue("@ImgFondoLong", ImgFondoLong);
                cmd.ExecuteNonQuery();
                cmd.Parameters.Clear();
                cmd.CommandText = "SELECT @@IDENTITY";
                _postID = Convert.ToInt32(cmd.ExecuteScalar());
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally {
                if (!(conexion.State == System.Data.ConnectionState.Closed))
                {
                    conexion.Close();
                };             
            }
        }

        public void Actualizar()
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            try
            {
                conexion.Open();
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Comentario WHERE PostID = @PostID", conexion);
                cmd.Parameters.AddWithValue("@PostID", _postID);
                _comentarios = Convert.ToInt32(cmd.ExecuteScalar());
                cmd.CommandText = "UPDATE Post SET Titulo = @Titulo, PosteadoPor = @PosteadoPor, Descripcion = @Descripcion, Contenido = @Contenido, Fecha = @Fecha, Publicado = @Publicado, Comentarios = @Comentarios, ImgFondo = @ImgFondo, NombreImagenFondo = @NombreImagenFondo, ImgFondoLong = @ImgFondoLong  WHERE PostID = @PostID";
                cmd.Parameters.AddWithValue("@Titulo   ", _titulo);
                cmd.Parameters.AddWithValue("@PosteadoPor", _posteadoPor);
                cmd.Parameters.AddWithValue("@Descripcion", _descripcion);
                cmd.Parameters.AddWithValue("@Contenido", _contenido);
                cmd.Parameters.AddWithValue("@Fecha", _fecha);
                cmd.Parameters.AddWithValue("@Publicado", _publicado);
                cmd.Parameters.AddWithValue("@Comentarios", _comentarios);
                cmd.Parameters.AddWithValue("@ImgFondo", ImgFondo);
                cmd.Parameters.AddWithValue("@NombreImagenFondo", NombreImagenFondo);
                cmd.Parameters.AddWithValue("@ImgFondoLong", ImgFondoLong);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally {
                if (!(conexion.State == System.Data.ConnectionState.Closed))
                {
                    conexion.Close();
                };             
            }
        }

        public void Eliminar()
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            conexion.Open();
            SqlTransaction oTransaction = conexion.BeginTransaction();
            try
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Comentario WHERE PostID = @PostID", conexion);
                cmd.Transaction = oTransaction;
                cmd.Parameters.AddWithValue("@PostID", _postID);
                cmd.ExecuteNonQuery();
                cmd.CommandText = "DELETE FROM Post WHERE PostID = @PostID";
                cmd.ExecuteNonQuery();
                oTransaction.Commit();
            }
            catch (Exception ex)
            {
                oTransaction.Rollback();
                throw ex;
            }
            finally
            {
                _postID = 0;
                conexion.Close();
            }
        }

        public List<cCategoria> ObtenerCategorias()
        {
            SqlConnection conexion;
            try
            {
                conexion = new SqlConnection(_cnString);
                conexion.Open();
                SqlCommand cmd = new SqlCommand("SELECT Categoria.CategoriaID, Categoria.Nombre FROM Categoria INNER JOIN PostCategoria ON Categoria.CategoriaID = PostCategoria.CategoriaID WHERE PostCategoria.PostID = @PostID ORDER BY Categoria.Nombre", conexion);
                cmd.Parameters.AddWithValue("@PostID", _postID);
                SqlDataReader reader = cmd.ExecuteReader();
                List<cCategoria> list = new List<cCategoria>();
                while (reader.Read())
                {
                    cCategoria c = new cCategoria();
                    c.CategoriaID = reader.GetInt32(0);
                    c.Nombre = reader.GetString(1);
                    list.Add(c);
                }
                reader.Close();
                return list;
            }
            catch (Exception ex) 
            {
              throw ex;  
            }
        }

        public void AgregarCategoria(cCategoria c)
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            
            try
            {
                conexion.Open();
                SqlCommand command = new SqlCommand("INSERT INTO PostCategoria (PostID, CategoriaID) VALUES (@PostID, @CategoriaID)", conexion);
                command.Parameters.AddWithValue("@PostID", _postID);
                command.Parameters.AddWithValue("@CategoriaID", c.CategoriaID);
                command.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally {
                if (!(conexion.State == System.Data.ConnectionState.Closed))
                {
                    conexion.Close();
                };           
            }
        }

        public void BorrarCategorias()
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            try
            {
                conexion.Open();
                SqlCommand command = new SqlCommand("DELETE FROM PostCategoria WHERE PostID = @PostID", conexion);
                command.Parameters.AddWithValue("@PostID", _postID);
                command.ExecuteNonQuery();
                
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally {
                if (!(conexion.State == System.Data.ConnectionState.Closed)) { 
                    conexion.Close();               
                }
            }
        }

        public List<cComentario> ObtenerComentarios()
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            conexion.Open();
            SqlCommand cmd = new SqlCommand("SELECT ComentarioID, PostID, Fecha, Nombre, Url, Contenido FROM Comentario WHERE PostID = @PostID ORDER BY Fecha", conexion);
            cmd.Parameters.AddWithValue("@PostID", _postID);
            SqlDataReader reader = cmd.ExecuteReader();
            List<cComentario> list = new List<cComentario>();
            while (reader.Read())
            {
                cComentario c = new cComentario();
                c.ComentarioID = reader.GetInt32(0);
                c.PostID = reader.GetInt32(1);
                c.Fecha = reader.GetDateTime(2);
                c.Nombre = reader.GetString(3);
                c.Url = reader.GetString(4);
                c.Contenido = reader.GetString(5);
                list.Add(c);
            }
            reader.Close();
            conexion.Close();
            return list;
        }

        public static List<cPost> Obtener10()
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            conexion.Open();
            List<cPost> oListaPost = new List<cPost>();
            SqlCommand cmd = new SqlCommand("SELECT TOP 10 PostID, Titulo, PosteadoPor, Descripcion, Contenido, Fecha, Publicado, Comentarios,  ImgFondo, NombreImagenFondo, ImgFondoLong FROM Post WHERE Publicado = 1 ORDER BY Fecha DESC", conexion);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                cPost item = new cPost();
                cPost.TopPost(item, reader);
                oListaPost.Add(item);
            }
            reader.Close();
            conexion.Close();
            return oListaPost;
        }

        public static List<cPost> Obtener10(int categoriaID)
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            conexion.Open();
            List<cPost> list = new List<cPost>();
            SqlCommand cmd = new SqlCommand("SELECT TOP 10 Post.PostID, Post.Titulo, Post.PosteadoPor, Post.Descripcion, Post.Contenido, Post.Fecha, Post.Publicado, Post.Comentarios,  Post.ImgFondo, Post.NombreImagenFondo, Post.ImgFondoLong FROM Post INNER JOIN PostCategoria ON Post.PostID = PostCategoria.PostID WHERE Post.Publicado = 1 AND PostCategoria.CategoriaID = @CategoriaID ORDER BY Post.Fecha DESC", conexion);
            cmd.Parameters.AddWithValue("@CategoriaID", categoriaID);
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                cPost item = new cPost();
                cPost.TopPost(item, reader);
                list.Add(item);
            }
            reader.Close();
            conexion.Close();
            return list;
        }

        public static List<cPost> BuscarPostPorTitulo(string busqueda)
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            conexion.Open();
            List<cPost> oListaPost = new List<cPost>();
            SqlCommand cmd = new SqlCommand("SELECT PostID, Titulo, PosteadoPor, Descripcion, Contenido, Fecha,Publicado, Comentarios,  ImgFondo, NombreImagenFondo, ImgFondoLong FROM Post WHERE Titulo LIKE '%' + @Busqueda + '%' ORDER BY Fecha DESC", conexion);
            cmd.Parameters.AddWithValue("@Busqueda", busqueda.Trim());
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                cPost item = new cPost();
                cPost.TopPost(item, reader);
                oListaPost.Add(item);
            }
            reader.Close();
            conexion.Close();
            return oListaPost;
        }

        public static List<cPost> ObtenerPorMes(int mes, int anio)
        {
            SqlConnection conexion = new SqlConnection(_cnString);
            conexion.Open();
            List<cPost> list = new List<cPost>();
            SqlCommand command = new SqlCommand("SELECT Post.PostID, Post.Titulo, Post.PosteadoPor, Post.Descripcion, Post.Contenido, Post.Fecha, Post.Publicado, Post.Comentarios FROM Post WHERE Post.Publicado = 1 AND Post.Fecha > @Inicio AND Post.Fecha < @Fin ORDER BY Post.Fecha DESC", conexion);
            command.Parameters.AddWithValue("@Inicio", cAjustarTiempo.GetReverseAdjustedTime(new DateTime(anio, mes, 1).AddSeconds(-1)));
            command.Parameters.AddWithValue("@Fin", cAjustarTiempo.GetReverseAdjustedTime(new DateTime(anio, mes, 1, 0, 0, 0).AddMonths(1)));
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                cPost item = new cPost();
                cPost.TopPost(item, reader);
                list.Add(item);
            }
            reader.Close();
            conexion.Close();
            return list;
        }



       public List<cPost> TopN(int NumReg)
        {
            List<IDataParameter> ListaParametros = new List<IDataParameter>();
            SqlDataReader oSqlDataReader;
            List<cPost> ListaPost = new List<cPost>();
            String sProcAlmacenado = "spBuscarNPost";
            try
            {
                cConexionDatosGenerica oConBDIntraTec = new cConexionDatosGenerica(cConexionDatosGenerica.PROVIDER_SQLCLIENT);
                oConBDIntraTec.getConnection(sBDIntraTec);

                System.Data.IDataParameter oIDataParameter;
                oIDataParameter = new SqlParameter("@NumReg", NumReg);
                ListaParametros.Add(oIDataParameter);

                oSqlDataReader = (SqlDataReader)oConBDIntraTec.executeReaderGetDataReader(sProcAlmacenado, ListaParametros);

                if (oSqlDataReader.HasRows)
                {
                    while (oSqlDataReader.Read())
                    {
                        cPost itemPost = new cPost();
                        cPost.TopPost(itemPost, oSqlDataReader);
                        ListaPost.Add(itemPost);
                    }
                }

                ListaParametros.Clear();
                oSqlDataReader = null;
                oConBDIntraTec.closeConnection();
                return ListaPost;
            }
            catch (Exception ex)
            {
                throw new Exception("Error al obtener post. Detalles: " + ex.Message.ToString());
            }
        }





    }
}