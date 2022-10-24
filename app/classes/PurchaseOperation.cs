using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace pos.app.classes
{
    public class PurchaseOperation: SQLOperation, IPurchase
    {
        public string VendorName { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        public string ReferenceNumber { get; set; }
        public string Date { get; set; }
        public string PurchasePrice { get; set; }
        public string Unit { get; set; }
        public string PurchaseDescription { get; set; }
        public string PurchaseQuantity { get; set; }
        public string TotalAmount { get; set; }
        public string Balance { get; set; }
        public string BillNumber { get; set; }
        public string FSNumber { get; set; }
        public string TIN { get; set; }
        public string PaymentMode { get; set; }
        public string Address { get; set; }
        public string BankName { get; set; }
        public string PurchaseOrderNumber { get; set; }
        public string ExpiredDate { get; set; }
        public string ManufacturedDate { get; set; }


        public PurchaseOperation() { }

        public void CreateBills()
        {
            string tablePurchaseColumn = "(vendor_name,date,bill_no,total_amount,balance,fsno,vendor_tin,payment_mode,bank_name)";
            base.cmdText = "insert into tblpurchases " + tablePurchaseColumn + " values('" + VendorName + "','" + Date + "'" +
                ",'" + BillNumber + "','" + TotalAmount + "','" + Balance + "','" + FSNumber + "','" + TIN + "','" + PaymentMode + "','" + BankName + "')";
            base.MakeCUD();

            if (double.Parse(Balance) > 0)
            {
                CreditOperation co = new CreditOperation(this.VendorName, this.BillNumber);
                co.TotalAmount = this.TotalAmount;
                co.Balance = this.Balance;
                co.CreditType = "Purchase";
                co.PaymentMode = this.PaymentMode;
                co.Date = this.Date;
                co.CreateCredit();
            }
        }
        public void CreateBillDetails()
        {
            string tablePurchaseColumn = "(vendor_name,item_name,ref_number,date,unit_price,description,quantity,total_amount" +
                ",bill_number,expired_date,manufactured_date)";
            base.cmdText = "insert into tblpurchase_and_bill " + tablePurchaseColumn + " values('" + VendorName + "','" + ItemName + "'," +
                "'" + ReferenceNumber + "'," +
                "'" + Date + "','" + PurchasePrice + "','" + PurchaseDescription + "','" + PurchaseQuantity + "','" + TotalAmount + "'" +
                ",'" + BillNumber + "','" + ExpiredDate + "'" +
                ",'" + ManufacturedDate + "')";
            base.MakeCUD();

            //Adding the item to stock

            StoreOperation so = new StoreOperation(this.ItemName);
            so.ExpiredDate = this.ExpiredDate.ToString();
            so.Quantity = this.PurchaseQuantity;
            so.IssuedPerson = "";
            so.Date = this.Date;
            so.Description = this.PurchaseDescription;
            so.AddItemToStock();
        }
        public Int64 BillNumberCounter()
        {
            base.cmdText = "select * from tblpurchases order by id desc LIMIT 1";
            if (base.ReadTable().Rows.Count == 0)
                return 1;
            return Convert.ToInt64(base.ReadTable().Rows[0]["bill_no"].ToString()) + 1;
        }
        //Purchase Order Methods
        public void CreatePurchaseOrder()
        {
            //Insert into the main tables
            string tablePOColumn = "(vendor_name,date,bill_status,bill_number,shipment_status,amount,vendor_address,vendor_tin,order_number)";
            base.cmdText = "insert into tblpurchase_order_main " + tablePOColumn + " values ('" + VendorName + "','" + Date + "','Unconfirmed','','Unconfirmed','" + TotalAmount + "','" + Address + "','" + TIN + "','" + PurchaseOrderNumber + "')";
            base.MakeCUD();
        }
        public void CreatePurchaseOrderDetails()
        {
            //Insert into details of the item

            string tablePODetailColumn = "(vendor_name,item_name,date,unit_price,description,quantity,total_amount,order_number)";
            base.cmdText = "insert into tblpurchase_order " + tablePODetailColumn + " values ('" + VendorName + "','" + ItemName + "','" + Date + "','" + PurchasePrice + "'" +
                ",'" + PurchaseDescription + "','" + PurchaseQuantity + "','" + TotalAmount + "','" +PurchaseOrderNumber  + "')";
            base.MakeCUD();
        }
        public Int64 PurchaseOrderNumberCounter()
        {
            base.cmdText = "select * from tblpurchase_order_main order by id desc LIMIT 1";
            if (base.ReadTable().Rows.Count == 0)
                return 1;
            return Convert.ToInt64(base.ReadTable().Rows[0]["id"].ToString()) + 1;
        }
    }
}