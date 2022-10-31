<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="sales.aspx.cs" Inherits="pos.app.sales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Sales</title>
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

        window.addEventListener('load', (event) => {
            var x = document.getElementById("Pbutton");
            x.style.display = "none";
    </script>
    <script type="text/javascript">

        //document.onkeyup = function (e) {
            //if (e.which == 67) {
                //$('#ModalCreateInvoice').modal('show');
            //}
        //};
    </script>

    <script type="text/javascript">

            $(document).ready(function () {
                function GetDefaultPrinter() {
                    PageMethods.GetPrinterSN(returnPrinterId);
                }
                function returnPrinterId(result) {
                    var printerId = document.getElementById("<%=printerId.ClientID%>");
                    printerId.innerHTML = result;
                }
                GetDefaultPrinter();
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
    <style>
        .water {
            opacity: 0.5;
            z-index: 1;
            transform: rotate(-45deg);
            position: absolute;
        }
    </style>
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
                                <span visible="false" id="invoiceStatus" runat="server"></span>
                                <span class="fas fa-cart-plus mr-2" style="color: #d46fe8" id="salesIconSpan" runat="server"></span><span id="salesSpan" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">Sales</span>

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
                                    <button id="draftConverter" runat="server" visible="false" type="button"  class="btn btn-outline-warning rounded-pill mr-2 btn-sm" data-toggle="modal" data-target="#convertModal">Convert to Invoice</button>
                                    <button type="button" visible="false" runat="server" id="btnCustomize" class="mr-2 btn btn-secondary btn-circle btn-sm" data-toggle="modal" data-target="#CustomizeInvoiceModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Customize Template" class="fas fa-cog  font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnSendEmail" class="mr-2 btn btn-circle btn-secondary btn-sm" data-toggle="modal" data-target="#ModalCreateInvoice">
                                        <div>
                                            <i data-toggle="tooltip" title="Send Email" class="fas fa-envelope  font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnDelete" class="mr-2 btn btn-circle btn-secondary btn-sm" data-toggle="modal" data-target="#DeletInvoiceModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Delete Invoice" class="fas fa-trash  font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnDuplicate" class="mr-2 btn btn-circle btn-secondary btn-sm" data-toggle="modal" data-target="#ModalCreateInvoice">
                                        <div>
                                            <i data-toggle="tooltip" title="Duplicate" class="fas fa-copy  font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="false" runat="server" id="btnEdit" class="mr-2 btn btn-circle btn-secondary btn-sm" data-toggle="modal" data-target="#EditInvoiceModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Edit Info" class="fas fa-edit  font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button name="b_print" onclick="printdiv('div_print');" class="mr-2 btn btn-circle btn-secondary btn-sm">
                                        <div>
                                            <i class="fas fa-print font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" runat="server" id="Sp2" class="mr-1 btn btn-sm btn-circle" style="background-color: #d46fe8" data-toggle="modal" data-target="#ModalCreateInvoice">
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
                                        <div class="dropdown-header text-gray-900">Filter:</div>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#filterModal" id="A1" runat="server"><span class="fas fa-filter mr-2 " style="color: #d46fe8"></span>Filter Record</a>

                                        <div class="dropdown-header text-gray-900">Option:</div>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#DiscountModal" id="A2" runat="server"><span class="fas fa-cog mr-2 " style="color: #d46fe8"></span>Manage Discount</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#createNewBankModal" id="LR" runat="server"><span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Bank Account</a>

                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" visible="false" data-target="#CreditModal" id="creditLink" runat="server"><span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Credit</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" visible="false" data-target="#CommentModal" id="commentLink" runat="server"><span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Comment</a>
                                        <a href="#" class="dropdown-item  text-gray-900  text-danger" onclick="ShowRefund();" data-toggle="modal" visible="false" data-target="#ModalCreateInvoice" id="refundLink" runat="server"><span class="fas fa-reply mr-2" style="color: #d46fe8"></span>Refund Invoice</a>
                                    </div>
                                </div>

                            </div>
                        </div>

                    </div>
                    <div class="card-body small text-gray-900" id="InvoiceDiv" style="margin-top: -21px" runat="server">
                        <asp:Repeater ID="rptrInvoice" runat="server">

                            <HeaderTemplate>
                                <table class="table align-items-center table-hover table-sm ">
                                    <thead>
                                        <tr>

                                            <th scope="col" class="text-gray-900 text-uppercase text-left">Date</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Invoice#</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Customer </th>
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
                                        <a class=" text-primary  " href="sales.aspx?invno=<%# Eval("invoice_number")%>&&fsno=<%# Eval("fsno")%>&&customer=<%# Eval("customer_name")%>"><span>INV#-00000<%# Eval("invoice_number")%></span></a>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="lblCustomer" runat="server" Text='<%# Eval("customer_name")%>'></asp:Label>
                                    </td>

                                    <td class="text-gray-900">
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("total_amount" , "{0:N2}")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("balance" , "{0:N2}")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900 text-right">
                                        <span class="badge badge-success"><%# Eval("invoice_type" , "{0:N2}")%></span>
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
                                <td>

                                </td>
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
                    <div class="card-body text-gray-900" visible="false" id="invoiceDetailDiv" runat="server">
                        <div class="row">
                            <div class="col-4 border-right" style="margin-top: -21px; max-height:900px;overflow-y:scroll;overflow-x:hidden">
                                <asp:Repeater ID="rptInvoiceShort" runat="server">

                                    <HeaderTemplate>
                                        <table class="table align-items-center table-hover table-sm ">

                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="border-bottom">

                                            <td>
                                                <asp:Label ID="Label3" class="text-gray-900 small" runat="server" Text='<%# Eval("customer_name")%>'></asp:Label>
                                                <br />
                                                <a class=" text-primary  small" href="sales.aspx?invno=<%# Eval("invoice_number")%>&&fsno=<%# Eval("fsno")%>&&customer=<%# Eval("customer_name")%>"><span>INV#-<%# Eval("invoice_number")%></span></a>
                                                <span>| <span class="small text-gray-900"><%# Eval("date")%></span> </span>
                                            </td>

                                            <td class="text-gray-900 text-right">
                                                <h6><span class="small text-gray-400 font-weight-bold text-uppercase">Balance</h6>
                                                <asp:Label ID="Label8" runat="server" class="text-uppercase text-gray-600 small" Text='<%# Eval("balance" , "{0:N2}")%>'></asp:Label>

                                            </td>

                                        </tr>

                                    </ItemTemplate>
                                    <FooterTemplate>
                                        </tbody>
                                  </table>
                                    </FooterTemplate>

                                </asp:Repeater>
                            </div>
                            <div class="col-8" style="max-height:900px;overflow-y:scroll;overflow-x:hidden">
          
                                <div id="div_print">

                                    <div class="row mt-3" style="margin-left: -60px; margin-right: -60px">
                                        <div class="col-1">
                                        </div>
                                        <div id="colTen" class="col-10 shadow-sm" >
                                            <div class="card-body border-none">
                                                <div class="row">
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
                                                                    <span style="color: black" id="VT" runat="server" class="border-top mb-2 mt-1">TIN Number<span class="fas border-top m-1 fa-hashtag  ml-1"></span><span id="VendorTIN" runat="server"></span></span>
                                                                    <br />
                                                                    <span style="color: black" id="VendorVatRegSpan" contenteditable="true" runat="server" width="200px">Vat Reg. Number<span class="fas fa-hashtag  ml-1"></span><span id="VendorVatRegNumber" width="200px" contenteditable="true" runat="server" class="ml-1"></span></span>
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

                                                        <span style="color: black" contenteditable="true" class="h4 text-uppercase border-bottom border-dark font-weight-bold" id="HeaderInv" runat="server"></span>
                                                        <br />
                                                        <span id="invocenumber" runat="server"></span>
                                                        <div id="Body2" runat="server">
                                                            <span id="BindShop" runat="server">
                                                                <span style="height: 100px; color: black" contenteditable="true">To: </span><span style="height: 100px; color: black" contenteditable="true" class=" font-weight-bold text-uppercase" id="Name" runat="server"></span>
                                                                <span style="height: 100px; color: black" contenteditable="true" class=" font-weight-bold font-italic" id="CustomerCompany" runat="server"></span>
                                                                <br />
                                                                <span id="CustomerTIN" style="color: black" runat="server" width="200px">CUSTOMER TIN<span class="fas fa-hashtag  ml-1"></span><span id="TINNUMBER" width="200px" contenteditable="true" runat="server" class="ml-1"></span></span>
                                                                <br />
                                                                <span id="CustVatRegNumberSpan" style="color: black" contenteditable="true" runat="server" width="200px">Vat Reg. Number<span class="fas fa-hashtag ml-1"></span><span id="CustVatRegNumber" width="200px" contenteditable="true" runat="server" class="ml-1"></span></span>

                                                            </span>
                                                            <br />
                                                            <span id="Addressbar" class="border-bottom border-dark" style="color: black" runat="server">ADDRESS: <span id="Address" class="  text-uppercase" contenteditable="true" runat="server"></span></span>
                                                            <h6 class=""><span class="text-uppercase font-weight-bold " style="color: black" id="InvNoBinding" runat="server">INV#</span></h6>
                                                            <h6><span class="text-uppercase  font-weight-bold " id="FSno" style="color: black" contenteditable="true" runat="server">FS#</span></h6>
                                                            <h6 id="dateDiv" runat="server"><span class="text-uppercase text-gray-900 font-weight-bold mr-1" id="Span1" runat="server">Date:</span><span id="dateSpan" style="color: black" runat="server"></span></h6>
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

                                                            <table class="table align-items-center table-sm " style="color: black;" id="attachmentTable">
                                                                <thead class="thead-dark ">
                                                                    <tr>
                                                                        <th scope="col" class="" style="border-block-color: black; border: solid; border-width: 1px">#</th>

                                                                        <th scope="col" class="" style="border-block-color: black; border: solid; border-width: 1px">Item</th>
                                                                        <th scope="col" class="" style="border-block-color: black; border: solid; border-width: 1px">Description</th>
                                                                        <th scope="col" class=" text-center" style="border-block-color: black; border: solid; border-width: 1px">Quantity</th>
                                                                        <th scope="col" class="text-center" style="border-block-color: black; border: solid; border-width: 1px">Price</th>


                                                                        <th scope="col" class=" text-right" style="border-block-color: black; border: solid; border-width: 1px">Amount</th>

                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="text-left" style="color: black; border-block-color: black; border: solid; border-width: 1px">
                                                                    <a class="  " href="sales.aspx?invno=<%# Eval("invoice_number")%>&&fsno=<%# Eval("fsno")%>&&customer=<%# Eval("customer_name")%>&&item_id=<%# Eval("id")%>&&edit=true"><span><%# Eval("id")%></span></a>
                                                                </td>
                                                                <td class="text-left" style="color: black; border-block-color: black; border: solid; border-width: 1px">
                                                                    <%# Eval("item_name")%>
                                                                </td>
                                                                <td class="text-left" style="color: black; border-block-color: black; border: solid; border-width: 1px">
                                                                    <%# Eval("description")%>
                                                                    

                                                                </td>
                                                                <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class="text-center" contenteditable="true">
                                                                   <%# Convert.ToDouble(Eval("quantity")).ToString("#,##0.00")%>
                                                                </td>

                                                                <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class=" text-center" contenteditable="true">
                                                                    <%# Convert.ToDouble(Eval("unit_price")).ToString("#,##0.00")%>
                                                                </td>

                                                                <td style="color: black; border-block-color: black; border: solid; border-width: 1px" class="text-right" contenteditable="true">
                                                                    <%# Convert.ToDouble(Eval("total_amount")).ToString("#,##0.00")%>
                                                                </td>
                                                            </tr>

                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                   </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>
                                                    <center>
                                                        <h5 id="RaksTDiv" runat="server" class="water text-gray-900 font-weight-bolder mx-lg-5" style="padding-right: 0px; padding-left: 300px; font-size: 70px;">ATTACHMENT</h5>

                                                    </center>
                                                    <div class="row" id="TotalRow" runat="server">

                                                        <div class="col-md-8 text-left" style="z-index: 2">
                                                            <div id="amoundInWordsDiv" runat="server">
                                                                <span class="text-gray-900 h6 text-uppercase mr-1 border-bottom border-dark">Amount in words: </span>
                                                                <br />
                                                                <span class="text-uppercase small font-weight-bold text-gray-900" id="AmountInWords" runat="server"></span>
                                                            </div>
                                                            <p class="small text-gray-900 font-weight-bold border-top">* Invalid without Fiscal or Refund Receipt</p>

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
                                                    <div class="row " id="NotesDiv" runat="server" style="color: black">

                                                        <div class="col-md-6 text-left font-italic font-weight-bold">
                                                            <span class="mb-2">Prepared By:_________________________</span><br />
                                                            <br />
                                                            <span>Signature_________________________</span>
                                                        </div>
                                                        <div class="col-md-6 text-right font-italic font-weight-bold">
                                                            <span class=" mb-2 text-right">Authorized By:_________________________</span><br />
                                                            <br />
                                                            <span class=" text-right">Signature_________________________</span>
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
        <div class="modal fade " id="filterModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="fas fa-filter mr-2" style="color: #d46fe8"></span>Filter Record</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-md-12">
                                <div class="custom-control custom-checkbox custom-control-inline">
                                    <input type="checkbox" id="dateRange" name="customRadioInline2" class="custom-control-input" runat="server" checked="true" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-700 small " for="dateRange">Date Range</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">FRM</span>
                                        </div>
                                        <asp:TextBox ID="txtDateFrom" ClientIDMode="Static" TextMode="Date" data-toggle="tooltip" title="From Date" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                                                        <div class="col-6">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">TOD</span>
                                        </div>
                                        <asp:TextBox ID="txtDateTo" ClientIDMode="Static" TextMode="Date" data-toggle="tooltip" title="To Date" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-2">
                            <div class="col-md-12">
                                <div class="custom-control custom-checkbox custom-control-inline">
                                    <input type="checkbox" id="advancedSearch" name="customRadioInline2" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-700 small " for="advancedSearch">Advanced search</label>
                                </div>
                            </div>
                        </div>
                        <div id="customerDiv" style="display:none">
                            <div class="col-12">
                                <div class="row mb-3">
                                    <div class="col-6">
                                        <asp:TextBox ID="txtCustomerSearchName" ClientIDMode="Static" placeholder="Customer Name. eg Abel" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                    <div class="col-6">
                                        <asp:TextBox ID="txtInvoiceNumber" ClientIDMode="Static" placeholder="Invoice Number/ Att. Reference" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                        
                        <div class="row mb-3" id="invoiceDiv" style="display: none">
                            <div class="col-12">
                                <div class="form-group mb-0">
                                    <asp:DropdownList ID="ddlInvoiceType" ClientIDMode="Static" placeholder="Customer Name. eg Abel" class="form-control form-control-sm" runat="server">
                                        <asp:ListItem>Cash Sale</asp:ListItem>
                                        <asp:ListItem>Credit Sale</asp:ListItem>
                                        <asp:ListItem>Refund</asp:ListItem>
                                    </asp:DropdownList>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnFilterRecord" class="btn btn-sm text-white" Style="background-color: #d46fe8" runat="server" OnClick="btnFilterRecord_Click"><span class="fas fa-search text-white mr-2"></span>Search</asp:LinkButton>
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
        <div class="modal fade " id="CommentModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="fas fa-comment mr-2" style="color: #d46fe8"></span>Add Comment</h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12">
                                <div class="form-group mb-0">
                                    <asp:TextBox ID="txtInvoiceComment" Height="150px" ClientIDMode="Static" TextMode="MultiLine" data-toggle="tooltip" title="Quantity" placeholder="Comments here..." class="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-2">
                            </div>
                            <div class="col-8">
                                <center>
                                    <div class="input-group">
                                        <asp:LinkButton ID="btnSaveComment" class="btn btn-sm text-white w-100" Style="background-color: #d46fe8" runat="server" OnClick="btnSaveComment_Click"><span class="fas fa-save text-white mr-2"></span>Save Comment</asp:LinkButton>
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
        <div class="modal fade " id="CreditModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="fas fa-plus mr-2" style="color: #d46fe8"></span>Add Credit to Invoice</h5>
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
                                            <span class="input-group-text">ETB</span>
                                        </div>
                                        <asp:TextBox ID="txtAddCreditAmount" ClientIDMode="Static" data-toggle="tooltip" title="Credit Amount" placeholder="Credit Amount" class="form-control form-control-sm" runat="server"></asp:TextBox>
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
                                        <asp:LinkButton ID="btnSaveCredit" class="btn btn-sm text-white w-100" Style="background-color: #d46fe8" runat="server" OnClick="btnSaveCredit_Click"><span class="fas fa-save text-white mr-2"></span>Save Credit</asp:LinkButton>
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

        <div class="modal fade " id="BankTableModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel">
                            <span class="fas fa-cog mr-2" style="color: #d46fe8"></span>Manage Bank</h5>
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
        <div class="modal fade " id="createNewBankModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-plus mr-2" style="color: #ff00bb"></span>
                            New Bank Account
                            <button class="btn btn-circle btn-sm ml-2" type="button" data-toggle="modal" data-target="#BankTableModal"><span class="fas fa-cog " style="color: #d46fe8"></span></button>
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-6">
                                <asp:TextBox ID="txtBankName" runat="server" class="form-control form-control-sm" placeholder="Bank name"></asp:TextBox>
                            </div>
                            <div class="col-6">
                                <asp:TextBox ID="txtAccountNumber" runat="server" class="form-control form-control-sm" placeholder="Account Number"></asp:TextBox>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnSaveBankAccount" class="btn btn-sm btn-danger" runat="server" OnClick="btnSaveBankAccount_Click"><span class="fas fa-save text-white mr-2"></span>Save</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" data-backdrop="static" id="ModalCreateInvoice" tabindex="-1" role="dialog" aria-labelledby="ModalAnalysis" aria-hidden="true">
            <div class="modal-dialog  modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h6 class="modal-title font-weight-bold text-gray-900" id="exampleModalLabelG"><span class="fas fa-cart-plus mr-2" id="createInvoiceIcon" runat="server" style="color: #c24599"></span>
                            <span id="createInvoiceSpan" runat="server">Create Invoice</span> [INV#-<span id="invoiceSpan" runat="server"></span>]

                            <button class="btn btn-circle btn-sm ml-2" type="button" data-toggle="modal" data-target="#ExistingCustomerModal"><span class="fas fa-user-check " data-toggle="tooltip" title="Select existing customer" style="color: #d46fe8"></span></button>
                            <span class="m-1 small text-uppercase text-white">Printer ID<span id="printerId" runat="server" class="badge text-lowercase text-white badge-light"></span></span>

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
                                <asp:TextBox ID="txtDate" TextMode="Date" data-toggle="tooltip" ClientIDMode="Static" title="Date of Invoice" Style="border-color: #ff00bb" class="form-control form-control-sm" runat="server"></asp:TextBox>
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
                        <div class="row border-top mb-3">
 
                            <div class="col-12">      
                                <label class="small mr-2 text-gray-600">Receipt Settings:</label>
                                <div class="custom-control custom-checkbox custom-control-inline">

                                    <input type="checkbox" id="duplicate" name="customRadioInline2" class="custom-control-input"  runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-700 small " for="duplicate">Print Duplicate Receipt</label>
                                </div>
                                <div class="custom-control custom-checkbox custom-control-inline">
                                    <input type="checkbox" id="refund" name="customRadioInline2" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-700 small " for="refund">Is Refund</label>
                                </div>

                            </div>
                        </div>
                        <div class="row mb-3  border-top">
                            <div class="col-7 mt-2">
                                <asp:DropDownList ID="ddlINVnumber" Style="display: none" data-toggle="tooltip" title="Select Invoice to Refund" ClientIDMode="Static" class="form-control form-control-sm" runat="server"></asp:DropDownList>
                            </div>
                            
                        </div>
                        <div class="row mb-3" id="refundTable" style="display:none">
                            <div class="col-7">
                                <div class=" table-responsive">
                                    <table class="table table-sm table-bordered">

                                        <tbody>

                                            <tr class="border-bottom">
                                                <td class=" text-gray-700">
                                                    <span class="fas fa-arrow-alt-circle-right mr-2 text-gray-400"></span><span class="text-gray-500 small">Device Rec#</span>

                                                </td>
                                                <td class=" text-right">
                                                    <span class="small text-gray-600" id="refundReceiptNo" runat="server"></span>

                                                </td>
                                            </tr>
                                            <tr class="border-bottom">
                                                <td class=" text-gray-700">
                                                    <span class="fas fa-arrow-alt-circle-right mr-2 text-gray-400"></span><span class="text-gray-500 small">DateTime</span>

                                                </td>
                                                <td class=" text-right">
                                                    <span class="small text-gray-600" id="refundDateTime" runat="server"></span>


                                                </td>
                                            </tr>
                                            <tr class="border-bottom">
                                                <td class=" text-gray-700 ">
                                                    <span class="fas fa-arrow-alt-circle-right mr-2 text-gray-400"></span><span class="text-gray-500 small">Fiscal Memory#</span>

                                                </td>
                                                <td class=" text-right">
                                                    <span class=" text-gray-600">

                                                        <span class="small text-gray-600" id="refundMemory" runat="server"></span>

                                                    </span>

                                                </td>
                                            </tr>
                                            

                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                        <div class="mt-2 mb-2 border-top"></div>
                        <div class="row">
                            <div class="col-12">
                                <div id="itemInfoDiv" style="display: none">
                                    <button class="btn btn-light btn-sm" type="button" data-toggle="tooltip" onclick="AddTable();CreateSale();" title="Add item"><span class="fas fa-plus"></span></button>

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
                            <div class="col-md-3" id="discountDiv" runat="server">
                                <div class="input-group">
                                    <asp:TextBox ID="txtDiscountLine" Value="0" ClientIDMode="Static" ReadOnly="false" data-toggle="tooltip" title="Line Discount" class="form-control form-control-sm" placeholder="Line Discount" runat="server"></asp:TextBox>

                                    <div class="input-group-append">
                                        <asp:DropDownList ID="ddlLineDiscountType" data-toggle="tooltip" title="Disc. Type" data-placement="bottom" ClientIDMode="Static" class="form-control form-control-sm " runat="server">
                                            <asp:ListItem>ETB</asp:ListItem>
                                            <asp:ListItem>%</asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>

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
                                <span class="text-gray-400 mx-1 border-bottom border-top">ITEM#</span><span id="itemCount" runat="server" class="text-gray-400  border-bottom border-top"></span>
                            </div>
                            <div class="col-4 small">
                                <div class="form-group">
                                    <div class="input-group">
                                        <asp:TextBox ID="txtDiscount" ClientIDMode="Static" Value="0" data-toggle="tooltip" title="Total Discount" class="form-control mb-2 form-control-sm" placeholder="Add Discount" runat="server"></asp:TextBox>

                                        <div class="input-group-append">
                                            <asp:DropDownList ID="ddlTransactionDiscountType" data-toggle="tooltip" title="Disc. Type" data-placement="bottom" ClientIDMode="Static" class="form-control mb-2 form-control-sm " runat="server">
                                                <asp:ListItem>ETB</asp:ListItem>
                                                <asp:ListItem>%</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
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
                        <button class="btn btn-light btn-sm" type="button" onclick="ConvertToPercentage()">Add</button>
                        <button class="btn btn-sm text-white" style="background-color: #d46fe8;display: none" type="button" disabled id="Pbutton">
                            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                            Creating Invoice...
                        </button>
                        <asp:LinkButton ID="btnSaveAsDraft" runat="server" class="btn btn-sm btn-light" OnClientClick="ShowLoader();SendJSONtoPrinter();" CausesValidation="false" OnClick="btnSaveAsDraft_Click"><span class="fas fa-save mr-2"></span>Save as Draft</asp:LinkButton>
                        <asp:LinkButton ID="btnCreateInvoice" runat="server" class="btn btn-sm text-white" OnClientClick="ShowLoader();SendJSONtoPrinter();" Style="background-color: #d46fe8" CausesValidation="false" OnClick="btnCreateInvoice_Click"><span class="fas fa-plus mr-2"></span>Create Invoice</asp:LinkButton>

                    </div>

                </div>
            </div>
        </div>



        <div class="modal fade " id="CustomizeInvoiceModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-cogs mr-2" style="color: #ff00bb"></span>
                            Customize Template
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12 ">
                                <div class="form-group mb-0">
                                    <asp:TextBox ID="txtHeadingName" data-toggle="tooltip" title="Edit Heading Name" ClientIDMode="Static" placeholder="Heading Name" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-6 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <asp:TextBox ID="txtHeadingFontsize" class="form-control form-control-sm" data-toggle="tooltip" data-placement="bottom" title="Edit Heading font size" TextMode="Number" Height="25px" Width="70px" runat="server" Text="12"></asp:TextBox>

                                        <div class="input-group-prepend " style="height: 25px">
                                            <span class="input-group-text ">px</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <asp:TextBox ID="txtHeadingLineHeight" class="form-control form-control-sm" data-toggle="tooltip" data-placement="bottom" title="Edit Heading Line Spacing" TextMode="Number" Height="25px" Width="70px" runat="server" Text="12"></asp:TextBox>

                                        <div class="input-group-prepend " style="height: 25px">
                                            <span class="input-group-text ">px</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-6 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <asp:TextBox ID="txtBodyFontSize" class="form-control form-control-sm" data-toggle="tooltip" data-placement="bottom" title="Edit Body font size" TextMode="Number" Height="25px" Width="70px" runat="server" Text="12"></asp:TextBox>

                                        <div class="input-group-prepend " style="height: 25px">
                                            <span class="input-group-text ">px</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <asp:TextBox ID="txtLogosize" class="form-control form-control-sm" data-toggle="tooltip" data-placement="bottom" title="Edit Logo size" TextMode="Number" Height="25px" Width="70px" runat="server" Text="12"></asp:TextBox>

                                        <div class="input-group-prepend " style="height: 25px">
                                            <span class="input-group-text ">px</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                                <h6 class="text-gray-900 small mb-3">Watermark Opacity(<asp:Label ID="lblOpacity" class="text-danger" ClientIDMode="Static" runat="server" Text="Label"></asp:Label>)</h6>
                                <div class="form-group">
                                    <input type="range" class="custom-range" min="0" max="1" step="0.1" id="customRange5">
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-6">
                                <h6 class="text-gray-900 small mb-3" data-toggle="tooltip" title="credit balance line visibility">CB Visibilty</h6>
                                <div class="custom-control mb-2 custom-checkbox font-weight-300">
                                    <input type="checkbox" class="custom-control-input" id="creditCheck" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label small text-gray-900 font-weight-bolder" for="creditCheck">Visible</label>
                                </div>

                            </div>
                            <div class="col-6 text-right">
                                <h6 class="text-gray-900 small mb-3" data-toggle="tooltip" title="watermark line visibility">WM Visibilty</h6>
                                <div class="custom-control mb-2 custom-checkbox font-weight-300">
                                    <input type="checkbox" class="custom-control-input" id="waterCheck" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label small text-gray-900 font-weight-bolder" for="waterCheck">Visible</label>
                                </div>

                            </div>

                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnSaveCustomization" OnClientClick="UpdateOpacity1();" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnSaveCustomization_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Save</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            function ShowLoader() {
                var y = document.getElementById("<%=btnCreateInvoice.ClientID %>");
                var z = document.getElementById("<%=btnSaveAsDraft.ClientID %>");
                var x = document.getElementById("Pbutton");
                if (x.style.display === "none") {
                    x.style.display = "block";
                } else {
                    x.style.display = "none";
                }

                if (y.style.display === "none") {
                    y.style.display = "block";
                } else {
                    y.style.display = "none";
                }
                if (z.style.display === "none") {
                    z.style.display = "block";
                } else {
                    z.style.display = "none";
                }
            }
        </script>
        <script type="text/javascript">
            var slider = document.getElementById("customRange5");
            var txtAm = document.getElementById("<%=lblOpacity.ClientID%>");
            slider.oninput = function () {
                txtAm.innerText = this.value;
            }
        </script>
        <div class="modal fade " id="convertModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-stop-circle mr-2" style="color: #ff00bb"></span>
                            Approve Conversion
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-2 ">
                            <div class="col-12 ">
                                
                                <span class="text-gray-400 text-uppercase">Draft Summary</span>
                                 <br />
                                <table class="table table-sm">

                                    <tbody>
                                        <tr class="border-bottom">
                                            <td class=" text-gray-700">
                                                <span class="fas fa-arrow-alt-circle-right mr-2 text-gray-400"></span><span class="text-gray-500 small">Total Amount</span>

                                            </td>
                                            <td class=" text-right">
                                                <span class="small text-gray-600" id="totalAmount" runat="server"></span>

                                            </td>
                                        </tr>
                                        <tr class="border-bottom">
                                            <td class=" text-gray-700">
                                                <span class="fas fa-arrow-alt-circle-right mr-2 text-gray-400"></span><span class="text-gray-500 small">Credit</span>

                                            </td>
                                            <td class=" text-right">
                                                <span class="small text-gray-600" id="creditAmount" runat="server"></span>


                                            </td>
                                        </tr>
                                        <tr class="border-bottom">
                                            <td class=" text-gray-700 text-uppercase">
                                                <span class="fas fa-arrow-alt-circle-right mr-2 text-gray-400"></span><span class="text-gray-500 small">Item#</span>

                                            </td>
                                            <td class=" text-right">
                                                <span class=" text-gray-600">

                                                    <span class="small text-gray-600" id="itemCountSummary" runat="server"></span>

                                                </span>

                                            </td>
                                        </tr>
              
                                    </tbody>
                                </table>
                            </div>
                            </div>
                        <div class="row mb-3">
                            <div class="col-12 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">FS#</span>
                                        </div>
                                        <asp:TextBox ID="txtDraftFSNumber" data-toggle="tooltip" title="FS#" ClientIDMode="Static" placeholder="FS#" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-12 ">
                                <div class="form-group mb-0">
                                    <div class="input-group input-group-alternative input-group-sm">
                                        <div class="input-group-prepend ">
                                            <span class="input-group-text">DATE</span>
                                        </div>
                                        <asp:TextBox ID="txtDraftDate" data-toggle="tooltip" TextMode="Date" title="Date of Invoice" ClientIDMode="Static" placeholder="Date" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3 border-top border-bottom">

                            <div class="col-12">
              
                                <div class="custom-control custom-checkbox custom-control-inline">
                                    <input type="checkbox" id="isRefund" name="customRadioInline2" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-700 small " for="isRefund">Is Refund</label>
                                </div>

                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-2 ">
                                </div>
                            <div class="col-8 text-center">
                                <button class="btn btn-light btn-sm" type="button" onclick="SendDraftJSONtoPrinter()">cancel</button>
                                <asp:LinkButton ID="btnConvertToInvoice" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClientClick="SendDraftJSONtoPrinter()" OnClick="btnConvertToInvoice_Click1" runat="server" Text="Button"><span class="fas fa-recycle mr-2"></span>Convert</asp:LinkButton>

                            </div>
                            <div class="col-2 ">
                            </div>
                        </div>
             
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="EditInvoiceModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                                            <span class="input-group-text">INV#</span>
                                        </div>
                                        <asp:TextBox ID="txtEdiInvNumber" data-toggle="tooltip" title="INV#" ClientIDMode="Static" placeholder="INV#" class="form-control form-control-sm" runat="server"></asp:TextBox>
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
                            <asp:LinkButton ID="btnDeleteInvoice" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnDeleteInvoice_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
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

        <div class="modal fade " id="DiscountModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-md" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-minus-circle mr-2" style="color: #ff00bb"></span>
                            Manage Discount
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <div class="row mb-3">
                            <div class="col-md-12 ">
                                <label class=" text-gray-900  small font-weight-bold text-uppercase mr-3">[Discount Mode]</label>
                                <div class="custom-control custom-radio custom-control-inline">

                                    <input type="radio" id="no" name="customRadioInline2" class="custom-control-input" checked="true" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label text-gray-900 small font-weight-bold text-uppercase " for="no">No</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="line" name="customRadioInline2" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label font-weight-200  text-gray-900  small font-weight-bold text-uppercase " for="line">Line</label>
                                </div>
                                <div class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" id="transactional" name="customRadioInline2" class="custom-control-input" runat="server" clientidmode="Static" />
                                    <label class="custom-control-label font-weight-200  text-gray-900  small font-weight-bold text-uppercase " for="transactional">Total</label>
                                </div>
                            </div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-12">
                                <asp:DropDownList ID="ddlDiscountApplied" ClientIDMode="Static" class="form-control form-control-sm" runat="server">
                                    <asp:ListItem>After Tax</asp:ListItem>
                                    <asp:ListItem>Before Tax</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnSaveDiscountOption" class="btn btn-sm text-white" Style="background-color: #d46fe8" runat="server" OnClick="btnSaveDiscountOption_Click"><span class="fas fa-save mr-2"></span>Save</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            $(document).ready(function () {
                var totalAmount1 = document.getElementById("<%=totalAmount.ClientID%>");
                var creditAmount = document.getElementById("<%=creditAmount.ClientID%>");
                var itemCountSummary = document.getElementById("<%=itemCountSummary.ClientID%>");

                totalAmount1.innerText = document.getElementById("<%=Total.ClientID%>").innerHTML;
                creditAmount.innerText = document.getElementById("<%=credittotal.ClientID%>").innerText;
                itemCountSummary.innerText = Number(document.getElementById("attachmentTable").rows.length) - 1;

            });
        </script>
        <script type="text/javascript">
            function ShowRefund() {
                var createInvoiceSpan = document.getElementById("<%= createInvoiceSpan.ClientID%>");
                var createInvoiceIcon = document.getElementById("<%= createInvoiceIcon.ClientID%>");

                createInvoiceSpan.innerHTML = "Create Refund";
                createInvoiceIcon.className = "fas fa-reply mr-2";
            }
        </script>

        <script type="text/javascript">
            $('#advancedSearch').click(function () {
                var h = document.getElementById("customerDiv");
                if (h.style.display === "none") {
                    h.style.display = "block";
                    h.className = "row mb-3";
                } else {
                    h.style.display = "none";
                }
                //For Invoice Type Number
                var y = document.getElementById("invoiceDiv");
                if (y.style.display === "none") {
                    y.style.display = "block";
                } else {
                    y.style.display = "none";
                }
            });
        </script>
        <script type="text/javascript">
            $('#transactional').click(function () {
                
                $("#ddlDiscountApplied").toggle(true);
            });
            $('#no').click(function () {
                $("#ddlDiscountApplied").toggle(false);
            });
            $('#line').click(function () {
                $("#ddlDiscountApplied").toggle(false);
            });
        </script>
        <script type="text/javascript">
            $('#refund').click(function () {
                x = document.getElementById("<%=ddlINVnumber.ClientID%>");
                if (x.style.display === "none") {
                    $("#ddlINVnumber").toggle(true);
                    document.getElementById("refundTable").style.display = "block";
                } else {
                    $("#ddlINVnumber").toggle(false);
                    document.getElementById("refundTable").style.display = "none";
                }
              
            });
            $('#paid').click(function () {
                $("#txtCreditAmount").toggle(false);
            });
            $('#credit').click(function () {
                $("#txtCreditAmount").toggle(true);
            });
            $('#ddlINVnumber').change(function () {
                if ($("#ddlINVnumber option:selected").text() == "-Select Invoice Number-") {
                    document.getElementById("refundTable").style.display = "none";
                }
                else {
                    GetRefundData();
                    document.getElementById("refundTable").style.display = "block";
                }
            });
            function GetRefundData() {
                PageMethods.GetRefundResult($("#ddlINVnumber option:selected").text(), returnVales)
            }
            function returnVales(result) {
                document.getElementById("<%=refundReceiptNo.ClientID%>").innerText = result[0];
                document.getElementById("<%=refundDateTime.ClientID%>").innerText = result[1];
                document.getElementById("<%=refundMemory.ClientID%>").innerText = result[2];

            }
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
            function bindCustomer() {
                PageMethods.GetCustomerInfo($("#ddlExistingCustomer option:selected").text(), Success, Failure);

            }
            function Success(result) {
                $("[id*=txtTINNumber]").val(result[0]);
                $("[id*=txtAddress]").val(result[1]);
                $("[id*=txtCustomerName]").val($("#ddlExistingCustomer option:selected").text());
                $('#ExistingCustomerModal').modal('hide');
                $('#ModalCreateInvoice').modal('show');
            }
            function Failure(error) {
                alert(error);
            }
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
                header1.className = " bg-light text-gray-500";
                header2.className = " bg-light text-gray-500";
                header3.className = " bg-light text-gray-500";
                header4.className = "text-right bg-light mall text-gray-500";
            });
        </script>
        <script type="text/javascript">

            function GetTax() {
                PageMethods.GetItemRate($("#ddlItemName option:selected").text(), Success2);
            }
            function Success2(result) {
                let isChecked = $('#line').is(':checked');
                if (isChecked == true) {
                    if ($("#ddlLineDiscountType option:selected").text() == "ETB") {
                        var discount = $("[id*=txtDiscountLine]").val();
                    }
                    else {
                        var unitPrice = $("[id*=txtUnitPrice]").val();
                        var quantity = $("[id*=txtQuantity]").val();
                        var totalPrice = unitPrice * quantity
                        var discount = (Number($("[id*=txtDiscountLine]").val()) / 100) * unitPrice;
                    }
                }
                else
                    var discount = 0;
                var totalDiscount = $("[id*=txtTotalDiscount]").val(Number($("[id*=txtTotalDiscount]").val()) + Number(discount));
                var unitPrice = Number($("[id*=txtUnitPrice]").val()) - Number(discount);
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
                DiscountMode();

            }
            function DiscountMode() {
                PageMethods.GetDiscountAppliedMode(Success5, Error);
            }
            function Success5(result) {
                let isChecked = $('.transactional').is(':checked');
                if (isChecked == true) {
                    if (result == "After Tax") {
                        var tot = document.getElementById("<%=GrandTotal.ClientID %>");
                        tot.innerHTML = (Number(tot.innerHTML) - $("[id*=txtDiscount]").val()).toFixed(2);
                    }
                    else {
                        var tot = document.getElementById("<%=GrandTotal.ClientID %>");
                        tot.innerHTML = (Number(tot.innerHTML) - $("[id*=txtDiscount]").val()).toFixed(2);
                    }
                }
            }
            function Error(error) {
                alert(error);
            }
            function AddTable() {
                var itemCount = document.getElementById("<%=itemCount.ClientID %>");
                itemCount.innerHTML = Number(itemCount.innerHTML) + 1;
                let isChecked = $('#line').is(':checked');
                if (isChecked == true) {
                    if ($("#ddlLineDiscountType option:selected").text() == "ETB") {
                        var discount = $("[id*=txtDiscountLine]").val();
                    }
                    else {
                        var unitPrice = $("[id*=txtUnitPrice]").val();
                        var quantity = $("[id*=txtQuantity]").val();
                        var totalPrice = unitPrice * quantity
                        var discount = (Number($("[id*=txtDiscountLine]").val()) / 100) * unitPrice;
                    }
                }
                else
                    var discount = 0;
                var table = document.getElementById("myTable");
                var row = table.insertRow(1);
                var cell1 = row.insertCell(0);
                var cell2 = row.insertCell(1);
                var cell3 = row.insertCell(2);
                var cell4 = row.insertCell(3);
                
                // Add some text to the new cells:
                cell1.innerHTML = $("#ddlItemName option:selected").text()+ "<br/>" + $("[id*=txtDescription]").val();
                cell2.innerHTML = $("[id*=txtQuantity]").val();

                var unitPrice = Number($("[id*=txtUnitPrice]").val()) - Number(discount);
                var quantity = $("[id*=txtQuantity]").val();
                var totalPrice = (unitPrice * quantity).toFixed(2);
                cell3.innerHTML = unitPrice;
                cell4.innerHTML = totalPrice;
                cell4.className = "text-right";
                GetTax();
            }
        </script>
        <script type="text/javascript">
            function CreateSale() {
                var customerName = $("[id*=txtCustomerName]").val();
                var itemName = $("#ddlItemName option:selected").text();
                var referenceNumber = $("[id*=txtReferenceNumber]").val();
                var date = $("[id*=txtDate]").val();
                var unit = "";
                var salePrice = $("[id*=txtUnitPrice]").val();
                var saleDescription = $("[id*=txtDescription]").val();
                var quantity = $("[id*=txtQuantity]").val();
                var totalAmount = document.getElementById("<%=GrandTotal.ClientID %>").innerHTML;
                var balance = $("[id*=txtCreditAmount]").val();
                var invoiceNumber = document.getElementById("<%=invoiceSpan.ClientID %>").innerHTML;
                var fsno = $("[id*=txtFSnumber]").val();
                var tin = $("[id*=txtTINNumber]").val();
                if ($("#ddlBankAccount option:selected").text() != "-Select-")
                    var paymentMode = "Bank";
                else
                    var paymentMode = "Cash";
                var address = $("[id*=txtAddress]").val();
                var bankName = $("#ddlBankAccount option:selected").text();

                let isChecked = $('#line').is(':checked');
                if (isChecked == true) {
                    if ($("#ddlLineDiscountType option:selected").text() == "ETB") {
                        var discount = $("[id*=txtDiscountLine]").val();
                    }
                    else {
                        var unitPrice = $("[id*=txtUnitPrice]").val();
                        var quantity = $("[id*=txtQuantity]").val();
                        var totalPrice = unitPrice * quantity
                        var discount = (Number($("[id*=txtDiscountLine]").val()) / 100) * unitPrice
                    }
                }
                else
                    var discount = 0;
                PageMethods.CreateInvoice($("[id*=txtCustomerName]").val(), $("#ddlItemName option:selected").text(), $("[id*=txtReferenceNumber]").val(), $("[id*=txtDate]").val(),
                    "", $("[id*=txtUnitPrice]").val() - Number(discount), $("[id*=txtDescription]").val(), $("[id*=txtQuantity]").val(), (Number($("[id*=txtUnitPrice]").val()) - Number(discount)) * Number($("[id*=txtQuantity]").val()), $("[id*=txtCreditAmount]").val(),
                    document.getElementById("<%=invoiceSpan.ClientID %>").innerHTML, $("[id*=txtFSNumber]").val(), $("[id*=txtTINNumber]").val(), paymentMode, $("[id*=txtAddress]").val(), $("#ddlBankAccount option:selected").text(), discount);
            }
        </script>
        <script>
            function UpdateOpacity1() {

                PageMethods.UpdateOpacity(document.getElementById("<%=lblOpacity.ClientID%>").innerText);
            }
        </script>
        <script>
            $(document).ready(function () {
                var txtAm = document.getElementById("<%=lblOpacity.ClientID%>");
                var slider = document.getElementById("customRange5");
                slider.value = txtAm.innerText;
            });
        </script>


        <script type="text/javascript">
            //Discount amount to percentage converter
            function RemoveDescription(text) {
                var indexOfNewLine = text.indexOf("\n");
                text = text.substring(0, indexOfNewLine)
                return text;
            }
            function ConvertToPercentage() {
                var percenteDiscount = 0;
                var initalRate = $("#txtUnitPrice").val();
                var discount = $("#txtDiscountLine").val();
                var finalRate = initalRate - discount;
                if ($("#ddlLineDiscountType option:selected").text() == "ETB") {
                    percenteDiscount = (((initalRate - finalRate) / initalRate) * 100).toFixed(2);
                }
                else {
                    percenteDiscount = $("#txtDiscountLine").val();

                }
                alert(percenteDiscount);
            }
            function BindDiscount() {

            }
            //Record Receipt Response[receipt no, datetime, fiscalmemoryno]
            function RecordReceiptResponse(invoiceNumber, receiptNo, datetime, fiscalMemoryNo) {
                PageMethods.RecordReceiptInfo(invoiceNumber, receiptNo, datetime, fiscalMemoryNo);
            }

            function RemoveCurlBrace(text) {
                text = text.substring(0, text.length - 1);
                text = text.substring(1, text.length);
                return text;
            }
            //Methods for retriving Refund
            function GetRefundInfo() {
                PageMethods.GetRefundResult(document.getElementById("<%= invoiceSpan.ClientID%>"), refundValue);
            }
            var refundCheckBox = document.getElementById("<%= refund.ClientID%>")
            function GetRefundValue() {
                var refundJsonData = "";
                if (refundCheckBox.checked == true) {
                    refundJsonData += RemoveCurlBrace(JSON.stringify({
                        Reversal: {
                            RevrsalType: "Refund",
                            ReceiptNo: document.getElementById("<%=refundReceiptNo.ClientID%>").innerText,
                            ReceiptDateTime: document.getElementById("<%=refundDateTime.ClientID%>").innerText,
                            FiscalMemoryNo: document.getElementById("<%=refundMemory.ClientID%>").innerText
                        }
                    }));
                    refundJsonData += ",";
                }
                return refundJsonData;
            }
            //End Retriving
            function UniqueSaleNumberGenerator() {
                var printerId = document.getElementById("<%=printerId.ClientID%>");
                var firstLetters = printerId.innerHTML;
                var operatorCode = "0001";
                var lastSerialNumber = $("[id*=txtFSNumber]").val();
                var uniqueSaleNumber = firstLetters + "-" + operatorCode + "-" + lastSerialNumber;
                return uniqueSaleNumber;
            }
            function BindRefund() {
                var refundJsonValue = "";
                var createInvoiceSpan = document.getElementById("<%= createInvoiceSpan.ClientID%>");
                if (createInvoiceSpan.innerHTML == "Create Refund") {
                    refundJsonValue = GetRefundInfo();
                }
                return refundJsonValue;
            }
            function IterateDraftItemLine() {
                //Item Count
                let jsonData = "";
                var table2 = document.getElementById("attachmentTable");
                for (var i = 1; i < table2.rows.length; i++) {
                    jsonData += "{";
                    jsonData += RemoveCurlBrace(JSON.stringify({ ItemName: table2.rows[i].cells[1].innerText })) + ",";
                    jsonData += RemoveCurlBrace(JSON.stringify({ Price: Number(table2.rows[i].cells[2].innerText) })) + ",";
                    jsonData += RemoveCurlBrace(JSON.stringify({ TaxGroup: Number("1") })) + ",";
                    jsonData += RemoveCurlBrace(JSON.stringify({ Quantity: Number(table2.rows[i].cells[3].innerText) }));
                    jsonData += "},";
                }
                return jsonData;
            }
            function IterateItemLine() {
                //Item Count
                let jsonData = "";
                var table = document.getElementById("myTable");
                var itemCounts = Number(document.getElementById("<%=itemCount.ClientID %>").innerText)
                for (var i = 1; i < itemCounts + 1; i++) {
                    jsonData += "{";
                    jsonData += RemoveCurlBrace(JSON.stringify({ ItemName: RemoveDescription(table.rows[i].cells[0].innerText) })) + ",";
                    jsonData += RemoveCurlBrace(JSON.stringify({ Price: Number(table.rows[i].cells[3].innerText) })) + ",";
                    jsonData += RemoveCurlBrace(JSON.stringify({ TaxGroup: Number("1") })) + ",";
                    jsonData += RemoveCurlBrace(JSON.stringify({ Quantity: Number(table.rows[i].cells[2].innerText) }));
                    jsonData += "},";
                }
                return jsonData;
            }

            //JSON Input without surcharge and discount
            function AddJson() {
                //Getting the amount paid for the invoice
                //Amount Paid = Total - Credit
                var totalAmount = document.getElementById("<%=GrandTotal.ClientID %>");
                var creditAmount = document.getElementById("<%=credittotal.ClientID %>");
                var paymentAmount = Number(totalAmount.innerText) - creditAmount.innerText;
                const headerJsonData = RemoveCurlBrace(JSON.stringify({
                    ReceiptType: 1, //1 for Sale type
                    Operator: {
                        Code: "1",
                        Name: "Abel",
                        Password: "*******"
                    },
                    uniqueSaleNumber: UniqueSaleNumberGenerator()
                }));
                var bodyJsonData = RemoveCurlBrace(JSON.stringify({
                    Rows: []
                }));
                bodyJsonData = bodyJsonData.substring(0, 8);
                bodyJsonData += IterateItemLine().substring(0, IterateItemLine().length - 1) + ",";
                bodyJsonData += JSON.stringify({
                    Amount: Number(paymentAmount.toFixed(2)),
                    PaymentType: 1 //1 for cash sale
                });
                bodyJsonData += "]";
                var jsonData = "{" + headerJsonData + "," + GetRefundValue() + bodyJsonData + "}";
                return jsonData;
            }
            //JSON with surcharge and without discount
            function AddJsonDraft() {
                //Getting the amount paid for the invoice
                //Amount Paid = Total - Credit

                var totalAmount = document.getElementById("<%=Total.ClientID %>");
                var creditAmount = document.getElementById("<%=credittotal.ClientID %>");
                var paymentAmount = Number(totalAmount.innerText) - creditAmount.innerText;
                const headerJsonData = RemoveCurlBrace(JSON.stringify({
                    ReceiptType: 1, //1 for Sale type
                    Operator: {
                        Code: "1",
                        Name: "Abel",
                        Password: "*******"
                    },
                    uniqueSaleNumber: UniqueSaleNumberGenerator()
                }));
                var bodyJsonData = RemoveCurlBrace(JSON.stringify({
                    Rows: []
                }));
                bodyJsonData = bodyJsonData.substring(0, 8);
                bodyJsonData += IterateDraftItemLine().substring(0, IterateDraftItemLine().length - 1) + ",";
                bodyJsonData += JSON.stringify({
                    Amount: Number(paymentAmount.toFixed(2)),
                    PaymentType: 1 //1 for cash sale
                });
                bodyJsonData += "]";
                var jsonData = "{" + headerJsonData + "," + bodyJsonData + "}";
                return jsonData;
            }
            //Post and Receive information from the fiscal printer when create Invoice
            function SendJSONtoPrinter() {
                var printerId = document.getElementById("<%=printerId.ClientID%>");
                var uri = 'http://localhost:3000/printers/' + printerId.innerText + '/receipt';
                var json = AddJson();
                $.ajax({
                    type: "POST",
                    url: uri,
                    data:json,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //recording the response json
                        RecordReceiptResponse(document.getElementById(
                            "<%=invoiceSpan.ClientID %>").innerHTML
                            , response.ReceiptNo
                            , response.ReceiptDateTime
                            , response.FiscalMemoryNo);
                    },
                    error: function (error) {
                        alert("Couldn't connect to the printer");
                    }
                });
            }
            //Post and Receive Drafted Item from the fiscal printer when create Invoice
            function SendDraftJSONtoPrinter() {
                var printerId = document.getElementById("<%=printerId.ClientID%>");
                var uri = 'http://localhost:3000/printers/' + printerId.innerHTML + '/receipt';
                var json = AddJsonDraft();
                $.ajax({
                    type: "POST",
                    url: uri,
                    data:json,
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        //recording the response json
                        RecordReceiptResponse(document.getElementById(
                            "<%=invoiceSpan.ClientID %>").innerHTML
                            , response.ReceiptNo
                            , response.ReceiptDateTime
                            , response.FiscalMemoryNo);
                    },
                    error: function (error) {
                        alert("Couldn't connect to the printer");
                    }
                });
            }
        </script>
        <script>
            $(document).ready(function () {
                GetFSNumberConfig();
            });
            function GetFSNumberConfig() {
                PageMethods.GetFSnumberSetings(GetFSNumbersettingsValue);
            }
            function GetFSNumbersettingsValue(result) {
                if (result[0] == "True") {
                    if (result[1] == "True") {
                        var SerialNo = document.getElementById("<%=printerId.ClientID%>");

                        var deviceReceiptNo = document.getElementById("<%=txtFSNumber.ClientID%>");
                        $(document).ready(function () {
                            var uri = 'http://localhost:3000/printers/' + SerialNo.innerText;
                            $.getJSON(uri)
                                .done(function (data) {
                                    $("[id*=txtFSNumber]").val(String(Number(data.LastReceiptNo) + 1).padStart('8', '0'));
                                    $("[id*=txtDraftFSNumber]").val(String(Number(data.LastReceiptNo) + 1).padStart('8', '0'));
                                })
                        });
                    }
                    else {
                        PageMethods.BindFSnumber(GetFSNumberValues);
                        function GetFSNumberValues(result) {
                            $("[id*=txtFSNumber]").val(String(Number(result)).padStart('8', '0'));
                            $("[id*=txtDraftFSNumber]").val(String(Number(result)).padStart('8', '0'));
                        }
                    }
                }
                else {
                    if (result[1] == "True") {
                        var SerialNo = document.getElementById("<%=printerId.ClientID%>");

                        var deviceReceiptNo = document.getElementById("<%=txtFSNumber.ClientID%>");
                        $(document).ready(function () {
                            var uri = 'http://localhost:3000/printers/' + SerialNo.innerText;
                            $.getJSON(uri)
                                .done(function (data) {
                                    $("[id*=txtFSNumber]").val(Number(data.LastReceiptNo) + 1);
                                    $("[id*=txtDraftFSNumber]").val(Number(data.LastReceiptNo) + 1);
                                })
                        });
                    }
                    else {
                        PageMethods.BindFSnumber(GetFSNumberValues);
                        function GetFSNumberValues(result) {
                            $("[id*=txtFSNumber]").val(String(Number(result)).padStart('0', '0'));
                            $("[id*=txtDraftFSNumber]").val(String(Number(result)).padStart('0', '0'));;
                        }
                    }
                }
            }
        </script>
    </div>
</asp:Content>
