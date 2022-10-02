using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace pos.app.classes
{
    public class CreditOperation : SQLOperation, ICredit
    {
        public string CustomerName { get; set; }
        public string TotalAmount { get; set; }
        public string Balance { get; set; }
        public string TransactionNumber { get; set; }
        public string CreditType { get; set; }
        public string PaymentMode { get; set; }
        public string Date { get; set; }

        public CreditOperation() { }
        public CreditOperation(string customerName) => this.CustomerName = customerName;
        public CreditOperation(string customerName, string transactionNumber)
        {
            this.CustomerName = customerName;
            this.TransactionNumber = transactionNumber;
        }
        public void CreateCredit()
        {
            string tableCreditColumns = "(customer_or_vendor,total_amount,balance,invoice_or_bill_number,credit_type,payment_mode,date)";
            base.cmdText = "insert into tblcredit_note " + tableCreditColumns + " values('" + this.CustomerName + "','" + this.TotalAmount + "'" +
                ",'" + this.Balance + "','" + this.TransactionNumber + "','" + this.CreditType + "','" + this.PaymentMode + "','" + this.Date + "')";
            base.MakeCUD();
        }
        public void CreditPayment()
        {

        }
        public DataTable GetCreditInfo()
        {
            DataTable dt = new DataTable();
            base.cmdText = "select * from tblcredit_note where invoice_or_bill_number= '" + this.TransactionNumber + "'";
            dt = base.ReadTable();
            return dt;
        }
    }
}