<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Reset Password | Document Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Document Management System" name="description" />
    <meta content="IC-Tech Africa" name="author" />
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
                            <h5 class="text-white font-size-20">Reset Password</h5>
                            <img src="<?= base_url() ?>/assets/images/logo-sm-dark.png" alt="" height="30">
                        </div>
                    </div>
                    <div class="card-body pt-5">
                        <div class="p-2">
                            <div id="MessageDiv" class="alert alert-warning fade show" role="alert">

                            </div>

                            <?php if(isset($remark)) { ?>
                                <div id="ErrorMessageDiv" class="alert alert-warning fade show" role="alert">
                                    <?php echo $remark; ?>
                                </div>
                            <?php } ?>

                            <form method="post" class="form-horizontal">
                                <div class="form-group">
                                    <input required="required" type="email" class="form-control" id="username" name="username" placeholder="Enter your username">
                                </div>

                                <div class="mt-3">
                                    <button onclick="InitiatePasswordReset();" id="btnReset" class="btn btn-primary btn-block waves-effect waves-light" type="button">Initiate Password Reset</button>
                                </div>
                            </form>

                            <div class="row mt-3">
                                <div class="col-12 text-center">
                                    <p class="page-title"><a href="<?php echo site_url(); ?>/Common/Index" class="text-dark ml-1"><b>Back to login</b></a></p>
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
<script src="<?php echo base_url() ?>/assets/custom/common/reset_password.js"></script>
<!-- Sweet Alerts js -->

</body>

</html>