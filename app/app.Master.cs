using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web.Services;
using System.Web.UI.WebControls;
using pos.app.classes;

namespace pos.app
{
    public partial class app : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { BindFiscalPrinterSettings(); }
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
            bool isLogoAllowed = bool.Parse(so.ReadTable().Rows[0]["allow_logo"].ToString());
            if (isDiscountAllowed == true)
                discount.Checked = true;
            if (isSurchargeAllowed == true)
                surcharge.Checked = true;
            if (isLogoAllowed == true)
                logoAllow.Checked = true;
            if (isLogoAllowed == false)
                logoDisallow.Checked = true;
        }
        protected void btnSaveDeviceType_Click(object sender, EventArgs e)
        {

        }
        protected void btnSaveCommandType_Click(object sender, EventArgs e)
        {

        }

        protected void btnSaveFiscalSettings_Click(object sender, EventArgs e)
        {
            bool isLogoAllowed = true;
            if (logoDisallow.Checked == true)
                isLogoAllowed = false;
            SQLOperation so = new SQLOperation("insert into tblfiscal_printer_settings values ('" + discount.Checked + "','" + surcharge.Checked + "','" + isLogoAllowed + "')");
            so.MakeCUD();
        }
    }
}