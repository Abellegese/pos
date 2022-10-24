using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace pos.app.classes
{
    public class StoreOperation : SQLOperation, IStore
    {
        public string Quantity { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        public string ItemCategory { get; set; }
        public string ShelfNo { get; set; }  
        public string Barcode { get; set; }
        public string Date { get; set; }
        public string ExpiredDate { get; set; }
        public string Warehouse { get; set; }
        public string WarehouseAddress { get; set; }
        public string Description { get; set; }
        public string PurchasePrice { get; set; }
        public string SalePrice { get; set; }
        public string IssuedPerson { get; set; }
        public string Unit { get; set; }
        public string SKU { get; set; }
        public string Manufacturer { get; set; }
        public string ReorderPoint { get; set; }
        public string TaxRate { get; set; }
        public string Category { get; set; }
        public string CreatedSource { get; set; }
        public StoreOperation() { }
        public StoreOperation(string ProductName, string cmdText) : base(cmdText) => this.ItemName = ProductName;
        public StoreOperation(string ProductName) => this.ItemName = ProductName;
        public void AddItem()
        {
            string tableColumns = "";
            tableColumns += "(item_name,item_code,item_category,shelf_no,barcode";
            tableColumns += ",detail_description,purchase_price,sale_price,unit";
            tableColumns += ",sku,manufacturer,reorder_point,tax,created_source,warehouse,opening_stock)";
            base.cmdText = "insert into tblstock_details "+tableColumns+" values('" + ItemName+"','"+ItemCode+"','"+ItemCategory+"'" +
                ",'"+ShelfNo+"','"+Barcode+"','"+Description+"','"+PurchasePrice+"','"+SalePrice+"'" +
                ",'"+Unit+"','"+SKU+"','"+Manufacturer+"','"+ReorderPoint+"','"+TaxRate+"','"+CreatedSource+"','"+Warehouse+ "','" + Quantity + "')";
            //Inserting the updated quantity to the database
            base.MakeCUD();
            //Adding Item to Stock
            AddItemToStock();
            AddiItemsAccount();
        }
        public void AddItemToStock()
        {
            //Reading and adding the current balance with the new incoming inventory
            double newBalance = 0;
            double currentBalance = 0;
            base.cmdText = "select * from tblstock where item_name = '" + this.ItemName + "' order by id desc";
            DataTable dt = base.ReadTable();
            if (dt.Rows.Count != 0)
                currentBalance = Convert.ToDouble(dt.Rows[0]["balance"].ToString());
            newBalance = currentBalance + Convert.ToDouble(Quantity);
            //Adding Item to tblstock
            string tableStockColumn = "";
            tableStockColumn += "(item_name, quantity_in, quantity_out, balance, date, description,";
            tableStockColumn += "issued_person, expired_date, warehouse)";
            base.cmdText = "insert into tblstock " + tableStockColumn + " values('" + ItemName + "', " +
                "'" + Quantity + "','0','" + newBalance + "','" + Date + "','" + Description + "'," +
                "'" + IssuedPerson + "','" + ExpiredDate + "','" + Warehouse + "')";
            base.MakeCUD();
        }
        public void AddCategory()
        {
            base.cmdText = "insert into tblstock_category (category_name) values('" + this.Category + "')";
            base.MakeCUD();
        }
        public void RemoveItemFromStock(string date, string quantity)
        {
            //Reading and adding the current balance with the new incoming inventory
            double newBalance = 0;
            double currentBalance = 0;
            base.cmdText = "select * from tblstock where item_name = '" + this.ItemName + "' order by id desc";
            DataTable dt = base.ReadTable();
            if (dt.Rows.Count != 0)
                currentBalance = Convert.ToDouble(dt.Rows[0]["balance"].ToString());
            newBalance = currentBalance - Convert.ToDouble(quantity);
            //Adding Item to tblstock
            string tableStockColumn = "";
            tableStockColumn += "(item_name, quantity_in, quantity_out, balance, date, description,";
            tableStockColumn += "issued_person, expired_date, warehouse)";
            base.cmdText = "insert into tblstock " + tableStockColumn + " values('" + ItemName + "', " +
                "'0','" + quantity + "','" + newBalance + "','" + date + "','" + Description + "'," +
                "'" + IssuedPerson + "','','" + dt.Rows[0]["warehouse"].ToString() + "')";
            base.MakeCUD();
        }
        public void CreateWarehouse()
        {
            base.cmdText = "insert into tblwarehouse (name,address) values('" + this.Warehouse + "','" + this.WarehouseAddress + "')";
            base.MakeCUD();
        }
        public DataTable GetAllItemInfo()
        {
            base.cmdText = "select * from tblstock_details";
            return base.ReadTable();
        }
        public DataTable GetItemInfo()
        {
            base.cmdText = "select * from tblstock_details where item_name='"+this.ItemName+"'";
            return base.ReadTable();
        }
        public DataTable GetStockInfo()
        {
            base.cmdText = "select * from tblstock where item_name='" + this.ItemName + "' order by id desc";
            return base.ReadTable();
        }
        public void AddiItemsAccount()
        {
            string tableItemsAccountColumn = "(item_name, sales_account,purchase_account,inventory_account)";
            base.cmdText = "insert into tblitems_account " + tableItemsAccountColumn + " values('" + ItemName + "','Sales','Cost of Goods Sold','Inventory Asset')";
            base.MakeCUD();
        }
        public void AddProductHistory()
        {
            string tableProductHistory = "(item_name, description)";
            base.cmdText = "insert into tblproduct_history " + tableProductHistory + " values('" + ItemName + "','" + Description + "')";
            base.MakeCUD();
        }
    }
}