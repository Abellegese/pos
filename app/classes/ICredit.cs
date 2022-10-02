using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace pos.app.classes
{
    public interface ICredit
    {
        string CustomerName { get; set; }
        string TotalAmount { get; set; }
        string Balance { get; set; }
        string TransactionNumber { get; set; }
        string CreditType { get; set; }
        string PaymentMode { get; set; }
        string Date { get; set; }
    }
}
