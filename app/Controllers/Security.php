<?php namespace App\Controllers;

use App\Models\SessionModel;
use CustomHelper\Common\StringHelper;

require_once APPPATH . '/Libraries/StringHelper.php';

class Security extends BaseController
{
    public function __construct($is_log_out = false) {
        session_start();
        $this->isResourceAllowed();
        $this->killInactiveSessions();
        
        if (!$is_log_out) {        
            if ($_SESSION['has_password_expired']) {
                $_SESSION['remark'] = 'Your password has expired and must be changed';
                $location = sprintf('%s/%s',site_url(), 'Common/Password');
                header("Location: $location");
                exit;
            }
    
            if ($_SESSION['first_login']) {
                $_SESSION['remark'] = 'You are required to change your password at first login';
                $location = sprintf('%s/%s',site_url(), 'Common/Password');
                header("Location: $location");
                exit;
            }
        }

        if ($_SESSION['two_factor']) {
            $location = sprintf('%s/%s',site_url(), 'Common/OTP');
            header("Location: $location");
            exit;
        }
    }

    /**
     * Method checks if a user is allowed to access a resource
     */
    public function isResourceAllowed() {

        if (!isset($_SESSION['routes'])) {
            $location = sprintf('%s/%s',site_url(), 'Common/Index');
            header("Location: $location");
            exit;
        }

        $helper = new StringHelper();
        $current_uri = array_filter(explode("/", $helper->getCurrentUri()));
        $routes      = $helper->flattenArray($_SESSION['routes']);

        // for hosted environments
        if (sizeof($current_uri) > 3 && in_array('public', $current_uri)) {
            $sanitised_uri = sprintf("/%s/%s", $current_uri[3], $current_uri[4]);
        } else {
            $sanitised_uri = sprintf("/%s/%s", $current_uri[1], $current_uri[2]);
        }

        // user should not be allowed to access the resource
        if (!in_array($sanitised_uri, $routes)) {
            $location = sprintf('%s/%s',site_url(), 'Common/PermissionDenied');
            header("Location: $location");
            exit;
        }
    }

    /**
     * Method gets if a login session is valid
     */
    public function isLoginValid() {
        if (!isset($_SESSION['session_key'])) {
            $location = sprintf('%s/%s',site_url(), 'Common/Index');
            header("Location: $location");
            exit;
        }
        $this->isSessionActive();
    }

    public function endSession($id) {
        $session_model = new SessionModel();
        $session_model->endSession($id);
    }

    public function killInactiveSessions() {
        $session_model = new SessionModel();
        $session_model->deleteInactiveSessions();
    }

    private function isSessionActive() {

        $lib = new StringHelper();

        $session_model = new SessionModel();
        $request['id']         = $_SESSION['session_key'];
        $request['ip_address'] = $lib->getIpAddress();
        $request['user_agent'] = $lib->getUserAgent();
        $request['user_id']    = $_SESSION['user_id'];

        $response = $session_model->isSessionValid($request);

        if (!$response) {
            session_unset();
            session_destroy();
            $location = sprintf('%s/%s',site_url(), 'Common/Index');
            header("Location: $location");
            exit;
        }
    }
}
