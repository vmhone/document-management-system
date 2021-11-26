function ViewDetails(id) {
    $('#DocumentDetailsModal').modal();
    $('#DocumentDetailsModalDiv').hide();
    $.ajax({
        "type": 'GET',
        "url": '../Document/GetDocumentDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            if (response !== null) {
                $('#DocumentName').html(response[0].file_name);
                $('#FolderName').html(response[0].folder_name);
                $('#Version').html(response[0].version);
                $('#Extension').html(response[0].extension);
                $('#UploadedDate').html(response[0].date_uploaded);
                $('#UploadedBy').html(response[0].first_name + ' ' + response[0].last_name + ' (' + response[0].email_address + ')');
                $('#MimeType').html(response[0].mime_type);
                $('#State').html(response[0].state_desc);
                $('#Size').html(response[0].file_size);
                $('#Keywords').empty();

                if (response[0].keywords.result_set.length > 0) {
                    $('#Keywords').empty();
                    for (let i = 0; i < response[0].keywords.result_set.length; i++) {
                        if (i - response[0].keywords.result_set === 1) {
                            $('#Keywords').append(response[0].keywords.result_set[i].keyword)
                        } else {
                            $('#Keywords').append(response[0].keywords.result_set[i].keyword + '<br />')
                        }
                    }
                } else {
                    $('#Keywords').html('None');
                }

                if (response[0].comment === '') {
                    $('#Comments').html('None')
                } else {
                    $('#Comments').html(response[0].comment);
                }
            } else {
                $('#DocumentDetailsModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while fetching the document details');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#DocumentDetailsModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching the document details');
            $('#MessageDiv').show();
        }
    });
}