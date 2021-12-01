$(document).ready(function () {
    $('#SearchKeyword').focus();
    $('#MessageDiv').hide();
    GetAvailableFolders();
    GetAvailableOwners();
    $('#Loader').hide();
});

function DownloadDocument(id) {
    $(location).attr('href','../Document/DownloadDocument/' + id);
}

function SearchDocument() {
    $("#btnSearch").attr("disabled", true);
    $('#SearchForm').hide();
    $.ajax({
        type: 'POST',
        url: '../Document/SearchDocument',
        dataType: 'json',
        data: {
            "Keywords"  : $('#SearchKeyword').val(),
            "Folder"    : $('#Folder option:selected').val(),
            "UserId"    : $('#User option:selected').val(),
            "StartDate" : $('#StartDate').val(),
            "EndDate"   : $('#EndDate').val()
        },
        success: function (response) {
            $('#btnSearch').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#SearchForm').show();
            if (response.state) {
                $('#SearchResultModal').modal();
                $('#MessageDiv').hide();

                $('#SearchResultModalDiv').html(response.remark);

                $('#datatable').show();
                let t = $('#datatable').DataTable();
                t.clear().draw();

                let resultSet = response.payload.result_set;

                for (let i = 0; i < resultSet.length; i++) {
                    let fileName = '';
                    if (resultSet[i].extension !== '') {
                        fileName = resultSet[i].file_name + '.' + resultSet[i].extension;
                    } else {
                        fileName = resultSet[i].file_name
                    }

                    t.row.add([
                        fileName,
                        resultSet[i].folder_name,
                        resultSet[i].date_uploaded,
                        resultSet[i].version,
                        resultSet[i].file_size,
                        `<button onclick="DownloadDocument(${resultSet[i].id});"  type="button" class="btn btn-primary waves-effect waves-light width-md">Download</button>`,
                    ]).draw(true);
                }
            }
            else {
                $('#MessageDiv').html(response.remark);
                $('#btnSearch').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $("#SearchKeyword").focus();
            }
        },
        error: function () {
            $('#SearchForm').show();
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#btnSearch').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $("#FolderName").focus();
        }
    });
}

function GetAvailableOwners() {
    $.ajax({
        type: "GET",
        url: "../Folder/GetAvailableOwners",
        success: function (response) {
            $('#User').empty();
            $("#User").append('<option value="">Select a user to search documents which they uploaded</option>');
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.length; i++) {
                let fullName = jsonResponse[i].first_name + ' ' + jsonResponse[i].last_name + ' (' + jsonResponse[i].email_address + ')';
                $('#User').append('<option value="' + jsonResponse[i].id + '">' + fullName + '</option>');
            }
        },
        error: function () {
            $('#User').empty();
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching available users');
            $('#MessageDiv').show();
        }
    });
}

function GetAvailableFolders() {
    $.ajax({
        type: "GET",
        url: "../Folder/GetAvailableFolders",
        success: function (response) {
            $('#Folder').empty();
            $("#Folder").append('<option value="">Select a folder to search in</option>');
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.length; i++) {
                if (jsonResponse[i].status_id > 0) {
                    if (jsonResponse[i].privilege >= 0) {
                        $('#Folder').append('<option value="' + jsonResponse[i].id + '">' + jsonResponse[i].name + '</option>');
                    }
                }
            }
        },
        error: function () {
            $('#Folder').empty();
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching available folders');
            $('#MessageDiv').show();
        }
    });
}