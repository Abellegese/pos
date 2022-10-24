<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="salesorder.aspx.cs" Inherits="pos.app.salesorder" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Sales Order</title>
    <script language="javascript">
        function printdiv(printpage) {
            document.getElementById("colTen").className = "col-10";
            var headstr = "<html><head><title></title></head><body>";
            var footstr = "</body>";
            var newstr = document.all.item(printpage).innerHTML;
            var oldstr = document.body.innerHTML;
            document.body.innerHTML = headstr + newstr + footstr;
            window.print();
            document.body.innerHTML = oldstr;
            document.getElementById("colTen").className = "col-10 shadow-sm";

            return false;
        }

    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            //We are binding onchange event using jQuery built-in change event
            $('#ddlItemName').change(function () {
                GetItemRate();
                GetStockInf();
                ShowItemIStock();
            });
            function ShowItemIStock() {
                if ($("#ddlItemName option:selected").text() == "-Select Item-")
                    $("#itemInfoDiv").toggle(false);
                else
                    $("#itemInfoDiv").toggle(true);
            }
            function GetItemRate() {
                PageMethods.GetItemRate($("#ddlItemName option:selected").text(), Success);
            }
            function Success(result) {
                $("#txtUnitPrice").val(result[0]);
                document.getElementById("taxSpan").innerHTML = "Tax [" + result[1] + "%" + "]";
                document.getElementById("unitSpan").innerHTML = result[2];

            }

            function GetStockInf() {
                PageMethods.GetItemBalance($("#ddlItemName option:selected").text(), Success1);
            }
            function Success1(result) {
                document.getElementById("balanceSpan").innerHTML = "stock on hand [" + result + " " + document.getElementById("unitSpan").innerHTML + " ]";
            }
        });
    </script>
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
                                <span class="fas fa-cart-plus mr-2" style="color: #d46fe8" id="salesIconSpan" runat="server"></span><span id="salesSpan" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">Sales Order</span>

                            </div>
                            <div class="col-md-8 text-right">
                                <div class="dropdown no-arrow">
                                    <span class="badge text-white" style="background-color: #d46fe8" visible="false" id="selectSpan" runat="server">ITEM#<span id="itemNumber" runat="server"></span> SELECTED</span>
                                    <button type="button" runat="server" id="btnEditLine" visible="false" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#EditLineModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Edit Line Item" class="fas fa-pencil-alt text-gray-600 font-weight-bold"></i>
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
                                    <button name="b_print" onclick="printdiv('div_print');" class="mr-1 btn btn-light btn-sm">
                                        <div>
                                            <i class="fas fa-print text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <div class="vr">
                                    </div>


                                    <button type="button" runat="server" id="Sp2" class="mr-1 btn btn-sm btn-circle" style="background-color: #d46fe8" data-toggle="modal" data-target="#ModalCreateSalesOrder">
                                        <div>
                                            <i data-toggle="tooltip" title="Create Sales Order" class="fas fa-plus text-white font-weight-bold"></i>
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
                    <div class="card-body small text-gray-900" id="SorderDiv" style="margin-top: -21px" runat="server">
                        <asp:Repeater ID="rptrSalesOrder" runat="server">

                            <HeaderTemplate>
                                <table class="table align-items-center table-hover table-sm ">
                                    <thead>
                                        <tr>

                                            <th scope="col" class="text-gray-900 text-uppercase text-left">Date</th>
                                            <th scope="col" class="text-warning text-uppercase ">Sales Order#</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Customer </th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Invoiced</th>
                                            <th scope="col" class="text-gray-900 text-uppercase  text-right">Shipment</th>  
                                            <th scope="col" class="text-gray-900 text-uppercase ">Amount</th>



                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr>

                                    <td class="text-gray-900 text-left">
                                        <%# Eval("date")%>
                                    </td>
                                    <td class="text-primary">
                                        <a class=" text-warning  " href="salesorder.aspx?sono=<%# Eval("order_number")%>"><span>SO-00000<%# Eval("order_number")%></span></a>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="lblCustomer" runat="server" Text='<%# Eval("customer_name")%>'></asp:Label>
                                    </td>

                                    <td class="text-gray-900">
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("invoice_status")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("shipment_status")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900 text-right">
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("amount")%>'></asp:Label>

                                    </td>

                                </tr>

                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                  </table>
                            </FooterTemplate>

                        </asp:Repeater>
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
                    <div class="card-body text-gray-900" visible="false" id="SODetailDiv" runat="server">
                        <div class="row">
                            <div class="col-4 border-right" style="margin-top: -21px">
                                <asp:Repeater ID="rptSOShort" runat="server">

                                    <HeaderTemplate>
                                        <table class="table align-items-center table-hover table-sm ">

                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="border-bottom">

                                            <td>
                                                <asp:Label ID="Label3" class="text-gray-900" runat="server" Text='<%# Eval("customer_name")%>'></asp:Label>
                                                <a class=" text-primary  " href="salesorder.aspx?sono=<%# Eval("order_number")%>"><span>SO#-00000<%# Eval("order_number")%></span></a>
                                                <h6>| <span class=" text-gray-600"><%# Eval("date")%></span> </h6>
                                            </td>

                                            <td class="text-gray-900 text-right">
                                                <h6><span class="small text-gray-400 font-weight-bold text-uppercase">Due</h6>
                                                <asp:Label ID="Label6" runat="server" class="badge badge-warning" Text='<%# Eval("amount" , "{0:N2}")%>'></asp:Label>
                                                <asp:Label ID="Label8" runat="server" class="badge badge-warning" Text='<%# Eval("invoice_status")%>'></asp:Label>

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
                                                <div class="row">
                                                    <div class="col-md-6  text-left" style="color: black">
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <span class="text-uppercase mb-2 h6 font-weight-bold" id="companyNameSpan" runat="server"></span>
                                                                <br />
                                                                <div id="Body1" runat="server">
                                                                    <span class=" text-gray-900 small  mt-1" id="countrySpan" runat="server"></span>
                                                                    <br />
                                               
                                                                    <span class="small" style="height: 100px; color: black" contenteditable="true">To: </span><span style="height: 100px; color: black" contenteditable="true" class=" text-primary small" id="Name" runat="server"></span>
                                                                    <br />
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-1  ">
                                                            <div class="col-md-12 text-left">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6 text-right">

                                                        <span style="color: black" contenteditable="true" class="h3 text-uppercase font-weight-bold " id="HeaderInv" runat="server">SALES ORDER</span>
                                                        <br />
                                                        <span id="invocenumber" class="h6 text-gray-800 mt-2" runat="server">Sales Order# SO-<span id="salesOrderNumberSpan" runat="server"></span></span>
                                                        <div id="Body2" runat="server">

                                                            <span title="order date" style="color: black" id="dateOfOrder" class="small" runat="server"></span>

                                                            <br />
                                                            <br />
                                                            <br />

                                                            <br />
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="conw" runat="server" style="color: black">
                                                    <asp:Repeater ID="rptrSODetails" runat="server">

                                                        <HeaderTemplate>

                                                            <table class="table align-items-center table-bordered table-sm " style="color: black;">
                                                                <thead class="thead-dark ">
                                                                    <tr>
                                                                        <th scope="col" class="small">#</th>

                                                                        <th scope="col" class="small" >Item & Description</th>
                                                                        <th scope="col" class="small text-center">Quantity</th>
                                                                        <th scope="col" class="small text-center">Unit Price</th>


                                                                        <th scope="col" class="small text-right">Total Price</th>

                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="text-left" >
                                                                    <a class="  " href="sales.aspx?sono_d=<%# Eval("id")%>&&edit=true"><span><%# Eval("id")%></span></a>
                                                                </td>
                                                                <td class="text-left" >
                                                                    <span><%# Eval("item_name")%></span><br />
                                                                    <span class="small text-gray-600"><%# Eval("description")%></span>

                                                                </td>

                                                                <td  class="text-center" contenteditable="true">
                                                                    <span><%# Convert.ToDouble(Eval("quantity")).ToString("#,##0.00")%></span>
                                                                </td>

                                                                <td  class=" text-center" contenteditable="true">
                                                                    <span><%# Convert.ToDouble(Eval("unit_price")).ToString("#,##0.00")%></span>

                                                                </td>

                                                                <td  class="text-right" contenteditable="true">
                                                                    <span><%# Convert.ToDouble(Eval("total_amount")).ToString("#,##0.00")%></span>

                                                                </td>
                                                            </tr>

                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                   </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                    <center>

                                                    </center>
                                                    <div class="row" id="TotalRow" runat="server">

                                                        <div class="col-md-8 text-left" style="z-index: 2">

                                                            <div class="row">
                                                                <div class="col-md-12 text-left">
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="col-md-4 mt-1" style="z-index: 2; color: black">
                                                            <div class="form-group">
                                                                <table class="table table-sm  table-bordered" style="color: black">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td ><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">Sub-Total:</span></td>
                                                                            <td  class="text-right"><span id="subTotal" class=" font-weight-bold " runat="server"></span></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td ><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">VAT(15%):</span></td>
                                                                            <td  class="text-right"><span id="vatAmount" class=" font-weight-bold" runat="server"></span></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td ><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">Grand Total:</span></td>
                                                                            <td  class="text-right"><span id="Total" class="font-weight-bold" runat="server"></span></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>

                                                            </div>

                                                        </div>

                                                    </div>
                                                </div>

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

                            <main role="main" id="main" class="mt-2 pl-5 pr-5 mb-5" runat="server" visible="false">

                                <div class="starter-template">
                                    <center>

                                        <h3 class="text-gray-900 mb-2 font-weight-bold">Create New Sales Order</h3>

                                        <h6 class="text-gray-500 mb-3">By creating sales order for the customer you can easily track customer order and convert customer order to invoice [sales attachment] with one click!</h6>
                                        <button type="button" data-toggle="modal" data-target="#ModalCreateSalesOrder" class="btn btn-danger text-white"><span class="fas fa-plus mr-2 text-white"></span>Create New Sales Order</button>
                                    </center>
                                </div>



                            </main>
                        </center>
                    </div>
                </div>
                <div class="modal fade" data-backdrop="static" id="ModalCreateSalesOrder" tabindex="-1" role="dialog" aria-labelledby="ModalAnalysis" aria-hidden="true">
                    <div class="modal-dialog  modal-lg" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h6 class="modal-title font-weight-bold text-gray-900" id="exampleModalLabelG"><span class="fas fa-cart-plus mr-2" style="color: #c24599"></span>
                                    Create Sales Order [SO-00000<span id="orderSpan" runat="server"></span>]
                            
                            <button class="btn btn-circle btn-sm ml-2" type="button" data-toggle="modal" data-target="#ExistingCustomerModal"><span class="fas fa-user-check " data-toggle="tooltip" title="Select existing customer" style="color: #d46fe8"></span></button>
                                </h6>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3">
                                    <div class="col-md-4">

                                        <asp:TextBox ID="txtCustomerName" ClientIDMode="Static" placeholder="Customer Name" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-md-4 ">

                                        <div class="form-group mb-0">
                                            <asp:TextBox ID="txtTINNumber" ClientIDMode="Static" placeholder="TIN Number" class="form-control form-control-sm " runat="server"></asp:TextBox>

                                        </div>
                                    </div>

                                </div>
                                <div class="row mb-3">
                                    <div class="col-md-8 ">
                                        <asp:TextBox ID="txtAddress" ClientIDMode="Static" class="form-control form-control-sm" placeholder="Address" runat="server"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-8">
                                        <asp:TextBox ID="txtDate" TextMode="Date" data-toggle="tooltip" ClientIDMode="Static" title="Date of Sales Order" Style="border-color: #ff00bb" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                  
                                <div class="mt-2 mb-2 border-top"></div>
                                <div class="row">
                                    <div class="col-12">
                                        <div id="itemInfoDiv" style="display: none">
                                            <button class="btn btn-light btn-sm" type="button" data-toggle="tooltip" onclick="AddTable();CreateSalesOrderClient();" title="Add item"><span class="fas fa-plus"></span></button>

                                            <div class="vr"></div>
                                            <span class="fas fa-cart-arrow-down text-gray-500 mr-2"></span>
                                            <span class="text-gray-600 small " id="balanceSpan"></span>
                                            <span class="text-gray-600 small " id="unitSpan"></span>
                                            <div class="vr"></div>
                                            <span class="text-gray-600 small " id="taxSpan"></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-2 mb-2 border-top"></div>
                                <div class="row  ">
                                    <div class="col-md-4 ">
                                        <asp:DropDownList ID="ddlItemName" data-toggle="tooltip" title="Item Name" data-placement="bottom" ClientIDMode="Static" Style="border-color: #ff00bb" class="form-control form-control-sm " runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="col-md-2 " id="descriptionDiv" runat="server">

                                        <asp:TextBox ID="txtDescription" ClientIDMode="Static" placeholder="Description" data-toggle="tooltip" title="Description" Style="border-color: #ff00bb" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-md-1 ">
                                        <div class="form-group mb-0">
                                            <div class="input-group input-group-alternative input-group-sm">
                                                <div class="input-group-prepend ">
                                                    <asp:TextBox ID="txtQuantity" Value="1" ClientIDMode="Static" data-toggle="tooltip" title="Quantity" Style="border-color: #ff00bb" class="form-control form-control-sm " placeholder="Quantity" runat="server"></asp:TextBox>
                                                </div>

                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-md-2 " id="rateDiv" runat="server">
                                        <asp:TextBox ID="txtUnitPrice" ClientIDMode="Static" Style="border-color: #ff00bb" data-toggle="tooltip" title="Rate" class="form-control form-control-sm" placeholder="Rate" runat="server"></asp:TextBox>
                                    </div>
           
                                </div>
                                <div class="mt-2 mb-2 border-top"></div>
                                <div class="row small">
                                    <div class="col-12">
                                        <table id="myTable" class="table table-sm table-bordered table-hover text-gray-900">
                                        </table>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-8">
                                    </div>
                                    <div class="col-4 small">
                                        <div class="form-group">
                                            <table class="table  table-sm table-bordered">
                                                <tbody>
                                                    <tr>
                                                        <td><span class="m-0 font-weight-bold text-right text-gray-900">Sub-Total:</span></td>
                                                        <td class="text-right"><span id="VatFree" class="text-gray-900 font-weight-bold text-gray-900" runat="server"></span></td>
                                                    </tr>
                                                    <tr>
                                                        <td><span class="m-0 font-weight-bold text-right text-gray-900 ">VAT(15%):</span></td>
                                                        <td class="text-right"><span id="VAT" class="text-gray-900 font-weight-bold text-gray-900" runat="server"></span></td>
                                                    </tr>
                                                    <tr>
                                                        <td><span class="m-0 font-weight-bold text-right text-gray-900 ">Grand Total:</span></td>
                                                        <td class="text-right"><span id="GrandTotal" class="text-gray-900 font-weight-bold text-gray-900" runat="server"></span></td>
                                                        <asp:TextBox ID="txtTotalDiscount" ClientIDMode="Static" Style="display: none" runat="server"></asp:TextBox>
                                                        <asp:TextBox ID="txtVatFree" ClientIDMode="Static" Style="display: none" runat="server"></asp:TextBox>
                                                        <asp:TextBox ID="txtGrandTotal" ClientIDMode="Static" Style="display: none" runat="server"></asp:TextBox>
                                                    </tr>
                                                </tbody>
                                            </table>

                                        </div>
                                    </div>
                                </div>

                            </div>

                            <div class="modal-footer">

                                <asp:LinkButton ID="btnCreateSalesOrder" runat="server" class="btn btn-sm text-white" Style="background-color: #d46fe8" CausesValidation="false" OnClick="btnCreateSalesOrder_Click"><span class="fas fa-plus mr-2"></span>Create Order</asp:LinkButton>

                            </div>

                        </div>
                    </div>
                </div>
                <div class="modal fade " id="ExistingCustomerModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-sm" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>
                                    Select Customer
                                </h5>
                                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">×</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <div class="row mb-3">
                                    <div class="col-12">
                                        <asp:DropDownList ID="ddlExistingCustomer" ClientIDMode="Static" class="form-control form-control-sm" runat="server"></asp:DropDownList>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-sm text-white" style="background-color: #d46fe8" onclick="bindCustomer();"><span class="fas fa-plus mr-2"></span>Bind</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
    <script type="text/javascript">

        $(document).ready(function () {
            var table = document.getElementById("myTable");
            var header = table.insertRow(0);
            header.className = "thead-dark";
            var header1 = header.insertCell(0);
            var header2 = header.insertCell(1);
            var header3 = header.insertCell(2);
            var header4 = header.insertCell(3);
            header1.innerHTML = "Item & Description";
            header2.innerHTML = "Quantity";
            header3.innerHTML = "Rate";
            header4.innerHTML = "Amount";
            header1.className = "font-weight-bold bg-light text-uppercase";
            header2.className = "font-weight-bold bg-light text-uppercase";
            header3.className = "font-weight-bold bg-light text-uppercase";
            header4.className = "text-right bg-light font-weight-bold text-uppercase";
        });
    </script>
    <script type="text/javascript">

        function GetTax() {
            PageMethods.GetItemRate($("#ddlItemName option:selected").text(), Success2);
        }
        function Success2(result) {
            var unitPrice = Number($("[id*=txtUnitPrice]").val());
            var quantity = $("[id*=txtQuantity]").val();
            var totalPrice = unitPrice * quantity;
            var Vatfree1 = document.getElementById("<%=VatFree.ClientID %>");
                var Vat = document.getElementById("<%=VAT.ClientID %>");
                var tot = document.getElementById("<%=GrandTotal.ClientID %>");
            Vatfree1.innerHTML = (Number(Vatfree1.innerHTML) + totalPrice).toFixed(2);
            Vat.innerHTML = (Number(Vat.innerHTML) + (Number(result[1]) / 100) * totalPrice).toFixed(2);

            tot.innerHTML = (Number(tot.innerHTML) + totalPrice + totalPrice * (Number(result[1]) / 100)).toFixed(2);
            $("[id*=txtGrandTotal]").val(Number($("[id*=txtGrandTotal]").val()) + totalPrice + totalPrice * (Number(result[1]) / 100));
            $("[id*=txtVatFree]").val(Number($("[id*=txtVatFree]").val()) + totalPrice);

        }
        function AddTable() {
            var table = document.getElementById("myTable");
            var row = table.insertRow(1);
            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);
            // Add some text to the new cells:
            cell1.innerHTML = $("#ddlItemName option:selected").text() + "<br/>" + $("[id*=txtDescription]").val();
            cell2.innerHTML = $("[id*=txtQuantity]").val();

            var unitPrice = Number($("[id*=txtUnitPrice]").val());
            var quantity = $("[id*=txtQuantity]").val();
            var totalPrice = unitPrice * quantity;
            cell3.innerHTML = unitPrice;
            cell4.innerHTML = totalPrice;
            cell4.className = "text-right";
            GetTax();
        }
    </script>
    <script type="text/javascript">
        function CreateSalesOrderClient() {
            PageMethods.CreateSalesOrder($("[id*=txtCustomerName]").val(), $("#ddlItemName option:selected").text(), $("[id*=txtDate]").val(),
                $("[id*=txtUnitPrice]").val(), $("[id*=txtDescription]").val(), $("[id*=txtQuantity]").val(), (Number($("[id*=txtUnitPrice]").val())) * Number($("[id*=txtQuantity]").val()),
                document.getElementById("<%=orderSpan.ClientID %>").innerHTML, SuccessOrderInsertion, ErrorOrderInsertion);
        }
        function SuccessOrderInsertion(result) {
            alert(result);
        }
        function ErrorOrderInsertion(error) {
            alert(error);
        }
    </script>
    <script type="text/javascript">
        function bindCustomer() {
            PageMethods.GetCustomerInfo($("#ddlExistingCustomer option:selected").text(), Success, Failure);

        }
        function Success(result) {
            $("[id*=txtTINNumber]").val(result[0]);
            $("[id*=txtAddress]").val(result[1]);
            $("[id*=txtCustomerName]").val($("#ddlExistingCustomer option:selected").text());
            $('#ExistingCustomerModal').modal('hide');
            $('#ModalCreateSalesOrder').modal('show');
        }
        function Failure(error) {
            alert(error);
        }
    </script>

</asp:Content>
