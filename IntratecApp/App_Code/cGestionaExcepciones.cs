using System;
using System.IO;
using System.Web;

namespace IntraTecApp
{
    public sealed class cGestionaExcepciones
    {
        //No quitar
        private cGestionaExcepciones()
        { }

        // Guarda el Log de la excepción
        public static void RegistrarLog(Exception oException, string strOrigen)
        {
            string strHoy = DateTime.Today.ToString("yyyyMMdd");
            
            string strCarpetaLog = cConfiguracion.ObtenerAppSettings("ArchivoLog");
            string strArchivoLog = strHoy + "ErrorLog.txt";

            if (!Directory.Exists(@HttpContext.Current.Server.MapPath(strCarpetaLog)))
                Directory.CreateDirectory(@HttpContext.Current.Server.MapPath(strCarpetaLog));

            strArchivoLog = Path.Combine(@HttpContext.Current.Server.MapPath(strCarpetaLog), strArchivoLog);
            lock("Grabar")
            {
                using (StreamWriter oStreamWriter = new StreamWriter(strArchivoLog, true))
                {
                    oStreamWriter.WriteLine("********** {0} **********", DateTime.Now);
                    if (oException.InnerException != null)
                    {
                        oStreamWriter.Write("Inner Exception Type: ");
                        oStreamWriter.WriteLine(oException.InnerException.GetType().ToString());
                        oStreamWriter.Write("Inner Exception: ");
                        oStreamWriter.WriteLine(oException.InnerException.Message);
                        oStreamWriter.Write("Inner Source: ");
                        oStreamWriter.WriteLine(oException.InnerException.Source);
                        if (oException.InnerException.StackTrace != null)
                        {
                            oStreamWriter.WriteLine("Inner Stack Trace: ");
                            oStreamWriter.WriteLine(oException.InnerException.StackTrace);
                        }
                    }
                    oStreamWriter.Write("Exception Type: ");
                    oStreamWriter.WriteLine(oException.GetType().ToString());
                    oStreamWriter.WriteLine("Exception: " + oException.Message);
                    oStreamWriter.WriteLine("Source: " + strOrigen);
                    oStreamWriter.WriteLine("Stack Trace: ");
                    if (oException.StackTrace != null)
                    {
                        oStreamWriter.WriteLine(oException.StackTrace);
                        oStreamWriter.WriteLine();
                    }
                    oStreamWriter.Close();
                }
            }
        }

        // Notificación 
        public static void GenerarNotificacion(Exception oException)
        {

        }
    }
}