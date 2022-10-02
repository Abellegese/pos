using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pos.app.classes
{
     interface ISale
    {
         string CustomerName { get; set; }
         string ItemName { get; set; }
         string ItemCode { get; set; }
         string ReferenceNumber { get; set; }
         string Date { get; set; }
         string SalePrice { get; set; }
         string Unit { get; set; }
         string SalesDescription { get; set; }
         string SalesQuantity { get; set; }
         string TotalAmount { get; set; }
         string Balance { get; set; }
         string InvoiceNumber { get; set; }
         string FSNumber { get; set; }
         string TIN { get; set; }
         string PaymentMode { get; set; }
         string Address { get; set; }
         string BankName { get; set; }
         string Discount { get; set; }
         string DiscountType { get; set; }
         string IsDiscounted { get; set; }
        string Warehouse { get; set; }
    }
}
