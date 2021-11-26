<?php namespace App\Controllers;

use App\Models\GroupMembershipModel;
use App\Models\PrivilegeModel;
use Config\Services;

class Privilege extends BaseController {

    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }

    public function GetPrivilegeAssignedToGroupOnDocument() {
        $http_request = Services::request();

        $params['document_id'] = $http_request->getPost('DocumentID');
        $params['group_id']    = $http_request->getPost('GroupID');

        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getPrivilegeAssignedToGroupOnDocument($params);

        return json_encode($response);
    }

    public function GetPrivilegeAssignedToUserOnDocument() {
        $http_request = Services::request();

        $params['document_id'] = $http_request->getPost('DocumentID');
        $params['user_id']     = $http_request->getPost('UserID');

        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getPrivilegeAssignedToUserOnDocument($params);

        return json_encode($response);
    }

    public function GetPrivilegeAssignedToGroupOnFolder() {
        $http_request = Services::request();

        $params['folder_id'] = $http_request->getPost('FolderID');
        $params['group_id']  = $http_request->getPost('GroupID');

        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getPrivilegeAssignedToGroupOnFolder($params);

        return json_encode($response);
    }

    public function GetPrivilegeAssignedToUserOnFolder() {
        $http_request = Services::request();

        $params['folder_id'] = $http_request->getPost('FolderID');
        $params['user_id']   = $http_request->getPost('UserID');

        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getPrivilegeAssignedToUserOnFolder($params);

        return json_encode($response);
    }

    public function GetGroupAccessOnFolder($id) {
        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getGroupAccessOnFolder($id);
        return json_encode($response['result_set']);
    }

    public function GetUserAccessOnDocument($id) {
        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getUserAccessOnDocument($id);
        return json_encode($response['result_set']);
    }

    public function GetUserAccessOnFolder($id) {
        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getUserAccessOnFolder($id);
        return json_encode($response['result_set']);
    }

    public function GetGroupAccessOnDocument($id) {
        $privilege_model = new PrivilegeModel();
        $response = $privilege_model->getGroupAccessOnDocument($id);
        return json_encode($response['result_set']);
    }

    public function ModifyPrivilegeOnDocument() {
        $http_request = Services::request();
        $validation   = Services::validation();

        $members = [];

        $document_id         = $http_request->getPost('DocumentID');
        $selected_privilege  = $http_request->getPost('SelectedPrivilege');
        $grant_type          = $http_request->getPost('GrantType');
        $group_id            = $http_request->getPost('GroupID');

        if (!$validation->check($document_id, 'required|numeric')) {
            $json_data = [
              'remark' => 'Please ensure that you have specified a document ',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($selected_privilege, 'required|in_list[-1,0,1]|numeric')) {
            $json_data = [
              'remark' => 'Please ensure that you have specified a valid privilege level',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($grant_type, 'required|in_list[0,1]|numeric')) {
            $json_data = [
              'remark' => 'Please ensure that you have specified a valid operation',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        // granting access to an entire group
        if ((int) $grant_type === 0) {

            $group_id = $http_request->getPost('GroupID');

            // check if a group was specified...
            if (!$validation->check($group_id, 'required|numeric')) {
                $json_data = [
                  'remark' => 'Please ensure that you have specified a valid group',
                  'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            $group_membership = new GroupMembershipModel();
            $members = $group_membership->getGroupMembers($group_id);
    
            if (sizeof($members) <= 0) {
                $json_data = [
                    'remark' => 'Unable to modify privileges for the group. There are no members in the group or the group is inactive',
                    'state'  => false
                ];
                return $this->response->setJSON($json_data);
            }
        } else {
            // check if a user was specified...
            $selected_user = $http_request->getPost('SelectedUser');

            if (!$validation->check($selected_user, 'required|numeric')) {
                $json_data = [
                  'remark' => 'Please ensure that you have specified a user',
                  'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
            array_push($members, $selected_user);
        } 

        $param['members']     = $members;
        $param['document_id'] = $document_id;
        $param['group_id']    = $group_id;
        $param['privilege']   = $selected_privilege;

        $privilege_model = new PrivilegeModel();

        $response = $privilege_model->modifyPrivilegeOnDocument($param);

        $json_data = [
            'remark' => $response['remark'],
            'state'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function ModifyPrivilegeOnFolder() {
        $http_request = Services::request();
        $validation   = Services::validation();

        $members = [];

        $folder_id           = $http_request->getPost('FolderID');
        $selected_privilege  = $http_request->getPost('SelectedPrivilege');
        $grant_type          = $http_request->getPost('GrantType');
        $group_id = null;

        if (!$validation->check($folder_id, 'required|numeric')) {
            $json_data = [
              'remark' => 'Please ensure that you have specified a folder',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($selected_privilege, 'required|in_list[-1,0,1]|numeric')) {
            $json_data = [
              'remark' => 'Please ensure that you have specified a valid privilege level',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($grant_type, 'required|in_list[0,1]|numeric')) {
            $json_data = [
              'remark' => 'Please ensure that you have specified a valid operation',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        // granting access to an entire group
        if ((int) $grant_type === 0) {

            $group_id = $http_request->getPost('GroupID');

            // check if a group was specified...
            if (!$validation->check($group_id, 'required|numeric')) {
                $json_data = [
                  'remark' => 'Please ensure that you have specified a valid group',
                  'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            $group_membership = new GroupMembershipModel();
            $members = $group_membership->getGroupMembers($group_id);
    
            if (sizeof($members) <= 0) {
                $json_data = [
                    'remark' => 'Unable to modify privileges for the group. There are no members in the group or the group is inactive',
                    'state'  => false
                ];
                return $this->response->setJSON($json_data);
            }
        } else {
            // check if a user was specified...
            $selected_user = $http_request->getPost('SelectedUser');

            if (!$validation->check($selected_user, 'required|numeric')) {
                $json_data = [
                  'remark' => 'Please ensure that you have specified a user',
                  'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
            array_push($members, $selected_user);
        } 

        $param['members']   = $members;
        $param['folder_id'] = $folder_id;
        $param['group_id']  = $group_id;
        $param['privilege'] = $selected_privilege;

        $privilege_model = new PrivilegeModel();

        $response = $privilege_model->modifyPrivilegeOnFolder($param);

        $json_data = [
            'remark' => $response['remark'],
            'state'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }
}