using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class DialogContentPage : System.Web.UI.Page
{
    protected void Page_Init(object sender, EventArgs e)
    {
        // Stop Caching in IE
        Response.Cache.SetCacheability(System.Web.HttpCacheability.NoCache);

        // Stop Caching in Firefox
        Response.Cache.SetNoStore();

        var rows = int.Parse(Request.QueryString["inp1"]);
        var columns = int.Parse(Request.QueryString["inp2"]);

        CreateDynamicTable(rows, columns);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private void CreateDynamicTable(int rows, int columns)
    {
        Table dynamicTable = new Table();
        dynamicTable.ID = "DynamicTable";

        for (int i = 0; i < rows; i++)
        {
            TableRow row = new TableRow();

            for (int j = 0; j < columns; j++)
            {
                TableCell cell = new TableCell();

                TextBox t1 = new TextBox();
                t1.Text = "1";
                cell.Controls.Add(t1);

                row.Cells.Add(cell);
            }

            dynamicTable.Rows.Add(row);
        }

        DynamicPlaceholder.Controls.Add(dynamicTable);
    }

    [System.Web.Services.WebMethod]
    public static string Evaluate_Click(string[] inputArray)
    {
        string result = string.Empty;

        try
        {
            int resultInt = 0;
            foreach (var item in inputArray)
            {
                var input = int.Parse(item);
                resultInt += input;
            }

            result = resultInt.ToString();
        }
        catch (Exception exp)
        {
            result = "error";
        }
        return result;
    }
}