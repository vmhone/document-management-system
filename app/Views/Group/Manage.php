<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

<div>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-xl-3">
            <div id="GroupMembersModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Manage Group Members</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <input type="hidden" name="Group" id="Group" />
                        </div>
                        <div class="modal-body">

                            <div id="GroupMembersMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="row">
                                <div class="col-12">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="form-group row">
                                                <label class="col-md-2 col-form-label">Available Users</label>
                                                <div class="col-md-10">
                                                    <select style="width: 100%" id="User" name="User" class="form-control select2">

                                                    </select>
                                                </div>
                                                <input type="hidden" name="grantGroupID" id="grantGroupID" />
                                            </div>

                                            <div class="form-group row">
                                                <label class="col-md-2 col-form-label">&nbsp;</label>
                                                <div class="col-md-10">
                                                    <div>
                                                        <button onclick="ConfirmGrant();" name="btnAdd" id="btnAdd" type="submit" class="btn btn-primary waves-effect waves-light width-md">Add to group</button>
                                                    </div>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                                <!-- end col -->
                            </div>


                            <div class="col-md-12 col-12">
                                <div class="responsive-table-plugin">
                                    <div class="table-rep-plugin">
                                        <br />
                                        <div class="table-responsive" data-pattern="priority-columns">
                                            <table id="groupMembersTable" class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <th data-priority="1">Name</th>
                                                    <th>Email Address</th>
                                                    <th data-priority="3">Assigned Date</th>
                                                    <th>Action</th>
                                                </tr>
                                                </thead>
                                                <tbody></tbody>
                                            </table>
                                        </div> <!-- end table-responsive-->
                                    </div> <!-- table-rep-plugin-->
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
            <div id="modifyModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Modify Group</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="ModifyModalMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">Group Name</label>
                                <div class="col-md-10">
                                    <input required="required" maxlength="45" class="form-control" type="text" id="GroupName" name="GroupName">
                                    <input type="hidden" id="GroupID" name="GroupID" />
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">Comment</label>
                                <div class="col-md-10">
                                    <input required="required" maxlength="128" class="form-control" maxlength="128" type="text" id="GroupComment" name="GroupComment">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">Status</label>
                                <div class="col-md-10">
                                    <select id="Status" name="Status" class="form-control">
                                        <option>Select a status</option>
                                        <option value="0">Inactive</option>
                                        <option value="1">Active</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">&nbsp;</label>
                                <div class="col-md-10">
                                    <div>
                                        <button onclick="ModifyGroup();" name="btnModify" id="btnModify" type="submit" class="btn btn-primary waves-effect waves-light width-md">Save Changes</button>
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

<div>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-xl-3">
            <div id="renameModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Rename Group</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="ModalMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">Current Name</label>
                                <div class="col-md-10">
                                    <input disabled="disabled" readonly="readonly" required="required" maxlength="128" class="form-control" type="text" id="CurrentFolderName" name="CurrentFolderName">
                                    <input type="hidden" id="FolderID" name="FolderID" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">New Name</label>
                                <div class="col-md-10">
                                    <input required="required" maxlength="128" class="form-control" type="text" id="NewFolderName" name="NewFolderName">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">&nbsp;</label>
                                <div class="col-md-10">
                                    <div>
                                        <button onclick="RenameFolder();" name="btnRename" id="btnRename" type="submit" class="btn btn-primary waves-effect waves-light width-md">Rename Folder</button>
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
            <h4 class="page-title mb-0 font-size-18">Manage Group</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Group</a></li>
                    <li class="breadcrumb-item active">Manage</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">

    <div class="col-12">
        <div id="MessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div class="card">
            <div class="card-body">

                <h4 class="card-title">Group Management</h4>
                <p class="card-title-desc"><a onclick="GetAvailableGroups()" href="#" class="card-link">Refresh</a></p>

                <div class="table-responsive">
                    <table id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Comment</th>
                            <th>Created Date</th>
                            <th>Created By</th>
                            <th>Status</th>
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
