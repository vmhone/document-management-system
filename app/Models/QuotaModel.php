<?php namespace App\Models;
use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use Exception;

class QuotaModel extends Model{

    /**
     * Method updates the available quota for a user
     * @param int
     * @param int
     * @return bool
     */
    public function updateUserQuota($id, $quota): bool
    {
        try {
            $db = db_connect();

            $builder = $db->table('user');
            $builder->set('quota', $quota * 1024 * 1024);
            $builder->set('updated_date', new Time('now'));
            $builder->where('id', $id);
            $builder->update();    

            return true;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }

    /**
     * Method gets the quota for a particular user
     * @param int
     * @return int
     * @throws Exception
     */
    public function getUserQuota($id): int
    {
        try {
            $db = db_connect();

            $builder = $db->table('user');
            $builder->select('quota');
            $builder->where('id', $id);

            $row = $builder->get()->getRow();

            return $row->quota;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new Exception($ex->getMessage());
        }
    }

     /**
     * Method calculates the used quota for a particular user
     * @param int
     * @param int
     * @return array
     */
    public function computeUsedQuota($id): array
    {
        try {
            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('COALESCE(SUM(file_size), 0) AS total_used');
            $builder->where('uploaded_by', $id);

            $row = $builder->get()->getRow();

            $response['status'] = true;
            $response['quota']  = $row->total_used;

            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());

            $response['status'] = false;
            $response['quota']  = 0;

            return $response;
        }
    }
}