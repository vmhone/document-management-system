<?php namespace App\Models;

use CodeIgniter\Model;
use Exception;

/**
 * A class that manages folder hierachy in the system
 */
class FolderHierarchy extends Model{

    /**
     * Method to create a folder hierachy
     */
    public function createHierarchy($request){
        $response = [];
        try {
            //code...
            if(isset($request)){
                $db = db_connect();
                $builder = $db->table('folder_hierarchy');
                $request['created_date'] = time();
                $request['updated_date'] = time();
                $builder->insert($request);

                $response['remark'] = 'Resource created successfully';
                $response['status'] = true;
            }
            else{
                $response['remark'] = 'Please choose a folder to be moved';
                $response['status'] = false;
            }
        } catch (Exception $ex) {
            //throw $th;
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;
        }
        return $response;
    }

    /**
     * Method to update a folder hierachy
     */
    public function updateHierarchy($request){
        $response = [];
        try{
            if(isset($request)){
                $db = db_connect();
                $builder = $db->table('folder_hierarchy');
                $builder->where('folder_id', $request['folder_id']);
                $builder->update([
                    'parent' => $request['parent'],
                    'updated_date' => time()
                ]);

                $response['remark'] = 'Resource updated successfully';
                $response['status'] = true;
            }
            else{
                throw new Exception("Request cannot be null");
            }
        }
        catch(Exception $ex){
            log_message('error', $ex->getMessage());
            $response['remark'] = 'An error occured while processing your request';
            $response['status'] = false;
        }
        return $response;
    }

    /**
     * Method to delete a folder hierarchy record
     */
    public function deleteHierarchy($request){
        $response = [];
        try{
            if(isset($request)){
                $db = db_connect();
                $builder = $db->table('folder_hierarchy');
                $builder->where('folder_id', $request['folder_id']);
                $builder->delete();

                $response['remark'] = 'Resource removed successfully';
                $response['status'] = true;
            }
            else{
                throw new Exception("Request does not have data to be manipulated");
            }
        }
        catch(Exception $ex){
            log_message('error', $ex->getMessage());
            $response['remark'] = 'An error occured while processing your request';
            $response['status'] = false;
        }
        return $response;
    }

    /**
     * Method to fetch folder structure from the system
     */
    public function getHierarchy($id = null){
        $response = [];
        try{
            $db = db_connect();
            $builder = $db->table('folder_hierarchy');
            $builder->select('folder_hierarchy.folder_id,folder_hierarchy.parent,folder_hierarchy.created_date,folder_hierarchy.updated_date, folder.name');
            $builder->join('folder', 'folder.id=folder_hierarchy.folder_id');
            if(isset($id)){
                $builder->where('parent', $id);
            }

            $query = $builder->get();
            $response['returned_rows'] = $builder->countAllResults();
            $response['result_set']    = $query;
            $response['status']        = true;
            $response['remark']        = '';

        }
        catch(Exception $ex){
            log_message('error', $ex->getMessage());
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['remark']        = "An error occured while processing your request";
        }
        return $response;
    }
}