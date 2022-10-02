using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pos.app.classes
{
    public interface IBank
    {
        string BankName { get; set; }
        string AccountNumber { get; set; }
    }
}
