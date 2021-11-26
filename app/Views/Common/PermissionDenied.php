<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

<div class="home-btn d-none d-sm-block">
        <a href="#" class="text-dark"><i class="fas fa-home h2"></i></a>
    </div>
    <div class="account-pages my-5 pt-sm-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 col-xl-5">
                    <div class="card overflow-hidden">
                        <div class="card-body">
                            <div class="text-center p-3">

                                <div class="img">
                                    <img src="<?php echo base_url() ?>/assets/images/error-img.png" class="img-fluid" alt="">
                                </div>

                                <h1 class="error-page mt-5"><span></span></h1>
                                <h4 class="mb-4 mt-5">Sorry, you are not allowed to access this resource</h4>
                                <p class="mb-4 w-75 mx-auto">If you think you shouldn't be seeing this message, contact your system administrator</p>
                                <a class="btn btn-primary mb-4 waves-effect waves-light" href="<?php echo site_url(); ?>/Dashboard/Index"><i class="mdi mdi-home"></i> Back to Dashboard</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

<?php $this->endSection() ?>