<?php namespace App\Models;

use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use CustomHelper\Common\StringHelper;
use Exception;
use function db_connect;
use PrivilegeOptions;
use UserRole;

require_once APPPATH . '/Libraries/StringHelper.php';
require_once APPPATH . '/Models/UserRole.php';
require_once APPPATH . '/Models/PrivilegeOptions.php';

class FolderModel extends Model {
        
    /**
     * Method checks if a folder exists
     * @param  string
     * @return object
     * @throws Exception
     */
    private function validateFolderExistence($folder_name): object
    {
        try {
            $db = db_connect();
            
            $lib = new StringHelper();
            
            $builder = $db->table('folder');
            $builder->select('folder.id, folder.comment, folder.created_by');
            $builder->where('name', $lib->formatName(($folder_name)));
            
            $query = $builder->get();

            return $query->getRow();
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Method gets the owner of a folder
     * @param int $id
     * @return int
     * @throws Exception
     */
    public function getFolderOwner(int $id): int
    {
        try {
            $db = db_connect();

            $builder = $db->table('folder');
            $builder->select('created_by, owner');
            $builder->where('id', $id);

            $row = $builder->get()->getRow();
            
            if ($row->owner != null) {
                return $row->owner;
            } 

            return $row->created_by;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Method fetches details for a particular folder
     * @param int
     * @return array
     */
    public function getFolderDetails($id): array
    {
        try {
            $db = db_connect();
            
            $builder = $db->table('vw_folder');
            $builder->select('id, name, comment, created_date, created_by, folder_owner, folder_status, updated_date');
            $builder->select('folder_state_id, creator_email_address, owner_email_address');
            $builder->where('id', $id);
            
            $row = $builder->get()->getRow();
            
            $response = [];
            
            if (!isset($row)) {
                $response['result_set']    = null;
                $response['status']        = false;
                $response['remark']        = sprintf('Folder with ID: %d not found on the system', $id);
                $response['exception_msg'] = null;
                return $response;
            }
            
            $response['result_set']    = $row;
            $response['status']        = true;
            $response['remark']        = '';
            $response['exception_msg'] = null;
            
            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['result_set']    = null;
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            $response['remark']        = 'Something went wrong while processing your request';

            return $response;
        }
    }
    
    /**
     * Method gets a count of files in a particular folder
     * @param int $id
     * @return int
     */
    public function countDocumentsInFolder(int $id): int
    {
        try {
            $db = db_connect();
            $builder = $db->table('document');
            $builder->selectCount('id', 'total_count');
            $result = $builder->where('folder', $id)->get();
            return $result->getRow()->total_count;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return 0;
        }
    }

    /**
     * Method gets the available folders in the database
     * @param bool $include_active_only
     * @return array
     */
    public function getAvailableFolders(bool $include_active_only = false): array
    {
        try {
            $db = db_connect();

            $builder = $db->table('vw_folder');
            $builder->select('id, name, comment, created_date, created_by, folder_owner, folder_status, folder_state_id');
            $builder->select('owner_email_address, creator_email_address');

            if ($include_active_only) {
                $builder->where('folder_state_id', 1);
            }

            $builder->orderBy('name','ASC');
            $result = $builder->get();

            $result_set = null;

            $lib = new StringHelper();
            $privilege_model = new PrivilegeModel();

            foreach ($result->getResult() as $row) {

                // check if the user has access to the folder being accessed
                $param['folder_id'] = $row->id;
                $param['user_id']   = $_SESSION['user_id'];

                $response = $privilege_model->getPrivilegeForFolder($param);

                // restricted users can't do much on folders
                if ($_SESSION['role_id'] == UserRole::RESTRICTED_USER && $response['privilege'] > 0) {
                    $response['privilege'] = PrivilegeOptions::READ;
                }

                if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                    $response['privilege'] = PrivilegeOptions::WRITE;
                } else {
                    // user should not have access to this folder
                    if ($response['privilege'] == PrivilegeOptions::NO_ACCESS) {
                        continue;
                    }
                }

                $current_time = Time::now();

                $result_set[] = array(
                  'id'             => $row->id,
                  'name'           => $row->name,
                  'comment'        => $row->comment,
                  'created_date'   => $row->created_date,
                  'created_by'     => $row->created_by,
                  'folder_owner'   => $row->folder_owner,
                  'folder_status'  => $row->folder_status,
                  'status_id'      => $row->folder_state_id,
                  'humanized_time' => $current_time->difference($row->created_date)->humanize(),
                  'file_count'     => $lib->convertToThousandsFormat($this->countDocumentsInFolder($row->id)),
                  'privilege'      => $response['privilege'],
                  'role_id'        => $_SESSION['role_id'],
                  'owner_email'    => $row->owner_email_address,
                  'creator_email'  => $row->creator_email_address,
                );
            }
            
            $response['returned_rows'] = sizeof($result_set);
            $response['result_set']    = $result_set;
            $response['status']        = true;
            $response['remark']        = '';
            
            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['returned_rows'] = 0;
            $response['result_set']    = null;
            $response['status']        = false;
            $response['remark']        = $ex->getMessage();
            return $response;
        }
    }

    /**
     * Method changes the state of a folder
     * @param int $id
     * @param int $folder_state
     * @param int $updated_by
     * @return array
     */
    public function changeFolderState(int $id, int $folder_state, int $updated_by): array
    {
        try {
            $db = db_connect();
            
            $builder = $db->table('folder');
            $builder->select('folder.id');
            $builder->where('id', $id);
            $query = $builder->get();
            
            $row = $query->getRow();
            
            // check if the folder exists
            if (!isset($row)) {
                $response['remark']        = 'Unable to change the folder state. It does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;

                return $response;
            }

            $param['user_id']   = $_SESSION['user_id'];
            $param['folder_id'] = $row->id;

            // check the privilege level on the folder
            $privilege_model = new PrivilegeModel();
            $response = $privilege_model->getPrivilegeForFolder($param);

            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['remark'] = 'Unable to change the folder state. You do not have write permissions';
                $response['status'] = false;

                return $response;
            }
            
            $folder = $db->table('folder');
            $folder->set('state', $folder_state);
            $folder->set('updated_by', $updated_by);
            $folder->set('updated_date', new Time('now'));
            $folder->set('row_version', time());
            $folder->where('id', $id);
            $folder->update();
            
            $response['remark']        = 'Folder state successfully changed';
            $response['status']        = true;
            $response['exception_msg'] = null;

            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }
    
    /**
     * Method renames a folder
     * @param array $request
     * @return array
     */
    public function renameFolder(array $request): array
    {
        try {
            if (strcasecmp(trim($request['old_name']), trim($request['new_name'])) == 0) {
                $response['remark']        = 'Unable to rename the folder. The old and new name are the same';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            $param['folder_id'] = $request['id'];
            $param['user_id']   = $_SESSION['user_id'];

            $privilege_model = new PrivilegeModel();
            $response = $privilege_model->getPrivilegeForFolder($param);

            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['remark'] = 'Unable to change the folder state. Access Denied';
                $response['status'] = false;

                return $response;
            }
            
            $row = $this->validateFolderExistence($request['new_name']);
            
            // the folder exists
            if ($row->id != $request['id']) {
                 $response['remark']        = sprintf('Unable to rename the folder. Folder %s already exists', $request['new_name']);
                 $response['status']        = false;
                 $response['exception_msg'] = null;
                 return $response;
            }
            
            $db = db_connect();
            $lib = new StringHelper();
            
            $builder = $db->table('folder');
            $builder->set('name', $lib->formatName($request['new_name']));
            $builder->set('updated_date', new Time('now'));
            $builder->set('updated_by', $request['updated_by']);
            $builder->set('row_version', time());
            $builder->where('id', $request['id']);
            $builder->update();
                        
            $response['remark']        = sprintf('Folder successfully renamed to %s', ucwords(trim($request['new_name'])));
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            return $response;
        }
    }
    
    /**
     * Method searches for a particular folder
     * @param array $request
     * @param bool $include_date
     * @return array
     */
    public function searchForFolder(array $request, bool $include_date = false): array
    {
        try {
            $db = db_connect();
            
            $builder = $db->table('vw_folder');
            $builder->select('id, name, comment, created_date, created_by, folder_owner, folder_status');
            
            if ($include_date) {
                $builder->where('created_date >=', $request['start_date']);
                $builder->where('created_date <=', $request['end_date']);
            }
            else {
                $builder->like('name', trim($request['search_keyword']));
                $builder->like('comment', trim($request['search_keyword']));
            }
            
            $query = $builder->get();
            
            $response['returned_rows'] = $builder->countAllResults();
            $response['result_set']    = $query;
            $response['status']        = true;
            $response['remark']        = '';
            
            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request';
            $response['returned_rows'] = 0;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }

    /**
     * Method gets all the available states for a folder
     * @param void
     * @return array
     */

    public  function getFolderStates(): array
    {
        try {
            $db = db_connect();

            $builder = $db->table('folder_state');
            $builder->select('row_id, description');
            $builder->orderBy('description', 'ASC');

            $result = $builder->get();

            $result_set = null;

            foreach ($result->getResult() as $row) {
                $result_set[] = [
                    'row_id'      => $row->row_id,
                    'description' => $row->description,
                ];
            }

            $response['result_set']    = $result_set;
            $response['remark']        = '';
            $response['returned_rows'] = count($result_set);
            $response['exception_msg'] = '';

            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());

            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request';
            $response['returned_rows'] = 0;
            $response['exception_msg'] = $ex->getMessage();

            return $response;
        }
    }

    /**
     * Method gets list of people who can own folders in the system
     * @param bool $json_friendly
     * @return array
     */
    public function getAvailableOwners(bool $json_friendly = false): array
    {
        try {

            $db = db_connect();

            $builder = $db->table('user');
            $builder->select('id, first_name, last_name, email_address');
            $builder->where('state >', '0');
            $builder->orderBy('first_name', 'ASC');
            $builder->orderBy('last_name', 'ASC');

            $result = $builder->get();

            $result_set = null;

            if ($json_friendly) {
                foreach ($result->getResult() as $row) {
                    $result_set[] = [
                        'id'            => $row->id,
                        'first_name'    => $row->first_name,
                        'last_name'     => $row->last_name,
                        'email_address' => $row->email_address,
                    ];
                }

                $response['result_set'] = $result_set;
            } else {
                $response['result_set'] = $result;
            }

            $response['remark']        = '';
            $response['returned_rows'] = $builder->countAllResults();
            $response['exception_msg'] = '';

            return $response;

        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());

            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request';
            $response['returned_rows'] = 0;
            $response['exception_msg'] = $ex->getMessage();

            return $response;
        }
    }
    
    /**
     * Method creates a folder
     * @param array $request
     * @return array
     */
    public function createFolder(array $request): array
    {
        try {
            
            $row = $this->validateFolderExistence($request['folder_name']);
            
            if (isset($row)) {
                $response['remark']        = sprintf('Unable to create the folder: %s. It already exists', $request['folder_name']);
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            $lib = new StringHelper();
            
            $db = db_connect();

            $db->transBegin();
            
            $builder = $db->table('folder');
            
            $data = [
                       'name'         => $lib->formatName($request['folder_name']),
                       'comment'      => $lib->formatName($request['folder_comment']),
                       'created_date' => new Time('now'),
                       'created_by'   => $request['created_by'],
                       'owner'        => $request['owner'],
                       'state'        => $request['state'],
                       'row_version'  => time()
                    ];
            
            $builder->insert($data);

            $row = $builder->where('name', $lib->formatName($request['folder_name']))->orderBy('id', 'DESC')->get()->getRow();

            if (!isset($row)) {
                $response['remark'] = 'Something went wrong while processing your request';
                $response['status'] = false;
                $db->transRollback();
                return $response;
            }

            // also grant this user permissions to this folder automatically
            $data = [
                'row_id'       => $lib->generateGuid(),
                'folder_id'    => $row->id,
                'user_id'      => $_SESSION['user_id'],
                'created_date' => new Time('now'),
                'privilege'    => PrivilegeOptions::WRITE,
                'row_version'  => time()
            ];
            
            $db->table('folder_access_level')->insert($data);  

            // if an owner was specified, also grant them full access as well
            if (!empty($request['owner']) && $request['owner'] != $_SESSION['user_id']) {
                $data = [
                    'row_id'       => $lib->generateGuid(),
                    'folder_id'    => $row->id,
                    'user_id'      => $request['owner'],
                    'created_date' => new Time('now'),
                    'privilege'    => PrivilegeOptions::WRITE,
                    'row_version'  => time()
                ];
                $db->table('folder_access_level')->insert($data);  
            }

            $db->transCommit();
            
            $response['remark']        = sprintf('Folder: %s successfully created', ucwords(trim($request['folder_name'])));
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            return $response;
        }
    }
}