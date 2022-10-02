<%@ Page Title="" Language="C#" MasterPageFile="~/app/app.Master" AutoEventWireup="true" CodeBehind="dashboard.aspx.cs" Inherits="pos.app.dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard</title>
    <script src="../asset/js/chart.min.js"></script>

    <script type="text/javascript">
        function save() {
            var itemName = $("[id*=txtItemName]").val();
            PageMethods.AddItem(itemName);
            //, shelfNo, barcode, description, purchasePrice
            //, salePrice, unit, sku, amountPerSKU
            //, manufacturer, reorderPoint, tax);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid pl-3 pr-2" style="position: relative;">
        <asp:ScriptManager ID='ScriptManager1' runat='server' EnablePageMethods='true' />


        <div class="bg-white rounded-lg" id="div_print">
            <div class="row mx-2 border-bottom">


                <div class="col-xl-3 mb-2 mt-2 border-right ">
                    <div class="row">
                        <div class="col-8 text-left">
                            <span class="small font-weight-bold text-gray-900 mx-1 mt-2"><button class="btn btn-sm btn-circle mr-2" style="background-color: #c24599"><span class="fas fa-cart-plus text-white"></span></button>Sales Summay</span>
                        </div>


                        <div class="col-4  text-right ">
                            <div class="dropdown no-arrow">
                                <button type="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn mt-1 mb-1 btn-circle btn-sm btn-light">
                                    <span data-toggle="tooltip" title="Action" class="fas fa-caret-down" style="color:#ff6a00"></span>


                                </button>


                                <div class="dropdown-menu  dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                    <div class="dropdown-header text-gray-900">Option:</div>
                                   

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row border-top">
                        <div class="col-xl-10 mx-2">

                            <canvas id="myCharta" class="mt-3"></canvas>

                        </div>

                    </div>
                    <div class="card-bod mt-5">
                        <div class="row">
                            <div class="col-6">
                                <span class="fas fa-hand-holding-usd text-left mr-2" style="color:#a323de"></span><span class=" dropdown-toggle btn-sm  small" href="#" role="button" id="drpReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Receivable</span>

                                <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in text-center" aria-labelledby="drpReceivable">
                                </div>
                                </div>
                            <div class="col-6 text-right">
                                <span class="text-gray-900 font-weight-bold  small">156,200</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 mb-2 mt-2 border-right ">
                    <div class="row">
                        <div class="col-8 text-left">
                            <span class="small font-weight-bold text-gray-900 mx-1 mt-2">
                                <button class="btn btn-sm btn-circle mr-2" style="background-color: #c24599"><span class="fas fa-ambulance text-white"></span></button>
                                Purchase Summay</span>
                        </div>


                        <div class="col-4  text-right ">
                            <div class="dropdown no-arrow">
                                <button type="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn mt-1 mb-1 btn-circle btn-sm btn-light">
                                    <span data-toggle="tooltip" title="Action" class="fas fa-caret-down" style="color: #ff6a00"></span>


                                </button>


                                <div class="dropdown-menu  dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                    <div class="dropdown-header text-gray-900">Option:</div>


                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row border-top">
                        <div class="col-xl-10 mx-2">

                            <canvas id="myChartd" class="mt-3"></canvas>

                        </div>

                    </div>
                    <div class="card-bod mt-5">
                        <div class="row">
                            <div class="col-6">
                                <span class="fas fa-donate text-left mr-2" style="color: rgba(255, 26, 104, 1)"></span><span class=" dropdown-toggle btn-sm  small" href="#" role="button" id="drpReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Payable</span>

                                <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in text-center" aria-labelledby="drpReceivable">
                                </div>
                            </div>
                            <div class="col-6 text-right">
                                <span class="text-gray-900 font-weight-bold  small">152,200</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 mb-2 mt-2 border-right ">
                    <div class="row">
                        <div class="col-8 text-left">
                            <span class="small font-weight-bold text-gray-900 mx-1 mt-2">
                                <button class="btn btn-sm btn-circle mr-2" style="background-color: #c24599"><span class="fas fa-chart-line text-white"></span></button>
                                Business Status</span>
                        </div>


                        <div class="col-4  text-right ">
                            <div class="dropdown no-arrow">
                                <button type="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn mt-1 mb-1 btn-circle btn-sm btn-light">
                                    <span data-toggle="tooltip" title="Action" class="fas fa-caret-down" style="color: #ff6a00"></span>


                                </button>


                                <div class="dropdown-menu  dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                    <div class="dropdown-header text-gray-900">Option:</div>


                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row border-top border-bottom">
                        <div class="col-xl-10 mx-2">

                            <canvas id="myChartc" class="mt-3"></canvas>

                        </div>

                    </div>
                    <div class="card-bod mt-5">
                        <div class="row">
                            <div class="col-6">
                                <span class="fas fa-chart-bar text-left mr-2" style="color: rgba(255, 26, 104, 1)"></span><span class=" dropdown-toggle btn-sm  small" href="#" role="button" id="drpReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Profit</span>

                                <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in text-center" aria-labelledby="drpReceivable">
                                </div>
                            </div>
                            <div class="col-6 text-right">
                                <span class="text-gray-900 font-weight-bold  small">152,200</span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xl-3 mb-2 mt-2 border-right ">
                    <div class="row">
                        <div class="col-8 text-left">
                            <span class="small font-weight-bold text-gray-900 mx-1 mt-2">
                                <button class="btn btn-sm btn-circle mr-2" style="background-color: #c24599"><span class="fas fa-tablets text-white"></span></button>
                                Stocks</span>
                        </div>


                        <div class="col-4  text-right ">
                            <div class="dropdown no-arrow">
                                <button type="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="btn mt-1 mb-1 btn-circle btn-sm btn-light">
                                    <span data-toggle="tooltip" title="Action" class="fas fa-caret-down" style="color: #ff6a00"></span>


                                </button>


                                <div class="dropdown-menu  dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                                    <div class="dropdown-header text-gray-900">Option:</div>
                                    <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#createNewIteModal" id="A2" runat="server"><span class="fas fa-plus mr-2 " style="color: #d46fe8"></span>Create New Item</a>
                                    <a href="#" class="dropdown-item  text-gray-900  text-danger" data-toggle="modal" data-target="#ModalReference" id="LR" runat="server"><span class="fas fa-filter mr-2 " style="color: #d46fe8"></span>Filter Letter Record</a>


                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row border-top">
                        <div class="col-xl-10 mx-2">

                            <canvas id="myChartb" class="mt-3"></canvas>

                        </div>

                    </div>
                    <div class="card-bod mt-5">
                        <div class="row">
                            <div class="col-6">
                                <span class="fas fa-cart-plus text-left mr-2" style="color: rgba(255, 26, 104, 1)"></span><span class=" dropdown-toggle btn-sm  small" href="#" role="button" id="drpReceivable" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Balance</span>

                                <div class="dropdown-menu  dropdown-menu-left shadow animated--fade-in text-center" aria-labelledby="drpReceivable">
                                </div>
                            </div>
                            <div class="col-6 text-right">
                                <span class="text-gray-900 font-weight-bold  small">200</span>
                            </div>
                        </div>
                    </div>
                </div>
                

            </div>
            <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label>


            <div class="row ">
                <div class="col-12">

                    <div class="row">
                        <div class="col-lg-4 mx-0 border-right">


                        </div>

                        <div class="col-lg-8 mb-2 ">


                        </div>
                    </div>



                </div>

            </div>

        </div>
        
    </div>

    <script>
        // setup 
        var data = {
            labels: ['Total Sales', 'Unpaid'],
            datasets: [{
                label: 'Weekly Sales',
                data: [18, 12],

                borderWidth: 1
            }]
        };

        const centerText = {
            id: 'centerText',
            afterDatasetsDraw(chart, args, options) {
                const { ctx, chartArea: { left, right, top, bottom, width, height } } =
                    chart;
                ctx.save();
                console.log(top);
                ctx.font = "normal 25px Corbel Light";
                ctx.fillStyle = 'rgba(170, 178, 190)';
                ctx.textAlign = 'center';
                ctx.fillText('sales', width / 2, height / 2 + 13);
            }
        }

        // config 
        const config = {
            type: 'doughnut',
            data,
            options: {
                circumference: 180,
                aspectRatio: 2,
                rotation: 270,
                cutout: '85%',
                borderRadius:0,
                backgroundColor: [
                    'rgb(0, 200, 42)',
                    '#9017c1'
                ],
                plugins: {
                    legend: { display: false }
                }
            },
            plugins: [centerText]
        };

        // render init block
        const myChart = new Chart(
            document.getElementById('myCharta'),
            config
        );
    </script>
    <script>
        // setup 


        const gaugeNeedle = {
            id: 'gaugeNeedle',
            afterDatasetsDraw(chart, args, options) {
                const { ctx, chartArea: { left, right, top, bottom, width, height } } =
                    chart;
                ctx.save();
                console.log(data)
                const needleValue = data.datasets[0].needleValue;
                const dataTotal = data.datasets[0].data.reduce((a, b) => a + b, 0);
                const angle = Math.PI + (1 / dataTotal * needleValue * Math.PI);

                const cx = width / 2;
                const cy = chart._metasets[0].data[0].y;
                console.log(chart._metasets[0].data[0].y);

                //needle
                ctx.translate(cx, cy);
                ctx.rotate(angle);
                ctx.beginPath();
                ctx.moveTo(0, -2);
                ctx.lineTo(20, -110);
                ctx.lineTo(0, 2);
                ctx.fillStyle = 'rgb(212, 196, 44)';
                ctx.fill();
                //needle dot
                ctx.translate(-cx, -cy);
                ctx.beginPath();
                ctx.arc(cx, cy, 5, 0, 10);
                ctx.fill();
                ctx.restore();
            }
        }

        // config 
        const configb = {
            type: 'doughnut',
            data,
            options: {
                circumference: 180,
                aspectRatio: 2,
                rotation: 270,
                cutout: '85%',
                borderRadius: 5,
                backgroundColor: [
                    'rgb(212, 196, 44)',
                    'rgb(212, 196, 44)',
                    'rgb(212, 196, 44)',
                    'rgb(212, 196, 44)'
                ],
                plugins: {
                    legend: { display: false }
                }
            },
            plugins: [gaugeNeedle]
        };

        // render init block
        const myChartb = new Chart(
            document.getElementById('myChartb'),
            configb
        );
    </script>
    <script>
        // setup 
        var datac = {
            labels: ['Mon', 'Tue', 'Wed', 'Thu'],
            datasets: [{
                label: 'Weekly Sales',
                data: [300, 12, 6, 9],
                borderWidth: 1
            }]
        };

        const centerTextc = {
            id: 'centerText',
            afterDatasetsDraw(chart, args, options) {
                const { ctx, chartArea: { left, right, top, bottom, width, height } } =
                    chart;
                ctx.save();
                console.log(top);
                ctx.font = "normal 25px Corbel Light";
                ctx.fillStyle = 'rgba(170, 178, 190)';
                ctx.textAlign = 'center';
                ctx.fillText('Profit', width / 2, height / 2 + 13);
            }
        }

        // config 
        const configc = {
            type: 'doughnut',
            data: datac,
            options: {
                circumference: 180,
                aspectRatio: 2,
                rotation: 270,
                cutout: '85%',
                borderRadius: 5,
                backgroundColor: [
                    'rgb(241, 65, 34)',
                    'rgb(241, 65, 34)',
                    'rgb(241, 65, 34)',
                    'rgb(241, 65, 34)'
                ],
                plugins: {
                    legend: { display: false }
                }
            },
            plugins: [centerTextc]
        };

        // render init block
        const myChartc = new Chart(
            document.getElementById('myChartc'),
            configc
        );
    </script>
    <script>
        // setup 
        const datad = {
            labels: ['Total Purchases', 'Paid'],
            datasets: [{
                label: 'Weekly Sales',
                data: [18, 12],

                borderWidth: 1
            }]
        };

        const centerTextd = {
            id: 'centerText',
            afterDatasetsDraw(chart, args, options) {
                const { ctx, chartArea: { left, right, top, bottom, width, height } } =
                    chart;
                ctx.save();
                console.log(top);
                ctx.font = "normal 25px Corbel Light";
                ctx.fillStyle = 'rgba(170, 178, 190)';
                ctx.textAlign = 'center';
                ctx.fillText('Purchases', width / 2, height / 2 + 13);
            }
        }

        // config 
        const configd = {
            type: 'doughnut',
            data: datad,
            options: {
                circumference: 180,
                aspectRatio: 2,
                rotation: 270,
                cutout: '85%',
                borderRadius: 5,
                backgroundColor: [
                    '#c24599',
                    '#c7c866'
                ],
                plugins: {
                    legend: { display: false }
                }
            },
            plugins: [centerTextd]
        };

        // render init block
        const myChartd = new Chart(
            document.getElementById('myChartd'),
            configd
        );
    </script>
</asp:Content>
