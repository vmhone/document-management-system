$(document).ready(function () {
    $('#MessageDiv').hide();
    $('#spinner').hide();
});

function SaveChanges() {
    let checkPasswordComplexity = $('#CheckPasswordComplexity option:selected').val();
    let lockOutTime = $('#LockOutTime').val();
    let maxNumberAttempts = $('#MaxNumberOfAttempts').val();
    let maxPasswordAge = $('#MaxPasswordAge').val();
    let maxRememberPasswords =  $('#MaxRememberPasswords').val();
    let minPasswordLength = $('#MinPasswordLength').val();
    let senderAddress = $('#SenderAddress').val();
    let systemID = $('#SystemID').val();
    let sessionTimeout = $('#SessionTimeout').val();
    let smtpHost = $('#SMTPHost').val();
    let smtpPassword = $('#SMTPPassword').val();
    let smtpPort = $('#SMTPPort').val();
    let smtpTimeout = $('#SMTPTimeout').val();
    let logPlatform = $('#LogPlatform option:selected').val();
    let smtpCrypto = $('#SMTPCrypto option:selected').val();
    let smtpUsername = $('#SMTPUsername').val();
    let noReplyAddress = $('#NoReplyAddress').val();

    $("#btnSave").attr("disabled", true);
    $('#spinner').show();
    $('#MessageDiv').hide();

    $.ajax({
        type: 'POST',
        url: '../SystemConfig/SaveChanges',
        dataType: 'json',
        data: {
            "CheckPasswordComplexity" : checkPasswordComplexity,
            "LockoutTime": lockOutTime,
            "MaxNumberAttempts" : maxNumberAttempts,
            "MaxPasswordAge" : maxPasswordAge,
            "MaxRememberPasswords" : maxRememberPasswords,
            "MinPasswordLength" : minPasswordLength,
            "SenderAddress" : senderAddress,
            "SystemID" : systemID,
            "SessionTimeout" : sessionTimeout,
            "SMTPHost" : smtpHost,
            "SMTPPassword" : smtpPassword,
            "SMTPPort" : smtpPort,
            "SMTPTimeout" : smtpTimeout,
            "LogPlatform" : logPlatform,
            "SMTPCrypto" : smtpCrypto,
            "SMTPUsername" : smtpUsername,
            "NoReplyAddress" : noReplyAddress
        },
        success: function (response) {
            $('#spinner').hide();
            $('#btnSave').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
            }
            else {
                $('#btnSave').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            }
            window.scrollTo({ top: 0, behavior: 'smooth' });
        },
        error: function () {
            $('#spinner').hide();
            $('#btnSave').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    });
}