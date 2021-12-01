<?php $this->extend('templates/admin_template') ?>
<?php $this->section('content') ?>
<?php require_once APPPATH . '/Models/UserRole.php'; ?>
<?php helper('number'); ?>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="page-title mb-0 font-size-18">Upload New Document</h4>

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

                <h4 class="card-title">Upload Wizard</h4>

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-body">

                                <div id="spinner" class="spinner-border text-primary m-1" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>

                                <form method="post" enctype="multipart/form-data" action="<?php echo base_url('Document/UploadNewDocument');?>" id="form-horizontal" class="form-horizontal form-wizard-wrapper" >
                                    <h3>Document Details</h3>
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group row">
                                                    <label for="txtFile" class="col-lg-3 col-form-label">Select a document</label>
                                                    <div class="col-lg-9">
                                                        <input required="required" type="file" id="file" name="file" class="form-control">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group row">
                                                    <label for="txtFile" class="col-lg-3 col-form-label">Document name</label>
                                                    <div class="col-lg-9">
                                                        <input maxlength="128" required="required" type="text" id="file_name" name="file_name" class="form-control">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </fieldset>
                                    <h3>Folder Selection</h3>
                                    <fieldset>
                                        <div class="row">
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
                                        </div>
                                    </fieldset>

                                    <h3>Document Keywords</h3>
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group row">
                                                    <label for="txnKeyWords" class="col-lg-3 col-form-label">Keywords (If Any)</label>
                                                    <div class="col-lg-9">
                                                        <input data-role="tagsinput" id="keyword" name="keyword" type="text" class="form-control">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group row">
                                                    <label for="txnComment" class="col-lg-3 col-form-label">Comments (If Any)</label>
                                                    <div class="col-lg-9">
                                                        <textarea id="comment" class="form-control" maxlength="128" rows="3" placeholder=""></textarea>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>

                                    <h3>Notification List</h3>
                                    <fieldset>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group row">
                                                    <label for="usersToNotify" class="col-lg-3 col-form-label">Users To Notify</label>
                                                    <div class="col-lg-9">
                                                        <select multiple id="user_list" name="user_list[]" style="width: 100%" class="select">
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label for="groupToNotify" class="col-lg-3 col-form-label">Groups To Notify</label>
                                                    <div class="col-lg-9">
                                                        <select multiple id="group_list" name="group_list[]" style="width: 100%" class="select">
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </fieldset>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->
                
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
                                            <td><?php echo number_to_size($used_quota['quota'], 2); ?></td>
                                            <td><?php echo number_to_size($assigned_quota - $used_quota['quota'], 2); ?></td>
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
