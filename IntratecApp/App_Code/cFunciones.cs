using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;

namespace IntraTecApp
{
    public class cFunciones
    {
        public static string QuitarHTML(string strTextoHTML)
        {
            string strTextoHTMLAux = "";
            strTextoHTMLAux = Regex.Replace(strTextoHTML, @"<(.|\n)*?>", string.Empty);
            return strTextoHTMLAux;
        }

    }
}