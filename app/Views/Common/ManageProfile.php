<?php

session_start(); ?>
<?php require_once APPPATH . '/Models/UserRole.php'; ?>
<?php $this->extend('templates/admin_template') ?>
<?php helper('number'); ?>

<?php $this->section('content') ?>

    <div>
        <div class="row">
            <div class="col-sm-6 col-md-4 col-xl-3">
                <div id="PasswordModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title mt-0" id="myLargeModalLabel">Authentication</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">

                                <div id="ModalMessageDiv" class="alert alert-info fade show" role="alert">
                                    To save the changes, enter your password
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">Password</label>
                                    <div class="col-md-10">
                                        <input required="required" maxlength="50" class="form-control" type="password" id="Password" name="Password">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-2 col-form-label">&nbsp;</label>
                                    <div class="col-md-10">
                                        <div>
                                            <button onclick="SaveChanges();" name="btnAuth" id="btnAuth" type="submit" class="btn btn-primary waves-effect waves-light width-md">Submit</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
            </div>
        </div>
    </div>

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <h4 class="page-title mb-0 font-size-18">Profile</h4>

                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript: void(0);">User</a></li>
                        <li class="breadcrumb-item active">Profile</li>
                    </ol>
                </div>

            </div>
        </div>
    </div>
    <!-- end page title -->

    <div class="row">
        <div class="col-lg-12">

            <div id="MessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>

            <?php if(isset($error_message)) { ?>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            <?php } ?>

            <div class="card">
                <div class="card-body">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs nav-tabs-custom nav-justified" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#home1" role="tab">
                                <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
                                <span class="d-none d-sm-block">Modify Profile</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#profile1" role="tab">
                                <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
                                <span class="d-none d-sm-block">Profile</span>
                            </a>
                        </li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content p-3 text-muted">
                        <div class="tab-pane active" id="home1" role="tabpanel">
                        <div class="card">
                <div class="card-body">

                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">First Name</label>
                        <div class="col-md-10">
                            <input autofocus="autofocus" value="<?php echo $profile['first_name']; ?>" required="required" maxlength="35" class="form-control" type="text" id="FirstName" name="FirstName">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Last Name</label>
                        <div class="col-md-10">
                            <input value="<?php echo $profile['last_name']; ?>" required="required" maxlength="35" class="form-control" type="text" id="LastName" name="Last Name">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Email Address</label>
                        <div class="col-md-10">
                            <input data-toggle="tooltip" data-placement="top" title="You cannot change this" readonly="readonly" value="<?php echo $profile['email_address']; ?>" maxlength="50" class="form-control" type="text" id="EmailAddress" name="EmailAddress">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Role</label>
                        <div class="col-md-10">
                            <input data-toggle="tooltip" data-placement="top" title="You cannot change this" readonly="readonly" value="<?php echo $_SESSION['role_desc']; ?>" class="form-control" type="text" id="RoleDesc" name="RoleDesc">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Two Factor</label>
                        <div class="col-md-10">
                            <select <?php if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) { ?> data-toggle="tooltip" data-placement="top" title="You cannot change this" disabled="disabled" readonly="readonly" <?php } ?>
                                id="TwoFactor" name="TwoFactor" class="form-control select2">
                                <option value="">Select...</option>
                                <option <?php if ($profile['use_otp'] > 0) { ?> selected="selected" <?php } ?> value="1">Enabled</option>
                                <option <?php if ($profile['use_otp'] <= 0) { ?> selected="selected" <?php } ?> value="0">Disabled</option>
                            </select>
                        </div>
                    </div>

                    <input type="hidden" name="Op" id="Op" value="1" />

                    <input type="hidden" id="UserId" name="UserId" value="<?php echo $profile['id']; ?>" />
                    <input type="hidden" id="State" name="State" value="<?php echo $profile['state_id']; ?>" />
                    <input type="hidden" id="Role" name="Role" value="<?php echo $profile['role_id']; ?>" />
                    <input type="hidden" id="AllocatedQuota" name="AllocatedQuota" value="<?php echo $assigned_quota; ?>" />

                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">&nbsp;</label>
                        <div class="col-md-10">
                            <div>
                                <?php if(isset($error_message)) { ?>
                                    <button disabled="disabled" name="btnSaveChanges" id="btnSaveChanges" type="button" class="btn btn-primary waves-effect waves-light width-md">Submit</button>
                                <?php } else { ?>
                                    <button onclick="PromptPassword();" name="btnSaveChanges" id="btnSaveChanges" type="button" class="btn btn-primary waves-effect waves-light width-md">Submit</button>
                                <?php } ?>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
            </div>
                    <div class="tab-pane" id="profile1" role="tabpanel">
                    <div class="table-responsive">
                            <table class="table table-striped mb-0">
                                <tbody>
                                    <tr>
                                        <td>First Name</td>
                                        <td><?php echo $_SESSION['first_name']; ?></td>
                                    </tr>
                                    <tr>
                                        <td>Last Name</td>
                                        <td><?php echo $_SESSION['last_name']; ?></td>
                                    </tr>
                                    <tr>
                                        <td>Username</td>
                                        <td><?php echo $profile['email_address']; ?></td>
                                    </tr>
                                    <tr>
                                        <td>User Role</td>
                                        <td><?php echo $_SESSION['role_desc']; ?></td>
                                    </tr>
                                    <tr>
                                        <td>Last Login</td>
                                        <td><?php echo $_SESSION['last_login']; ?></td>
                                    </tr>
                                    <tr>
                                        <td>Last Password Change</td>
                                        <td><?php echo $_SESSION['last_password_change']; ?></td>
                                    </tr>
                                    <tr>
                                        <td>Two Factor Authentication</td>
                                        <td><?php echo $profile['use_otp'] > 0 ? 'On' : 'Off'; ?></td>
                                    </tr>
                                    <?php if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) { ?>
                                        <tr>
                                            <td>Allocated Quota</td>
                                            <td><?php echo number_to_size($assigned_quota); ?> </td>
                                        </tr>
                                        <tr>
                                            <td>Used Quota</td>
                                            <td><?php echo number_to_size($quota['quota']); ?> </td>
                                        </tr>
                                        <tr>
                                            <td>Remaining Quota</td>
                                            <td><?php echo number_to_size($assigned_quota - $quota['quota']); ?></td>
                                        </tr>
                                    <?php } else { ?>
                                        <tr>
                                            <td>Used Space</td>
                                            <td><?php echo number_to_size($quota['quota']); ?> </td>
                                        </tr>
                                    <?php } ?>
                                </tbody>
                            </table>
                        </div>
                    </div>
                 </div>
              </div>
            </div>
        </div>
    </div>
    <!-- end row -->
<?php $this->endSection() ?>