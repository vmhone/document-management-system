<?php namespace App\Models;

use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use CustomHelper\Common\StringHelper;
use PHPMailer\PHPMailer\Exception;
use DateTime;
use UserRole;

require_once APPPATH . '/Libraries/StringHelper.php';
require_once APPPATH . '/Models/UserRole.php';

class UserModel extends Model {
    
     /**
      * Method checks if a user exists
      * @param string $email_address
      * @return boolean
      * @throws Exception
      */
     protected function doesUserExist($email_address) {
        try {
            $db = db_connect();
              
            $builder = $db->table('user');
            $builder->where('email_address', trim($email_address));
            $row = $builder->get()->getRow();
            return isset($row) ? true : false;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new \Exception($ex->getMessage());
        }
    }

    /**
     * Method checks if a particular email address is in use
     * @param string $email_address
     * @param int $user_id
     * @return bool
     */
    protected function isEmailAddressInUse($email_address, $user_id) {
         try {
            $db = db_connect();

            $builder = $db->table('user');
            $builder->select('id');
            $builder->where('email_address', $email_address);
            $row = $builder->get()->getRow();

            if (!isset($row)) {
                return false;
            }

            return $row->id == $user_id ? false : true;

         } catch (\Exception $ex) {
             log_message('error', $ex->getMessage());
             return true;
         }
    }
    
    /**
     * Method gets the groups a user belongs to
     * @param int $id
     * @return array
     */
    
    public function getGroupsForUser($id) {
        try {
            $db = db_connect();

            $builder = $db->table('group_member');
            $builder->select('group.id, group.name, group.comment, group.created_by');
            $builder->join('group_member', 'group_member.group_id = group.id');
            $builder->where('group.state > 0');
            $builder->where('group_member.user_id', $id);

            $result = $builder->get();

            $result_set = null;

            foreach ($result->getResult() as $row) {
                $result_set[] = [
                    'id'         => $row->id,
                    'name'       => $row->name,
                    'comment'    => $row->comment,
                    'created_by' => $row->created_by
                ];
            }

            return $result_set;
        } catch (\Exception $ex) {
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request';

            log_message('error', $ex->getMessage());

            return $response;
        }
    }
    
    /**
     * Method verifies a user by ID
     * @param  int $id
     * @return object
     * @throws Exception
     */
    protected function verifyUserById($id) {
        try {
            $db = db_connect();
            
            $builder = $db->table('user');
            $builder->select('id, password, first_name, last_name');
            $builder->where('id', $id);
            return $builder->get()->getRow();

        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new \Exception($ex->getMessage());
        }
    }

    /**
     * Method verifies a user by checking the email address
     * @param string
     * @return object
     */
    protected function verifyUserByEmail($email_address) {
        try {
            $db = db_connect();

            $builder = $db->table('user');
            $builder->select('id, first_name, last_name, state');
            $builder->where('email_address', trim($email_address));
            return $builder->get()->getRow();
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new \Exception($ex->getMessage());
        }
    }

    /**
     * Method fetches available roles on the system
     * @return array
     */
    
    public function getAvailableRoles() {
        try {
            $db = db_connect();
            
            $builder = $db->table('role');
            $builder->select('id, description');
            $builder->orderBy('id', 'ASC');
            
            $result = $builder->get();
            
            $result_set = null;
            
            foreach ($result->getResult() as $row) { 
                $result_set[] = array(
                  'id'          => $row->id,
                  'description' => $row->description
                );
            }
            
            $response['returned_rows'] = sizeof($result_set);
            $response['result_set']    = $result_set;
            $response['status']        = true;
            $response['remark']        = '';
            
            return $response;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['returned_rows'] = 0;
            $response['result_set']    = null;
            $response['status']        = false;
            $response['remark']        = $ex->getMessage();
            return $response;
        }
    }
    
    /**
     * Method gets the list of available users in the system
     * @param int
     * @param int
     * @return array
     */
    public function getAvailableUsers($current_user_id = 0, $id_to_fetch = 0) {
        try {        
            $db = db_connect();
            
            $builder = $db->table('user');
            $builder->select('user.id, email_address, user.state, first_name, last_name, last_password_change');
            $builder->select('created_date, last_login, description, user.use_otp, user.quota');
            $builder->select('role.id AS role_id');
            $builder->join('role', 'user.role = role.id');

            if ($current_user_id > 0) {
                $builder->where('user.id <>', $current_user_id);
            }

            if ($id_to_fetch > 0) {
                $builder->where('user.id', $id_to_fetch);
            }

            $builder->orderBy('user.first_name', 'ASC');
            $result = $builder->get();
                        
            $result_set = null;

            $quota_model = new QuotaModel();
            helper('number');
            
            foreach ($result->getResult() as $row) { 
                
                $created_date = Time::parse($row->created_date)->toDateTimeString();
                
                if ($row->last_login !== null) {
                    $last_login = Time::parse($row->last_login)->toDateTimeString();
                } else {
                    $last_login = 'Never';
                }

                if ($row->last_password_change !== null) {
                    $last_pwd_change = Time::parse($row->last_password_change)->toDateTimeString();
                } else {
                    $last_pwd_change = 'Never';
                }

                $used_quota = $quota_model->computeUsedQuota($row->id);
                
                $result_set[] = array(
                  'id'                   => $row->id,
                  'email_address'        => $row->email_address,
                  'first_name'           => $row->first_name,
                  'last_name'            => $row->last_name,
                  'last_password_change' => $last_pwd_change,
                  'created_date'         => $created_date,
                  'last_login'           => $last_login,
                  'description'          => $row->description,
                  'role_id'              => $row->role_id,
                  'state_id'             => $row->state,
                  'state'                => $row->state == 0 ? 'Inactive' : 'Active',
                  'use_otp'              => (int) $row->use_otp,
                  'allocated_quota'      => number_to_size($row->quota, 2),
                  'used_quota'           => number_to_size($used_quota['quota'], 2),
                  'remaining_quota'      => number_to_size($row->quota - $used_quota['quota'], 2),
                  'display_quota'        => $row->role_id != UserRole::ADMINISTRATOR ? true : false,
                  'quota'                => $row->quota
                );
            }
            
            $response['returned_rows'] = sizeof($result_set);
            $response['result_set']    = $result_set;
            $response['status']        = true;
            $response['remark']        = '';
            
            return $response;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['returned_rows'] = 0;
            $response['result_set']    = null;
            $response['status']        = false;
            $response['remark']        = 'Something went wrong while processing your request';
            return $response;
        }
    }

    /**
     * Method fetches user details
     * @param int
     * @param bool
     * @return array
     */
    public function getUserDetails($id, $is_login = true) {
        try {
            $db = db_connect();
            
            $builder = $db->table('user');
            $builder->select('user.id, user.state, first_name, last_name, email_address');
            $builder->select('user.role, last_login, last_password_change, role.description, user.use_otp');
            $builder->join('role', 'user.role = role.id');
            $builder->where('user.id', $id);

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['remark']     = 'Unable to fetch user details. Try again later';
                $response['status']     = false;
                $response['result_set'] = null;
                return $response;
            }

            $response['remark']     = '';
            $response['status']     = true;
            $response['result_set'] = $row;

            if ($is_login) {
                $update = $db->table('user');
                $update->set('last_login', new Time('now'));
                $update->where('user.id', $id);
                $update->update();    
            }

            return $response;

        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['result_set'] = null;
            $response['status']     = false;
            $response['remark']     = 'Something went wrong while processing your request';
            return $response;
        }
    }

    /**
     * Method locks/unlocks a profile
     * @param array
     * @return bool
     */
    private function changeProfileState($request) {
        try {
            $db = db_connect();

            $builder = $db->table('user');

            if ($request['op'] === 1) {
                $parameter_model = new ParameterModel();
                $row = $parameter_model->getParameter('lockout_time');
                $builder->set('unlock_time', date('Y-m-d H:i:s', time() + ($row->parameter_value * 60)));
                $builder->set('is_locked', true);
            } else {
                $builder->set('unlock_time', null);
                $builder->set('is_locked', false);
            }
            
            $builder->where('id', $request['id']);
            $builder->update();

            return true;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method authenticates a login request
     * @param  array
     * @return array 
     */
    
    public function authenticateLogin($request) {
        try {
            $db = db_connect();

            $builder = $db->table('user');
            $builder->select('id, password, email_address, first_login, last_login, state, is_locked, unlock_time, user.role');
            $builder->where('email_address', trim($request['email_address']));
            
            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['remark']        = 'Invalid username or password provided';
                $response['status']        = false;
                $response['exception_msg'] = null;
                $response['user_id']       = 0;
                return $response;
            }
            
            // credentials are correct. is the profile active?
            if ($row->state <= 0) {
                $response['remark']        = 'Access denied. Your profile is inactive';
                $response['status']        = false;
                $response['exception_msg'] = null;
                $response['user_id']       = 0;
                return $response;
            }

            if ($row->is_locked > 0 && strtotime($row->unlock_time) > time()) {

                $unlock_time  = strtotime($row->unlock_time);
                $current_time = time();

                $minutes = round(($unlock_time - $current_time) / 60, 0);

                if ($minutes <= 1) {
                    $response['remark'] = sprintf('Profile locked. Try again in a minute', $minutes);
                } else {
                    $response['remark'] = sprintf('Profile locked. Try again in %s minutes', $minutes);
                }
                $response['status'] = false;
                $response['exception_msg'] = null;
                $response['user_id'] = 0;
                return $response;
            }
            
            $lib = new StringHelper();
            
            // check if the password is correct?
            $result = strcmp($row->password, $lib->hashPassword($request['password']));
    
            $login_logger['user_id'] = $row->id;
            $login_logger['result']  = $result == 0 ? 1 : 0;
            
            $this->logLoginAttempt($login_logger);
            
            if ($result != 0) {

                $parameter_model = new ParameterModel();
                $attempts = $parameter_model->getParameter('max_number_attempts');

                // lock the profile at this point
                if ($request['attempt_no'] >= $attempts->parameter_value) {
                    $profile['id'] = $row->id;
                    $profile['op'] = 1;
                    $this->changeProfileState($profile);
                }

                $response['remark']            = 'Invalid username or password provided';
                $response['status']            = false;
                $response['exception_msg']     = null;
                $response['first_login']       = 0;
                $response['user_id']           = 0;
                $response['wrong_credentials'] = true;
                return $response;
            }

            // flag the profile as unlocked at this point
            if ($row->is_locked > 0) {
                $profile['op'] = 0;
                $profile['id'] = $row->id;
                $this->changeProfileState($profile);
            }
            
            $parameter_model  = new ParameterModel();
            $param_result = $parameter_model->getParameter('session_timeout');

            // create the parameter if it does not exist
            if (!isset($param_result)) {
                $param['parameter_name']  = 'session_timeout';
                $param['parameter_value'] = 5;
                $parameter_model->createParameter($param);
                $response['session_timeout'] = 5;
            } else {
                $response['session_timeout'] = $param_result->parameter_value;
            }

            $response['remark']               = '';
            $response['status']               = true;
            $response['exception_msg']        = null;
            $response['first_login']          = (bool) $row->first_login;
            $response['user_id']              = $row->id;
            $response['result_set']           = $row;
            $response['has_password_expired'] = $this->hasPasswordExpired($row->id);
            $response['routes']               = $this->getRoutes($row->role);

            return $response;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            $response['first_login']   = 0;
            $response['user_id']       = 0;

            return $response;
        }
    }

    /**
     * Method gets the available routes
     * @param int
     * @return array
     */
    private function getRoutes($id) {
        $result_set = [];
        try {
            $db = db_connect();
            $builder = $db->table('route');
            $builder->select('base_path, route_path');
            $builder->where('role_id', $id);

            $result = $builder->get();

            foreach ($result->getResult() as $row) {
                array_push($result_set, sprintf('%s%s', strtolower(trim($row->base_path)), strtolower(trim($row->route_path))));
            }

            return $result_set;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            return $result_set;
        }
    }

    /**
     * Method logs platform details to the database
     * @param  array
     * @return bool
     * @throws Exception
     */
    public function logPlatformDetails($request) {
        try {
            $db = db_connect();

            $builder = $db->table('platform');

            $data = [
                'user_agent'  => $request['user_agent'],
                'version'     => $request['version'],
                'is_robot'    => $request['is_robot'],
                'is_mobile'   => $request['is_mobile'],
                'platform'    => $request['platform'],
                'date_logged' => $request['date_logged'],
            ];

            $builder->insert($data);
            return true;

        } catch(\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }
    
    /**
     * Method logs a login attempt
     * @param  array
     * @return void
     * @throws Exception
     */
    private function logLoginAttempt($request) {
        try {
            $lib = new StringHelper();

            $ip_address = $lib->getIpAddress();
            $db = db_connect();
            
            $user_activity = $db->table('user_activity');
            $data = [
                       'user_id'     => $request['user_id'],
                       'date_logged' => new Time('now'),
                       'is_success'  => $request['result'],
                       'ip_address'  => $ip_address,
                    ];
            
            $user_activity->insert($data);
            return;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            return;
        }
    }

    /**
     * Method checks if a password has expired
     * @param int
     * @return bool
     */
    private function hasPasswordExpired($id) {
        try {
            $parameter_model = new ParameterModel();
            $row = $parameter_model->getParameter('max_password_age');

            if (!isset($row)) {
                return false;
            }

            $db = db_connect();
            $builder = $db->table('user');
            $builder->select('COALESCE(ABS(DATEDIFF(last_password_change, NOW())), 0) AS password_age');
            $builder->where('id', $id);

            $result = $builder->get()->getRow();

            if (!isset($result)) {
                return false;
            }

            return $result->password_age >= $row->parameter_value ? true : false;

        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }
    
    /**
     * Method initiates a password reset
     * @param array
     * @return array
     */
    public function initiatePasswordReset($request) {
        try {
            // does the user profile exist?
            $row = $this->verifyUserByEmail($request['email_address']);

            if (!isset($row)) {
                $response['remark']        = 'Password reset initiated. If your email address is in our records, you will get reset instructions in your inbox';
                $response['status']        = true;
                $response['exception_msg'] = null;
                return $response;
            }

            // the profile exists, we can proceed...
            $lib = new StringHelper();

            $generated_token = strtolower($lib->generateGuid(false));

            if (empty($generated_token)) {
                $response['remark'] = 'Something went wrong while processing your request';
                $response['status'] = false;
                return $response;
            }
            
            $db = db_connect();
            $builder = $db->table('password_reset');
            
            $data = [
                       'user_id'         => $row->id,
                       'request_time'    => new Time('now'),
                       'expiry_time'     => date('Y-m-d H:i:s', time() + 3600),
                       'token_state'     => 0,
                       'generated_token' => $generated_token
                    ];
            
            $builder->insert($data);

            $email_param['name']                = sprintf('%s %s', $row->first_name, $row->last_name);
            $email_param['password_reset_link'] = sprintf('%s/%s/%s/%s', site_url(), 'Common', 'ValidatePasswordReset', $generated_token);
            $email_param['email_address']       = $request['email_address'];
            
            $this->sendResetInitiateEmail($email_param);
            
            $response['remark']        = 'Password reset initiated. If your email address is in our database, you will get reset instructions in your inbox';
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();

            return $response;
        }
    }

    /**
     * Method to check if a token is valid
     * @param  array
     * @return array
     */
    
    public function isTokenValid($request) {
        try {
            // check if the token exists
            $db = db_connect();
            
            $builder = $db->table('password_reset');
            $builder->select('user_id, token_state, expiry_time');
            $builder->where('generated_token', trim($request['token']));
            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['remark']        = 'Invalid Request. Reset token not found';
                $response['status']        = false;
                $response['exception_msg'] = null;
                
                return $response;
            }
            
            // has the token being used?
            if ($row->token_state > 0) {
                $response['remark']        = 'This reset token has already been used';
                $response['status']        = false;
                $response['exception_msg'] = null;
                
                return $response;
            }
            
            // has the token expired?
            $current_time = time();
            $expiry_time  = strtotime($row->expiry_time);

            if ($expiry_time <= 0) {
                $response['remark']        = 'Invalid expiry time. Please initiate a new request';
                $response['status']        = false;
                $response['exception_msg'] = null;

                return $response;
            }

            if ($current_time > $expiry_time) {
                $response['remark']        = 'The reset token has expired. Please initiate a new password request';
                $response['status']        = false;
                $response['exception_msg'] = null;

                return $response;
            }
            
            // get the email address and user ID of this user
            $user = $db->table('user');
            $user->select('email_address');
            $user->where('id', $row->user_id);
            
            $user_row = $user->get()->getRow();
            
            $response['user_id']       = $row->user_id;
            $response['email_address'] = $user_row->email_address;
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }

    /**
     * Method modifies a user profile
     * @param type
     * @return type
     */
    public function modifyProfile($request) {
        try {
            // check if the user ID exists...
            $row = $this->verifyUserById($request['user_id']);

            session_start();
            
            if (!isset($row)) {
                $response['remark']        = 'Unable to modify the profile. The user profile does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                
                return $response;
            }

            // check if the email address is in use
            if ($this->isEmailAddressInUse($request['email_address'], $request['user_id'])) {
                $response['remark'] = sprintf('Unable to modify the profile. The email address %s is already in use', $request['email_address']);
                $response['status'] = false;
                $response['exception_msg'] = null;

                return $response;
            }
            
            // update the quota as well
            if ($request['role'] != UserRole::ADMINISTRATOR && $request['quota'] >= 0) {
                $quota_model = new QuotaModel();

                // what is the current used quota?
                $used_quota = $quota_model->computeUsedQuota($request['user_id']);

                if (!$used_quota['status']) {
                    $response['remark'] = 'Unable to calculate used quota. Try again later';
                    $response['status'] = false;
                    return $response;
                }
                
                helper('number');

                if ($used_quota['quota'] > ($request['quota'] * 1024 * 1024)) {
                    $response['remark'] = sprintf('Unable to save the changes. Used quota (%s) is more than requested quota (%s)',
                                          number_to_size($used_quota['quota'], 2), number_to_size($request['quota'] * 1024 * 1024), 2);
                    $response['status'] = false;
                    return $response;
                }

                $quota_model->updateUserQuota($request['user_id'], $request['quota']);
            }     
            
            $db = db_connect();
            $lib = new StringHelper();

            $first_name = $lib->formatName($request['first_name'], false);
            $last_name  = $lib->formatName($request['last_name'], false);
            
            $builder = $db->table('user');
            $builder->set('first_name', $first_name);
            $builder->set('last_name', $last_name);
            $builder->set('role', $request['role']);
            $builder->set('email_address', $request['email_address']);
            $builder->set('updated_date', new Time('now'));
            $builder->set('state', $request['state']);
            $builder->set('use_otp', $request['use_otp']);
            
            $builder->where('id', $request['user_id']);
            $builder->update();

            if ($request['user_id'] == $_SESSION['user_id']) {
                $_SESSION['first_name'] = $first_name;
                $_SESSION['last_name']  = $last_name;
            }
            
            $response['remark']        = 'User profile successfully modified';
            $response['status']        = true;
            $response['exception_msg'] = null;
                
            return $response;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }
    
    /**
     * Method resets a password using a token (self reset)
     * @param type $request
     * @return type $response
     */
    public function resetPasswordUsingToken($request) {
        try {
            $row = $this->verifyUserById($request['user_id']);
            
            if (!isset($row)) {
                $response['remark']        = 'Unable to reset the password. User does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
            
                return $response;
            }
            
            $db = db_connect();
            $builder = $db->table('password_reset');
            $builder->select('user_id, request_time, expiry_time, token_state, generated_token');
            $builder->where('generated_token', $request['token']);
            
            $token = $builder->get()->getRow();
            
            if(!isset($token)) {
                $response['remark']        = 'Unable to reset the password. The reset token does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            if ($token->token_state < 0) {
                $response['remark']        = 'Unable to reset the password. The reset token has expired';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }
            
            // has the token expired?            
            if (time() > strtotime($token->expiry_time)) {

                // flag the token as expired
                $this->flagTokenAsExpired($request['token'], $request['user_id']);

                $response['remark']        = 'Unable to reset the password. The reset token has expired';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            // has the token been used?
            if ($token->token_state > 0) {
                $response['remark']        = 'Unable to reset the password. The reset token has already been used';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }
            
            // is there a mismatch between the user ID in the request and what's in the database?
            if ($request['user_id'] != $token->user_id) {
                $response['remark']        = 'Unable to reset the password. Please initiate a new password reset request';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }
            
            $lib = new StringHelper();
            $new_password = $lib->generateRandomPassword(8);

            // get the user details...
            $user = $db->table('user');
            $user->select('first_name, last_name, email_address, password');
            $user->where('id', $request['user_id']);

            $user_record = $user->get()->getRow();

            // reset the password now...
            $reset = $db->table('user');
            $reset->set('password', $lib->hashPassword($new_password));
            $reset->set('first_login', 1);
            $reset->set('updated_date', new Time());
            $reset->where('id', $request['user_id']);
            $reset->update();

            // log the previous password in the history table
            $this->logCurrentPasswordToHistory($request['user_id'], $user_record->password);

            $reset_param['op'] = 0;
            $reset_param['id'] = $request['user_id'];

            // unlock the profile if locked
            $this->changeProfileState($reset_param);

            $email_param['name']          = sprintf('%s %s', $user_record->first_name, $user_record->last_name);
            $email_param['email_address'] = $user_record->email_address;
            $email_param['new_password']  = $new_password;
            
            $this->sendPasswordResetEmail($email_param);

            // flag the token as used
            $this->flagTokenAsUsed($request['token'], $request['user_id']);
            
            $response['remark']        = 'Password successfully reset. Check your e-mail for the new password';
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }

    /**
     * Method logs the current password to history
     * @param $user_id
     * @param $password
     * @return bool
     */
    protected  function logCurrentPasswordToHistory($user_id, $password) {
        try {
            $db = db_connect();
            $logger = $db->table('password_history');

            $data = [
              'user_id'     => $user_id,
              'password'    => $password,
              'date_logged' => new Time('now'),
            ];

            $logger->insert($data);

            return true;

        } catch(\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method flags a token as used
     * @param string
     * @return bool
     */
    private function flagTokenAsUsed($token, $user_id) {
        try {
            $db = db_connect();
            $builder = $db->table('password_reset');
            $builder->set('token_state', 1);
            $builder->set('token_usage_time', new Time('now'));
            $builder->where('user_id', $user_id);
            $builder->where('generated_token', $token);

            $builder->update();

            return true;
        } catch(\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method flags a token as expired
     * @param string
     * @return bool
     */
    private function flagTokenAsExpired($token, $user_id) {
        try {
            $db = db_connect();
            $builder = $db->table('password_reset');
            $builder->set('token_state', -1);
            $builder->set('token_usage_time', new Time('now'));
            $builder->where('user_id', $user_id);
            $builder->where('generated_token', $token);
            
            $builder->update();

            return true;
        } catch(\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method verifies if an OTP is correct
     * @param $code
     * @param $id
     * @return array
     */
    public function verifyOtp($code, $id) {
        $response = [];
        try {
            $db = db_connect();

            $builder = $db->table('otp');
            $builder->select('code, date_expiry');
            $builder->where('user_id', $id);

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $this->generateOtp($id);
                $response['remark'] = 'Unable to verify the OTP provided. Please check your email for a new OTP';
                $response['status'] = false;
                return $response;
            }

            // what is the max attempt count?
            $parameter_model = new ParameterModel();
            $max_attempts = $parameter_model->getParameter('max_number_attempts');

            // is the OTP correct?
            $lib = new StringHelper();
            $otp = $lib->decryptString($row->code, $_SESSION['encryption_key']);

            if (strcmp($otp, trim($code)) == 0) {
                if (time() > strtotime($row->date_expiry)) {
                    $this->generateOtp($id);
                    $response['remark'] = 'OTP has expired. Please check your email for a new OTP';
                    $response['status'] = false;
                    $response['max_attempts'] = $max_attempts->parameter_value;
                    return $response;
                } else {
                    $response['remark']       = '';
                    $response['status']       = true;
                    $response['otp_valid']    = true;
                    $response['max_attempts'] = $max_attempts->parameter_value;
                    return $response;
                }
            } else {
                $response['max_attempts'] = $max_attempts->parameter_value;
                $response['remark']       = 'Invalid OTP provided. Please try again';
                $response['status']       = false;
                $response['otp_valid']    = false;
                return $response;
            }

        } catch(\Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;
            return $response;
        }
    }

    /**
     * Method generates an OTP to be used when logging in
     * @param $id
     * @return array
     */
    public function generateOtp($id) {
        $response = [];

        try {
            $db = db_connect();

            $db->transBegin();
  
            $builder = $db->table('otp');
            $builder->where('user_id', $id);
            $builder->delete();

            $parameter_model = new ParameterModel();
            $row = $parameter_model->getParameter('session_timeout');

            if (!isset($row)) {
                $response['status'] = false;
                $response['remark'] = 'Unable to generate an OTP. Please contact technical support';
                return $response;
            }

            // generate a six digit random number
            $otp = mt_rand(100000, 999999);

            $lib = new StringHelper();

            $_SESSION['encryption_key'] = $lib->generateRandomPassword(16);

            $data = [
                'user_id'       => $id,
                'code'          => $lib->encryptString($otp, $_SESSION['encryption_key']),
                'date_created'  => new Time('now'),
                'date_expiry'   => date('Y-m-d H:i:s', time() + ($row->parameter_value * 60))
            ];  

            $builder->insert($data);
            $db->transCommit();

            // send an email with the OTP details
            $user_response = $this->getUserDetails($id, false);

            // user probably does not exist
            if ($user_response['result_set'] == null) {
                $response['status'] = false;
                $response['remark'] = 'We were unable to send the code. Contact support if the issue persists';
                return $response;
            }

            $row = $user_response['result_set'];
            $param['name'] = sprintf('%s %s', $row->first_name, $row->last_name);
            $param['email_address'] = $row->email_address;
            $param['otp'] = $otp;

            if ($this->sendOtpEmail($param)) {
                $response['status'] = true;
                $response['remark'] = 'Please enter the code that we have sent to your email address';
            } else {
                $response['status'] = false;
                $response['remark'] = 'We were unable to send the code. Please try again later';
            }

            return $response;

        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['status'] = false;
            $response['remark'] = 'Something went wrong while processing your request';
            return $response;
        }
    }

    /**
     * Method resets a password for a user
     * @param  array
     * @return array
     */
    public function resetPassword($request) {
        try {
            $row = $this->verifyUserById($request['user_id']);
            
            if (!isset($row)) {
                $response['remark']        = 'Unable to reset the password. User does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
            
                return $response;
            }
            
            $lib = new StringHelper();
            $new_password = $lib->generateRandomPassword(8);
            
            $db = db_connect();
            
            // reset the password now...
            $builder = $db->table('user');
            $builder->set('password', $lib->hashPassword($new_password));
            $builder->set('first_login', 1);
            $builder->where('id', $request['user_id']);
            $builder->update();
            
            // get the user details...
            $user = $db->table('user');
            $user->select('first_name, last_name, email_address');
            $user->where('id', $request['user_id']);
            
            $user_record = $user->get()->getRow();

            $email_param['name']          = sprintf('%s %s', $user_record->first_name, $user_record->last_name);
            $email_param['email_address'] = $user_record->email_address;
            $email_param['new_password']  = $new_password;

            $reset_param['op'] = 0;
            $reset_param['id'] = $request['user_id'];

            // unlock the profile if locked
            $this->changeProfileState($reset_param);

            // send the new credendtials
            $this->sendPasswordResetEmail($email_param);

            $response['name']          =
            $response['remark']        = 'Password successfully reset and sent to the user via e-mail';
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
           
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }

    /**
     * Method checks if a password is being re-used
     * @param string $password
     * @param int $user_id
     * @return bool
     */
    private function isPasswordInHistory($password, $user_id) {
        try {
            $parameter_model = new ParameterModel();
            $row = $parameter_model->getParameter('max_remember_passwords');

            // the system is not enforcing the remembering of passwords
            if ($row->parameter_value <= 0) {
                $response['remember_count'] = 0;
                $response['count'] = false;
                $response['password_count'] = 0;
                return $response;
            }

            $db = db_connect();

            $builder = $db->table('password_history');
            $builder->selectCount('row_id', 'total_count');
            $builder->where('password', $password);
            $builder->where('user_id', $user_id);
            $builder->orderBy('date_logged', 'DESC');
            $builder->limit($row->parameter_value);

            $query = $builder->get();

            $count = $query->getRow()->total_count;

            $response['remember_count'] = $row->parameter_value;
            $response['status'] = $count > 0 ? true : false;
            $response['password_count'] = $count;

            return $response;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remember_count'] = 0;
            $response['status'] = true;

            return $response;
        }
    }

    /**
     * Method checks the complexity of a password
     * @param string $password
     * @return array
     */
    private function checkPasswordComplexity($password) {
        $uppercase     = preg_match('@[A-Z]@', $password);
        $lowercase     = preg_match('@[a-z]@', $password);
        $number        = preg_match('@[0-9]@', $password);
        $special_chars = preg_match('@[^\w]@', $password);

        try {
            $param_model = new ParameterModel();
            $row         = $param_model->getParameter('min_password_length');
            $min_length  = $row->parameter_value;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $min_length = 0;
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;
            return $response;
        }

        if (!$uppercase) {
            $response['remark'] = 'Please ensure that your password contains at least one uppercase letter';
            $response['status'] = false;
            return $response;
        } else if (!$lowercase) {
            $response['remark'] = 'Please ensure that your password contains at least one lowercase letter';
            $response['status'] = false;
            return $response;
        } else if(!$number) {
            $response['remark'] = 'Please ensure that your password contains at least a number';
            $response['status'] = false;
            return $response;
        } else if (!$special_chars) {
            $response['remark'] = 'Please ensure that your password contains a special character';
            $response['status'] = false;
            return $response;
        } else if(strlen($password) < $min_length) {
            $response['remark'] = sprintf('Please ensure that your password is at least %s characters long', $min_length);
            $response['status'] = false;
            return $response;
        } else {
            $response['remark'] = '';
            $response['status'] = true;
            return $response;
        }
    }

    /**
     * Method checks if a password is valid
     * @param array $request
     * @return bool
     */
    public function isPasswordValid($request) {
        try {
            $db = db_connect();

            $builder = $db->table('user');
            $builder->select('password');
            $builder->where('id', $request['user_id']);
            $row = $builder->get()->getRow();

            if (!isset($row)) {
                return false;
            }

            $lib = new StringHelper();
            $hashed_password_form = $lib->hashPassword($request['password']);
            return strcmp($hashed_password_form, $row->password) === 0 ? true : false;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }
    
    /**
     * Method changes a user password
     * @param array $request
     * @return array
     */
    public function changeUserPassword($request) {
        try {
            // the current and new passwords must not be the same
            if ($request['current_password'] == $request['new_password']) {
                $response['remark']        = 'The current password cannot be the same as the new password';
                $response['status']        = false;
                $response['exception_msg'] = null;
                
                return $response;
            }
            
            // check if the user ID exists...
            $row = $this->verifyUserById($request['user_id']);
            
            if (!isset($row)) {
                $response['remark']        = 'Unable to change the password. The user profile does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                
                return $response;
            }
            
            $lib = new StringHelper();
            
            // hash what was on the form and compare it to the stored value
            if (strcmp($lib->hashPassword($request['current_password']), $row->password) === 0) {

                $new_password = $lib->hashPassword($request['new_password']);

                // check if the password is in history
                $result = $this->isPasswordInHistory($new_password, $request['user_id']);

                if ($result['status']) {
                    if ($result['remember_count'] == 1) {
                        $response['remark'] = sprintf('You are not allowed to repeat your last password');
                    } else {
                        $response['remark'] = sprintf('You are not allowed to repeat your last %s passwords', $result['remember_count']);
                    }

                    $response['status']        = false;
                    $response['exception_msg'] = null;
                    return $response;
                }
 
                // are we allowed to check password complexity?
                $parameter_model = new ParameterModel();
                $complex = $parameter_model->getParameter('check_password_complexity');

                if(isset($complex) && (int) $complex->parameter_value === 1) {

                    $complex_response = $this->checkPasswordComplexity($request['new_password']);

                    if (!$complex_response['status']) {
                        $response['remark']        = $complex_response['remark'];
                        $response['status']        =  false;
                        $response['exception_msg'] = null;
                        return $response;
                    }
                }

                $db = db_connect();
                $builder = $db->table('user');

                $builder->set('password', $new_password);
                $builder->set('last_password_change', new Time('now'));
                $builder->set('first_login', false);
                $builder->where('id', $request['user_id']);
                $builder->update();

                unset($_SESSION['has_password_expired']);
                unset($_SESSION['first_login']);

                // keep a log of the password in history
                $this->logCurrentPasswordToHistory($request['user_id'], $row->password);

                $user_details = $this->getUserDetails($request['user_id'], false);
                $row = $user_details['result_set'];

                // send a notification about the password change
                $param['timestamp']     = time();
                $param['name']          = sprintf('%s %s', $row->first_name, $row->last_name);
                $param['email_address'] = $row->email_address;

                $this->sendPasswordChangeEmail($param);

                $response['remark']        = 'Password successfully changed';
                $response['status']        = true;
                $response['exception_msg'] = null;
                
                return $response;
            } else {
                $response['remark']        = 'Incorrect password provided. The password has not been changed';
                $response['status']        = false;
                $response['exception_msg'] = null;
                
                return $response;
            }
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']         = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }
    
    /**
     * Method creates a new user in the system
     * @param array $request
     * @return array
     */
    public function createUser($request) {
        try {            
            if ($this->doesUserExist($request['email_address'])) {
                $response['remark']        = sprintf('The username %s already exists. Please try a different email address', $request['email_address']);
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }
            
            $db = \db_connect();
            
            $lib = new StringHelper();
            
            $builder = $db->table('user');
            
            $new_password = $lib->generateRandomPassword(8);

            if ($request['role'] == UserRole::ADMINISTRATOR) {
                $data = [
                    'email_address' => trim($request['email_address']),
                    'first_name'    => $lib->formatName($request['first_name'], false),
                    'last_name'     => $lib->formatName($request['last_name'], false),
                    'role'          => $request['role'],
                    'password'      => $lib->hashPassword($new_password),
                    'first_login'   => 1,
                    'created_date'  => new Time('now'),
                    'state'         => 1,
                    'use_otp'       => $request['use_otp'],
                    'quota'         => 0,
                ];                
            } else {
                $data = [
                    'email_address' => trim($request['email_address']),
                    'first_name'    => $lib->formatName($request['first_name'], false),
                    'last_name'     => $lib->formatName($request['last_name'], false),
                    'role'          => $request['role'],
                    'password'      => $lib->hashPassword($new_password),
                    'first_login'   => 1,
                    'created_date'  => new Time('now'),
                    'state'         => 1,
                    'use_otp'       => $request['use_otp'],
                    'quota'         => $request['quota'] * 1024 * 1024,
                ];
            }
            
            $builder->insert($data);
            
            $emailer['name']          = sprintf('%s %s', $lib->formatName($request['first_name']), $lib->formatName($request['last_name']));
            $emailer['email_address'] = $request['email_address'];
            $emailer['new_password']  = $new_password;
            
            $this->sendNewUserEmail($emailer);
            
            $response['remark']        = 'User profile successfully created. Credentials sent via email';
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
            
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }

    /**
     * Method sends an email with the link to initiate the password request
     * @param array $request
     * @return array
     */
    protected function sendResetInitiateEmail($request) {
        try {
            $db = db_connect();
        
            $builder = $db->table('email_template');
            $builder->select('parameter_value');
            $builder->where('parameter_name', 'password_self_reset_request');

            $row = $builder->get()->getRow();

            if (!isset($row)) {//
                log_message('error', sprintf('Missing template: %s', 'password_self_reset_request'));
                throw new \Exception('Missing template: password_self_reset_request');
            }

            // transform the email template
            $email_template = $row->parameter_value;
            $transform = array("{name}" => $request['name'], "{password_reset_link}" => $request['password_reset_link']);
            $email_msg = strtr($email_template, $transform);
  
            $parameter_model = new ParameterModel();
            $parameters = $parameter_model->getAllParameters();

            $config['SMTPHost']    = $parameters['smtp_host'];
            $config['SMTPUser']    = $parameters['smtp_username'];
            $config['SMTPPass']    = $parameters['smtp_password'];
            $config['SMTPPort']    = $parameters['smtp_port'];
            $config['SMTPTimeout'] = $parameters['smtp_timeout'];
            $config['SMTPCrypto']  = $parameters['smtp_crypto'];
            $config['mailType']    = 'html';
            $config['protocol']    = 'smtp';
            $config['charset']     = 'utf-8';
            $config['priority']    = 1;
  
            $email = \Config\Services::email($config);
            $email->setFrom($parameters['sender_address'], $parameters['system_id']);
            $email->setTo($request['email_address']);
            $email->setReplyTo($parameters['no_reply_address'], $parameters['system_id']);
  
            $email->setSubject('Password Reset Request');
            $email->setMessage($email_msg);
 
            $email_param['recipient']     = $request['email_address'];
            $email_param['email_message'] = $email_msg;
            $email_param['submit_date']   = new Time('now');
            $email_param['subject']       = 'Password Reset Request';
 
            $result = $email->send();
 
            if (!$result) {
                $sendAttempt = 0;
                while ($sendAttempt <= 3) {
                    $result = $email->send();
                    if ($result) {
                        break;
                    } else {
                        $sendAttempt+=1;
                    }
                }
            }
 
            if ($result) {
                $email_param['is_sent']   = $result;
                $email_param['sent_date'] = new Time('now');
            }
            
            $email_logger = new LoggingModel();
            $email_logger->logOutgoingEmail($email_param);
 
            return;

        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new \Exception($ex->getMessage());
        }
    }

    /**
     * Method sends an email when a new profile has been created
     * @param array $request
     * @return void
     */
    protected function sendNewUserEmail($request) {
        try {
            $db = db_connect();
        
            $builder = $db->table('email_template');
            $builder->select('parameter_value');
            $builder->where('parameter_name', 'new_user_profile');

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                log_message('error', sprintf('Missing template: %s', 'new_user_profile'));
                return;
            }

            $email_template = $row->parameter_value;
            $transform = array("{name}" => $request['name'], "{username}" => $request['email_address'],
                               "{system_url}" => sprintf('%s/%s/%s', site_url(), 'Common', 'Index'),
                               "{password}" => $request['new_password']);
            $email_msg = strtr($email_template, $transform);

            $parameter_model = new ParameterModel();
            $parameters = $parameter_model->getAllParameters();

            $config['SMTPHost']    = $parameters['smtp_host'];
            $config['SMTPUser']    = $parameters['smtp_username'];
            $config['SMTPPass']    = $parameters['smtp_password'];
            $config['SMTPPort']    = $parameters['smtp_port'];
            $config['SMTPTimeout'] = $parameters['smtp_timeout'];
            $config['SMTPCrypto']  = $parameters['smtp_crypto'];
            $config['mailType']    = 'html';
            $config['protocol']    = 'smtp';
            $config['charset']     = 'utf-8';
            $config['priority']    = 1;
  
            $email = \Config\Services::email($config);
            $email->setFrom($parameters['sender_address'], $parameters['system_id']);
            $email->setTo($request['email_address']);

            $email->setReplyTo($parameters['no_reply_address'], $parameters['system_id']);
            $email->setSubject('New User Profile');
            $email->setMessage($email_msg);

            $email_param['recipient']     = $request['email_address'];
            $email_param['email_message'] = $email_msg;
            $email_param['submit_date']   = new Time('now');
            $email_param['subject']       = 'New User Profile';

            $result = $email->send();

            if (!$result) {
                $sendAttempt = 0;
                while ($sendAttempt <= 3) {
                    $result = $email->send();
                    if ($result) {
                        break;
                    } else {
                        $sendAttempt+=1;
                    }
                }
            }

            if ($result) {
                $email_param['is_sent']   = $result;
                $email_param['sent_date'] = new Time('now');
            }

            $email_logger = new LoggingModel();
            $email_logger->logOutgoingEmail($email_param);

            return;

        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new \Exception($ex->getMessage());
        }
    }

    /**
     * Method sends an email when the password has been changed
     * @param array $request
     * @return void
     */

    protected function sendPasswordChangeEmail($request) {
        try {
            $db = db_connect();

            $builder = $db->table('email_template');
            $builder->select('parameter_value');
            $builder->where('parameter_name', 'password_change');

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                log_message('error', sprintf('Missing template: %s', 'password_change'));
                return;
            }

            $date = new DateTime();
            $timezone = $date->getTimezone();

            $email_template = $row->parameter_value;
            $transform = array("{name}" => $request['name'], "{date}" => date("l jS \of F Y h:i:s A", $request['timestamp']),
                               "{timezone}" => $timezone->getName());

            $email_msg = strtr($email_template, $transform);

            $email_param['recipient']     = $request['email_address'];
            $email_param['email_message'] = $email_msg;
            $email_param['submit_date']   = new Time('now');
            $email_param['subject']       = 'Password Changed';

            $email_logger = new LoggingModel();
            $email_logger->logOutgoingEmail($email_param);

            return;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            return;
        }
    }

    /**
     * Method sends an email with the OTP
     * @param array $request
     */
    protected function sendOtpEmail($request) {
        try {
            $db = db_connect();

            $builder = $db->table('email_template');
            $builder->select('parameter_value');
            $builder->where('parameter_name', 'otp');

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                log_message('error', sprintf('Missing template: %s', 'otp'));
                throw new \Exception('Missing template: otp');
            }

            $parameter_model = new ParameterModel();
            $parameters = $parameter_model->getAllParameters();

            $email_template = $row->parameter_value;
            $transform = array("{name}" => $request['name'], "{otp}" => $request['otp'], "{validity}" => $parameters['session_timeout']);
            $email_msg = strtr($email_template, $transform);

            $config['SMTPHost']    = $parameters['smtp_host'];
            $config['SMTPUser']    = $parameters['smtp_username'];
            $config['SMTPPass']    = $parameters['smtp_password'];
            $config['SMTPPort']    = $parameters['smtp_port'];
            $config['SMTPTimeout'] = $parameters['smtp_timeout'];
            $config['SMTPCrypto']  = $parameters['smtp_crypto'];
            $config['mailType']    = 'html';
            $config['protocol']    = 'smtp';
            $config['charset']     = 'utf-8';
            $config['priority']    = 1;

            $email = \Config\Services::email($config);
            $email->setFrom($parameters['sender_address'], $parameters['system_id']);
            $email->setTo($request['email_address']);

            $email->setSubject('One-Time Pin (OTP)');
            $email->setMessage($email_msg);
            $email->setReplyTo($parameters['no_reply_address'], $parameters['system_id']);

            $result = $email->send();

            if ($result) {     
                $email_param['is_sent']       = true;
                $email_param['sent_date']     = new Time('now');
                $email_param['recipient']     = $request['email_address'];
                $email_param['email_message'] = $email_msg;
                $email_param['submit_date']   = new Time('now');
                $email_param['subject']       = 'One-Time Pin (OTP)';

                $email_logger = new LoggingModel();
                $email_logger->logOutgoingEmail($email_param);
            }

            return $result;
        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method sends an email with the new password after a successful password reset
     * @param  array $request
     * @return void
     */
    protected function sendPasswordResetEmail($request) {
        try {
            // get the password reset message from email template
            $db = db_connect();
            
            $builder = $db->table('email_template');
            $builder->select('parameter_value');
            $builder->where('parameter_name', 'password_reset');

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                log_message('error', sprintf('Missing template: %s', 'password_reset'));
                return;
            }

            $email_template = $row->parameter_value;
            $transform = array("{name}" => $request['name'], "{new_password}" => $request['new_password']);
            $email_msg = strtr($email_template, $transform);

            $parameter_model = new ParameterModel();
            $parameters = $parameter_model->getAllParameters();

            $config['SMTPHost']    = $parameters['smtp_host'];
            $config['SMTPUser']    = $parameters['smtp_username'];
            $config['SMTPPass']    = $parameters['smtp_password'];
            $config['SMTPPort']    = $parameters['smtp_port'];
            $config['SMTPTimeout'] = $parameters['smtp_timeout'];
            $config['SMTPCrypto']  = $parameters['smtp_crypto'];
            $config['mailType']    = 'html';
            $config['protocol']    = 'smtp';
            $config['charset']     = 'utf-8';
            $config['priority']    = 1;
  
            $email = \Config\Services::email($config);
            $email->setFrom($parameters['sender_address'], $parameters['system_id']);
            $email->setTo($request['email_address']);

            $email->setSubject('Password Reset');
            $email->setMessage($email_msg);
            $email->setReplyTo($parameters['no_reply_address'], $parameters['system_id']);

            $email_param['recipient']     = $request['email_address'];
            $email_param['email_message'] = $email_msg;
            $email_param['submit_date']   = new Time('now');
            $email_param['subject']       = 'Password Reset';

            $result = $email->send();

            if (!$result) {
                $sendAttempt = 0;
                while ($sendAttempt <= 3) {
                    $result = $email->send();
                    if ($result) {
                        break;
                    } else {
                        $sendAttempt+=1;
                    }
                }
            }

            if ($result) {
                $email_param['is_sent']   = $result;
                $email_param['sent_date'] = new Time('now');
            }

            $email_logger = new LoggingModel();
            $email_logger->logOutgoingEmail($email_param);

            return;

        } catch (\Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new \Exception($ex->getMessage());
        }
    }    
}