<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="pos.app.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard</title>
    <script src="../asset/js/chart.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid pl-3 pr-2">    
        <asp:ScriptManager ID='ScriptManager1' runat='server' EnablePageMethods='true' />
        <div class="bg-white shadow-none rounded-lg h-100">
            <div class="row">
                <div class="col-xl-12 col-xl-12">

                    <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>
                    <div class="card-body border-bottom">

                        <div class="row">
                            <div class="col-xl-3 col-md-6 mb-2">

                                <div class="bg-white rounded-lg shadow-none border-left-warning border-top border-warning  border-right-warning  h-100 ">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bolder text-primary text-uppercase mb-2">Receivable</div>
                                                <div class="row align-content-center">
                                                    <div class="col-8">
                                                        <div class="h6 mb-0 font-weight-bold text-gray-900"><a href="agedreceivable.aspx" class="text-gray-800"><span id="totalReceivable" runat="server">0.00</span></a></div>
                                                    </div>
                                                    <div class="col-1 text-left">
                                                        <a class="dropdown-toggle btn-sm text-warning font-weight-bolder" onclick="BindReceivables()" href="#" role="button" id="dropdownReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                                        <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in" style="width: 300px" aria-labelledby="dropdownReceivable">
                                                            <center>
                                                                <a class="dropdown-item text-primary" style="font-style: normal" href="#"><span>Aged Receivable Summary</span></a>
                                                            </center>
                                                            <div class="dropdown-divider"></div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-8 text-left"><span class="text-left dropdown-item">AGED 1-30 DAYS</span></div>
                                                                <div class="col-sm-4 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedOne" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-8 text-left"><span class="text-left dropdown-item">AGED 31-60 DAYS</span></div>
                                                                <div class="col-sm-4 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedTwo" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-8 text-left"><span class="text-left dropdown-item">AGED  61-90 DAYS</span></div>
                                                                <div class="col-sm-4 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedThree" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-8 text-left"><span class="text-left dropdown-item">AGED  61-90 DAYS</span></div>
                                                                <div class="col-sm-4 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="receivableAgedFour" runat="server">0.00</span></div>
                                                            </div>
                                                            <center>
                                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Report <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Analytics <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                                            </center>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-dollar-sign text-gray-500 fa-2x "></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6 mb-2">

                                <div class="bg-white rounded-lg shadow-none border-left-warning border-right-primary border-top border-right border-warning  h-100 ">
                                    <div class="card-body">

                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bolder text-primary text-uppercase mb-2">Sales<span class="mx-2 text-xs text-gray-300">Balance</span></div>

                                                <div class="row align-items-center">
                                                    <div class="col-8">
                                                        <div class="h6 mb-0 font-weight-bold text-gray-900"><a class="text-gray-800" href="#"><span id="totalSales" runat="server">0.00</span></a></div>
                                                    </div>
                                                    <div class="col-1 text-left">
                                                        <a class="dropdown-toggle btn-sm text-warning font-weight-bolder" href="#" role="button" id="dropdowSales" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                                        <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in" style="width: 350px" aria-labelledby="dropdowSales">
                                                            <center>
                                                                <a class="dropdown-item text-primary" style="font-style: normal" href="#"><span>Sales Summary</span></a>
                                                            </center>
                                                            <div class="dropdown-divider"></div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">CASH SALE</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanCashSale" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">CREDIT SALE</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanCreditSale" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">REFUND</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanRefund" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">SALES ORDER</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanSalesOrder" runat="server">0</span></div>
                                                            </div>
                                                            <div class="dropdown-divider"></div>

                                                            <center>
                                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Credit List <span class="fas fa-arrow-right ml-2 text-primary"></span></a>
                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Analytics <span class="fas fa-arrow-right ml-2 text-primary"></span></a>
                                                            </center>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-hand-holding-usd text-gray-500 fa-2x"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6 mb-2">
                                <div class="bg-white rounded-lg shadow-none border-left-warning border-top border-warning border-right-danger  h-100 ">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col mr-2">
                                                <div class="text-xs font-weight-bolder text-danger text-uppercase mb-2">Purchase</div>
                                                <div class="row align-content-center">
                                                    <div class="col-8">
                                                        <div class="h6 mb-0 font-weight-bold text-gray-900"><a href="#" class="text-gray-800"><span id="totalPurchases" runat="server">0.00</span></a></div>
                                                    </div>

                                                    <div class="col-1 text-left">
                                                        <a class="dropdown-toggle btn-sm text-warning font-weight-bolder" href="#" role="button" id="drpDownPurchase" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                                        <div class="dropdown-menu  dropdown-menu-right shadow animated--fade-in" style="width: 350px" aria-labelledby="drpDownPurchase">
                                                            <center>
                                                                <a class="dropdown-item text-danger" style="font-style: normal" href="#"><span>Purchase & Inventory Summary</span></a>
                                                            </center>
                                                            <div class="dropdown-divider"></div>

                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">CASH BILL</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanCashBill" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">CREDIT BILL</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanCreditBill" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">PURCHASE ORDER</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanPurchaseOrder" runat="server">0.00</span></div>
                                                            </div>
                                                            <center>
                                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Credit List <span class="fas fa-arrow-right ml-2 text-primary"></span></a>
                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>See Analytics <span class="fas fa-arrow-right ml-2 text-primary"></span></a>
                                                                <div class="dropdown-divider"></div>
                                                                <a class="dropdown-item text-danger" href="creditnote.aspx"><i class="invisible"></i>See Inventory Status <span class="fas fa-arrow-right ml-2 text-danger"></span></a>
                                                            </center>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-chart-pie text-gray-500 fa-2x "></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-3 col-md-6 mb-2">
                                <div class="bg-white rounded-lg shadow-none border-left-warning border-right-warning border-top border-right border-warning  h-100 ">
                                    <div class="card-body">
                                        <div class="row no-gutters align-items-center">
                                            <div class="col">
                                                <div class="text-xs font-weight-bolder text-success text-uppercase text- mb-2">Net Profit</div>
                                                <div class="row align-items-center">
                                                    <div class="col-8">
                                                        <div class="h6 mb-0 font-weight-bold text-gray-900"><a class="text-gray-800"><span id="netProfit" runat="server">0.00</span></a></div>
                                                    </div>
                                                    <div class="col-1 text-left">
                                                        <a class="dropdown-toggle btn-sm text-warning font-weight-bolder" href="#" role="button" id="drpDownProfit" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"></a>
                                                        <div class="dropdown-menu  dropdown-menu-right shadow animated--fade-in" style="width: 400px" aria-labelledby="drpDownProfit">
                                                            <center>
                                                                <a class="dropdown-item text-danger" style="font-style: normal" href="#"><i>From 02-11-2022 to 03-11-2022</i></a>
                                                            </center>
                                                            <div class="dropdown-divider"></div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">TOTAL SALES</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanTotalSales" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">TOTAL PURCHASES</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanTotalPurchase" runat="server">0.00</span></div>
                                                            </div>
                                                            <div class="dropdown-divider"></div>

                                                            <div class="row mb-3">
                                                                <div class="col-sm-6 text-left"><span class="text-left dropdown-item">GROSS PROFIT</span></div>
                                                                <div class="col-sm-6 text-right"><span class="text-uppercase dropdown-item font-weight-bolder text-black text-right" id="spanGrossProfit" runat="server">0.00</span></div>
                                                            </div>
                                                            <center>
                                                                <a class="dropdown-item text-primary" href="creditnote.aspx"><i class="invisible"></i>Calculate Profit <span class="fas fa-arrow-right ml-2 text-primary"></span></a>

                                                            </center>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-auto">
                                                <i class="fas fa-chart-line text-gray-500 fa-2x "></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>

                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">

                    <div class="row" style="height: 370px">
                        <div class="col-lg-8 mx-0 mb-2 border-right">
                            <div class="card-header bg-white ">
                                <div class="row ">
                                    <div class="col-12">

                                        <h6 class="text-xs font-weight-bolder text-primary text-uppercase mb-1">Revenues<span class="mx-2 text-xs text-gray-300 text-uppercase">This Fiscal</span></h6>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body mt-5 mb-2">
                                <main role="main" id="main" runat="server">
                                    <div class="starter-template">
                                        <center>
                                            <p class="lead text-primary">
                                                <span class="fas fa-chart-bar text-gray-300 fa-4x"></span>
                                            </p>
                                            <h6 class="text-gray-300 text-xs" style="font-weight: bold">No Data.</h6>
                                        </center>
                                    </div>
                                </main>
                                <div class="chart">
                                    <asp:Literal ID="ltChart" runat="server"></asp:Literal>
                                </div>
                                <hr />
                                <div>
                                    <span class=" text-gray-500 fas fa-1x fa-info-circle mr-2"></span><span id="info" runat="server" class="small text-gray-500  mb-1">Values are in Thousands</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-4 mb-2">
                            <div class="card-header bg-white py-3 d-flex flex-row align-items-center justify-content-between">
                                <div class="row align-items-center">
                                    <div class="col-12">

                                        <h6 class="text-xs font-weight-bolder text-primary text-uppercase mb-1">Top 5 Sold Items<span class="mx-2 text-xs text-gray-300 text-uppercase">balance</span></h6>
                                    </div>
                                    <div class="col">
                                        <ul class="nav nav-pills justify-content-end">
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body mt-5 mb-2">

                                <main role="main" id="main1" runat="server">

                                    <div class="starter-template">
                                        <center>
                                            <p class="lead text-primary">
                                                <span class="fas fa-chart-pie text-gray-300 fa-4x"></span>
                                            </p>
                                            <h6 class="text-gray-300 text-xs" style="font-weight: bold">No Data.</h6>
                                        </center>
                                    </div>
                                </main>
                                <div class="chart">
                                    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                                </div>
                                <hr />
                                <div>
                                    <span class=" text-gray-500 fas fa-1x fa-info-circle mr-2"></span><span id="Span4" runat="server" class="small text-gray-500  mb-1">Values are in Thousands</span>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            //Retrieving dashboard datas using jquery and js
            $(document).ready(function () {
                BindTotals();
            });
            function BindReceivables() {
                PageMethods.BindReceivables(OnReceivableBinded);
            }
            function OnTotalReceivableBinded(result) {
                document.getElementById("<%=totalReceivable.ClientID%>").innerHTML = result[0];
            }
            function OnReceivableBinded(result) {
                let agedTypeOne, agedTypeTwo, agedTypeThree, agedTypeFour;
                agedTypeOne = result[1];
                agedTypeTwo = result[2];
                agedTypeThree = result[3];
                agedTypeFour = result[4];
                document.getElementById("<%=receivableAgedOne.ClientID%>").innerHTML = agedTypeOne;
                document.getElementById("<%=receivableAgedTwo.ClientID%>").innerHTML = agedTypeTwo;
                document.getElementById("<%=receivableAgedThree.ClientID%>").innerHTML = agedTypeThree;
                document.getElementById("<%=receivableAgedFour.ClientID%>").innerHTML = agedTypeFour;
            }
            function BindTotals() {
                PageMethods.GetTotals("2022-10-03", "2022-11-03", OnTotalBined, OnError);
                PageMethods.BindReceivables(OnTotalReceivableBinded);
            }
            function OnError(error) {
                alert('Error when binded!');
            }
            function OnTotalBined(result) {
                let totalSales, totalPurcahses, netProfit;
                totalSales = result[0];
                totalPurcahses = result[1];
                netProfit = result[2];
                document.getElementById("<%=totalSales.ClientID%>").innerHTML = totalSales;
            document.getElementById("<%=totalPurchases.ClientID%>").innerHTML = totalPurcahses;
            document.getElementById("<%=netProfit.ClientID%>").innerHTML = netProfit;
        }
        </script>
    </div>
    
</asp:Content>
