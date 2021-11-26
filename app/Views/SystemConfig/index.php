<?php $this->extend('templates/admin_template') ?>

<?php $this->section('content') ?>

    <!-- start page title -->
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-flex align-items-center justify-content-between">
                <h4 class="page-title mb-0 font-size-18">Settings</h4>

                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="javascript: void(0);">System</a></li>
                        <li class="breadcrumb-item active">Settings</li>
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

                    <h4 class="card-title">System Configuration</h4>
                    <p class="card-title-desc">&nbsp;</p>

                    <div id="spinner" class="spinner-border text-primary m-1" role="status">
                          <span class="sr-only">Loading...</span>
                    </div>


                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" data-toggle="tab" href="#password" role="tab">
                                <span class="d-block d-sm-none"><i class="fas fa-home"></i></span>
                                <span class="d-none d-sm-block">Password Settings</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#email" role="tab">
                                <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
                                <span class="d-none d-sm-block">Email Server Settings</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" data-toggle="tab" href="#general" role="tab">
                                <span class="d-block d-sm-none"><i class="far fa-user"></i></span>
                                <span class="d-none d-sm-block">General Settings</span>
                            </a>
                        </li>
                    </ul>

                     <!-- Tab panes -->
                     <div class="tab-content p-3 text-muted">
                        <div class="tab-pane active" id="password" role="tabpanel">
                            <p class="mb-0">
                            <div class="form-group row">
                            <label class="col-md-2 col-form-label">Check Password Strength</label>
                            <div class="col-md-10">
                                <div class="form-group row">
                                    <div class="col-md-12">
                                            <select style="width: 100%" id="CheckPasswordComplexity" class="form-control">
                                                <option>Select a value</option>
                                                <option <?php if($config['check_password_complexity'] == '1') { ?> selected="selected" <?php } ?> value="1">Enabled</option>
                                                <option <?php if($config['check_password_complexity'] == '0') { ?> selected="selected" <?php } ?> value="0">Disabled</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        <div class="form-group row">
                            <label for="example-text-input" class="col-md-2 col-form-label">Lockout Time (Min)</label>
                            <div class="col-md-10">
                                <input required="required" min="0" value="<?php echo $config['lockout_time']; ?>" class="form-control" type="number" id="LockOutTime" name="LockOutTime">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="example-text-input" class="col-md-2 col-form-label">Max Number Of Attempts</label>
                            <div class="col-md-10">
                                <input required="required" min="0" value="<?php echo $config['max_number_attempts']; ?>" class="form-control" type="number" id="MaxNumberOfAttempts" name="MaxNumberOfAttempts">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="example-text-input" class="col-md-2 col-form-label">Max Password Age (Days)</label>
                            <div class="col-md-10">
                                <input required="required" min="0" value="<?php echo $config['max_password_age']; ?>" class="form-control" type="number" id="MaxPasswordAge" name="MaxPasswordAge">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="example-text-input" class="col-md-2 col-form-label">Max Password History</label>
                            <div class="col-md-10">
                                <input required="required" min="0" value="<?php echo $config['max_remember_passwords']; ?>" class="form-control" type="number" id="MaxRememberPasswords" name="MaxRememberPasswords">
                            </div>
                        </div>

                        <div class="form-group row">
                            <label for="example-text-input" class="col-md-2 col-form-label">Min Password Length</label>
                            <div class="col-md-10">
                                <input required="required" min="4" value="<?php echo $config['min_password_length']; ?>" class="form-control" type="number" id="MinPasswordLength" name="MinPasswordLength">
                            </div>
                        </div>
                            <p></p>
                        </div>
                        <div class="tab-pane" id="email" role="tabpanel">
                            <p class="mb-0">
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">Sender Address</label>
                                    <div class="col-md-10">
                                        <input required="required" class="form-control" value="<?php echo $config['sender_address']; ?>" type="email" maxlength="80" id="SenderAddress" name="SenderAddress">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">No Reply Address</label>
                                    <div class="col-md-10">
                                        <input required="required" class="form-control" value="<?php echo $config['no_reply_address']; ?>" type="email" maxlength="80" id="NoReplyAddress" name="NoReplyAddress">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">SMTP Username</label>
                                    <div class="col-md-10">
                                        <input required="required" class="form-control" value="<?php echo $config['smtp_username']; ?>" type="text" maxlength="80" id="SMTPUsername" name="SMTPUsername">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">SMTP Host</label>
                                    <div class="col-md-10">
                                        <input required="required" class="form-control" value="<?php echo $config['smtp_host']; ?>" type="text" id="SMTPHost" name="SMTPHost">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">SMTP Password</label>
                                    <div class="col-md-10">
                                        <input required="required" class="form-control" value="<?php echo $config['smtp_password']; ?>" type="text" id="SMTPPassword" name="SMTPPassword">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">SMTP Port</label>
                                    <div class="col-md-10">
                                        <input type="number" min="0" required="required" class="form-control" value="<?php echo $config['smtp_port']; ?>" id="SMTPPort" name="SMTPPort">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">SMTP Timeout (Sec)</label>
                                    <div class="col-md-10">
                                        <input type="number" min="0" required="required" class="form-control" value="<?php echo $config['smtp_timeout']; ?>" id="SMTPTimeout" name="SMTPTimeout">
                                    </div>
                                </div>

                                <div class="form-group row">
                                <label class="col-md-2 col-form-label">Crypto Protocol</label>
                                <div class="col-md-10">
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                                <select required style="width: 100%" id="SMTPCrypto" class="form-control">
                                                    <option>Select a protocol</option>
                                                    <option <?php if(trim(strtolower($config['smtp_crypto'])) == '') { ?> selected="selected" <?php } ?> value="none">None</option>
                                                    <option <?php if(trim(strtolower($config['smtp_crypto'])) == 'tls') { ?> selected="selected" <?php } ?>value="tls">TLS</option>
                                                    <option <?php if(trim(strtolower($config['smtp_crypto'])) == 'ssl') { ?> selected="selected" <?php } ?> value="ssl">SSL</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </p>
                        </div>

                        <div class="tab-pane" id="general" role="tabpanel">
                            <p class="mb-0">
                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">System ID</label>
                                    <div class="col-md-10">
                                        <input maxlength="50" minlength="2" required="required" class="form-control" value="<?php echo $config['system_id']; ?>" type="text" id="SystemID" name="SystemID">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="example-text-input" class="col-md-2 col-form-label">Session Timeout (Min)</label>
                                    <div class="col-md-10">
                                        <input required="required" class="form-control" value="<?php echo $config['session_timeout']; ?>" type="number" min="1" id="SessionTimeout" name="SessionTimeout">
                                    </div>
                                </div>

                                <div class="form-group row">
                                <label class="col-md-2 col-form-label">Log Platform Details</label>
                                <div class="col-md-10">
                                    <div class="form-group row">
                                        <div class="col-md-12">
                                                <select style="width: 100%" id="LogPlatform" class="form-control">
                                                    <option>Select a value</option>
                                                    <option <?php if($config['log_platform'] == '1') { ?> selected="selected" <?php } ?> value="1">Enabled</option>
                                                    <option <?php if($config['log_platform'] == '0') { ?> selected="selected" <?php } ?> value="0">Disabled</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            </p>
                        </div>

                    </div>

                    <div class="form-group row">
                        <label class="col-md-2 col-form-label">&nbsp;</label>
                        <div class="col-md-10">
                            <div>
                                <button onclick="SaveChanges();" name="btnSave" id="btnSave" type="button" class="btn btn-primary waves-effect waves-light width-md">Save Changes</button>
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
