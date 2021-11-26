$(document).ready(function () {
    $("#FolderName").focus();
    $('#MessageDiv').hide();
});

function CreateFolder() {
    $("#btnCreate").attr("disabled", true);
    $('#MessageDiv').hide();
    $.ajax({
        type: 'POST',
        url: '../Workspace/CreateNewWorkspace',
        dataType: 'json',
        data: {
            "FolderName" : $('#FolderName').val(),
            "FolderComment": $('#FolderComment').val(),
            "Owner" : $('#Owner option:selected').val()
        },
        success: function (response) {
            $('#btnCreate').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $("#FolderName").focus();
                ResetFields();
            }
            else {
                $('#btnCreate').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $("#FolderName").focus();
            }
        },
        error: function () {
            $('#btnCreate').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $("#FolderName").focus();
        }
    });
}

function ResetFields() {
    $('#FolderName').val('');
    $('#FolderComment').val('');
    $('#Owner').prop('selectedIndex', 0);
}