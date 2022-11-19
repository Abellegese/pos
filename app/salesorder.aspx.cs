using pos.app.classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Services;
using System.Web.UI.WebControls;

namespace pos.app
{
    public partial class salesorder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSalesOrder();
                GetItemInfo();
                BindCustomer();
                BindSalesOrderNumber();
                GetOrderDetails();
                GetTotals();
                BindCompanyInfo();
                BindCustomerInfo();
                EditLineItem();
            }
        }
        private void BindCustomerInfo()
        {
            if (Request.QueryString["sono"] != null)
            {
                SQLOperation sqlop = new SQLOperation("select * from tblsales_order_main where order_number='" + Request.QueryString["sono"].ToString() + "'");
                if (sqlop.ReadTable().Rows.Count != 0)
                {
                    DataTable dt = sqlop.ReadTable();
                    Name.InnerText = dt.Rows[0]["customer_name"].ToString();
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
            if (Request.QueryString["sono"] != null)
            {
                string sono = Request.QueryString["sono"].ToString();
                SQLOperation slo = new SQLOperation("select *from tblsales_order_main where order_number='" + sono + "'");
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
        public static void CreateSalesOrder(string customerName, string itemName, string date, string unitPrice, string description
            , string quantity, string totalAmount, string salesOrderNumber)
        {
            SalesOperation so = new SalesOperation
            {
                CustomerName = customerName,
                ItemName = itemName,
                Date = date,
                SalePrice = unitPrice,
                SalesDescription = description,
                SalesQuantity = quantity,
                TotalAmount = totalAmount,
                SalesOrderNumber = salesOrderNumber
            };
            so.CreateSalesOrderDetails();
        }
        private void BindSalesOrderNumber()
        {
            SalesOperation slo = new SalesOperation();
            orderSpan.InnerText = Convert.ToInt64(slo.SalesOrderNumberCounter().ToString()).ToString("D8");
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
        private void GetOrderDetails()
        {
            if (Request.QueryString["sono"] != null)
            {
                SorderDiv.Visible = false;
                SODetailDiv.Visible = true;
                buttondiv.Visible = false;
                orderDetailSpan.Visible = true;
                salesIconSpan.Visible = false;
                buttonback.Visible = true;
                salesSpan.Visible = false;
                //Buttons
                btnDelete.Visible = true;
                salesOrderNumberSpan.InnerText = Convert.ToInt64(Request.QueryString["sono"].ToString()).ToString("D8");
                orderDetailSpan.InnerText = "SO#-" + Convert.ToInt64(Request.QueryString["sono"].ToString()).ToString("D8");
                SQLOperation sqlop = new SQLOperation("select * from tblsales_order where order_number = '" + Request.QueryString["sono"].ToString() + "'");
                if (sqlop.ReadTable().Rows.Count != 0)
                {
                    rptrSODetails.DataSource = sqlop.ReadTable();
                    rptrSODetails.DataBind();
                }
                sqlop.cmdText = "select * from tblsales_order_main";

                if (sqlop.ReadTable().Rows.Count != 0)
                {
                    rptSOShort.DataSource = sqlop.ReadTable();
                    rptSOShort.DataBind();
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
        private void BindSalesOrder()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblsales_order_main");
            if (sqlop.ReadTable().Rows.Count != 0)
            {
                rptrSalesOrder.DataSource = sqlop.ReadTable();
                rptrSalesOrder.DataBind();
            }
            else
            {
                rptrSalesOrder.Visible = false;
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
        protected void btnCreateSalesOrder_Click(object sender, EventArgs e)
        {
            SalesOperation so = new SalesOperation();
            so.CustomerName = txtCustomerName.Text;
            so.Address = txtAddress.Text;
            so.TIN = txtTINNumber.Text;
            so.TotalAmount = txtGrandTotal.Text;
            so.SalesOrderNumber = orderSpan.InnerText;
            so.Date = txtDate.Text;
            so.CreateSalesOrder();
            Response.Redirect("salesorder.aspx?sono=" + orderSpan.InnerText);
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
                selectedItem.InnerText = Request.QueryString["item_name"].ToString();
                //Get item unit price and quantity
                SQLOperation so = new SQLOperation();
                so.cmdText = "select * from tblsales_order where id = '" + itemId + "'";
                DataTable dt = so.ReadTable();
                if(dt.Rows.Count != 0)
                {
                    txtEditUnitPrice.Text = Convert.ToDouble(dt.Rows[0]["unit_price"].ToString()).ToString("#,##0.00");
                    txtEditQuantity.Text = Convert.ToDouble(dt.Rows[0]["quantity"].ToString()).ToString("#,##0.00");
                }
            }
        }
        protected void btnSaveLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null)
            {
                string itemId = Request.QueryString["item_id"].ToString();
                SQLOperation so = new SQLOperation();
                double totalAmount = Convert.ToDouble(txtEditQuantity.Text) * Convert.ToDouble(txtEditUnitPrice.Text);
                so.cmdText = "update tblsales_order set unit_price = '" + txtEditUnitPrice.Text + "', quantity = '" + txtEditQuantity.Text + "',total_amount='" + totalAmount + "'  where id = '" + itemId + "'";
                so.MakeCUD();
                //Updating the total from the main sales order table
                so.cmdText = "select sum(total_amount) from tblsales_order where order_number='" + Request.QueryString["sono"].ToString() + "'";

                double vatFree = double.Parse(so.ReadTable().Rows[0][0].ToString());

                double total = vatFree + vatFree * 0.15;
                so.cmdText = "update tblsales_order_main set amount='" + total + "' where order_number='" + Request.QueryString["sono"].ToString() + "'";
                so.MakeCUD();
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void btnDeleteOrder_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["sono"] != null)
            {
                string sono = Request.QueryString["sono"].ToString();
                SQLOperation so = new SQLOperation();
                so.cmdText = "delete from tblsales_order where order_number = '" + sono + "'";
                so.MakeCUD();
                so.cmdText = "delete from tblsales_order_main where order_number = '" + sono + "'";
                so.MakeCUD();
                Response.Redirect("salesorder.aspx");
            }
        }

        protected void btnDeleteLineItem_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["item_id"] != null)
            {
                string itemId = Request.QueryString["item_id"].ToString();
                string sono = Request.QueryString["sono"].ToString();
                if (Request.QueryString["sono"] != null)
                {
                    SQLOperation so = new SQLOperation();
                    so.cmdText = "delete from tblsales_order where order_number = '" + sono + "'";
                    so.MakeCUD();
                    Response.Redirect("salesorder.aspx?sono=" + sono);
                }
            }
        }

        protected void btnSearchByCustomer_Click(object sender, EventArgs e)
        {
            SQLOperation so = new SQLOperation();
            so.cmdText = "select * from tblsales_order_main where customer_name like '%" + txtSearchCustomerName.Text + "%'";
            DataTable dt = so.ReadTable();
            rptrSalesOrder.DataSource = dt;
            rptrSalesOrder.DataBind();
            rptSOShort.DataSource = dt;
            rptSOShort.DataBind();
        }
        protected void btnFilterRecordByDate_Click(object sender, EventArgs e)
        {
            string dateFrom = string.Empty;

            if (txtDateFrom.Text != "" || txtDateFrom.Text != null)
                dateFrom += Convert.ToDateTime(txtDateFrom.Text).ToString("yyyy-MM-dd").Substring(0, 10);

            string dateTo = string.Empty;

            if (txtDateTo.Text != "" || txtDateTo.Text != null)
                dateTo += Convert.ToDateTime(txtDateTo.Text).ToString("yyyy-MM-dd").Substring(0, 10);
            SQLOperation so = new SQLOperation();
            so.cmdText = "select * from tblsales_order_main where date between '" + txtDateFrom.Text + "' and '" + txtDateTo.Text + "'";
            DataTable dt = so.ReadTable();
            rptrSalesOrder.DataSource = dt;
            rptrSalesOrder.DataBind();
            rptSOShort.DataSource = dt;
            rptSOShort.DataBind();
        }

        protected void rptSOShort_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in rptSOShort.Items)
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
        protected void rptrSalesOrder_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in rptrSalesOrder.Items)
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