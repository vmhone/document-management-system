<?php namespace App\Controllers;

use App\Models\DocumentModel;
use App\Models\FolderModel;
use Config\Services;

class Workspace extends BaseController
{
    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }

    public function Index() {
        $data['js_files'][0] = base_url() . '/assets/custom/folder/create.js';
        $folder_model = new FolderModel();
        $data['response'] = $folder_model->getAvailableOwners();
        return view('Workspace/Index', $data);
    }

    public function GetAvailableOwners() {
        $folder_model = new FolderModel();
        $response = $folder_model->getAvailableOwners(true);
        return json_encode($response['result_set']);
    }

    public function Manage() {
        $data['js_files'][0] = base_url() . '/assets/custom/folder/manage.js';
        return view('Workspace/Manage', $data);
    }

    public function GetAvailableWorkspaces() {
        $folder_model = new FolderModel();
        $response = $folder_model->getAvailableFolders();
        return json_encode($response['result_set']);
    }

    public function GetWorkspaceStates() {
        $folder_model = new FolderModel();
        $response = $folder_model->getFolderStates();
        return json_encode($response['result_set']);
    }

    public function GetWorkspaceDetails($id) {
        $folder_model = new FolderModel();
        $response = $folder_model->getFolderDetails($id);
        return json_encode($response['result_set']);
    }

    public function GetDocumentsInWorkspace($id) {
        $document_model = new DocumentModel();
        $response = $document_model->getAvailableDocuments($id);
        return json_encode($response['result_set']);
    }

    public function ModifyWorkspace() {
        helper(['form', 'url']);

        $validation   = Services::validation();
        $http_request = Services::request();

        $folder_id = $http_request->getPost('FolderID');
        $state     = $http_request->getPost('State');

        if (!$validation->check($state, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have selected a state for the workspace',
                'state'  => false
            ];
            return $this->response->setJSON($json_data);
        }
        else {
            if (!$validation->check($folder_id, 'required')) {
                $json_data = [
                    'remark' => 'Please ensure you have selected a workspace to rename',
                    'status' => false
                ];
                return $this->response->setJSON($json_data);
            } else {
                $folder_model = new FolderModel();
                $response = $folder_model->changeFolderState($folder_id, $state, $_SESSION['user_id']);

                $json_data = [
                    'remark' => $response['remark'],
                    'status' => $response['status']
                ];

                return $this->response->setJSON($json_data);
            }
        }
    }

    public function RenameWorkspace() {
        helper(['form', 'url']);

        $validation       = Services::validation();
        $http_request     = Services::request();
        $new_folder_name  = $http_request->getPost('NewFolderName');
        $old_folder_name  = $http_request->getPost('CurrentFolderName');
        $folder_id        = $http_request->getPost('FolderID');

        if (!$validation->check(trim($new_folder_name), 'required|min_length[1]')) {
            $json_data = [
              'remark' => 'Please ensure you have provided a valid name for the workspace',
              'status' => false
            ];

            return $this->response->setJSON($json_data);
        } else {
            if (!$validation->check($folder_id, 'required')) {
                $json_data = [
                    'remark' => 'Please ensure you have selected a workspace to rename',
                    'status' => false
                ];
                return $this->response->setJSON($json_data);
            } else {
                $request['old_name']   = $old_folder_name;
                $request['new_name']   = $new_folder_name;
                $request['id']         = $folder_id;
                $request['updated_by'] = $_SESSION['user_id'];

                $folder_model = new FolderModel();

                $response = $folder_model->renameFolder($request);

                $json_data = [
                    'remark' => $response['remark'],
                    'status' => $response['status'],
                ];
                return $this->response->setJSON($json_data);
            }
        }
    }

    public function CreateNewWorkspace() {
        helper(['form', 'url']);

        $validation     = Services::validation();
        $http_request   = Services::request();
        $folder_name    = $http_request->getPost('FolderName');

        if (!$validation->check(trim($folder_name), 'required|max_length[128]')) {
            $json_data = [
                'remark' => 'Please provide a valid name for the workspace',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        } else {
            $folder_model = new FolderModel();

            $request['folder_name']    = $folder_name;
            $request['folder_comment'] = $http_request->getPost('FolderComment');
            $request['created_by']     = $_SESSION['user_id'];
            $request['owner']          = $http_request->getPost('Owner') != null ? $http_request->getPost('Owner') : null;
            $request['state']          = 1;

            $response = $folder_model->createFolder($request);

            $json_data = [
                'remark' => $response['remark'],
                'status' => $response['status'],
            ];
            return $this->response->setJSON($json_data);
        }
    }
}