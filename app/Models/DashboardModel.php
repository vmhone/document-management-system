<?php namespace App\Models;
use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use Exception;
use CustomHelper\Common\StringHelper;
use UserRole;
use CodeIgniter\Database\BaseBuilder;

require_once APPPATH . '/Models/UserRole.php';
require_once APPPATH . '/Models/PrivilegeOptions.php';

class DashboardModel extends Model {

    /**
     * Method gets dashboard statistics
     * @return array
     */
    public function getDashboardStatistics() {

        $result_set = null;

        $result_set['active_sessions'] = $this->countActiveSessions();
        $result_set['total_docs']      = $this->countTotalDocuments();
        $result_set['total_groups']    = $this->countTotalGroups();
        $result_set['total_folders']   = $this->countTotalFolders();

        return $result_set;
    }

    /**
     * Method counts active users in the system
     * @return string
     */
    private function countActiveSessions() {
        try {
            $lib = new StringHelper();
            $session_model = new SessionModel();
            return $lib->convertToThousandsFormat($session_model->countActiveSessions());
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return '0';
        }
    }

    /**
     * Method counts total documents in the system
     * @return string
     */
    private function countTotalDocuments() {
        try {
            $db = db_connect();

            $builder = $db->table('document');
            $builder->selectCount('*', 'total_count');
            $builder->where('is_archived', 0);
            
            $query = $builder->get();
            
            $lib = new StringHelper();
            return $lib->convertToThousandsFormat($query->getRow()->total_count);
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return '0';
        }
    }

    /**
     * Method counts total groups in the system
     * @return string
     */
    private function countTotalGroups() {
        try {
            $db = db_connect();

            $builder = $db->table('group');
            $builder->selectCount('*', 'total_count');
            $builder->where('state', 1);

            $query = $builder->get();
            
            $lib = new StringHelper();
            return $lib->convertToThousandsFormat($query->getRow()->total_count);
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return '0';
        }
    }

    /**
     * Method counts total folders in the system
     * @return string
     */
    private function countTotalFolders() {
        try {
            $db = db_connect();

            $builder = $db->table('folder');
            $builder->selectCount('*', 'total_count');
            $builder->where('state >', 0);

            $query = $builder->get();
            
            $lib = new StringHelper();
            return $lib->convertToThousandsFormat($query->getRow()->total_count);
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return '0';
        }
    }

    /**
     * Method gets the largest folders in the system
     * @return array|null
     */
    public function getLargestFolders() {
        $result_set = null;

        try {
            $db = db_connect();

            $builder = $db->table('vw_folder_stat');
            $builder->select('name, file_count');
            $builder->orderBy('file_count', 'DESC');
            $builder->limit(3);

            $result = $builder->get();
            
            if (isset($result)) {
                foreach ($result->getResult() as $row) {                    
                    $result_set[] = array(
                        'folder_name'   => $row->name,
                        'file_count'    => (int) $row->file_count,
                    );   
                }
                return $result_set;
            } else {
                return null;
            }

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return null;
        }
    }

    /**
     * Method gets the newest files uploaded to the system
     * @return array|null
     */
    public function getLatestFiles() {
        
        $result_set = [];

        try {
            $db = db_connect();

            session_start();

            $builder = $db->table('document');
            $builder->select('document.id, file_name, user.first_name, user.last_name, date_uploaded');
            $builder->join('user', 'document.uploaded_by = user.id'); 
            if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) {
                $builder->whereIn('document.id', function(BaseBuilder $builder) {
                    return $builder->select('document_id', false)->from('document_access_level')->where('user_id', $_SESSION['user_id']);
                });
            }
            $builder->orderBy('date_uploaded', 'DESC');
            $builder->limit('3');

            $result = $builder->get();

            foreach ($result->getResult() as $row) {
                $current_time   = Time::now();
                $humanised_time = $current_time->difference($row->date_uploaded);
                $result_set[] = array(
                    'file_name'     => strlen($row->file_name) > 12 ? substr($row->file_name, 0, 10) . '...' : $row->file_name,
                    'first_name'    => $row->first_name,
                    'last_name'     => $row->last_name,
                    'date_uploaded' => $humanised_time->humanize(),
                );
            }

            if (sizeof($result_set) <= 0) {
                return [];
            }
            return $result_set;
        } catch (Exception $ex) { 
            log_message('error', $ex->getMessage());
            return $result_set;
        }
    }

    /**
     * Method gets the latest folders on the system
     * @return array|null
     */
    public function getLatestFolders() {

        $result_set = [];

        try {
            session_start();

            $db = db_connect();

            $builder = $db->table('folder');
            $builder->select('folder.id, folder.name, folder.created_date, user.first_name, user.last_name');
            $builder->join('user', 'folder.created_by = user.id');
            $builder->where('folder.state', 1);

            if ($_SESSION['role_id'] != UserRole::ADMINISTRATOR) {
                $builder->whereIn('folder.id', function(BaseBuilder $builder) {
                    return $builder->select('folder_id', false)->from('folder_access_level')->where('user_id', $_SESSION['user_id']);
                });
            }

            $builder->orderBy('folder.created_date', 'DESC');
            $builder->limit('3');

            $result = $builder->get();
            
            foreach ($result->getResult() as $row) {
                $current_time   = Time::now();
                $humanised_time = $current_time->difference($row->created_date);
                $result_set[] = array(
                    'folder_name'   => strlen($row->name) > 12 ? substr($row->name, 0, 10) . '...' : $row->name,
                    'created_date'  => $humanised_time->humanize(),
                    'first_name'    => $row->first_name,
                    'last_name'     => $row->last_name
                );
            }

            if (sizeof($result_set) <= 0) {
                return [];
            }
            
            return $result_set;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return $result_set;
        }
    }
}