using pos.app.classes;
using System;
using System.Data;
using System.IO;

namespace pos.app
{
    public partial class app : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindFiscalPrinterSettings();
                BindFiscalType();
                GetPrinterSN();
            }
        }
        public void GetPrinterSN()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblfiscal_printer_active");
            DataTable dt = sqlop.ReadTable();
            serialNumber.InnerText = dt.Rows[0]["fiscal_id"].ToString();
        }
        private void BindFiscalType()
        {
            SQLOperation so = new SQLOperation("select * from tblfiscal_printer_type");
            DataTable dt = so.ReadTable();
            ddlFiscalTypes.DataSource = dt;
            ddlFiscalTypes.DataTextField = "fiscal_type";
            ddlFiscalTypes.DataBind();
        }
        protected void btnSaveCompany_Click(object sender, EventArgs e)
        {
            string SavePath = Server.MapPath("~/asset/images/logo/");
            if (!Directory.Exists(SavePath))
            {
                Directory.CreateDirectory(SavePath);
            }
            string Extention = Path.GetExtension(FileUpload1.PostedFile.FileName);
            FileUpload1.SaveAs(SavePath + "\\" + FileUpload1.FileName + Extention);
            string path = "~/asset/images/logo/";
            string totalPath = path + FileUpload1.FileName;
            SQLOperation sqlop = new SQLOperation("insert into tblcompany values('" + txtCompanyName.Text + "','" + txtAddress.Text + "'" +
                ",'" + totalPath + "','" + txtEmail.Text + "','" + txtFax.Text + "','" + txtPhone.Text + "'" +
                ",'" + txtCountry.Text + "','" + ddlBusinessType.SelectedItem.Text + "','" + txtTin.Text + "','" + txtVatRegNumber.Text + "')");
            sqlop.MakeCUD();
        }
        private void BindFiscalPrinterSettings()
        {
            SQLOperation so = new SQLOperation("select * from tblfiscal_printer_settings");
            bool isDiscountAllowed = bool.Parse(so.ReadTable().Rows[0]["allow_discount"].ToString());
            bool isSurchargeAllowed = bool.Parse(so.ReadTable().Rows[0]["allow_surcharge"].ToString());
            bool isOperatorAllowed = bool.Parse(so.ReadTable().Rows[0]["allow_operator"].ToString());
            bool isUniqueSaleNumber = bool.Parse(so.ReadTable().Rows[0]["allow_unique_sale_no"].ToString());
            bool isFSNumber = bool.Parse(so.ReadTable().Rows[0]["allow_fsno"].ToString());
            bool isFSNumberSelectionFromPrinter = bool.Parse(so.ReadTable().Rows[0]["allow_fsno_SELECT"].ToString());
            discount.Checked = isDiscountAllowed;
            surcharge.Checked = isSurchargeAllowed;
            @operator.Checked = isOperatorAllowed;
            saleno.Checked = isUniqueSaleNumber;
            fsno.Checked = isFSNumber;
            fsnoSelection.Checked = isFSNumberSelectionFromPrinter;
        }
        protected void btnSaveDeviceType_Click(object sender, EventArgs e)
        {
            SQLOperation so = new SQLOperation();
            so.cmdText = "insert into tblfiscal_printer_type values('" + txtFiscalPrinterType.Text + "')";
            so.MakeCUD();
            Response.Redirect(Request.RawUrl);
        }
        protected void btnSaveCommandType_Click(object sender, EventArgs e)
        {

        }

        protected void btnSaveFiscalSettings_Click(object sender, EventArgs e)
        {
            SQLOperation so = new SQLOperation("update  tblfiscal_printer_settings set allow_discount = '" + discount.Checked + "'" +
                ",allow_surcharge = '" + surcharge.Checked + "',allow_operator = '" + @operator.Checked + "',allow_unique_sale_no = '" + saleno.Checked + "'" +
                ",allow_fsno = '" + fsno.Checked + "',allow_fsno_select = '" + fsnoSelection.Checked + "'");
            so.MakeCUD();
            Response.Redirect(Request.RawUrl);
        }

        protected void btnSaveFiscalName_Click(object sender, EventArgs e)
        {
            SQLOperation so = new SQLOperation();
            so.cmdText = "update tblfiscal_printer_active set fiscal_name = '" + ddlFiscalTypes.SelectedItem.Text + "', fiscal_id = '" + txtPrinterID.Text.ToLower() + "'";
            so.MakeCUD();
            Response.Redirect(Request.RawUrl);
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/applogin/login.aspx");
        }
    }
}