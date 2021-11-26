<?php namespace App\Controllers;

use App\Models\UserModel;
use Config\Services;
use UserRole;

require_once APPPATH . '/Models/UserRole.php';

class User extends BaseController 
{
    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }

    public function Index() {
        $data = null;
        $data['js_files'][0] = base_url() . '/assets/custom/user/index.js';
        $data['js_files'][1] = base_url() . '/assets/custom/user/create.js';
        return view('User/Index', $data);
    }
    
    public function Manage() {
        $data = null;
        $data['js_files'][0] = base_url() . '/assets/custom/user/manage.js';
        $data['js_files'][1] = base_url() . '/assets/custom/user/create.js';
        return view('User/Manage', $data);
    }
    
    public function GetAvailableRoles() {
        $user_model = new UserModel();
        $response = $user_model->getAvailableRoles();
        return json_encode($response['result_set']);
    }
    
    public function GetAvailableUsers() {
        $user_model = new UserModel();
        $response = $user_model->getAvailableUsers($_SESSION['user_id']);
        return json_encode($response['result_set']);
    }

    public function GetUserDetails($id) {
        $user_model = new UserModel();
        $response = $user_model->getAvailableUsers($_SESSION['user_id'], $id);
        return json_encode($response['result_set']);
    }

    public function ModifyProfile() {
        $validation    = Services::validation();
        $http_request  = Services::request();

        $user_id       = $http_request->getPost('UserId');
        $first_name    = $http_request->getPost('FirstName');
        $last_name     = $http_request->getPost('LastName');
        $role          = $http_request->getPost('Role');
        $state         = $http_request->getPost('State');
        $email_address = $http_request->getPost('EmailAddress');
        $use_otp       = $http_request->getPost('TwoFactor');
        $op            = $http_request->getPost('Op');
        $quota         = $http_request->getPost('Quota');

        $user_model = new UserModel();

        if ($op == '1') {

            $quota = -1;

            if ($user_id != $_SESSION['user_id']) {
                $json_data = [
                    'remark' => 'Invalid request',
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            $password = $http_request->getPost('Password');
            if (!$validation->check($password, 'required')) {
                $json_data = [
                    'remark' => 'The password field is required',
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }

            $param['user_id']  = $user_id;
            $param['password'] = $password;
            $is_valid = $user_model->isPasswordValid($param);

            if (!$is_valid) {
                $json_data = [
                    'remark' => 'The password is incorrect. Please try again',
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
        }

        if (!$validation->check($user_id, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a user to modify a profile for',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($first_name, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have provided a first name',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($last_name, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have provided a last name',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($role, 'required') || $role <= 0) {
            $json_data = [
                'remark' => 'Please ensure that you have selected a role for the user',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($state, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have selected a status for the user',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($email_address, 'required|valid_email')) {
            $json_data = [
                'remark' => 'Please ensure that you have specified a valid email address for the user',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($use_otp, 'required|in_list[0,1]')) {
            $json_data = [
                'remark' => 'Please specify whether the profile will require two factor authentication or not',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        // check the privilege
        if ($op <> '1') {
            if (!$_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                $json_data = [
                    'remark' => 'Access Denied',
                    'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
        }

        if ($role != UserRole::ADMINISTRATOR && $op <> '1') {
            if (!$validation->check($quota, 'required|integer|greater_than_equal_to[0]')) {
                $json_data = [
                  'remark' => 'Please provide a valid quota for the user in megabytes',
                  'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
        }

        $request['first_name']    = $first_name;
        $request['last_name']     = $last_name;
        $request['role']          = $role;
        $request['email_address'] = $email_address;
        $request['state']         = $state;
        $request['user_id']       = $user_id;
        $request['use_otp']       = $use_otp;
        $request['quota']         = $quota;

        $response = $user_model->modifyProfile($request);

        $json_data = [
            'remark'  => $response['remark'],
            'status'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function ResetPassword() {
        $validation   = Services::validation();
        $http_request = Services::request();
        
        $user_id = $http_request->getPost('UserId');
        
        $validation->setRules([
            'UserId' => ['label' => 'User ID', 'rules' => 'required'],
        ]);
        
        if (!$validation->check($user_id, 'required')) {
            $json_data = [
              'remark' => 'Please ensure that you have specified a user to reset a password for',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }
        
        $user_model = new UserModel();
        
        $request['user_id'] = $user_id;

        $response = $user_model->resetPassword($request);
        
        $json_data = [
            'remark'  => $response['remark'],
            'status'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function CreateUser() {
        $validation = Services::validation();
        $http_request = Services::request();
        
        $first_name    = $http_request->getPost('FirstName');
        $last_name     = $http_request->getPost('LastName');
        $email_address = $http_request->getPost('EmailAddress');
        $role          = $http_request->getPost('UserRole');
        $use_otp       = $http_request->getPost('TwoFactor');
        $quota         = $http_request->getPost('Quota');
                        
        if (!$validation->check($first_name, 'required')) {
            $json_data = [
              'remark' => 'Please provide a first name',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }
        
        if (!$validation->check($last_name, 'required')) {
            $json_data = [
              'remark' => 'Please provide a last name',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }
        
        if (!$validation->check($email_address, 'required|valid_email')) {
            $json_data = [
              'remark' => 'Please provide a valid email address',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }
        
        if (!$validation->check($role, 'required')) {
            $json_data = [
              'remark' => 'Please provide a role for the user',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }
        
        if ($role <= 0) {
             $json_data = [
              'remark' => 'Please provide a role for the user',
              'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($use_otp, 'required|in_list[0,1]')) {
            $json_data = [
                'remark' => 'Please specify whether the profile will require two factor authentication or not',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if ($role != UserRole::ADMINISTRATOR) {
            if (!$validation->check($quota, 'required|integer|greater_than_equal_to[0]')) {
                $json_data = [
                  'remark' => 'Please provide a valid quota for the user in megabytes',
                  'state' => false
                ];
                return $this->response->setJSON($json_data);
            }
        }
        
        $user_model = new UserModel();
        
        $request['email_address'] = $email_address;
        $request['first_name']    = $first_name;
        $request['last_name']     = $last_name;
        $request['role']          = $role;
        $request['use_otp']       = $use_otp;
        $request['quota']         = $quota;
        
        $response = $user_model->createUser($request);
        
        $json_data = [
            'remark'  => $response['remark'],
            'status'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }
} 