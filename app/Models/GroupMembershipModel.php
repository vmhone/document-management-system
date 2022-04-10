<?php namespace App\Models;

use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use CustomHelper\Common\StringHelper;
use Exception;
use function db_connect;

require_once APPPATH . '/Libraries/StringHelper.php';

class GroupMembershipModel extends Model{

    /**
     * Method assigns a member to a particular group
     * @param array $request
     * @return array
     */

    public function assignUserToGroup(array $request): array
    {
        $response = [];
        try{
            $db = db_connect();

            // only assign users to groups that are active
            $builder = $db->table('group');
            $builder->select('state, name');
            $builder->where('id', $request['group_id']);
            $group = $builder->get()->getRow();

            if (!isset($group)) {
                $response['remark'] = 'Unable to add the user to the group. The group does not exist';
                $response['status'] = false;
                return $response;
            }

            if ($group->state <= 0) {
                $response['remark'] = 'Unable to add the user to an inactive group';
                $response['status'] =  false;
                return $response;
            }

            // is the user already in the group?
            $builder = $db->table('group_member');
            $builder->select('user_id, group_id');
            $builder->where('user_id', $request['user_id']);
            $builder->where('group_id', $request['group_id']);

            $group_member = $builder->get()->getRow();

            if (isset($group_member)) {
                if ($group_member->user_id == $request['user_id'] && $group_member->group_id == $request['group_id']) {
                    $response['remark'] = sprintf('The user already belongs to the group: %s', $group->name);
                    $response['status'] = true;
                    return $response;
                }
            }

            $db->transBegin();

            $data = [
                'user_id'       => $request['user_id'],
                'group_id '     => $request['group_id'],
                'assigned_by'   => $request['assigned_by'],
                'assigned_date' => new Time('now'),
            ];

            $db->table('group_member')->insert($data);

            $data = [
                'group_id'     => $request['group_id'],
                'user_id'      => $request['user_id'],
                'operation'    => 1,
                'changed_by'   => $request['assigned_by'],
                'changed_date' => new Time('now'),
            ];

            $db->table('group_membership_log')->insert($data);

            $lib = new StringHelper();

            // also get the documents the group has access to and add the user accordingly
            $document = $db->table('vw_group_document_privilege');
            $document->select('document_id, privilege');
            $document->where('group_id', $request['group_id']);

            $available_documents = $document->get();

            if (isset($available_documents)) {
                $builder = $db->table('document_access_level');

                foreach ($available_documents->getResult() as $row) { 

                    $builder->where('document_id', $row->document_id);
                    $builder->where('user_id', $request['user_id']);
                    $builder->where('group_id', $request['group_id']);
                    $builder->delete();

                    $data = [
                        'row_id'       => $lib->generateGuid(),
                        'document_id'  => $row->document_id,
                        'user_id'      => $request['user_id'],
                        'created_date' => new Time('now'),
                        'privilege'    => $row->privilege,
                        'group_id'     => $request['group_id'],
                    ];
                    $db->table('document_access_level')->insert($data);
                }
            }

            // also get the files the group has access to and add this user accordingly
            $folder = $db->table('vw_group_folder_privilege');
            $folder->select('folder_id, privilege');
            $folder->where('group_id', $request['group_id']);

            $available_folders = $folder->get();

            if (isset($available_folders)) {
                $builder = $db->table('folder_access_level');

                foreach ($available_folders->getResult() as $row) {

                    $builder->where('folder_id', $row->folder_id);
                    $builder->where('user_id', $request['user_id']);
                    $builder->where('group_id', $request['group_id']);
                    $builder->delete();

                    $data = [
                        'row_id'       => $lib->generateGuid(),
                        'folder_id'    => $row->folder_id,
                        'user_id'      => $request['user_id'],
                        'created_date' => new Time('now'),
                        'privilege'    => $row->privilege,
                        'group_id'     => $request['group_id'],
                        'row_version'  => time(),
                    ];
                    $db->table('folder_access_level')->insert($data);
                }
            }

            $db->transCommit();

            // notify the user that we have added them to the group...
            $this->sendNotification($request['user_id'], 1, $group->name);

            $response['remark'] = sprintf('User successfully added to the group: %s', $lib->formatName($group->name, true));
            $response['status'] = true;

            return $response;
        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;

            return $response;
        }
    }

    /**
     * Method sends a notification to a user
     * @param int $user_id
     * @param int $action
     * @param string $group_name
     * @return void
     */
    private function sendNotification(int $user_id, int $action, string $group_name): void
    {
        try {
            // get the details of the affected user
            $user_model = new UserModel();
            $affected_user = $user_model->getUserDetails($user_id, false);

            if ($affected_user['result_set'] == null) {
                return;
            }

            $row = $affected_user['result_set'];

            // do not send emails to inactive users
            if ((int) $row->state <= 0) {
                return;
            }

            if ($row->id == $_SESSION['user_id']) {
                return;
            }

            // get details of the authorising user
            $auth_user = $user_model->getUserDetails($_SESSION['user_id'], false);

            if ($auth_user['result_set'] == null) {
                return;
            }

            $auth = $auth_user['result_set'];

            $db = db_connect();
            $builder = $db->table('email_template');
            $builder->select('parameter_value');

            if ($action == 1) {
                $builder->where('parameter_name', 'group_membership_add');
            } else if ($action == 0) {
                $builder->where('parameter_name', 'group_membership_remove');
            } else {
                return;
            }

            $template = $builder->get()->getRow();

            if (!isset($template)) {
                log_message('error', 'Missing template - Group Email');
                return;
            }

            // format the names properly
            $full_name_affected = sprintf('%s %s', $row->first_name, $row->last_name);
            $full_name_auth = sprintf('%s %s (%s)', $auth->first_name, $auth->last_name, $auth->email_address);

            $email_template = $template->parameter_value;
            $transform = array("{name}" => $full_name_affected, "{group_name}" => $group_name, "{user}" => $full_name_auth);
            $email_msg = strtr($email_template, $transform);

            // log the outgoing email
            $email_param['recipient']     = $row->email_address;
            $email_param['email_message'] = $email_msg;
            $email_param['submit_date']   = new Time('now');
            $email_param['subject']       = 'Group Membership';

            $email_logger = new LoggingModel();
            $email_logger->logOutgoingEmail($email_param);

            return;
        } catch(Exception $ex) { 
            log_message('error', $ex->getMessage());
            return;
        }
    }

    /**
     * Method to remove a user from a group membership
     * @param array $request
     * @return array
     */
    public function revokeGroupMembership(array $request): array
    {
        $response = [];

        try{
            $db = db_connect();

            // get the group name
            $group = $db->table('group');
            $group->select('name');
            $group->where('id', $request['group_id']);

            $row = $group->get()->getRow();

            if (!isset($row)) {
                $response['remark'] = 'Unable to revoke membership. The group does not exist';
                $response['status'] = false;    
                return $response;
            }

            $db->transBegin();

            $builder = $db->table('group_member');
            $builder->where('user_id', $request['user_id']);
            $builder->where('group_id', $request['group_id']);
            $builder->delete();

            $data = [
                'group_id'     => $request['group_id'],
                'user_id'      => $request['user_id'],
                'operation'    => 0,
                'changed_by'   => $request['revoked_by'],
                'changed_date' => new Time('now'),
            ];

            $db->table('group_membership_log')->insert($data);

            // also revoke membership to the files they have access to
            $document = $db->table('document_access_level');
            $document->where('user_id', $request['user_id']);
            $document->where('group_id', $request['group_id']);
            $document->delete();

            // also revoke membership to the folders they have access to
            $folder = $db->table('folder_access_level');
            $folder->where('user_id', $request['user_id']);
            $folder->where('group_id', $request['group_id']);
            $folder->delete();

            $db->transCommit();

            $response['remark'] = 'Group membership successfully revoked';
            $response['status'] = true;

            $this->sendNotification($request['user_id'], 0, $row->name);

            return $response;
        }
        catch(Exception $ex){
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;

            return $response;
        }
    }

     /**
     * method to get all members of the different or specified group
     * @param int $id
     * @return array
     */
    public function getGroupMembers(int $id): array
    {
        $members = [];
        try {
            $db = db_connect();

            $builder = $db->table('group_member');
            $builder->select('group_member.user_id');
            $builder->join('group', 'group.id = group_member.group_id');
            $builder->join('user', 'group_member.user_id = user.id');
            $builder->where('group.state >', 0);
            $builder->where('user.state >', 0);

            if ($id != null) {
                $builder->where('group_member.group_id', $id);
            }

            $result = $builder->get();

            foreach ($result->getResult() as $row) { 
                $members[] = $row->user_id;
            }

            return array_unique($members);
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return $members;
        }
    }

    /**
     * method to get all members of the different or specified group
     * @param int|null $id
     * @param int|null $user_id
     * @return array
     */
    public function getGroupMembership(int $id = null, int $user_id = null): array
    {
        $response = [];
        try {
            $db = db_connect();

            $builder = $db->table('group_member');
            $builder->select('group.id, group.name, group.created_date, group.state, user.first_name');
            $builder->select('user.last_name, user.email_address');
            $builder->select('group_member.assigned_date, group.state, user.id as user_id');
            $builder->join('user', 'user.id = group_member.user_id');
            $builder->join('group', 'group.id = group_member.group_id');

            if ($id != null){
                $builder->where('group_member.group_id', $id);
            }

            if ($user_id != null) {
                $builder->where('user.user_id', $user_id);
            }

            $builder->where('group.state >', 0);

            $result = $builder->get();

            $result_set = null;

            foreach ($result->getResult() as $row) {

                $current_time = Time::now();

                $result_set[] = array(
                    'id'             => $row->id,
                    'humanized_time' => $current_time->difference($row->assigned_date)->humanize(),
                    'name'           => $row->name,
                    'assigned_date'  => $row->assigned_date,
                    'created_date'   => $row->created_date,
                    'first_name'     => $row->first_name,
                    'last_name'      => $row->last_name,
                    'email_address'  => $row->email_address,
                    'user_id'        => $row->user_id,
                    'group_state'    => $row->state <= 0 ? 'Inactive' : 'Active'
                );
            }
            
            $response['returned_rows'] = $builder->countAllResults();
            $response['result_set']    = $result_set;
            $response['status']        = true;
            $response['remark']        = '';

            return $response;
        }
        catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['remark']        = 'Something went wrong while processing your request';

            return $response;
        }
    }

    /**
     * Method gets group membership for each member
     * @param int $id
     * @param bool $only_include_active
     * @param bool $get_ids_only
     * @return array
     */
    public function getGroupMembershipByMember(int $id, bool $only_include_active = false, bool $get_ids_only = false): array
    {
        $response = [];
        try {
            $db = db_connect();

            $builder = $db->table('group_member');
            $builder->select('group.id, group.name, group.created_date, group.state, user.id AS user_id');
            $builder->select('group_member.assigned_date');
            $builder->join('group', 'group.id = group_member.group_id');
            $builder->join('user', 'user.id = group_member.user_id');
            $builder->where('user_id', $id);

            $result = $builder->get();

            $result_set = array();

            foreach ($result->getResult() as $row) {
                if ($only_include_active) {
                    if ($row->state > 0) {
                        if ($get_ids_only) {
                            $result_set[] = $row->id;
                        } else {
                            $result_set[] = array(
                                'id'             => $row->id,
                                'group_name'     => $row->name,
                                'created_date'   => $row->created_date,
                                'group_state'    => 'Active',
                                'group_state_id' => $row->state,
                                'assigned_date'  => $row->assigned_date,
                            );
                        }
                    }
                } else {           
                    if ($get_ids_only) {
                        $result_set[] = $row->id;
                    } else {
                        $result_set[] = array(
                            'id'             => $row->id,
                            'group_name'     => $row->name,
                            'created_date'   => $row->created_date,
                            'group_state'    => $row->state == 0 ? 'Inactive' : 'Active',
                            'group_state_id' => $row->state,
                            'assigned_date'  => $row->assigned_date,
                        );
                    }
                }
            }
            
            $response['returned_rows'] = $builder->countAllResults();
            $response['result_set']    = $result_set;
            $response['status']        = true;
            $response['remark']        = '';

            return $response;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['remark']        = 'Something went wrong while processing your request ' . $ex->getMessage();

            return $response;
        }
    }
}