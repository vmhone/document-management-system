$(document).ready(function () {
    $("#GroupName").focus();
    $('#MessageDiv').hide();
});

function CreateGroup() {
    $("#btnCreate").attr("disabled", true);
    $('#MessageDiv').show();
    $.ajax({
        type: 'POST',
        url: '../Group/CreateGroup',
        dataType: 'json',
        data: {
            "GroupName"    : $('#GroupName').val(),
            "GroupComment" : $('#GroupComment').val()
        },
        success: function (response) {
            $('#btnCreate').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#GroupName').val('');
                $('#GroupComment').val('');
                $("#GroupName").focus();
            }
            else {
                $('#btnCreate').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $("#GroupName").focus();
            }
        },
        error: function () {
            $('#btnCreate').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $("#GroupName").focus();
        }
    });
}