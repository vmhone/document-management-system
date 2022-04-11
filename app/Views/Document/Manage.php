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

                                <input type="hidden" id="SelectedDocument" name="SelectedDocument" />

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
    <div class="row">
        <div class="col-sm-6 col-md-4 col-xl-3">
            <div id="DocumentDetailsModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Document Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="DocumentDetailsModalDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="row">
                                <div class="col-md-4 col-12">
                                    <h6><i class="fas fa-file"></i> Document Name</h6>
                                    <div id="DocumentName"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-folder"></i> Folder</h6>
                                    <div id="FolderName"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-file-signature"></i> Version</h6>
                                    <div id="Version"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-info-circle"></i> Extension</h6>
                                    <div id="Extension"></div>
                                    <div>&nbsp;</div>

                                </div>

                                <div class="col-md-4 col-12">
                                    <h6><i class="fas fa-calendar-alt"></i> Uploaded Date</h6>
                                    <div id="UploadedDate"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-user-tie"></i> Uploaded By</h6>
                                    <div id="UploadedBy"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-envelope"></i> Mime Type</h6>
                                    <div id="MimeType"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-calendar-day"></i> State</h6>
                                    <div id="State"></div>
                                    <div>&nbsp;</div>

                                </div>

                                <div class="col-md-4 col-12">

                                    <h6><i class="fas fa-book"></i> Comments</h6>
                                    <div id="Comments"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-compact-disc"></i> Size</h6>
                                    <div id="Size"></div>
                                    <div>&nbsp;</div>

                                    <h6><i class="fas fa-key"></i> Keywords</h6>
                                    <div id="Keywords"></div>
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
            <div id="DocumentHistoryModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">View Document History</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="DocumentHistoryMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div class="col-md-12 col-12">
                                <div class="responsive-table-plugin">
                                    <div class="table-rep-plugin">
                                        <br />
                                        <div class="table-responsive" data-pattern="priority-columns">
                                            <table id="filesInHistory" class="table table-striped">
                                                <thead>
                                                <tr>
                                                    <th data-priority="1">File Name</th>
                                                    <th data-priority="3">Size</th>
                                                    <th data-priority="1">Version</th>
                                                    <th data-priority="3">Uploaded By</th>
                                                    <th>Date Uploaded</th>
                                                    <th></th>
                                                    <th></th>
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
            <div id="EmailModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Send Document Via Email</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="EmailMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <input type="hidden" id="EmailDocumentID" name="EmailDocumentID" />

                            <div class="form-group row">
                                <label for="recipients" class="col-lg-3 col-form-label">Recipient Email Addresses</label>
                                <div class="col-lg-9">
                                    <input type="text" class="form-control" data-role="tagsinput" id="Recipients" name="Recipients" />
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="sendcopy" class="col-lg-3 col-form-label"></label>
                                <div class="col-lg-9">
                                    <div class="form-check mb-2">
                                        <input class="form-check-input" type="checkbox" id="SendACopy" name="SendACopy">
                                        <label class="form-check-label" for="emailCheck">
                                            Send a copy to my email address
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group row">
                            <label for="recipients" class="col-lg-3 col-form-label"></label>
                                <div class="col-lg-9">         
                                    <div>
                                        <button onclick="SubmitEmailRequest();" name="btnEmail" id="btnEmail" type="button" class="btn btn-primary waves-effect waves-light width-md">Send Email</button>
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
            <div id="DocumentRenameModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Rename Document</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="DocumentRenameMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <input type="hidden" id="DocumentId" name="DocumentId" />

                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">Document Name</label>
                                <div class="col-md-10">
                                    <input disabled="disabled" readonly="readonly" required="required" maxlength="128" class="form-control" type="text" id="CurrentDocumentName" name="CurrentDocumentName">
                                    <input type="hidden" id="CurrentDocId" name="CurrentDocId" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">Current Folder</label>
                                <div class="col-md-10">
                                    <input disabled="disabled" readonly="readonly" required="required" maxlength="128" class="form-control" type="text" id="CurrentFolderName" name="CurrentFolderName">
                                    <input type="hidden" id="CurrentFolderId" name="CurrentFolderId" />
                                </div>
                            </div>
                            <div class="form-group row">
                                <label for="example-text-input" class="col-md-2 col-form-label">New Document Name</label>
                                <div class="col-md-10">
                                    <input required="required" maxlength="128" class="form-control" type="text" id="NewDocumentName" name="NewDocumentName">
                                </div>
                            </div>
                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">&nbsp;</label>
                                <div class="col-md-10">
                                    <div>
                                        <button onclick="RenameDocument();" name="btnRenameDocument" id="btnRenameDocument" type="submit" class="btn btn-primary waves-effect waves-light width-md">Rename Document</button>
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
            <div id="TransferDocumentModal" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Transfer Document</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="DocumentTransferMessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <input type="hidden" id="DocumentIdTransfer" name="DocumentIdTransfer" />
                            <input type="hidden" id="FolderIdTransfer" name="FolderIdTransfer" />

                            <div class="form-group row">
                                <label for="document-name" class="col-md-2 col-form-label">Document Name</label>
                                <div class="col-md-10">
                                    <input disabled="disabled" readonly="readonly" required="required" maxlength="128" class="form-control" type="text" id="TransferDocumentName" name="TransferDocumentName">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label for="current-folder" class="col-md-2 col-form-label">Current Folder</label>
                                <div class="col-md-10">
                                    <input disabled="disabled" readonly="readonly" required="required" maxlength="128" class="form-control" type="text" id="TransferCurrentFolderName" name="TransferCurrentFolderName">
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">Destination Folder</label>
                                <div class="col-md-10">
                                    <select style="width: 100%" id="DestinationFolder" name="DestinationFolder" class="form-control select2">

                                    </select>
                                </div>
                            </div>

                            <div class="form-group row">
                                <label class="col-md-2 col-form-label">&nbsp;</label>
                                <div class="col-md-10">
                                    <div>
                                        <button onclick="ConfirmDocumentTransfer();" name="btnTransferDocument" id="btnTransferDocument" type="submit" class="btn btn-primary waves-effect waves-light width-md">Transfer Document</button>
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
            <h4 class="page-title mb-0 font-size-18">Manage Document</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Document</a></li>
                    <li class="breadcrumb-item active">Manage</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">

    <div class="col-12">
        <?php
            $remark = null;
            $state  = null;
            session_start();

            if (array_key_exists('remark', $_SESSION)) {
                $remark = $_SESSION['remark'];
            }

            if (array_key_exists('state', $_SESSION)) {
                $state  = $_SESSION['state'];
            }

            if (isset($remark) && $state === false) {
        ?>

        <div id="WarningDiv" class="alert alert-warning alert-dismissible fade show" role="alert">
            <?php echo $remark; ?>
            <?php
                if (array_key_exists('remark', $_SESSION)) {
                    unset($_SESSION['remark']);
                }
            ?>
            <?php unset($_SESSION['state']); ?>
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <?php } ?>

        <?php if (isset($remark) && $state === true) { ?>
            <div id="SuccessDiv" class="alert alert-success alert-dismissible fade show" role="alert">
                <?php echo $remark; ?>
                <?php unset($_SESSION['remark']); ?>
                <?php unset($_SESSION['state']); ?>
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        <?php } ?>

        <div id="MessageDiv" class="alert alert-danger alert-dismissible fade show" role="alert">

            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div class="card">
            <div class="card-body">

                <h4 class="card-title">Document Management</h4>
                <p class="card-title-desc"><a onclick="GetAvailableDocuments()" href="#" class="card-link">Refresh</a></p>

                <form id = "frmDownload" method = "post" action="<?php echo base_url('Document/DownloadDocumentsAsZip');?>">
                        <table id="datatable" class="table table-bordered dt-responsive nowrap">
                            <thead>
                            <tr>
                                <th><input type="checkbox" name="checkedAll" id="checkedAll" /></th>
                                <th>Name</th>
                                <th>Folder</th>
                                <th>Uploaded Date</th>
                                <th>Version</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                            </thead>

                            <tbody>

                            </tbody>
                        </table>
                    </form>
                    <button id="DownloadAsZip" onclick="DownloadAsZip()" name="DownloadAsZip" type="button" class="btn btn-primary waves-effect waves-light">Download As Zip</button>
            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->

<div id="formSection"></div>

<!-- end row -->
<?php $this->endSection() ?>
