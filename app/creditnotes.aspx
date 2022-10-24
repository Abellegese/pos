<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="creditnotes.aspx.cs" Inherits="pos.app.creditnotes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Credit Notes</title>
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
                                <a class="btn btn-circle btn-sm text-white btn-light mr-2" id="buttonback" href="creditnotes.aspx" visible="false" runat="server" data-toggle="tooltip" data-placement="bottom" title="Back to Credit">

                                    <span class="fa fa-arrow-left text-gray-600"></span>

                                </a>
                                <span class="badge mr-2 text-white badge-light text-gray-600 font-weight-bold" visible="false" id="creditDetailSpan" runat="server"></span>
                                <span class="badge mr-2 text-white text-white font-weight-bold" visible="false" id="creditStatusSpan" runat="server"></span>

                                <span class="fas fa-notes-medical mr-2" style="color: #d46fe8" id="creditIconSpan" runat="server"></span><span id="creditsSpan" class="small text-gray-900 font-weight-bold text-uppercase" runat="server">credit notes</span>

                            </div>
                            <div class="col-md-8 text-right">
                                <div class="dropdown no-arrow">
                                    <button type="button" visible="true" runat="server" id="btnReceiveCredits" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#RecieveCreditModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Receieve Credit" class="fas fa-hand-holding-usd text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="true" runat="server" id="btnSendEmail" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#ModalCreateInvoice">
                                        <div>
                                            <i data-toggle="tooltip" title="Send Email" class="fas fa-envelope text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>
                                    <button type="button" visible="true" runat="server" id="btnDelete" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#DeleteCreditModal">
                                        <div>
                                            <i data-toggle="tooltip" title="Delete Credit" class="fas fa-trash text-gray-600 font-weight-bold"></i>
                                            <span></span>
                                        </div>
                                    </button>

                                    <button type="button" visible="true" runat="server" id="btnEdit" class="mr-1 btn btn-light btn-sm" data-toggle="modal" data-target="#EditCreditModal">
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
         
                    <div class="card-body small text-gray-900" style="margin-top:-21px" id="creditDiv" runat="server">
                        <asp:Repeater ID="rptrCredit" runat="server">

                            <HeaderTemplate>
                                <table class="table align-items-center table-hover table-sm ">
                                    <thead>
                                        <tr>

                                            <th scope="col" class="text-gray-900 text-uppercase text-left">Date</th>
                                            <th scope="col" class="text-warning text-uppercase ">CN#</th>
                                            <th scope="col" class="text-warning text-uppercase ">Trans#</th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Customer </th>
                                            <th scope="col" class="text-gray-900 text-uppercase ">Credit Type </th>
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
                                        <a class=" text-warning  " href="creditnotes.aspx?cid=<%# Eval("id")%>&&invno=<%# Eval("invoice_or_bill_number")%>"><span>CN#-00000<%# Eval("id")%></span></a>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("invoice_or_bill_number")%>'></asp:Label>
                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="lblCustomer" runat="server" Text='<%# Eval("customer_or_vendor")%>'></asp:Label>
                                    </td>

                                    <td class="text-gray-900">
                                        <asp:Label ID="Label2" runat="server" Text='<%# Eval("credit_type")%>'></asp:Label>
                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="Label4" runat="server" Text='<%# Eval("total_amount" , "{0:N2}")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900">
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("balance" , "{0:N2}")%>'></asp:Label>

                                    </td>
                                    <td class="text-gray-900 text-right">
                                        <span class="badge badge-success">PAID</span>
                                    </td>

                                </tr>

                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                  </table>
                            </FooterTemplate>

                        </asp:Repeater>

                    </div>

                    <div class="card-body" id="creditDetailDiv" runat="server" visible="false">
                        <div class="row">
                            <div class="col-4 border-right" style="margin-top: -21px">
                                <asp:Repeater ID="rptCreditNotesDetail" runat="server">

                                    <HeaderTemplate>
                                        <table class="table align-items-center table-hover table-sm ">

                                            <tbody>
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <tr class="border-bottom">

                                            <td>
                                                <asp:Label ID="Label3" class="text-gray-900 text-uppercase" runat="server" Text='<%# Eval("customer_or_vendor")%>'></asp:Label>
                                                <a class=" text-primary  " href="creditnotes.aspx?cid=<%# Eval("id")%>"><span>CN#-<%# Eval("id")%></span></a>
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
                                    <div class="row">
                                        <div class="col-1">
                                        </div>
                                        <div class="col-10">
                                            <div class="row ">
                                                <div class="col-md-8 text-left">
                                                    <asp:Repeater ID="rptrLogo" runat="server">
                                                        <ItemTemplate>
                                                            <img class="" src='<%# Eval("logo")%>' height="60" width="60" alt="" id="LogoImage" runat="server" />
                                                        </ItemTemplate>

                                                    </asp:Repeater>
                                                    <div class="row ">
                                                        <div class="col-md-6 text-left">
                                                            <span translate="no" class="h6 text-gray-900 text-uppercase border-bottom border-top border-dark font-weight-bold" id="oname" runat="server"></span>
                                                            <br />
                                                            <span translate="no" class="text-xs text-gray-900 text-uppercase border-bottom font-weight-bold" id="oAddress" runat="server"></span>

                                                        </div>
                                                        <div class="col-md-6 text-right">
                                                            <span translate="no" class="small text-gray-900 font-weight-bold" id="datecurrent" runat="server"></span>
                                                        </div>
                                                    </div>
                                                    <div class="row  ">
                                                        <div class="col-md-12 text-left">
                                                            <span class=" small font-weight-bold text-gray-900 " style="height: 100px">TO: </span><span style="height: 100px" class="h6 mx-2 text-gray-900 font-weight-bold small text-uppercase" id="Name" runat="server"></span>

                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-4 text-right">

                                                    <h3 class="text-gray-900 font-weight-bolder border-bottom border-dark">CREDIT NOTE</h3>
                                                    <h5 class="text-gray-900 font-weight-bold">CN#-<span id="CNNumber" runat="server"></span></h5>
                                                    <h5 class="text-gray-900 font-weight-bold">INV#-<span id="INVNumber" runat="server"></span></h5>
                                                    <h6 class="text-danger font-weight-bold">DUE: ETB<span id="dueAmount" runat="server"></span></h6>

                                                    <h5 id="CreditTitle" class="text-gray-900 text-uppercase border-bottom border-top border-dark font-weight-bold" runat="server"></h5>
                                                </div>

                                            </div>
                                         
                                            <br />
                                            <br />
                                        
                                            <asp:Repeater ID="rptrAttachment" runat="server">

                                                <HeaderTemplate>

                                                    <table class="table align-items-center table-sm small " style="color: black;">
                                                        <thead class="thead-light text-uppercase ">
                                                            <tr>

                                                                <th scope="col" class="">Item Name</th>
                                                                <th scope="col" class="">Decription</th>
                                                                <th scope="col" class=" text-center">Quantity</th>
                                                                <th scope="col" class="text-center">Unit Price</th>


                                                                <th scope="col" class=" text-right">Total Price</th>

                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr class="border-bottom">
                                             
                                                        <td class="text-left"><%# Eval("item_name")%>

                                                        </td>
                                                        <td scope="col" contenteditable="true"><%# Eval("description")%></td>

                                                        <td class="text-center" contenteditable="true">
                                                            <span><%# Convert.ToDouble(Eval("quantity")).ToString("#,##0.00")%></span>
                                                        </td>

                                                        <td class=" text-center" contenteditable="true">
                                                            <span><%# Convert.ToDouble(Eval("unit_price")).ToString("#,##0.00")%></span>

                                                        </td>

                                                        <td class="text-right" contenteditable="true">
                                                            <span><%# Convert.ToDouble(Eval("total_amount")).ToString("#,##0.00")%></span>

                                                        </td>
                                                    </tr>

                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tbody>
                                                   </table>
                                                </FooterTemplate>
                                            </asp:Repeater>
                                            <div class="row" id="TotalRow" runat="server">

                                                <div class="col-md-8 text-left" style="z-index: 2">
                  
                                                </div>

                                                <div class="col-md-4 mt-1" style="z-index: 2; color: black">
                                                    <div class="form-group">
                                                        <table class="table table-sm small" style="color: black">
                                                            <tbody>
                                                                <tr>
                                                                    <td ><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">Sub-Total:</span></td>
                                                                    <td  class="text-right"><span id="subTotal" class=" font-weight-bold " runat="server"></span></td>
                                                                </tr>
                                                                <tr>
                                                                    <td ><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">VAT(15%):</span></td>
                                                                    <td  class="text-right"><span id="vatAmount" class=" font-weight-bold" runat="server"></span></td>
                                                                </tr>

                                                                <tr class="border-bottom bg-light">
                                                                    <td ><span style="margin: 7px 5px 5px 5px; padding: 5px" class="m-0 font-weight-bold text-right">Grand Total:</span></td>
                                                                    <td  class="text-right"><span id="Total" class="font-weight-bold" runat="server"></span></td>
                                                                </tr>
                                                            </tbody>
                                                        </table>

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
                </div>
            </div>
        </div>

        <div class="modal fade " id="DeleteCreditModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-trash mr-2" style="color: #ff00bb"></span>
                            Delete Credit
                        </h5>
                        <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="row mb-3">
                            <div class="col-12 mx-2 border-danger border-left">
                                <span class="fas fa-arrow-alt-circle-right text-danger mr-2"></span>
                                <span class="small text-gray-500">Are You Sure to Delete the Credit?</span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnDeleteInvoice" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnDeleteCredit_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade " id="EditCreditModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-pencil-alt mr-2" style="color: #ff00bb"></span>
                            Edit Credit Info
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
                                            <span class="input-group-text">ETB</span>
                                        </div>
                                        <asp:TextBox ID="txtEditCreditAmount" data-toggle="tooltip" title="Edit Credit Amount" ClientIDMode="Static" placeholder="Credit Amount" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <asp:LinkButton ID="btnSaveEditCreditAmount" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnSaveEditCreditAmount_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade " id="RecieveCreditModal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-sm" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title text-gray-900 h6 font-weight-bold" id="exampleModalLabel"><span class="fas fa-hand-holding-usd mr-2" style="color: #ff00bb"></span>
                            Receive Credit
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
                                            <span class="input-group-text">ETB</span>
                                        </div>
                                        <asp:TextBox ID="txtCreditAmount" data-toggle="tooltip" title="Credit Amount" ClientIDMode="Static" placeholder="Credit Amount" class="form-control form-control-sm" runat="server"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal-footer">
                            <asp:LinkButton ID="btnReceiveCredit" class="btn btn-sm text-white" Style="background-color: #d46fe8" OnClick="btnReceiveCredit_Click" runat="server" Text="Button"><span class="fas fa-arrow-right mr-2"></span>Proceed</asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
