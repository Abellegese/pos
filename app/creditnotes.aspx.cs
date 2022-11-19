using pos.app.classes;
using System;
using System.Data;
using System.Web.UI.WebControls;
namespace pos.app
{
    public partial class creditnotes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindCredit();
                BindCreditDetails();
                BindCompanyInfo();
                GetTotals();
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
                if (dt.Rows.Count != 0)
                {
                    Total.InnerText = Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()).ToString("#,##0.00");
                    subTotal.InnerText = (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) / 1.15).ToString("#,##0.00");
                    vatAmount.InnerText = (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) - (Convert.ToDouble(dt.Rows[0]["total_amount"].ToString()) / 1.15)).ToString("#,##0.00");
                }
            }
        }
        private void BindCredit()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblcredit_note");
            rptrCredit.DataSource = sqlop.ReadTable();
            rptrCredit.DataBind();
        }
        private void BindCompanyInfo()
        {
            SQLOperation sqlop = new SQLOperation("select * from tblcompany");
            oname.InnerText = sqlop.ReadTable().Rows[0]["company_name"].ToString();
            oAddress.InnerText = sqlop.ReadTable().Rows[0]["address"].ToString();

            rptrLogo.DataSource = sqlop.ReadTable();
            rptrLogo.DataBind();
        }
        private void BindCreditDetails()
        {
            if (Request.QueryString["cid"] != null && Request.QueryString["invno"] != null)
            {
                SQLOperation sqlop = new SQLOperation("select * from tblcredit_note where id='" + Request.QueryString["cid"].ToString() + "'");
                rptCreditNotesDetail.DataSource = sqlop.ReadTable();
                rptCreditNotesDetail.DataBind();
                if (sqlop.ReadTable().Rows.Count != 0)
                {
                    CreditTitle.InnerText = sqlop.ReadTable().Rows[0]["credit_type"].ToString() + " credit";
                    Name.InnerText = sqlop.ReadTable().Rows[0]["customer_or_vendor"].ToString();
                    dueAmount.InnerText = Convert.ToDouble(sqlop.ReadTable().Rows[0]["balance"].ToString()).ToString("#,#0.00");
                    buttonback.Visible = true;
                    creditDiv.Visible = false;
                    creditDetailDiv.Visible = true;
                    txtCreditAmount.Text = Convert.ToDouble(sqlop.ReadTable().Rows[0]["balance"].ToString()).ToString("#,#0.00");
                    if (Convert.ToDouble(sqlop.ReadTable().Rows[0]["balance"].ToString()) > 0)
                    {
                        creditStatusSpan.InnerText = "PENDING";
                        creditStatusSpan.Attributes.Add("class", "badge mr-2 text-white text-white font-weight-bold badge-danger");
                    }
                    else
                    {
                        creditStatusSpan.InnerText = "PAID";
                        creditStatusSpan.Attributes.Add("class", "badge mr-2 text-white text-white font-weight-bold badge-success");
                        btnReceiveCredits.Visible = false;
                    }
                    creditDetailSpan.Visible = true;
                    creditDetailSpan.InnerText = "CN#-" + Request.QueryString["cid"].ToString();
                    CNNumber.InnerText = Request.QueryString["cid"].ToString();
                    INVNumber.InnerText = Request.QueryString["invno"].ToString();
                    creditsSpan.Visible = false;
                    creditIconSpan.Visible = false;

                    creditStatusSpan.Visible = true;
                    SalesOperation slo = new SalesOperation();
                    DataTable dt = slo.GetSalesInfo(Request.QueryString["invno"].ToString());
                    rptrAttachment.DataSource = dt;
                    rptrAttachment.DataBind();
                    //Make buttons visible
                    btnDelete.Visible = true;
                    btnEdit.Visible = true;
                    btnSendEmail.Visible = true;
                }
            }
        }
        protected void btnDeleteCredit_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["cid"] != null && Request.QueryString["invno"] != null)
            {
                SQLOperation sqlop = new SQLOperation("delete from tblcredit_note where id = '" + Request.QueryString["cid"].ToString() + "'");
                sqlop.MakeCUD();

                sqlop.cmdText = "update tblinvoice set balance = '0'  where invoice_number = '" + Request.QueryString["invno"].ToString() + "'";
                sqlop.MakeCUD();
                Response.Redirect("creditnotes.aspx");
            }
        }

        protected void btnSaveEditCreditAmount_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["cid"] != null && Request.QueryString["invno"] != null)
            {
                SQLOperation sqlop = new SQLOperation("update tblcredit_note set balance='" + txtEditCreditAmount.Text + "' where id = '" + Request.QueryString["cid"].ToString() + "'");
                sqlop.MakeCUD();

                sqlop.cmdText = "update tblinvoice set balance = '" + txtEditCreditAmount.Text + "'  where invoice_number = '" + Request.QueryString["invno"].ToString() + "'";
                sqlop.MakeCUD();
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void btnReceiveCredit_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["cid"] != null && Request.QueryString["invno"] != null)
            {

                double newCredit = Convert.ToDouble(dueAmount.InnerText) - Convert.ToDouble(txtCreditAmount.Text);
                SQLOperation sqlop = new SQLOperation("update tblcredit_note set balance='" + newCredit + "' where id = '" + Request.QueryString["cid"].ToString() + "'");
                sqlop.MakeCUD();

                sqlop.cmdText = "update tblinvoice set balance = '" + newCredit + "'  where invoice_number = '" + Request.QueryString["invno"].ToString() + "'";
                sqlop.MakeCUD();
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void rptrCredit_ItemDataBound(object sender, System.Web.UI.WebControls.RepeaterItemEventArgs e)
        {
            foreach (RepeaterItem item in rptrCredit.Items)
            {
                Label lblBalance = item.FindControl("lblBalance") as Label;
                Label lblStatus = item.FindControl("lblStatus") as Label;
                if (Convert.ToDouble(lblBalance.Text) > 0)
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