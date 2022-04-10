<?php namespace App\Models;

use CodeIgniter\Model;
use Exception;
use function db_connect;
use CodeIgniter\I18n\Time;

class SessionModel extends Model
{
    /**
     * Method creates a new session
     * @param array
     * @return bool
     */
    public function createSession($param): bool
    {
        try {
            $db = db_connect();

            $builder = $db->table('session');
            
            $data = [
                       'id'           => $param['session_id'],
                       'ip_address'   => $param['ip_address'],
                       'user_agent'   => $param['user_agent'],
                       'last_seen'    => $param['last_seen'],
                       'date_created' => new Time('now'),
                       'user_id'      => $param['user_id']
                    ];
            
            $builder->insert($data);            

            return true;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method deletes inactive sessions
     * @return bool
     */
    public function deleteInactiveSessions(): bool
    {
        try {            
            $db = db_connect();
            
            $builder = $db->table('vw_session');
            $builder->where('time_diff >=', $_SESSION['session_life']);
            $builder->delete();

            return true;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method ends a session
     * @param string
     * @return bool
     */
    public function endSession($id): bool
    {
        try {
            $db = db_connect();

            $builder = $db->table('vw_session');
            $builder->where('id', $id);
            $builder->delete();

            return true;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method counts active sessions
     * @return int
     */
    public function countActiveSessions() {
        try {
            $db = db_connect();

            $builder = $db->table('vw_session');
            $builder->selectCount('*', 'total_count');
            $builder->where('time_diff <=', $_SESSION['session_life']);

            $query = $builder->get();
            return $query->getRow()->total_count;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return '0';
        }
    }

    /**
     * Method updates a session
     * @param array
     * @return void
     */
    private function updateSession($param): void
    {
        try {  
            $db = db_connect();

            $builder = $db->table('session');
            $builder->set('last_seen', $param['last_seen']);
            $builder->where('id', $param['session_id']);
            $builder->update();

            return;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return;
        }
    }

    /**
     * Method checks if a session is valid
     * @param array
     * @return bool
     */
    public function isSessionValid($param): bool
    {
        try {
            $db = db_connect();

            $builder = $db->table('vw_session');
            $builder->select('id, ip_address, user_agent, last_seen, user_id, time_diff');
            $builder->where('id', $param['id']);

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                return false;
            } else {
                // check for a possible session hijack
                if ($param['ip_address'] != $row->ip_address) {
                    return false;
                } else if ($param['user_agent'] != $row->user_agent) {
                    return false;
                } else if ($param['user_id'] != $row->user_id) {
                    return false;
                } else {
                    if ($row->time_diff >= $_SESSION['session_life']) {
                        return false;
                    } else {
                        $request['session_id'] = $row->id;
                        $request['last_seen']  = time();
                        $this->updateSession($request);
                        return true;
                    }
                }
            }
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }
}