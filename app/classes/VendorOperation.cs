using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

namespace pos.app.classes
{
    public class VendorOperation:SQLOperation,IVendor
    {
        public string Name { get; set; }
        public string Company { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Website { get; set; }
        public string CreditLimit { get; set; }
        public string Status { get; set; }
        public string Address { get; set; }
        public string TIN { get; set; }
        public string VatRegistrationNumber { get; set; }

        public VendorOperation() { }
        public VendorOperation(string name) => this.Name = name;
        public void AddVendor()
        {

        }
        public DataTable GetVendorInfo()
        {
            base.cmdText = "select * from tblvendor where vendor_name = '" + this.Name + "'";
            return base.ReadTable();
        }
    }
}