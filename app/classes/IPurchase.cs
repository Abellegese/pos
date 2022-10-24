using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pos.app.classes
{
    public interface IPurchase
    {
        string VendorName { get; set; }
        string ItemName { get; set; }
        string ItemCode { get; set; }
        string ReferenceNumber { get; set; }
        string Date { get; set; }
        string PurchasePrice { get; set; }
        string Unit { get; set; }
        string PurchaseDescription { get; set; }
        string PurchaseQuantity { get; set; }
        string TotalAmount { get; set; }
        string Balance { get; set; }
        string BillNumber { get; set; }
        string FSNumber { get; set; }
        string TIN { get; set; }
        string PaymentMode { get; set; }
        string Address { get; set; }
        string BankName { get; set; }
        string PurchaseOrderNumber { get; set; }
        string ExpiredDate { get; set; }
        string ManufacturedDate { get; set; }
    }
}
