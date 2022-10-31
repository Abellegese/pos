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
