using System.Data;
using System.Data.SQLite;
using System.Web;

namespace pos.app.classes
{
    public class SQLOperation
    {
        public string cmdText { get; set; }
        private string connectionString = "Data Source=" + HttpContext.Current.Server.MapPath("~/inventorydb.db");
        public SQLOperation() { }
        public SQLOperation(string cmdText) => this.cmdText = cmdText;
        //CUD Stands for Create <-> Update <-> Delete
        public void MakeCUD()
        {

            using (SQLiteConnection con = new SQLiteConnection(connectionString))
            {
                SQLiteCommand cmd = new SQLiteCommand(cmdText, con);
                con.Open();
                cmd.ExecuteScalar();
                con.Close();
            }
        }
        public DataTable ReadTable()
        {
            DataTable dt = new DataTable();
            using (SQLiteConnection con = new SQLiteConnection(connectionString))
            {
                SQLiteCommand cmd = new SQLiteCommand(cmdText, con);
                SQLiteDataAdapter sda = new SQLiteDataAdapter(cmd);
                sda.Fill(dt);
                con.Close();
            }
            return dt;
        }
    }
}