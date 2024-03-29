﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="pos.applogin.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Sign In</title>
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet" />
    <!-- Nucleo Icons -->
    <link href="../asset/login/asset/css/nucleo-icons.css" rel="stylesheet" />
    <link href="../asset/login/asset/css/nucleo-svg.css" rel="stylesheet" />
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <link href="../asset/login/asset/css/nucleo-svg.css" rel="stylesheet" />
    <!-- CSS Files -->
    <link id="pagestyle" href="../asset/login/asset/css/argon-dashboard.css?v=2.0.4" rel="stylesheet" />
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
                                        <form role="form">
                                            <div class="mb-3">
                                                <input type="email" class="form-control form-control-lg" placeholder="Email" aria-label="Email">
                                            </div>
                                            <div class="mb-3">
                                                <input type="email" class="form-control form-control-lg" placeholder="Password" aria-label="Password">
                                            </div>
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="rememberMe">
                                                <label class="form-check-label" for="rememberMe">Remember me</label>
                                            </div>
                                            <div class="text-center">
                                                <button type="button" class="btn btn-lg btn-primary btn-lg w-100 mt-4 mb-0">Sign in</button>
                                            </div>
                                        </form>
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
                                <div class="position-relative bg-gradient-dark h-100 px-7 d-flex flex-column justify-content-center overflow-hidden" style="background-size: cover;background-image:src('')">
                                    <span class="mask bg-gradient-dark opacity-6"></span>
                                    <h4 class="mt-5 text-white font-weight-bolder position-relative">"Welcome to QemerPOS Platform"</h4>
                                    <p class="text-white position-relative">The more effortless the writing looks, the more effort the writer actually put into the process.</p>
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
                            Copyright ©
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
    <script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
      var options = {
        damping: '0.5'
      }
      Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }
  </script>
    <!-- Github buttons -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
    <!-- Control Center for Soft Dashboard: parallax effects, scripts for the example pages etc -->
    <script src="../asset/login/asset/js/argon-dashboard.min.js?v=2.0.4"></script>
</body>
</html>
