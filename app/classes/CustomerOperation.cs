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
            string tableCustomerColumns = "(bussines_type,customer_name,company_name,email,phone,website,credit_limit,status" +
                ",address,tin,vat_registration_number)";
            base.cmdText = "insert into tblcustomer " + tableCustomerColumns + " values ('" + BusinessType + "','" + Name + "','" + Company + "'," +
                "'" + Email + "','" + Phone + "','" + Website + "','" + CreditLimit + "','" + Status + "','" + Address + "','" + TIN + "','" + VatRegistrationNumber + "')";
            base.MakeCUD();
        }
        public DataTable GetCustomerInfo()
        {
            base.cmdText = "select * from tblcustomer where customer_name = '" + this.Name + "'";
            return base.ReadTable();
        }
    }
}