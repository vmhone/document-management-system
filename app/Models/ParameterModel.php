<?php namespace App\Models;
use CodeIgniter\Model;
use CustomHelper\Common\StringHelper;
use Exception;

class ParameterModel extends Model{
    /**
     * Method fetches a parameter from the configuration table
     * @param array
     * @return object
     * @throws Exception
     */
    public function getParameter($param) {
        try {
            $db = db_connect();
            $builder = $db->table('config');
            $builder->select('parameter_value');
            $builder->where('parameter_name', $param);
            return $builder->get()->getRow();
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new Exception($ex->getMessage());
        }
    }
    
    /**
     * Method fetches all parameters
     * @return array
     * @throws Exception
     */

    public function getAllParameters() {
        $result_set = [];
        try {
            $db = db_connect();
            $builder = $db->table('config');
            $builder->select('parameter_name, parameter_value');
            $builder->orderBy('parameter_name', 'ASC');
            
            $result = $builder->get();

            foreach ($result->getResult() as $row) {
                $result_set[] = array($row->parameter_name => $row->parameter_value);
            }

            $lib = new StringHelper();
            return $lib->flattenArray($result_set);
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return $result_set;
        }
    }

    /**
     * Method updates an existing parameter
     * @param array
     * @return array
     */
    public function updateParameter($param) {
        try {
            $response = [];
            if (sizeof($param) > 0) {   

                $db = db_connect();
                $db->transStart();
                
                $builder = $db->table('config');

                foreach($param as $parameter_name=>$parameter_value) {
                    $builder->set('parameter_value', trim($parameter_value));
                    $builder->where('parameter_name', trim($parameter_name));
                    $builder->update();
                }

                $db->transCommit();

                $response['remark'] = 'Settings successfully saved';
                $response['status'] = true;
            } else {        
                $response['remark'] = 'Unable to save settings. Try again later';
                $response['status'] = false;
            }

            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request : ' . $ex->getMessage();
            $response['status'] = false;
            return $response;
        }
    }

    /**
     * Method creates a parameter
     * @param array
     * @return bool
     */
    public function createParameter($param) {
        try {
            $db = db_connect();
            $builder = $db->table('config');

            $data = [
                'parameter_name'  => $param['parameter_name'],
                'parameter_value' => $param['parameter_value']
            ];

            $builder->insert($data);
            return true;
        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }
}