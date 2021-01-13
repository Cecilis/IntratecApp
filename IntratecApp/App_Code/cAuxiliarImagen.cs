using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.IO;
using System.Linq;
using System.Reflection;


namespace IntraTecApp
{

    public static class cAuxiliarImagen
    {

        public static readonly string STORED_IMAGE = "ImageFile";
        public static readonly string STORED_IMAGE_NAME = "ImageName";
        public static readonly string STORED_IMAGE_LENGTH = "ImageLength";
        public static readonly string DEFAULT_IMAGE = "ImageDefault";

        public static ImageFormat ObtenerTipoContenido(byte[] oArrBytes)
        {
            MemoryStream oMemoryStream = new MemoryStream(oArrBytes);

            using (BinaryReader oBinaryReader = new BinaryReader(oMemoryStream))
            {
                int LongitudMaxima = oArrFormatoDecodificarImagen.Keys.OrderByDescending(x => x.Length).First().Length;

                byte[] oArrBytesImagen = new byte[LongitudMaxima];

                for (int i = 0; i < LongitudMaxima; i += 1)
                {
                    oArrBytesImagen[i] = oBinaryReader.ReadByte();

                    foreach (var oFormatoDecodificarImagen in oArrFormatoDecodificarImagen)
                    {
                        if (oArrBytesImagen.EmpiezaCon(oFormatoDecodificarImagen.Key))
                        {
                            return oFormatoDecodificarImagen.Value;
                        }
                    }
                }

                throw new ArgumentException("Formato de Imagen no reconocido", "binaryReader");
            }
        }

        private static bool EmpiezaCon(this byte[] BytesInicio, byte[] BytesFinal)
        {
            for (int i = 0; i < BytesFinal.Length; i += 1)
            {
                if (BytesInicio[i] != BytesFinal[i])
                {
                    return false;
                }
            }
            return true;
        }

        private static Dictionary<byte[], ImageFormat> oArrFormatoDecodificarImagen = new Dictionary<byte[], ImageFormat>()
        {
            { new byte[]{ 0x42, 0x4D }, ImageFormat.Bmp},
            { new byte[]{ 0x47, 0x49, 0x46, 0x38, 0x37, 0x61 }, ImageFormat.Gif },
            { new byte[]{ 0x47, 0x49, 0x46, 0x38, 0x39, 0x61 }, ImageFormat.Gif },
            { new byte[]{ 0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A }, ImageFormat.Png },
            { new byte[]{ 0xff, 0xd8 }, ImageFormat.Jpeg },
        };

        private static readonly Dictionary<Guid, string> FormatoImagenConocido =
            (from p in typeof(ImageFormat).GetProperties(BindingFlags.Static | BindingFlags.Public)
             where p.PropertyType == typeof(ImageFormat)
             let value = (ImageFormat)p.GetValue(null, null)
             select new { Guid = value.Guid, Name = value.ToString() })
            .ToDictionary(p => p.Guid, p => p.Name);

        public static string ObtenerNombreFormato(ImageFormat oImageFormat)
        {
            string NombreFormato;
            if (FormatoImagenConocido.TryGetValue(oImageFormat.Guid, out NombreFormato))
                return NombreFormato;
            return null;
        }
    }
}
