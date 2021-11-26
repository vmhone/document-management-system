$(document).ready(function () {
    $('#username').focus();
    $('#MessageDiv').hide();
});

function ConfirmPasswordReset() {
    Swal.fire({
        title: "Confirm Reset",
        text: "Proceed to reset the password for your profile?",
        type: "question",
        allowEscapeKey: true,
        showCancelButton: !0,
        confirmButtonColor: "#31ce77",
        cancelButtonColor: "#f34943",
        confirmButtonText: "Yes"
    }).then(function (t) {
        t.value && SubmitRequestToServer();
    });
}

function SubmitRequestToServer() {
    $("#btnConfirmReset").attr("disabled", true);
    $('#btnConfirmReset').html('Please wait...');
    $('#MessageDiv').hide();
    $('#ErrorMessageDiv').hide();
    $.ajax({
        type: 'POST',
        url: '../ResetPasswordUsingToken',
        dataType: 'json',
        data: {
            "UserId" : $('#UserID').val(),
            "Token"  : $('#Token').val()
        },
        success: function (response) {
            $('#MessageDiv').show();
            $('#btnConfirmReset').html('Reset');
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $("#btnConfirmReset").attr("disabled", true);
            } else {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#btnConfirmReset').removeAttr('disabled');
            }
        },
        error: function () {
            $('#btnConfirmReset').html('Reset');
            $('#btnConfirmReset').removeAttr('disabled');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
        }
    });
}

function InitiatePasswordReset() {
    $("#btnReset").attr("disabled", true);
    $('#btnReset').html('Please wait...');
    $('#spinner').show();
    $('#MessageDiv').hide();
    $('#ErrorMessageDiv').hide();
    $.ajax({
        type: 'POST',
        url: '../Common/InitiatePasswordReset',
        dataType: 'json',
        data: {
            "EmailAddress" : $('#username').val()
        },
        success: function (response) {
            $('#btnReset').html('Initiate password reset');
            $('#btnReset').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#username').val('');
                $('#username').focus();
            } else {
                $('#btnReset').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#username').focus();
            }
        },
        error: function () {
            $('#btnReset').html('Initiate password reset');
            $('#btnReset').removeAttr('disabled');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $("#username").focus();
        }
    });
}