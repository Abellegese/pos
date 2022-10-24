<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="pos.app.product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Products</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pl-3 pr-3" id="container" runat="server">
        <div class="row">
            <div class="col">

                <div class="bg-white rounded-lg">
                    <div class="card-header bg-white ">
                        <div class="row">
                            <div class="col-md-4 text-left">
                                <span class="fas fa-folder-plus mr-2" id="itemDropIcon" runat="server" style="color: #d46fe8"></span><span id="itemDrop" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">ITEMS</span>

                                <a class="btn btn-circle btn-sm text-white btn-light mr-2" id="buttonback" href="product.aspx" visible="false" runat="server" data-toggle="tooltip" data-placement="bottom" title="Back to Product">

                                    <span class="fa fa-arrow-left text-gray-600"></span>

                                </a>
                                <span class="badge mr-2 text-white badge-light text-gray-600 font-weight-bold" visible="false" id="itemDetailSpan" runat="server"></span>
                            </div>
                            <div class="col-md-8 text-right">
                                <div class="dropdown no-arrow">
                                    <button type="button" visible="false" runat="server" id="btnAdjustItemsModalButton" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#adjustItemsModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Adjust Items" class="fas fa-plus text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnEditItemModalButton" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#ModalCreateInvoice">
                                        <div>
                                            <i data-toggle="tooltip" title="Edit Items" class="fas fa-pencil-alt text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnDeleteItemModalButton" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#DeleteItemModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Delete Items" class="fas fa-trash text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <div class="vr">
                                    </div>
                                    <button type="button" runat="server" id="Sp2" class="mr-1 btn btn-sm btn-circle" style="background-color: #d46fe8" data-toggle="modal" data-target="#createNewIteModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Create New Item" class="fas fa-plus text-white font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>

                                    <button class="btn btn-light btn-circle mx-2 dropdown-toggle" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

                                        <a class="nav-link btn btn-sm" data-toggle="tooltip" data-placement="bottom" title="Options">
                                            <div>
                                                <i class="fas fa-caret-down text-danger"></i>

                                            </div>
                                        </a>

                                    </button>


                                    <div class="dropdown-menu  dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                        <div class="dropdown-header text-gray-900">Option:</div>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#createNewCategoryModal" id="A2" runat="server"><span class="fas fa-plus mr-2 " style="color: #d46fe8"></span>Create Item Category</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#createNewWarehouseModal" id="LR" runat="server"><span class="fas fa-plus mr-2 " style="color: #d46fe8"></span>Create Warehouse</a>

                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>

                    <div class="card-body small text-gray-900" style="margin-top: -21px" id="productDiv" runat="server">
                        <asp:Repeater ID="rptrProducts" runat="server">

                            <HeaderTemplate>
                                <div class="table-responsive">
                                    <table class="table align-items-center table-sm ">
                                        <thead>
                                            <tr>

                                                <th scope="col" class="text-gray-900">ITEM NAME</th>
                                                <th scope="col" class="text-gray-900">SKU </th>
                                                <th scope="col" class="text-gray-900">STOCK OH HAND </th>
                                                <th scope="col" class="text-gray-900 text-right">REORDER LEVEL</th>




                                            </tr>
                                        </thead>
                                        <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>

                                    <td class="text-gray-900">
                                        <a class=" text-primary " href="product.aspx?pid=<%# Eval("id")%>&&pname=<%# Eval("item_name")%>"><span><%# Eval("item_name")%></span></a>
                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="lblCustomer" runat="server" Text='<%# Eval("sku")%>'></asp:Label>
                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="Label4" runat="server" Text=''></asp:Label>

                                    </td>
                                    <td class="text-gray-900 text-right">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("reorder_point" , "{0:N2}")%>'></asp:Label>

                                    </td>

                                </tr>

                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                  </table>
                            </FooterTemplate>

                        </asp:Repeater>
                    </div>
                    <center>

                        <main role="main" id="mainb" class="mt-5" runat="server" visible="false">

                            <div class="starter-template">
                                <center>


                                    <p class="lead">

                                        <i class="fas fa-donate text-gray-300  fa-5x"></i>

                                    </p>
                                    <h6 class="text-gray-700 h6 font-italic">No Product Found</h6>
                                </center>
                            </div>



                        </main>
                    </center>
                    <div class="card-body" id="productDetailDiv" runat="server" visible="false">
                        <div class="row">
                            <div class="col-4 border-right" style="margin-top:-21px">
                                <asp:Repeater ID="rptpProductDetail" runat="server">

                                    <HeaderTemplate>
                                        <table class="table align-items-center table-hover table-sm ">

                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="border-bottom">

                                            <td>
                                                <a class=" text-primary " href="product.aspx?pid=<%# Eval("id")%>&&pname=<%# Eval("item_name")%>"><span><%# Eval("item_name")%></span></a>
                                                <br />
                                                <span class="text-xs text-gray-400 font-weight-bold text-uppercase">reorder point</span>
                                                <span id="Label3" runat="server" class="tetx-xs text-gray-400 font-weight-bold text-uppercase"><%# GetStockInfo( Eval("item_name").ToString()).Item1 %></span>


                                            </td>

                                            <td class="text-gray-900 text-right">
                                                <h6><span class="small text-gray-400 font-weight-bold text-uppercase">STOCK ON HAND</h6>
                                                <asp:Label ID="Label2" runat="server" class="badge badge-warning" ><%# GetStockBalance( Eval("item_name").ToString()) %></asp:Label>
                                                <asp:Label ID="Label8" runat="server" class="text-xs text-gray-400 font-weight-bold text-uppercase" ><%# GetStockInfo( Eval("item_name").ToString()).Item2 %></asp:Label>

                                            </td>

                                        </tr>

                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                  </table>
                                    </FooterTemplate>

                                </asp:Repeater>
                            </div>
                            <div class="col-8">
                                <div id="div_print">
                                    <div class="row" style="overflow-y: scroll; max-height: 800px">
                                    
                                        <div class="col-10">
                                            <div class="row ">
                                                <div class="col-md-8 text-left">
                                                   <div class="row mb-3">
                                                       <div class="col-6">
                                                           <span class="small text-gray-500">Item Types</span><br />
                                                           <span class="small text-gray-500">Unit</span><br />
                                                           <span class="small text-gray-500">Maufacturer</span><br />
                                                           <span class="small text-gray-500">Created Source</span><br />
                                                           <span class="small text-gray-500">Inventory Account</span><br />
                                                       </div>
                                                       <div class="col-6">
                                                           <span class="small text-gray-500" id="inventoryTypeSpan" runat="server" >Inventory Items</span><br />
                                                           <span class="small text-gray-500" id="unitSpan" runat="server"></span><br />
                                                           <span class="small text-gray-500" id="manufacturerSpan" runat="server"></span><br />
                                                           <span class="small text-gray-500" id="createdSourceSpan" runat="server"></span><br />
                                                           <span class="small text-gray-500" id="inventoryAccountSpan" runat="server"></span><br />

                                                       </div>
                                                   </div>
                                                    <span class="small mb-2 text-gray-700 font-weight-bold border-bottom border-top">Purchase Information</span>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <span class="small text-gray-500">Cost Price</span><br />
                                                            <span class="small text-gray-500">Purchase Account</span><br />
                                                    
                                                        </div>
                                                        <div class="col-6">
                                                            <span class="small text-gray-500" id="purchasePriceSpan" runat="server"></span><br />
                                                            <span class="small text-gray-500" id="purchaseAccountSpan" runat="server"></span><br />
                                                            <br />
                                                          
                                                        </div>
                                                    </div>
                                                    <span class="small mb-3 text-gray-700 font-weight-bold border-bottom border-top">Sales Information</span>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <span class="small text-gray-500">Selling Price</span><br />
                                                            <span class="small text-gray-500">Sales Account</span><br />
                                                        </div>
                                                        <div class="col-6">
                                                            <span class="small text-gray-500" id="sellingPriceSpan" runat="server"></span><br />
                                                            <span class="small text-gray-500" id="salesAccountSpan" runat="server"></span><br />
                                                        </div>
                                                    </div>
                                                    <span class="small mb-3 text-gray-700 font-weight-bold border-bottom border-top">Stock Location</span>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <span class="small text-gray-500">Warehouse Name</span><br />
                                                            <span class="small text-gray-500">Stock on Hand</span><br />
                                                            <span class="small text-gray-500">Commited Stock</span><br />
                                                            <span class="small text-gray-500">Available for Sale</span><br />
                                                        </div>
                                                        <div class="col-6">
                                                            <span class="small text-gray-500" id="warehouseNameSpan" runat="server"></span><br />
                                                            <span class="small text-gray-500" id="stockOnHandSpan" runat="server"></span><br />
                                                            <span class="small text-gray-500" id="commitedStock" runat="server"></span><br />
                                                            <span class="small text-gray-500" id="availableForSale" runat="server"></span><br />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 text-right">
                                                    <img class="" src='' height="120" width="120" alt="" id="LogoImage" runat="server" />
                                                    <br />
                                                    <br />

                                                    <span class="h5 mt-4 text-center text-uppercase text-gray-500 bg-light" id="itemName" runat="server"></span>
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <br />
                                                    <div class="row mb-3">
                                                        <div class="col-12">
                                                            <span class="small text-primary">Opening Stock <span class="mx-2 text-gray-500 font-weight-bold" id="openingStock" runat="server"></span></span><br />
                                                 
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <span class="small text-primary">0  <span class="mx-2 text-gray-500 font-weight-bold">Qty</span></span><br />
                                                            <span class=" text-xs text-gray-500">To be Shiped</span>

                                                        </div>
                                                        <div class="col-6">
                                                            <span class="small text-primary">0  <span class="mx-2 text-gray-500 font-weight-bold">Qty</span></span><br />
                                                            <span class=" text-xs text-gray-500">To be Received</span>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <span class="small text-primary">0  <span class="mx-2 text-gray-500 font-weight-bold">Qty</span></span><br />
                                                            <span class=" text-xs text-gray-500">To be Invoiced</span>
                                                        </div>
                                                        <div class="col-6">
                                                            <span class="small text-primary">0  <span class="mx-2 text-gray-500 font-weight-bold">Qty</span></span><br />
                                                            <span class=" text-xs text-gray-500">To be Billed</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer bg-white py-4" id="buttondiv" runat="server">
                    <nav aria-label="...">
                        <ul class="pagination justify-content-end mb-0">
                            <br />
                            <td>
                                <asp:Label ID="Label1" runat="server" class="m-1 small text-uppercase text-gray-500"></asp:Label>
                            </td>
                            <br />
                            <li class="page-item active">

                                <asp:LinkButton ID="btnPrevious" OnClick="btnPrevious_Click" data-toggle="tooltip" title="Previous" class="btn btn-sm  btn-circle btn-light" runat="server"><span class="fas fa-angle-left text-gray-600"></span></asp:LinkButton>

                            </li>
                            <li class="page-item active">

                                <asp:LinkButton ID="btnNext" OnClick="btnNext_Click" data-toggle="tooltip" title="Next" class="btn btn-sm  btn-circle mx-2 btn-light" runat="server"><span class="fas fa-angle-right text-white text-gray-600"></span></asp:LinkButton>

                            </li>

                        </ul>
                    </nav>
                </div>

            </div>
        </div>
        <div class="modal fade " id="createNewCategoryModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>
                            New Category
                            <button class="btn btn-circle btn-sm ml-2" type="button" data-toggle="modal" data-target="#CategoryTableModal"><span class="fas fa-cog " style="color: #d46fe8"></span></button>
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12">
                                <asp:TextBox ID="txtItemCategory" runat="server" class="form-control form-control-sm" placeholder="Category"></asp:TextBox>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnSaveCategory" class="btn btn-sm btn-danger" runat="server" OnClick="btnSaveCategory_Click"><span class="fas fa-save text-white mr-2"></span>Save</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade " id="adjustItemsModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>
                            Adjust Item Quantity
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12">
                                <asp:TextBox ID="txtQuantityAdjusted" runat="server" class="form-control form-control-sm" placeholder="eg. 5 or -5"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlAdjustmentReason" class="form-control form-control-sm" runat="server">
                                    <asp:ListItem>Stock on Fire</asp:ListItem>
                                    <asp:ListItem>Stolen Goods</asp:ListItem>
                                    <asp:ListItem>Damaged Goods</asp:ListItem>
                                    <asp:ListItem>Stock Written Off</asp:ListItem>
                                    <asp:ListItem>Stocktaking Result</asp:ListItem>
                                    <asp:ListItem>Inventory Revaluation</asp:ListItem>

                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnAdjustItems" class="btn btn-sm btn-danger" runat="server" OnClick="btnAdjustItems_Click"><span class="fas fa-adjust text-white mr-2"></span>Adjust</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="modal fade " id="createNewWarehouseModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>
                            New Warehouse
                            <button class="btn btn-circle btn-sm ml-2" type="button" data-toggle="modal" data-target="#WarehouseTableModal"><span class="fas fa-cog " style="color: #d46fe8"></span></button>
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-6">
                                <asp:TextBox ID="txtWarehouseName" runat="server" class="form-control form-control-sm" placeholder="Warehouse name"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtAddress" runat="server" class="form-control form-control-sm" placeholder="Warehouse address"></asp:TextBox>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnSaveWarehouse" class="btn btn-sm btn-danger" runat="server" OnClick="btnSaveWarehouse_Click"><span class="fas fa-save text-white mr-2"></span>Save</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="createNewIteModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>Creater New Item</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtItemName" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Item Name" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtItemCode" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Item Code" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6 ">
                                <asp:DropDownList ID="ddlCategory" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Item Category" class="form-control form-control-sm" runat="server"></asp:DropDownList>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtShelfNumber" ClientIDMode="Static" placeholder="Shelf Number" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>

                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12 ">
                                <asp:DropDownList ID="ddlWarehouse" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Item Category" class="form-control form-control-sm" data-toggle="tooltip" title="Select Warehouse" runat="server"></asp:DropDownList>
                            </div>

                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtPurchasePrice" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Purchase Price" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtSalesPrice" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Sales Price" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtUnit" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Unit" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtSKU" ClientIDMode="Static" placeholder="SKU" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>

                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12 ">

                                <asp:TextBox ID="txtDescriptionDetail" ClientIDMode="Static" TextMode="MultiLine" placeholder="Item Detail Description" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtBarcode" ClientIDMode="Static" placeholder="Item barcode" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtManufacturer" ClientIDMode="Static" placeholder="Manufacturer" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 ">

                                <asp:TextBox ID="txtReoderPoint" ClientIDMode="Static" placeholder="Reorder Point" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-4 ">

                                <asp:TextBox ID="txtOpening" ClientIDMode="Static" placeholder="Opening" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-4 ">

                                <asp:TextBox ID="txtTax" ClientIDMode="Static" Style="border-color: #ff6a00" placeholder="Tax Rate[%]" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>


                        <div class="modal-footer">
                            <asp:LinkButton ID="btnCreateItem" class="btn btn-sm btn-danger" runat="server" OnClick="btnCreateItem_Click"><span class="fas fa-save text-white mr-2"></span>Save</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade " id="DeleteItemModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-trash mr-2" style="color: #ff00bb"></span>
                            Delete Item
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12 mx-2 border-danger border-left">
                                <span class="fas fa-arrow-alt-circle-right text-danger mr-2"></span>
                                <span class="small text-gray-500">Are You Sure to Delete the Item?</span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDeleteItems" runat="server" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnDeleteItems_Click" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade " id="CategoryTableModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="fas fa-cog mr-2" style="color: #d46fe8"></span>Manage Category</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12">
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="WarehouseTableModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="fas fa-cog mr-2" style="color: #d46fe8"></span>Manage Warehouse</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12">
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
