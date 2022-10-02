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
            }
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
    }
}