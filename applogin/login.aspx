<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="pos.applogin.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <title>Sign In</title>
    <!-- Nucleo Icons -->
    <link href="../asset/login/asset/css/nucleo-icons.css" rel="stylesheet" />
    <link href="../asset/login/asset/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <link href="../asset/login/asset/css/nucleo-svg.css" rel="stylesheet" />
    <!-- CSS Files -->
    <link id="pagestyle" href="../asset/login/asset/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
    <script type="text/javascript">
        window.addEventListener('load', (event) => {
            var loginLoader = document.getElementById("loginLoader");
            loginLoader.style.display = "none";
        });
    </script>
    <style>
        /* width */
        ::-webkit-scrollbar {
            width: 5px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
            background: #ffffff;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: #e8e8e8;
        }

            /* Handle on hover */
            ::-webkit-scrollbar-thumb:hover {
                background: #ad9e9e;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container position-sticky z-index-sticky top-0">
            <div class="row">
                <div class="col-12">
                    <!-- Navbar -->

                    <!-- End Navbar -->
                </div>
            </div>
        </div>
        <main class="main-content  mt-0">
            <section>
                <div class="page-header min-vh-100">
                    <div class="container">
                        <div class="row">
                            <div class="col-xl-4 col-lg-5 col-md-7 d-flex flex-column mx-lg-0 mx-auto">
                                <div class="card card-plain">
                                    <div class="card-header pb-0 text-start">
                                        <h4 class="font-weight-bolder">Sign In</h4>
                                        <p class="mb-0">Enter your Username and password to sign in</p>
                                    </div>
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <asp:TextBox ID="txtUsername" class="form-control form-control-lg" placeholder="Username" runat="server"></asp:TextBox>
                                        </div>
                                        <div class="mb-3">
                                            <asp:TextBox ID="txtPassword" TextMode="Password" class="form-control form-control-lg" placeholder="Username" runat="server"></asp:TextBox>

                                        </div>
                                        <div class="mb-3">
                                            <asp:Label ID="lblMsg" class="text-danger" runat="server"></asp:Label>

                                        </div>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="rememberMe" />
                                            <label class="form-check-label" for="rememberMe">Remember me</label>
                                        </div>
                                        <div class="text-center">
                                            <button class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0 text-white" type="button" disabled id="loginLoader" style="display: none;">
                                                <span class="spinner-grow spinner-grow-sm text-white" role="status" aria-hidden="true"></span>
                                                Signing in...
                                            </button>
                                            <asp:LinkButton ID="btnLogin" OnClientClick="ShowLoginLoader();" class="btn btn-lg btn-primary btn-lg w-100 text-white mt-4 mb-0" runat="server" OnClick="btnLogin_Click"><span class="fas fa-arrow-right text-white mr-2"></span>Sign in</asp:LinkButton>
                                        </div>
                                    </div>
                                    <div class="card-footer text-center pt-0 px-lg-2 px-1">
                                        <p class="mb-4 text-sm mx-auto">
                                            Don't have an account?
                   
                                            <a href="signup.aspx" class="text-primary text-gradient font-weight-bold">Sign up</a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 d-lg-flex d-none h-100 my-auto pe-0 position-absolute top-0 end-0 text-center justify-content-center flex-column">
                                <div class="position-relative bg-gradient-dark h-100 px-7 d-flex flex-column justify-content-center overflow-hidden" style="background-size: cover; background-image: src('')">
                                    <span class="mask bg-gradient-dark opacity-6"></span>
                                    <h4 class="mt-5 text-white font-weight-bolder position-relative">"Welcome to QemerPOS Platform"</h4>
                                    <p class="text-white position-relative">The most advanced and efficient POS software. In the platform creating sales, purcahses and handling credit is alot easier than you think. You can manage inventory items, warehoues and more.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
        <footer class="footer py-5">
            <div class="container">

                <div class="row">
                    <div class="col-8 mx-auto text-center mt-1">
                        <p class="mb-0 text-secondary">
                            Copyright ©yo
                            <script>
                                document.write(new Date().getFullYear())
                            </script>
                            QemerPOS.
         
                        </p>
                    </div>
                </div>
            </div>
        </footer>
    </form>
    <script src="../asset/login/asset/js/core/popper.min.js"></script>
    <script src="../asset/login/asset/js/core/bootstrap.min.js"></script>
    <script src="../asset/login/asset/js/plugins/perfect-scrollbar.min.js"></script>
    <script src="../asset/login/asset/js/plugins/smooth-scrollbar.min.js"></script>

    <script src="../asset/login/asset/js/argon-dashboard.min.js?v=2.0.4"></script>
    <script>
        function ShowLoginLoader() {
            var loginLoader = document.getElementById("loginLoader");
            var loginButton = document.getElementById("<%=btnLogin.ClientID %>");
            if (loginButton.style.display === "none")
                loginButton.style.display = "block";
            else
                loginButton.style.display = "none";
            if (loginLoader.style.display === "none")
                loginLoader.style.display = "block";
            else
                loginLoader.style.display = "none";
        }
    </script>
</body>
</html>
