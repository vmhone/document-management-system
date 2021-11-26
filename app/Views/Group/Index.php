<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

<!-- start page title -->
<div class="row">
    <div class="col-12">
        <div class="page-title-box d-flex align-items-center justify-content-between">
            <h4 class="page-title mb-0 font-size-18">Create New Group</h4>

            <div class="page-title-right">
                <ol class="breadcrumb m-0">
                    <li class="breadcrumb-item"><a href="javascript: void(0);">Group</a></li>
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

                <h4 class="card-title">Group Details</h4>
                <p class="card-title-desc">Provide the details of the group</p>

                <div class="form-group row">
                    <label for="example-text-input" class="col-md-2 col-form-label">Name *</label>
                    <div class="col-md-10">
                        <input required="required" maxlength="45" class="form-control" type="text" id="GroupName" name="GroupName">
                    </div>
                </div>

                <div class="form-group row">
                    <label for="example-text-input" class="col-md-2 col-form-label">Comment</label>
                    <div class="col-md-10">
                        <input required="required" maxlength="128" class="form-control" type="text" id="GroupComment" name="GroupComment">
                    </div>
                </div>

                <div class="form-group row">
                    <label class="col-md-2 col-form-label">&nbsp;</label>
                    <div class="col-md-10">
                        <div>
                            <button onclick="CreateGroup();" name="btnCreate" id="btnCreate" type="submit" class="btn btn-primary waves-effect waves-light width-md">Create Group</button>
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
