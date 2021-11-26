function HandleClickEvent() {
    var isAllChecked = 0;
    var checkCount = 0
    $(".checkSingle").each(function () {
        if (!this.checked) {
            isAllChecked = 1;
        } else {
            checkCount = checkCount + 1;
            $('html,body').animate({ scrollTop: 9999 }, 'slow');
        }
    });
    
    // all checkboxes selected
    if (isAllChecked == 0) {
        $("#checkedAll").prop("checked", true);
        $('#DownloadAsZip').show();
        $('html,body').animate({ scrollTop: 9999 }, 'slow');
    }

    if (checkCount > 0) {
        $('#DownloadAsZip').show();
        $('html,body').animate({ scrollTop: 9999 }, 'slow');
    } else {
        $('#DownloadAsZip').hide();
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
}

function DownloadAsZip() {
    let form = $("#frmDownload");
    // submit the form at this point
    form.submit();
}

$(document).ready(function () {
    $('#MessageDiv').hide();
    GetAvailableDocuments();
    $('#DownloadAsZip').hide();

    window.scrollTo({ top: 0, behavior: 'smooth' });

    $("#checkedAll").change(function () {
        if (this.checked) {
            $(".checkSingle").each(function () {
                this.checked = true;
                $('#DownloadAsZip').show();
            });
            $('html,body').animate({ scrollTop: 9999 }, 'slow');
        } else {
            $(".checkSingle").each(function () {
                this.checked = false;
                $('#DownloadAsZip').hide();
            });
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    });

    $("#SelectedUser").change(function () {
        var selectedUser = $(this).children("option:selected").val();
        var selectedDocument = $('#SelectedDocument').val();
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: '../Privilege/GetPrivilegeAssignedToUserOnDocument',
            data: { 
                'DocumentID': selectedDocument,
                'UserID' : selectedUser, 
            },
            success: function(response) {
                if (response.status) {
                   if (response.privilege >= 0) {
                       $('#SelectedPrivilegeUser').val(response.privilege);
                       if (response.is_owner) {
                            $("#btnGrantUser").attr("disabled", true);
                            // this is the owner of the folder
                            $('#GrantPrivilegesModalMessageDiv').html('You cannot modify the privileges for this user. They own the document');
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
        var selectedDocument = $('#SelectedDocument').val();
        $.ajax({
            type: "POST",
            dataType: 'json',
            url: '../Privilege/GetPrivilegeAssignedToGroupOnDocument',
            data: { 
                'DocumentID': selectedDocument,
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

function DisplayEmailModal(id) {
    $('#SendACopy').prop('checked', false);
    $("#Recipients").tagsinput('removeAll');
    $('#DocumentHistoryModal').modal('hide');
    $('#MessageDiv').hide();
    $('#EmailModal').modal();
    $('#EmailMessageDiv').hide();
    $('#EmailDocumentID').val(id);
    $('#Recipients').val('');
    $('#EmailModal').on('shown.bs.modal', function () {
        $('Recipients').tagsinput('focus');
        $('Recipients').focus();
    });
}

function SubmitEmailRequest() {
    let mailingList = $('#Recipients').val();
    if (mailingList.length <= 0) {
        $('#EmailMessageDiv').show();
        $('#EmailMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#EmailMessageDiv').html('Please ensure that you have specified one or more recipients');
        $('#Recipients').focus();
    } else {
        let sendToOwner = $('#SendACopy').is(":checked") ? 1 : 0;
        let receipients = $('#Recipients').val().split(",");
        let isError = false;
        let emailRegex = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
        
        for (i = 0; i < receipients.length; i++) {
            if (!emailRegex.test(receipients[i])) {
                $('#EmailMessageDiv').html('The input ' + receipients[i] +  ' is not a valid email address. Please check');
                $('#Recipients').focus();
                isError = true;
            }
        }

        if (!isError) {
            $('#EmailMessageDiv').hide();
            let documentID = $('#EmailDocumentID').val();
            $("#btnEmail").attr("disabled", true);

            $.ajax({
                "type": 'POST',
                "url": '../Document/SendDocumentViaEmail',
                data: {
                    "Recipients"     : mailingList,
                    "DocumentID"     : documentID,
                    "IncludeSender"  : sendToOwner
                },
                "dataType": 'json',
                success: function (response) {
                    $('#btnEmail').removeAttr('disabled');
                    if (response !== null) {
                        if (response.state) {
                            $('#EmailModal').modal('hide');
                            $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                            $('#MessageDiv').html(response.remark);
                            $('#MessageDiv').show();
                            $("#Recipients").tagsinput('removeAll');
                            $('#SendACopy').prop('checked', false);
                        } else {
                            $('#EmailMessageDiv').show();
                            $('#EmailMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                            $('#EmailMessageDiv').html(response.remark);
                        }
                    } else {
                        $('#EmailMessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                        $('#EmailMessageDiv').html('Something went wrong while processing your request');
                        $('#EmailMessageDiv').show();
                    }
                },
                error: function () {
                    $('#btnEmail').removeAttr('disabled');
                    $('#EmailMessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                    $('#EmailMessageDiv').html('Something went wrong while processing your request');
                    $('#EmailMessageDiv').show();
                }
            });
        }
    }
}

function DisplayPrivileges(id) {
    $('#PrivilegesModalMessageDiv').hide();
    $('#privilegesModal').modal();

    // get privileges at group level
    $("#grantedGroups > tbody").empty();
    $.ajax({
        type: 'GET',
        url: '../Privilege/GetGroupAccessOnDocument/' + id,
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
        url: '../Privilege/GetUserAccessOnDocument/' + id,
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

function GetAvailableGroups() {
    $.ajax({
        type: 'GET',
        url: '../Group/GetAvailableGroups',
        dataType: 'json',
        success: function (response) {
            if (!response.status) {
                $('#documentDetailsModal').modal('hide');
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
    $('#SelectedDocument').val(id);
    $('#SelectedPrivilege').val('');
    $('#SelectedPrivilegeUser').val('');
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
    $('#MessageDiv').hide();

    var selectedPrivilege = $('#SelectedPrivilegeUser option:selected').val();
    var selectedUser = $('#SelectedUser option:selected').val();
    var selectedDocument = $('#SelectedDocument').val();
    var grantType = 1;

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: '../Privilege/ModifyPrivilegeOnDocument',
        data: { 
            'DocumentID': selectedDocument,
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
    var selectedDocument = $('#SelectedDocument').val();
    var grantType = 0;

    $('#MessageDiv').hide()

    $.ajax({
        type: "POST",
        dataType: 'json',
        url: '../Privilege/ModifyPrivilegeOnDocument',
        data: { 
            'DocumentID': selectedDocument,
            'GroupID' : selectedGroup, 
            'GrantType' : grantType,
            'SelectedPrivilege' : selectedPrivilege
        },
        success: function(response) {
            $('#GrantPrivilegesModalMessageDiv').html(response.remark);
            $('#GrantPrivilegesModalMessageDiv').show();
            if (response.state) {
                $('#GrantPrivilegesModalMessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                GetAvailableDocuments();
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

function DownloadDocument(id) {
    $(location).attr('href','../Document/DownloadDocument/' + id);
}

function RenderDocument(id) {
    window.open('../Document/RenderDocument/' + id, '', '_blank');
}

function ConfirmArchiveDocument(id) {
    $('#MessageDiv').hide();
    Swal.fire({
        title: "Confirm Operation",
        text: "Proceed to archive the document?",
        type: "question",
        allowEscapeKey: true,
        showCancelButton: !0,
        confirmButtonColor: "#31ce77",
        cancelButtonColor: "#f34943",
        confirmButtonText: "Yes"
    }).then(function (t) {
        t.value && ChangeDocumentState(id, '0');
    });
}

function ConfirmRestoreDocument(id) {
    $('#MessageDiv').hide();
    Swal.fire({
        title: "Confirm Operation",
        text: "Proceed to restore the document?",
        type: "question",
        allowEscapeKey: true,
        showCancelButton: !0,
        confirmButtonColor: "#31ce77",
        cancelButtonColor: "#f34943",
        confirmButtonText: "Yes"
    }).then(function (t) {
        t.value && ChangeDocumentState(id, '1');
    });
}

function ChangeDocumentState(id, operation) {
    $('#MessageDiv').hide();
    $.ajax({
        "type": 'POST',
        "url": '../Document/ChangeDocumentState',
        data: {
            "DocumentId" : id,
            "Operation" : operation
        },
        "dataType": 'json',
        success: function (response) {
            if (response !== null) {
                if (response.state) {
                    GetAvailableDocuments();
                    $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                    $('#MessageDiv').html(response.remark);
                    $('#MessageDiv').show();
                } else {
                    $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                    $('#MessageDiv').html(response.remark);
                    $('#MessageDiv').show();
                }
            } else {
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while processing your request');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function ConfirmDocumentTransfer() {
    let destFolder = $('#DestinationFolder option:selected').val();
    if (destFolder === '') {
        $('#DocumentTransferMessageDiv').show();
        $('#DocumentTransferMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#DocumentTransferMessageDiv').html('Please ensure that you have selected a destination folder');
    } else {
        $('#DocumentTransferMessageDiv').hide();
        Swal.fire({
            title: "Confirm Transfer",
            text: "Proceed to transfer the document?",
            type: "question",
            allowEscapeKey: true,
            showCancelButton: !0,
            confirmButtonColor: "#31ce77",
            cancelButtonColor: "#f34943",
            confirmButtonText: "Yes"
        }).then(function (t) {
            t.value && SubmitRequestToServer();
        });
    }
}

function SubmitRequestToServer() {
    $('#MessageDiv').hide();
    $.ajax({
        "type": 'POST',
        "url": '../Document/TransferDocument',
        data: {
            "DocumentId"   : $('#DocumentIdTransfer').val(),
            "SourceFolder" : $('#FolderIdTransfer').val(),
            "DestFolder"   : $('#DestinationFolder option:selected').val()
        },
        "dataType": 'json',
        success: function (response) {
            if (response !== null) {
                if (response.state) {
                    GetAvailableDocuments();
                    $('#TransferDocumentModal').modal('hide');
                    $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                    $('#MessageDiv').html(response.remark);
                    $('#MessageDiv').show();
                } else {
                    $('#DocumentTransferMessageDiv').show();
                    $('#DocumentTransferMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                    $('#DocumentTransferMessageDiv').html(response.remark);
                }
            } else {
                $('#DocumentTransferMessageDiv').show();
                $('#DocumentTransferMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                $('#DocumentTransferMessageDiv').html('Something went wrong while processing your request');
            }
        },
        error: function () {
            $('#DocumentTransferMessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#DocumentTransferMessageDiv').html('Something went wrong while processing your request');
            $('#DocumentTransferMessageDiv').show();
        }
    });
}

function TransferDocument(id) {
    $('#TransferDocumentModal').modal();
    $('#DocumentTransferMessageDiv').hide();
    $('#MessageDiv').hide();

    $.ajax({
        "type": 'GET',
        "url": '../Document/GetDocumentDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            if (response !== null) {
                $('#TransferDocumentName').val(response[0].file_name);
                $('#DocumentIdTransfer').val(response[0].id);
                $('#FolderIdTransfer').val(response[0].folder_id);
                $('#TransferCurrentFolderName').val((response[0]).folder_name);
                GetAvailableFolders(response[0].folder_id);
            } else {
                $('#TransferDocumentModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while fetching the document details');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#TransferDocumentModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching the document details');
            $('#MessageDiv').show();
        }
    });
}

function GetAvailableFolders(currentFolder) {
    $.ajax({
        type: "GET",
        url: "../Workspace/GetAvailableWorkspaces",
        success: function (response) {
            $('#DestinationFolder').empty();
            $("#DestinationFolder").append('<option value="">Select a workspace</option>');
            let jsonResponse = $.parseJSON(response);
            for (let i = 0; i < jsonResponse.length; i++) {
                if (jsonResponse[i].status_id > 0) {
                    if (currentFolder !== jsonResponse[i].id) {
                        if (jsonResponse[i].privilege == "1") {
                            $('#DestinationFolder').append('<option value="' + jsonResponse[i].id + '">' + jsonResponse[i].name + '</option>');
                        }
                    }
                }
            }
        },
        error: function () {
            $('#DestinationFolder').empty();
            $('#TransferDocumentModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching available folders');
            $('#MessageDiv').show();
        }
    });
}

function UpdateDocument(id) {
    let form = $('<form/>', {
        method: 'post', action: '../Document/ValidateDocumentUpdate', class: 'name="frmDoc" id="frmDoc" class="form-horizontal"'
    }).appendTo('#formSection');
    form.append("<input type='hidden' name='doc_id' id='doc_id' value = " + id + " />");
    form.submit();
}

function ViewHistoryModal(id) {
    $('#DocumentHistoryModal').modal();
    $('#DocumentHistoryMessageDiv').hide();

    $("#filesInHistory > tbody").empty();
    $.ajax({
        type: 'GET',
        url: '../Document/GetDocumentVersionHistory/' + id,
        dataType: 'json',
        success: function (response) {
            let t = $('#filesInHistory').DataTable();
            t.clear().draw();

            for (let i = 0; i < response.length; i++) {
                t.row.add([
                    response[i].file_name + '.' + response[i].extension,
                    response[i].file_size,
                    response[i].version,
                    response[i].first_name + ' ' + response[i].last_name,
                    response[i].date_uploaded,
                    '<button onclick="DownloadDocument(' + response[i].id + ')" type="button" class="btn btn-primary waves-effect waves-light" type="submit">Download</button>&nbsp',
                    '<button onclick="DisplayEmailModal(' + response[i].id + ')" type="button" class="btn btn-info waves-effect waves-light" type="submit">Email</button>&nbsp' 
                ]).draw(true);
            }

            $('#filesInHistory').DataTable().draw(true);
        },
        error: function () {
            $('#DocumentHistoryModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function RenameDocument() {
    let currentDocumentName = $('#CurrentDocumentName').val();
    let documentId          = $('#CurrentDocId').val();
    let folderId            = $('#CurrentFolderId').val();
    let newDocName          = $('#NewDocumentName').val();

    $('#DocumentRenameMessageDiv').hide();
    $('#MessageDiv').hide()

    $.ajax({
        "type": 'POST',
        "url": '../Document/RenameDocument',
        data: {
            "CurrentFileName"     : currentDocumentName,
            "Document"            : documentId,
            "Folder"              : folderId,
            "NewFileName"         : newDocName
        },
        "dataType": 'json',
        success: function (response) {
            if (response !== null) {
                if (response.state) {
                    GetAvailableDocuments();
                    $('#NewDocumentName').val('');
                    $('#DocumentRenameModal').modal('hide');
                    $('#MessageDiv').attr('class', 'alert alert-success alert-dismissible fade show');
                    $('#MessageDiv').html(response.remark);
                    $('#MessageDiv').show();
                } else {
                    $('#DocumentRenameMessageDiv').show();
                    $('#DocumentRenameMessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
                    $('#DocumentRenameMessageDiv').html(response.remark);
                }
            } else {
                $('#DocumentRenameModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while processing your request');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#DocumentRenameModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while processing your request');
            $('#MessageDiv').show();
        }
    });
}

function ViewRenameDocumentModal(id) {
    $('#DocumentRenameModal').modal();
    $('#DocumentRenameMessageDiv').hide();
    $('#CurrentDocId').val(id);

    $.ajax({
        "type": 'GET',
        "url": '../Document/GetDocumentDetails/' + id,
        "dataType": 'json',
        success: function (response) {
            if (response !== null) {
                $('#CurrentDocumentName').val(response[0].file_name);
                $('#CurrentFolderName').val(response[0].folder_name);
                $('#CurrentFolderId').val(response[0].folder_id);
                $('#DocumentRenameModal').on('shown.bs.modal', function () {
                    $('#NewDocumentName').focus();
                });
            }
            else {
                $('#DocumentRenameModal').modal('hide');
                $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
                $('#MessageDiv').html('Something went wrong while fetching the document details');
                $('#MessageDiv').show();
            }
        },
        error: function () {
            $('#DocumentRenameModal').modal('hide');
            $('#MessageDiv').attr('class', 'alert alert-danger alert-dismissible fade show');
            $('#MessageDiv').html('Something went wrong while fetching the document details');
            $('#MessageDiv').show();
        }
    });
}

function GetAvailableDocuments() {
    $.ajax({
        type: 'POST',
        url: '../Document/GetAvailableDocuments',
        dataType: 'json',
        success: function (response) {

            $('#datatable').show();
            let t = $('#datatable').DataTable();

            t.clear().draw();

            t.destroy();

            t = $('#datatable').DataTable( {
                scrollCollapse: false,
                responsive: true,
                autoWidth : false,
                autoHeight: true,
                scrollY: '55vh',
                scrollCollapse: false,
                "columnDefs": [
                    { "width": "1%", "targets": 0 },
                    { "width": "1%", "targets": 4 }
                  ]
            });

            for (let i = 0; i < response.length; i++) {
                let fileName = response[i].extension === null ? response[i].file_name : response[i].file_name + '.' + response[i].extension;
                let version = parseInt(response[i].version);
                let privilege = parseInt(response[i].privilege);
                let isArchived = parseInt(response[i].is_archived);
                let state = parseInt(response[i].state);
                let fileId = "'" + response[i].generated_file_name.toString() + "'";

                if (version > 1 && isArchived === 0) {
                    if (privilege === 1) {
                        if (response[i].can_render > 0) {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="RenderDocument(${fileId});" class="dropdown-item" href="#">View Online</a>
                            <a onclick="UpdateDocument(${response[i].id});" class="dropdown-item" href="#">Update</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="TransferDocument(${response[i].id});" class="dropdown-item" href="#">Transfer</a>
                            <a onclick="ViewRenameDocumentModal(${response[i].id});" class="dropdown-item" href="#">Rename</a>
                            <a onclick="ViewHistoryModal(${response[i].id});" class="dropdown-item" href="#">View History</a>
                            <a onclick="ConfirmArchiveDocument(${response[i].id});" class="dropdown-item" href="#">Archive</a>
                            <a onclick="DisplayGrantPrivilegesModal(${response[i].id});" class="dropdown-item" href="#">Manage Privileges</a>
                            <a onclick="DisplayPrivileges(${response[i].id});" class="dropdown-item" href="#">View Privileges</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        } else {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="UpdateDocument(${response[i].id});" class="dropdown-item" href="#">Update</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="TransferDocument(${response[i].id});" class="dropdown-item" href="#">Transfer</a>
                            <a onclick="ViewRenameDocumentModal(${response[i].id});" class="dropdown-item" href="#">Rename</a>
                            <a onclick="ViewHistoryModal(${response[i].id});" class="dropdown-item" href="#">View History</a>
                            <a onclick="ConfirmArchiveDocument(${response[i].id});" class="dropdown-item" href="#">Archive</a>
                            <a onclick="DisplayGrantPrivilegesModal(${response[i].id});" class="dropdown-item" href="#">Manage Privileges</a>
                            <a onclick="DisplayPrivileges(${response[i].id});" class="dropdown-item" href="#">View Privileges</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        }
                    } else if (privilege === 0) {
                        if (response[i].can_render > 0) {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="RenderDocument(${fileId});" class="dropdown-item" href="#">View Online</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="ViewHistoryModal(${response[i].id});" class="dropdown-item" href="#">View History</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        } else {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="ViewHistoryModal(${response[i].id});" class="dropdown-item" href="#">View History</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        }
                    }
                } else if (version === 1 && isArchived === 0) {
                    if (privilege === 1) {
                        if (response[i].can_render > 0) {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>" ,
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="RenderDocument(${fileId});" class="dropdown-item" href="#">View Online</a>
                            <a onclick="UpdateDocument(${response[i].id});" class="dropdown-item" href="#">Update</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="TransferDocument(${response[i].id});" class="dropdown-item" href="#">Transfer</a>
                            <a onclick="ViewRenameDocumentModal(${response[i].id});" class="dropdown-item" href="#">Rename</a>
                            <a onclick="ConfirmArchiveDocument(${response[i].id});" class="dropdown-item" href="#">Archive</a>
                            <a onclick="DisplayGrantPrivilegesModal(${response[i].id});" class="dropdown-item" href="#">Manage Privileges</a>
                            <a onclick="DisplayPrivileges(${response[i].id});" class="dropdown-item" href="#">View Privileges</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        } else {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>" ,
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="UpdateDocument(${response[i].id});" class="dropdown-item" href="#">Update</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="TransferDocument(${response[i].id});" class="dropdown-item" href="#">Transfer</a>
                            <a onclick="ViewRenameDocumentModal(${response[i].id});" class="dropdown-item" href="#">Rename</a>
                            <a onclick="ConfirmArchiveDocument(${response[i].id});" class="dropdown-item" href="#">Archive</a>
                            <a onclick="DisplayGrantPrivilegesModal(${response[i].id});" class="dropdown-item" href="#">Manage Privileges</a>
                            <a onclick="DisplayPrivileges(${response[i].id});" class="dropdown-item" href="#">View Privileges</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        }
                    } else if (privilege === 0) {
                        if (response[i].can_render > 0) {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="RenderDocument(${fileId});" class="dropdown-item" href="#">View Online</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        } else {
                            t.row.add([
                                `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                                fileName,
                                response[i].folder_name,
                                response[i].humanized_time,
                                response[i].version,
                                response[i].state_desc,
                                `<div class="dropdown mt-4 mt-sm-0">
                            <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Options <i class="mdi mdi-chevron-down"></i>
                            </a>
                            
                            <div class="dropdown-menu">
                            <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                            <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                            <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                            </div>
                            </div>`,
                            ]).draw(true);
                        }
                    }
                } else if (state === 1 && isArchived === 1) {
                    if (response[i].privilege == "1") {
                        t.row.add([
                            `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                            fileName,
                            response[i].folder_name,
                            response[i].humanized_time,
                            response[i].version,
                            response[i].state_desc,
                            `<div class="dropdown mt-4 mt-sm-0">
                        <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Options <i class="mdi mdi-chevron-down"></i>
                        </a>
                        
                        <div class="dropdown-menu">
                        <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                        <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                        <a onclick="ConfirmRestoreDocument(${response[i].id});" class="dropdown-item" href="#">Restore</a>
                        <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                        </div>
                        </div>`,
                        ]).draw(true);
                    } else if (privilege === 0) {
                        t.row.add([
                            `<input type="checkbox" onclick="HandleClickEvent();" class="checkSingle" name="checkAll[]" value= '` + response[i].id + "'>",
                            fileName,
                            response[i].folder_name,
                            response[i].humanized_time,
                            response[i].version,
                            response[i].state_desc,
                            `<div class="dropdown mt-4 mt-sm-0">
                        <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Options <i class="mdi mdi-chevron-down"></i>
                        </a>
                        
                        <div class="dropdown-menu">
                        <a onclick="DownloadDocument(${response[i].id});" class="dropdown-item" href="#">Download</a>
                        <a onclick="ViewDetails(${response[i].id});" class="dropdown-item" href="#">View Details</a>
                        <a onclick="DisplayEmailModal(${response[i].id});" class="dropdown-item" href="#">Send Via Email</a>
                        </div>
                        </div>`,
                        ]).draw(true)
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