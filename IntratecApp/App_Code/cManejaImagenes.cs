using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.IO;

namespace IntraTecApp
{
    public class cManejaImagenes
    {
        //METODO PARA REDIMENSIONAR LA IMAGEN
        public String Redimensionar(System.Drawing.Image Imagen_Original, string nombre)
        {
            //RUTA DEL DIRECTORIO TEMPORAL
            String DirTemp = Path.GetTempPath() + @"\" + nombre + ".jpg";
            //IMAGEN ORIGINAL A REDIMENSIONAR
            Bitmap imagen = new Bitmap(Imagen_Original);
            //CREAMOS UN MAPA DE BIT CON LAS DIMENSIONES QUE QUEREMOS PARA LA NUEVA IMAGEN
            Bitmap nuevaImagen = new Bitmap(Imagen_Original.Width, Imagen_Original.Height);
            //CREAMOS UN NUEVO GRAFICO
            Graphics gr = Graphics.FromImage(nuevaImagen);
            //DIBUJAMOS LA NUEVA IMAGEN
            gr.DrawImage(imagen, 0, 0, nuevaImagen.Width, nuevaImagen.Height);
            //LIBERAMOS RECURSOS
            gr.Dispose();
            //GUARDAMOS LA NUEVA IMAGEN ESPECIFICAMOS LA RUTA Y EL FORMATO
            nuevaImagen.Save(DirTemp, System.Drawing.Imaging.ImageFormat.Jpeg);
            //LIBERAMOS RECURSOS
            nuevaImagen.Dispose();
            imagen.Dispose();
            return DirTemp;
        }

        //FUNCION PARA CONVERTIR LA IMAGEN A BYTES
        public Byte[] Imagen_A_Bytes(String strRuta)
        {
            using (FileStream oFileStream = new FileStream(strRuta, FileMode.OpenOrCreate, FileAccess.ReadWrite))
            {
                Byte[] oArrBytes = new Byte[oFileStream.Length];
                BinaryReader oBinaryReader = new BinaryReader(oFileStream);
                oArrBytes = oBinaryReader.ReadBytes(Convert.ToInt32(oFileStream.Length));
                return oArrBytes;
            }
        }

        public void Imagen2Bytes(String ruta, ref Byte[] arreglo, ref int tamaño)
        {
            FileStream foto = new FileStream(ruta, FileMode.OpenOrCreate, FileAccess.Read);
            arreglo = new Byte[foto.Length];
            BinaryReader reader = new BinaryReader(foto);
            arreglo = reader.ReadBytes(Convert.ToInt32(foto.Length));
            tamaño = Convert.ToInt32(foto.Length);
        }

        //FUNCION PARA CONVERTIR DE BYTES A IMAGEN
        public Image Bytes_A_Imagen(Byte[] ImgBytes)
        {
            Bitmap imagen = null;
            Byte[] bytes = (Byte[])(ImgBytes);
            MemoryStream ms = new MemoryStream(bytes);
            imagen = new Bitmap(ms);
            return imagen;
        }


        public string CodificarFoto(string sNombreArchivo)
        {
            string sBase64 = "";
            // Declaramos fs para tener acceso a la imagen residente en la maquina cliente.
            FileStream fs = new FileStream(sNombreArchivo, FileMode.Open);
            // Declaramos un Leector Binario para accesar a los datos de la imagen pasarlos a un arreglo de bytes
            BinaryReader br = new BinaryReader(fs);
            byte[] bytes = new byte[(int)fs.Length];
            try
            {
                br.Read(bytes, 0, bytes.Length);
                // base64 es la cadena en donde se guarda el arreglo de bytes ya convertido
                sBase64 = Convert.ToBase64String(bytes);
                return sBase64;
            }
            catch
            {
                //MessageBox.Show("Ocurri un error al cargar la fotografa.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Asterisk, MessageBoxDefaultButton.Button1);
                return null;
            }
            // Se cierran los archivos para liberar memoria.
            finally
            {
                fs.Close();
                fs = null;
                br = null;
                bytes = null;
            }
        }

        public string DecodificarFoto(string sBase64)
        {
            // Declaramos fs para tener crear un nuevo archivo temporal en la maquina cliente.
            // y memStream para almacenar en memoria la cadena recibida.
            string sImagenTemporal = @"c:foto-decodificada.jpg";
            FileStream fs = new FileStream(sImagenTemporal, FileMode.Create);
            BinaryWriter bw = new BinaryWriter(fs);
            byte[] bytes;
            try
            {
                bytes = Convert.FromBase64String(sBase64);
                bw.Write(bytes);
                return sImagenTemporal;
            }
            catch
            {
                //MessageBox.Show("Ocurrió un error al leer la imgen.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Asterisk, MessageBoxDefaultButton.Button1);
                return sImagenTemporal = @"c:no-disponible.jpg";
            }
            finally
            {
                fs.Close();
                bytes = null;                                                                                                                                                                                                                                                                                                                                   
                bw = null;
                sBase64 = null;
            }
        }
    }
}