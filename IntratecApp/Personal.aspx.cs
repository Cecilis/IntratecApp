using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using IntraTecApp;

namespace IntraTecApp
{
    public partial class Personal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
            DataSet oDataset = cEmpleado.MostrarEnGaleria();

            rptPersona.DataSource = oDataset.Tables["EmpleadosAdmin"];
            rptPersona.DataBind();
            
            System.Threading.Thread.Sleep(3000); 
        }
    }
}