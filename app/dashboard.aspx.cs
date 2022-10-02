using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using pos.app.classes;
using System.Web.Services;
namespace pos.app
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        [System.Web.Script.Services.ScriptMethod()]
        public static void AddItem(string itemName)
        {
            StoreOperation so = new StoreOperation()
            {
                ItemName = itemName
            };
            so.AddItem();

        }
    }
}