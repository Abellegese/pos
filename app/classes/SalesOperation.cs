using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using pos.app.classes;
namespace pos.app.classes
{
    public class SalesOperation:SQLOperation,ISale
    {
        public string CustomerName { get; set; }
        public string ItemName { get; set; }
        public string ItemCode { get; set; }
        public string ReferenceNumber { get; set; }
        public string Date { get; set; }
        public string SalePrice { get; set; }
        public string Unit { get; set; }
        public string SalesDescription { get; set; }
        public string SalesQuantity { get; set; }
        public string TotalAmount { get; set; }
        public string Balance { get; set; }
        public string InvoiceNumber { get; set; }
        public string FSNumber { get; set; }
        public string TIN { get; set; }
        public string PaymentMode { get; set; }
        public string Address { get; set; }
        public string BankName { get; set; }
        public string Discount { get; set; }
        public string DiscountType { get; set; }
        public string IsDiscounted { get; set; }
        public string Warehouse { get; set; }
        public SalesOperation() { }
        public void CreateSales()
        {
            string tableSaleColumn = "";
            tableSaleColumn += "(customer_name,item_name,ref_number,date,unit, unit_price,";
            tableSaleColumn += "description,quantity,total_amount,invoice_number,fsno,customer_tin,";
            tableSaleColumn += "payment_mode,customer_address,bank_name, discount,is_discounted,discount_type)";
            base.cmdText = "";
            base.cmdText += "insert into tblsale_and_invoice " + tableSaleColumn + " values ('" + CustomerName + "','" + ItemName + "'";
            base.cmdText += ",'" + ReferenceNumber + "','" + Date + "','" + Unit + "','" + SalePrice + "','" + SalesDescription + "'";
            base.cmdText += ",'" + SalesQuantity + "','" + TotalAmount + "','" + InvoiceNumber + "','" + FSNumber + "'";
            base.cmdText += ",'" + TIN + "','" + PaymentMode + "','" + Address + "','" + BankName + "','" + Discount + "','" + IsDiscounted + "','" + DiscountType + "')";
            base.MakeCUD();
            StoreOperation so = new StoreOperation(this.ItemName, "select * from tblstock");
            so.RemoveItemFromStock(this.Date, this.SalesQuantity);
        }
        public DataTable GetSalesInfo(string invNo)
        {
            base.cmdText = "select * from tblsale_and_invoice where invoice_number='" + invNo + "'";
            return base.ReadTable();
        }
        public void CreateInvoice()
        {
            StoreOperation so = new StoreOperation(this.ItemName, "select * from tblstock");
            //recording Values to Invoice Table
            string tableInvoiceColumn = "";
            tableInvoiceColumn += "(customer_name,invoice_number,discount,total_amount,balance,date,fsno,warehouse,discount_type,is_discounted)";
            base.cmdText = "insert into tblinvoice " + tableInvoiceColumn + " values('" + CustomerName + "','" + InvoiceNumber + "','"+Discount+"','" + TotalAmount + "','" + Balance + "','" + Date + "','" + FSNumber + "','" + so.ReadTable().Rows[0]["warehouse"] + "','" + DiscountType + "','" + IsDiscounted + "')";
            base.MakeCUD();

            //Recording Credit If Any 
            if (double.Parse(Balance) > 0)
            {
                CreditOperation co = new CreditOperation(this.CustomerName, this.InvoiceNumber);
                co.TotalAmount = this.TotalAmount;
                co.Balance = this.Balance;
                co.CreditType = "Sale";
                co.PaymentMode = this.PaymentMode;
                co.Date = this.Date;
                co.CreateCredit();
            }
        }
        public string FSnumberCounter()
        {
            base.cmdText = "select * from tblsale_and_invoice order by id desc LIMIT 1";
            if (base.ReadTable().Rows.Count == 0)
                return "";
            return (Convert.ToInt64(Int64.Parse(base.ReadTable().Rows[0]["fsno"].ToString())) + 1).ToString();
        }
        public Int64 InvoiceNumberCounter()
        {
            base.cmdText = "select * from tblsale_and_invoice order by id desc LIMIT 1";
            if (base.ReadTable().Rows.Count == 0)
                return 1;
            return Convert.ToInt64(base.ReadTable().Rows[0]["invoice_number"].ToString()) + 1;
        }
    }
}