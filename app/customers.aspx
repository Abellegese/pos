<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="customers.aspx.cs" Inherits="pos.app.customers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Customers</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid pl-3 pr-3" style="position: absolute;" id="container" runat="server">

        <asp:ScriptManager ID='ScriptManager1' runat='server' EnablePageMethods='true' />
        <div class="row">
            <div class="col">

                <div class="bg-white rounded-lg h-100">
                    <div class="card-header bg-white ">
                        <div class="row">
                            <div
                                class="col-md-4 text-left">
                                <a class="btn btn-circle btn-sm text-white btn-light mr-2" id="buttonback" href="sales.aspx" visible="false" runat="server" data-toggle="tooltip" data-placement="bottom" title="Back to Invoice">

                                    <span class="fa fa-arrow-left text-gray-600"></span>

                                </a>
                                <span class="badge mr-2 text-white badge-light text-gray-600 font-weight-bold" visible="false" id="invoiceDetailSpan" runat="server"></span>
                                <span class="fas fa-user mr-2" style="color: #d46fe8" id="salesIconSpan" runat="server"></span><span id="salesSpan" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">Customers</span>

                            </div>
                            <div class="col-md-8 text-right">
                                <div class="dropdown no-arrow">
                                    <span class="badge text-white" style="background-color: #d46fe8" visible="false" id="selectSpan" runat="server">ITEM#<span id="itemNumber" runat="server"></span> SELECTED</span>
                                    <button type="button" runat="server" id="btnEditLine" visible="false" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#EditLineModal">
                                        <div>
                                            Edit
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnCustomize" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#CustomizeInvoiceModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Customize Template" class="fas fa-cog text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnSendEmail" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#ModalCreateInvoice">
                                        <div>
                                            <i data-toggle="tooltip" title="Send Email" class="fas fa-envelope text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnDelete" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#DeletInvoiceModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Delete Invoice" class="fas fa-trash text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnDuplicate" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#ModalCreateInvoice">
                                        <div>
                                            <i data-toggle="tooltip" title="Duplicate" class="fas fa-copy text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnEdit" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#EditInvoiceModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Edit Info" class="fas fa-edit text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" runat="server" id="Sp2" class="mr-1 btn btn-sm btn-circle" style="background-color: #d46fe8" data-toggle="modal" data-target="#createNewCustomerModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Create Customer" class="fas fa-plus text-white font-weight-bold"></i>
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
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#DiscountModal" id="A2" runat="server"><span class="fas fa-cog mr-2 " style="color: #d46fe8"></span>Manage Discount</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#createNewBankModal" id="LR" runat="server"><span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Bank Account</a>

                                        <a href="#" class="dropdown-item border-top  text-gray-900  text-danger" data-toggle="modal" visible="false" data-target="#CreditModal" id="creditLink" runat="server"><span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Credit</a>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                    <div class="card-body small text-gray-900" id="InvoiceDiv" style="margin-top: -21px" runat="server">
                        <asp:Repeater ID="rptrCustomer" runat="server">

                            <HeaderTemplate>
                                <table class="table align-items-center table-hover table-sm ">
                                    <thead>
                                        <tr>

                                            <th scope="col" class="text-gray-900 text-uppercase text-left">Name</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Company Name</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Email </th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Work Phone</th>
                                            <th scope="col" class="text-gray-900 text-uppercase text-right">Receivable</th>



                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>

                                    <td class="text-primary">
                                        <a class=" text-primary  " href="sales.aspx?customer=<%# Eval("customer_name")%>&&cust_id=<%# Eval("id")%>"><span><%# Eval("customer_name")%></span></a>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="lblCustomer" runat="server" Text='<%# Eval("company_name")%>'></asp:Label>
                                    </td>

                                    <td class="text-gray-900">
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("email")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("phone")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900 text-right">
                                        <span class="badge badge-success">ETB3.5</span>
                                    </td>

                                </tr>

                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                  </table>
                            </FooterTemplate>

                        </asp:Repeater>
                    </div>
                    <div class="card-body text-gray-900" visible="false" id="invoiceDetailDiv" runat="server">
                        <div class="row">
                            <div class="col-4 border-right" style="margin-top: -21px">
                                <asp:Repeater ID="rptInvoiceShort" runat="server">

                                    <HeaderTemplate>
                                        <table class="table align-items-center table-hover table-sm ">

                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="border-bottom">

                                            <td>
                                                <asp:Label ID="Label3" class="text-gray-900" runat="server" Text='<%# Eval("customer_name")%>'></asp:Label>
                                                <a class=" text-primary  " href="sales.aspx?invno=<%# Eval("invoice_number")%>&&fsno=<%# Eval("fsno")%>&&customer=<%# Eval("customer_name")%>"><span>INV#-00000<%# Eval("invoice_number")%></span></a>
                                                <h6>| <span class=" text-gray-600"><%# Eval("date")%></span> </h6>
                                            </td>

                                            <td class="text-gray-900 text-right">
                                                <h6><span class="small text-gray-400 font-weight-bold text-uppercase">Due</h6>
                                                <asp:Label ID="Label8" runat="server" class="badge badge-warning" Text='<%# Eval("balance" , "{0:N2}")%>'></asp:Label>

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
                                    <div class="row" style="margin-left: -60px; margin-right: -60px">
                                        <div class="col-1">
                                        </div>
                                        <div id="colTen" class="col-10 shadow-sm">
                                            <div class="card-body border-none">
          

                                            </div>
                                        </div>
                                        <div class="col-1">
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="card-body">
                        <center>

                            <main role="main" id="mainb" class="mt-2 mb-5" runat="server" visible="false">

                                <div class="starter-template">
                                    <center>

                                        <h3 class="text-gray-900 mb-2 font-weight-bold">Create New Sales</h3>

                                        <h5 class="text-gray-500 mb-3">Start your business by creating sales</h5>
                                        <button type="button" data-toggle="modal" data-target="#ModalCreateInvoice" class="btn btn-danger text-white"><span class="fas fa-plus mr-2 text-white"></span>Create New Invoice</button>
                                    </center>
                                </div>



                            </main>
                        </center>
                    </div>


                </div>


            </div>
        </div>
        <div class="modal fade " id="createNewCustomerModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>Creater New Customer</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtBusinessType" ClientIDMode="Static"  placeholder="Business Type" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtCustomerName" ClientIDMode="Static"  placeholder="Customer Name" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-12 ">

                                <asp:TextBox ID="txtCompanyName" ClientIDMode="Static" placeholder="Company Name" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>

                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtEmail" ClientIDMode="Static"  placeholder="Email" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtPhone" ClientIDMode="Static"  placeholder="Phone" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtWebsite" ClientIDMode="Static"  placeholder="Website" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtCreditLimit" ClientIDMode="Static" placeholder="Credit Limit" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>

                        </div>
       
                        <div class="row mb-3">
                            <div class="col-md-12 ">

                                <asp:TextBox ID="txtAddress" ClientIDMode="Static" placeholder="Address" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtTinNumber" ClientIDMode="Static" placeholder="TIN#" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                            <div class="col-md-6 ">

                                <asp:TextBox ID="txtVatRegNumber" ClientIDMode="Static"  placeholder="Vat Reg. Number" class="form-control form-control-sm " runat="server"></asp:TextBox>
                            </div>
                        </div>


                        <div class="modal-footer">
                            <asp:LinkButton ID="btnCreateCustomer" class="btn btn-sm btn-danger" runat="server" OnClick="btnCreateCustomer_Click"><span class="fas fa-save text-white mr-2"></span>Save</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
