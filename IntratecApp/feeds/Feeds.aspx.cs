using System;
using System.Collections.Generic;
using System.Xml;
using System.ServiceModel.Syndication;

namespace IntraTecApp.feeds
{
    public partial class Feeds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int intNumRegxFeeds = Int32.Parse(cConfiguracion.ObtenerAppSettings("NumRegxFeeds"));            

            cPost oPost = new cPost();
            List<cPost> ListaPost = new List<cPost>();
            ListaPost = oPost.TopN(intNumRegxFeeds);

            bool outputRss = (Request.QueryString["Type"] == "RSS");
            bool outputAtom = !outputRss;

            if (outputRss)
            Response.ContentType = "application/oRss20FeedFormatter+xml";
            else if (outputAtom)
            Response.ContentType = "application/oAtom10FeedFormatter+xml";

            // Especificar atributos del Feed
            SyndicationFeed oSyndicationFeed = new SyndicationFeed();
            oSyndicationFeed.Title = TextSyndicationContent.CreatePlaintextContent("FCIB - News");
            oSyndicationFeed.Description = TextSyndicationContent.CreatePlaintextContent(@"Lo más reciente.");
            oSyndicationFeed.Links.Add(SyndicationLink.CreateAlternateLink(cConfiguracion.GetFullyQualifiedUrl2Uri("../Noticias.aspx")));
            oSyndicationFeed.Links.Add(SyndicationLink.CreateSelfLink(cConfiguracion.GetFullyQualifiedUrl2Uri("../Noticias.aspx")));
            oSyndicationFeed.Copyright = TextSyndicationContent.CreatePlaintextContent("Copyright " + cConfiguracion.ObtenerAppSettings("OrganizacionNombreComercial"));
            oSyndicationFeed.Language = cConfiguracion.ObtenerAppSettings("CultureInfo"); 

            // Crear y llenar la lista de SyndicationItems
            List<SyndicationItem> feedItems = new List<SyndicationItem>();
            foreach (cPost item in ListaPost)
            {
                // Atom ListaSyndicationItem MUST have an author, so if there are no authors for this
                // content itemPost then go to next itemPost in loop
                if (outputAtom && item.PosteadoPor.Length == 0)
                    continue;
                SyndicationItem oSyndicationItem = new SyndicationItem();
                oSyndicationItem.Title = TextSyndicationContent.CreatePlaintextContent(item.Titulo);
                oSyndicationItem.Links.Add(SyndicationLink.CreateAlternateLink(cConfiguracion.GetFullyQualifiedUrl2Uri("../Noticias.aspx?ID=" + item.PostID))); //, item.PostID));
                oSyndicationItem.Summary = TextSyndicationContent.CreatePlaintextContent(item.Contenido);
                oSyndicationItem.Categories.Add(new SyndicationCategory("Categoria"));
                oSyndicationItem.PublishDate = item.Fecha;
                //foreach (oSyndicationFeed ta in t.TitleAuthors)
                //{
                    SyndicationPerson oSyndicationPerson = new SyndicationPerson();
                    oSyndicationPerson.Email = cConfiguracion.ObtenerAppSettings("RSSEmail");
                    oSyndicationPerson.Name = item.PosteadoPor;
                    oSyndicationItem.Authors.Add(oSyndicationPerson);
                    // RSS oRssFeedItemList solo especifican tener un autor
                    if (outputRss)
                    break;
                //}
                // Agregar Post (tmpSyndicationItem) a la lista de oRssFeedItemList
                feedItems.Add(oSyndicationItem);
            }
            oSyndicationFeed.Items = feedItems;

            XmlWriter feedWriter = XmlWriter.Create(Response.OutputStream);
            if (outputAtom)
            {
                // Use Atom 1.0       
                Atom10FeedFormatter oAtom10FeedFormatter = new Atom10FeedFormatter(oSyndicationFeed);
                oAtom10FeedFormatter.WriteTo(feedWriter);
            }
            else if (outputRss)
            {
                // Emit RSS 2.0
                Rss20FeedFormatter oRss20FeedFormatter = new Rss20FeedFormatter(oSyndicationFeed);
                oRss20FeedFormatter.WriteTo(feedWriter);
            }
            feedWriter.Close();

       //http://dotnetslackers.com/articles/aspnet/How-to-create-a-syndication-oSyndicationFeed-for-your-website.aspx

        }



  
    }
}