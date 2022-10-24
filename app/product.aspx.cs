using System;
using System.Data;
using pos.app.classes;
using System.Web.UI.WebControls;

namespace pos.app
{
    public partial class product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetCategory();
                BindWarehouse();
                BindItems();
                BindItemsDetail();
            }
        }
        public Tuple<string,string> GetStockInfo(string itemName)
        {
            string reorderPoint = "";
            string unit = "";
            SQLOperation sqlop = new SQLOperation("select * from tblstock_details where item_name = '" + itemName + "' ");
            if(sqlop.ReadTable().Rows.Count != 0)
            {
                reorderPoint = sqlop.ReadTable().Rows[0]["reorder_point"].ToString();
                unit = sqlop.ReadTable().Rows[0]["unit"].ToString();
            }
            return Tuple.Create(reorderPoint,unit);
        }
        public string GetStockBalance(string itemName)
        {
            string balance = "";
            SQLOperation sqlop = new SQLOperation("select * from tblstock where item_name = '" + itemName + "' LIMIT 1");
            if (sqlop.ReadTable().Rows.Count != 0)
            {
                balance = sqlop.ReadTable().Rows[0]["balance"].ToString();
            }
            return balance;
        }
        private void BindItemsDetail()
        {
            if (Request.QueryString["pid"] != null && Request.QueryString["pname"] != null)
            {
                productDiv.Visible = false;
                productDetailDiv.Visible = true;
                buttonback.Visible = true;
                itemDetailSpan.Visible = true;
                itemDetailSpan.InnerText = Request.QueryString["pname"].ToString();
                itemDrop.Visible = false;
                itemDropIcon.Visible = false;

                btnAdjustItemsModalButton.Visible = true;
                btnEditItemModalButton.Visible = true;
                btnDeleteItemModalButton.Visible = true;
                SQLOperation sqlops = new SQLOperation("select* from tblstock_details");

                rptpProductDetail.DataSource = sqlops.ReadTable();
                rptpProductDetail.DataBind();

                SQLOperation sqlop = new SQLOperation("select* from tblstock_details where item_name='" + Request.QueryString["pname"].ToString() + "' and id = '" + Request.QueryString["pid"].ToString() + "'");
                DataTable dt = sqlop.ReadTable();

                itemName.InnerText = Request.QueryString["pname"].ToString();

                //Binding Stock Details Information
                if (dt.Rows.Count != 0)
                {
                    unitSpan.InnerText = dt.Rows[0]["unit"].ToString();
                    manufacturerSpan.InnerText = dt.Rows[0]["manufacturer"].ToString();
                    createdSourceSpan.InnerText = dt.Rows[0]["created_source"].ToString();

                    purchasePriceSpan.InnerText = dt.Rows[0]["purchase_price"].ToString();
                    sellingPriceSpan.InnerText = dt.Rows[0]["sale_price"].ToString();
                    warehouseNameSpan.InnerText = dt.Rows[0]["warehouse"].ToString();
                    commitedStock.InnerText = "";
                    availableForSale.InnerText ="";
                    openingStock.InnerText = dt.Rows[0]["opening_stock"].ToString();
                 

                    //Binding Items Account

                }
                sqlop.cmdText = "select * from tblitems_account where item_name = '" + Request.QueryString["pname"].ToString() + "'";
                DataTable dtAccount = sqlop.ReadTable();
                if (dtAccount.Rows.Count != 0)
                {
                    salesAccountSpan.InnerText = dtAccount.Rows[0]["sales_account"].ToString();
                    purchaseAccountSpan.InnerText = dtAccount.Rows[0]["purchase_account"].ToString();
                    inventoryAccountSpan.InnerText = dtAccount.Rows[0]["inventory_account"].ToString();
                }
            }
        }
        private void BindItems()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblstock_details");
            DataTable dt = sqlop.ReadTable();
            rptrProducts.DataSource = dt;
            rptrProducts.DataBind();
        }
        private void BindWarehouse()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblwarehouse");
            DataTable dt = sqlop.ReadTable();
            ddlWarehouse.DataSource = dt;
            ddlWarehouse.DataTextField = "name";
            ddlWarehouse.DataBind();
            ddlWarehouse.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        private void GetCategory()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblstock_category");
            DataTable dt = sqlop.ReadTable();
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "category_name";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        protected void btnCreateItem_Click(object sender, EventArgs e)
        {
            StoreOperation so = new StoreOperation(txtItemName.Text)
            {
                ItemCode = txtItemCode.Text,
                ItemCategory = ddlCategory.SelectedItem.Text,
                ShelfNo = txtItemCode.Text,
                Barcode = txtBarcode.Text,
                Description = txtDescriptionDetail.Text,
                PurchasePrice = txtPurchasePrice.Text,
                SalePrice = txtSalesPrice.Text,
                Unit = txtUnit.Text,
                SKU = txtSKU.Text,
                Manufacturer = txtManufacturer.Text,
                ReorderPoint = txtReoderPoint.Text,
                TaxRate = txtTax.Text,
                Quantity = txtOpening.Text,
                Date = DateTime.Now.Date.ToString(),
                Warehouse = ddlWarehouse.SelectedItem.Text,
                ExpiredDate = "None"
            };
            so.AddItem();
        }
        protected void btnSaveCategory_Click(object sender, EventArgs e)
        {
            StoreOperation so = new StoreOperation();
            so.Category = txtItemCategory.Text;
            so.AddCategory();
        }
        protected void btnSaveWarehouse_Click(object sender, EventArgs e)
        {
            StoreOperation so = new StoreOperation();
            so.Warehouse = txtWarehouseName.Text;
            so.WarehouseAddress = txtAddress.Text;
            so.CreateWarehouse();
        }
        protected void btnPrevious_Click(object sender, EventArgs e)
        {

        }
        protected void btnNext_Click(object sender, EventArgs e)
        {

        }
        protected void btnAdjustItems_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["pid"] != null && Request.QueryString["pname"] != null)
            {
                StoreOperation so = new StoreOperation(Request.QueryString["pname"].ToString())
                {
                    Description = "Quantity adjusted for "+ddlAdjustmentReason.SelectedItem.Text+" @"+DateTime.Now.ToString(),
                    Quantity = txtQuantityAdjusted.Text,
                    Date = DateTime.Now.Date.ToString(),
                    Warehouse = warehouseNameSpan.InnerText,
                    ExpiredDate = "None"
                };
                if(Convert.ToDouble(txtQuantityAdjusted.Text) > 0)
                {
                    so.AddItemToStock();
                }
                else
                {
                    so.RemoveItemFromStock(DateTime.Now.ToString(), txtQuantityAdjusted.Text);
                }
                so.AddProductHistory();
            }
            Response.Redirect(Request.RawUrl);
        }
        protected void btnDeleteItems_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["pid"] != null && Request.QueryString["pname"] != null)
            {
                SQLOperation sqlop = new SQLOperation("delete from tblstock where item_name = '" + Request.QueryString["pname"] + "'");
                sqlop.MakeCUD();

                sqlop.cmdText = "delete from tblstock_details where item_name = '" + Request.QueryString["pname"] + "'";
                sqlop.MakeCUD();

                sqlop.cmdText = "delete from tblproduct_history where item_name = '" + Request.QueryString["pname"] + "'";
                sqlop.MakeCUD();

                sqlop.cmdText = "delete from tblproduct_image where item_name = '" + Request.QueryString["pname"] + "'";
                sqlop.MakeCUD();
                Response.Redirect("product.aspx");
            }
        }
    }
}