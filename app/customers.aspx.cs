using pos.app.classes;
using System;

namespace pos.app
{
    public partial class customers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCustomer();
            }
        }
        private void BindCustomer()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblcustomer");
            if (sqlop.ReadTable().Rows.Count != 0)
            {
                rptrCustomer.DataSource = sqlop.ReadTable();
                rptrCustomer.DataBind();
            }
        }
        protected void btnCreateCustomer_Click(object sender, EventArgs e)
        {
            CustomerOperation co = new CustomerOperation();
            co.BusinessType = txtBusinessType.Text;
            co.Name = txtCustomerName.Text;
            co.Company = txtCompanyName.Text;
            co.Email = txtEmail.Text;
            co.Phone = txtPhone.Text;
            co.Website = txtWebsite.Text;
            co.CreditLimit = txtCreditLimit.Text;
            co.Status = "Active";
            co.Address = txtAddress.Text;
            co.TIN = txtTinNumber.Text;
            co.VatRegistrationNumber = txtVatRegNumber.Text;
            co.AddCustomer();
        }
    }
}