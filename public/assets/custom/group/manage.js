$(document).ready(function () {
    $("#GroupName").focus();
    $('#MessageDiv').hide();
    GetAvailableGroups();
});

function ShowGroupMembers(id) {
    $('#Group').val(id);
    $('#GroupMembersModal').modal();
    $('#GroupMembersMessageDiv').hide();
    $('#grantGroupID').val(id);
    FetchGroupMembers(id)
}

function ConfirmRevoke(group_id, user_id) {
    Swal.fire({
        title: "Confirmation",
        text: "Are you sure you want to remove the user from the group?",
        type: "question",
        allowEscapeKey: true,
        showCancelButton: !0,
        confirmButtonColor: "#31ce77",
        cancelButtonColor: "#f34943",
        confirmButtonText: "Yes"
    }).then(function (t) {
        t.value && RevokeAccessToGroup(group_id, user_id);
    });
}

function ConfirmGrant() {
    let userId  = $('#User option:selected').val();
    if (userId === '') {
        $('#GroupMembersMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#GroupMembersMessageDiv').html('Please ensure that you have selected a user from the drop down menu');
        $('#GroupMembersMessageDiv').show();
    } else {
        Swal.fire({
            title: "Confirmation",
            text: "Are you sure you want to add the user to the group?",
            type: "question",
            allowEscapeKey: true,
            showCancelButton: !0,
            confirmButtonColor: "#31ce77",
            cancelButtonColor: "#f34943",
            confirmButtonText: "Yes"
        }).then(function (t) {
            $('#GroupMembersMessageDiv').hide();
            t.value && GrantAccessToGroup();
        });
    }
}

function GrantAccessToGroup() {
    let groupId = $('#grantGroupID').val();
    let userId  = $('#User option:selected').val();
    $('#GroupMembersMessageDiv').hide();

    $.ajax({
        "type": 'POST',
        "url": '../GroupMembership/DoMemberOperation',
        data: {
            "UserID"    : userId,
            "GroupID"   : groupId,
            "Operation" : 1,
        },
        "dataType": 'json',
        success: function (result) {
            if (result.status) {
                $('#GroupMembersMessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#GroupMembersMessageDiv').html(result.remark);
                $('#GroupMembersMessageDiv').show();

                // refresh the data table
                FetchGroupMembers(groupId);

            } else {
                $('#GroupMembersMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#GroupMembersMessageDiv').html(result.remark);
                $('#GroupMembersMessageDiv').show();
            }
        },
        error: function () {
            $('#GroupMembersMessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#GroupMembersMessageDiv').html('Something went wrong while processing your request');
            $('#GroupMembersMessageDiv').show();
        }
    });
}

function RevokeAccessToGroup(group_id, user_id) {
    $('#GroupMembersMessageDiv').hide();

    $.ajax({
        "type": 'POST',
        "url": '../GroupMembership/DoMemberOperation',
        data: {
            "UserID"    : user_id,
            "GroupID"   : group_id,
            "Operation" : 0
        },
        "dataType": 'json',
        success: function (response) {
            if (response.status) {
                // refresh the data table
                FetchGroupMembers(group_id);

                $('#GroupMembersMessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#GroupMembersMessageDiv').html(response.remark);
                $('#GroupMembersMessageDiv').show();

            } else {
                $('#GroupMembersMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#GroupMembersMessageDiv').html(response.remark);
                $('#GroupMembersMessageDiv').show();
            }
        },
        error: function () {
            $('#GroupMembersMessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#GroupMembersMessageDiv').html('Something went wrong while processing your request');
            $('#GroupMembersMessageDiv').show();
        }
    });
}

function FetchGroupMembers(id) {
    $("#groupMembersTable > tbody").empty();
    GetAvailableUsers();
    $.ajax({
        type: 'GET',
        url: '../GroupMembership/GetGroupMemberShipById/' + id,
        dataType: 'json',
        success: function (response) {
            let t = $('#groupMembersTable').DataTable();
            t.clear().draw();

            t.destroy();

            t = $('#groupMembersTable').DataTable( {
                "pageLength": 5,
                "lengthChange": false,
                "info" : true
            } );

            for (let i = 0; i < response.returned_rows; i++) {
                t.row.add([
                    response.result_set[i].first_name + ' ' + response.result_set[i].last_name,
                    response.result_set[i].email_address,
                    response.result_set[i].humanized_time,
                    '<button onclick="ConfirmRevoke(' + response.result_set[i].id + ',' + response.result_set[i].user_id + ')" type="button" class="btn btn-danger waves-effect waves-light" type="submit">Remove</button>'
                ]).draw(true);
            }
            $('#groupMembersTable').DataTable().draw(true);
        },
        error: function () {
            $('#GroupMembersModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function GetAvailableUsers() {
    $.ajax({
        type: "GET",
        url: "../GroupMembership/GetAvailableUsers",
        success: function (response) {
            $('#User').empty();
            $("#User").append('<option value="">Select a user</option>');
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.result_set.length; i++) {
                let fullName = jsonResponse.result_set[i].first_name + ' ' + jsonResponse.result_set[i].last_name + ' - ' + jsonResponse.result_set[i].email_address;
                $('#User').append('<option value="' + jsonResponse.result_set[i].id + '">' + fullName + '</option>');
            }
        },
        error: function () {
            $('#User').empty();
            $('#GroupMembersModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching available users');
            $('#MessageDiv').show();
        }
    });
}

function ModifyGroup() {
    $('#ModifyModalMessageDiv').hide();

    let groupID      = $('#GroupID').val();
    let state        = $('#Status option:selected').val();
    let groupName    = $('#GroupName').val();
    let groupComment = $('#GroupComment').val();

    $('#MessageDiv').hide();

    $.ajax({
        "type": 'POST',
        "url": '../Group/ModifyGroup',
        data: {
            "GroupID"      : groupID,
            "GroupState"   : state,
            "GroupName"    : groupName,
            "GroupComment" : groupComment
        },
        "dataType": 'json',
        success: function (response) {
            if (response.status) {
                $('#modifyModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').show();

                // refresh the data table
                GetAvailableGroups();
            } else {
                $('#ModifyModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#ModifyModalMessageDiv').html(response.remark);
                $('#ModifyModalMessageDiv').show();
            }
        },
        error: function () {
            $('#ModalMessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#ModalMessageDiv').html(response.remark);
            $('#ModalMessageDiv').show();
        }
    });
}

function GetGroupDetails(id) {
    $('#ModifyModalMessageDiv').hide();
    $('#modifyModal').modal();
    $('#GroupID').val(id);

    $.ajax({
        "type": 'GET',
        "url": '../Group/GetGroupDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            if (response.result_set !== null) {
                $('#modifyModal').on('shown.bs.modal', function () {
                    $('#GroupName').focus();
                });

                $('#GroupName').val(response.result_set[0].group_name);
                $('#GroupComment').val(response.result_set[0].group_comment);
                $('#Status').val(response.result_set[0].group_state_flag);
            }
            else {
                $('#modifyModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while fetching the group details');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#modifyModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching the group details');
            $('#MessageDiv').show();
        }
    });

}

function GetAvailableGroups() {
    $.ajax({
        type: 'GET',
        url: '../Group/GetAvailableGroups',
        dataType: 'json',
        success: function (response) {

            $('#datatable').show();
            let t = $('#datatable').DataTable();
            t.clear().draw();

            if (response.length === 1) {
                t.destroy();

                t = $('#datatable').DataTable( {
                    scrollY:        '40vh',
                    scrollCollapse: false,
                } );
            }

            if (!response.status) {
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').show();
            } else {
                for (let i = 0; i < response.result_set.length; i++) {

                    if (response.result_set[i].group_state_flag > 0) {
                        t.row.add([
                            response.result_set[i].group_name,
                            response.result_set[i].group_comment,
                            response.result_set[i].humanized_time,
                            response.result_set[i].first_name + ' ' + response.result_set[i].last_name,
                            response.result_set[i].group_state,
                            `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Manage <i class="mdi mdi-chevron-down"></i>
                            </a>
              
                            <div class="dropdown-menu">
                            <a onclick="GetGroupDetails(${response.result_set[i].id});" class="dropdown-item" href="#">Group Properties</a>
                            <a onclick="ShowGroupMembers(${response.result_set[i].id});" class="dropdown-item" href="#">Manage Members</a>
                            </div>
                            </div>`
                        ]).draw(true);
                    } else {
                        t.row.add([
                            response.result_set[i].group_name,
                            response.result_set[i].group_comment,
                            response.result_set[i].humanized_time,
                            response.result_set[i].first_name + ' ' + response.result_set[i].last_name,
                            response.result_set[i].group_state,
                            `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Manage <i class="mdi mdi-chevron-down"></i>
                            </a>
              
                            <div class="dropdown-menu">
                            <a onclick="GetGroupDetails(${response.result_set[i].id});" class="dropdown-item" href="#">Group Properties</a>
                            </div>
                            </div>`
                        ]).draw(true);
                    }
                }
            }
        },
        error: function () {
            $('#datatable').hide();
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}