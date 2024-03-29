﻿namespace pos.app.classes
{
    public interface IStore
    {
        string Quantity { get; set; }
        string ItemName { get; set; }
        string ItemCode { get; set; }
        string ItemCategory { get; set; }
        string ShelfNo { get; set; }
        string Date { get; set; }
        string ExpiredDate { get; set; }
        string Warehouse { get; set; }
        string WarehouseAddress { get; set; }
        string IssuedPerson { get; set; }
        string Barcode { get; set; }
        string Description { get; set; }
        string PurchasePrice { get; set; }
        string SalePrice { get; set; }
        string Unit { get; set; }
        string SKU { get; set; }
        string Manufacturer { get; set; }
        string ReorderPoint { get; set; }
        string TaxRate { get; set; }
        string CreatedSource { get; set; }
    }
}