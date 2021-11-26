<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <h4 class="page-title mb-0 font-size-18">Create New Workspace</h4>

                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript: void(0);">Workspace</a></li>
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

                    <h4 class="card-title">Workspace Details</h4>
                    <p class="card-title-desc">Provide the details of the workspace</p>

                    <div class="form-group row">
                        <label for="example-text-input" class="col-md-2 col-form-label">Name *</label>
                        <div class="col-md-10">
                            <input required="required" maxlength="128" class="form-control" type="text" id="FolderName" name="FolderName">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="example-search-input" class="col-md-2 col-form-label">Comment</label>
                        <div class="col-md-10">
                            <input class="form-control" maxlength="255" type="text" id="FolderComment" name="FolderComment">
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">Owner</label>
                        <div class="col-md-10">
                            <select id="Owner" name="Owner" class="form-control select2">
                                <option value="">Select...</option>
                                <option value="">None</option>
                                <?php
                                foreach ($response['result_set']->getResult() as $row)
                                {
                                ?>
                                    <option value="<?php echo $row->id; ?>"><?php echo "{$row->first_name} {$row->last_name} - $row->email_address"; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">&nbsp;</label>
                        <div class="col-md-10">
                            <div>
                                <button onclick="CreateFolder();" name="btnCreate" id="btnCreate" type="submit" class="btn btn-primary waves-effect waves-light width-md">Create Workspace</button>
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
