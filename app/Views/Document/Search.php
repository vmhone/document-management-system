<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

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

                                    <h6><i class="fas fa-folder"></i> Workspace</h6>
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
            <div id="SearchResultModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Search Result</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">

                            <div id="SearchResultModalDiv" class="alert alert-success alert-dismissible fade show" role="alert">
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>

                            <div id="ResultTable" class="table-responsive">
                                <table id="datatable" class="table table-bordered dt-responsive nowrap">
                                    <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Workspace</th>
                                        <th>Uploaded Date</th>
                                        <th>Version</th>
                                        <th>File Size</th>
                                        <th>Action</th>
                                    </tr>
                                    </thead>

                                    <tbody>

                                    </tbody>
                                </table>
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
            <h4 class="page-title mb-0 font-size-18">Search for a document</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Document</a></li>
                    <li class="breadcrumb-item active">Search</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">

    <div class="col-12">
        <?php
        session_start();
        $remark = $_SESSION['remark'];
        $state  = $_SESSION['state'];
        if (isset($remark) && $state === false) {
            ?>

            <div id="WarningDiv" class="alert alert-danger alert-dismissible fade show" role="alert">
                <?php echo $remark; ?>
                <?php unset($_SESSION['remark']); ?>
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

        <div id="MessageDiv" class="alert alert-success alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div class="card" id="SearchArea">
            <div class="card-body">

                <h4 class="card-title">Search Details</h4>
                <p class="card-title-desc">Provide one or more search criteria</p>

                <div class="spinner-border text-primary m-1" id="Loader" role="status">
                    <span class="sr-only">Processing your request...</span>
                </div>

                <form id="SearchForm" class="form-horizontal">
                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Keywords</label>
                        <div class="col-md-10">
                            <input required="required" maxlength="128" class="form-control" type="text" id="SearchKeyword" name="SearchKeyword">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">Uploaded By</label>
                        <div class="col-md-10">
                            <select id="User" name="User" class="form-control select2">

                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">Workspace</label>
                        <div class="col-md-10">
                            <select id="Folder" name="Folder" class="form-control select2">

                            </select>
                        </div>
                    </div>

                    <div id="StartDateDiv" class="form-group row">
                        <label for="example-date-input" class="col-md-2 col-form-label">Start Date</label>
                        <div class="col-md-10">
                            <input class="form-control" type="date" name="StartDate" type="date" id="StartDate">
                        </div>
                    </div>

                    <div id="EndDateDiv" class="form-group row">
                        <label for="example-date-input" class="col-md-2 col-form-label">End Date</label>
                        <div class="col-md-10">
                            <input class="form-control" type="date" name="EndDate" type="date" id="EndDate">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">&nbsp;</label>
                        <div class="col-md-10">
                            <div>
                                <button name="btnSearch" id="btnSearch" type="button" onclick="SearchDocument();" class="btn btn-primary waves-effect waves-light width-md">Search</button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<!-- end row -->

<!-- end row -->
<?php $this->endSection() ?>
