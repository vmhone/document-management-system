<?php session_start(); ?>
<?php require_once APPPATH . '/Models/UserRole.php'; ?>

<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>Document Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Document Management System" name="description" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="<?php echo base_url() ?>/assets/images/favicon.ico">
    
    <link href="<?php echo base_url() ?>/assets/libs/select2/css/select2.min.css" id="app-style" rel="stylesheet" type="text/css" />

    <link href="<?php echo base_url() ?>/assets/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />

    <!-- Bootstrap Css -->
    <link href="<?php echo base_url() ?>/assets/css/bootstrap.min.css" id="bootstrap-style" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="<?php echo base_url() ?>/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="<?php echo base_url() ?>/assets/css/app.min.css" id="app-style" rel="stylesheet" type="text/css" />

    <!-- Sweet Alert-->
    <link href="<?php echo base_url() ?>/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />

    <link href="<?php echo base_url() ?>/assets/libs/datatables.net-bs4/css/dataTables.bootstrap4.min.css" rel="stylesheet" type="text/css" />

    <link href="<?php echo base_url() ?>/assets/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.css" rel="stylesheet" type="text/css" />

    <link href="<?php echo base_url() ?>/assets/custom/jquery.tagsinput.css" rel="stylesheet" type="text/css" />
    <link href="<?php echo base_url() ?>/assets/css/tagsinput.css" rel="stylesheet" type="text/css" />

</head>
<body data-layout="horizontal" data-topbar="dark" class="">

    <div class="container-fluid">
        <!-- Begin page -->
        <div id="layout-wrapper">

            <header id="page-topbar">
                <div class="navbar-header">
                    <div class="d-flex">
                        <!-- LOGO -->
                        <div class="navbar-brand-box">
                            <a href="<?php echo site_url(); ?>/Dashboard/Index" class="logo logo-dark">
                                <span class="logo-sm">
                                    <img src="<?php base_url() ?>/assets/images/logo-sm-dark.png" alt="" height="20">
                                </span>
                                <span class="logo-lg">
                                    <img src="<?php base_url() ?>/assets/images/logo-dark.png" alt="" height="40">
                                </span>
                            </a>

                            <a href="<?php echo site_url(); ?>/Dashboard/Index" class="logo logo-light">
                                <span class="logo-sm">
                                    <img src="<?php echo base_url() ?>/assets/images/logo-sm-dark.png" alt="" height="20">
                                </span>
                                <span class="logo-lg">
                                    <img src="<?php echo base_url() ?>/assets/images/logo-light.png" alt="" height="40">
                                </span>
                            </a>
                        </div>

                        <button type="button" class="btn btn-sm px-3 font-size-16 d-lg-none header-item waves-effect waves-light" data-toggle="collapse" data-target="#topnav-menu-content">
                            <i class="fa fa-fw fa-bars"></i>
                        </button>

                        <div class="topnav">
                            <nav class="navbar navbar-light navbar-expand-lg topnav-menu active">

                                <div class="collapse navbar-collapse active" id="topnav-menu-content">
                                    <ul class="navbar-nav active">
                                        <li class="nav-item dropdown active">
                                            <a class="nav-link" href="<?php echo site_url('Dashboard'); ?>/Index" id="topnav-dashboard" role="button"  aria-haspopup="false" aria-expanded="false">
                                                Dashboard <div class="arrow"></div>
                                            </a>
                                        </li>

                                        <li class="nav-item dropdown active">
                                            <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-pages" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Folder <div class="arrow-down"></div>
                                            </a>
                                            <div class="dropdown-menu" aria-labelledby="topnav-pages">
                                                <?php if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR || $_SESSION['role_id'] == UserRole::SUPER_USER) { ?>
                                                    <a href="<?php echo site_url('Folder')?>/Index" class="dropdown-item">Create</a>
                                                <?php } ?>
                                                <a href="<?php echo site_url('Folder')?>/Manage" class="dropdown-item">Manage Folders</a>
                                            </div>
                                        </li>

                                        <li class="nav-item dropdown active">
                                            <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-pages" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                Document <div class="arrow-down"></div>
                                            </a>
                                            <div class="dropdown-menu" aria-labelledby="topnav-pages">
                                                <?php if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR || $_SESSION['role_id'] == UserRole::SUPER_USER || $_SESSION['role_id'] == UserRole::STANDARD_USER) { ?>
                                                    <a href="<?php echo site_url('Document')?>/Index" class="dropdown-item">Single Document Upload</a>
                                                    <a href="<?php echo site_url('Document')?>/BulkUpload" class="dropdown-item">Bulk Document Upload</a>
                                                <?php } ?>
                                                <a href="<?php echo site_url('Document')?>/Manage" class="dropdown-item">Manage Documents</a>
                                                <a href="<?php echo site_url('Document')?>/Search" class="dropdown-item">Search</a>
                                            </div>
                                        </li>
                                        
                                        <?php if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR || $_SESSION['role_id'] == UserRole::SUPER_USER) { ?>
                                            <li class="nav-item dropdown active">
                                                <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-pages" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    Group <div class="arrow-down"></div>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="topnav-pages">
                                                    <a href="<?php echo site_url('Group')?>/Index" class="dropdown-item">Create</a>
                                                    <a href="<?php echo site_url('Group')?>/Manage" class="dropdown-item">Manage Groups</a>
                                                </div>
                                            </li>
                                        <?php } ?>
                                        
                                        <?php if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) { ?>
                                            <li class="nav-item dropdown active">
                                                <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-pages" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    User <div class="arrow-down"></div>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="topnav-pages">
                                                    <a href="<?php echo site_url('User')?>/Index" class="dropdown-item">Create</a>
                                                    <a href="<?php echo site_url('User')?>/Manage" class="dropdown-item">Manage Users</a>
                                                </div>
                                            </li>
                                        <?php } ?>
                                        
                                        <?php if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) { ?>
                                            <li class="nav-item dropdown active">
                                                <a class="nav-link dropdown-toggle arrow-none" href="#" id="topnav-pages" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                    Configuration <div class="arrow-down"></div>
                                                </a>
                                                <div class="dropdown-menu" aria-labelledby="topnav-pages">
                                                    <a href="<?php echo site_url('SystemConfig')?>/Index" class="dropdown-item">Settings</a>
                                                </div>
                                            </li>
                                        <?php } ?>
                                    </ul>
                                </div>
                            </nav>
                        </div>
                    </div>

                    <div class="d-flex">
                        <div class="dropdown d-inline-block d-lg-none ml-2">
                            <button type="button" class="btn header-item noti-icon waves-effect" id="page-header-search-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="mdi mdi-magnify"></i>
                            </button>
                            <div class="dropdown-menu dropdown-menu-lg dropdown-menu-right p-0" aria-labelledby="page-header-search-dropdown">

                                <form class="p-3">
                                    <div class="form-group m-0">
                                        <div class="input-group">
                                            <input type="text" class="form-control" placeholder="Search ..." aria-label="Recipient's username">
                                            <div class="input-group-append">
                                                <button class="btn btn-primary" type="submit"><i class="mdi mdi-magnify"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="dropdown d-inline-block">
                            <button type="button" class="btn header-item waves-effect" id="page-header-user-dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="d-none d-xl-inline-block ml-1"><?php echo $_SESSION['first_name']; ?> <?php echo $_SESSION['last_name']; ?></span>
                                <i class="mdi mdi-chevron-down d-none d-xl-inline-block"></i>
                            </button>
                            <div class="dropdown-menu dropdown-menu-right">
                                <!-- item-->
                                <a class="dropdown-item" href="<?php echo site_url(); ?>/Common/Password"><i class="bx bx-user font-size-16 align-middle mr-1"></i> Change Password</a>
                                <a class="dropdown-item" href="<?php echo site_url(); ?>/Common/MyProfile"><i class="bx bx-wallet font-size-16 align-middle mr-1"></i> My Profile</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item text-danger" href="<?php echo site_url(); ?>/Common/Logout"><i class="bx bx-power-off font-size-16 align-middle mr-1 text-danger"></i> Logout</a>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- ============================================================== -->
            <!-- Start right Content here -->
            <!-- ============================================================== -->
            <div class="main-content">

                <div class="page-content">

                    <!-- start page title -->
                    <?php $this->renderSection('content') ?>

                </div>
                <!-- End Page-content -->

                <footer class="footer">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-6">
                                © <?php echo date('Y'); ?> Document Management System
                            </div>
                            <div class="col-sm-6">
                                <div class="text-sm-right d-none d-sm-block">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
            <!-- end main content-->

        </div>
        <!-- END layout-wrapper -->

    </div>
    <!-- end container-fluid -->

    <script src="<?php echo base_url() ?>/assets/libs/jquery/jquery.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/metismenu/metisMenu.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/simplebar/simplebar.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/select2/js/select2.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/node-waves/waves.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/js/app.js"></script>
    <script src="<?php echo base_url() ?>/assets/js/pages/form-advanced.init.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/datatables.net-bs4/js/dataTables.bootstrap4.min.js"></script>
    
    <script src="<?php echo base_url() ?>/assets/libs/apexcharts/apexcharts.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/bootstrap-touchspin/jquery.bootstrap-touchspin.min.js"></script>
    <script src="<?php echo base_url() ?>/assets/libs/bootstrap-maxlength/bootstrap-maxlength.min.js"></script>

    <!-- Sweet Alerts js -->
    <script src="<?php echo base_url() ?>/assets/libs/sweetalert2/sweetalert2.min.js"></script>

    <!-- Sweet alert init js--> 
    <script src="<?php echo base_url() ?>/assets/js/pages/sweet-alerts.init.js"></script>

    <script src="<?php echo base_url() ?>/assets/libs/jquery-steps/build/jquery.steps.min.js"></script>

    <!-- form wizard init -->
    <script src="<?php echo base_url() ?>/assets/js/pages/form-wizard.init.js"></script>
    <script src="<?php echo base_url() ?>/assets/js/jquery.tagsinput.js"></script>
    <script src="<?php echo base_url() ?>/assets/js/tagsinput.js"></script>

    <?php
        if(isset($js_files)) foreach ($js_files as $js_file) {
    ?>
        <script src="<?php echo $js_file ?>"></script>
    <?php }
    ?>
</body>

</html>