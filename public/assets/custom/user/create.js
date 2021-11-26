function CreateUser() {
    $("#btnCreate").attr("disabled", true);
    $('#spinner').show();
    $('#MessageDiv').hide();

    $.ajax({
        type: 'POST',
        url: '../User/CreateUser',
        dataType: 'json',
        data: {
            "FirstName"    : $('#FirstName').val(),
            "LastName"     : $('#LastName').val(),
            "UserRole"     : $('#UserRole option:selected').val(),
            "EmailAddress" : $('#EmailAddress').val(),
            "TwoFactor"    : $('#TwoFactor option:selected').val(),
            "Quota"        : $('#Quota').val(),
        },
        success: function (response) {
            $('#btnCreate').removeAttr('disabled');
            $('#MessageDiv').show();
            $('#MessageDiv').html(response.remark);
            if (response.status) {
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $("#FirstName").focus();
                ResetFields();
                $('#spinner').hide();
            } else {
                $('#btnCreate').removeAttr('disabled');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $("#FirstName").focus();
                $('#spinner').hide();
            }
        },
        error: function () {
            $('#btnCreate').removeAttr('disabled');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $("#FirstName").focus();
            $('#spinner').hide();
        }
    });
}

function ResetFields() {
    $('#FirstName').val('');
    $('#LastName').val('');
    $('#EmailAddress').val('');
    $('#TwoFactor').val('-1');
    GetAvailableRoles();
}

function GetAvailableRoles(selectedRole = 0) {
    $.ajax({
        type: "GET",
        url: "../User/GetAvailableRoles",
        success: function (response) {
            $('#UserRole').empty();
            $("#UserRole").append('<option value="0">Select a role</option>');
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.length; i++) {
                if (selectedRole > 0 && selectedRole === jsonResponse[i].id) {
                    $('#UserRole').append('<option selected value="' + jsonResponse[i].id + '">' + jsonResponse[i].description + '</option>');
                } else {
                    $('#UserRole').append('<option value="' + jsonResponse[i].id + '">' + jsonResponse[i].description + '</option>');
                }
            }
        },
        error: function () {
            $('#UserRole').empty();
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching available users');
            $('#MessageDiv').show();
        }
    });
}