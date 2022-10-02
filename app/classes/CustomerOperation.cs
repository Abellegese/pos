using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace pos.app.classes
{
    public class CustomerOperation: SQLOperation, ICustomer
    {
        public string BusinessType { get; set; }
        public string Name { get; set; }
        public string Company { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string Website { get; set; }
        public string CreditLimit { get; set; }
        public string ContactPerson { get; set; }
        public string Status { get; set; }
        public string JoiningDate { get; set; }
        public string Address { get; set; }
        public string TIN { get; set; }
        public string VatRegistrationNumber { get; set; }

        public CustomerOperation () { }
        public CustomerOperation(string name) => this.Name = name;
        public void AddCustomer()
        {

        }
        public DataTable GetCustomerInfo()
        {
            base.cmdText = "select * from tblcustomer where customer_name = '" + this.Name + "'";
            return base.ReadTable();
        }
    }
}