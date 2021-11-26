<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="page-title mb-0 font-size-18">Update Existing Document</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Document</a></li>
                    <li class="breadcrumb-item active">Update Existing</li>
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

                                <form method="post" enctype="multipart/form-data" action="<?php echo base_url('Document/UpdateDocument');?>" id="form-horizontal" class="form-horizontal form-wizard-wrapper" >
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
                                                    <label for="txtFile" class="col-lg-3 col-form-label">Document Name</label>
                                                    <div class="col-lg-9">
                                                        <input readonly type="hidden" value="<?php echo $result_set[0]['id']; ?>" id="file_id" name="file_id" />
                                                        <input disabled value="<?php echo $result_set[0]['file_name']; ?>" readonly="readonly" required="required" type="text" id="FileName" name="FileName" class="form-control" />
                                                    </div>
                                                </div>
                                                <div class="form-group row">
                                                    <label for="txtFile" class="col-lg-3 col-form-label">Folder</label>
                                                    <div class="col-lg-9">
                                                        <input readonly type="hidden" value="<?php echo $result_set[0]['folder_id']; ?>" id="folder_id" name="folder_id" />
                                                        <input type="hidden" id="file_name" name="file_name" value="<?php echo $result_set[0]['file_name']; ?>" />
                                                        <input type="hidden" id="version" name="version" value="<?php echo $version; ?>" />
                                                        <input disabled value="<?php echo $result_set[0]['folder_name']; ?>" readonly="readonly" required="required" type="text" id="FolderName" name="FolderName" class="form-control" />
                                                    </div>
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
                Maximum File Size: <b><?php echo ini_get('upload_max_filesize') . 'B'; ?></b>
            </div>

        </div>
    </div>
</div>
<!-- end col -->
</div>
<!-- end row -->

<!-- end row -->
<?php $this->endSection() ?>
