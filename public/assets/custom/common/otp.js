$(document).ready(function () {
    $('#otp').focus();
    GenerateOTP(0);
});

function VerifyOTP() {
    $("#btnVerify").attr("disabled", true);
    $("#otp").attr("disabled", true);
    $('#spinner').show();
    $('#MessageDiv').hide();
    $('#navBottom').hide();
    $('#btnVerify').html('Checking...');

    $.ajax({
        type: 'POST',
        url: '../Common/VerifyOTP',
        dataType: 'json',
        data: {
            "OTP" : $('#otp').val(),
        },
        success: function (response) {
            $('#btnVerify').html('Verify OTP');
            $('#btnVerify').removeAttr('disabled');
            $('#otp').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#navBottom').show()
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').hide();
                window.location.replace(response.redirect_url);
            } else {
                $('#btnVerify').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#otp').focus();
            }
        },
        error: function () {
            $('#navBottom').show();
            $("#otp").show();
            $('#btnVerify').html('Verify OTP');
            $('#otp').removeAttr('disabled');
            $('#btnVerify').html('Verify OTP');
            $('#btnVerify').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $("#otp").focus();
        }
    });
}

function GenerateOTP(is_resend = 0) {  
    if (is_resend == 1) {
        $("#btnVerify").attr("disabled", true);
        $("#otp").attr("disabled", true);
        $("#otp").hide();
        $('#btnVerify').html('Sending the OTP to your email address...');
        $('#spinner').show();
        $('#MessageDiv').hide();
        $('#navBottom').hide();
    } else {
        $('#MessageDiv').show();
    }

    $.ajax({
        type: 'POST',
        url: '../Common/GenerateOTP',
        dataType: 'json',
        success: function (response) {
            $('#btnVerify').html('Verify OTP');
            $("#otp").show();
            $('#btnVerify').removeAttr('disabled');
            $('#otp').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#navBottom').show();
            if (is_resend == 1) {
                $('#MessageDiv').html(response.remark);
                if (response.status) {
                    $('#MessageDiv').attr('class', 'alert alert-info alert-dismissible fade show');
                } else {
                    $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                }
            } else {
                $('#MessageDiv').html('Please enter the code that we have sent to your email address');
            }
            $('#otp').val('');
            $('#otp').focus();
        },
        error: function () {
            $('#navBottom').show();
            $("#otp").show();
            $('#otp').removeAttr('disabled');
            $('#btnVerify').html('Verify OTP');
            $('#btnVerify').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $("#otp").focus();
        }
    });
}

function ResendOTP() {
    GenerateOTP(1);
}