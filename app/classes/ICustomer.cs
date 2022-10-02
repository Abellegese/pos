using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace pos.app.classes
{
    public interface ICustomer
    {
        string BusinessType { get; set; }
        string Name { get; set; }
        string Company { get; set; }
        string Email { get; set; }
        string Phone { get; set; }
        string Website { get; set; }
        string CreditLimit { get; set; }
        string ContactPerson { get; set; }
        string Status { get; set; }
        string JoiningDate { get; set; }
        string Address { get; set; }
        string TIN { get; set; }
        string VatRegistrationNumber { get; set; }
    }
}