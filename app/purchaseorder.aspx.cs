using pos.app.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace pos.app
{
    public partial class purchaseorder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPurchaseOrder();
                GetItemInfo();
                BindVendor();
                BindPurchaseOrderNumber();
                GetOrderDetails();
                GetTotals();
                BindCompanyInfo();
                BindCustomerInfo();
                EditLineItem();
            }
        }
        private void BindCustomerInfo()
        {
            if (Request.QueryString["pono"] != null)
            {
                SQLOperation sqlop = new SQLOperation("select * from tblpurchase_order_main where order_number='" + Request.QueryString["pono"].ToString() + "'");
                if (sqlop.ReadTable().Rows.Count != 0)
                {
                    DataTable dt = sqlop.ReadTable();
                    Name.InnerText = dt.Rows[0]["vendor_name"].ToString();
                    dateOfOrder.InnerText = "Order Date: " + dt.Rows[0]["date"].ToString();
                }
            }
        }
        private void BindCompanyInfo()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblcompany");
            companyNameSpan.InnerText = sqlop.ReadTable().Rows[0]["company_name"].ToString();
            countrySpan.InnerText = sqlop.ReadTable().Rows[0]["country"].ToString();
        }
        private void GetTotals()
        {
            if (Request.QueryString["pono"] != null)
            {
                string pono = Request.QueryString["pono"].ToString();
                SQLOperation slo = new SQLOperation("select *from tblpurchase_order_main where order_number='" + pono + "'");
                DataTable dt = slo.ReadTable();
                if (dt.Rows.Count != 0)
                {
                    //
                    Total.InnerText = Convert.ToDouble(dt.Rows[0]["amount"].ToString()).ToString("#,##0.00");
                    subTotal.InnerText = (Convert.ToDouble(dt.Rows[0]["amount"].ToString()) / 1.15).ToString("#,##0.00");
                    vatAmount.InnerText = (Convert.ToDouble(dt.Rows[0]["amount"].ToString()) - (Convert.ToDouble(dt.Rows[0]["amount"].ToString()) / 1.15)).ToString("#,##0.00");
                }
            }
        }
        [WebMethod]
        public static void CreatePurchaseOrder(string vendorName, string itemName, string date, string unitPrice, string description
            , string quantity, string totalAmount, string purchaseOrderNumber)
        {
            PurchaseOperation so = new PurchaseOperation
            {
                VendorName = vendorName,
                ItemName = itemName,
                Date = date,
                PurchasePrice = unitPrice,
                PurchaseDescription = description,
                PurchaseQuantity = quantity,
                TotalAmount = totalAmount,
                PurchaseOrderNumber = purchaseOrderNumber
            };
            so.CreatePurchaseOrderDetails();
        }
        private void BindPurchaseOrderNumber()
        {
            PurchaseOperation slo = new PurchaseOperation();
            orderSpan.InnerText = slo.PurchaseOrderNumberCounter().ToString();
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
        private void BindVendor()
        {
            SQLOperation sqlop = new SQLOperation("select* from tblvendor");
            DataTable dt = sqlop.ReadTable();
            ddlExistingVendor.DataSource = dt;
            ddlExistingVendor.DataTextField = "vendor_name";
            ddlExistingVendor.DataBind();
            ddlExistingVendor.Items.Insert(0, new ListItem("-Select-", "0"));
        }
        [WebMethod]
        public static List<string> GetVendorInfo(string name)
        {
            List<string> lst = new List<string>();
            VendorOperation co = new VendorOperation(name);
            DataTable dt = co.GetVendorInfo();
            string tin = dt.Rows[0]["tin"].ToString();
            string address = dt.Rows[0]["billing_address"].ToString();
            lst.Add(tin);
            lst.Add(address);
            return lst;
        }
        private void GetOrderDetails()
        {
            if (Request.QueryString["pono"] != null)
            {
                SorderDiv.Visible = false;
                PODetailDiv.Visible = true;
                buttondiv.Visible = false;

                orderDetailSpan.Visible = true;
                purchasesIconSpan.Visible = false;
                buttonback.Visible = true;
                purchasesSpan.Visible = false;
                //Buttons
                btnDelete.Visible = true;
                pucrhaseOrderNumberSpan.InnerText = Convert.ToInt64(Request.QueryString["pono"].ToString()).ToString("D8");
                orderDetailSpan.InnerText = "PO#-" + Convert.ToInt64(Request.QueryString["pono"].ToString()).ToString("D8");
                SQLOperation sqlop = new SQLOperation("select * from tblpurchase_order where order_number = '" + Request.QueryString["pono"].ToString() + "'");
                if (sqlop.ReadTable().Rows.Count != 0)
                {
                    rptrPODetails.DataSource = sqlop.ReadTable();
                    rptrPODetails.DataBind();
                }
                sqlop.cmdText = "select * from tblpurchase_order_main";

                if (sqlop.ReadTable().Rows.Count != 0)
                {
                    rptPOShort.DataSource = sqlop.ReadTable();
                    rptPOShort.DataBind();
                }
            }
        }
        private void EditLineItem()
        {
            if (Request.QueryString["item_id"] != null)
            {
                string itemId = Request.QueryString["item_id"].ToString();

                selectSpan.Visible = true;
                itemNumber.InnerText = itemId;
                btnDeleteLine.Visible = true;
                btnEditLine.Visible = true;
                selectedItem.InnerText = Request.QueryString["item"].ToString();
                //Get item unit price and quantity
                SQLOperation so = new SQLOperation();
                so.cmdText = "select * from tblpurchase_order where id = '" + itemId + "'";
                DataTable dt = so.ReadTable();
                if (dt.Rows.Count != 0)
                {
                    txtEditUnitPrice.Text = Convert.ToDouble(dt.Rows[0]["unit_price"].ToString()).ToString("#,##0.00");
                    txtEditQuantity.Text = Convert.ToDouble(dt.Rows[0]["quantity"].ToString()).ToString("#,##0.00");
                }
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
        private void BindPurchaseOrder()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblpurchase_order_main");
            if (sqlop.ReadTable().Rows.Count != 0)
            {
                rptrPurchaseOrder.DataSource = sqlop.ReadTable();
                rptrPurchaseOrder.DataBind();
            }
            else
            {
                rptrPurchaseOrder.Visible = false;
                main.Visible = true;
                buttondiv.Visible = false;
            }
        }
        protected void btnPrevious_Click(object sender, EventArgs e)
        {

        }

        protected void btnNext_Click(object sender, EventArgs e)
        {

        }
        protected void btnSaveLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null)
            {
                string itemId = Request.QueryString["item_id"].ToString();
                SQLOperation so = new SQLOperation();
                double totalAmount = Convert.ToDouble(txtEditQuantity.Text) * Convert.ToDouble(txtEditUnitPrice.Text);
                so.cmdText = "update tblpurchase_order set unit_price = '" + txtEditUnitPrice.Text + "', quantity = '" + txtEditQuantity.Text + "',total_amount='" + totalAmount + "'  where id = '" + itemId + "'";
                so.MakeCUD();
                //Updating the total from the main sales order table
                so.cmdText = "select sum(total_amount) from tblpurchase_order where order_number='" + Request.QueryString["pono"].ToString() + "'";

                double vatFree = double.Parse(so.ReadTable().Rows[0][0].ToString());

                double total = vatFree + vatFree * 0.15;
                so.cmdText = "update tblpurchase_order_main set amount='" + total + "' where order_number='" + Request.QueryString["pono"].ToString() + "'";
                so.MakeCUD();
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void btnDeleteOrder_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["pono"] != null)
            {
                string pono = Request.QueryString["pono"].ToString();
                SQLOperation so = new SQLOperation();
                so.cmdText = "delete from tblpurchase_order where order_number = '" + pono + "'";
                so.MakeCUD();
                so.cmdText = "delete from tblpurchase_order_main where order_number = '" + pono + "'";
                so.MakeCUD();
                Response.Redirect("purchaseorder.aspx");
            }
        }

        protected void btnDeleteLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null)
            {
                string itemId = Request.QueryString["item_id"].ToString();
                string pono = Request.QueryString["pono"].ToString();
                if (Request.QueryString["pono"] != null)
                {
                    SQLOperation so = new SQLOperation();
                    so.cmdText = "delete from tblpurchase_order where order_number = '" + pono + "'";
                    so.MakeCUD();
                    Response.Redirect("purchaseorder.aspx?pono=" + pono);
                }
            }
        }
        protected void btnCreatePurchaseOrder_Click(object sender, EventArgs e)
        {
            PurchaseOperation so = new PurchaseOperation();
            so.VendorName = txtVendorName.Text;
            so.Address = txtAddress.Text;
            so.TIN = txtTINNumber.Text;
            so.TotalAmount = txtGrandTotal.Text;
            so.PurchaseOrderNumber = orderSpan.InnerText;
            so.Date = txtDate.Text;
            so.CreatePurchaseOrder();
            Response.Redirect("purchaseorder.aspx?pono=" + orderSpan.InnerText);
        }

        protected void rptrPurchaseOrder_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in rptrPurchaseOrder.Items)
            {
                Label lblStatus = item.FindControl("lblStatus") as Label;
                if (lblStatus.Text == "Unconfirmed")
                {
                    lblStatus.Attributes.Add("class", "badge badge badge-danger");
                }
                else
                {
                    lblStatus.Attributes.Add("class", "badge badge badge-success");
                }
            }
        }

        protected void rptPOShort_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in rptPOShort.Items)
            {
                Label lblStatus = item.FindControl("lblStatus") as Label;
                if (lblStatus.Text == "Unconfirmed")
                {
                    lblStatus.Attributes.Add("class", "badge badge badge-danger");
                }
                else
                {
                    lblStatus.Attributes.Add("class", "badge badge badge-success");
                }
            }
        }
    }
}