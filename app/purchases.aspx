<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="purchases.aspx.cs" Inherits="pos.app.purchases" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Purchases</title>
    <script language="javascript">
        function printdiv(printpage) {

            var headstr = "<html><head><title></title></head><body>";
            var footstr = "</body>";
            var newstr = document.all.item(printpage).innerHTML;
            var oldstr = document.body.innerHTML;
            document.body.innerHTML = headstr + newstr + footstr;
            window.print();
            document.body.innerHTML = oldstr;

            return false;
        }

    </script>
    <link href="../asset/css/snackbar.css" rel="stylesheet" />

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
                                <a class="btn btn-circle btn-sm text-white btn-light mr-2" id="btnBack" href="purchases.aspx" visible="false" runat="server" data-toggle="tooltip" data-placement="bottom" title="Back to Invoice">

                                    <span class="fa fa-arrow-left text-gray-600"></span>

                                </a>
                                <span class="badge mr-2 text-white badge-light text-gray-600 font-weight-bold" visible="false" id="billNumberSpan" runat="server"></span>
                                <span class="fas fa-cart-plus mr-2" style="color: #d46fe8" id="billSpanIcon" runat="server"></span><span id="billText" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">Purchases</span>

                            </div>

                            <div class="col-md-8 text-right">
                                <div class="dropdown no-arrow">
                                    <span class="badge text-white" style="background-color: #d46fe8" visible="false" id="itemSelectionSpan" runat="server">ITEM#<span id="itemNumber" runat="server"></span> SELECTED</span>
                                    <button type="button" runat="server" id="btnEditLineItem" visible="false" class="mr-1 btn btn-outline-light btn-sm" data-toggle="modal" data-target="#EditLineModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Edit Line Item" class="fas fa-pencil-alt text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" runat="server" id="btnDeleteLineItemsModal" visible="false" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#DeleteLineItemModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Delete Line Item" class="fas fa-trash-restore text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnDeleteBills" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#DeletInvoiceModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Delete Bills" class="fas fa-trash text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>

                                    <button type="button" visible="false" runat="server" id="btnEditInfo" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#EditBillModal">
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


                                    <button type="button" runat="server" id="Button7" class="mr-1 btn btn-sm btn-circle" style="background-color: #d46fe8" data-toggle="modal" data-target="#ModalCreateBill">
                                        <div>
                                            <i data-toggle="tooltip" title="Create Invoice" class="fas fa-plus text-white font-weight-bold"></i>
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
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#DiscountModal" id="A3" runat="server"><span class="fas fa-cog mr-2 " style="color: #d46fe8"></span>Manage Discount</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#createNewBankModal" id="A4" runat="server"><span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Bank Account</a>

                                        <a href="#" class="dropdown-item border-top  text-gray-900  text-danger" data-toggle="modal" visible="false" data-target="#CreditModal" id="A5" runat="server"><span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Credit</a>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                    <div class="card-body small text-gray-900" id="BillDiv" style="margin-top: -21px" runat="server">
                        <asp:Repeater ID="rptrBill" runat="server" OnItemDataBound="rptrBill_ItemDataBound">

                            <HeaderTemplate>
                                <table class="table align-items-center table-hover table-sm ">
                                    <thead>
                                        <tr>

                                            <th scope="col" class="text-gray-900 text-uppercase text-left">Date</th>
                                            <th scope="col" class="text-warning text-uppercase ">Bill#</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Vendor </th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Amount</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Balance</th>
                                            <th scope="col" class="text-gray-900 text-uppercase  text-right">Status</th>



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
                                        <a class=" text-warning  " href="purchases.aspx?billno=<%# Eval("bill_no")%>&&fsno=<%# Eval("fsno")%>&&vendor=<%# Eval("vendor_name")%>"><span>INV#-00000<%# Eval("bill_no")%></span></a>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="lblCustomer" runat="server" Text='<%# Eval("vendor_name")%>'></asp:Label>
                                    </td>

                                    <td class="text-gray-900">
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("total_amount" , "{0:N2}")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="lblBalance" runat="server" Text='<%# Eval("balance")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900 text-right">
                                        <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("balance" , "{0:N2}")%>'></asp:Label>

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
                    <div class="card-body text-gray-900" visible="false" id="BillDetailDiv" runat="server">
                        <div class="row">
                            <div class="col-4 border-right" style="margin-top: -21px;height: 1000px;">
                                <asp:Repeater ID="rptBillShort" runat="server">

                                    <HeaderTemplate>
                                        <table class="table align-items-center table-hover table-sm ">

                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="border-bottom">

                                            <td>
                                                <asp:Label ID="Label3" class="text-gray-900 small" runat="server" Text='<%# Eval("vendor_name")%>'></asp:Label>
                                                <br />
                                                <a class=" text-primary  small" href="purchases.aspx?billno=<%# Eval("bill_no")%>&&vendor=<%# Eval("vendor_name")%>"><span>Bill#-00000<%# Eval("bill_no")%></span></a>
                                                | <span class=" text-gray-600 small"><%# Eval("date", "{0: dd/MM/yyyy}")%></span>
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
                            <div class="col-8" style="max-height: 1200px; overflow-y: scroll; overflow-x: hidden">
                                <div id="div_print">
                                    <div class="row" style="margin-left: -60px; margin-right: -60px">
                                        <div class="col-1">
                                        </div>
                                        <div class="col-10  shadow-sm " style="height: 1000px;">
                                            <div class="card-body border-none">
                                                <div class="row mt-5">
                                                    <div class="col-md-6  text-left" style="color: black">
                                                        <asp:Repeater ID="rptrLogo" runat="server">
                                                            <ItemTemplate>
                                                                <img class="" src='<%# Eval("logo")%>' height="80" width="80" alt="" id="LogoImage" runat="server" />
                                                            </ItemTemplate>

                                                        </asp:Repeater>
                                                        <div class="row">
                                                            <div class="col-md-12">
                                                                <span class="text-uppercase mb-2 h3 font-weight-bold border-bottom border-dark border-top" id="companyNameSpan" runat="server"></span>
                                                                <br />
                                                                <div id="Body1" runat="server">
                                                                    <span style="color: black" class="fas fa-address-book mb-2  mr-1"></span><span class="  text-uppercase  font-weight-bold  mt-1" id="CompAddress" runat="server"></span>
                                                                    <br />
                                                                    <span style="color: black" class="fas fa-address-book mb-2  mr-1"></span><span class="  text-uppercase   font-weight-bold mt-1" id="Contact" runat="server"></span>
                                                                    <br />
                                                                    <span style="color: black" class="border-top border-bottom border-dark font-weight-bold" id="RefTag" runat="server"></span>

                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="row mt-1  ">
                                                            <div class="col-md-12 text-left">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-6 text-right">

                                                        <span style="color: black" contenteditable="true" class="h2 mb-3 text-uppercase border-bottom border-dark font-weight-bold" id="HeaderBill" runat="server">Bill</span>
                                                        <br />
                                                        <br />
                                                        <br />
                                                        <div id="Body2" runat="server">
                                                            <span id="BindShop" runat="server">
                                                                <span style="height: 100px; color: black" contenteditable="true">From: </span><span style="height: 100px; color: black" contenteditable="true" class=" font-weight-bold text-uppercase" id="Name" runat="server"></span>
                                                                <span style="height: 100px; color: black" contenteditable="true" class=" font-weight-bold font-italic" id="CustomerCompany" runat="server"></span>
                                                                <br />
                                                                <span style="color: black" width="200px">TIN<span class="fas fa-hashtag  ml-1"></span><span id="TINNUMBER" width="200px" contenteditable="true" runat="server" class="ml-1"></span></span>
                                                                <br />
                                                                <span id="VendVatRegNumberSpan" style="color: black" contenteditable="true" runat="server" width="200px">Vat Reg. Number<span class="fas fa-hashtag ml-1"></span><span id="CustVatRegNumber" width="200px" contenteditable="true" runat="server" class="ml-1"></span></span>

                                                            </span>
                                                            <br />
                                                            <span id="Addressbar" class="border-bottom border-dark" style="color: black" runat="server">ADDRESS: <span id="Address" class="  text-uppercase" contenteditable="true" runat="server"></span></span>
                                                            <h6 class=""><span class="text-uppercase font-weight-bold " style="color: black" id="BillNoBinding" runat="server">BILL#</span></h6>
                                                            <h6><span class="text-uppercase  font-weight-bold " id="FSno" style="color: black" contenteditable="true" runat="server">FS#</span></h6>
                                                            <h6 id="dateDiv" runat="server"><span class="text-uppercase text-gray-900 font-weight-bold mr-1" id="Span6" runat="server">Date:</span><span id="dateSpan" style="color: black" runat="server"></span></h6>
                                                            <span id="PayMode" visible="true" style="color: black" runat="server" class="mt-2 border-top border-bottom border-dark"><i class=" fas fa-dollar-sign text-dark "></i><span class="mx-1"><span class="font-weight-bold   text-uppercase">Payment Mode:</span> <span id="PaymentMode" class="  text-uppercase" runat="server"></span></span></span>
                                                            <br />
                                                            <span title="print date" style="color: black" id="printdate" class="h5" runat="server"></span>

                                                            <br />

                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="conw" runat="server" style="color: black">
                                                    <asp:Repeater ID="rptrAttachment" runat="server">

                                                        <HeaderTemplate>

                                                            <table class="table align-items-center table-sm " style="color: black;">
                                                                <thead class="thead-dark ">
                                                                    <tr>
                                                                        <th scope="col" class="" style="border-block-color: black; border: solid; border-width: 1px">#</th>

                                                                        <th scope="col" class="" style="border-block-color: black; border: solid; border-width: 1px">Item & Description</th>
                                                                        <th scope="col" class=" text-center" style="border-block-color: black; border: solid; border-width: 1px">Quantity</th>
                                                                        <th scope="col" class="text-center" style="border-block-color: black; border: solid; border-width: 1px">Unit Price</th>


                                                                        <th scope="col" class=" text-right" style="border-block-color: black; border: solid; border-width: 1px">Total Price</th>

                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="text-left" style="color: black; border-block-color: black; border: solid; border-width: 1px">
                                                                    <a class="  " href="purchases.aspx?billno=<%# Eval("bill_number")%>&&vendor=<%# Eval("vendor_name")%>&&item=<%#Eval("item_name")%>&&item_id=<%# Eval("id")%>&&edit=true"><span><%# Eval("id")%></span></a>
                                                                </td>
                                                                <td class="text-left" style="color: black; border-block-color: black; border: solid; border-width: 1px">
                                                                    <span><%# Eval("item_name")%></span><br />
                                                                    <span class="small text-gray-600"><%# Eval("description")%></span>

                                                                </td>

                                                                <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class="text-center" contenteditable="true">
                                                                    <span><%# Convert.ToDouble(Eval("quantity")).ToString("#,##0.00")%></span>
                                                                </td>

                                                                <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class=" text-center" contenteditable="true">
                                                                    <span><%# Convert.ToDouble(Eval("unit_price")).ToString("#,##0.00")%></span>

                                                                </td>

                                                                <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class="text-right" contenteditable="true">
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
                                                            <div id="amoundInWordsDiv" runat="server">
                                                                <span class="text-gray-900 h6 text-uppercase mr-1 border-bottom border-dark">Amount in words: </span>
                                                                <br />
                                                                <span class="text-uppercase small font-weight-bold text-gray-900" id="AmountInWords" runat="server"></span>
                                                            </div>
                                      

                                                            <div class="row">
                                                                <div class="col-md-12 text-left">
                                                                    <span id="CreditDiv" runat="server" class="fas fa-arrow-circle-right text-gray-400 mr-2"></span><span id="CreditDiv2" runat="server">CREDIT BALANCE: [<span id="credittotal" class="font-weight-bold" runat="server">0.00</span>]</span>
                                                                </div>

                                                            </div>
                                                        </div>

                                                        <div class="col-md-4 mt-1" style="z-index: 2; color: black">
                                                            <div class="form-group">
                                                                <table class="table table-sm " style="color: black">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td style="color: black; border-block-color: black; border: solid; border-width: 1px"><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">Sub-Total:</span></td>
                                                                            <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class="text-right"><span id="subTotal" class=" font-weight-bold " runat="server"></span></td>
                                                                        </tr>
                                                                        <tr>
                                                                            <td style="color: black; border-block-color: black; border: solid; border-width: 1px"><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">VAT(15%):</span></td>
                                                                            <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class="text-right"><span id="vatAmount" class=" font-weight-bold" runat="server"></span></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td style="color: black; border-block-color: black; border: solid; border-width: 1px"><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">Grand Total:</span></td>
                                                                            <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class="text-right"><span id="Total" class="font-weight-bold" runat="server"></span></td>
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

                            <main role="main" id="mainb" class="mt-2 mb-5" runat="server" visible="false">

                                <div class="starter-template">
                                    <center>

                                        <h3 class="text-gray-900 mb-2 font-weight-bold">Create New Purchase</h3>

                                        <h5 class="text-gray-500 mb-3">Record and track your bill easily and neatly. When items purchased they will automatically affect the inventory ledger.</h5>
                                        <button type="button" data-toggle="modal" data-target="#ModalCreateBill" class="btn btn-danger text-white"><span class="fas fa-plus mr-2 text-white"></span>Create New Bill</button>
                                    </center>
                                </div>
                            </main>
                        </center>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" data-backdrop="static" id="ModalCreateBill" tabindex="-1" role="dialog" aria-labelledby="ModalAnalysis" aria-hidden="true">
            <div id="snackbar1">Order data successfully added!</div>
            <div id="snackbar2">Item updated successfully!</div>
            <div id="snackbar3">Item deleted successfully!</div>
            <div class="modal-dialog  modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title font-weight-bold text-gray-900" id="exampleModalLabelG"><span class="fas fa-cart-plus mr-2" style="color: #c24599"></span>
                            Create Bill [Bill#-<span id="billSpan" runat="server"></span>]
                            
                            <button class="btn btn-circle btn-sm ml-2" type="button" data-toggle="modal" data-target="#ExistingVendorModal"><span class="fas fa-user-check " data-toggle="tooltip" title="Select existing vendor" style="color: #d46fe8"></span></button>
                        </h6>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-8">
                                <asp:DropDownList ID="ddlOrderNumber" data-toggle="tooltip" title="Convert From Order" ClientIDMode="Static" class="form-control form-control-sm" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4">

                                <asp:TextBox ID="txtVendorName" ClientIDMode="Static" placeholder="Vendor Name" class="form-control form-control-sm" runat="server"></asp:TextBox>
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
                            <div class="col-md-4 ">

                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">FS#</span>
                                            <asp:TextBox ID="txtFSNumber" data-toggle="tooltip" ClientIDMode="Static" title="FS#" Style="border-color: #ff00bb" class="form-control form-control-sm " placeholder="FS#" runat="server"></asp:TextBox>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 ">
                                <asp:TextBox ID="txtDate" TextMode="Date" data-toggle="tooltip" ClientIDMode="Static" title="Date of Purchases" Style="border-color: #ff00bb" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-8 ">
                                <asp:TextBox ID="txtReferenceNumber" data-toggle="tooltip" title="Reference Number" ClientIDMode="Static" class="form-control form-control-sm" placeholder="Reference Number" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-8 ">
                                <label class=" text-gray-900  small font-weight-bold text-uppercase mr-3">[Payment Mode]</label>
                                <div class="custom-control custom-radio custom-control-inline">

                                    <input type="radio" id="cash" name="customRadioInline3" class="custom-control-input" checked="true" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-900 small font-weight-bold text-uppercase " for="cash">Cash</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="bank" name="customRadioInline3" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label font-weight-200  text-gray-900  small font-weight-bold text-uppercase " for="bank">Bank</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-8">
                                <asp:DropDownList ID="ddlBankAccount" Style="display: none" data-toggle="tooltip" title="Bank Account" ClientIDMode="Static" class="form-control form-control-sm" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-8 ">
                                <label class=" text-gray-900  small font-weight-bold text-uppercase mr-3">[Payment Status]</label>
                                <div class="custom-control custom-radio custom-control-inline">

                                    <input type="radio" id="paid" name="customRadioInline" class="custom-control-input" checked="true" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-900 small font-weight-bold text-uppercase " for="paid">Paid</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="credit" name="customRadioInline" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label font-weight-200  text-gray-900  small font-weight-bold text-uppercase " for="credit">Apply Credit</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-8 ">
                                <asp:TextBox ID="txtCreditAmount" Value="0" Style="display: none" data-toggle="tooltip" title="Credit Amount" ClientIDMode="Static" class="form-control form-control-sm" placeholder="Credit Amount" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="mt-2 mb-2 border-top"></div>
                        <div class="row">
                            <div class="col-12">
                                <div id="itemInfoDiv" style="display: none">
                                    <button class="btn btn-light btn-sm" type="button" data-toggle="tooltip" onclick="AddTable();" title="Add item"><span class="fas fa-plus"></span></button>

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
                            <div class="col-md-3 ">
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
                            <div class="col-md-2 " id="Div1" runat="server">
                                <asp:TextBox ID="txtManufacturingDate" TextMode="Date" data-toggle="tooltip" title="Manufactured Date" ClientIDMode="Static" Style="border-color: #ff00bb" class="form-control form-control-sm" placeholder="Manufactured Date" runat="server"></asp:TextBox>

                            </div>
                            <div class="col-md-2 " id="Div2" runat="server">
                                <asp:TextBox ID="txtExpiredDate" TextMode="Date" data-toggle="tooltip" title="Expired Date" ClientIDMode="Static" Style="border-color: #ff00bb" class="form-control form-control-sm" placeholder="Expired Date" runat="server"></asp:TextBox>

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
                                    <table class="table table-sm table-bordered">
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
                        <button class="btn btn-sm btn-light" type="button" onclick="CreatePurchasesClient();">Add</button>
                        <asp:LinkButton ID="btnCreateBill" runat="server" OnClientClick="CreatePurchasesClient();" class="btn btn-sm text-white" Style="background-color: #d46fe8" CausesValidation="false" OnClick="btnCreateBill_Click"><span class="fas fa-plus mr-2"></span>Create Bill</asp:LinkButton>

                    </div>

                </div>
            </div>
        </div>
        <div class="modal fade " id="ExistingVendorModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>
                            Select Vendor
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlExistingVendor" ClientIDMode="Static" class="form-control form-control-sm" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-sm text-white" style="background-color: #d46fe8" onclick="bindVendor();"><span class="fas fa-plus mr-2"></span>Bind</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="EditLineModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="fas fa-pencil-alt mr-2" style="color: #d46fe8"></span>Edit Line Item</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">QTY</span>
                                        </div>
                                        <asp:TextBox ID="txtEditQuantity" ClientIDMode="Static" data-toggle="tooltip" title="Quantity" placeholder="quantity eg. 3" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-12">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">UNP</span>
                                        </div>
                                        <asp:TextBox ID="txtEditUnitPrice" data-toggle="tooltip" title="Unit Price" ClientIDMode="Static" placeholder="unit price" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr />


                        <div class="row mb-3">
                            <div class="col-2">
                            </div>
                            <div class="col-8">
                                <center>
                                    <div class="input-group">
                                        <asp:LinkButton ID="btnSaveLineItem" class="btn btn-sm text-white w-100" Style="background-color: #d46fe8" runat="server" OnClick="btnSaveLineItem_Click"><span class="fas fa-save text-white mr-2"></span>Save Edit</asp:LinkButton>
                                    </div>
                                </center>

                            </div>
                            <div class="col-2">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="EditBillModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-pencil-alt mr-2" style="color: #ff00bb"></span>
                            Edit Invoice Info
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">FS#</span>
                                        </div>
                                        <asp:TextBox ID="txtEditFSNumber" data-toggle="tooltip" title="FS#" ClientIDMode="Static" placeholder="FS#" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-12 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">BILL#</span>
                                        </div>
                                        <asp:TextBox ID="txtEdiBillNumber" data-toggle="tooltip" title="INV#" ClientIDMode="Static" placeholder="INV#" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnSaveEditInvoiceInfo" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnSaveEditInvoiceInfo_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="DeleteLineItemModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-trash mr-2" style="color: #ff00bb"></span>
                            Delete Line Item
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12 mx-2 border-danger border-left">
                                <span class="fas fa-arrow-alt-circle-right text-danger mr-2"></span>
                                <span class="small text-gray-500">Are You Sure to Delete the Items?</span>
                                <br />
                                <span class="fas fa-arrow-alt-circle-right text-danger mr-2"></span>
                                <span class="small text-danger" id="selectedItem" runat="server"></span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDeleteLineItem" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnDeleteLineItem_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="DeletInvoiceModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-trash mr-2" style="color: #ff00bb"></span>
                            Delete Invoice
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12 mx-2 border-danger border-left">
                                <span class="fas fa-arrow-alt-circle-right text-danger mr-2"></span>
                                <span class="small text-gray-500">Are You Sure to Delete the Invoice?</span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDeleteBill" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnDeleteBill_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        function myFunctionSnackDelete() {
            // Get the snackbar DIV
            var x = document.getElementById("snackbar2");

            // Add the "show" class to DIV
            x.className = "show";

            // After 3 seconds, remove the show class from DIV
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 6000);
        }
        function myFunctionSnackUpdate() {
            // Get the snackbar DIV
            var x = document.getElementById("snackbar3");

            // Add the "show" class to DIV
            x.className = "show";

            // After 3 seconds, remove the show class from DIV
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 6000);
        }
        function myFunctionSnack() {
            // Get the snackbar DIV
            var x = document.getElementById("snackbar1");

            // Add the "show" class to DIV
            x.className = "show";

            // After 3 seconds, remove the show class from DIV
            setTimeout(function () { x.className = x.className.replace("show", ""); }, 6000);
        }
        function BindOrderData() {

            PageMethods.BindOrderItems(document.getElementById("<%=ddlOrderNumber.ClientID%>").value, OnOrderItemDataBinded, OnOrderItemDataBindedError);
            PageMethods.BindOrderVendor(document.getElementById("<%=ddlOrderNumber.ClientID%>").value, OnOrderCustDataBinded, OnOrderCustDataBindedError);
                    PageMethods.BindOrderSubtotals(document.getElementById("<%=ddlOrderNumber.ClientID%>").value, OnOrderSubTotalDataBinded, OnOrderCustDataBinded);
                }
                function OnOrderSubTotalDataBinded(result) {
                    var subTotal = document.getElementById("<%=VatFree.ClientID %>");
                    var Vat = document.getElementById("<%=VAT.ClientID %>");
                    var totalAmount = document.getElementById("<%=GrandTotal.ClientID %>");
            subTotal.innerHTML = Number(result[1]).toFixed(2);
            Vat.innerHTML = Number(result[2]).toFixed(2);
            totalAmount.innerHTML = Number(result[0]).toFixed(2);

            $("[id*=txtGrandTotal]").val(Number(result[0]).toFixed(2));
        }
        function OnOrderSubTotalDataBindedError(error) {
            alert("Error Bind");
        }
        function OnOrderCustDataBinded(result) {
            $("[id*=txtTINNumber]").val(result[2]);
            $("[id*=txtAddress]").val(result[1]);
            $("[id*=txtVendorName]").val(result[0]);
        }
        function OnOrderCustDataBindedError(error) {
            alert("Error Bind");
        }
        function OnOrderItemDataBinded(result) {
            myFunctionSnack();
            var table = document.getElementById("myTable");
            if (table.rows.length == 1) {
                // Add some text to the new cells:
                var rowCount = result.length;

                for (var i = 0; i < rowCount; i++) {
                    var row = table.insertRow(i + 1);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    var cell3 = row.insertCell(2);
                    var cell4 = row.insertCell(3);
                    cell1.innerHTML = result[i][0];
                    cell2.innerHTML = result[i][1];
                    cell3.innerHTML = result[i][2];
                    cell4.innerHTML = result[i][3];
                    cell4.className = "text-right";
                }

                cell4.className = "text-right";

            }
        }

        function OnOrderItemDataBindedError(error) {
            alert("Error Bind");
        }
        $('#ddlOrderNumber').change(function () {
            BindOrderData();
            $("#itemInfoDiv").toggle(true);
        });
    </script>
    <script type="text/javascript">
        $('#paid').click(function () {
            $("#txtCreditAmount").toggle(false);
        });
        $('#credit').click(function () {
            $("#txtCreditAmount").toggle(true);
        });
    </script>
    <script type="text/javascript">
        $('#bank').click(function () {
            $("#ddlBankAccount").toggle(this.checked);
        });
        $('#cash').click(function () {
            $("#ddlBankAccount").toggle(false);
        });
    </script>
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
        function bindVendor() {
            PageMethods.GetVendorInfo($("#ddlExistingVendor option:selected").text(), Success, Failure);
        }
        function Success(result) {
            $("[id*=txtTINNumber]").val(result[0]);
            $("[id*=txtAddress]").val(result[1]);
            $("[id*=txtVendorName]").val($("#ddlExistingVendor option:selected").text());
            $('#ExistingVendorModal').modal('hide');
            $('#ModalCreateBill').modal('show');
        }
        function Failure(error) {
            alert(error);
        }
    </script>
    <script type="text/javascript">
        function CreatePurchasesClient() {

            var table = document.getElementById("myTable");
            var rowCount = table.rows.length;
            for (var i = 1; i < rowCount; i++) {

                var description = table.rows[i].cells[0].innerText;
                var indexOfNewLine = description.indexOf("\n");
                description = description.substring(indexOfNewLine, description.length);
                var itemName = table.rows[i].cells[0].innerText;
                var unitPrice = Number(table.rows[i].cells[2].innerText);
                var quantity = Number(table.rows[i].cells[1].innerText);
                var totalPrice = unitPrice * quantity;
                PageMethods.CreatePurchases($("[id*=txtVendorName]").val(), itemName, $("[id*=txtReferenceNumber]").val(), $("[id*=txtDate]").val(),
                    unitPrice, description,  quantity, totalPrice,
                    document.getElementById("<%=billSpan.ClientID %>").innerHTML, $("[id*=txtExpiredDate]").val(), $("[id*=txtManufacturingDate]").val(), OnSuccess, OnError);
            }
        }
        function OnSuccess(result) {
            alert("Success");
        }
        function OnError(error) {
            alert("Couldn't Save");
        }
    </script>
</asp:Content>
