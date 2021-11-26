<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>
<?php session_start(); ?>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="page-title mb-0 font-size-18">Change Password</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">User</a></li>
                    <li class="breadcrumb-item active">Password</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">

    <div class="col-12">
        <div id="MessageDiv" class="alert alert-success alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <?php if($_SESSION['has_password_expired']) {  ?>
            <div id="PasswordExpiredDiv" class="alert alert-info alert-dismissible fade show" role="alert">
            <?php echo $_SESSION['remark']; ?>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        <?php } ?>

        <?php if ($_SESSION['first_login']) { ?>
            <div id="FirstLoginDiv" class="alert alert-info alert-dismissible fade show" role="alert">
            <?php echo $_SESSION['remark']; ?>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        <?php } ?>

        <div class="card">
            <div class="card-body">

                <h4 class="card-title">Change Password</h4>
                <p class="card-title-desc">Provide the current password and confirm the new password</p>

                <div class="form-group row">
                    <label for="example-text-input" class="col-md-2 col-form-label">Current Password</label>
                    <div class="col-md-10">
                        <input required="required" maxlength="50" class="form-control" type="password" id="CurrentPassword" name="CurrentPassword">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="example-text-input" class="col-md-2 col-form-label">New Password</label>
                    <div class="col-md-10">
                        <input required="required" maxlength="50" class="form-control" type="password" id="NewPassword" name="NewPassword">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="example-text-input" class="col-md-2 col-form-label">Confirm New Password</label>
                    <div class="col-md-10">
                        <input required="required" maxlength="50" class="form-control" type="password" id="ConfirmNewPassword" name="ConfirmNewPassword">
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-md-2 col-form-label">&nbsp;</label>
                    <div class="col-md-10">
                        <div>
                            <button onclick="ChangePassword();" name="btnChangePassword" id="btnChangePassword" type="submit" class="btn btn-primary waves-effect waves-light width-md">Change Password</button>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->

<!-- end row -->
<?php $this->endSection() ?>