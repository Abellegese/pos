namespace pos.app.classes
{
    public class UserUtility : SQLOperation
    {
        public string UserName { get; set; }
        public UserUtility() { }
        public string BindUser()
        {
            string fulName = string.Empty;
            base.cmdText = "select * from tblusers where username='" + System.Web.HttpContext.Current.Session["USERNAME"].ToString() + "'";
            if (base.ReadTable().Rows.Count != 0)
            {
                fulName = base.ReadTable().Rows[0]["full_name"].ToString();
            }
            return fulName;
        }
    }
}