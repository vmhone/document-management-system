<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <h4 class="page-title mb-0 font-size-18">Create New User</h4>

                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript: void(0);">User</a></li>
                        <li class="breadcrumb-item active">Create New</li>
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

            <div class="card">
                <div class="card-body">
                    
                    <h4 class="card-title">User Details</h4>
                    <p class="card-title-desc">Provide the details of the user</p>
                    
                    <div id="spinner" class="spinner-border text-primary m-1" role="status">
                          <span class="sr-only">Loading...</span>
                    </div>

                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">First Name</label>
                        <div class="col-md-10">
                            <input required="required" maxlength="35" class="form-control" type="text" id="FirstName" name="FirstName">
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Last Name</label>
                        <div class="col-md-10">
                            <input required="required" maxlength="35" class="form-control" type="text" id="LastName" name="LastName">
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Email Address</label>
                        <div class="col-md-10">
                            <input required="required" maxlength="80" class="form-control" type="email" id="EmailAddress" name="EmailAddress">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">Two Factor Authentication</label>
                        <div class="col-md-10">
                            <select id="TwoFactor" name="TwoFactor" class="form-control select2">
                                <option value="-1">Select...</option>
                                <option value="1">Enabled</option>
                                <option value="0">Disabled</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">Role</label>
                        <div class="col-md-10">
                            <select id="UserRole" name="UserRole" class="form-control select2">
                                <option value="0">Select...</option>
                            </select>
                        </div>
                    </div>

                    <div id="QuotaDiv" class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Quota (MB)</label>
                        <div class="col-md-10">
                            <input class="form-control" type="number" min="0" value="100" id="Quota" name="Quota">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">&nbsp;</label>
                        <div class="col-md-10">
                            <div>
                                <button onclick="CreateUser();" name="btnCreate" id="btnCreate" type="submit" class="btn btn-primary waves-effect waves-light width-md">Create User</button>
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