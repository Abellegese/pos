using pos.app.classes;
using System;
using System.Web.Services;
using System.Data;
using System.Collections.Generic;
namespace pos.app
{
    public partial class dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
            }
        }
        [WebMethod]
        public static List<string> BindReceivables()
        {
            //Creating instances of credit operation class
            CreditOperation co = new CreditOperation();
            return co.GetReceivableInfo();
        }
        [WebMethod]
        public static List<string> GetTotals(string fiscalBeg, string fiscalEnd)
        {
            List<string> lst = new List<string>();
            //Declaring tuple variable
            string totalSales = "0";
            string totalPurchase = "0";
            string netProfit = string.Empty;
            //Creating instances of sql operation class
            SQLOperation so = new SQLOperation();
            //Reading Sales Table
            so.cmdText = "SELECT SUM(total_amount) FROM tblinvoice where date between '" + fiscalBeg + "' and '" + fiscalEnd + "'";
            DataTable dtSales = so.ReadTable();
            if (dtSales.Rows[0][0].ToString() != "")
                totalSales = Convert.ToDouble(dtSales.Rows[0][0].ToString()).ToString("#,##0.00");
            //Reading Purchase Table
            so.cmdText = "SELECT SUM(total_amount) FROM tblpurchases where date between '" + fiscalBeg + "' and '" + fiscalEnd + "'";
            DataTable dtPurchase = so.ReadTable();
            if (dtPurchase.Rows[0][0].ToString() != "")
                totalPurchase = Convert.ToDouble(dtPurchase.Rows[0][0].ToString()).ToString("#,##0.00");
            //Calculatig net profit from sales - purcahse
            netProfit = (Convert.ToDouble(totalSales) - Convert.ToDouble(totalPurchase)).ToString("#,##.00");
            //Creatig and returing values as list
            lst.Add(totalSales);
            lst.Add(totalPurchase);
            lst.Add(netProfit);

            return lst;
        }
        [WebMethod]
        public static Tuple<string, string, string, string> GetSalesInfo(string fiscalBeg, string fiscalEnd)
        {
            //Creating instances of sql operation class
            SQLOperation so = new SQLOperation();
            //Declaring tuple variable
            string cashSale = string.Empty;
            string creditSale = string.Empty;
            string refund = string.Empty;
            string numberOfSalesOrder = string.Empty;
            //Reading Cash Table
            so.cmdText = "SELECT SUM(total_amount) FROM tblinvoice where date between '" + fiscalBeg + "' and '" + fiscalEnd + "' and balance = 0";
            DataTable dtCashSale = so.ReadTable();
            if(dtCashSale.Rows[0][0].ToString() != "")
                cashSale = Convert.ToDouble(dtCashSale.Rows[0][0].ToString()).ToString("#,##0.00");
            //Reading Credit Table
            so.cmdText = "SELECT SUM(total_amount) FROM tblinvoice where date between '" + fiscalBeg + "' and '" + fiscalEnd + "' and balance > 0";
            DataTable dtCreditSale = so.ReadTable();
            if (dtCreditSale.Rows[0][0].ToString() != "")
                creditSale = Convert.ToDouble(dtCreditSale.Rows[0][0].ToString()).ToString("#,##0.00");
            //Reading Refund Table
            so.cmdText = "SELECT SUM(total_amount) FROM tblinvoice where date between '" + fiscalBeg + "' and '" + fiscalEnd + "' and invoice_type = 'Refund'";
            DataTable dtRefundSale = so.ReadTable();
            if (dtRefundSale.Rows[0][0].ToString() != "")
                refund = Convert.ToDouble(dtRefundSale.Rows[0][0].ToString()).ToString("#,##0.00");
            //Reading Total Sales Order
            so.cmdText = "SELECT count(*) FROM tblsales_order_main where date between '" + fiscalBeg + "' and '" + fiscalEnd + "'";
            DataTable dtSalesOrder = so.ReadTable();
            if (dtSalesOrder.Rows[0][0].ToString() != "")
                numberOfSalesOrder = Convert.ToDouble(dtSalesOrder.Rows[0][0].ToString()).ToString("#,##0.00");
            return Tuple.Create(
                cashSale,
                creditSale,
                refund,
                numberOfSalesOrder
          );
        }
        [WebMethod]
        public static Tuple<string, string, string> GetPurcahseInfo(string fiscalBeg, string fiscalEnd)
        {
            //Creating instances of sql operation class
            SQLOperation so = new SQLOperation();
            //Declaring tuple variable
            string cashPurchase = string.Empty;
            string creditPurchase = string.Empty;
            string refund = string.Empty;
            string numberOfPurchasesOrder = string.Empty;
            //Reading Cash Table
            so.cmdText = "SELECT SUM(total_amount) FROM tblpurchases where date between '" + fiscalBeg + "' and '" + fiscalEnd + "' and balance = 0";
            DataTable dtCashPurchase = so.ReadTable();
            if (dtCashPurchase.Rows[0][0].ToString() != "")
                cashPurchase = Convert.ToDouble(dtCashPurchase.Rows[0][0].ToString()).ToString("#,##0.00");
            //Reading Credit Table
            so.cmdText = "SELECT SUM(total_amount) FROM tblpurchases where date between '" + fiscalBeg + "' and '" + fiscalEnd + "' and balance > 0";
            DataTable dtCreditPurchase = so.ReadTable();
            if (dtCreditPurchase.Rows[0][0].ToString() != "")
                creditPurchase = Convert.ToDouble(dtCreditPurchase.Rows[0][0].ToString()).ToString("#,##0.00");
            //Reading Total Purchases Order
            so.cmdText = "SELECT count(*) FROM tblpurchase_order_main where date between '" + fiscalBeg + "' and '" + fiscalEnd + "'";
            DataTable dtPurchasesOrder = so.ReadTable();
            if (dtPurchasesOrder.Rows[0][0].ToString() != "")
                numberOfPurchasesOrder = Convert.ToDouble(dtPurchasesOrder.Rows[0][0].ToString()).ToString("#,##0.00");
            return Tuple.Create(
                cashPurchase,
                creditPurchase,
                numberOfPurchasesOrder
          );
        }
    }
}