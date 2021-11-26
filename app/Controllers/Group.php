<?php namespace App\Controllers;

use App\Models\GroupModel;
use Config\Services;

class Group extends BaseController
{
    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }

    public function GetAvailableGroups() {
        $group_model = new GroupModel();
        $response = $group_model->getAvailableGroups();
        return json_encode($response);
    }

    public function GetGroupDetails($id) {
        $group_model = new GroupModel();
        $response = $group_model->getAvailableGroups($id);
        return json_encode($response);
    }

    public  function Manage() {
        $data = null;
        $data['js_files'][0] = base_url() . '/assets/custom/group/manage.js';
        return view('Group/Manage', $data);
    }

    public function Index() {
        $data = null;
        $data['js_files'][0] = base_url() . '/assets/custom/group/index.js';
        return view('Group/Index', $data);
    }

    public function ModifyGroup() {
        helper(['form', 'url']);

        $validation    = Services::validation();
        $http_request  = Services::request();

        $group_id       = $http_request->getPost('GroupID');
        $group_name     = $http_request->getPost('GroupName');
        $group_comment  = $http_request->getPost('GroupComment');
        $group_state    = $http_request->getPost('GroupState');

        if (!$validation->check($group_name, 'required|max_length[45]')) {
            $json_data = [
                'remark' => 'Please provide a valid name for the group',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($group_id, 'required')) {
            $json_data = [
                'remark' => 'Please ensure you have selected a group to modify',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check(trim($group_comment), 'max_length[128]')) {
            $json_data = [
                'remark' => 'Please ensure that the comment does not exceed 128 characters',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($group_state, 'required')) {
            $json_data = [
                'remark' => 'Please ensure you have selected a state for the group',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $group_model = new GroupModel();

        $request['state']      = $group_state;
        $request['group_name'] = strtoupper(trim($group_name));
        $request['updated_by'] = $_SESSION['user_id'];
        $request['comment']    = $group_comment;
        $request['id']         = $group_id;

        $response = $group_model->modifyGroup($request);

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status'],
        ];
        return $this->response->setJSON($json_data);
    }

    public function CreateGroup() {
        helper(['form', 'url']);

        $validation   = Services::validation();
        $http_request = Services::request();

        $group_name    = $http_request->getPost('GroupName');
        $group_comment = $http_request->getPost('GroupComment');

        if (!$validation->check(trim($group_name), 'required|max_length[45]')) {
            $json_data = [
                'remark' => 'Please provide a valid name for the group',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check(trim($group_comment), 'max_length[128]')) {
            $json_data = [
                'remark' => 'Please ensure that the comment does not exceed 128 characters',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $group_model = new GroupModel();

        $request['group_name']    = strtoupper(trim($group_name));
        $request['group_comment'] = $group_comment;
        $request['created_by']    = $_SESSION['user_id'];

        $response = $group_model->createGroup($request);

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status'],
        ];
        return $this->response->setJSON($json_data);
    }
}