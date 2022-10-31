namespace pos.app.classes
{
    public class BankOperation : SQLOperation, IBank
    {
        public string BankName { get; set; }
        public string AccountNumber { get; set; }

        public BankOperation() { }

        public void AddBankAccount()
        {
            string tablBankColumn = "(bank_name,bank_number)";
            base.cmdText = "insert into tblbank_account_info " + tablBankColumn + " values('" + BankName + "','" + AccountNumber + "')";
            base.MakeCUD();
        }
    }
}