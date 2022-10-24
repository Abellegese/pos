using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pos.app.classes
{
    public interface IVendor
    {
        string Name { get; set; }
        string Company { get; set; }
        string Email { get; set; }
        string Phone { get; set; }
        string Website { get; set; }
        string CreditLimit { get; set; }
        string Status { get; set; }
        string Address { get; set; }
        string TIN { get; set; }
        string VatRegistrationNumber { get; set; }
    }
}
