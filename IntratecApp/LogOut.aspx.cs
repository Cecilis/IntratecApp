using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Threading;

namespace IntraTecApp
{
    public partial class LogOut : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Abandon();
            Cache.Remove("oListaFeeds");
            Session["Accesos"] = "NOTOK";
            Thread.Sleep(8000);
            Page.ClientScript.RegisterStartupScript(GetType(), "Reload", "parent.location.reload();", true);
        }
    }
}