<?php namespace App\Controllers;

use App\Models\DocumentModel;
use App\Models\FolderModel;
use App\Models\PrivilegeModel;
use App\Models\ZipModel;
use App\Models\QuotaModel;
use Config\Services;
use CustomHelper\Common\StringHelper;
use Exception;
use CodeIgniter\I18n\Time;
use PrivilegeOptions;
use UserRole;
use Extension;

require_once APPPATH . '/Models/UserRole.php';
require_once APPPATH . '/Models/Extension.php';

class Document extends BaseController
{
    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }

    public function Index() {
        $folder_model = new FolderModel();
        $data['available_folders'] = $folder_model->getAvailableFolders(true);

        // get the users assigned quota
        $quota_model = new QuotaModel();
        $data['assigned_quota'] = $quota_model->getUserQuota($_SESSION['user_id']);

        // get the used quota
        $data['used_quota'] = $quota_model->computeUsedQuota($_SESSION['user_id']);

        $data['js_files'][0] = base_url() . '/assets/custom/document/index.js';
        $data['js_files'][1] = base_url() . '/assets/custom/document/select_params.js';

        return view('Document/Index', $data);
    }

    public function BulkUpload() {
        $folder_model = new FolderModel();
        $data['available_folders'] = $folder_model->getAvailableFolders(true);
        $data['js_files'][0] = base_url() . '/assets/custom/document/bulk_uploader.js';

        // get the users assigned quota
        $quota_model = new QuotaModel();
        $data['assigned_quota'] = $quota_model->getUserQuota($_SESSION['user_id']);

        // get the used quota
        $data['used_quota'] = $quota_model->computeUsedQuota($_SESSION['user_id']);

        return view('Document/BulkUpload', $data);
    }

    public function GetAvailableDocuments() {
        $document_model = new DocumentModel();
        $response = $document_model->getAvailableDocuments(0, 0, true);
        return json_encode($response['result_set']);
    }

    public function GetDocumentVersionHistory($id) {
        $document_model = new DocumentModel();
        $response = $document_model->getDocumentVersionHistory($id);
        return json_encode($response['result_set']);
    }

    public function GetDocumentDetails($id) {
        $document_model = new DocumentModel();
        $response = $document_model->getAvailableDocuments(0, $id, true);
        return json_encode($response['result_set']);
    }

    public function Manage() {
        $data = null;
        $data['js_files'][0] = base_url() . '/assets/custom/document/manage.js';
        $data['js_files'][1] = base_url() . '/assets/custom/document/common.js';
        return view('Document/Manage', $data);
    }

    public function ValidateDocumentUpdate() {
        $http_request = Services::request();

        $id = $http_request->getPost('doc_id');

        if ($id == null) {
            $_SESSION['remark'] = 'Unable to update the document. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } else if (!is_numeric($id)) {
            $_SESSION['remark'] = 'Unable to update the document. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } else if ($id <= 0) {
            $_SESSION['remark'] = 'Unable to update the document. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } else {
            $_SESSION['id'] = $id;
            return redirect()->to('/Document/InitiateDocumentUpdate');
        }
    }

    public function ChangeDocumentState() {
        $http_request = Services::request();
        $validation   = Services::validation();

        $validation->setRules([
            'DocumentId' => ['label' => 'Document', 'rules' => 'required'],
            'Operation' => ['label' => 'Operation', 'rules' => 'required|in_list[0,1]|is_natural']
        ]);

        $id = $http_request->getPost('DocumentId');
        $op = (int) $http_request->getPost('Operation');

        if (!$validation->check($id, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a document to perform an operation on',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($op, 'required|in_list[0,1]|is_natural')) {
            $json_data = [
                'remark' => 'Please ensure you have specified a valid document operation state',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $document_model = new DocumentModel();

        $request['document_id'] = $id;
        $request['user_id']     = $_SESSION['user_id'];

        $response = $op === 0 ? $document_model->archiveDocument($request) : $document_model->restoreDocument($request);

        $json_data = [
            'remark' => $response['remark'],
            'state'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function TransferDocument() {
        $http_request = Services::request();
        $validation   = Services::validation();

        $id             = $http_request->getPost('DocumentId');
        $source_folder  = $http_request->getPost('SourceFolder');
        $dest_folder    = $http_request->getPost('DestFolder');

        if (!$validation->check($id, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a document to transfer',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if(!$validation->check($source_folder, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a source folder',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if(!$validation->check($dest_folder, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a destination folder',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $document_model = new DocumentModel();
        $response = $document_model->transferDocument($id, $source_folder, $dest_folder, $_SESSION['user_id']);

        $json_data = [
            'remark' => $response['remark'],
            'state'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function Search() {
        $folder_model = new FolderModel();
        $data['owners']   = $folder_model->getAvailableOwners();
        $data['folders']  = $folder_model->getAvailableFolders(true);
        $data['js_files'][0] = base_url() . '/assets/custom/document/search.js';
        $data['js_files'][1] = base_url() . '/assets/custom/document/common.js';
        return view('Document/Search', $data);
    }

    public function SearchDocument() {
        $http_request = Services::request();

        $search_criteria = trim($http_request->getPost('Keywords'));
        $user_id         = $http_request->getPost('UserId');
        $folder          = $http_request->getPost('Folder');
        $start_date      = $http_request->getPost('StartDate');
        $end_date        = $http_request->getPost('EndDate');

        if (empty($search_criteria) && empty($user_id) && empty($folder) && empty($start_date) && empty($end_date)) {
            $json_data = [
                'remark' => 'Please ensure that you have specified at least one search criteria',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if ($start_date != null && empty($end_date)) {
            $json_data = [
                'remark' => 'Please ensure that you have specified an end date since you specified a start date',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if ($end_date != null && empty($start_date)) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a start date since you specified an end date',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $document_model = new DocumentModel();
        $request['search_keyword'] = $search_criteria;

        if (isset($user_id)) {
            $request['user_id'] = $user_id;
        }

        if (isset($folder)) {
            $request['folder'] = $folder;
        }

        if ($start_date > $end_date) {
            $json_data = [
                'remark' => 'Please ensure that the start date is not greater than the end date',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (strtotime($start_date) && (strtotime($end_date))) {
            try {
                $request['start_date'] = Time::parse($start_date)->addHours(0)->addMinutes(0)->addSeconds(0)->toDateTimeString();
                $request['end_date']   = Time::parse($end_date)->addHours(23)->addMinutes(59)->addSeconds(59)->toDateTimeString();
                $include_date = true;
            } catch (Exception $ex) {
                $include_date = false;
            }
        } else {
            $include_date = false;
        }

        $request['search_start_time'] = time();

        $response = $document_model->searchDocument($request, $include_date);

        $json_data = [
            'remark'  => $response['remark'],
            'state'   => $response['status'],
            'payload' => $response
        ];
        return $this->response->setJSON($json_data);
    }

    public function InitiateDocumentUpdate() {

        $id = null;

        if (array_key_exists('id', $_SESSION)) {
            $id = $_SESSION['id'];
        }

        // no ID present, just redirect
        if ($id == null) {
            $_SESSION['remark'] = 'Unable to update the document. Invalid parameters specified';
            $_SESSION['state']  = false;
            return redirect()->to('/Document/Manage');
        }

        if (array_key_exists('id', $_SESSION)) {
            // forget the ID
            unset($_SESSION['id']);
        }

        // do we have permissions to update this document?
        $param['document_id'] = $id;
        $param['user_id']     = $_SESSION['user_id'];

        $privilege_model = new PrivilegeModel();
        $result = $privilege_model->getPrivilegeForDocument($param);

        if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
            $result['privilege'] = PrivilegeOptions::WRITE;
        }

        if ($result['privilege'] != PrivilegeOptions::WRITE) {
            $_SESSION['remark'] = 'Unable to update the document. Access denied';
            $_SESSION['state']  = false;
            return redirect()->to('/Document/Manage');
        }

        // get the details about this document
        $document_model = new DocumentModel();
        $response = $document_model->getAvailableDocuments(0, $id);

        if ($response['returned_rows'] <= 0) {
            $_SESSION['remark'] = 'Unable to update the document. Invalid parameters specified';
            $_SESSION['state']  = false;
            return redirect()->to('/Document/Manage');
        }

        // get the document latest version
        $version = $document_model->getDocumentLatestVersion($response['result_set'][0]['id']);

        if ($version <= 0) {
            $_SESSION['remark'] = 'Unable to update the document. Invalid parameters specified';
            $_SESSION['state']  = false;
            return redirect()->to('/Document/Manage');
        }

        $data['js_files'][0]   = base_url() . '/assets/custom/document/update.js';
        $data['js_files'][1]   = base_url() . '/assets/custom/document/select_params.js';
        $data['result_set']    = $response['result_set'];
        $data['returned_rows'] = $response['returned_rows'];
        $data['version']       = $version;

        $folder_model = new FolderModel();
        $data['available_folders'] = $folder_model->getAvailableFolders(true);

        return view('Document/Update', $data);
    }

    public function DownloadDocumentsAsZip() {
        $http_request = Services::request();
        $documents = $http_request->getPost('checkAll');

        if ($documents == null || sizeof($documents) <= 0) {
            $_SESSION['remark'] = 'Unable to download the documents. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }
        
        $document_model = new DocumentModel();
        $response = $document_model->getDocumentsForZip($documents);

        if ($response == null || sizeof($response) < 0) {
            $_SESSION['remark'] = 'Something went wrong while processing your request';
            $_SESSION['state']  = false;
            return redirect()->to('/Document/Manage');
        }

        $zip_model = new ZipModel();
        $zip_response = $zip_model->zipDocuments($response);

        if (!$zip_response['status']) {
            $_SESSION['remark'] = 'Unable to complete the download. Please try again later';
            $_SESSION['state']  = false;
            return redirect()->to('/Document/Manage');
        }

        header('Content-Description: File Transfer');
        header(sprintf('Content-Type: %s', 'application/zip'));
        header('Content-Disposition: attachment; filename="'. $zip_response['filename'] .'"');
        header('Expires: 0');
        header('Cache-Control: must-revalidate');
        header('Pragma: public');
        header('Content-Length: ' . filesize($zip_response['zip_path']));
        flush();
        readfile($zip_response['zip_path']);
        return '';

    }

    public function SendDocumentViaEmail() {
        $http_request = Services::request();
        $validation   = Services::validation();

        $doc_id         = $http_request->getPost('DocumentID');
        $recipients     = explode(',', $http_request->getPost('Recipients'));
        $include_sender = $http_request->getPost('IncludeSender');

        if (!$validation->check(trim($doc_id), 'required|numeric')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a document to send via email',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($recipients, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified one or more recipients to receive the document via email',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        // validate the provided email addresses
        foreach ($recipients as $recipient) {
            if (!filter_var($recipient, FILTER_VALIDATE_EMAIL)) {
                $json_data = [
                    'remark' => sprintf('The email address %s is not a valid email address. Please check', $recipient),
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
        }

        $document_model = new DocumentModel();
        $response = $document_model->sendDocumentViaEmail($doc_id, $recipients, $include_sender > 0 ? true : false);

        $json_data = [
            'remark' => $response['remark'],
            'state' => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function RenderDocument($id) {
        if ($id == null) {
            $_SESSION['remark'] = 'Unable to display the document. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } 

        $document_model = new DocumentModel();
        $response = $document_model->getDocumentForDownload($id);

        // either the file is missing or an exception occurred...
        if (!$response['status']) {
            $_SESSION['remark'] = $response['remark'];
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        $row = $response['result_set'];

        // do we have permission to download this document??
        $param['document_id'] = $row->id;
        $param['user_id']     = $_SESSION['user_id'];

        $privilege_model = new PrivilegeModel();
        $privilege_response = $privilege_model->getPrivilegeForDocument($param);

        if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
            $privilege_response['privilege'] = PrivilegeOptions::WRITE;
        } 

        if ($privilege_response['privilege'] != PrivilegeOptions::READ && $privilege_response['privilege'] != PrivilegeOptions::WRITE) {
            $_SESSION['remark'] = 'Unable to display the document. Access denied';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        $file_name = null;

        $allowed_extensions = Extension::getRenderSupportedExtensions();

        if (!in_array($row->extension, $allowed_extensions)) {
            $_SESSION['remark'] = 'Unable to display the document. Unsupported file extension';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        // does the file have an extension?
        if (isset($row->extension)) {
            $download_path = sprintf('%s%s.%s', $row->abs_file_path, $row->generated_file_name, $row->extension);
            $file_name = sprintf('%s.%s', $row->file_name, $row->extension);
        } else {
            $download_path = sprintf('%s%s', $row->abs_file_path, $row->generated_file_name);
            $file_name = sprintf('%s', $row->file_name);
        }

        // does the file exist on the file system?
        if (!file_exists($download_path)) {
            $_SESSION['remark'] = 'Unable to display the document. It does not exist or permissions are incorrectly set on the file system';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } else {
            header('Content-type:' . $row->mime_type);
            header('Content-disposition: inline; filename="'.$file_name.'"');
            header('Content-Transfer-Encoding:binary');
            header('Content-Length: ' . filesize($download_path));
            header('Accept-Ranges:bytes');
            @readfile($download_path);
            exit;
        }
    }

    public function DownloadDocument($id) {
        if ($id == null) {
            $_SESSION['remark'] = 'Unable to download the document. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } else if (!is_numeric($id)) {
            $_SESSION['remark'] = 'Unable to download the document. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } else if ($id <= 0) {
            $_SESSION['remark'] = 'Unable to download the document. Invalid parameters specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        $param['user_id']     = $_SESSION['user_id'];
        $param['document_id'] = $id;

        // do we have permission to download this document??
        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getPrivilegeForDocument($param);

        if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
            $response['privilege'] = PrivilegeOptions::WRITE;
        } 

        if ($response['privilege'] != PrivilegeOptions::READ && $response['privilege'] != PrivilegeOptions::WRITE) {
            $_SESSION['remark'] = 'Unable to download the document. Access denied';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        $document_model = new DocumentModel();
        $response = $document_model->getDocumentForDownload($id);

        // either the file is missing or an exception occurred...
        if (!$response['status']) {
            $_SESSION['remark'] = $response['remark'];
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        $row = $response['result_set'];
        $file_name = null;

        // does the file have an extension?
        if (isset($row->extension)) {
            $download_path = sprintf('%s%s.%s', $row->abs_file_path, $row->generated_file_name, $row->extension);
            $file_name = sprintf('%s.%s', $row->file_name, $row->extension);
        } else {
            $download_path = sprintf('%s%s', $row->abs_file_path, $row->generated_file_name);
            $file_name = sprintf('%s', $row->file_name);
        }

        // does the file exist on the file system?
        if (!file_exists($download_path)) {
            $_SESSION['remark'] = 'Unable to download the document. It does not exist or permissions are incorrectly set on the file system';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        } else {
            // download the file
            header('Content-Description: File Transfer');
            header(sprintf('Content-Type: %s', $row->mime_type));
            header('Content-Disposition: attachment; filename="'. $file_name .'"');
            header('Expires: 0');
            header('Cache-Control: must-revalidate');
            header('Pragma: public');
            header('Content-Length: ' . filesize($download_path));
            flush();
            readfile($download_path);
            return '';
        }
    }

    public function RenameDocument() {
        $validation = Services::validation();
        $http_request = Services::request();

        $folder             = $http_request->getPost('Folder');
        $document           = $http_request->getPost('Document');
        $new_file_name      = $http_request->getPost('NewFileName');
        $current_file_name  = $http_request->getPost('CurrentFileName');

        if (!$validation->check(trim($new_file_name), 'required|min_length[1]')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a new file name for the document',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        // old and new names are the same
        if (strcasecmp($new_file_name, $current_file_name) == 0) {
            $json_data = [
                'remark' => 'Unable to rename the file. The old and new file names are the same',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $document_model = new DocumentModel();

        $response = $document_model->renameDocument($document, $folder, $new_file_name, $current_file_name);

        $json_data = [
            'remark' => $response['remark'],
            'state'  => $response['status']
        ];

        return $this->response->setJSON($json_data);
    }

    public function UpdateDocument() {

        ini_set('max_execution_time', '0');

        $validation    = Services::validation();
        $http_request  = Services::request();

        $file_id    = $http_request->getPost('file_id');
        $folder     = $http_request->getPost('folder_id');
        $file       = $http_request->getFile('file');
        $file_name  = $http_request->getPost('file_name');
        $version    = $http_request->getPost('version');
        $users      = $http_request->getPost('user_list');
        $groups     = $http_request->getPost('group_list');

        // check if there are any errors
        if (!$file->isValid()) {
            $_SESSION['remark'] = $file->getErrorString().'('.$file->getError().')';
            $_SESSION['state']  = false;
            return redirect()->to('/Document/Manage');
        }

        // check the file size against remaining quota
        if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) {
            $quota_model = new QuotaModel();
            $assigned_quota = $quota_model->getUserQuota($_SESSION['user_id']);
            $used_quota = $quota_model->computeUsedQuota($_SESSION['user_id']);

            $remaining_quota = $assigned_quota - $used_quota['quota'];

            helper('number');

            if ($file->getSize() > $remaining_quota) {
                $_SESSION['remark'] = sprintf('Insufficient space. Remaining quota: %s. File size: %s', 
                                      number_to_size($remaining_quota), 
                                      number_to_size($file->getSize()));

                $_SESSION['state'] = false;
                return redirect()->to('/Document/Manage');
            }
        }

        // is a folder present?
        if (!$validation->check($folder, 'required')) {
            $_SESSION['remark'] = 'Unable to update the document. No folder specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        if (!$validation->check($file_name, 'required|min_length[1]|max_length[128]')) {
            $_SESSION['remark'] = 'Unable to update the document. Invalid filename specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        if (!$validation->check($version,  'required')) {
            $_SESSION['remark'] = 'Unable to update the document. No version specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        // is an existing file present?
        if (!$validation->check($file_id, 'required')) {
            $_SESSION['remark'] = 'Unable to update the document. No file id specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        if (!$validation->check($file, 'required')) {
            $_SESSION['remark'] = 'Unable to update the document. No file specified';
            $_SESSION['state'] = false;
            return redirect()->to('/Document/Manage');
        }

        try {
            $comment  = ucwords(trim($http_request->getPost('comment')));
            $keywords = trim($http_request->getPost('keyword'));
            $new_name = $file->getRandomName();
            $path     = WRITEPATH . 'uploads/' . Date('Ymd') . '/';

            // adjust the folder separators depending on the OS being used
            if (stristr(PHP_OS, 'WIN')) {
                $path = str_replace("/", "\\", $path);
            } else {
                // probably a Linux/Unix/Mac environment
                $path = str_replace("\\", "/", $path);
            }

            // create the directory if it does not exist
            if (!file_exists($path)) {
                mkdir($path);
            }

            $result = copy($_FILES['file']['tmp_name'], sprintf('%s%s', $path, $new_name));

            if (!$result) {
                $json_data = [
                    'remark' => 'Unable to upload the document. Ensure the permissions are correctly set on the file system',
                    'state'  => false,
                ];
                return $this->response->setJSON($json_data);
            }

            $lib = new StringHelper();

            // log the file in the database
            $request['file_name']           = $lib->formatName($file_name);
            $request['version']             = $version;
            $request['generated_file_name'] = str_replace('.', '', str_replace($file->getExtension(), '' , $new_name));
            $request['file_size']           = $file->getSize();
            $request['original_file_name']  = $file->getClientName();
            $request['extension']           = $file->getExtension();
            $request['mime_type']           = $file->getMimeType();
            $request['folder']              = $folder;
            $request['abs_file_path']       = $path;
            $request['comment']             = $comment;
            $request['uploaded_by']         = $_SESSION['user_id'];
            $request['state']               = 1;
            $request['id']                  = $file_id;
            $request['users']               = strtolower(gettype($users)) == 'array' ? $users : [];
            $request['groups']              = strtolower(gettype($groups)) == 'array' ? $groups : [];

            $document_model = new DocumentModel();

            $response = $document_model->uploadDocument($request, explode(',', $keywords), true);

            $_SESSION['remark'] = $response['remark'];
            $_SESSION['state']  = $response['status'];

            return redirect()->to('/Document/Manage');

        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());
            $_SESSION['remark'] = 'Something went wrong while uploading the document: ' . $ex->getMessage();
            $_SESSION['state']  = false;

            return redirect()->to('/Document/Manage');
        }
    }

    public function UploadMultipleDocuments() {

        // the script can run for some time since we may have a lot of files to process
        ini_set('max_execution_time', '0');

        helper('form', 'url');

        $validation   = Services::validation();
        $http_request = Services::request();

        $resp_msg = null;

        $path     = WRITEPATH . 'uploads/' . Date('Ymd') . '/';
        $folder   = $http_request->getPost('folder');

        // is a folder selected?
        if (!$validation->check($folder, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have selected a folder to upload the documents to',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $success_count = 0;
        $fail_count    = 0;

        try {
            // create the directory if it does not exist
            if (!file_exists($path)) {
                mkdir($path);
            }

            // adjust the folder separators depending on the OS being used
            if (stristr(PHP_OS, 'WIN')) {
                $path = str_replace("/", "\\", $path);
            } else {
                // probably a Linux/Unix/Mac environment
                $path = str_replace("\\", "/", $path);
            }

            $document_model = new DocumentModel();

            foreach($_FILES['file']['name'] as $keys => $values) {
                $file_name = $_FILES['file']['name'][$keys];
                $file_info = pathinfo($file_name);
                $extension = $file_info['extension'];
                $new_name  = null;

                $max_size  = (str_replace('M', '', ini_get('upload_max_filesize'))) * 1024 * 1024;
                $temp_size = filesize($_FILES['file']['tmp_name'][$keys]);

                if ($temp_size >= $max_size) {
                    $resp_msg.= sprintf('%s: %s <br />', $file_name, sprintf('Allowable Size Exceeded: %sB', ini_get('upload_max_filesize')));
                    $fail_count +=1;

                    $json_data = [
                        'remark' => $resp_msg,
                        'state'  => false
                    ];
                    return $this->response->setJSON($json_data);;
                }
                
                // does the document exist?
                $response = $document_model->doesDocumentExist(pathinfo($file_name, PATHINFO_FILENAME), 1, $folder);

                // the file already exists in the folder so skip it then
                if ($response) {
                    $resp_msg.= sprintf('%s: %s <br />', $file_name, 'Duplicate Filename');
                    $fail_count +=1;
                    $json_data = [
                        'remark' => $resp_msg,
                        'state'  => false
                    ];
                    return $this->response->setJSON($json_data);
                }
                
                // check the quota allocations
                if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) {
                    $quota_model = new QuotaModel();
                    $assigned_quota = $quota_model->getUserQuota($_SESSION['user_id']);
                    $used_quota = $quota_model->computeUsedQuota($_SESSION['user_id']);
        
                    $remaining_quota = $assigned_quota - $used_quota['quota'];
        
                    helper('number');
        
                    if ($temp_size > $remaining_quota) {
                        $resp_msg.= sprintf('File: %s not uploaded. Size: %s. Remaining quota: %s',  
                                            $file_name,
                                            number_to_size($temp_size),
                                            number_to_size($remaining_quota));

                        $json_data = [
                            'remark' => $resp_msg,
                            'state'  => false
                        ];
                        return $this->response->setJSON($json_data);
                        
                    }
                }

                // generate a random file name and append an extension if we can
                if (!empty($extension)) {
                    $new_name = sprintf('%s.%s', time() . '_' . bin2hex(random_bytes(10)), $extension);
                } else {
                    $new_name = time() . '_' . bin2hex(random_bytes(10));
                }

                // copy the files now
                $result = copy($_FILES['file']['tmp_name'][$keys], sprintf('%s%s', $path, $new_name));

                if (!$result) {
                    $json_data = [
                        'remark' => sprintf('Unable to upload the document %s. Ensure the permissions are correctly set on the file system', $file_name),
                        'state'  => false,
                    ];
                    return $this->response->setJSON($json_data);
                }

                $new_file_abs_path = sprintf('%s%s', $path, $new_name);

                // log the file in the database
                $request['file_name']           = pathinfo($file_name, PATHINFO_FILENAME);
                $request['generated_file_name'] = pathinfo($new_file_abs_path, PATHINFO_FILENAME);
                $request['file_size']           = filesize($new_file_abs_path);
                $request['original_file_name']  = pathinfo($file_name, PATHINFO_FILENAME);
                $request['extension']           = $extension;
                $request['mime_type']           = mime_content_type($new_file_abs_path);
                $request['folder']              = $folder;
                $request['abs_file_path']       = $path;
                $request['comment']             = null;
                $request['uploaded_by']         = $_SESSION['user_id'];
                $request['users']               = [];
                $request['groups']              = [];

                $response = $document_model->uploadDocument($request, array());

                if ($response['status']) {
                    $success_count+=1;
                    $resp_msg.= $response['remark'];
                } else {
                    $fail_count+=1;
                    $resp_msg.= $response['remark'];
                }
            }

            // all files uploaded
            if ($success_count > 0 && $fail_count <= 0) {
                $json_data = [
                    'remark' => $resp_msg,
                    'state'  => true
                ];
                return $this->response->setJSON($json_data);
            } else if ($success_count > 0 && $fail_count > 0) {
                $json_data = [
                    'remark' => $resp_msg,
                    'state'  => false
                ];
                return $this->response->setJSON($json_data);
            } else if ($success_count <= 0 && $fail_count > 0) {
                $json_data = [
                    'remark' => $resp_msg,
                    'state'  => false
                ];
                return $this->response->setJSON($json_data);
            } else {
                $json_data = [
                    'remark' => $resp_msg,
                    'state'  => false
                ];
                return $this->response->setJSON($json_data);
            }
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $json_data = [
                'remark' => 'Something went wrong while processing your request',
                'state'  => false
            ];
            return $this->response->setJSON($json_data);
        }
    }

    public function UploadNewDocument() {

        ini_set('max_execution_time', '0');

        helper(['form', 'url']);

        $validation   = Services::validation();
        $http_request = Services::request();

        $file_name = ucwords(trim($http_request->getPost('file_name')));
        $folder    = $http_request->getPost('folder');
        $comment   = ucwords(trim($http_request->getPost('comment')));
        $file      = $http_request->getFile('file');
        $new_name  = $file->getRandomName();
        $path      = WRITEPATH . 'uploads/' . Date('Ymd') . '/';
        $keywords  = trim($http_request->getPost('keyword'));
        $users     = $http_request->getPost('user_list');
        $groups    = $http_request->getPost('group_list');

        // check if there are any errors
        if (!$file->isValid()) {
            $json_data = [
                'remark' => $file->getErrorString().'('.$file->getError().')',
                'state'  => false
            ];
            return $this->response->setJSON($json_data);
        }

        // check the file size against remaining quota
        if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) {
            $quota_model = new QuotaModel();
            $assigned_quota = $quota_model->getUserQuota($_SESSION['user_id']);
            $used_quota = $quota_model->computeUsedQuota($_SESSION['user_id']);

            $remaining_quota = $assigned_quota - $used_quota['quota'];

            helper('number');

            if ($file->getSize() > $remaining_quota) {
                $json_data = [
                    'remark' => sprintf('Insufficient space. Remaining quota: %s. File size: %s', 
                                number_to_size($remaining_quota), 
                                number_to_size($file->getSize())),
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
        }

        // adjust the folder separators depending on the OS being used
        if (stristr(PHP_OS, 'WIN')) {
            $path = str_replace("/", "\\", $path);
        } else {
            // probably a Linux/Unix/Mac environment
            $path = str_replace("\\", "/", $path);
        }

        try {
            if (!$validation->check(trim($file_name), 'required|min_length[1]|max_length[128]')) {
                $json_data = [
                    'remark' => 'Please ensure that you have specified a valid name for the document',
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            // is a folder selected?
            if (!$validation->check($folder, 'required')) {
                $json_data = [
                    'remark' => 'Please ensure that you have selected a folder to upload the document to',
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            if (!$validation->check($file, 'required')) {
                $json_data = [
                    'remark' => 'Please ensure that you have selected a document to upload',
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            // is the file name already existing in the folder? in the database that is...
            $document_model = new DocumentModel();
            $response = $document_model->doesDocumentExist($file_name, 1, $folder);

            if ($response) {
                $json_data = [
                    'remark' => sprintf('A document with a name: %s already exists in the folder', trim(ucwords(strtolower($file_name)))),
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            // create the directory if it does not exist
            if (!file_exists($path)) {
                mkdir($path);
            }

            $result = copy($_FILES['file']['tmp_name'], sprintf('%s%s', $path, $new_name));

            if (!$result) {
                $json_data = [
                    'remark' => 'Unable to upload the document. Ensure the permissions are correctly set on the file system',
                    'state'  => false,
                ];
                return $this->response->setJSON($json_data);
            }

            $lib = new StringHelper();

            // log the file in the database
            $request['file_name']           = $lib->formatName($file_name);
            $request['generated_file_name'] = str_replace('.', '', str_replace($file->getExtension(), '' , $new_name));
            $request['file_size']           = $file->getSize();
            $request['original_file_name']  = $file->getClientName();
            $request['extension']           = $file->getExtension();
            $request['mime_type']           = $file->getMimeType();
            $request['folder']              = $folder;
            $request['abs_file_path']       = $path;
            $request['comment']             = $comment;
            $request['uploaded_by']         = $_SESSION['user_id'];
            $request['users']               = strtolower(gettype($users)) == 'array' ? $users : [];
            $request['groups']              = strtolower(gettype($groups)) == 'array' ? $groups : [];

            $document_model = new DocumentModel();

            $response = $document_model->uploadDocument($request, explode(',', $keywords));

            if ($response['status']) {
                $json_data = [
                    'remark' => $response['remark'] . '. ' . sprintf("<a href='%s/%s'>Upload Another Document?</a>", site_url(),  'Document/Index'),
                    'state' => true,
                ];
            } else {
                $json_data = [
                    'remark' => $response['remark'],
                    'state'  => $response['status'],
                ];
            }

            return $this->response->setJSON($json_data);

        } catch(Exception $ex) {
            $json_data = [
                'remark' => 'Something went wrong while uploading the document: ' . $ex->getMessage(),
                'state'  => false
            ];
            log_message('error', $ex->getMessage());
            return $this->response->setJSON($json_data);
        }
    }
}