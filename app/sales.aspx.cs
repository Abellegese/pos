﻿using pos.app.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace pos.app
{
    public partial class sales : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCustomer();
                //BindFSnumber();
                GetItemInfo();
                IsDiscountEnabled();
                BindDiscountModes();
                BindInvoiceNumber();
                BindReferenceNumber();
                BindBankAccount();
                BindInvoiceData();
                BindInvoiceSmallData();
                ShowInvoiceInfoAndHTMLElement();
                BindCustomerInfo();
                BindCompanyInfo();
                GetTotals();
                NumberToWord();
                BindCredit();
                EditInvoice();
                BindInvoiceTemplate();
                BindComments();
                BindFiscalReceiptNumber();
                BindSalesOrderNumber();
            }
        }
        private void BindFiscalReceiptNumber()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblfiscal_receipt_response");
            DataTable dt = sqlop.ReadTable();
            ddlINVnumber.DataSource = dt;
            ddlINVnumber.DataTextField = "inv_no";
            ddlINVnumber.DataBind();
            ddlINVnumber.Items.Insert(0, new ListItem("-Select Invoice Number-", "0"));
        }
        private void BindComments()
        {
            if (Request.QueryString["invno"] != null)
            {
                string invno = Request.QueryString["invno"].ToString();
                SQLOperation so = new SQLOperation("select * from tblinvoice_comment where invoice_number = '" + invno + "'");
                DataTable dt = so.ReadTable();
                //rptrComments.DataSource = dt;
                //rptrComments.DataBind();
            }
        }
        [WebMethod]
        public static void RecordReceiptInfo(string invoiceNo, string receiptNo, string datetime, string fiscalMemoryNo)
        {
            SQLOperation so = new SQLOperation();
            so.cmdText = "insert into tblfiscal_receipt_response values('" + invoiceNo + "','" + receiptNo + "','" + datetime + "','" + fiscalMemoryNo + "')";
            so.MakeCUD();
        }
        [WebMethod]
        public static List<string> GetRefundResult(string invNo)
        {
            List<string> lst = new List<string>();
            SQLOperation so = new SQLOperation("select * from tblfiscal_receipt_response where inv_no = '" + invNo + "'");
            lst.Add(so.ReadTable().Rows[0]["receipt_no"].ToString());
            lst.Add(so.ReadTable().Rows[0]["datetime"].ToString());
            lst.Add(so.ReadTable().Rows[0]["fiscal_memory_number"].ToString());
            return lst;
        }
        [WebMethod]
        public static List<string> GetSurchargeDiscountSetting()
        {
            List<string> lst = new List<string>();

            SQLOperation so = new SQLOperation("select * from tblfiscal_printer_settings");

            bool isDiscountAllowed = bool.Parse(so.ReadTable().Rows[0]["allow_discount"].ToString());
            bool isSurchargeAllowed = bool.Parse(so.ReadTable().Rows[0]["allow_surcharge"].ToString());
            lst.Add(isDiscountAllowed.ToString());
            lst.Add(isSurchargeAllowed.ToString());

            return lst;
        }
        [WebMethod]
        public static string GetPrinterSN()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblfiscal_printer_active");
            DataTable dt = sqlop.ReadTable();
            return dt.Rows[0]["fiscal_id"].ToString();
        }
        [WebMethod]
        public static void UpdateOpacity(string opacity)
        {
            SQLOperation sqlop = new SQLOperation("update tblinvoice_customization set watermark_opacity='" + opacity + "'");
            sqlop.MakeCUD();
        }
        private void BindInvoiceTemplate()
        {
            SQLOperation sqlop = new SQLOperation("select*from tblinvoice_customization");

            DataTable dt = sqlop.ReadTable();

            txtHeadingName.Text = dt.Rows[0]["heading_name"].ToString();
            txtHeadingFontsize.Text = dt.Rows[0]["heading_font_size"].ToString();
            txtHeadingLineHeight.Text = dt.Rows[0]["heading_line_spacing"].ToString();
            txtBodyFontSize.Text = dt.Rows[0]["body_font_size"].ToString();
            txtLogosize.Text = dt.Rows[0]["logo_size"].ToString();

            lblOpacity.Text = dt.Rows[0]["watermark_opacity"].ToString();
            creditCheck.Checked = bool.Parse(dt.Rows[0]["cb_visibility"].ToString());
            waterCheck.Checked = bool.Parse(dt.Rows[0]["wm_visibility"].ToString());
            //
            Body1.Style.Add("font-size", dt.Rows[0]["body_font_size"].ToString() + "px");
            Body2.Style.Add("font-size", dt.Rows[0]["body_font_size"].ToString() + "px");
            conw.Style.Add("font-size", dt.Rows[0]["body_font_size"].ToString() + "px");

            companyNameSpan.Style.Add("font-size", dt.Rows[0]["heading_font_size"].ToString() + "px");
            companyNameSpan.Style.Add("line-height", dt.Rows[0]["heading_line_spacing"].ToString() + "px");

            HeaderInv.Style.Add("font-size", dt.Rows[0]["heading_font_size"].ToString() + "px");
            HeaderInv.Style.Add("line-height", dt.Rows[0]["heading_line_spacing"].ToString() + "px");

            HeaderInv.InnerText = dt.Rows[0]["heading_name"].ToString();

            RaksTDiv.Style.Add("opacity", dt.Rows[0]["watermark_opacity"].ToString());

            RaksTDiv.Visible = bool.Parse(dt.Rows[0]["wm_visibility"].ToString());
            CreditDiv2.Visible = bool.Parse(dt.Rows[0]["cb_visibility"].ToString());
            CreditDiv.Visible = bool.Parse(dt.Rows[0]["cb_visibility"].ToString());
        }
        private void EditInvoice()
        {
            if (Request.QueryString["item_id"] != null)
            {
                selectSpan.Visible = true;
                btnEditLine.Visible = true;
                btnDeleteLine.Visible = true;
                itemNumber.InnerText = Request.QueryString["item_id"].ToString();
                selectedItem.InnerText = Request.QueryString["item"].ToString();
                SQLOperation sqlop = new SQLOperation("select * from tblsale_and_invoice where id = '" + Request.QueryString["item_id"].ToString() + "'");
                txtEditQuantity.Text = sqlop.ReadTable().Rows[0]["quantity"].ToString();
                txtEditUnitPrice.Text = sqlop.ReadTable().Rows[0]["unit_price"].ToString();
            }
        }
        private void BindCredit()
        {
            if (Request.QueryString["invno"] != null)
            {
                string invno = Request.QueryString["invno"].ToString();
                CreditOperation co = new CreditOperation();
                co.TransactionNumber = invno;
                DataTable dt = co.GetCreditInfo();
                if (dt.Rows.Count != 0)
                {
                    credittotal.InnerText = Convert.ToDouble(dt.Rows[0]["balance"].ToString()).ToString("#,##0.00");
                    creditLink.Visible = false;
                }
            }
        }
        private void GetTotals()
        {
            if (Request.QueryString["invno"] != null)
            {
                string invno = Request.QueryString["invno"].ToString();
                SQLOperation slo = new SQLOperation("select *from tblinvoice where invoice_number='" + invno + "'");
                DataTable dt = slo.ReadTable();

                //
                Total.InnerText = Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()).ToString("#,##0.00");
                subTotal.InnerText = (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) / 1.15).ToString("#,##0.00");
                vatAmount.InnerText = (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) - (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) / 1.15)).ToString("#,##0.00");
            }
        }
        private void NumberToWord()
        {
            if (Request.QueryString["invno"] != null)
            {
                double total = Convert.ToDouble(Total.InnerText);
                NumberToWord NumToWrd = new NumberToWord();
                AmountInWords.InnerText = NumToWrd.ConvertAmount(total);
            }
        }
        private void BindCompanyInfo()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblcompany");
            companyNameSpan.InnerText = sqlop.ReadTable().Rows[0]["company_name"].ToString();
            CompAddress.InnerText = sqlop.ReadTable().Rows[0]["address"].ToString();
            Contact.InnerText = sqlop.ReadTable().Rows[0]["phone"].ToString();
            VendorTIN.InnerText = sqlop.ReadTable().Rows[0]["tin"].ToString();
            VendorVatRegNumber.InnerText = sqlop.ReadTable().Rows[0]["vat_registration_number"].ToString();
            rptrLogo.DataSource = sqlop.ReadTable();
            rptrLogo.DataBind();
        }
        private void ShowInvoiceInfoAndHTMLElement()
        {
            if (Request.QueryString["invno"] != null && Request.QueryString["fsno"] != null)
            {
                InvoiceDiv.Visible = false;
                invoiceDetailDiv.Visible = true;
                //

                invoiceDetailSpan.InnerText = "INV#-" + Convert.ToInt64(Request.QueryString["invno"].ToString()).ToString("D8");
                invoiceDetailSpan.Visible = true;
                salesIconSpan.Visible = false;
                salesSpan.Visible = false;
                buttonback.Visible = true;
                btnCustomize.Visible = true;
                btnSendEmail.Visible = true;
                btnDelete.Visible = true;
                btnEdit.Visible = true;
                btnDuplicate.Visible = true;
                creditLink.Visible = true;
                commentLink.Visible = true;
                refundLink.Visible = true;
                buttondiv.Visible = false;
                invoiceStatus.Visible = true;
                InvNoBinding.InnerText = "INV#-" + Convert.ToInt64(Request.QueryString["invno"].ToString()).ToString("D8"); ;

                //
                if (Request.QueryString["fsno"] == null || Request.QueryString["fsno"] == "")
                {
                    FSno.InnerText = "FS#-NONE";
                }
                else
                {
                    FSno.InnerText = "FS#-" + Convert.ToInt64(Request.QueryString["fsno"].ToString()).ToString("D8");
                    txtEditFSNumber.Text = Convert.ToInt64(Request.QueryString["fsno"].ToString()).ToString("D8");
                }

                txtEdiInvNumber.Text = Convert.ToInt64(Request.QueryString["invno"].ToString()).ToString("D8");
                //
                SalesOperation slo = new SalesOperation();
                DataTable dt = slo.GetSalesInfo(Request.QueryString["invno"].ToString());
                rptrAttachment.DataSource = dt;
                rptrAttachment.DataBind();
                //
                PaymentMode.InnerText = dt.Rows[0]["payment_mode"].ToString();
                dateSpan.InnerText = dt.Rows[0]["date"].ToString();
                RefTag.InnerText = "Tra.Ref.:" + dt.Rows[0]["ref_number"].ToString();
                //Check Sale Type;
                SQLOperation so = new SQLOperation("select * from tblinvoice where invoice_number = '" + Request.QueryString["invno"].ToString() + "'");
                if (so.ReadTable().Rows[0]["invoice_type"].ToString() == "Cash Sale")
                {
                    invoiceStatus.Attributes.Add("class", "badge mr-2 text-gray-700 text-uppercase badge-light  font-weight-bold");
                    invoiceStatus.InnerText = so.ReadTable().Rows[0]["invoice_type"].ToString();
                }
                else if (so.ReadTable().Rows[0]["invoice_type"].ToString() == "Credit Sale")
                {
                    invoiceStatus.Attributes.Add("class", "badge mr-2 text-uppercase text-white badge-warning  font-weight-bold");
                    invoiceStatus.InnerText = so.ReadTable().Rows[0]["invoice_type"].ToString();
                }
                else if (so.ReadTable().Rows[0]["invoice_type"].ToString() == "Draft")
                {
                    invoiceStatus.Attributes.Add("class", "badge mr-2 text-uppercase text-white badge-warning  font-weight-bold");
                    invoiceStatus.InnerText = so.ReadTable().Rows[0]["invoice_type"].ToString();
                }
                else
                {
                    invoiceStatus.Attributes.Add("class", "badge mr-2 text-uppercase text-white badge-danger  font-weight-bold");
                    invoiceStatus.InnerText = so.ReadTable().Rows[0]["invoice_type"].ToString();
                }
                if (invoiceStatus.InnerText == "Draft")
                    draftConverter.Visible = true;
            }
        }
        private void BindCustomerInfo()
        {
            if (Request.QueryString["customer"] != null)
            {
                CustomerOperation co = new CustomerOperation(Request.QueryString["customer"].ToString());
                if (co.GetCustomerInfo().Rows.Count != 0)
                {
                    DataTable dt = co.GetCustomerInfo();
                    Name.InnerText = dt.Rows[0]["customer_name"].ToString();
                    CustVatRegNumber.InnerText = dt.Rows[0]["vat_registration_number"].ToString();
                    TINNUMBER.InnerText = dt.Rows[0]["tin"].ToString();
                    Address.InnerText = dt.Rows[0]["address"].ToString();
                }
            }
        }
        private void BindInvoiceData()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblinvoice");
            //rptrInvoice.DataSource = sqlop.ReadTable();
            //rptrInvoice.DataBind();
            if (sqlop.ReadTable().Rows.Count != 0)
            {
                PagedDataSource Pds1 = new PagedDataSource();
                Pds1.DataSource = sqlop.ReadDataset().Tables[0].DefaultView;
                Pds1.AllowPaging = true;
                Pds1.PageSize = 10;
                Pds1.CurrentPageIndex = CurrentPage;
                Label1.Text = "Showing Page: " + (CurrentPage + 1).ToString() + " of " + Pds1.PageCount.ToString();
                btnPrevious.Enabled = !Pds1.IsFirstPage;
                btnNext.Enabled = !Pds1.IsLastPage;
                rptrInvoice.DataSource = Pds1;
                rptrInvoice.DataBind();
            }
            else
            {
                InvoiceDiv.Visible = false;
                mainb.Visible = true;
                buttondiv.Visible = false;
            }
        }
        private void BindInvoiceSmallData()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblinvoice");
            rptInvoiceShort.DataSource = sqlop.ReadTable();
            rptInvoiceShort.DataBind();
        }
        public int CurrentPage
        {
            get
            {
                object s1 = this.ViewState["CurrentPage"];
                if (s1 == null)
                {
                    return 0;
                }
                else
                {
                    return Convert.ToInt32(s1);
                }
            }

            set { this.ViewState["CurrentPage"] = value; }
        }
        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            CurrentPage -= 1;
            BindInvoiceData();

        }
        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage += 1;
            BindInvoiceData();

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
        private void BindReferenceNumber()
        {
            //ReferenceGenerator rg = new ReferenceGenerator();
            txtReferenceNumber.Text = "CS-" + Convert.ToInt64(invoiceSpan.InnerText).ToString("D6") + "-" + DateTime.Now.ToString("yy");
        }
        [WebMethod]
        public static string GetDiscountAppliedMode()
        {
            SQLOperation sqlop = new SQLOperation("select * from tbldiscount_preferences");
            return sqlop.ReadTable().Rows[0]["applied"].ToString();
        }
        private void BindDiscountModes()
        {
            SQLOperation sqlop = new SQLOperation("select * from tbldiscount_preferences");
            ddlDiscountApplied.DataSource = sqlop.ReadTable();
            ddlDiscountApplied.DataTextField = "applied";
            ddlDiscountApplied.DataBind();

            ddlDiscountApplied.Items.Insert(1, new ListItem("After Tax", "1"));
            ddlDiscountApplied.Items.Insert(2, new ListItem("Before Tax", "2"));


            if (sqlop.ReadTable().Rows[0]["discount_mode"].ToString() == "No")
            {
                ddlDiscountApplied.Style.Add("display", "none");
                no.Checked = true;
            }
            if (sqlop.ReadTable().Rows[0]["discount_mode"].ToString() == "Line")
            {
                ddlDiscountApplied.Style.Add("display", "none");
                line.Checked = true;
            }
            if (sqlop.ReadTable().Rows[0]["discount_mode"].ToString() == "Transactional")
            {
                ddlDiscountApplied.Style.Add("display", "block");
                transactional.Checked = true;
            }
        }
        protected void btnSaveDiscountOption_Click(object sender, EventArgs e)
        {
            if (no.Checked == true)
            {
                SQLOperation sqlop = new SQLOperation("update tbldiscount_preferences set discount_mode = 'No',applied='" + ddlDiscountApplied.SelectedItem.Text + "'");
                sqlop.MakeCUD();
            }
            if (line.Checked == true)
            {
                SQLOperation sqlop = new SQLOperation("update tbldiscount_preferences set discount_mode = 'Line',applied='" + ddlDiscountApplied.SelectedItem.Text + "'");
                sqlop.MakeCUD();
            }
            if (transactional.Checked == true)
            {
                SQLOperation sqlop = new SQLOperation("update tbldiscount_preferences set discount_mode = 'Transactional',applied='" + ddlDiscountApplied.SelectedItem.Text + "'");
                sqlop.MakeCUD();
            }

            Response.Redirect(Request.RawUrl);
        }
        private void IsDiscountEnabled()
        {
            SQLOperation sqlop = new SQLOperation("select * from tbldiscount_preferences");
            string isEnabled = sqlop.ReadTable().Rows[0]["discount_mode"].ToString();
            if (isEnabled == "No") { discountDiv.Visible = false; txtDiscount.Visible = false; ddlTransactionDiscountType.Style.Add("display", "none"); descriptionDiv.Attributes.Add("class", "col-5"); }
            if (isEnabled == "Line") { discountDiv.Visible = true; txtDiscount.Visible = false; ddlTransactionDiscountType.Style.Add("display", "none"); }
            if (isEnabled == "Transactional")
            {
                discountDiv.Visible = false; txtDiscount.Visible = true; descriptionDiv.Attributes.Add("class", "col-5");
                ddlTransactionDiscountType.Style.Add("display", "block");
            }
        }
        [WebMethod]
        public static List<string> GetFSnumberSetings()
        {
            SQLOperation slo = new SQLOperation("select * from tblfiscal_printer_settings");
            List<string> lst = new List<string>();
            lst.Add(slo.ReadTable().Rows[0]["allow_fsno"].ToString());
            lst.Add(slo.ReadTable().Rows[0]["allow_fsno_select"].ToString());
            return lst;
        }
        [WebMethod]
        public static string BindFSnumber()
        {
            SalesOperation slo = new SalesOperation();
            return Convert.ToInt64(slo.FSnumberCounter().ToString()).ToString("D8");
        }
        private void BindInvoiceNumber()
        {
            SalesOperation slo = new SalesOperation();
            invoiceSpan.InnerText = Convert.ToInt64(slo.InvoiceNumberCounter().ToString()).ToString("D8");
        }
        private void BindCustomer()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblcustomer");
            DataTable dt = sqlop.ReadTable();
            ddlExistingCustomer.DataSource = dt;
            ddlExistingCustomer.DataTextField = "customer_name";
            ddlExistingCustomer.DataBind();
            ddlExistingCustomer.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        [WebMethod]
        public static List<string> GetCustomerInfo(string name)
        {
            List<string> lst = new List<string>();
            CustomerOperation co = new CustomerOperation(name);
            DataTable dt = co.GetCustomerInfo();
            string tin = dt.Rows[0]["tin"].ToString();
            string address = dt.Rows[0]["address"].ToString();
            lst.Add(tin);
            lst.Add(address);
            return lst;
        }
        public void BindSalesOrderNumber()
        {
            SQLOperation so = new SQLOperation("select * from tblsales_order_main where invoice_status = 'Confirmed' or invoice_status = 'Unconfirmed'");
            ddlOrderNumber.DataSource = so.ReadTable();
            ddlOrderNumber.DataValueField = "order_number";
            ddlOrderNumber.DataBind();
            ddlOrderNumber.Items.Insert(0, new ListItem("-Select Order Number-", "0"));
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
            SQLOperation so = new SQLOperation("select * from tblsales_order where order_number = '" + orderNumber + "'");
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
        public static List<string> BindOrderCustomer(string orderNumber)
        {
            List<string> lst = new List<string>();
            SQLOperation so = new SQLOperation("select * from tblsales_order_main where order_number = '" + orderNumber + "'");
            DataTable dt = so.ReadTable();
            string customerName = dt.Rows[0]["customer_name"].ToString();
            string customerAddress = dt.Rows[0]["customer_address"].ToString();
            string customerTin = dt.Rows[0]["customer_tin"].ToString();

            //Add to List
            lst.Add(customerName);
            lst.Add(customerAddress);
            lst.Add(customerTin);

            return lst;
        }
        [WebMethod]
        public static List<double> BindOrderSubtotals(string orderNumber)
        {
            List<double> lst = new List<double>();
            SQLOperation so = new SQLOperation("select sum(total_amount) from tblsales_order where order_number = '" + orderNumber + "'");
            DataTable dt = so.ReadTable();
            double totalAmount = Convert.ToDouble(dt.Rows[0][0].ToString()) + 0.15* Convert.ToDouble(dt.Rows[0][0].ToString());
            double subtotal = Convert.ToDouble(dt.Rows[0][0].ToString());
            double vat = totalAmount - subtotal;


            //Add to List
            lst.Add(totalAmount);
            lst.Add(subtotal);
            lst.Add(vat);

            return lst;
        }
        [WebMethod]
        public static List<string> GetItemRate(string itemName)
        {
            List<string> lst = new List<string>();
            StoreOperation so = new StoreOperation(itemName);
            lst.Add(so.GetItemInfo().Rows[0]["sale_price"].ToString());
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
        public static void CreateInvoice(string customerName, string itemName, string referenceNumber,
            string date, string unit, string salePrice, string salesDescription, string quantity,
            string totalAmount, string balance, string invoiceNumber, string fsno, string tin, string pm,
            string address, string bankName, string discount)
        {
            SalesOperation slo = new SalesOperation();
            slo.CustomerName = customerName;
            slo.ItemName = itemName;
            slo.ReferenceNumber = referenceNumber;
            slo.Date = date;
            slo.Unit = unit;
            slo.SalePrice = salePrice;
            slo.SalesDescription = salesDescription;
            slo.SalesQuantity = quantity;
            slo.TotalAmount = totalAmount;
            slo.Balance = balance;
            slo.InvoiceNumber = invoiceNumber;
            slo.FSNumber = fsno;
            slo.TIN = tin;
            slo.PaymentMode = pm;
            slo.Address = address;
            slo.BankName = bankName;
            //Which type of discount to use
            slo.Discount = discount;
            slo.CreateSales();
        }
        protected void btnCreateInvoice_Click(object sender, EventArgs e)
        {
            SalesOperation slo = new SalesOperation();
            slo.CustomerName = txtCustomerName.Text;
            slo.InvoiceNumber = invoiceSpan.InnerText;

            slo.Balance = txtCreditAmount.Text;
            slo.Date = txtDate.Text;
            slo.FSNumber = txtFSNumber.Text;
            if (refund.Checked == true)
            {
                slo.InvoiceType = "Refund";
            }
            else
            {
                if (Convert.ToDouble(txtCreditAmount.Text) > 0)
                    slo.InvoiceType = "Credit Sale";
                else
                    slo.InvoiceType = "Cash Sale";
            }
            double Tdiscount = 0; double Ldiscount = 0;
            if (txtDiscount.Visible == true)
                Tdiscount = Convert.ToDouble(txtDiscount.Text);
            if (txtDiscountLine.Visible == true)
                Ldiscount = Convert.ToDouble(txtDiscountLine.Text);
            if (transactional.Checked == true)
            {
                if (ddlDiscountApplied.SelectedItem.Text == "Before Tax")
                {
                    if (ddlTransactionDiscountType.SelectedItem.Text == "%")
                    {
                        double total = 0;
                        double discount = Convert.ToDouble(txtVatFree.Text) * (Convert.ToDouble(txtDiscount.Text) / 100);
                        double beforeVatamount = Convert.ToDouble(txtVatFree.Text) - discount;
                        total += beforeVatamount + beforeVatamount * 0.15;
                        slo.TotalAmount = total.ToString();

                        slo.Discount = discount.ToString();

                    }
                    else
                    {
                        double total = 0;
                        double discount = Convert.ToDouble(txtDiscount.Text);
                        double beforeVatamount = Convert.ToDouble(txtVatFree.Text) - discount;
                        total += beforeVatamount + beforeVatamount * 0.15;
                        slo.Discount = discount.ToString();
                        slo.TotalAmount = total.ToString();
                    }
                }
                else
                {
                    if (ddlTransactionDiscountType.SelectedItem.Text == "%")
                    {
                        double total = Convert.ToDouble(txtGrandTotal.Text);
                        double discount = Convert.ToDouble(txtGrandTotal.Text) * (Convert.ToDouble(txtDiscount.Text) / 100);
                        total = total - discount;
                        slo.Discount = discount.ToString();
                        slo.TotalAmount = total.ToString();
                    }
                    else
                    {
                        double total = Convert.ToDouble(txtGrandTotal.Text);
                        double discount = Convert.ToDouble(txtDiscount.Text);
                        total = total - discount;
                        slo.TotalAmount = total.ToString();
                        slo.Discount = discount.ToString();
                    }
                }
            }
            else
            {
                slo.TotalAmount = txtGrandTotal.Text;
                slo.Discount = txtTotalDiscount.Text;
            }

            if (Tdiscount > 0 || Ldiscount > 0)
            {
                slo.IsDiscounted = "Yes";
            }
            else
            {
                slo.IsDiscounted = "No";

            }
            if (ddlLineDiscountType.SelectedItem.Text == "ETB" && line.Checked == true)
            {
                slo.DiscountType = "amount";
            }
            if (ddlLineDiscountType.SelectedItem.Text == "%" && line.Checked == true)
            {
                slo.DiscountType = "percent";
            }

            if (ddlTransactionDiscountType.SelectedItem.Text == "ETB" && transactional.Checked == true)
            {
                slo.DiscountType = "amount";
            }
            if (ddlTransactionDiscountType.SelectedItem.Text == "%" && transactional.Checked == true)
            {
                slo.DiscountType = "percent";
            }
            if (no.Checked == true)
            {
                slo.DiscountType = "";
            }
            slo.CreateInvoice();
            Response.Redirect("sales.aspx?invno=" + invoiceSpan.InnerText + "&&fsno=" + txtFSNumber.Text + "&&customer=" + txtCustomerName.Text);
            Response.Redirect(Request.RawUrl);
        }
        protected void btnSaveBankAccount_Click(object sender, EventArgs e)
        {
            BankOperation bo = new BankOperation();
            bo.BankName = txtBankName.Text;
            bo.AccountNumber = txtAccountNumber.Text;
            bo.AddBankAccount();
            Response.Redirect(Request.RawUrl);
        }
        protected void btnSaveLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null && Request.QueryString["edit"] != null)
            {
                SQLOperation sqlop = new SQLOperation("update tblsale_and_invoice set quantity='" + txtEditQuantity.Text + "'" +
                    ",unit_price='" + txtEditUnitPrice.Text + "'" +
                    ", total_amount='" + Convert.ToDouble(txtEditQuantity.Text) * Convert.ToDouble(txtEditUnitPrice.Text) + "' where id='" + Request.QueryString["item_id"].ToString() + "'");
                sqlop.MakeCUD();

                sqlop.cmdText = "select sum(total_amount) from tblsale_and_invoice where invoice_number='" + Request.QueryString["invno"].ToString() + "'";

                double vatFree = double.Parse(sqlop.ReadTable().Rows[0][0].ToString());

                double total = vatFree + vatFree * 0.15;

                sqlop.cmdText = "update tblinvoice set total_amount='" + total + "' where invoice_number='" + Request.QueryString["invno"].ToString() + "'";
                sqlop.MakeCUD();
                Response.Redirect(Request.RawUrl);

            }
        }

        protected void btnDeleteInvoice_Click(object sender, EventArgs e)
        {
            SQLOperation sqlop = new SQLOperation("delete from tblsale_and_invoice where invoice_number='" + Request.QueryString["invno"].ToString() + "'");
            sqlop.MakeCUD();

            sqlop.cmdText = "delete from tblinvoice where invoice_number='" + Request.QueryString["invno"].ToString() + "'";
            sqlop.MakeCUD();

            Response.Redirect("sales.aspx");
        }
        protected void btnSaveEditInvoiceInfo_Click(object sender, EventArgs e)
        {
            SQLOperation sqlop = new SQLOperation("update tblsale_and_invoice set invoice_number='" + txtEdiInvNumber.Text + "', fsno='" + txtEditFSNumber.Text + "' where invoice_number='" + Request.QueryString["invno"].ToString() + "'");
            sqlop.MakeCUD();

            //
            sqlop.cmdText = "update tblinvoice set invoice_number='" + txtEdiInvNumber.Text + "', fsno='" + txtEditFSNumber.Text + "' where invoice_number='" + Request.QueryString["invno"].ToString() + "'";
            sqlop.MakeCUD();

            Response.Redirect("sales.aspx?invno=" + txtEdiInvNumber.Text + "&&fsno=" + txtEditFSNumber.Text + "&&customer=" + Name.InnerText);

        }
        protected void btnSaveCustomization_Click(object sender, EventArgs e)
        {
            SQLOperation sqlop = new SQLOperation("update tblinvoice_customization set heading_name='" + txtHeadingName.Text + "', heading_font_size='" + txtHeadingFontsize.Text + "'" +
                ",heading_line_spacing='" + txtHeadingLineHeight.Text + "',body_font_size='" + txtBodyFontSize.Text + "',logo_size='" + txtLogosize.Text + "'" +
                ",cb_visibility='" + creditCheck.Checked + "',wm_visibility='" + waterCheck.Checked + "'");
            sqlop.MakeCUD();
            Response.Redirect(Request.RawUrl);
        }

        protected void btnSaveCredit_Click(object sender, EventArgs e)
        {
            CreditOperation co = new CreditOperation(Name.InnerText, Request.QueryString["invno"].ToString());
            co.TotalAmount = Total.InnerText;
            co.Balance = txtAddCreditAmount.Text;
            co.CreditType = "Sale";
            co.Date = dateSpan.InnerText;
            co.PaymentMode = PaymentMode.InnerText;
            co.CreateCredit();

            SQLOperation sqlop = new SQLOperation("update tblinvoice set balance='" + txtAddCreditAmount.Text + "' where invoice_number='" + Request.QueryString["invno"].ToString() + "'");
            sqlop.MakeCUD();
            Response.Redirect(Request.RawUrl);
        }

        protected void btnSaveComment_Click(object sender, EventArgs e)
        {
            SalesOperation so = new SalesOperation();
            so.InvoiceNumber = InvNoBinding.InnerText;
            so.Comments = txtInvoiceComment.Text;
            so.AddComment();
            Response.Redirect(Request.RawUrl);
        }

        protected void btnSaveAsDraft_Click(object sender, EventArgs e)
        {
            SalesOperation slo = new SalesOperation();
            slo.CustomerName = txtCustomerName.Text;
            slo.InvoiceNumber = invoiceSpan.InnerText;

            slo.Balance = txtCreditAmount.Text;
            slo.Date = txtDate.Text;
            slo.FSNumber = "";
            slo.InvoiceType = "Draft";
            double Tdiscount = 0; double Ldiscount = 0;
            if (txtDiscount.Visible == true)
                Tdiscount = Convert.ToDouble(txtDiscount.Text);
            if (txtDiscountLine.Visible == true)
                Ldiscount = Convert.ToDouble(txtDiscountLine.Text);
            if (transactional.Checked == true)
            {
                if (ddlDiscountApplied.SelectedItem.Text == "Before Tax")
                {
                    if (ddlTransactionDiscountType.SelectedItem.Text == "%")
                    {
                        double total = 0;
                        double discount = Convert.ToDouble(txtVatFree.Text) * (Convert.ToDouble(txtDiscount.Text) / 100);
                        double beforeVatamount = Convert.ToDouble(txtVatFree.Text) - discount;
                        total += beforeVatamount + beforeVatamount * 0.15;
                        slo.TotalAmount = total.ToString();

                        slo.Discount = discount.ToString();

                    }
                    else
                    {
                        double total = 0;
                        double discount = Convert.ToDouble(txtDiscount.Text);
                        double beforeVatamount = Convert.ToDouble(txtVatFree.Text) - discount;
                        total += beforeVatamount + beforeVatamount * 0.15;
                        slo.Discount = discount.ToString();
                        slo.TotalAmount = total.ToString();
                    }
                }
                else
                {
                    if (ddlTransactionDiscountType.SelectedItem.Text == "%")
                    {
                        double total = Convert.ToDouble(txtGrandTotal.Text);
                        double discount = Convert.ToDouble(txtGrandTotal.Text) * (Convert.ToDouble(txtDiscount.Text) / 100);
                        total = total - discount;
                        slo.Discount = discount.ToString();
                        slo.TotalAmount = total.ToString();
                    }
                    else
                    {
                        double total = Convert.ToDouble(txtGrandTotal.Text);
                        double discount = Convert.ToDouble(txtDiscount.Text);
                        total = total - discount;
                        slo.TotalAmount = total.ToString();
                        slo.Discount = discount.ToString();
                    }
                }
            }
            else
            {
                slo.TotalAmount = txtGrandTotal.Text;
                slo.Discount = txtTotalDiscount.Text;
            }

            if (Tdiscount > 0 || Ldiscount > 0)
            {
                slo.IsDiscounted = "Yes";
            }
            else
            {
                slo.IsDiscounted = "No";

            }
            if (ddlLineDiscountType.SelectedItem.Text == "ETB" && line.Checked == true)
            {
                slo.DiscountType = "amount";
            }
            if (ddlLineDiscountType.SelectedItem.Text == "%" && line.Checked == true)
            {
                slo.DiscountType = "percent";
            }

            if (ddlTransactionDiscountType.SelectedItem.Text == "ETB" && transactional.Checked == true)
            {
                slo.DiscountType = "amount";
            }
            if (ddlTransactionDiscountType.SelectedItem.Text == "%" && transactional.Checked == true)
            {
                slo.DiscountType = "percent";
            }
            if (no.Checked == true)
            {
                slo.DiscountType = "";
            }
            slo.CreateInvoice();
            Response.Redirect("sales.aspx?invno=" + invoiceSpan.InnerText + "&&fsno=" + txtFSNumber.Text + "&&customer=" + txtCustomerName.Text);
        }
        protected void btnConvertToInvoice_Click1(object sender, EventArgs e)
        {
            double credit = 0;
            if (Request.QueryString["invno"] != null)
            {
                SQLOperation sqlop = new SQLOperation("select * from tblinvoice where invoice_number = '" + Request.QueryString["invno"].ToString() + "'");
                DataTable dt = sqlop.ReadTable();
                if (dt.Rows.Count != 0)
                    credit = Convert.ToDouble(dt.Rows[0]["balance"].ToString());
                String invoiceType = "Cash Sale";
                if (isRefund.Checked == true)
                    invoiceType = "Refund";
                else
                    if (credit > 0)
                    invoiceType = "Credit Sale";
                SQLOperation so = new SQLOperation("update tblinvoice set invoice_type='" + invoiceType + "', fsno='" + txtDraftFSNumber.Text + "', date='" + txtDraftDate.Text + "'");
                so.MakeCUD();
                string invNo = Request.QueryString["invno"].ToString();
                Response.Redirect("sales.aspx?invno=" + invNo + "&&fsno=" + txtDraftFSNumber.Text + "&&customer=" + Name.InnerText);
            }
        }
        protected void btnFilterRecord_Click(object sender, EventArgs e)
        {
            string searchQuery = string.Empty;
            string dateFrom = string.Empty;

            if (txtDateFrom.Text != "" || txtDateFrom.Text != null)
                dateFrom = Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd").Substring(0, 10);

            string dateTo = string.Empty;

            if (txtDateTo.Text != "" || txtDateTo.Text != null)
                dateTo = Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd").Substring(0, 10);

            searchQuery += "select * from tblinvoice where ";
            searchQuery += "date between '" + dateFrom + "' ";
            searchQuery += "and '" + dateTo + "'";
            if (advancedSearch.Checked == true)
            {
                searchQuery += " or customer_name = '" + txtCustomerSearchName.Text + "' or invoice_number = '" + txtInvoiceNumber.Text + "' ";
                searchQuery += " or invoice_type = '" + ddlInvoiceType.SelectedItem.Text + "'";
            }
            invoiceStatus.Visible = true;
            invoiceStatus.InnerText = searchQuery;
            SQLOperation so = new SQLOperation(searchQuery);
            DataTable dt = so.ReadTable();
            rptrInvoice.DataSource = dt;
            rptrInvoice.DataBind();
            rptInvoiceShort.DataSource = dt;
            rptInvoiceShort.DataBind();
        }

        protected void rptrInvoice_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in rptrInvoice.Items)
            {
                Label lblStatus = item.FindControl("lblStatus") as Label;
                if (lblStatus.Text == "Cash Sale")
                    lblStatus.Attributes.Add("class", "badge badge badge-success");
                if (lblStatus.Text == "Credit Sale")
                    lblStatus.Attributes.Add("class", "badge badge badge-warning");
                if (lblStatus.Text == "Refund")
                    lblStatus.Attributes.Add("class", "badge badge badge-danger");
            }
        }

        protected void btnDeleteLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null && Request.QueryString["edit"] != null)
            {
                SQLOperation so = new SQLOperation("delete from tblsale_and_invoice where id = '" + Request.QueryString["item_id"].ToString() + "'");
                so.MakeCUD();
                string invno = Request.QueryString["invno"].ToString();
                string fsno = Request.QueryString["fsno"].ToString();
                string customer = Request.QueryString["customer"].ToString();
                Response.Redirect("sales.aspx?invno=" + invno + "&&fsno=" + fsno + "&&customer=" + customer);

            }
        }
    }
}