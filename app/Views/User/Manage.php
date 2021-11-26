<?php $this->extend('templates/admin_template') ?>
<?php $this->section('content') ?>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="page-title mb-0 font-size-18">Manage Users</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">User</a></li>
                    <li class="breadcrumb-item active">Manage</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-xl-3">
            <div id="UserDetailsModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">User Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div class="row">
                                <div class="col-md-4 col-12">
                                    <h6><i class="fas fa-user"></i> Name</h6>
                                    <div id="FullName"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-lock"></i> Username</h6>
                                    <div id="Username"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-laptop"></i> Last Login</h6>
                                    <div id="LastLogin"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-calendar"></i> Last Password Change</h6>
                                    <div id="LastPasswordChange"></div>
                                    <div>&nbsp;</div>

                                </div>

                                <div class="col-md-4 col-12">
                                    <h6><i class="fas fa-user-tie"></i> Role</h6>
                                    <div id="Role"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-globe-europe"></i> State</h6>
                                    <div id="State"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-calendar-day"></i> Created Date</h6>
                                    <div id="CreatedDate"></div>
                                    <div>&nbsp;</div>
                                </div>
                                
                                <div id="QuotaDiv" class="col-md-4 col-12">
                                    <h6><i class="fas fa-database"></i> Allocated Quota</h6>
                                    <div id="AllocatedQuota"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-tachometer-alt "></i> Used Quota</h6>
                                    <div id="UsedQuota"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-calendar-day"></i> Remaining Quota</h6>
                                    <div id="RemainingQuota"></div>
                                    <div>&nbsp;</div>
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

<div>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-xl-3">
            <div id="ModifyUserModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Modify Profile</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="ModifyUserMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">First Name</label>
                                <div class="col-md-10">
                                    <input required="required" maxlength="35" class="form-control" type="text" id="UserFirstName" name="UserFirstName">
                                    <input type="hidden" id="UserID" name="UserID" />
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">Last Name</label>
                                <div class="col-md-10">
                                    <input required="required" maxlength="35" class="form-control" type="text" id="UserLastName" name="UserLastName">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">Email Address</label>
                                <div class="col-md-10">
                                    <input required="required" maxlength="80" class="form-control" type="text" id="UserEmailAddress" name="UserEmailAddress">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">Role</label>
                                <div class="col-md-10">
                                    <select id="UserRole" name="UserRole" class="form-control">
                                        <option>Select a role</option>
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
                                <label class="col-md-2 col-form-label">Two Factor</label>
                                <div class="col-md-10">
                                    <select id="TwoFactor" name="TwoFactor" class="form-control">
                                        <option>Select an option</option>
                                        <option value="0">Disabled</option>
                                        <option value="1">Enabled</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">Status</label>
                                <div class="col-md-10">
                                    <select id="UserStatus" name="UserStatus" class="form-control">
                                        <option value="">Select a status</option>
                                        <option value="1">Active</option>
                                        <option value="0">Inactive</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">&nbsp;</label>
                                <div class="col-md-10">
                                    <div>
                                        <button onclick="ModifyProfile();" name="btnModify" id="btnModify" type="submit" class="btn btn-primary waves-effect waves-light width-md">Modify Profile</button>
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

<div class="row">

    <div class="col-12">
        <div id="MessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div class="card">
            <div class="card-body">

                <h4 class="card-title">User Management</h4>
                <p class="card-title-desc"><a onclick="GetAvailableUsers()" href="#" class="card-link">Refresh</a></p>

                <div id="spinner" class="spinner-border text-primary m-1" role="status">
                    <span class="sr-only">Loading...</span>
                </div>


                <div class="table-responsive">
                    <table id="userTable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Last Login</th>
                            <th>Role</th>
                            <th>State</th>
                            <th>Action</th>
                        </tr>
                        </thead>

                        <tbody>

                        </tbody>
                    </table>

                </div>

            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->

<!-- end row -->
<?php $this->endSection() ?>
