$(document).ready(function () {
    GetLatestFiles();
    GetLatestFolders();
    RefreshStats();

    // refresh the table after a set time
    window.setInterval(function () {
        GetLatestFiles();
        GetLatestFolders();
        RefreshStats();
    }, 60000);

});

function SubmitRequest() {
    var serverResponse;
    $.ajax({
        type: 'GET',
        async: false,
        url: '../Dashboard/GetLargestFolders',
        dataType: 'json',
        success: function (result) {
            serverResponse = result;
        },
        error: function () {
            console.log(result);
        }
    });
    return serverResponse;
}

function GetFolderInformation(param) {
    let serverResponse = SubmitRequest(param);
    let arr = [];
    for (let i = 0; i < serverResponse.length; i++) {
        if (param === 0) {
            arr.push(serverResponse[i].folder_name);
        } else {
            arr.push(serverResponse[i].file_count);
        }
    }
    return arr;
}

function RefreshStats() {
    $.ajax({
        type: 'GET',
        url: '../Dashboard/GetDashboardStatistics/1',
        dataType: 'json',
        success: function (response) {
            $('#TotalDocuments').html(response.total_docs);
            $('#ActiveSessions').html(response.active_sessions);
            $('#TotalFolders').html(response.total_folders);
            $('#TotalGroups').html(response.total_groups);

            if (response.total_folders <= 0) {
                $('#LatestFolders').hide();
                $('#FolderOverview').hide();
            }

            if (response.total_docs <= 0) {
                $('#LatestFiles').hide();
            }
        },
        error: function () {
            $('#TotalDocuments').html('0');
            $('#ActiveSessions').html('0');
            $('#TotalFolders').html('0');
            $('#TotalGroups').html('0');
            $('#LatestFolders').hide();
        }
    });
}

function GetLatestFiles() {
    $.ajax({
        type: 'GET',
        url: '../Dashboard/GetLatestFiles',
        dataType: 'json',
        success: function (response) {
            if (response !== null && response.length > 0) {
                $('#FileTable').show();
                let t = $('#FileTable').DataTable({
                    "paging" : false,
                    "bFilter" : false,
                    "bInfo" : false,
                    "responsive" : true
                });
    
                t.destroy();
    
                t.clear().draw();
    
                for (let i = 0; i < response.length; i++) {
                    t.row.add([
                        response[i].file_name,
                        response[i].first_name + ' ' + response[i].last_name,
                        response[i].date_uploaded,
                    ]).draw(true);
                }
            } else {
                $('#LatestFiles').hide();
            }
        },
        error: function () {
            $('#LatestFiles').hide();
            let t = $('#FileTable').DataTable({
                "paging" : false,
                "bFilter" : false,
                "bInfo" : false
            });
            t.destroy();
        }
    });
}

function GetLatestFolders() {
    $.ajax({
        type: 'GET',
        url: '../Dashboard/GetLatestFolders',
        dataType: 'json',
        success: function (response) {
            
            if (response !== null && response.length > 0) {
                $('#FolderTable').show();
                let t = $('#FolderTable').DataTable({
                    "paging" : false,
                    "bFilter" : false,
                    "bInfo" : false,
                    "responsive" : true
                });
    
                t.destroy();
    
                t.clear().draw();
    
                for (let i = 0; i < response.length; i++) {
                    t.row.add([
                        response[i].folder_name,
                        response[i].first_name + ' ' + response[i].last_name,
                        response[i].created_date,
                    ]).draw(true);
                }
            } else {
                $('#LatestFolders').hide();
            }
        },
        error: function () {
            $('#LatestFolders').hide();
            let t = $('#FolderTable').DataTable({
                "paging" : false,
                "bFilter" : false,
                "bInfo" : false
            });
            t.destroy();
        }
    });
}