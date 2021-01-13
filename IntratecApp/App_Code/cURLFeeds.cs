using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IntraTecApp
{
    
    public class cURLFeeds
    {
        public int IDURLFeed {get;set;}
        public string Titulo { get; set; }
        public string URLFeed {get;set;}
        public string TipoFeed {get;set;}
        public string Propietario { get; set; }
        public string Estado { get; set; }

        public cURLFeeds()
        {
            IDURLFeed = 0;
            Titulo = "";
            URLFeed = "";
            TipoFeed = "";
            Estado = "1";        
        }


    }
}