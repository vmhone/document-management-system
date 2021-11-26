$(document).ready(function () {
    $("#FirstName").focus();
    $('#MessageDiv').hide();
    $('#QuotaDiv').hide();
    GetAvailableRoles();
    $('#spinner').hide();

    $("#UserRole").change(function () {
        var selectedRole = $(this).children("option:selected").val();
        if (selectedRole > 1) {
            $('#QuotaDiv').show();
        } else {
            $('#QuotaDiv').hide();
        }
    });
});