<?php namespace App\Models;
use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use CustomHelper\Common\StringHelper;
use Exception;
use PrivilegeOptions;
use UserRole;

require_once APPPATH . '/Models/PrivilegeOptions.php';
require_once APPPATH . '/Libraries/StringHelper.php';
require_once APPPATH . '/Models/UserRole.php';

class PrivilegeModel extends Model{

    /**
     * Method gets the privilege assigned to a user on a specific document
     * @param int
     * @return array
    */
    public function getPrivilegeAssignedToUserOnDocument($request): array
    {
        $response = [];        
        try {
            $db = db_connect();

            $builder = $db->table('vw_user_document_privilege');
            $builder->select('privilege, id, uploaded_by');
            $builder->where('user_id', $request['user_id']);
            $builder->where('document_id', $request['document_id']);
            $builder->orderBy('privilege', 'DESC');

            $row = $builder->get()->getRow();

            // if the user is an admin give them full access
            if (!isset($row)) {
                $response['privilege'] = PrivilegeOptions::NO_ACCESS;
                $response['status']    = true;
                $response['is_owner']  = false;
            } else {
                $response['privilege'] = $row->privilege;
                $response['status']    = true;
                $response['is_owner']  = $row->uploaded_by == $request['user_id'];
            }
            return $response;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['privilege'] = PrivilegeOptions::NO_ACCESS;
            $response['status'] = false;
            $response['is_owner'] = false;
            $response['remark'] = 'Something went wrong while processing your request : ' . $ex->getMessage();
            return $response;
        }
    }

    /**
     * Method gets the privilege assigned to a user on a specific folder
     * @param int
     * @return array
    */
    public function getPrivilegeAssignedToUserOnFolder($request): array
    {
        $response = [];
        try {
            $db = db_connect();

            $builder = $db->table('vw_user_folder_privilege');
            $builder->select('privilege, id, created_by');
            $builder->where('user_id', $request['user_id']);
            $builder->where('folder_id', $request['folder_id']);
            $builder->orderBy('privilege', 'DESC');

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['privilege'] = PrivilegeOptions::NO_ACCESS;
                $response['status']    = true;
                $response['is_owner']  = false;
            } else {
                $response['privilege'] = $row->privilege;
                $response['status']    = true;
                $response['is_owner']  = $row->created_by == $request['user_id'];
            }
            $response['user_id']   = $request['user_id'];
            $response['folder_id'] = $request['folder_id'];
            return $response;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['privilege'] = PrivilegeOptions::NO_ACCESS;
            $response['status']    = false;
            $response['is_owner']  = false;
            $response['remark']    = 'Something went wrong while processing your request : ' . $ex->getMessage();
            return $response;
        }
    }

    /**
     * Method gets the privilege assigned to a group on a specific folder
     * @param int
     * @return array
    */
    public function getPrivilegeAssignedToGroupOnFolder($request): array
    {
        $response = [];
        try {
            $db = db_connect();

            $builder = $db->table('vw_group_folder_privilege');
            $builder->select('privilege');
            $builder->where('group_id', $request['group_id']);
            $builder->where('folder_id', $request['folder_id']);

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['privilege'] = PrivilegeOptions::NO_ACCESS;
            } else {
                $response['privilege'] = $row->privilege;
            }
            $response['status']    = true;
            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['privilege'] = PrivilegeOptions::NO_ACCESS;
            $response['status']    = false;
            $response['remark']    = 'Something went wrong while processing your request : ' . $ex->getMessage();
            return $response;
        }
    }

    /**
     * Method gets the privilege assigned to a group on a specific document
     * @param int
     * @return array
    */
    public function getPrivilegeAssignedToGroupOnDocument($request): array
    {
        $response = [];

        try {
            $db = db_connect();

            $builder = $db->table('vw_group_document_privilege');
            $builder->select('privilege');
            $builder->where('group_id', $request['group_id']);
            $builder->where('document_id', $request['document_id']);

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['privilege'] = PrivilegeOptions::NO_ACCESS;
            } else {
                $response['privilege'] = $row->privilege;
            }
            $response['status']    = true;
            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['privilege'] = PrivilegeOptions::NO_ACCESS;
            $response['status'] = false;
            $response['remark'] = 'Something went wrong while processing your request : ' . $ex->getMessage();
            return $response;
        }
    }

    /**
     * Method to check which groups have access to a document
     * @param int
     * @return array
    */
    public function getGroupAccessOnDocument($id): array
    {
        $response = [];

        try {
            $db = db_connect();
            $builder = $db->table('vw_group_document_privilege');

            $builder->select('group_id, privilege, document_id, group_name, created_date');
            $builder->where('document_id', $id);
            $builder->orderBy('group_name','ASC');
        
            $result_set = null;

            $result = $builder->get(); 

            foreach ($result->getResult() as $row) {
                $result_set[] = array(
                    'id'           => $row->group_id,
                    'group_name'   => $row->group_name,
                    'document_id'  => $row->document_id,
                    'privilege'    => $row->privilege,
                    'created_date' => $row->created_date
                );
            }

            $response['returned_rows'] = $builder->countAllResults();
            $response['status']        = true;
            $response['result_set']    = $result_set;
            $response['remark']        = '';

            return $response;

        } catch(Exception $ex) {
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request: ' . $ex->getMessage();

            log_message('error', $ex->getMessage());

            return $response;
        }
    }

    /**
     * Method to check which groups have access to a folder
     * @param int
     * @return array
    */
    public function getGroupAccessOnFolder($id): array
    {
        $response = [];

        try {
            $db = db_connect();
            $builder = $db->table('vw_group_folder_privilege');

            $builder->select('group_id, privilege, folder_id, group_name, created_date');
            $builder->where('folder_id', $id);
            $builder->orderBy('group_name','ASC');

            $result_set = null;

            $result = $builder->get(); 

            foreach ($result->getResult() as $row) {
                $result_set[] = array(
                    'id'           => $row->group_id,
                    'group_name'   => $row->group_name,
                    'folder_id'    => $row->folder_id,
                    'privilege'    => $row->privilege,
                    'created_date' => $row->created_date
                );
            }

            $response['returned_rows'] = $builder->countAllResults();
            $response['status']        = true;
            $response['result_set']    = $result_set;
            $response['remark']        = '';

            return $response;

        } catch(Exception $ex) {
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request: ' . $ex->getMessage();

            log_message('error', $ex->getMessage());

            return $response;
        }
    }

      /**
     * Method to check which users have access to a document
     * @param int
     * @return array
    */
    public function getUserAccessOnDocument($id): array
    {
        $response = [];

        try {
            $db = db_connect();

            $builder = $db->table('vw_user_document_privilege');
            $builder->select('document_id, user_id, created_date, privilege, first_name');
            $builder->select('last_name, email_address, owner, uploaded_by, id');
            $builder->where('document_id', $id);
            $builder->orderBy('first_name', 'ASC');

            $result_set = [];

            $result = $builder->get();

            foreach ($result->getResult() as $row) {
                $result_set[] = array(
                    'document_id'   => $row->document_id,
                    'user_id'       => $row->user_id,
                    'created_date'  => $row->created_date,
                    'privilege'     => $row->privilege,
                    'name'          => sprintf('%s %s', $row->first_name, $row->last_name),
                    'email_address' => $row->email_address,
                    'owner'         => $row->owner,
                    'uploaded_by'   => $row->uploaded_by,
                    'is_owner'      => $row->uploaded_by == $row->id,
                );
            }

            $response['returned_rows'] = sizeof($result_set);
            $response['status']        = true;
            $response['result_set']    = $result_set;
            $response['remark']        = '';

            return $response;

        } catch(Exception $ex) {
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request ' . $ex->getMessage();

            log_message('error', $ex->getMessage());

            return $response;
        }
    }

    /**
     * Method to check which users have access to a folder
     * @param int
     * @return array
    */
    public function getUserAccessOnFolder($id): array
    {
        $response = [];

        try {
            $db = db_connect();

            $builder = $db->table('vw_user_folder_privilege');
            $builder->select('folder_id, user_id, created_date, privilege, first_name');
            $builder->select('last_name, email_address, owner, created_by, id');
            $builder->where('folder_id', $id);
            $builder->orderBy('first_name', 'ASC');

            $result_set = [];

            $result = $builder->get();

            foreach ($result->getResult() as $row) {
                $result_set[] = array(
                    'folder_id'     => $row->folder_id,
                    'user_id'       => $row->user_id,
                    'created_date'  => $row->created_date,
                    'privilege'     => $row->privilege,
                    'name'          => sprintf('%s %s', $row->first_name, $row->last_name),
                    'email_address' => $row->email_address,
                    'owner'         => $row->owner,
                    'created_by'    => $row->created_by,
                    'is_owner'      => $row->created_by == $row->id,
                );
            }

            $response['returned_rows'] = sizeof($result_set);
            $response['status']        = true;
            $response['result_set']    = $result_set;
            $response['remark']        = '';

            return $response;

        } catch(Exception $ex) {
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request ' . $ex->getMessage();

            log_message('error', $ex->getMessage());

            return $response;
        }
    }

    /**
     * Method to get privileges for a folder
     * @param array
     * @return array
     */
    public function getPrivilegeForFolder($request): array
    {
        $response = [];

        try {
            $db = db_connect();

            // check all the groups the user belongs to, so we can check if indeed they should access the requested folder
            $builder = $db->table('folder_access_level');
            $builder->select('privilege');
            $builder->where('folder_id', $request['folder_id']);
            $builder->where('user_id', $request['user_id']); 
            $builder->orderBy('privilege', 'DESC');
            
            $row = $builder->get()->getRow();

            if (isset($row)) {
                $response['privilege']     = $row->privilege;
                $response['folder_id']     = $request['folder_id'];
                $response['is_authorised'] = true;
            } else {
                $response['privilege']     = PrivilegeOptions::NO_ACCESS;
                $response['folder_id']     = $request['folder_id'];
                $response['is_authorised'] = false;
            }
            $response['status']        = true;
            return $response;

        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['privilege'] = PrivilegeOptions::NO_ACCESS;
            $response['folder_id'] = $request['folder_id'];
            $response['remark']    = 'Something went wrong while processing your request';
            $response['status']    = false;

            return $response;
        }
    }

    /**
     * Method to get privileges for a document
     * @param array
     * @return array
     */
    public function getPrivilegeForDocument($request): array
    {
        $response = [];
        try {
            $db = db_connect();

            // check all the groups the user belongs to, so we can check if indeed they should access the requested document
            $builder = $db->table('document_access_level');
            $builder->select('privilege');
            $builder->where('document_id', $request['document_id']);
            $builder->where('user_id', $request['user_id']); 
            $builder->orderBy('privilege', 'DESC');
            
            $row = $builder->get()->getRow();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       

            if (isset($row)) {
                $response['privilege']     = $row->privilege;
                $response['document_id']   = $request['document_id'];
                $response['is_authorised'] = true;
            } else {
                $response['privilege']     = PrivilegeOptions::NO_ACCESS;
                $response['document_id']   = $request['document_id'];
                $response['is_authorised'] = false;
            }
            return $response;
        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['privilege']     = PrivilegeOptions::NO_ACCESS;
            $response['document_id']   = $request['document_id'];
            $response['is_authorised'] = false;

            return $response;
        }
    }

    /**
     * Method modifies privileges for a folder
     * @param $request
     * @param bool $send_email
     * @return array
     */
    public function modifyPrivilegeOnFolder($request, bool $send_email = true): array
    {
        $response = [];
        try {
            
            if (count($request['members']) <= 0) {
                $response['remark'] = 'Unable to complete your request. No group or user was specified';
                $response['status'] = false;
                return $response;
            }

            $db = db_connect();

            // get the folder name
            $builder = $db->table('folder');
            $builder->select('name');
            $builder->where('id', $request['folder_id']);

            $row = $builder->get()->getRow();
            
            $db->transStart();
            $lib = new StringHelper();

            foreach ($request['members'] as $user_id) {
                // this is an operation on an entire group
                if(isset($request['group_id'])) {
                    $builder = $db->table('folder_access_level');
                    $builder->where('folder_id', $request['folder_id']);
                    $builder->where('user_id', $user_id);
                    $builder->where('group_id', $request['group_id']);
                    
                    $builder->delete();

                    if ($request['privilege'] == PrivilegeOptions::READ || $request['privilege'] == PrivilegeOptions::WRITE) {
                        $data = [
                            'row_id'       => $lib->generateGuid(),
                            'folder_id'    => $request['folder_id'],
                            'user_id'      => $user_id,
                            'created_date' => new Time('now'),
                            'privilege'    => $request['privilege'],
                            'group_id'     => $request['group_id'],
                            'row_version'  => time()
                        ];
                        $db->table('folder_access_level')->insert($data);
                    } 
                } else {
                    $user_model = new UserModel();
                    $user_details = $user_model->getUserDetails($user_id, false);
                    $user = $user_details['result_set'];

                    if ($user->role == UserRole::ADMINISTRATOR) {
                        $db->transRollback();
                        $response['remark'] = 'This user is an administrator and already has full access to the folder';
                        $response['status'] = true;
                        return $response;
                    }

                    $folder_model = new FolderModel();
                    $owner = $folder_model->getFolderOwner($request['folder_id']);

                    // if this folder belongs to the owner then do not do anything
                    if ($owner == $user_id) {
                        $db->transRollback();
                        $response['remark'] = 'Unable to alter the privilege. This user is the owner and already has full access';
                        $response['status'] = false;
                        return $response;
                    }

                    $builder = $db->table('folder_access_level');
                    $builder->where('folder_id', $request['folder_id']);
                    $builder->where('user_id', $user_id);                    
                    $builder->delete();

                    if ($request['privilege'] == PrivilegeOptions::READ || $request['privilege'] == PrivilegeOptions::WRITE) {
                        $data = [
                            'row_id'       => $lib->generateGuid(),
                            'folder_id'    => $request['folder_id'],
                            'user_id'      => $user_id,
                            'created_date' => new Time('now'),
                            'privilege'    => $request['privilege'],
                            'row_version'  => time()
                        ];
                        $db->table('folder_access_level')->insert($data);  
                    } 
                }
            } 
            
            $db->transCommit();

            // determine the message to display based on the operation
            if (isset($request['group_id'])) {
                if ($request['privilege'] == PrivilegeOptions::READ) { 
                    $response['remark'] = 'Read privilege successfully set on the folder for the group';
                } else if ($request['privilege'] == PrivilegeOptions::WRITE) {
                    $response['remark'] = 'Write privilege successfully set on the folder for the group';
                } else {
                    $response['remark'] = 'Privilege successfully revoked on the folder for the group';
                }
            } else {
                if ($request['privilege'] == PrivilegeOptions::READ) {
                    $response['remark'] = 'Read privilege successfully set on the folder for the user';
                } else if ($request['privilege'] == PrivilegeOptions::WRITE) {
                    $response['remark'] = 'Write privilege successfully set on the folder for the user';
                } else {
                    $response['remark'] = 'Privilege successfully revoked on the folder for the user';
                }
            } 

            if ($send_email) {
                $this->sendNotification($request['members'], $_SESSION['user_id'], $row->name, $request['privilege'], 0);
            }

            $response['status'] = true;
            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;

            return $response;
        }
    }

    /***
     * Method assigns a privilege to a document
     * @param array
     * @return array
     */
    public function modifyPrivilegeOnDocument($request): array
    {
        $response = [];
        try {
            if (count($request['members']) <= 0) {
                $response['remark'] = 'Unable to complete your request. No group or user was specified';
                $response['status'] = false;
                return $response;
            }

            $db = db_connect();            
            $db->transStart();
            
            $lib = new StringHelper();

            // get the document name and the folder it is in
            $builder = $db->table('document');
            $builder->select('file_name, folder');
            $builder->where('id', $request['document_id']);

            $row = $builder->get()->getRow();
            
            foreach ($request['members'] as $user_id) {
                // this is an operation on an entire group
                if(isset($request['group_id'])) {
                    $builder = $db->table('document_access_level');
                    $builder->where('document_id', $request['document_id']);
                    $builder->where('user_id', $user_id);
                    $builder->where('group_id', $request['group_id']);
                    
                    $builder->delete();

                    if ($request['privilege'] == PrivilegeOptions::READ || $request['privilege'] == PrivilegeOptions::WRITE) {
                        $data = [
                            'row_id'       => $lib->generateGuid(),
                            'document_id'  => $request['document_id'],
                            'user_id'      => $user_id,
                            'created_date' => new Time('now'),
                            'privilege'    => $request['privilege'],
                            'group_id'     => $request['group_id']
                        ];
                        $db->table('document_access_level')->insert($data);

                        // does the user already have access to the folder?
                        $folder = $db->table('folder_access_level');
                        $folder->selectCount('*', 'total_count');
                        $folder->where('user_id', $user_id);
                        $folder->where('folder_id', $row->folder);
  
                        $folder_row = $folder->get()->getRow();

                        // also grant the same privilege to the folder the document is in
                        if ($folder_row->total_count <= 0) {                                  
                            $data = [
                                'row_id'       => $lib->generateGuid(),
                                'folder_id'    => $row->folder,
                                'user_id'      => $user_id,
                                'created_date' => new Time('now'),
                                'privilege'    => PrivilegeOptions::READ,
                                'group_id'     => $request['group_id'],
                                'row_version'  => time()
                            ];
                            $db->table('folder_access_level')->insert($data);
                        }
                    } 
                } else {
                    $document_model = new DocumentModel();
                    $owner = $document_model->getDocumentOwner($request['document_id']);

                    // if this folder belongs to the owner then do not do anything
                    if ($owner == $user_id) {
                        $db->transRollback();
                        $response['remark'] = 'Unable to alter the privilege. This user is the owner and already has full access';
                        $response['status'] = false;
                        return $response;
                    }
                    
                    // check if the user is already an administrator
                    $user_model = new UserModel();
                    $user_details = $user_model->getUserDetails($user_id, false);
                    $user = $user_details['result_set'];

                    if ($user->role == UserRole::ADMINISTRATOR) {
                        $db->transRollback();
                        $response['remark'] = 'This user is an administrator and already has full access to the document';
                        $response['status'] = true;
                        return $response;
                    }

                    $builder = $db->table('document_access_level');
                    $builder->where('document_id', $request['document_id']);
                    $builder->where('user_id', $user_id);                    
                    $builder->delete();

                    if ($request['privilege'] == PrivilegeOptions::READ || $request['privilege'] == PrivilegeOptions::WRITE) {
                        $data = [
                            'row_id'       => $lib->generateGuid(),
                            'document_id'  => $request['document_id'],
                            'user_id'      => $user_id,
                            'created_date' => new Time('now'),
                            'privilege'    => $request['privilege']
                        ];
                        $db->table('document_access_level')->insert($data);

                        // does the user already have access to the folder?
                        $folder = $db->table('folder_access_level');
                        $folder->selectCount('*', 'total_count');
                        $folder->where('user_id', $user_id);
                        $folder->where('folder_id', $row->folder);

                        $folder_row = $folder->get()->getRow();

                        // also grant the same privilege to the folder the document is in
                        if ($folder_row->total_count <= 0) {
                            $data = [
                                'row_id'       => $lib->generateGuid(),
                                'folder_id'    => $row->folder,
                                'user_id'      => $user_id,
                                'created_date' => new Time('now'),
                                'privilege'    => PrivilegeOptions::READ,
                                'row_version'  => time()
                            ];
                            $db->table('folder_access_level')->insert($data);
                        }
                    } 
                }
            }  

            // determine the message to display based on the operation
            if (isset($request['group_id'])) {
                if ($request['privilege'] == PrivilegeOptions::READ) { 
                    $response['remark'] = 'Read privilege successfully set on the document for the group';
                } else if ($request['privilege'] == PrivilegeOptions::WRITE) {
                    $response['remark'] = 'Write privilege successfully set on the document for the group';
                } else {
                    $response['remark'] = 'Privilege successfully revoked on the document for the group';
                }
            } else {
                if ($request['privilege'] == PrivilegeOptions::READ) {
                    $response['remark'] = 'Read privilege successfully set on the document for the user';
                } else if ($request['privilege'] == PrivilegeOptions::WRITE) {
                    $response['remark'] = 'Write privilege successfully set on the document for the user';
                } else {
                    $response['remark'] = 'Privilege successfully revoked on the document for the user';
                }
            } 
            
            $db->transCommit();
            $response['status'] = true;

            // notify the users
            $this->sendNotification($request['members'], $_SESSION['user_id'], $row->file_name, $request['privilege'], 1);

            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;
            return $response;
        }
    }

    /**
     * Method generates emails to send when privileges have been granted/removed from a group
     * @param array
     * @param int
     * @param string
     * @param int
     * @param int
     * @return void
     */
    private function sendNotification($users, $auth_user, $object_name, $privilege, $object_type): void
    {
        try {
            // get details of the authorising user
            $user_model = new UserModel();
            $auth_user = $user_model->getUserDetails($auth_user, false);

            if ($auth_user['result_set'] == null) {
                return;
            }

            $auth = $auth_user['result_set'];
            $db = db_connect();

            $builder = $db->table('email_template');
            $builder->select('parameter_value');

            // folder operation
            if ($object_type == 0) {
                if ($privilege == PrivilegeOptions::READ || $privilege == PrivilegeOptions::WRITE) {
                    $builder->where('parameter_name', 'folder_grant');
                } else {
                    $builder->where('parameter_name', 'folder_revoke');
                }        
            } else {
                if ($privilege == PrivilegeOptions::READ || $privilege == PrivilegeOptions::WRITE) {
                    $builder->where('parameter_name', 'document_grant');
                } else {
                    $builder->where('parameter_name', 'document_revoke');
                }       
            }

            $template = $builder->get()->getRow();

            if (!isset($template)) {
                log_message('error', 'Missing template - Privilege Template');
                return;
            }

            $email_template = $template->parameter_value;
            $full_name_admin = sprintf('%s %s (%s)', $auth->first_name, $auth->last_name, $auth->email_address);
                
            $email_logger = new LoggingModel();

            foreach ($users as $user) {
                $affected_user = $user_model->getUserDetails($user, false);    
                $row = $affected_user['result_set'];

                // do not send emails to inactive users
                if ($row->state <= 0) { 
                    continue;
                }

                // the user IDs match, so don't send the email
                if ($row->id == $_SESSION['user_id']) {
                    continue;
                }

                // format the names properly
                $full_name = sprintf('%s %s', $row->first_name, $row->last_name);
                $privilege_desc = '';

                if ($privilege == PrivilegeOptions::WRITE || $privilege == PrivilegeOptions::READ) {
                    $privilege_desc = $privilege == PrivilegeOptions::WRITE ? "WRITE" : "READ";

                    if ($object_type == 0) {
                        $transform = array("{name}" => $full_name, "{privilege}" => $privilege_desc, "{folder_name}" => $object_name, "{grant_user}" => $full_name_admin);
                    } else {
                        $transform = array("{name}" => $full_name, "{privilege}" => $privilege_desc, "{document_name}" => $object_name, "{grant_user}" => $full_name_admin);
                    }

                } else {
                    if ($object_type == 0) {
                        $transform = array("{name}" => $full_name, "{privilege}" => $privilege_desc, "{folder_name}" => $object_name, "{revoke_user}" => $full_name_admin);
                    } else {
                        $transform = array("{name}" => $full_name, "{privilege}" => $privilege_desc, "{document_name}" => $object_name, "{revoke_user}" => $full_name_admin);
                    }

                }
                $email_msg = strtr($email_template, $transform);

                $email_param['recipient']     = $row->email_address;
                $email_param['email_message'] = $email_msg;
                $email_param['submit_date']   = new Time('now');
                $email_param['subject']       = $object_type == 0 ? 'Folder Access' : 'Document Access';

                $email_logger->logOutgoingEmail($email_param);
            }

            return;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return;
        }
    }
}