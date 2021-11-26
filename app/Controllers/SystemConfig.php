<?php namespace App\Controllers;

use App\Models\ParameterModel;
use Config\Services;
use Exception;

require_once APPPATH . '/Controllers/Security.php';

class SystemConfig extends BaseController {
    function __construct() {
        session_start();
        $security = new Security();
        $security->isLoginValid();
    }
    
    public function Index() {
        try {
            $parameter_model = new ParameterModel();
            $data['config'] = $parameter_model->getAllParameters();
            $data['js_files'][0] = base_url() . '/assets/custom/system_config/index.js';
            return view('SystemConfig/Index', $data);
        } catch(Exception $ex) {
            $data['js_files'][0] = base_url() . '/assets/custom/system_config/index.js';
            return view('SystemConfig/Index', $data);
        }
    }

    public function SaveChanges() {
        $validation   = Services::validation();
        $http_request = Services::request();

        $check_password_complexity = $http_request->getPost('CheckPasswordComplexity');
        $lockout_time              = $http_request->getPost('LockoutTime');
        $max_number_attempts       = $http_request->getPost('MaxNumberAttempts');
        $max_password_age          = $http_request->getPost('MaxPasswordAge');
        $max_remember_passwords    = $http_request->getPost('MaxRememberPasswords');
        $min_password_length       = $http_request->getPost('MinPasswordLength');
        $sender_address            = $http_request->getPost('SenderAddress');
        $system_id                 = $http_request->getPost('SystemID');
        $session_timeout           = $http_request->getPost('SessionTimeout');
        $smtp_host                 = $http_request->getPost('SMTPHost');
        $smtp_password             = $http_request->getPost('SMTPPassword');
        $smtp_port                 = $http_request->getPost('SMTPPort');
        $smtp_timeout              = $http_request->getPost('SMTPTimeout');
        $log_platform_details      = $http_request->getPost('LogPlatform');
        $smtp_crypto               = $http_request->getPost('SMTPCrypto');
        $smtp_username             = $http_request->getPost('SMTPUsername');
        $no_reply_address          = $http_request->getPost('NoReplyAddress');

        if (strtolower(trim($smtp_crypto)) !== 'tls' && strtolower(trim($smtp_crypto)) !== 'ssl') {
            $smtp_crypto = '';
        }

        $param = null;

        if (!$validation->check($check_password_complexity, 'required|in_list[0,1]')) {
            $json_data = [
                'remark' => 'Please set the password complexity policy to on/off',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($lockout_time, 'required|numeric|is_natural_no_zero|integer')) {
            $json_data = [
                'remark' => 'Please specify a valid lock-out time in minutes',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($max_number_attempts, 'required|numeric|integer|is_natural_no_zero')) {
            $json_data = [
                'remark' => 'Please specify a valid max number of attempts',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($max_password_age, 'required|numeric|integer|is_natural_no_zero')) {
            $json_data = [
                'remark' => 'Please specify a valid maximum password age',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($max_remember_passwords, 'required|numeric|integer')) {
            $json_data = [
                'remark' => 'Please specify a valid value for remembered passwords',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($min_password_length, 'required|numeric|is_natural_no_zero')) {
            $json_data = [
                'remark' => 'Please specify a valid value for the minimum password length',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($sender_address, 'required|valid_email')) {
            $json_data = [
                'remark' => 'Please specify a valid email address for the sender address',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($no_reply_address, 'required|valid_email')) {
            $json_data = [
                'remark' => 'Please specify a valid email address for the no reply address',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($system_id, 'required|alpha_space')) {
            $json_data = [
                'remark' => 'Please specify a valid system ID',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($smtp_host, 'required')) {
            $json_data = [
                'remark' => 'Please specify a valid SMTP host',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($smtp_password, 'required')) {
            $json_data = [
                'remark' => 'Please specify a valid SMTP password',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($smtp_username, 'required')) {
            $json_data = [
                'remark' => 'Please specify a valid SMTP username',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($smtp_port, 'required|numeric|integer')) {
            $json_data = [
                'remark' => 'Please specify a valid SMTP Port',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($smtp_timeout, 'required|numeric|integer')) {
            $json_data = [
                'remark' => 'Please specify a valid SMTP Timeout',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($session_timeout, 'required|numeric|integer|is_natural_no_zero')) {
            $json_data = [
                'remark' => 'Please specify a valid session timeout value',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        if (!$validation->check($log_platform_details, 'required|in_list[0,1]')) {
            $json_data = [
                'remark' => 'Please set the log platform details policy to on/off',
                'state' => false
            ];
            return $this->response->setJSON($json_data);
        }

        $param['check_password_complexity'] = $check_password_complexity;
        $param['lockout_time']              = $lockout_time;
        $param['max_number_attempts']       = $max_number_attempts;
        $param['max_password_age']          = $max_password_age;
        $param['max_remember_passwords']    = $max_remember_passwords;
        $param['min_password_length']       = $min_password_length;
        $param['sender_address']            = $sender_address;
        $param['system_id']                 = $system_id;
        $param['session_timeout']           = $session_timeout;
        $param['smtp_host']                 = $smtp_host;
        $param['smtp_port']                 = $smtp_port;
        $param['smtp_password']             = $smtp_password;
        $param['smtp_timeout']              = $smtp_timeout;
        $param['log_platform']              = $log_platform_details;
        $param['smtp_crypto']               = strtolower($smtp_crypto);
        $param['smtp_username']             = $smtp_username;
        $param['no_reply_address']          = $no_reply_address;

        $parameter_model = new ParameterModel();
        $response = $parameter_model->updateParameter($param);

        $json_data = [
            'remark' => $response['remark'],
            'status' => $response['status']
        ];
        return $this->response->setJSON($json_data);
    }
}
