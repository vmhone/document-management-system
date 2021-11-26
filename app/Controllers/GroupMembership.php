<?php namespace App\Controllers;

use App\Models\FolderModel;
use App\Models\GroupMembershipModel;
use Config\Services;

class GroupMembership extends BaseController
{
    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }

    public function GetGroupMembership() {
        $group_membership_model = new GroupMembershipModel();
        $response = $group_membership_model->getGroupMembership();
        return json_encode($response);
    }

    public function GetGroupMemberShipById($id) {
        $group_membership_model = new GroupMembershipModel();
        $response = $group_membership_model->getGroupMembership($id);
        return json_encode($response);
    }

    public function GetAvailableUsers() {
        $folder_model = new FolderModel();
        $response = $folder_model->getAvailableOwners(true);
        return json_encode($response);
    }

    public function DoMemberOperation() {

        $validation   = Services::validation();
        $http_request = Services::request();

        $user_id   = $http_request->getPost('UserID');
        $group_id  = $http_request->getPost('GroupID');
        $operation = $http_request->getPost('Operation');

        if (!$validation->check($user_id, 'required')) {
            $json_data = [
                'remark' => 'Please select a user to assign to the group',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($group_id, 'required')) {
            $json_data = [
                'remark' => 'Please select a group to assign the user to',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($operation, 'required')) {
            $json_data = [
                'remark' => 'Please specify whether to assign to a group or revoke from a group',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $group_membership_model = new GroupMembershipModel();

        if ($operation == 0) {
            $request['user_id']    = $user_id;
            $request['group_id']   = $group_id;
            $request['revoked_by'] = $_SESSION['user_id'];
            $response = $group_membership_model->revokeGroupMembership($request);
        } else {
            $request['user_id']     = $user_id;
            $request['group_id']    = $group_id;
            $request['assigned_by'] = $_SESSION['user_id'];
            $response = $group_membership_model->assignUserToGroup($request);
        }

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status'],
        ];
        return $this->response->setJSON($json_data);
    }
}