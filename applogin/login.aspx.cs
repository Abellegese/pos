using System;
using System.Data;
using pos.app.classes;
using System.Data.SQLite;

namespace pos.applogin
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=" + Server.MapPath("~/app/database/inventorydb.db");
            SQLiteConnection con = new SQLiteConnection(connectionString);
            //Creating parametrized command [preventing every sql  injection]
            string sql = "SELECT * FROM tblusers WHERE username=@UserName and password=@pwd and status = 'Active'";
            SQLiteCommand cmd = new SQLiteCommand(sql, con);
            SQLiteParameter[] param = new SQLiteParameter[2];
            param[0] = new SQLiteParameter("@UserName", txtUsername.Text);
            param[1] = new SQLiteParameter("@pwd", txtPassword.Text);
            cmd.Parameters.Add(param[0]);
            cmd.Parameters.Add(param[1]);
            con.Open();
            object res = cmd.ExecuteScalar();
            con.Close();
            if (Convert.ToInt32(res) > 0)
            {
                Session["USERNAME"] = txtUsername.Text;
                Response.Redirect("~/app/dashboard.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid Username Or Password";
            }
        }
    }
}