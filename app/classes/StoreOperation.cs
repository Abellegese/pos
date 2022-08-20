using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace pos.app.classes
{
    public class StoreOperation : SQLOperation
    {
        public string ProductName { get; set; }
        private string WarehouseName { get; set; }
        public StoreOperation() { }
        public StoreOperation(string ProductName, string cmdText) : base(cmdText) => this.ProductName = ProductName;
        public StoreOperation(string ProductName) => this.ProductName = ProductName;
        public void AddItem()
        {
            
        }
        public void RemoveItem()
        {

        }
        public void CreateWarehouse()
        {

        }
    }
}