<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>One Time PIN | Document Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Document Management System" name="description" />
    <meta content="AHL Group" name="author" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="<?php echo base_url() ?>/assets/images/favicon.ico">

    <!-- Bootstrap Css -->
    <link href="<?php echo base_url(); ?>/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="<?php echo base_url(); ?>/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="<?php echo base_url(); ?>/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />

</head>

<body>
<div class="home-btn d-none d-sm-block">

</div>
<div class="account-pages my-5 pt-sm-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6 col-xl-5">
                <div class="card overflow-hidden">
                    <div class="bg-login text-center">
                        <div class="bg-login-overlay"></div>
                        <div class="position-relative">
                            <h5 class="text-white font-size-20">One-Time PIN (OTP)</h5>
                            <img src="<?php echo base_url() ?>/assets/images/logo-sm-dark.png" alt="" height="30">
                        </div>
                    </div>
                    <div class="card-body pt-5">
                        <div class="p-2">
                            <div id="MessageDiv" class="alert alert-info fade show" role="alert">
                                Please enter the code that we have sent to your email address
                            </div>

                            <form method="post" class="form-horizontal">
                                <div class="form-group">
                                    <input required="required" maxlength="10" type="number" class="form-control" id="otp" name="otp" placeholder="Enter the OTP">
                                </div>

                                <div class="mt-3">
                                    <button onclick="VerifyOTP();" id="btnVerify" class="btn btn-primary btn-block waves-effect waves-light" type="button">Verify OTP</button>
                                </div>
                            </form>

                            <div id="navBottom" class="row mt-3">
                                <div class="col-12 text-center">
                                    <p class="page-title">
                                        <a id="ResendLink" href="#" onclick="GenerateOTP(1);" class="text-dark ml-1"><b>Resend OTP</b></a>
                                        <span id="pipe">|</span>
                                        <a href="<?php echo site_url(); ?>/Common/Index" class="text-dark ml-1"><b>Back to login</b></a>
                                    </p>
                                </div> <!-- end col -->
                            </div>

                        </div>

                    </div>
                </div>
                <div class="mt-5 text-center">
                    <p>© <?php echo date('Y'); ?> DMS. Developed by: <a target="_blank" href="https://ic-techafrica.com">IC-Tech Africa</a> | <a target="_blank" href="http://www.ahlmw.com">AHL Group</a></p>
                </div>

            </div>
        </div>
    </div>
</div>

<!-- JAVASCRIPT -->
<script src="<?php echo base_url() ?>/assets/libs/jquery/jquery.min.js"></script>
<script src="<?php echo base_url() ?>/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<?php echo base_url() ?>/assets/libs/metismenu/metisMenu.min.js"></script>
<script src="<?php echo base_url() ?>/assets/libs/simplebar/simplebar.min.js"></script>
<script src="<?php echo base_url() ?>/assets/libs/node-waves/waves.min.js"></script>

<script src="<?php echo base_url() ?>/assets/js/app.js"></script>
<script src="<?php echo base_url() ?>/assets/custom/common/otp.js"></script>
<!-- Sweet Alerts js -->

</body>

</html>