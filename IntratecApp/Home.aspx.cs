using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Reflection;
using System.ServiceModel.Syndication;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

namespace IntraTecApp
{
    public partial class Home : System.Web.UI.Page
    {
        public class cFeedReader
        {
            public string TituloFeed { get; set; }
            public string NombreFeed { get; set; }
            public string URLFeed { get; set; }

            public cFeedReader()
            {
                TituloFeed = "";
                NombreFeed = "";
                URLFeed = "";
            }
        }

        public static DataTable ConvertToDataTable<T>(IList<T> list)
        {
            DataTable table = new DataTable();
           
            FieldInfo[] fields = typeof(T).GetFields();
            foreach (FieldInfo field in fields)
            {
                table.Columns.Add(field.Name, field.FieldType);
            }
            foreach (T item in list)
            {
                DataRow row = table.NewRow();
                foreach (FieldInfo field in fields)
                {
                    row[field.Name] = field.GetValue(item);
                }
                table.Rows.Add(row);
            }
            return table;
        }

        public static DataTable ObtenerDataTable<T>(IList<T> list)
        {
            DataTable table = new DataTable();

            FieldInfo[] fields = typeof(T).GetFields();
            foreach (FieldInfo field in fields)
            {
                table.Columns.Add(field.Name, field.FieldType);
            }
            foreach (T item in list)
            {
                DataRow row = table.NewRow();
                foreach (FieldInfo field in fields)
                {
                    row[field.Name] = field.GetValue(item);
                }
                table.Rows.Add(row);
            }
            return table;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {

                try
                {
                    int intNroIntentosMaximos = Int32.Parse(cConfiguracion.ObtenerAppSettings("NumRegxFeeds"));

                    List<cURLFeeds> lstURLFeeds = cURLFeedsMetodos.ObtenerTodosActivos(intNroIntentosMaximos);
                    if (lstURLFeeds.Count > 0)
                    {
                        rptListaFeeds.DataSource = lstURLFeeds;
                        rptListaFeeds.DataBind();
                    }
                    else
                    {
                        lblResultado.CssClass = "EResultado";
                        lblResultado.Text = "No hay feeds disponibles.";
                    }
                }
                catch (Exception ex)
                {
                    lblResultado.CssClass = "EResultado";
                    lblResultado.Text = ex.Message.ToString();
                }
            }
        }

        public DataSet CreateDataSet<T>(List<T> list, DataSet dataSet)
        {

            if (list == null || list.Count == 0) { return null; }
            var obj = list[0].GetType();
            var properties = obj.GetProperties();
            if (properties.Length == 0) { return null; }

            //var dataSet = new DataSet();
            var dataTable = new DataTable();

            var columns = new DataColumn[properties.Length];
            for (int i = 0; i < properties.Length; i++)
            {
                columns[i] = new DataColumn(properties[i].Name, properties[i].PropertyType);
            }
            dataTable.Columns.AddRange(columns);
            foreach (var item in list)
            {
                var dataRow = dataTable.NewRow();
                var itemProperties = item.GetType().GetProperties();
                for (int i = 0; i < itemProperties.Length; i++)
                {
                    dataRow[i] = itemProperties[i].GetValue(item, null);
                }
                dataTable.Rows.Add(dataRow);
            }
            dataSet.Tables.Add(dataTable);
            return dataSet;
        }

        public DataSet CreateDataSet<T>(List<T> list)
        {

            if (list == null || list.Count == 0) { return null; }
            var obj = list[0].GetType();
            var properties = obj.GetProperties();
            if (properties.Length == 0) { return null; }
            var dataSet = new DataSet();
            var dataTable = new DataTable();

            var columns = new DataColumn[properties.Length];
            for (int i = 0; i < properties.Length; i++)
            {
                columns[i] = new DataColumn(properties[i].Name, properties[i].PropertyType);
            }
            dataTable.Columns.AddRange(columns);
            foreach (var item in list)
            {
                var dataRow = dataTable.NewRow();
                var itemProperties = item.GetType().GetProperties();
                for (int i = 0; i < itemProperties.Length; i++)
                {
                    dataRow[i] = itemProperties[i].GetValue(item, null);
                }
                dataTable.Rows.Add(dataRow);
            }
            dataSet.Tables.Add(dataTable);
            return dataSet;
        }

        [WebMethod()]
        public static List<Imagen> Galeria()
        {
            List<Imagen> listImagenes = new List<Imagen>();

            string strCarpetaImagenesGaleria = cConfiguracion.ObtenerAppSettings("CarpetaImagenesGaleria");

            DirectoryInfo dir = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + strCarpetaImagenesGaleria);
            FileInfo[] fileList = dir.GetFiles("*.*", SearchOption.AllDirectories);

            var fileQuery = from file in fileList
                            where file.Extension == ".jpg"
                            || file.Extension == ".jpeg"
                            || file.Extension == ".png"
                            || file.Extension == ".gif"
                            orderby file.Name
                            select file;

            foreach (var file in fileQuery)
            {
                listImagenes.Add(new Imagen(strCarpetaImagenesGaleria + "/" + file.Name));
            }
            return listImagenes;
        }

        public string ConstRssFeedUrl { get; set; }
    }

    public class Imagen
    {
        public string rutaImagen { get; set; }
        public Imagen (string strRutaImagen)
        {
            //string strExtension = Path.GetExtension(strRutaImagen).ToString().Replace(".", "");
            //cManejaImagenes  oManejaImagenes = new cManejaImagenes();
            //byte[] oArrByteImagen = oManejaImagenes.Imagen_A_Bytes(strRutaImagen);
            //string strImagenBase64 = System.Convert.ToBase64String(oArrByteImagen, 0, oArrByteImagen.Length);
            //rutaImagen = @"data:image/" + strExtension + ";base64," + @strImagenBase64;
            rutaImagen = @strRutaImagen;
        }
    }
}