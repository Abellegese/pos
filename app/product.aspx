
<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="product.aspx.cs" Inherits="pos.app.product" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Product</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pl-3 pr-3" id="container" runat="server">
        <div class="row">
            <div class="col">

                <div class="bg-white rounded-lg">
                    <div class="card-header bg-white ">
                        <div class="row">
                            <div class="col-md-4 text-left">
                                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown1"
                                    role="button" data-toggle="dropdown" aria-haspopup="true"
                                    aria-expanded="false">
                                    <span class="fas fa-folder-plus mr-2" style="color: #d46fe8"></span><span id="cashdrop" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">ITEMS</span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-left animated--fade-in"
                                    aria-labelledby="navbarDropdown1">
                                </div>
                            </div>
                            <div class="col-md-8 text-right">
                                <div class="dropdown no-arrow">
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
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#ModalBody" id="LR1" runat="server"><span class="fas fa-edit mr-2 " style="color: #d46fe8"></span>Customize Body</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#ModalHeader" id="LR2" runat="server"><span class="fas fa-edit mr-2 " style="color: #d46fe8"></span>Customize Header and Footer</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#ModalAdjustReference" id="A3" runat="server"><span class="fas fa-hashtag mr-2 " style="color: #d46fe8"></span>Adjust Reference#</a>

                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#ModalReset" id="LR3" runat="server"><span class="fas fa-reply mr-2 " style="color: #d46fe8"></span>Reset Content</a>
                                        <hr />
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#ModalCreateSpecialLetter" id="LR4" runat="server"><span class="fas fa-file mr-2 " style="color: #d46fe8"></span>Create Special Letter</a>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                    <div id="salesTable" class="col-12" runat="server">
                        <div class="card-body small text-gray-900">
                            <asp:Repeater ID="Repeater1" runat="server">

                                <HeaderTemplate>
                                    <div class="table-responsive">
                                        <table class="table align-items-center table-sm ">
                                            <thead>
                                                <tr>

                                                    <th></th>
                                                    <th scope="col" class="text-gray-900">Date</th>
                                                    <th scope="col" class="text-gray-900">Credit# </th>
                                                    <th scope="col" class="text-gray-900">Customer </th>
                                                    <th scope="col" class="text-gray-900">Invoice Amount(VAT+) </th>
                                                    <th scope="col" class="text-gray-900">Credit Balance</th>
                                                    <th scope="col" class="text-gray-900">Ref#</th>
                                                    <th scope="col" class="text-gray-900">Due Date</th>
                                                    <th scope="col" class="text-gray-900">Status</th>



                                                </tr>
                                            </thead>
                                            <tbody>
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <tr>
                                        <td>
                                            <asp:Literal ID="LiteralDropdown" runat="server">


                                            </asp:Literal>


                                        </td>
                                        <td class="text-gray-900">
                                            <%# Eval("date", "{0: dd/MM/yyyy}")%>
                                        </td>
                                        <td class="text-primary">
                                            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                            <asp:Label ID="lblID" runat="server" Visible="false" Text='<%# Eval("id")%>'></asp:Label>
                                        </td>

                                        <td class="text-gray-900">
                                            <asp:Label ID="lblCustomer" runat="server" Text='<%# Eval("customer")%>'></asp:Label>
                                        </td>
                                        <td class="text-gray-900">
                                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("amount" , "{0:N2}")%>'></asp:Label>

                                        </td>
                                        <td class="text-gray-900">
                                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("balance" , "{0:N2}")%>'></asp:Label>

                                        </td>
                                        <td class="text-gray-900">
                                            <asp:Label ID="lblExp" runat="server" Text='<%# Eval("ref")%>'></asp:Label>
                                        </td>
                                        <td class="text-gray-900">
                                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("duedate","{0: MMMM dd, yyyy}")%>'></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="Label2" class="badge badge-danger" runat="server" Text="Pending"></asp:Label>
                                            <asp:Label ID="Label3" class="badge badge-success" runat="server" Text="Completed"></asp:Label>
                                            <asp:Label ID="Label_write_off" class="badge badge-warning" runat="server" Text="Writte Off"></asp:Label>
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
                                        <h6 class="text-gray-700 h6 font-italic">No Credit Found</h6>
                                    </center>
                                </div>



                            </main>
                        </center>
                    </div>

                </div>
                <div class="card-footer bg-white py-4" id="buttondiv" runat="server">
                    <nav aria-label="...">
                        <ul class="pagination justify-content-end mb-0">
                            <br />
                            <td>
                                <asp:Label ID="Label1" runat="server" class="m-1 text-primary"></asp:Label></td>
                            <br />
                            <li class="page-item active">

                                <asp:LinkButton ID="btnPrevious" class="btn btn-sm  btn-circle" Style="background-color: #d46fe8" runat="server"><span class="fas fa-angle-left text-white"></span></asp:LinkButton>

                            </li>
                            <li class="page-item active">

                                <asp:LinkButton ID="btnNext" class="btn btn-sm  btn-circle mx-2" Style="background-color: #d46fe8" runat="server"><span class="fas fa-angle-right text-white"></span></asp:LinkButton>

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
                            <button class="btn btn-circle btn-sm ml-2" type="button" data-toggle="modal" data-target="#CategoryTableModal"><span class="fas fa-cog " style="color:#d46fe8"></span></button></h5>
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

                                <asp:TextBox ID="txtShelfNumber" ClientIDMode="Static"  placeholder="Shelf Number" class="form-control form-control-sm " runat="server"></asp:TextBox>
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

                                <asp:TextBox ID="txtSKU" ClientIDMode="Static"  placeholder="SKU" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>

                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12 ">

                                <asp:TextBox ID="txtDescriptionDetail" ClientIDMode="Static"  TextMode="MultiLine" placeholder="Item Detail Description" class="form-control form-control-sm" runat="server"></asp:TextBox>
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

                                <asp:TextBox ID="txtReoderPoint" ClientIDMode="Static"  placeholder="Reorder Point" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-4 ">

                                <asp:TextBox ID="txtOpening" ClientIDMode="Static"  placeholder="Opening" class="form-control form-control-sm " runat="server"></asp:TextBox>
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
