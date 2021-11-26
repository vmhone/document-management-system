<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

<!-- start page title -->
<div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <h4 class="page-title mb-0 font-size-18">Dashboard</h4>

                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript: void(0);">Dashboard</a></li>
                        <li class="breadcrumb-item active">Welcome</li>
                    </ol>
                </div>

            </div>
        </div>
    </div>
    <!-- end page title -->

    <div class="row">
        <div class="col-xl-3 col-md-6">
            <div class="card bg-info mini-stat position-relative">
                <div class="card-body">
                    <div class="mini-stat-desc">
                        <h6 class="text-uppercase text-white">Documents</h6>
                        <div class="text-white">
                            <h3 id="TotalDocuments" class="mb-3 mt-0"><?php echo $total_docs; ?></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-primary mini-stat position-relative">
                <div class="card-body">
                    <div class="mini-stat-desc">
                        <h6 class="text-uppercase text-white">Workspaces</h6>
                        <div class="text-white">
                            <h3 id="TotalFolders" class="mb-3 mt-0"><?php echo $total_folders; ?></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-success mini-stat position-relative">
                <div class="card-body">
                    <div class="mini-stat-desc">
                        <h6 class="text-uppercase text-white">Groups</h6>
                        <div class="text-white">
                            <h3 id="TotalGroups" class="mb-3 mt-0"><?php echo $total_groups; ?></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-md-6">
            <div class="card bg-dark mini-stat position-relative">
                <div class="card-body">
                    <div class="mini-stat-desc">
                        <h6 class="text-uppercase text-white">Active Users</h6>
                        <div class="text-white">
                            <h3 id="ActiveSessions" class="mb-3 mt-0 text-white"><?php echo $active_sessions; ?></h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end row -->

    <div class="row">
        <div id="FolderOverview" class="col-xl-12">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title mb-4">Workspace Overview</h4>
                    <div class="row align-items-center">
                        <div class="col-sm-6">
                            <div id="donut-chart" class="apex-charts"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div id="LatestFiles" class="col-xl-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title mb-4">Latest Files</h4>
                    <div class="table-responsive">
                        <table id="FileTable" class="table table-centered">
                            <thead class = "thead-light">
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">Uploaded By</th>
                                    <th scope="col">Uploaded Date</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div id="LatestFolders" class="col-xl-6">
            <div class="card">
                <div class="card-body">
                    <h4 class="card-title mb-4">Latest Workspaces</h4>
                    <div class="table-responsive">
                        <table id="FolderTable" class="table table-centered">
                            <thead class = "thead-light">
                                <tr>
                                    <th scope="col">Name</th>
                                    <th scope="col">Created By</th>
                                    <th scope="col">Created Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>
        <!-- end row -->
    </div>
    <!-- End Page-content -->
</div>

<?php $this->endSection() ?>