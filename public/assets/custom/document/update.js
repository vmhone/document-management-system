$(document).ready(function () {
    $("#user_list").select2({
        placeholder: "Choose...",
        allowClear: false
    });

    $("#group_list").select2({
        placeholder: "Choose...",
        allowClear: false
    });

    getAvailableGroups();
    getAvailableUsers();

    $('#MessageDiv').hide();
    $('#spinner').hide();
    $("a").click(function(event) {
        let value = $(this).html();
        if (value === 'Finish') {
            let fileChosen     = $('#file').val();
            if (fileChosen === '') {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html('Please ensure you have selected a document to upload in step 1');
                $('#MessageDiv').show();
            }
            else {
                DoFileUpload();
            }
        }
    });
});

function DoFileUpload() {
    let form = $("#form-horizontal");
    // submit the form at this point
    form.submit();
}