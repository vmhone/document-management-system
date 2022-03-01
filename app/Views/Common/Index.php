<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Document Management System" name="description" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="<?php echo base_url() ?>/assets/images/favicon.ico">

    <!-- Bootstrap Css -->
    <link href="<?php echo base_url() ?>/assets/css/bootstrap.min.css?v=<?php echo mt_rand(); ?>" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="<?php echo base_url() ?>/assets/css/icons.min.css?v=<?php echo mt_rand(); ?>" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="<?php echo base_url() ?>/assets/css/app.min.css?v=<?php echo mt_rand(); ?>" id="app-style" rel="stylesheet" type="text/css" />

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
                            <h5 class="text-white font-size-20">Welcome</h5>
                            <p class="text-white-50 mb-0">Sign in to continue</p>
                            <img src="<?php base_url() ?>/assets/images/logo-sm-dark.png" alt="" height="30">
                        </div>
                    </div>
                    <div class="card-body pt-5">
                        <div class="p-2">
                            <?php if (isset($message)) { ?>
                                <div id="MessageDiv" class="alert alert-warning fade show" role="alert">
                                    <?php echo $message; ?>
                                </div>
                            <?php } ?>

                            <form method="post" class="form-horizontal" action="<?php echo site_url(); ?>/Common/AuthenticateLogin">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <?php if(isset($username)) { ?>
                                        <input value="<?php echo $username; ?>" required="required" type="email" class="form-control" id="username" name="username" placeholder="Enter your username">
                                    <?php } else { ?>
                                        <input required="required" type="email" class="form-control" id="username" name="username" placeholder="Enter your username">
                                    <?php } ?>
                                </div>

                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input required="required" type="password" class="form-control" id="password" name="password" placeholder="Enter your password">
                                </div>

                                <div class="mt-3">
                                    <button id="btnLogin" class="btn btn-primary btn-block waves-effect waves-light" type="submit">Log In</button>
                                </div>

                                <div class="mt-4 text-center">
                                    <a href="<?php echo site_url('Common'); ?>/InitiateReset" class="text-muted"><i class="mdi mdi-lock mr-1"></i> Forgot your password?</a>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
                <div class="mt-5 text-center">
                    <p>© <?php echo date('Y'); ?></p>
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
<script src="<?php echo base_url() ?>/assets/custom/common/index.js"></script>

</body>

</html>