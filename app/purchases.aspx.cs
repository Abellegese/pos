using pos.app.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace pos.app
{
    public partial class purchases : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindBills();
                BindVenddor();
                BindBankAccount();
                GetItemInfo();
                BindBillNumber();
                ShowBillInfoAndHTMLElement();
                BindCompanyInfo();
                GetTotals();
                BindVendorInfo();
                NumberToWord();
            }
        }
        private void BindVendorInfo()
        {
            if (Request.QueryString["vendor"] != null)
            {
                VendorOperation co = new VendorOperation(Request.QueryString["vendor"].ToString());
                if (co.GetVendorInfo().Rows.Count != 0)
                {
                    DataTable dt = co.GetVendorInfo();
                    Name.InnerText = dt.Rows[0]["vendor_name"].ToString();
                    CustVatRegNumber.InnerText = dt.Rows[0]["vat_registration_number"].ToString();
                    TINNUMBER.InnerText = dt.Rows[0]["tin"].ToString();
                    Address.InnerText = dt.Rows[0]["billing_address"].ToString();
                }
            }
        }
        private void GetTotals()
        {
            if (Request.QueryString["billno"] != null)
            {
                string invno = Request.QueryString["billno"].ToString();
                SQLOperation slo = new SQLOperation("select *from tblpurchases where bill_no='" + invno + "'");
                DataTable dt = slo.ReadTable();

                //
                Total.InnerText = Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()).ToString("#,##0.00");
                subTotal.InnerText = (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) / 1.15).ToString("#,##0.00");
                vatAmount.InnerText = (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) - (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) / 1.15)).ToString("#,##0.00");
            }
        }
        private void BindCompanyInfo()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblcompany");
            companyNameSpan.InnerText = sqlop.ReadTable().Rows[0]["company_name"].ToString();
            CompAddress.InnerText = sqlop.ReadTable().Rows[0]["address"].ToString();
            Contact.InnerText = sqlop.ReadTable().Rows[0]["phone"].ToString();
            rptrLogo.DataSource = sqlop.ReadTable();
            rptrLogo.DataBind();
        }
        private void NumberToWord()
        {
            if (Request.QueryString["billno"] != null)
            {
                double total = Convert.ToDouble(Total.InnerText);
                NumberToWord NumToWrd = new NumberToWord();
                AmountInWords.InnerText = NumToWrd.ConvertAmount(total);
            }
        }
        private void ShowBillInfoAndHTMLElement()
        {
            if (Request.QueryString["billno"] != null)
            {
                BillDiv.Visible = false;
                BillDetailDiv.Visible = true;
                buttondiv.Visible = false;
                //
                SQLOperation sqlop = new SQLOperation("select * from tblpurchases");
                rptBillShort.DataSource = sqlop.ReadTable();
                rptBillShort.DataBind();
                DataTable dt = sqlop.ReadTable();
                PaymentMode.InnerText = dt.Rows[0]["payment_mode"].ToString();
                dateSpan.InnerText = dt.Rows[0]["date"].ToString();
                FSno.InnerText = "FS#" + dt.Rows[0]["fsno"].ToString();
                BillNoBinding.InnerText = "BILL#" + Request.QueryString["billno"].ToString();
                //
                sqlop.cmdText = "select * from tblpurchase_and_bill where bill_number='" + Request.QueryString["billno"].ToString() + "'";
                rptrAttachment.DataSource = sqlop.ReadTable();
                rptrAttachment.DataBind();


            }
        }
        public void GetItemInfo()
        {
            StoreOperation so = new StoreOperation();
            ddlItemName.DataSource = so.GetAllItemInfo();
            ddlItemName.DataTextField = "item_name";
            ddlItemName.DataBind();
            ddlItemName.Items.Insert(0, new ListItem("-Select Item-", "0"));
        }
        private void BindBankAccount()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblbank_account_info");
            DataTable dt = sqlop.ReadTable();
            ddlBankAccount.DataSource = dt;
            ddlBankAccount.DataTextField = "bank_name";
            ddlBankAccount.DataBind();
            ddlBankAccount.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        private void BindBillNumber()
        {
            PurchaseOperation slo = new PurchaseOperation();
            billSpan.InnerText = slo.BillNumberCounter().ToString();
        }
        private void BindVenddor()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblvendor");
            DataTable dt = sqlop.ReadTable();
            ddlExistingVendor.DataSource = dt;
            ddlExistingVendor.DataTextField = "vendor_name";
            ddlExistingVendor.DataBind();
            ddlExistingVendor.Items.Insert(0, new ListItem("-Select-", "0"));
        }

        [WebMethod]
        public static void CreatePurchases(string vendorName, string itemName, string referenceNumber, string date, string unitPrice, string description
        , string quantity, string totalAmount, string billNumber, string expiredDate, string manufacturingDate)
        {
            PurchaseOperation so = new PurchaseOperation
            {
                VendorName = vendorName,
                ItemName = itemName,
                Date = date,
                ReferenceNumber = referenceNumber,
                PurchasePrice = unitPrice,
                PurchaseDescription = description,
                PurchaseQuantity = quantity,
                TotalAmount = totalAmount,
                BillNumber = billNumber,
                ExpiredDate = expiredDate,
                ManufacturedDate = manufacturingDate
            };
            so.CreateBillDetails();
        }
        [WebMethod]
        public static List<string> GetItemRate(string itemName)
        {
            List<string> lst = new List<string>();
            StoreOperation so = new StoreOperation(itemName);
            lst.Add(so.GetItemInfo().Rows[0]["purchase_price"].ToString());
            lst.Add(so.GetItemInfo().Rows[0]["tax"].ToString());
            lst.Add(so.GetItemInfo().Rows[0]["unit"].ToString());

            return lst;
        }
        [WebMethod]
        public static string GetItemBalance(string itemName)
        {
            StoreOperation so = new StoreOperation(itemName);
            if (so.GetStockInfo().Rows.Count == 0)
                return "0";
            return so.GetStockInfo().Rows[0]["balance"].ToString();
        }
        [WebMethod]
        public static List<string> GetVendorInfo(string vendorName)
        {
            List<string> lst = new List<string>();
            VendorOperation co = new VendorOperation(vendorName);
            DataTable dt = co.GetVendorInfo();
            string tin = dt.Rows[0]["tin"].ToString();
            string address = dt.Rows[0]["billing_address"].ToString();
            lst.Add(tin);
            lst.Add(address);
            return lst;
        }
        private void BindBills()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblpurchases");
            if (sqlop.ReadTable().Rows.Count != 0)
            {
                rptrBill.DataSource = sqlop.ReadTable();
                rptrBill.DataBind();
            }
            else
            {
                BillDiv.Visible = true;
                mainb.Visible = true;
                buttondiv.Visible = false;
            }
        }
        protected void btnPrevious_Click(object sender, EventArgs e)
        {

        }
        protected void btnNext_Click(object sender, EventArgs e)
        {

        }

        protected void btnCreateBill_Click(object sender, EventArgs e)
        {
            PurchaseOperation po = new PurchaseOperation();
            po.VendorName = txtVendorName.Text;
            po.Date = txtDate.Text;
            po.FSNumber = txtFSNumber.Text;
            po.TIN = txtTINNumber.Text;
            po.PurchaseDescription = txtVendorName.Text;
            po.PurchaseQuantity = txtVendorName.Text;
            po.TotalAmount = txtGrandTotal.Text;
            po.BillNumber = billSpan.InnerText;
            if (bank.Checked == true)
            {
                po.PaymentMode = "Bank";
                po.BankName = ddlBankAccount.SelectedItem.Text;
            }
            else
            {
                po.PaymentMode = "Cash";
            }
            po.Balance = txtCreditAmount.Text;
            po.CreateBills();
        }
    }
}