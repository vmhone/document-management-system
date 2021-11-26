<?php $this->extend('templates/admin_template') ?>
<?php $this->section('content') ?>
<?php helper('number'); ?>
<?php require_once APPPATH . '/Models/UserRole.php'; ?>

<style>
  h3 {
    line-height: 30px;
    text-align: center;
  }
 
  #drop_file_area {
    height: 200px;
    border: 2px dashed #ccc;
    line-height: 200px;
    text-align: center;
    font-size: 20px;
    background: #f9f9f9;
    margin-bottom: 15px;
  }
 
  .drag_over {
    color: #000;
    border-color: #000;
  }
 
  .thumbnail {
    width: 100px;
    height: 100px;
    padding: 2px;
    margin: 2px;
    border: 2px solid lightgray;
    border-radius: 3px;
    float: left;
  }
 
  #upload_file {
    display: none;
  }
</style>

<div>
    <div class="row">
        <div class="col-sm-6 col-md-4 col-xl-3">
            <div id="FileUploadResultModal" class="modal fade bs-example-modal-xl" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">

                <div class="modal-dialog modal-xl">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title mt-0" id="myLargeModalLabel">Upload Results</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <input type="hidden" name="Group" id="Group" />
                        </div>
                        <div class="modal-body">
                            <div class="col-md-12 col-12">
                                <div class="responsive-table-plugin">
                                    <div class="table-rep-plugin">
                                        <br />
                                        <div class="table-responsive" data-pattern="priority-columns">
                                            <table id="fileUploadResultTable" class="table table-dark">
                                                <thead>
                                                <tr>
                                                    <th>File</th>
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
            <h4 class="page-title mb-0 font-size-18">Bulk Upload</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Document</a></li>
                    <li class="breadcrumb-item active">Upload New</li>
                </ol>
            </div>

        </div>
    </div>
</div>
<!-- end page title -->

<div class="row">

    <div class="col-12">

        <?php 
            $remaining_quota = $assigned_quota - $used_quota['quota'];
            if ($remaining_quota <= 0) {
        ?>

        <div class="alert alert-warning alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>You do not have available quota to upload new documents. Contact support if you think you shouldn't be seeing this message
        </div>
        
        <?php } else { ?>

        <div id="MessageDiv" class="alert alert-success alert-dismissible fade show" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>

        <div id="FormBody" class="card">
            <div class="card-body">

                <h4 class="card-title">Upload Multiple Documents</h4>

                <div class="progress">
                    <div class="progress-bar progress-bar-striped bg-success" id="ProgressBar" role="progressbar" style="width: 100%" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                </div>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">
                                
                                <div id="spinner" class="spinner-border text-primary m-1" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>

                                <input type="hidden" name="UserID" value="UserID" value="<?php echo $_SESSION['user_id']; ?> "/>

                                <div class="container">

                                    <div class="col-md-6">
                                        <div class="form-group row">
                                            <select id="folder" name="folder" style="width: 100%" class="select">
                                                <option value="">Choose...</option>
                                                <?php
                                                if (isset($available_folders['result_set'])) {
                                                    foreach ($available_folders['result_set'] as $folder)
                                                    {
                                                        if ((int) $folder['privilege'] === PrivilegeOptions::WRITE) { 
                                                        ?>
                                                        <option value="<?php echo $folder['id']; ?>"><?php echo "{$folder['name']}"; ?></option>
                                                    <?php } 
                                                    }
                                                } ?>
                                            </select>
                                        </div>
                                    </div>

                                    <div id="drop_file_area">
                                    Drag and Drop Files Here
                                    </div>
                                    <!--<div id="uploaded_file"></div>-->
                                    <button onclick="ShowResult();" name="btnUpload" id="btnUpload" type="button" class="btn btn-primary waves-effect waves-light width-md">Show Upload Result</button>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                </div>

                <?php if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) { ?>
                    <div class="responsive-table-plugin">
                        <div class="table-rep-plugin">
                            <br />
                            <div class="table-responsive" data-pattern="priority-columns">
                                <table id="quota" class="table table-dark">
                                    <thead>
                                    <tr>
                                        <th>Allocated Quota</th>
                                        <th>Used Quota</th>
                                        <th>Remaining Quota</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td><?php echo number_to_size($assigned_quota, 2); ?></td>
                                            <td><span id='UsedQuota'><?php echo number_to_size($used_quota['quota'], 2); ?></span></td>
                                            <td><span id='RemainingQuota'><?php echo number_to_size($assigned_quota - $used_quota['quota'], 2); ?></span></td>
                                        </tr>
                                    </tbody>
                                </table>
                                
                            </div> <!-- end table-responsive-->
                            Maximum File Size: <b><?php echo ini_get('upload_max_filesize') . 'B'; ?></b>
                        </div> <!-- table-rep-plugin-->
                    </div>
                <?php } ?>
            </div>

            </div>
        </div>
    </div>
    <!-- end col -->
</div>
<?php } ?>
<!-- end row -->

<!-- end row -->
<?php $this->endSection() ?>
