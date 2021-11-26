<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

<div>

<div>
    <div id="privilegesModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myExtraLargeModalLabel">Privileges</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card-box">

                                <div id="PrivilegesModalMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>

                                <ul class="nav nav-pills navtab-bg nav-justified">

                                    <li class="nav-item">
                                        <a href="#available_group_privileges" data-toggle="tab" aria-expanded="true" class="nav-link active">
                                            Privileges By Group
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#available_user_privileges" data-toggle="tab" aria-expanded="false" class="nav-link">
                                            Privileges By User
                                        </a>
                                    </li>
                                </ul>

                                <br />

                                <div class="tab-content">
                                    <div class="tab-pane show active" id="available_group_privileges">
                                        <div class="col-md-12 col-12">
                                            <div class="responsive-table-plugin">
                                                <div class="table-rep-plugin">
                                                    <br />
                                                    <div class="table-responsive" data-pattern="priority-columns">
                                                        <table id="grantedGroups" class="table table-striped">
                                                            <thead>
                                                            <tr>
                                                                <th data-priority="1">Group</th>
                                                                <th data-priority="3">Privilege</th>
                                                                <th data-priority="2">Granted Date</th>
                                                            </tr>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div> <!-- end table-responsive-->
                                                </div> <!-- table-rep-plugin-->
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane" id="available_user_privileges">
                                        <div class="col-md-12 col-12">
                                            <div class="responsive-table-plugin">
                                                <div class="table-rep-plugin">
                                                    <br />
                                                    <div class="table-responsive" data-pattern="priority-columns">
                                                        <table id="grantedUsers" class="table table-striped">
                                                            <thead>
                                                                <tr>
                                                                    <th data-priority="1">User</th>
                                                                    <th data-priority="2">Email Address</th>
                                                                    <th data-priority="3">Privilege</th>
                                                                    <th data-priority="3">Granted Date</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                            </tbody>
                                                        </table>
                                                    </div> <!-- end table-responsive-->
                                                </div> <!-- table-rep-plugin-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div> <!-- end card-box-->
                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="grantPrivilegesModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myExtraLargeModalLabel">Grant Privilege</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card-box">

                                <div id="GrantPrivilegesModalMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>

                                <input type="hidden" id="SelectedFolder" name="SelectedFolder" />

                                <ul class="nav nav-pills navtab-bg nav-justified">

                                    <li class="nav-item">
                                        <a href="#groupgrant" data-toggle="tab" aria-expanded="true" class="nav-link active">
                                            Grant By Group
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#usergrant" data-toggle="tab" aria-expanded="false" class="nav-link">
                                            Grant By User
                                        </a>
                                    </li>
                                </ul>

                                <br />

                                <div class="tab-content">
                                    <div class="tab-pane show active" id="groupgrant">
                                    <div class="form-group row">
                                        <label class="col-md-2 col-form-label">Group</label>
                                        <div class="col-md-10">
                                            <select style="width: 100%" id="SelectedGroup" name="SelectedGroup" class="form-control select2">
                                                <option value="">Select a group...</option>
                                            </select>
                                        </div>
                                    </div>
            
                                    <div class="form-group row">
                                        <label class="col-md-2 col-form-label">Privilege</label>
                                        <div class="col-md-10">
                                            <select style="width: 100%" id="SelectedPrivilege" name="SelectedPrivilege" class="form-control">
                                                <option value="">Select a privilege...</option>
                                                <option value="-1">No Access</option>
                                                <option value="0">Read</option>
                                                <option value="1">Write</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-md-2 col-form-label">&nbsp;</label>
                                        <div class="col-md-10">
                                            <div>
                                                <button onclick="ConfirmGrantPrivilegeToGroup();" name="btnGrantGroup" id="btnGrantGroup" type="submit" class="btn btn-primary waves-effect waves-light width-md">Modify Privilege</button>
                                            </div>
                                        </div>
                                    </div>

                                </div>

                                <div class="tab-pane" id="usergrant">
                                    
                                    <div class="form-group row">
                                        <label class="col-md-2 col-form-label">User</label>
                                        <div class="col-md-10">
                                            <select style="width: 100%" id="SelectedUser" name="SelectedUser" class="form-control select2">
                                                <option value="">Select a user...</option>
                                            </select>
                                        </div>
                                    </div>
            
                                    <div class="form-group row">
                                        <label class="col-md-2 col-form-label">Privilege</label>
                                        <div class="col-md-10">
                                            <select style="width: 100%" id="SelectedPrivilegeUser" name="SelectedPrivilegeUser" class="form-control">
                                                <option value="">Select a privilege...</option>
                                                <option value="-1">No Access</option>
                                                <option value="0">Read</option>
                                                <option value="1">Write</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group row">
                                        <label class="col-md-2 col-form-label">&nbsp;</label>
                                        <div class="col-md-10">
                                            <div>
                                                <button onclick="ConfirmGrantPrivilegeToUser();" name="btnGrantUser" id="btnGrantUser" type="submit" class="btn btn-primary waves-effect waves-light width-md">Modify Privilege</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                               </div>
                            </div>
                        </div> <!-- end card-box-->
                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div>
    <div id="folderDetailsModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myExtraLargeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myExtraLargeModalLabel">Workspace Details</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="card-box">

                                <div id="FolderDetailsModalMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>


                                <ul class="nav nav-pills navtab-bg nav-justified">

                                    <li class="nav-item">
                                        <a href="#folderdetails" data-toggle="tab" aria-expanded="true" class="nav-link active">
                                            Workspace Details
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#files" data-toggle="tab" aria-expanded="false" class="nav-link">
                                            Files
                                        </a>
                                    </li>
                                </ul>

                                <br />

                                <div class="tab-content">
                                    <div class="tab-pane show active" id="folderdetails">
                                        <div class="row">
                                            <div class="col-md-4 col-12">
                                                <h6><i class="fas fa-folder"></i> Workspace Name</h6>
                                                <div id="FolderName"></div>
                                                <div>&nbsp;</div>

                                                <h6><i class="fas fa-user-tie"></i> Workspace Owner</h6>
                                                <div id="FolderOwner"></div>
                                                <div>&nbsp;</div>

                                                <h6><i class="fas fa-info-circle"></i> Workspace Status</h6>
                                                <div id="FolderStatus"></div>
                                                <div>&nbsp;</div>

                                            </div>

                                            <div class="col-md-4 col-12">
                                                <h6><i class="fas fa-calendar-alt"></i> Created Date</h6>
                                                <div id="CreatedDate"></div>
                                                <div>&nbsp;</div>

                                                <h6><i class="fas fa-user-tie"></i> Created By</h6>
                                                <div id="CreatedBy"></div>
                                                <div>&nbsp;</div>

                                                <h6><i class="fas fa-calendar-day"></i> Updated Date</h6>
                                                <div id="UpdatedDate"></div>
                                                <div>&nbsp;</div>

                                            </div>
                                        </div>

                                    </div>

                                    <div class="tab-pane" id="files">
                                        <div class="col-md-12 col-12">
                                            <div class="responsive-table-plugin">
                                                <div class="table-rep-plugin">
                                                    <br />
                                                    <div class="table-responsive" data-pattern="priority-columns">
                                                        <table id="availableFiles" class="table table-striped">
                                                            <thead>
                                                            <tr>
                                                                <th data-priority="1">Name</th>
                                                                <th data-priority="3">Size</th>
                                                                <th data-priority="1">Version</th>
                                                                <th data-priority="3">Uploaded By</th>
                                                                <th>Date Uploaded</th>
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
                            </div>
                        </div> <!-- end card-box-->
                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-xl-3">
            <div id="modifyModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Modify Workspace</h5>
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
                                <label for="example-text-input" class="col-md-2 col-form-label">Name</label>
                                <div class="col-md-10">
                                    <input disabled="disabled" readonly="readonly" required="required" maxlength="128" class="form-control" type="text" id="ModifyFolderName" name="ModifyFolderName">
                                    <input type="hidden" id="ModifyFolderID" name="ModifyFolderID" />
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">Status</label>
                                <div class="col-md-10">
                                    <select id="Status" name="Status" class="form-control">
                                        <option>Select a status</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">&nbsp;</label>
                                <div class="col-md-10">
                                    <div>
                                        <button onclick="ConfirmModify();" name="btnModify" id="btnModify" type="submit" class="btn btn-primary waves-effect waves-light width-md">Modify Workspace</button>
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
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Rename Workspace</h5>
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
                                        <button onclick="RenameFolder();" name="btnRename" id="btnRename" type="submit" class="btn btn-primary waves-effect waves-light width-md">Rename Workspace</button>
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
            <h4 class="page-title mb-0 font-size-18">Manage Workspace</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Workspace</a></li>
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

                <h4 class="card-title">Workspace Management</h4>
                <p class="card-title-desc"><a onclick="GetAvailableFolders()" href="#" class="card-link">Refresh</a></p>

                <div class="table-responsive">
                    <table id="datatable" class="table table-bordered dt-responsive nowrap" style="border-collapse: collapse; border-spacing: 0; width: 100%;">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Files</th>
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
