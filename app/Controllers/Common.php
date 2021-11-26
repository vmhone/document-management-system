<?php namespace App\Controllers;

use App\Models\ParameterModel;
use App\Models\SessionModel;
use App\Models\UserModel;
use App\Models\QuotaModel;
use CodeIgniter\I18n\Time;
use Config\Services;
use CustomHelper\Common\StringHelper;
use Exception;
use UserRole;

require_once APPPATH . '/Models/UserRole.php';

class Common extends BaseController
{
    public function Password() {
        session_start();
        if (!isset($_SESSION['session_key'])) {
            $location = sprintf('%s/%s',site_url(), 'Common/Index');
            header("Location: $location");
        }
        $data['js_files'][0] = base_url() . '/assets/custom/common/change_password.js';
        return view('Common/Password', $data);
    }

    public function Logout() {
        session_start();
        $security = new Security(true);
        $security->endSession($_SESSION['session_key']);
        session_destroy();

        return redirect()->to('/Common/Index');
    }

    public function PermissionDenied() {
        return view('Common/PermissionDenied');
    }

    public function Index() {
        try {
            $parameter_model = new ParameterModel();
            $platform = $parameter_model->getParameter('log_platform');
    
            // should we log the platform details
            if (isset($platform) && (int)$platform->parameter_value > 0) {
                $request = Services::request();
                $agent = $request->getUserAgent();
    
                $platform_param['user_agent']  = $agent->__toString();
                $platform_param['version']     = $agent->getVersion();
                $platform_param['is_robot']    = $agent->isRobot();
                $platform_param['is_mobile']   = $agent->isMobile();
                $platform_param['platform']    = $agent->getPlatform();
                $platform_param['date_logged'] = new Time('now');
    
                $user_model = new UserModel();
                $user_model->logPlatformDetails($platform_param);
            }
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
        }

        session_start();
        $_SESSION = array();
        session_destroy();
        return view('Common/Index');
    }

    public function InitiateReset() {
        return view('Common/InitiateReset');
    }

    public function OTP() {
        session_start();
        if (!isset($_SESSION['session_key'])) {
            $location = sprintf('%s/%s',site_url(), 'Common/Index');
            header("Location: $location");
            exit;
        }

        if (!isset($_SESSION['two_factor'])) {
            $location = sprintf('%s/%s',site_url(), 'Common/Index');
            header("Location: $location");
            exit;
        }

        $data['js_files'][0] = base_url() . '/assets/custom/common/otp.js';
        return view('Common/OTP');
    }

    public function GenerateOTP() {
        session_start();
        if (!isset($_SESSION['session_key'])) {
            $json_data = [
                'remark' => 'Access denied',
                'status' => false,
            ];
            return $this->response->setJSON($json_data);
        }

        if (!isset($_SESSION['two_factor'])) {
            $json_data = [
                'remark' => 'Access denied',
                'status' => false,
            ];
            return $this->response->setJSON($json_data);
        }

        $user_model = new UserModel();
        $response = $user_model->generateOtp($_SESSION['user_id']);

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status'],
        ];
        return $this->response->setJSON($json_data);
    }

    public function VerifyOTP() {
        session_start();
        if (!isset($_SESSION['session_key'])) {
            $json_data = [
                'remark' => 'Access denied',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!isset($_SESSION['two_factor'])) {
            $json_data = [
                'remark' => 'Access denied',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $http_request = Services::request();
        $validation   = Services::validation();
        $otp = $http_request->getPost('OTP');

        if (!$validation->check($otp, 'required|numeric')) {
            $json_data = [
                'remark' => 'Please provide the OTP',
                'state' => false,
                'too_many_attempts' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $user_model = new UserModel();
        $response = $user_model->verifyOtp($otp, $_SESSION['user_id']);
        $cache = Services::cache();

        if (isset($response['otp_valid'])) {
            if ($response['otp_valid']) {
                unset($_SESSION['two_factor']);
                $json_data = [
                    'remark'            => $response['remark'],
                    'status'            => $response['status'],
                    'too_many_attempts' => false,
                    'redirect_url'      => sprintf('%s/%s',site_url(), 'Dashboard/Index')
                ];
                return $this->response->setJSON($json_data);
            } else {
                $attempt = $cache->get($_SESSION['user_id']);

                // first wrong attempt
                if (!isset($attempt)) {
                    $request['attempt_no'] = 1;
                    $cache->save($_SESSION['user_id'], 1, 60);
                } else {
                    $attempt += 1;
                    $cache->save($_SESSION['user_id'], $attempt, 60);

                    // too many invalid OTP attempts
                    if (isset($response['max_attempts'])) {
                        if ($attempt >= $response['max_attempts']) {
                            $result = $user_model->generateOtp($_SESSION['user_id']);
                            if ($result['status']) {
                                $json_data = [
                                    'remark'            => 'Too many wrong OTP attempts. New OTP sent',
                                    'status'            => $response['status'],
                                    'too_many_attempts' => true,
                                ];
                                $cache->delete($_SESSION['user_id']);
                            } else {
                                $json_data = [
                                    'remark'            => $result['remark'],
                                    'status'            => $result['status'],
                                    'too_many_attempts' => true,
                                ];
                            }
                            return $this->response->setJSON($json_data);
                        }
                    }
                }
            }
        }

        if ($response['status']) {
            $cache->delete($_SESSION['user_id']);
        }

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status'],
            'too_many_attempts' => false,
        ];
        return $this->response->setJSON($json_data);
    }

    public function GetUserQuotaAllocation() {
        try {
            $security = new Security();
            $security->isLoginValid();

            session_start();

            // get the users assigned quota
            $quota_model = new QuotaModel();
            $result['assigned_quota'] = $quota_model->getUserQuota($_SESSION['user_id']);
 
            // get the used quota
            $response = $quota_model->computeUsedQuota($_SESSION['user_id']);

            helper('number');

            $result['remaining_quota'] = number_to_size($result['assigned_quota'] - $response['quota'], 2);
            $result['used_quota']      = number_to_size($response['quota'], 2);
            $result['assigned_quota']  = number_to_size($result['assigned_quota'], 2);
             
            return json_encode($result);

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());

            $result['remaining_quota'] = 0;
            $result['used_quota']      = 0;
            $result['assigned_quota']  = 0;

            return json_encode($result);
        }
    }
    
    public function MyProfile() {
        try {
            $security = new Security();
            $security->isLoginValid();

            session_start();
            $user_model = new UserModel();
            $data['user_info'] = $user_model->getAvailableUsers(0, $_SESSION['user_id']);

            // get the users assigned quota
            $quota_model = new QuotaModel();
            $data['assigned_quota'] = $quota_model->getUserQuota($_SESSION['user_id']);

            // get the used quota
            $data['quota'] = $quota_model->computeUsedQuota($_SESSION['user_id']);

            $returned_rows = $data['user_info']['returned_rows'];

            if ($returned_rows <= 0) {
                $data['error_message'] = 'Unable to locate profile details. Try again in a moment';
                return view('Common/ManageProfile', $data);
            }

            $data['js_files'][0] = base_url() . '/assets/custom/common/manage_profile.js';
            $data['profile'] = $data['user_info']['result_set'][0];

            return view('Common/ManageProfile', $data);
        } catch (Exception $ex) {
            $data['error_message'] = 'Something went wrong while processing your request';
            return view('Common/ManageProfile', $data);
        }
    }

    public function ValidatePasswordReset($token) {
        // check if the reset token is valid
        $request['token'] = $token;

        $user_model = new UserModel();
        $response = $user_model->isTokenValid($request);

        // token is not valid for some reason
        // display why we cannot proceed with the reset operation
        if (!$response['status']) {
            $data['remark'] = $response['remark'];
            return view('Common/InitiateReset', $data);
        } else {
            $data['user_id']       = $response['user_id'];
            $data['email_address'] = $response['email_address'];
            $data['token']         = $token;
            return view('Common/ResetPassword', $data);
        }
    }

    public function ResetPasswordUsingToken() {
        $http_request = Services::request();
        $validation   = Services::validation();

        $user_id = $http_request->getPost('UserId');
        $token   = $http_request->getPost('Token');

        if (!$validation->check($user_id, 'required')) {
            $json_data = [
              'remark' => 'Unable to reset the password. Invalid request',
              'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($token, 'required')) {
            $json_data = [
                'remark' => 'Unable to reset the password. Invalid request',
                'status' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $request['token']   = $token;
        $request['user_id'] = $user_id;

        $user_model = new UserModel();
        $response = $user_model->resetPasswordUsingToken($request);

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function InitiatePasswordReset() {
        $validation   = Services::validation();
        $http_request = Services::request();

        $email_address = $http_request->getPost('EmailAddress');

        if (!$validation->check($email_address, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have provided a username',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($email_address, 'valid_email')) {
            $json_data = [
                'remark' => 'We expect a username in the format of an email address',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $request['email_address'] = $email_address;

        $user_model = new UserModel();
        $response = $user_model->initiatePasswordReset($request);

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }

    public function AuthenticateLogin() {
        $validation   = Services::validation();
        $http_request = Services::request();

        $username = $http_request->getPost('username');
        $password = $http_request->getPost('password');

        if (!$validation->check($username, 'required')) {
            $data['username'] = $username;
            $data['message']  = 'Please ensure you have provided a username';
            return view('Common/Index', $data);
        }

        if (!$validation->check($username, 'valid_email')) {
            $data['username'] = $username;
            $data['message']  = 'We expect a username in the format of an email address';
            return view('Common/Index', $data);
        }

        if (!$validation->check($password, 'required')) {
            $data['username'] = $username;
            $data['message']  = 'Please ensure you have provided a password';
            return view('Common/Index', $data);
        }

        $request['email_address'] = $username;
        $request['password']      = $password;
        $request['attempt_no']    = 0;

        $cache_username = str_replace('@', '', trim($username));

        $cache = Services::cache();
        $attempt = $cache->get($cache_username, 1, 60);

        // first wrong attempt
        if (!isset($attempt)) {
            $request['attempt_no'] = 1;
            $cache->save($cache_username, 1, 60);
        } else {
            $attempt += 1;
            $request['attempt_no'] = $attempt;
            $cache->save($cache_username, $attempt, 60);
        }

        $user_model = new UserModel();
        $response = $user_model->authenticateLogin($request);

        // invalid credentials provided, or something went wrong...
        if (!$response['status']) {
            $data['username'] = $username;
            $data['message']  = $response['remark'];
            return view('Common/Index', $data);
        }

        $details = $user_model->getUserDetails($response['user_id']);

        if (!$details['status']) {
            $data['message'] = 'Login failed. Please try again later';
            return view('Common/Index', $data);
        }

        // remove attempts from the cache
        $cache->delete($cache_username, 1, 60);

        $row = $details['result_set'];

        session_start();
        $lib = new StringHelper();

        $session_id = $lib->generateGuid(true);

        $_SESSION['user_id']              = $row->id;
        $_SESSION['first_name']           = $row->first_name;
        $_SESSION['last_name']            = $row->last_name;
        $_SESSION['role_id']              = $row->role;
        $_SESSION['role_desc']            = $row->description;
        $_SESSION['session_key']          = $session_id;
        $_SESSION['session_life']         = $response['session_timeout'];
        $_SESSION['has_password_expired'] = $response['has_password_expired'];
        $_SESSION['first_login']          = $response['first_login'];
        $_SESSION['routes']               = $response['routes'];
        $_SESSION['username']             = $row->email_address;

        // first login takes precedence over an expired password
        if ($_SESSION['has_password_expired'] && $_SESSION['first_login']) {
            $_SESSION['has_password_expired'] = false;
            unset($_SESSION['two_factor']);
        } else if ($_SESSION['first_login']) {
            unset($_SESSION['two_factor']);
        } else {
            if ($row->use_otp > 0) {
                $_SESSION['two_factor'] = true;
            } else {
                unset($_SESSION['two_factor']);
            }
        }

        $row->role === UserRole::ADMINISTRATOR ? $_SESSION['is_admin'] = true : $_SESSION['is_admin'] = false;

        if ($response['routes'] == null || sizeof($response['routes']) <= 0) {
            $data['message'] = 'Login failed. Profile not correctly configured';
            return view('Common/Index', $data);
        }

        $session_model = new SessionModel();
        $param['session_id'] = $session_id;
        $param['ip_address'] = $lib->getIpAddress();
        $param['user_agent'] = $lib->getUserAgent();
        $param['last_seen']  = time();
        $param['user_id']    = $row->id;

        if (!$session_model->createSession($param)) {
            $data['message'] = 'Something went wrong while establishing your login session';
            return view('Common/Index', $data);
        }

        if (!is_null($row->last_password_change)) {
            try {
                $_SESSION['last_password_change'] = Time::parse($row->last_password_change)->toDateTimeString();
            } catch (Exception $e) {
                $_SESSION['last_password_change'] = 'Never';
            }
        } else {
            $_SESSION['last_password_change'] = 'Never';
        }

        if (!is_null($row->last_login)) {
            try {
                $_SESSION['last_login'] = Time::parse($row->last_login)->toDateTimeString();
            } catch (Exception $e) {
                $_SESSION['last_login'] = 'Never';
            }
        } else {
            $_SESSION['last_login'] = 'Never';
        }

        if ($_SESSION['two_factor']) {
            return redirect()->to('/Common/OTP');
        } else {
            return redirect()->to('/Dashboard/Index');
        }
    }

    public function ChangePassword() {

        session_start();

        $validation   = Services::validation();
        $http_request = Services::request();

        $user_id                   = $_SESSION['user_id'];
        $current_password          = $http_request->getPost('CurrentPassword');
        $new_password              = $http_request->getPost('NewPassword');
        $new_password_confirmation = $http_request->getPost('ConfirmNewPassword');

        if (!$validation->check($user_id, 'required')) {
            $json_data = [
                'remark' => 'Invalid request. Please try again',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($current_password, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have provided the current password',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($new_password, 'required')) {
            $json_data = [
                'remark' => 'Please ensure that you have provided the new password',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($new_password, 'max_length[50]')) {
            $json_data = [
                'remark' => 'The new password cannot exceed 50 characters',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (strcasecmp($new_password, $new_password_confirmation) !== 0) {
            $json_data = [
                'remark' => 'Please ensure that you have correctly confirmed the password',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $user_model = new UserModel();
        $request['user_id']          = $user_id;
        $request['current_password'] = $current_password;
        $request['new_password']     = $new_password;

        $response = $user_model->changeUserPassword($request);

        if ($response['status']) {            
            $_SESSION['has_password_expired'] = false;
            $_SESSION['first_login'] = 0;
        }

        $json_data = [
            'remark'  => $response['remark'],
            'status'  => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }
}