using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using pos.app.classes;
using System.Web.Services;
using System.Data;

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
                    dateOfOrder.InnerText = "Order Date: " +dt.Rows[0]["date"].ToString();
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
            ,string quantity, string totalAmount, string salesOrderNumber)
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
            orderSpan.InnerText = slo.SalesOrderNumberCounter().ToString();
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
                salesOrderNumberSpan.InnerText = Request.QueryString["sono"].ToString();
                SQLOperation sqlop = new SQLOperation("select * from tblsales_order where order_number = '" + Request.QueryString["sono"].ToString() + "'");
                if(sqlop.ReadTable().Rows.Count != 0 )
                {
                    rptrSODetails.DataSource = sqlop.ReadTable();
                    rptrSODetails.DataBind();
                }
                sqlop.cmdText = "select * from tblsales_order_main";

                if(sqlop.ReadTable().Rows.Count != 0)
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
    }
}