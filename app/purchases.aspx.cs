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
                EditBil();
                BindPurchaseOrderNumber();
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
                btnDeleteBills.Visible = true;
                btnEditInfo.Visible = true;
                btnBack.Visible = true;
                billSpanIcon.Visible = false;
                billText.Visible = false;
                billNumberSpan.Visible = true;
                billNumberSpan.InnerText = "bill#-"+Convert.ToInt64(Request.QueryString["billno"].ToString()).ToString("D8");
                //
                SQLOperation sqlop = new SQLOperation("select * from tblpurchases");
                rptBillShort.DataSource = sqlop.ReadTable();
                rptBillShort.DataBind();
                DataTable dt = sqlop.ReadTable();
                PaymentMode.InnerText = dt.Rows[0]["payment_mode"].ToString();
                dateSpan.InnerText = dt.Rows[0]["date"].ToString();
                FSno.InnerText = "FS#" + Convert.ToInt64(Request.QueryString["fsno"].ToString()).ToString("D8");
                BillNoBinding.InnerText = "BILL#" + Convert.ToInt64(Request.QueryString["billno"].ToString()).ToString("D8");

                txtEdiBillNumber.Text = Convert.ToInt64(Request.QueryString["billno"].ToString()).ToString("D8");
                txtEditFSNumber.Text = Convert.ToInt64(Request.QueryString["fsno"].ToString()).ToString("D8");
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
        [WebMethod]
        public static string[][] BindOrderItems(string orderNumber)
        {
            SQLOperation so = new SQLOperation("select * from tblpurchase_order where order_number = '" + orderNumber + "'");
            DataTable dt = so.ReadTable();
            string[][] orderMatrix = new string[dt.Rows.Count][];

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                string itemName = dt.Rows[i]["item_name"].ToString();
                string quantity = dt.Rows[i]["quantity"].ToString();
                string unitPrice = dt.Rows[i]["unit_price"].ToString();
                string totalAmount = dt.Rows[i]["total_amount"].ToString();
                orderMatrix[i] = new string[4] { itemName, quantity, unitPrice, totalAmount };
            }
            return orderMatrix;
        }
        [WebMethod]
        public static List<string> BindOrderVendor(string orderNumber)
        {
            List<string> lst = new List<string>();
            SQLOperation so = new SQLOperation("select * from tblpurchase_order_main where order_number = '" + orderNumber + "'");
            DataTable dt = so.ReadTable();
            string vendorName = dt.Rows[0]["vendor_name"].ToString();
            string vendorAddress = dt.Rows[0]["vendor_address"].ToString();
            string vendorTin = dt.Rows[0]["vendor_tin"].ToString();

            //Add to List
            lst.Add(vendorName);
            lst.Add(vendorAddress);
            lst.Add(vendorTin);

            return lst;
        }
        [WebMethod]
        public static List<double> BindOrderSubtotals(string orderNumber)
        {
            List<double> lst = new List<double>();
            SQLOperation so = new SQLOperation("select sum(total_amount) from tblpurchase_order where order_number = '" + orderNumber + "'");
            DataTable dt = so.ReadTable();
            double totalAmount = Convert.ToDouble(dt.Rows[0][0].ToString()) + 0.15 * Convert.ToDouble(dt.Rows[0][0].ToString());
            double subtotal = Convert.ToDouble(dt.Rows[0][0].ToString());
            double vat = totalAmount - subtotal;


            //Add to List
            lst.Add(totalAmount);
            lst.Add(subtotal);
            lst.Add(vat);

            return lst;
        }
        private void EditBil()
        {
            if (Request.QueryString["item_id"] != null)
            {
                btnEditLineItem.Visible = true;
                btnDeleteLineItemsModal.Visible = true;
                itemSelectionSpan.Visible = true;
                itemNumber.InnerText = Request.QueryString["item_id"].ToString();
                selectedItem.InnerText = Request.QueryString["item"].ToString();

                SQLOperation sqlop = new SQLOperation("select * from tblpurchase_and_bill where id = '" + Request.QueryString["item_id"].ToString() + "'");
                txtEditQuantity.Text = sqlop.ReadTable().Rows[0]["quantity"].ToString();
                txtEditUnitPrice.Text = sqlop.ReadTable().Rows[0]["unit_price"].ToString();
            }
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
        public void BindPurchaseOrderNumber()
        {
            SQLOperation so = new SQLOperation("select * from tblpurchase_order_main where bill_status = 'Confirmed' or bill_status = 'Unconfirmed'");
            ddlOrderNumber.DataSource = so.ReadTable();
            ddlOrderNumber.DataValueField = "order_number";
            ddlOrderNumber.DataBind();
            ddlOrderNumber.Items.Insert(0, new ListItem("-Select Order Number-", "0"));
        }
        private void BindBillNumber()
        {
            PurchaseOperation slo = new PurchaseOperation();
            billSpan.InnerText = Convert.ToInt64(slo.BillNumberCounter().ToString()).ToString("D8");
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
            Response.Redirect("purchases.aspx?billno=" + billSpan.InnerText + "&&vendor=" + txtVendorName.Text + "&&fsno=" + txtFSNumber.Text);
            Response.Redirect(Request.RawUrl);

        }

        protected void btnDeleteBill_Click(object sender, EventArgs e)
        {
            SQLOperation sqlop = new SQLOperation("delete from tblpurchase_and_bill where bill_number='" + Request.QueryString["billno"].ToString() + "'");
            sqlop.MakeCUD();

            sqlop.cmdText = "delete from tblpurchases where bill_no='" + Request.QueryString["billno"].ToString() + "'";
            sqlop.MakeCUD();

            Response.Redirect("purchases.aspx");
        }

        protected void btnDeleteLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null && Request.QueryString["edit"] != null)
            {
                SQLOperation so = new SQLOperation("delete from tblpurchase_and_bill where id = '" + Request.QueryString["item_id"].ToString() + "'");
                so.MakeCUD();
                string invno = Request.QueryString["invno"].ToString();
                string fsno = Request.QueryString["fsno"].ToString();
                string vendor = Request.QueryString["vendor"].ToString();
                Response.Redirect("purchases.aspx?bill=" + invno + "&&vendor=" + vendor);

            }
        }

        protected void btnSaveEditInvoiceInfo_Click(object sender, EventArgs e)
        {
            SQLOperation sqlop = new SQLOperation("update tblpurchase_and_bill set bill_number='" + txtEdiBillNumber.Text + "' where bill_number='" + Request.QueryString["billno"].ToString() + "'");
            sqlop.MakeCUD();

            //
            sqlop.cmdText = "update tblpurchases set bill_no='" + txtEdiBillNumber.Text + "', fsno='" + txtEditFSNumber.Text + "' where bill_no='" + Request.QueryString["billno"].ToString() + "'";
            sqlop.MakeCUD();

            Response.Redirect("purchases.aspx?billno=" + txtEdiBillNumber.Text + "&&fsno=" + txtEditFSNumber.Text + "&&vendor=" + Name.InnerText);
        }

        protected void btnSaveLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null && Request.QueryString["edit"] != null)
            {
                SQLOperation sqlop = new SQLOperation("update tblpurchase_and_bill set quantity='" + txtEditQuantity.Text + "'" +
                    ",unit_price='" + txtEditUnitPrice.Text + "'" +
                    ", total_amount='" + Convert.ToDouble(txtEditQuantity.Text) * Convert.ToDouble(txtEditUnitPrice.Text) + "' where id='" + Request.QueryString["item_id"].ToString() + "'");
                sqlop.MakeCUD();

                sqlop.cmdText = "select sum(total_amount) from tblpurchase_and_bill where bill_number='" + Request.QueryString["billno"].ToString() + "'";

                double vatFree = double.Parse(sqlop.ReadTable().Rows[0][0].ToString());

                double total = vatFree + vatFree * 0.15;

                sqlop.cmdText = "update tblpurchases set total_amount='" + total + "' where bill_no='" + Request.QueryString["billno"].ToString() + "'";
                sqlop.MakeCUD();
                Response.Redirect(Request.RawUrl);

            }
        }

        protected void rptrBill_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in rptrBill.Items)
            {
                Label lblStatus = item.FindControl("lblStatus") as Label;
                Label lblBalance = item.FindControl("lblBalance") as Label;
                double balance = Convert.ToDouble(lblBalance.Text);
                if (balance > 0)
                {
                    lblStatus.Attributes.Add("class", "badge badge badge-danger");
                    lblStatus.Text = "Pending";
                }
                else
                {
                    lblStatus.Attributes.Add("class", "badge badge badge-success");
                    lblStatus.Text = "Paid";
                }
            }
        }
    }
}