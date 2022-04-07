<?php namespace App\Models;

use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use CustomHelper\Common\StringHelper;
use Exception;

class GroupModel extends Model
{
    /**
     * Method checks if a group exists
     * @param string
     * @return boolean
     * @throws Exception
     */
    public  function doesGroupExist($group_name) {
        try {
            $db = db_connect();
            
            $lib = new StringHelper();
            
            $builder = $db->table('group');
            $builder->selectCount('*', 'total_count');
            $builder->where('group.name', $lib->formatName($group_name, true));
            $row = $builder->get()->getRow();

            return $row->total_count > 0 ? true : false;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Method gets the list of available groups
     * @param int $group_id
     * @return string
     */
    public function getAvailableGroups($group_id = 0) {
        try {
            $db = db_connect();
            
            $builder = $db->table('group');
            $builder->select('group.id, group.name AS group_name, group.created_date, group.state, user.email_address');
            $builder->select('user.first_name, user.last_name, group.comment');
            $builder->join('user', 'user.id = group.created_by', 'left');

            if ($group_id > 0) {
                $builder->where('group.id', $group_id);
            }

            $builder->orderBy('group.name', 'ASC');

            $result = $builder->get();

            $result_set = [];

            foreach ($result->getResult() as $row) {

                $current_time   = Time::now();
                $humanized_time = $current_time->difference($row->created_date);

                $result_set[] = [
                    'id'               => $row->id,
                    'group_name'       => strtoupper($row->group_name),
                    'group_comment'    => $row->comment,
                    'created_date'     => $row->created_date,
                    'group_state'      => $row->state == 0 ? 'Inactive' : 'Active',
                    'group_state_flag' => $row->state,
                    'humanized_time'   => $humanized_time->humanize(),
                    'email_address'    => $row->email_address,
                    'first_name'       => $row->first_name,
                    'last_name'        => $row->last_name
                ];
            }
            
            $response['returned_rows'] = $builder->countAllResults();
            $response['result_set']    = $result_set;
            $response['status']        = true;
            $response['remark']        = '';
            
            return $response;
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            
            $response['returned_rows'] = 0;
            $response['result_set']    = null;
            $response['status']        = false;
            $response['remark']        = $e->getMessage();
            return $response;
        }
    }
    
    /**
     * Method creates a group
     * @param string
     * @return array
     */
    public function createGroup($request) {
        try {
            // does the group exist?
            if ($this->doesGroupExist($request['group_name'])) {
                $response['remark'] = sprintf('Unable to create the group: %s. It already exists', $request['group_name']);
                $response['status'] = false;
                return $response;
            }

            $lib = new StringHelper();

            $data = [
                'name'          => $lib->formatName($request['group_name'], true),
                'comment'       => ucwords(trim($request['group_comment'])),
                'created_date'  => new Time('now'),
                'created_by'    => $request['created_by'],
            ];
            
            $db = db_connect();
            $db->table('group')->insert($data);
    
            $response['remark'] = sprintf('Group: %s successfully created', $request['group_name']);
            $response['status'] = true;
            
            return $response;
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;
            
            return $response;
        }
    }
    
    /**
     * Method modifies a group
     * @param array
     * @return array
     */
    public function modifyGroup($request) {
        try {
            $lib = new StringHelper();

            $db = db_connect();
            
            // check if the group name may already exist
            $builder = $db->table('group');
            $builder->select('id, name');
            $builder->where('name', $lib->formatName($request['group_name']));
            $row = $builder->get()->getRow();

            if (isset($row)) {
                if (strcasecmp($row->name, $lib->formatName($request['group_name']) == 0)) {
                    if ($row->id !== $request['id']) {
                        $response['remark'] = sprintf('Unable to rename the group. The name: %s already exists', $request['group_name']);
                        $response['status'] = false;
                        return $response;
                    }
                }
            }
            
            $builder = $db->table('group');
            
            $builder->set('state', $request['state']);
            $builder->set('updated_by', $request['updated_by']);
            $builder->set('name', $lib->formatName($request['group_name'], true));
            $builder->set('comment', trim(ucwords($request['comment'])));
            $builder->set('updated_date', new Time('now'));
            $builder->where('id', $request['id']);
            $builder->update();
    
            $response['remark'] = 'Group successfully modified';
            $response['status'] = true;
            
            return $response;
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            
            $response['exception_msg'] = $e->getMessage();
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            
            return $response;
        }
    }
}