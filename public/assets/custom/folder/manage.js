$(document).ready(function () {
    $('#MessageDiv').hide();
    GetAvailableFolders();

    $("#SelectedUser").change(function () {
        var selectedUser = $(this).children("option:selected").val();
        var selectedFolder = $('#SelectedFolder').val();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: '../Privilege/GetPrivilegeAssignedToUserOnFolder',
            data: { 
                'FolderID': selectedFolder,
                'UserID' : selectedUser, 
            },
            success: function(response) {
                if (response.status) {
                   if (response.privilege >= 0) {
                       $('#SelectedPrivilegeUser').val(response.privilege);
                       if (response.is_owner) {
                            $("#btnGrantUser").attr("disabled", true);
                            // this is the owner of the folder
                            $('#GrantPrivilegesModalMessageDiv').html('You cannot modify the privileges for this user. They own the workspace');
                            $('#GrantPrivilegesModalMessageDiv').show();
                            $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-info alert-dismissible fade show');
                       } else {
                            $('#GrantPrivilegesModalMessageDiv').hide();
                            $('#btnGrantUser').removeAttr('disabled');
                       }
                   } else {
                       $('#GrantPrivilegesModalMessageDiv').hide();
                       $('#SelectedPrivilegeUser').val('');
                       $('#btnGrantUser').removeAttr('disabled');
                   }
                }
            },
            error: function() {
                $('#MessageDiv').show()
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while processing your request');
                $('#grantPrivilegesModal').modal('hide');
            }
       });
    });

    $("#SelectedGroup").change(function () {
        var selectedGroup = $(this).children("option:selected").val();
        var selectedFolder = $('#SelectedFolder').val();
        $('#MessageDiv').hide();

        $.ajax({
            type: "POST",
            dataType: 'json',
            url: '../Privilege/GetPrivilegeAssignedToGroupOnFolder',
            data: { 
                'FolderID': selectedFolder,
                'GroupID' : selectedGroup, 
            },
            success: function(response) {
                if (response.status) {
                   if (response.privilege >= 0) {
                       $('#SelectedPrivilege').val(response.privilege);
                   } else {
                       $('#SelectedPrivilege').val('');
                   }
                }
            },
            error: function() {
                $('#MessageDiv').show()
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while processing your request');
                $('#grantPrivilegesModal').modal('hide');
            }
       });
    });
});

function DisplayPrivileges(id) {
    $('#PrivilegesModalMessageDiv').hide();
    $('#privilegesModal').modal();

    // get privileges at group level
    $("#grantedGroups > tbody").empty();
    $.ajax({
        type: 'GET',
        url: '../Privilege/GetGroupAccessOnFolder/' + id,
        dataType: 'json',
        success: function (response) {
            let t = $('#grantedGroups').DataTable();
            t.clear().draw();

            for (let i = 0; i < response.length; i++) {
                var currentPrivilege = '';
                if (response[i].privilege == 0) {
                    currentPrivilege = 'READ';
                } else if (response[i].privilege == 1) {
                    currentPrivilege = 'WRITE';
                } else {
                    currentPrivilege = 'NO ACCESS';
                }
                t.row.add([
                    response[i].group_name,
                    currentPrivilege,
                    response[i].created_date
                ]).draw(true);
            }
            $('#grantedGroups').DataTable().draw(true);
        },
        error: function () {
            $('#privilegesModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });

    $("#grantedUsers > tbody").empty();
    $.ajax({
        type: 'GET',
        url: '../Privilege/GetUserAccessOnFolder/' + id,
        dataType: 'json',
        success: function (response) {
            let t = $('#grantedUsers').DataTable();
            t.clear().draw();

            for (let i = 0; i < response.length; i++) {
                var currentPrivilege = '';
                if (response[i].privilege == 0) {
                    currentPrivilege = 'READ';
                } else if (response[i].privilege == 1) {
                    currentPrivilege = 'WRITE';
                } else {
                    currentPrivilege = 'NO ACCESS';
                }

                let fullName = response[i].is_owner ? response[i].name + ' (Owner)' : response[i].name;

                t.row.add([
                    fullName,
                    response[i].email_address,
                    currentPrivilege,
                    response[i].created_date
                ]).draw(true);
            }
            $('#grantedGroups').DataTable().draw(true);
        },
        error: function () {
            $('#privilegesModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function DisplayModifyFolderModal(id) {
    $('#modifyModal').modal();
    $('#ModifyModalMessageDiv').hide();
    $('#MessageDiv').hide();

    $.ajax({
        "type": 'GET',
        "url": '../Workspace/GetWorkspaceDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            $('#ModifyFolderName').val(response.name);
            $('#ModifyFolderID').val(id);
            GetFolderStates(response.folder_state_id);
        },
        error: function () {
            $('#folderDetailsModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html(response.remark);
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
            if (!response.status) {
                $('#folderDetailsModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').show();
            } else {
                $('#SelectedGroup').empty();
                $("#SelectedGroup").append('<option value="">Select a group...</option>');
                for (let i = 0; i < response.result_set.length; i++) {
                    if (response.result_set[i].group_state_flag > 0) {
                        $('#SelectedGroup').append('<option value="' + response.result_set[i].id + '">' + response.result_set[i].group_name + '</option>');
                    }
                }
            }
        },
        error: function () {
            $('#grantPrivilegesModal').modal('hide');
            $('#SelectedGroup').empty();
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
            $('#SelectedUser').empty();
            $("#SelectedUser").append('<option value="">Select a user...</option>');
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.result_set.length; i++) {
                let fullName = jsonResponse.result_set[i].first_name + ' ' + jsonResponse.result_set[i].last_name + ' - ' + jsonResponse.result_set[i].email_address;
                $('#SelectedUser').append('<option value="' + jsonResponse.result_set[i].id + '">' + fullName + '</option>');
            }
        },
        error: function () {
            $('#grantPrivilegesModal').modal('hide');
            $('#SelectedUser').empty();
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function DisplayGrantPrivilegesModal(id) {
    $('#GrantPrivilegesModalMessageDiv').hide();
    GetAvailableGroups();
    GetAvailableUsers();
    $('#grantPrivilegesModal').modal();
    $('#SelectedFolder').val(id);
    $('#SelectedPrivilege').val('');
}

function ConfirmGrantPrivilegeToGroup() {
    var selectedPrivilege = $('#SelectedPrivilege').val();
    var selectedGroup = $('#SelectedGroup option:selected').val();

    if (selectedGroup === '') {
        $('#GrantPrivilegesModalMessageDiv').show();
        $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#GrantPrivilegesModalMessageDiv').html('Please select a group from the drop down menu');
    } else if (selectedPrivilege === '') {
        $('#GrantPrivilegesModalMessageDiv').show();
        $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#GrantPrivilegesModalMessageDiv').html('Please select a privilege from the drop down menu');
    } else {
        $('#GrantPrivilegesModalMessageDiv').hide();
        Swal.fire({
            title: "Confirm",
            text: "Proceed to modify the privilege on the group?",
            type: "info",
            allowEscapeKey: true,
            showCancelButton: !0,
            confirmButtonColor: "#31ce77",
            cancelButtonColor: "#f34943",
            confirmButtonText: "Yes"
        }).then(function (t) {
            t.value && SubmitGrantRequestForGroup();
        });
    }
}

function ConfirmGrantPrivilegeToUser() {
    var selectedPrivilege = $('#SelectedPrivilegeUser option:selected').val();
    var selectedUser = $('#SelectedUser option:selected').val();

    if (selectedUser === '') {
        $('#GrantPrivilegesModalMessageDiv').show();
        $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#GrantPrivilegesModalMessageDiv').html('Please select a user from the drop down menu');
    } else if (selectedPrivilege === '') {
        $('#GrantPrivilegesModalMessageDiv').show();
        $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#GrantPrivilegesModalMessageDiv').html('Please select a privilege from the drop down menu');
    } else {
        $('#GrantPrivilegesModalMessageDiv').hide();
        Swal.fire({
            title: "Confirm",
            text: "Proceed to modify the privilege on the user?",
            type: "info",
            allowEscapeKey: true,
            showCancelButton: !0,
            confirmButtonColor: "#31ce77",
            cancelButtonColor: "#f34943",
            confirmButtonText: "Yes"
        }).then(function (t) {
            t.value && SubmitGrantRequestForUser();
        });
    }
}

function SubmitGrantRequestForUser() {
    var selectedPrivilege = $('#SelectedPrivilegeUser option:selected').val();
    var selectedUser = $('#SelectedUser option:selected').val();
    var selectedFolder = $('#SelectedFolder').val();
    var grantType = 1;
    $('#MessageDiv').hide();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: '../Privilege/ModifyPrivilegeOnFolder',
        data: { 
            'FolderID': selectedFolder,
            'SelectedUser' : selectedUser, 
            'GrantType' : grantType,
            'SelectedPrivilege' : selectedPrivilege
        },
        success: function(response) {
            $('#GrantPrivilegesModalMessageDiv').html(response.remark);
            $('#GrantPrivilegesModalMessageDiv').show();
            if (response.state) {
                $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                GetAvailableFolders();
            } else {
                $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            }
        },
        error: function() {
            $('#MessageDiv').show()
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#grantPrivilegesModal').modal('hide');
        }
   });
}

function SubmitGrantRequestForGroup() {
    var selectedPrivilege = $('#SelectedPrivilege option:selected').val();
    var selectedGroup = $('#SelectedGroup option:selected').val();
    var selectedFolder = $('#SelectedFolder').val();
    var grantType = 0;
    $('#MessageDiv').hide();

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: '../Privilege/ModifyPrivilegeOnFolder',
        data: { 
            'FolderID': selectedFolder,
            'GroupID' : selectedGroup, 
            'GrantType' : grantType,
            'SelectedPrivilege' : selectedPrivilege
        },
        success: function(response) {
            $('#GrantPrivilegesModalMessageDiv').html(response.remark);
            $('#GrantPrivilegesModalMessageDiv').show();
            if (response.state) {
                $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                GetAvailableFolders();
            } else {
                $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            }
        },
        error: function() {
            $('#MessageDiv').show()
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#grantPrivilegesModal').modal('hide');
        }
   });
}

function ConfirmModify() {
    let state = $('#Status option:selected').val();
    if (state === '') {
        $('#ModifyModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#ModifyModalMessageDiv').html('Please select a workspace status from the drop-down');
        $('#ModifyModalMessageDiv').show();
    } else {
        Swal.fire({
            title: "Confirm",
            text: "Proceed to change the workspace status?",
            type: "info",
            allowEscapeKey: true,
            showCancelButton: !0,
            confirmButtonColor: "#31ce77",
            cancelButtonColor: "#f34943",
            confirmButtonText: "Yes"
        }).then(function (t) {
            t.value && ModifyFolder();
        });
    }
}

function ModifyFolder() {
    $('#ModifyModalMessageDiv').hide();

    let folderID = $('#ModifyFolderID').val();
    let state    = $('#Status option:selected').val();

    $('#MessageDiv').hide();

    $.ajax({
        "type": 'POST',
        "url": '../Workspace/ModifyWorkspace',
        data: {
            "FolderID" : folderID,
            "State"    : state
        },
        "dataType": 'json',
        success: function (response) {
            if (response.status) {
                $('#modifyModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').show();

                // refresh the data table
                GetAvailableFolders();
            }
            else {
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

function GetFolderStates(state) {
    $('#Status').empty();
    $.ajax({
        type: "GET",
        url: "../Workspace/GetWorkspaceStates",
        dataType: 'json',
        success: function (response) {
            $('#Status').empty();
            $("#Status").append('<option value="">Select a status for the workspace</option>');

            for (let i = 0; i < response.length; i++) {
                if (response[i].row_id === state) {
                    $('#Status').append('<option selected value="' + response[i].row_id + '">' + response[i].description + '</option>');
                }
                else {
                    $('#Status').append('<option value="' + response[i].row_id + '">' + response[i].description + '</option>');
                }
            }
        },
        error: function () {
            $('#Status').empty();
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request. Try again later');
            $('#MessageDiv').show();
            $("#btnModify").attr("disabled", true);
        }
    });
}

function DisplayFolderDetailsModal(id) {
    $('#MessageDiv').hide();
    $('#FolderDetailsModalMessageDiv').hide();
    $('#folderDetailsModal').modal();
    GetAvailableFiles(id);
    $.ajax({
        "type": 'GET',
        "url": '../Workspace/GetWorkspaceDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            $('#FolderName').html(response.name);
            $('#CreatedDate').html(response.created_date);
            $('#CreatedBy').html(response.created_by + ' (' + response.creator_email_address + ')');
            $('#FolderStatus').html(response.folder_status);

            if (response.folder_owner !== null) {
                $('#FolderOwner').html(response.folder_owner + ' (' + response.owner_email_address + ')');
            } else {
                $('#FolderOwner').html(response.created_by + ' (' + response.creator_email_address + ')');
            }

            if (response.updated_date !== null) {
                $('#UpdatedDate').html(response.updated_date);
            }
            else {
                $('#UpdatedDate').html('Never');
            }
        },
        error: function () {
            $('#folderDetailsModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html(response.remark);
            $('#MessageDiv').show();
        }
    });
}

function GetAvailableFiles(id) {
    $("#availableFiles > tbody").empty();
    $.ajax({
        type: 'GET',
        url: '../Workspace/GetDocumentsInWorkspace/' + id,
        dataType: 'json',
        success: function (response) {
            let t = $('#availableFiles').DataTable();
            t.clear().draw();

            for (let i = 0; i < response.length; i++) {
                t.row.add([
                    response[i].file_name + '.' + response[i].extension,
                    response[i].file_size,
                    response[i].version,
                    response[i].first_name + ' ' + response[i].last_name,
                    response[i].date_uploaded,
                ]).draw(true);
            }

            $('#availableFiles').DataTable().draw(true);
        },
        error: function (errorMsg) {
            $('#folderDetailsModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function DisplayRenameModal(id) {
    $('#MessageDiv').hide();
    $.ajax({
        "type": 'GET',
        "url": '../Workspace/GetWorkspaceDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            $('#CurrentFolderName').val(response.name);
            $('#ModalMessageDiv').html('');
            $('#ModalMessageDiv').hide();
            $('#FolderID').val(response.id);
            $('#renameModal').modal();
            $('#renameModal').on('shown.bs.modal', function () {
                $('#NewFolderName').focus();
            });
        },
        error: function () {
            $('#ModalMessageDiv').html('');
            $('#ModalMessageDiv').hide();
            $('#renameModal').hide();
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function RenameFolder() {
    $('#MessageDiv').hide();
    $.ajax({
        "type": 'POST',
        "url": '../Workspace/RenameWorkspace',
        data: {
            "CurrentFolderName" : $('#CurrentFolderName').val(),
            "NewFolderName" : $('#NewFolderName').val(),
            "FolderID"      : $('#FolderID').val()
        },
        "dataType": 'json',
        success: function (response) {
            if (response.status) {
                $('#renameModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                $('#MessageDiv').html(response.remark);
                $('#MessageDiv').show();
                $('#ModalMessageDiv').hide();
                $('#NewFolderName').val('');

                // refresh the data table
                GetAvailableFolders();
            }
            else {
                $('#ModalMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#ModalMessageDiv').html(response.remark);
                $('#ModalMessageDiv').show();
                $('#NewFolderName').val('');
            }
        },
        error: function () {
            $('#ModalMessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#ModalMessageDiv').html(response.remark);
            $('#ModalMessageDiv').show();
            $('#CurrentFolderName').focus();
            $('#NewFolderName').val('');
        }
    });
}

function GetAvailableFolders() {
    $.ajax({
        type: 'GET',
        url: '../Workspace/GetAvailableWorkspaces',
        dataType: 'json',
        success: function (response) {

            $('#datatable').show();
            let t = $('#datatable').DataTable();

            t.clear().draw().destroy();

            t = $('#datatable').DataTable( {
                scrollY:        '40vh',
                scrollCollapse: false,
            } );

            for (let i = 0; i < response.length; i++) {
                if (response[i].privilege == 1) {
                    t.row.add([
                        response[i].name,
                        response[i].file_count,
                        response[i].humanized_time,
                        response[i].created_by,
                        response[i].folder_status,
                        
                        `<div class="dropdown mt-4 mt-sm-0">
                        <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Options <i class="mdi mdi-chevron-down"></i>
                        </a>
                        
                        <div class="dropdown-menu">
                        <a onclick="DisplayFolderDetailsModal(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                        <a onclick="DisplayModifyFolderModal(${response[i].id});" class="dropdown-item" href="#">Modify Workspace</a>
                        <a onclick="DisplayRenameModal(${response[i].id});" class="dropdown-item" href="#">Rename Workspace</a>
                        <a onclick="DisplayGrantPrivilegesModal(${response[i].id});" class="dropdown-item" href="#">Manage Privileges</a>
                        <a onclick="DisplayPrivileges(${response[i].id});" class="dropdown-item" href="#">View Privileges</a>
                        </div>
                        </div>`,
                    ]).draw(true);
                } else if (response[i].privilege == 0) {
                    t.row.add([
                        response[i].name,
                        response[i].file_count,
                        response[i].humanized_time,
                        response[i].created_by,
                        response[i].folder_status,
                        
                        `<div class="dropdown mt-4 mt-sm-0">
                        <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Options <i class="mdi mdi-chevron-down"></i>
                        </a>
                        
                        <div class="dropdown-menu">
                        <a onclick="DisplayFolderDetailsModal(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                        </div>
                        </div>`,
                    ]).draw(true);
                } else {
                    t.row.add([
                        response[i].name,
                        response[i].file_count,
                        response[i].humanized_time,
                        response[i].created_by,
                        response[i].folder_status,
                        
                        `<span class="badge badge-soft-danger font-size-14">No Access</span>`,
                    ]).draw(true);
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