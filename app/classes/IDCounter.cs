using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace pos.app.classes
{
    public class IDCounter : SQLOperation
    {
        public Int64 Id { get; set; }
        public string Cmd { get; set; }
        public IDCounter(string cmdTxt) => this.Cmd = cmdTxt;
        public Int64 CountTableID()
        {
            base.cmdText = this.Cmd;
            this.Id = Convert.ToInt64(base.ReadTable().Rows[0][0].ToString());
            return Id;
        }
    }
}