function ShowResult() {
    $('#FileUploadResultModal').modal();
}

function GetUserQuotaAllocation() {
    $.ajax({
      type: 'GET',
      url: '../Common/GetUserQuotaAllocation',
      dataType: 'json',
      success: function (response) {
          if (response !== null) {
              $('#UsedQuota').html(response.used_quota);
              $('#RemainingQuota').html(response.remaining_quota);
          }
      }
  });
}

$(document).ready(function () {
    $("html").on("dragover", function (e) {
      e.preventDefault();
      e.stopPropagation();
    });

    $('#spinner').hide();
    $('#MessageDiv').hide();
    $('#btnUpload').hide();

    let value = 0;
    $('#ProgressBar').css('width', value+'%').attr('aria-valuenow', value);
    $('#ProgressBar').hide();  

    $('#folder').select2({
        placeholder: "Choose a workspace...",
        allowClear : false
     });
 
    $("html").on("drop", function (e) {
      e.preventDefault();
      e.stopPropagation();
    });
 
    $('#drop_file_area').on('dragover', function () {
      $(this).addClass('drag_over');
      return false;
    });
 
    $('#drop_file_area').on('dragleave', function () {
      $(this).removeClass('drag_over');
      return false;
    });
 
    $('#drop_file_area').on('drop', function (e) {
      e.preventDefault();
      $(this).removeClass('drag_over');

      $("#fileUploadResultTable tr").remove();

      let folder = $('#folder option:selected').val();

      if (folder === '') {
        $('#MessageDiv').show();
        $('#MessageDiv').attr('class', 'alert alert-warning alert-dismissible fade show');
        $('#MessageDiv').html('Please select a folder to upload the documents to');
        return;
      } 

      $('#btnUpload').hide();

      var files = e.originalEvent.dataTransfer.files;
      let failedCount = 0;
      let successCount = 0;

      for (var i = 0; i < files.length; i++) {
        let formData = new FormData();
        formData.append('file[]', files[i]);
        formData.append('folder', folder);

        let currentPercentage = Math.round(i / files.length * 100);

        if (files.length - i <= 1) {
            currentPercentage = 100;
        }  

        $('#ProgressBar').css('width', currentPercentage+'%').attr('aria-valuenow', currentPercentage);  
        $('#ProgressBar').show();

        $('#spinner').show();
        $('#MessageDiv').hide();
        $("#folder").prop("disabled", true);
        $('#drop_file_area').prop("disabled", true);

        $.ajax({
          type: 'POST',
          url: '../Document/UploadMultipleDocuments',
          dataType: 'json',
          data: formData,
          contentType: false,
          cache: false,
          processData: false,
          method: 'POST',
          success: function (response) {
              $("#folder").prop("disabled", false);
              $('#drop_file_area').prop("disabled", false);
              $('#spinner').hide();
              $('#MessageDiv').show();

            if (response.state) {
                $('#MessageDiv').attr('class', 'alert alert-info alert-dismissible fade show');
                successCount = successCount + 1;
            } else {
                $('#MessageDiv').attr('class', 'alert alert-info alert-dismissible fade show');
                failedCount = failedCount + 1;
            }

            GetUserQuotaAllocation();

            $("#fileUploadResultTable").find('tbody')
                .append($('<tr>')
                    .append($('<td>')
                      .append(response.remark)
                    )
                );

            $('#MessageDiv').empty();
            $('#MessageDiv').html("Total Files: " + files.length + "<br />" + "Uploaded Files: " + successCount + "<br />" + "Failed To Upload: " + failedCount); 
            $('#btnUpload').show();        
          },
          error: function () {
              $("#folder").prop("disabled", false);
              $('#drop_file_area').prop("disabled", false);
              $('#spinner').hide();
            
              $('#MessageDiv').attr('class', 'alert alert-info alert-dismissible fade show');
              failedCount = failedCount + 1;

              $("#fileUploadResultTable").find('tbody')
              .append($('<tr>')
                  .append($('<td>')
                    .append(response.remark)
                  )
              );
              GetUserQuotaAllocation();
              $('#btnUpload').show();
          }
        });
      }
    });
});