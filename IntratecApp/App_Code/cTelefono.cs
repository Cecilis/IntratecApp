using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using IntraTecApp;
using System.Data;
using System.Data.SqlClient;

namespace IntraTecApp
{
    public class cTelefono
    {

        public int IDTelefono { get; set; }
        public String CodPais { get; set; }
        public String CodArea { get; set; }
        public String Numero{ get; set; }
        public String Extension{ get; set; }
        public int IDEmpleado { get; set; }

        String sBDIntraTec = "BD_IntraTec";
      
    }

 
}