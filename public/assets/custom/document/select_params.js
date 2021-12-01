function getAvailableUsers() {
    $.ajax({
        type: "GET",
        url: "../Folder/GetAvailableOwners",
        success: function (response) {
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.length; i++) {
                let fullName = jsonResponse[i].first_name + ' ' + jsonResponse[i].last_name + ' (' + jsonResponse[i].email_address + ')';
                $('#user_list').append('<option value="' + jsonResponse[i].id + '">' + fullName + '</option>');
            }
        },
        error: function () {
            $('#user_list').empty();
        }
    });
}

function getAvailableGroups() {
    $.ajax({
        type: "GET",
        url: "../Group/GetAvailableGroups",
        success: function (response) {
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.result_set.length; i++) {
                if (jsonResponse.result_set[i].group_state_flag > 0) {
                    $('#group_list').append('<option value="' + jsonResponse.result_set[i].id + '">' + jsonResponse.result_set[i].group_name + '</option>');
                }
            }
        },
        error: function () {
            $('#group_list').empty();
        }
    });
}

