$(document).ready(function () {
    $('#MessageDiv').hide();
    $('#FirstName').focus();
});

function PromptPassword() {

    let firstName = $('#FirstName').val();
    let lastName  = $('#LastName').val();

    if (firstName === '') {
        $('#MessageDiv').show();
        $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');4
        $('#MessageDiv').html('Please provide a first name');
        $('#FirstName').focus();
    } else if (lastName === '') {
        $('#MessageDiv').show();
        $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');4
        $('#MessageDiv').html('Please provide a last name');
        $('#LastName').focus();
    } else {
        $('#MessageDiv').hide();
        $('#PasswordModal').modal();
        $('#PasswordModal').on('shown.bs.modal', function () {
            $('#Password').focus();
        });
        $('#Password').val('');
    }
}

function SaveChanges() {
    $('#spinner').show();
    $.ajax({
        type: 'POST',
        url: '../User/ModifyProfile',
        dataType: 'json',
        data: {
            "UserId"        : $('#UserId').val(),
            "FirstName"     : $('#FirstName').val(),
            "LastName"      : $('#LastName').val(),
            "EmailAddress"  : $('#EmailAddress').val(),
            "Role"          : $('#Role').val(),
            "State"         : $('#State').val(),
            "TwoFactor"     : $('#TwoFactor option:selected').val(),
            "Password"      : $('#Password').val(),
            "Op"            : $('#Op').val(),
            "Quota"         : $('#AllocatedQuota').val(),
        },
        success: function (response) {
            if (response.status) {
                $('#MessageDiv').show();
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#spinner').hide();
                $('#PasswordModal').modal('hide');

                $('#ModalMessageDiv').show();
                $('#ModalMessageDiv').attr('class', 'alert alert-info alert-dismissible fade show');
                $('#ModalMessageDiv').html('To save the changes, enter your password');
            } else {
                $('#Password').focus();
                $('#ModalMessageDiv').html(response.remark);
                $('#ModalMessageDiv').show();
                $('#ModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#spinner').hide();
            }
        },
        error: function () {
            $('#Password').focus();
            $('#ModalMessageDiv').show();
            $('#ModalMessageDiv').html('Something went wrong while processing your request');
            $('#ModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#spinner').hide();
        }
    });
}