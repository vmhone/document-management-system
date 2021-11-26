$(document).ready(function () {
    $("#MessageDiv").hide();
    $('#spinner').hide();
    GetAvailableUsers();

    $("#UserRole").change(function () {
        var selectedRole = $(this).children("option:selected").val();
        if (selectedRole > 1) {
            $('#QuotaDiv').show();
        } else {
            $('#QuotaDiv').hide();
        }
    });

});

function DisplayUserDetails(id) {
    $.ajax({
        "type": 'GET',
        "url": '../User/GetUserDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            if (response.length > 0) {
                $('#UserDetailsModal').modal();
                $('#FullName').html(response[0].first_name + ' ' + response[0].last_name);
                $('#Username').html(response[0].email_address);
                $('#LastLogin').html(response[0].last_login);
                $('#LastPasswordChange').html(response[0].last_password_change);
                $('#Role').html(response[0].description);
                $('#State').html(response[0].state);
                $('#CreatedDate').html(response[0].created_date);
                
                if (response[0].display_quota) {
                    $('#AllocatedQuota').html(response[0].allocated_quota);
                    $('#UsedQuota').html(response[0].used_quota);
                    $('#RemainingQuota').html(response[0].remaining_quota);
                } else {
                    $('#QuotaDiv').hide();
                }
            }
            else {
                $('#UserDetailsModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while fetching the user details');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#UserDetailsModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching the user details');
            $('#MessageDiv').show();
        }
    });
}

function ConfirmPasswordReset(id) {
    Swal.fire({
        title: "Confirmation",
        text: "Are you sure you want to reset the password?",
        type: "question",
        allowEscapeKey: true,
        showCancelButton: !0,
        confirmButtonColor: "#31ce77",
        cancelButtonColor: "#f34943",
        confirmButtonText: "Yes"
    }).then(function (t) {
        t.value && ResetUserPassword(id);
    });
}

function ResetUserPassword(id) {
    $('#spinner').show();
    $.ajax({
        type: 'POST',
        url: '../User/ResetPassword',
        dataType: 'json',
        data: {
            "UserId" : id
        },
        success: function (response) {
            $('#MessageDiv').show();
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#spinner').hide();
            }
            else {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#spinner').hide();
            }
        },
        error: function () {
            $('#MessageDiv').show();
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#spinner').hide();
        }
    });
}

function ModifyProfile() {
    $('#spinner').show();
    $('#ModifyUserMessageDiv').hide();
    $('#MessageDiv').hide();

    $.ajax({
        type: 'POST',
        url: '../User/ModifyProfile',
        dataType: 'json',
        data: {
            "UserId"        : $('#UserID').val(),
            "FirstName"     : $('#UserFirstName').val(),
            "LastName"      : $('#UserLastName').val(),
            "EmailAddress"  : $('#UserEmailAddress').val(),
            "Role"          : $('#UserRole option:selected').val(),
            "State"         : $('#UserStatus option:selected').val(),
            "TwoFactor"     : $('#TwoFactor option:selected').val(),
            "Quota"         : $('#Quota').val(),
        },
        success: function (response) {
            if (response.status) {
                $('#MessageDiv').show();
                $('#MessageDiv').html(response.remark);
                $('#ModifyUserModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#spinner').hide();
                GetAvailableUsers();
            }
            else {
                $('#ModifyUserMessageDiv').html(response.remark);
                $('#ModifyUserMessageDiv').show();
                $('#ModifyUserMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#spinner').hide();
            }
        },
        error: function () {
            $('#ModifyUserMessageDiv').show();
            $('#ModifyUserMessageDiv').html('Something went wrong while processing your request');
            $('#ModifyUserMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#spinner').hide();
        }
    });
}

function RenderModifyDialog(id) {
    $('#MessageDiv').hide();
    $.ajax({
        "type": 'GET',
        "url": '../User/GetUserDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            if (response.length > 0) {
                $('#FullName').html(response[0].first_name + ' ' + response[0].last_name);
                $('#Username').html(response[0].email_address);
                $('#LastLogin').html(response[0].last_login);
                $('#LastPasswordChange').html(response[0].last_password_change);
                $('#Role').html(response[0].description);
                $('#State').html(response[0].state);
                $('#CreatedDate').html(response[0].created_date);
                $('#UserFirstName').val(response[0].first_name);
                $('#UserLastName').val(response[0].last_name);
                $('#UserEmailAddress').val(response[0].email_address);
                GetAvailableRoles(response[0].role_id);
                $('#UserStatus').val(response[0].state_id);
                $('#Quota').val(Math.round(response[0].quota / 1024 / 1024,0));

                if (response[0].use_otp) {
                    $("#TwoFactor").val(1);
                } else {
                    $('#TwoFactor').val(0);
                }
            }
            else {
                $('#ModifyUserModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while fetching the user details');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#ModifyUserModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching the user details');
            $('#MessageDiv').show();
        }
    });

    $('#ModifyUserMessageDiv').hide();
    $('#UserID').val(id);
    $('#ModifyUserModal').modal();
    $('#ModifyUserModal').on('shown.bs.modal', function () {
        $('#UserFirstName').focus();
    });
}

function GetAvailableUsers() {
    $("#userTable > tbody").empty();
    $.ajax({
        type: 'GET',
        url: '../User/GetAvailableUsers',
        dataType: 'json',
        success: function (response) {
            let t = $('#userTable').DataTable();
            t.clear().draw();

            for (let i = 0; i < response.length; i++) {
                t.row.add([
                    response[i].first_name + ' ' + response[i].last_name,
                    response[i].email_address,
                    response[i].last_login,
                    response[i].description,
                    response[i].state,
                    `<div class="dropdown mt-4 mt-sm-0">
                    <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Manage <i class="mdi mdi-chevron-down"></i>
                    </a>
                    
                    <div class="dropdown-menu">
                    <a onclick="DisplayUserDetails(${response[i].id})" class="dropdown-item" href="#">View Details</a>
                    <a onclick="ConfirmPasswordReset(${response[i].id})" class="dropdown-item" href="#">Reset Password</a>
                    <a onclick="RenderModifyDialog(${response[i].id})" class="dropdown-item" href="#">Modify Profile</a>
                    </div>
                    </div>`
                ]).draw(true);
            }

            $('#userTable').DataTable().draw(true);
        },
        error: function () {
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}