$(document).ready(function () {
    $('#MessageDiv').hide();
    $('#spinner').hide();

    $("#user_list").select2({
        placeholder: "Choose...",
        allowClear: false
    });

    $("#group_list").select2({
        placeholder: "Choose...",
        allowClear: false
    });

    $('#folder').select2({
       placeholder: "Choose a folder...",
       allowClear : false
    });

    getAvailableGroups();
    getAvailableUsers();

    $("a").click(function(event) {
        let value = $(this).html();
        if (value === 'Finish') {
            let fileChosen     = $('#file').val();
            let selectedFolder = $('#folder option:selected').val();
            let fileName       = $('#file_name').val();
            if (fileChosen === '') {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html('Please ensure you have selected a document to upload in step 1');
                $('#MessageDiv').show();
            } else if (fileName === '') {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html('Please ensure you have assigned a name to the file in step 1');
                $('#MessageDiv').show();
            } else if (selectedFolder === '') {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html('Please ensure you have selected a folder in step 2');
                $('#MessageDiv').show();
            } else {
                DoFileUpload();
            }
        }
    });
});

function ClearFields() {
    $('#keyword').val('');
    $('#folder').prop('selectedIndex', 0);
    $('#file').val('');
    $('#file_name').val();
    $('#comment').val('');
}

function DoFileUpload() {
    let form = $("#form-horizontal");
    // you can't pass Jquery form it has to be javascript form object
    let formData = new FormData(form[0]);

    $('#spinner').show();
    $('#form-horizontal').hide();

    $.ajax({
        type: "POST",
        "url": '../Document/UploadNewDocument',
        dataType: 'json',
        data: formData,
        contentType: false,
        processData: false,
        error: function (response) {
            if (response !== null) {
                $('#MessageDiv').html(response.remark);
            } else {
                $('#MessageDiv').html('Something went wrong while processing your request');
            }
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').show();
            $('#spinner').hide();
            $('#form-horizontal').show();
        },
        success: function (response) {
            if (response.state) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').show();
                $('#spinner').hide();
                $('#FormBody').hide();
                ClearFields();
            } else {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').show();
                $('#spinner').hide();
                $('#form-horizontal').show();
            }
        }
    });
}