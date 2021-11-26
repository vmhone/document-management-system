$(document).ready(function () {
    $('#MessageDiv').hide();
    $('#CurrentPassword').focus();
});

function ChangePassword() {
    $("#btnChangePassword").attr("disabled", true);
    $('#PasswordExpiredDiv').hide();
    $('#FirstLoginDiv').hide();
    $('#MessageDiv').hide();

    $.ajax({
        type: 'POST',
        url: '../Common/ChangePassword',
        dataType: 'json',
        data: {
            "CurrentPassword"    : $('#CurrentPassword').val(),
            "NewPassword"        : $('#NewPassword').val(),
            "ConfirmNewPassword" : $('#ConfirmNewPassword').val()
        },
        success: function (response) {
            $('#btnChangePassword').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#CurrentPassword').val('');
                $('#NewPassword').val('');
                $('#ConfirmNewPassword').val('');
                $("#CurrentPassword").focus();
            } else {
                $('#btnChangePassword').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $("#CurrentPassword").focus();
            }
        },
        error: function () {
            $('#btnChangePassword').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $("#CurrentPassword").focus();
        }
    });
}