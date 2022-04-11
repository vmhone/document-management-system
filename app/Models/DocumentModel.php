<?php namespace App\Models;

use CodeIgniter\Model;
use CodeIgniter\I18n\Time;
use CustomHelper\Common\StringHelper;
use Exception;
use PrivilegeOptions;
use UserRole;
use Extension;

use function db_connect;

require_once APPPATH . '/Libraries/StringHelper.php';
require_once APPPATH . '/Models/UserRole.php';
require_once APPPATH . '/Models/PrivilegeOptions.php';
require_once APPPATH . '/Models/Extension.php';

class DocumentModel extends Model
{
    /**
     * Method gets the owner of a document
     * @param $id
     * @return mixed
     * @throws Exception
     */
    public function getDocumentOwner($id) {
        try {
            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('uploaded_by, owner');
            $builder->where('id', $id);

            $row = $builder->get()->getRow();
            
            if ($row->owner != null) {
                return $row->owner;
            } 

            return $row->uploaded_by;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            throw new Exception($ex->getMessage());
        }
    }

    /**
     * Method submits a request to send documents via email
     * @param int ID of the document,
     * @param array List of recipients,
     * @param bool Whether to include the sender or not
     * @return array
     */
    public function sendDocumentViaEmail($id, $recipients, $include_sender): array
    {
        try {
            
            $mailing_list = [];

            if ($include_sender) {
                $mailing_list[] = $_SESSION['username'];
            }

            // add the existing recipients as well
            foreach ($recipients as $recipient) {
                if (!in_array($recipient, $mailing_list)) {
                    $mailing_list[] = trim($recipient);
                }
            }

            if (sizeof($mailing_list) <= 0) {
                $response['remark'] = 'Please ensure you have specified one or more recipients to send the document to';
                $response['status'] = false;
                return $response;
            }

            // get the document details for sending
            $db = db_connect();

            // get the template from the database
            $template = $db->table('email_template');
            $template->select('parameter_value');
            $template->where('parameter_name', 'document_received');

            $row_template = $template->get()->getRow();

            if (!isset($row_template)) {
                $response['remark'] = 'Unable to send the email. Contact support if the issue persists';
                $response['status'] = false;
                return $response;
            }

            $builder = $db->table('document');
            $builder->select('abs_file_path, generated_file_name, extension, file_name');
            $builder->where('id', $id);

            $row = $builder->get()->getRow();

            $email_template = $row_template->parameter_value;
            $user_detail = sprintf('%s %s (%s)', $_SESSION['first_name'], $_SESSION['last_name'], $_SESSION['username']);

            // the file has an extension so append it
            if ($row->extension != null) {
                $transform = array("{document}" => sprintf('%s.%s', $row->file_name, $row->extension), "{user}" => $user_detail);
            } else {
                $transform = array("{document}" => $row->file_name, "{user}" => $user_detail);
            }

            $email_msg = strtr($email_template, $transform);

            $request['email_message'] = $email_msg;
            $request['subject']       = 'Document Received';

            if ($row->extension != null) {
                $request['attachment'] = sprintf('%s%s.%s', $row->abs_file_path, $row->generated_file_name, $row->extension);
            } else {
                $request['attachment'] = sprintf('%s%s', $row->abs_file_path, $row->generated_file_name);
            }

            if ($row->extension != null) { 
                $request['friendly_name'] = sprintf('%s.%s', $row->file_name, $row->extension);
            } else {
                $request['friendly_name'] = $row->file_name;
            }

            $logging_model = new LoggingModel();

            // email each recipient
            foreach ($mailing_list as $recipient) {
                $request['recipient']   = $recipient;
                $request['submit_date'] = new Time('now');
                $logging_model->logOutgoingEmail($request);
            }

            $response['remark'] = sizeof($mailing_list) <= 1 ? 'Document sent via email to recipient' : 'Document sent via email to recipients';
            $response['status'] = true;
            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['remark'] = 'Something went wrong while processing your request';
            $response['status'] = false;
            return $response;
        }
    }

    /**
     * Method gets related IDs for a filename
     * @param string
     * @param int
     * @return array
     */
    public function getIdsFromFileName($file_name, $folder): array
    {
        $documents = [];

        try {
            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('id');
            $builder->where('file_name', trim($file_name));
            $builder->where('folder', $folder);

            $result = $builder->get();

            foreach ($result->getResult() as $row) { 
                $documents[] = $row->id;
            }

            return $documents;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return $documents;
        }
    }

    /**
     * Method checks if a document exists already
     * @param string
     * @param int $version
     * @param int $folder
     * @return boolean
     * @throws Exception
     */
    public function doesDocumentExist($file_name, int $version = 1, int $folder = 0): bool
    {
        try {
            $db = db_connect();
            $builder = $db->table('document');

            $lib = new StringHelper();

            $builder->selectCount('id', 'total_count');
            $builder->where('file_name', $lib->formatName($file_name));

            if ($folder > 0) {
                $builder->where('folder', $folder);
            }

            if ($version > 0) {
                $builder->where('version', $version);
            }

            $query = $builder->get();

            return $query->getRow()->total_count > 0;
            
        } catch(Exception $e) {
            log_message('error', $e->getMessage());
            throw new Exception($e->getMessage());
        }
    }

    /**
     * Method counts all the documents in the system/folder
     * @param int $folder
     * @return int
     */
    public function countAllDocuments(int $folder = 0): int
    {
        try {
            $db = db_connect();
            $builder = $db->table('document');

            if ($folder > 0) {
                $builder->where('folder', $folder);
            }

            $builder->selectCount('id', 'total_count');
            $query = $builder->get();

            return $query->getRow()->total_count;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return 0;
        }
    }

    /**
     * Method gets a version history for a document in a folder
     * @param int $id
     * @return array
     */
    public function getDocumentVersionHistory(int $id): array
    {
        try {
            $db = db_connect();

            $file = $db->table('document');
            $file->select('file_name, folder');
            $file->where('id', $id);

            $row = $file->get()->getRow();

            $builder = $db->table('vw_document_history');

            $builder->select('id, file_name, version, file_size, extension, mime_type, date_uploaded, uploaded_by');
            $builder->select('first_name, last_name, description, folder_name');
            $builder->where('file_name', trim($row->file_name));
            $builder->where('folder_id', $row->folder);
            $builder->orderBy('version', 'ASC');

            $result = $builder->get();

            $result_set = null;

            helper('number');

            foreach ($result->getResult() as $row) {

                $current_time = Time::now();
                $humanized_time = $current_time->difference($row->date_uploaded);

                $result_set[] = [
                    'id'             => $row->id,
                    'file_name'      => $row->file_name,
                    'version'        => $row->version,
                    'file_size'      => number_to_size($row->file_size, 2),
                    'extension'      => $row->extension,
                    'mime_type'      => $row->mime_type,
                    'date_uploaded'  => $row->date_uploaded,
                    'uploaded_by'    => $row->uploaded_by,
                    'first_name'     => $row->first_name,
                    'last_name'      => $row->last_name,
                    'description'    => $row->description,
                    'folder_name'    => $row->folder_name,
                    'humanized_time' => $humanized_time->humanize(),
                ];
            }

            $response['returned_rows']  = count($result_set);
            $response['result_set']     = $result_set;
            $response['status']         = true;
            $response['exception_msg']  = '';

            return $response;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());

            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            $response['result_set']    = null;

            return $response;
        }
    }

    /**
     * Method moves a document from one folder to another
     * @param int $document_id
     * @param int $source_folder
     * @param int $destination_folder
     * @param int $user_id
     * @return array
     */
    
    public function transferDocument(int $document_id, int $source_folder, int $destination_folder, int $user_id): array
    {
        try {
            if ($source_folder == $destination_folder) {
                $response['remark']        = 'Unable to transfer the document. The source and destination folder are the same';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            if ($destination_folder <= 0) {
                $response['remark']        = 'The destination folder specified does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            $privilege_model = new PrivilegeModel();
            $param['document_id'] = $document_id;
            $param['user_id']     = $_SESSION['user_id'];

            $response = $privilege_model->getPrivilegeForDocument($param);

            if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                $response['privilege'] = PrivilegeOptions::WRITE;
            }

            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['status'] = false;
                $response['remark'] = 'Unable to transfer the document. You do not have the necessary permissions';
                return $response;
            }

            // also check if the user has access to the destination folder (WRITE)
            $param['folder_id'] = $destination_folder;
            $param['user_id']   = $_SESSION['user_id'];
            $response = $privilege_model->getPrivilegeForFolder($param);

            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['status'] = false;
                $response['remark'] = 'Unable to transfer the document. You do not have write permissions on the destination folder';
                return $response;
            }

            $db = db_connect();                 
            
            $builder = $db->table('document');
            $query = $builder->select('file_name, version')->where('id', $document_id)->get();
            $row = $query->getRow();
            
            if (!isset($row)) {
                $response['remark']        = 'Unable to transfer the document. It does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }
            
            $duplicate_check = $this->doesDocumentExistInFolder($row->file_name, $destination_folder);
            
            if ($duplicate_check['status']) {
                $response['remark']        = $duplicate_check['remark'];
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            $db->transBegin();

            $current_timestamp = time();

            // move the current version of the document
            $builder->set('folder', $destination_folder);
            $builder->set('row_version', $current_timestamp);
            $builder->where('id', $document_id);
            $builder->update();

            // also move the history versions to the new folder
            $history = $db->table('document');
            $history->select('folder, file_name, row_version');
            $history->where('id', $document_id);

            $file = $history->get()->getRow();

            // update the old versions as well
            $document = $db->table('document');
            $document->set('folder', $file->folder);
            $document->set('row_version', $file->row_version);
            $document->where('file_name', $file->file_name);
            $document->where('folder', $source_folder);
            $document->update();

            // also log transfer for audit purposes
            $audit = $db->table('document');
            $audit->select('id, folder');
            $audit->where('file_name', $file->file_name);
            $audit->where('folder', $destination_folder);

            $result = $audit->get();

            $current_time = new Time('now');

            foreach ($result->getResult() as $row) {
                $data = [
                    'document'      => $row->id,
                    'source_folder' => $source_folder,
                    'dest_folder'   => $destination_folder,
                    'transfer_time' => $current_time,
                    'transfer_user' => $user_id,
                    'row_version'   => $current_timestamp,
                ];
                $transfer_log = $db->table('document_transfer');
                $transfer_log->insert($data);
            }

            $db->transCommit();

            $response['remark']        = sprintf('Document: %s successfully transferred', $file->file_name);
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

    /** Method renames a document within a folder
     * @param int $doc_id
     * @param int $folder_id
     * @param string $new_name
     * @param string $current_file_name
     * @return array
     */
    public function renameDocument(int $doc_id, int $folder_id, string $new_name, string $current_file_name): array
    {
        try {

            $privilege_model = new PrivilegeModel();
            $param['document_id'] = $doc_id;
            $param['user_id']     = $_SESSION['user_id'];

            $response = $privilege_model->getPrivilegeForDocument($param);

            if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                $response['privilege'] = PrivilegeOptions::WRITE;
            }
 
            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['status'] = false;
                $response['remark'] = 'Unable to rename the document. You do not have the necessary permissions';
                return $response;
            }

            // get the details about this document
            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('file_name');
            $builder->where('id', $doc_id);
            $builder->where('folder', $folder_id);

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['remark']        = 'The document specified does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            if (strcasecmp(trim($new_name), $row->file_name) == 0) {
                $response['remark']        = 'Unable to rename the document. The old and the new file names are the same';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            $file_check = $db->table('document');
            $file_check->selectCount('*', 'total_count');
            $file_check->where('file_name', trim($new_name));
            $file_check->where('folder', $folder_id);

            $duplicate_count = $file_check->get()->getRow()->total_count;

            if ($duplicate_count > 0) {
                $response['remark']        = sprintf('Unable to rename the document. Another file exists with the name: %s', trim($new_name));
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }

            $db->transBegin();

            $current_timestamp = time();

            $lib = new StringHelper();

            // go ahead and rename the document then
            $file = $db->table('document');
            $file->set('file_name', $lib->formatName($new_name, false));
            $file->set('row_version', $current_timestamp);
            $file->where('id', $doc_id);
            $file->where('folder', $folder_id);
            $file->update();

            // also update the earlier versions of the file as well to maintain consistency
            $version = $db->table('document');
            $version->set('file_name', $lib->formatName($new_name, false));
            $version->set('row_version', $current_timestamp);
            $version->where('folder', $folder_id);
            $version->where('file_name', $current_file_name);
            $version->update();

            $db->transCommit();

            $response['remark']        = sprintf('Document successfully renamed to: %s', $lib->formatName($new_name));
            $response['status']        = true;
            $response['exception_msg'] = null;

            return $response;

        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());

            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            return $response;
        }
    }

    /**
     * Method checks if a document exists in a folder
     * @param string $file_name
     * @param int $folder
     * @return array
     */
    protected function doesDocumentExistInFolder(string $file_name, int $folder): array
    {
        try {
            if ($folder <= 0) {
                $response['remark']        = 'The folder specified does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                return $response;
            }
            
            $db = db_connect();    

            $lib = new StringHelper();

            $builder = $db->table('document');
            $builder->select('document.id');
            $builder->where('file_name', $lib->formatName($file_name));
            $builder->where('folder', $folder);
            
            $query = $builder->get();
            $row = $query->getRow();
            
            if (isset($row)) {
                $response['remark']        = 'Unable to transfer the document. A document with a similar name ';
                $response['remark']       .= 'already exists in the folder';
                $response['status']        = true;
                $response['exception_msg'] = null;
            } else {
                $response['remark']        = '';
                $response['status']        = false;
                $response['exception_msg'] = false;
            }
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
     * Method searches for a document
     * @param array $request
     * @param bool $include_date
     * @return array
     */
    public function searchDocument(array $request, bool $include_date = false): array
    {
        try {
            $db = db_connect();
            
            $builder = $db->table('document');
            $builder->select('document.id AS document_id, document.file_name, document_state.description');
            $builder->select('document.generated_file_name, document.file_size, document.original_file_name, folder.id as folder_id');
            $builder->select('document.version, document.extension, document.mime_type, date_uploaded, folder.name AS folder_name');
            $builder->join('document_keyword','document_keyword.document_id = document.id', 'left');
            $builder->join('folder', 'document.folder = folder.id', 'left');
            $builder->join('document_state', 'document.state = document_state.id', 'left');

            if (strlen($request['search_keyword']) > 0) {
                $builder->like('keyword', strtoupper(trim($request['search_keyword'])));
                $builder->orLike('file_name', trim($request['search_keyword']));
                $builder->orLike('document.comment', trim($request['search_keyword']));
            }
            if ($include_date) {
                $builder->where('date_uploaded >=', $request['start_date']);
                $builder->where('date_uploaded <=', $request['end_date']);
            }

            // only get non archived documents that are in active state
            $builder->where('document.is_archived', 0);
                        
            // are we searching in a folder?
            if (isset($request['folder']) && $request['folder'] > 0) {
                $builder->where('document.folder', $request['folder']);
            }

            // are we searching documents uploaded by a particular person?
            if (isset($request['user_id']) && $request['user_id'] > 0) {
                $builder->where('document.uploaded_by', $request['user_id']);
            }

            $builder->orderBy('document.date_uploaded', 'DESC');

            $builder->distinct();

            $result = $builder->get();

            $result_set = [];

            helper('number');

            foreach ($result->getResult() as $row) {
                $privilege_model = new PrivilegeModel();
                $request['document_id'] = $row->document_id;
                $request['user_id']     = $_SESSION['user_id'];

                // do we have access to this document?
                $doc_response = $privilege_model->getPrivilegeForDocument($request);

                if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                    $doc_response['privilege'] = PrivilegeOptions::WRITE;
                }

                // do we have access to this folder?
                $param['folder_id'] = $row->folder_id;
                $param['user_id']   = $_SESSION['user_id'];
                $folder_response = $privilege_model->getPrivilegeForFolder($param);

                if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                    $folder_response['privilege'] = PrivilegeOptions::WRITE;
                }

                if ($folder_response['privilege'] == PrivilegeOptions::READ || $doc_response['privilege'] == PrivilegeOptions::WRITE) {
                    if ($doc_response['privilege'] == PrivilegeOptions::READ || $doc_response['privilege'] == PrivilegeOptions::WRITE) {
                        $result_set[] = array(
                            'id'                  => $row->document_id,
                            'file_name'           => $row->file_name,
                            'generated_file_name' => $row->generated_file_name,
                            'file_size'           => number_to_size($row->file_size, 2),
                            'original_file_name'  => $row->original_file_name,
                            'version'             => $row->version,
                            'extension'           => $row->extension,
                            'mime_type'           => $row->mime_type,
                            'date_uploaded'       => $row->date_uploaded,
                            'folder_name'         => $row->folder_name,
                        );
                    }
                }
            }
            
            $response['returned_rows'] = sizeof($result_set);
            $response['result_set']    = $result_set;

            $duration = time() - $request['search_start_time'];

            if (sizeof($result_set) > 0) {
                $response['remark'] = sprintf('Search result returned: %s %s in %s seconds',
                                      sizeof($result_set), sizeof($result_set) > 1 ? 'records' : 'record',
                                      number_format($duration, 4));
            } else {
                $response['remark'] = 'Your search criteria did not return any results. Please try again';
            }

            // check if the result query contains one or more rows of data
            $response['status'] = !(sizeof($result_set) <= 0);

            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request' . $ex->getMessage();
            $response['returned_rows'] = 0;
            $response['exception_msg'] = $ex->getMessage();
            
            return $response;
        }
    }
    
    /**
     * Method gets the file name given an ID
     * @param int $id
     * @return object
     * @throws Exception
     */
    protected function getOriginalDocumentFileName(int $id): object
    {
        try {
            $db = db_connect();
            $builder = $db->table('document');
            $builder->select('file_name, version, folder');
            $builder->where('id', $id);
            return $builder->get()->getRow();
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            throw new Exception($e->getMessage());
        }
    }

    /**
     * Method gets the available documents in a folder
     * @param int $folder
     * @param int $document
     * @param bool $include_archive
     * @return array
     */
    public function getAvailableDocuments(int $folder = 0, int $document = 0, bool $include_archive = false): array
    {
        try {

            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('document.id, file_name, generated_file_name, file_size, original_file_name, version');
            $builder->select('extension, mime_type, abs_file_path, document.comment, date_uploaded, is_archived');
            $builder->select('folder.name, document.state, email_address, first_name, last_name, document_state.description, folder.id AS folder_id');
            $builder->join('user', 'user.id = document.uploaded_by', 'left');
            $builder->join('folder', 'document.folder = folder.id', 'left');
            $builder->join('document_state', 'document_state.id = document.state', 'left');
            
            if ($folder > 0) {
                $builder->where('folder.id', $folder);
            }

            if ($document > 0) {
                $builder->where('document.id', $document);
            }

            $builder->where('document.state', 1);
            $builder->orderBy('file_name', 'ASC');
            $builder->orderBy('version', 'DESC');

            $result = $builder->get();

            $result_set = [];

            helper('number');

            $privilege_model = new PrivilegeModel();

            foreach ($result->getResult() as $row) {

                $request['document_id'] = $row->id;
                $request['user_id']     = $_SESSION['user_id'];

                $response = $privilege_model->getPrivilegeForDocument($request);

                if (!$include_archive) {
                    if ($row->is_archived > 0) {
                        continue;
                    }
                }

                // restricted users can't do much on documents
                if ($_SESSION['role_id'] == UserRole::RESTRICTED_USER && $response['privilege'] > 0) {
                    $response['privilege'] = PrivilegeOptions::READ;
                }

                // an administrator has access to all documents
                if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                    $response['privilege'] = PrivilegeOptions::WRITE;
                } else {
                    // user should not have access to this folder
                    if ($response['privilege'] == PrivilegeOptions::NO_ACCESS) {
                        continue;
                    }
                }

                $current_time   = Time::now();
                $humanised_time = $current_time->difference($row->date_uploaded);

                $result_set[] = [
                    'id'                  => $row->id,
                    'file_name'           => $row->file_name,
                    'generated_file_name' => $row->generated_file_name,
                    'file_size'           => number_to_size($row->file_size, 2),
                    'original_file_name'  => $row->original_file_name,
                    'version'             => (int) $row->version,
                    'extension'           => $row->extension,
                    'mime_type'           => $row->mime_type,
                    'abs_file_path'       => $row->abs_file_path,
                    'comment'             => strlen($row->comment) <= 0 ? 'N/A' : $row->comment,
                    'date_uploaded'       => $row->date_uploaded,
                    'humanized_time'      => $humanised_time->humanize(),
                    'folder_name'         => $row->name,
                    'state'               => $row->state,
                    'email_address'       => $row->email_address,
                    'first_name'          => $row->first_name,
                    'last_name'           => $row->last_name,
                    'state_desc'          => $row->is_archived == 0 || $row->is_archived == '' ? $row->description : 'Archived',
                    'is_archived'         => (int)$row->is_archived,
                    'keywords'            => $this->getDocumentKeywords($row->id),
                    'folder_id'           => $row->folder_id,
                    'privilege'           => $response['privilege'],
                    'role_id'             => $_SESSION['role_id'],
                    'can_render'          => in_array($row->extension, Extension::getRenderSupportedExtensions()) ? 1 : 0,
                ];
            }

            $response['returned_rows'] = sizeof($result_set);
            $response['result_set']    = $result_set;
            $response['status']        = true;
            $response['remark']        = '';

            return $response;
        } catch (Exception $ex) {
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
     * Method gets keywords for a particular document
     * @param int $doc_id
     * @return array
     */
    protected function getDocumentKeywords(int $doc_id): array
    {
        try {
            $db = db_connect();

            $builder = $db->table('document_keyword');
            $builder->select('document_keyword.keyword');
            $builder->where('document_id', $doc_id);
            $builder->orderBy('keyword', 'ASC');
            
            $result = $builder->get();

            $result_set = [];

            foreach ($result->getResult() as $row) {
                $result_set[] = [
                    'keyword' => $row->keyword
                ];
            }
            
            $response['returned_rows'] = sizeof($result_set);
            $response['status']        = true;
            $response['result_set']    = $result_set;
            $response['remark']        = '';
            $response['exception_msg'] = null;
            
            return $response;
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            $response['returned_rows'] = 0;
            $response['status']        = false;
            $response['exception_msg'] = $e->getMessage();
            $response['result_set']    = null;
            $response['remark']        = 'Something went wrong while processing your request';
            
            return $response;
        }
    }

    /**
     * Method gets particular documents for downloading as a ZIP file
     * @param array The list of documents to Zip
     * @return array 
     */
    public function getDocumentsForZip($documents): ?array
    {
        try {
            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('abs_file_path, extension, file_name, generated_file_name');
            $builder->whereIn('id', $documents);
            $builder->orderBy('file_name', 'ASC');

            $result = $builder->get();

            $result_set = [];

            foreach ($result->getResult() as $row) {
                $result_set[] = [
                    'abs_file_path'       => $row->abs_file_path,
                    'extension'           => $row->extension != null ? $row->extension : null,
                    'file_name'           => $row->file_name,
                    'generated_file_name' => $row->generated_file_name
                ];
            }

            return $result_set;

        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return null;
        }
    }
    
    /**
     * Method gets document details for download purposes
     * @param $id
     * @return array
     */
    public function getDocumentForDownload($id): array
    {
        try {
            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('document.id, abs_file_path, extension, mime_type, generated_file_name, file_name');
            $builder->where('id', $id);
            $builder->orWhere('generated_file_name', trim($id));
            
            $row = $builder->get()->getRow();
            
            if (!isset($row)) { 
                $response['returned_rows'] = 0;
                $response['result_set']    = null;
                $response['status']        = false;
                $response['remark']        = 'Unable to get the document details. The document does not exist';
                
                return $response;
            }
            
            $response['returned_rows'] = 1;
            $response['result_set']    = $row;
            $response['status']        = true;
            $response['remark']        = '';
            
            return $response;
            
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            
            $response['result_set']    = null;
            $response['status']        = false;
            $response['exception_msg'] = $ex->getMessage();
            $response['remark']        = 'Something went wrong while processing your request';
            $response['returned_rows'] = 0;
            return $response;
        }
    }

    /** Method restores a document to active state
     * @param array $request
     * @return array
     */
    public function restoreDocument(array $request): array
    {
        try {

            $privilege_model = new PrivilegeModel();
            $param['document_id'] = $request['document_id'];
            $param['user_id']     = $_SESSION['user_id'];

            $response = $privilege_model->getPrivilegeForDocument($param);

            if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                $response['privilege'] = PrivilegeOptions::WRITE;
            }

            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['status'] = false;
                $response['remark'] = 'Unable to restore the document. Access denied';
                return $response;
            }

            $db = db_connect();
            $db->transBegin();

            $builder = $db->table('document');
            $builder->select('file_name, folder, is_archived, version');
            $builder->where('id', $request['document_id']);

            $main_doc = $builder->get()->getRow();

            if (!isset($request)) {
                $response['status'] = false;
                $response['remark'] = 'Unable to restore the document. It does not exist';
                return $response;
            }

            if ($main_doc->is_archived <= 0) {
                $response['status'] = false;
                $response['remark'] = 'Unable to restore the document. It is not in the archived state';
                return $response;
            }

            $builder = $db->table('document');
            $builder->set('is_archived', 0);
            $builder->set('row_version', time());
            $builder->where('file_name', $main_doc->file_name);
            $builder->where('folder', $main_doc->folder);
            $builder->update();

            $builder = $db->table('document');
            $builder->select('id, is_archived');
            $builder->where('file_name', $main_doc->file_name);
            $builder->where('folder', $main_doc->folder);
            $builder->where('version', $main_doc->version);

            $result = $builder->get();

            $logger = $db->table('document_status_change');

            foreach ($result->getResult() as $row) {
                $data = [
                    'document_id'    => $row->id,
                    'previous_state' => 0,
                    'new_state'      => 1,
                    'changed_by'     => $request['user_id'],
                    'changed_date'   => new Time('now'),
                    'row_version'    => time(),
                ];
                $logger->insert($data);
            }

            $db->transCommit();

            $response['status']        = true;
            $response['remark']        = 'Document successfully restored from archive';
            $response['exception_msg'] = null;

            return $response;
        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());

            $response['status']        = false;
            $response['remark']        = 'Something went wrong while processing your request';
            $response['exception_msg'] = $ex->getMessage();

            return $response;
        }
    }

    /** Method archives a document, and it's history versions (if available)
     * @param array $request
     * @return array
     */

    public function archiveDocument(array $request): array
    {
        try {

            $param['document_id'] = $request['document_id'];
            $param['user_id']     = $_SESSION['user_id'];

            $privilege_model = new PrivilegeModel();
            $response = $privilege_model->getPrivilegeForDocument($param);

            if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                $response['privilege'] = PrivilegeOptions::WRITE;
            }

            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['status'] = false;
                $response['remark'] = 'Unable to change the document state. Access denied';
                return $response;
            }

            $db = db_connect();

            $db->transBegin();

            $builder = $db->table('document');
            $builder->select('file_name, folder, is_archived, version');
            $builder->where('id', $request['document_id']);

            $main_doc = $builder->get()->getRow();

            if (!isset($main_doc)) {
                $response['status']        = false;
                $response['remark']        = 'Unable to archive the document. It does not exist';
                $response['exception_msg'] = null;
                return $response;
            }

            if ($main_doc->is_archived > 0) {
                $response['status']        = false;
                $response['remark']        = 'Unable to archive the document. It is already in archive state';
                $response['exception_msg'] = null;
                return $response;
            }

            $builder = $db->table('document');
            $builder->set('is_archived', 1);
            $builder->set('row_version', time());
            $builder->where('file_name', $main_doc->file_name);
            $builder->where('folder', $main_doc->folder);
            $builder->update();

            // keep a log of all the documents that have been archived
            $builder = $db->table('document');
            $builder->select('id, is_archived');
            $builder->where('file_name', $main_doc->file_name);
            $builder->where('folder', $main_doc->folder);

            $result = $builder->get();

            $logger = $db->table('document_status_change');

            foreach ($result->getResult() as $row) {
                $data = [
                    'document_id'    => $row->id,
                    'previous_state' => 1,
                    'new_state'      => 0,
                    'changed_by'     => $request['user_id'],
                    'changed_date'   => new Time('now'),
                    'row_version'    => time(),
                ];
                $logger->insert($data);
            }

            $db->transCommit();

            $response['status']        = true;
            $response['remark']        = 'Document successfully archived';
            $response['exception_msg'] = null;

            return $response;

        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());

            $response['status']        = false;
            $response['remark']        = 'Something went wrong while processing your request';
            $response['exception_msg'] = $ex->getMessage();

            return $response;
        }
    }
    
    /**
     * Method changes a document state
     * @param array $request
     * @return array
     */
    public function changeDocumentState(array $request): array
    {
        try {

            $param['document_id'] = $request['id'];
            $param['user_id']     = $_SESSION['user_id'];

            $privilege_model = new PrivilegeModel();
            $response = $privilege_model->getPrivilegeForDocument($param);

            if ($_SESSION['role_id'] == UserRole::ADMINISTRATOR) {
                $response['privilege'] = PrivilegeOptions::WRITE;
            }

            if ($response['privilege'] != PrivilegeOptions::WRITE) {
                $response['status'] = false;
                $response['remark'] = 'Unable to change the document state. Access Denied';
                return $response;
            }

            $db = db_connect();
            
            $builder = $db->table('document');
            $builder->set('state', $request['state']);
            $builder->where('id', $request['id']);
            $builder->update();
            
            $response['status']        = true;
            $response['exception_msg'] = null;
            $response['remark']        = 'Document state successfully changed';
            
            return $response;
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            
            $response['status']        = false;
            $response['remark']        = 'Something went wrong while processing your request';
            $response['exception_msg'] = $e->getMessage();
            return $response;
        }
    }
    
    /**
     * Method modifies a document's keywords
     * @param array $keywords
     * @param int $document_id
     * @return array
     */
    public function modifyDocumentKeywords(array $keywords, int $document_id): array
    {
        try {
            if (sizeof($keywords) <= 0) {
               $response['remark']        = 'Unable to modify document keywords. No keywords provided';
               $response['status']        = false;
               $response['exception_msg'] = null;
               
               return $response;
            }

            $privilege_model = new PrivilegeModel();
            $param['user_id']     = $_SESSION['user_id'];
            $param['document_id'] = $document_id;

            $result = $privilege_model->getPrivilegeForDocument($param);

            if ($result['privilege'] != PrivilegeOptions::WRITE) {
                $response['remark'] = 'Unable to modify document keywords. Access denied';
                $response['status'] = false;
                return $response;
            }

            $db = db_connect();
            
            // does the document exist?
            $document = $db->table('document');
            $document->select('id');
            $document->where('id', $document_id);
            $row = $document->get()->getRow();
            
            if (!isset($row)) {
                $response['remark']        = 'Unable to modify document keywords. The document does not exist';
                $response['status']        = false;
                $response['exception_msg'] = null;
                
                return $response;
            }
            
            $db->transBegin();
            
            $builder = $db->table('document_keyword');
            $builder->where('document_id', $document_id);
            $builder->delete();
            
            foreach (array_unique($keywords) as $item) {
                 $keyword_data = [
                   'document_id' => $document_id,
                   'keyword'     => strtoupper(trim($item))
                 ];
                $builder->insert($keyword_data);
            }
            
            $db->transCommit();
            
            $response['remark']        = 'Document keywords successfully modified';
            $response['status']        = true;
            $response['exception_msg'] = null;
            
            return $response;
        } catch (Exception $e) {
            log_message('error', $e->getMessage());
            
            $response['status']        = false;
            $response['exception_msg'] = $e->getMessage();
            $response['remark']        = 'Something went wrong while processing your request';
            return $response;
        }
    }

    /** Method gets the latest version of a file
     * @param int $id
     * @return int
     */
    public function getDocumentLatestVersion(int $id): int
    {
        try {
            $db = db_connect();

            $builder = $db->table('document');
            $builder->select('version');
            $builder->where('id', $id);
            $builder->orderBy('version', 'DESC');
            $builder->limit(1);

            $row = $builder->get()->getRow();
            return isset($row) ? $row->version : 0;

        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());
            return 0;
        }
    }

    /**
     * Method sends a notification to a user/groups of users when a document is uploaded
     * @param array $request
     * @return void
     */
    private function sendNotification(array $request): void
    {
        try {
            $db = db_connect();
            $recipients = [];

            // first get the email template
            $template = $db->table('email_template');
            $template->select('parameter_value');

            // new document uploaded
            if ($request['action_type'] == 0) {
                $template->where('parameter_name', 'document_uploaded');
            } else if ($request['action_type'] == 1) {
                $template->where('parameter_name', 'document_updated');
            } else {
                return;
            }

            $email_template = $template->get()->getRow();

            if (!isset($email_template)) {
                log_message('error', 'Missing template - Document Update/Uploaded');
                return;
            }

            $template = $email_template->parameter_value;

            // if it is a new document get the folder name
            if ($request['action_type'] == 0) {
                $builder = $db->table('folder');
                $builder->select('name');
                $builder->where('id', $request['folder_id']);
                $folder = $builder->get()->getRow();
                $request['folder_name'] = $folder->name;
            }

            // let us get the users specified for receiving emails
            if (count($request['users']) > 0) {
                foreach ($request['users'] as $user_id) {
                    if (!in_array($user_id, $recipients)) {
                        $recipients[] = $user_id;
                    }
                }
            }

            $group_membership = new GroupMembershipModel();

            // let us also get the users in the specific groups as well
            if (count($request['groups']) > 0) {
                foreach ($request['groups'] as $group_id) {
                    $group_members = $group_membership->getGroupMembers($group_id);
                    if (sizeof($group_members) > 0) {
                        foreach ($group_members as $member) {
                            if (!in_array($member, $recipients)) {
                                $recipients[] = $member;
                            }
                        }
                    }
                }
            }

            // if it is an update let's get those who have access to the document and notify them as well
            // get the emails of those who currently have access to the document
            if ($request['action_type'] == 1 && sizeof($recipients) > 0) {
                $builder = $db->table('vw_notification');
                $builder->select('user_id');
                $builder->where('document_id', $request['doc_id']);
                $builder->whereNotIn('user_id', $recipients);

                $result = $builder->get();

                foreach ($result->getResult() as $row) {
                    if (!in_array($row->user_id, $recipients)) {
                        $recipients[] = $row->user_id;
                    }
                }
            }

            // we have no one to email in this case...
            if (sizeof($recipients) <= 0) {
                return;
            }

            // get the authorising user details
            $user_model = new UserModel();
            $auth_details = $user_model->getUserDetails($_SESSION['user_id'], false);
            $auth = $auth_details['result_set'];
            $auth_full_name = sprintf('%s %s (%s)', $auth->first_name, $auth->last_name, $auth->email_address);

            $logging_model = new LoggingModel();

            // get only the unique array elements
            $mailing_list = array_unique($recipients);

            $document_model = new DocumentModel();
            $owner = $document_model->getDocumentOwner($request['doc_id']);

            // first let us get the email addresses of the users specified
            foreach ($mailing_list as $user_id) {
                
                // do not send a notification to the owner or whoever uploaded the document
                if ($owner == $user_id) {
                    continue;
                }

                $user_details = $user_model->getUserDetails($user_id, false);
                $row = $user_details['result_set'];

                if ($row->state <= 0) {
                    continue;
                }

                if (!isset($row)) {
                    continue;
                }

                // for this user log to the outgoing email table
                $full_name = sprintf('%s %s', $row->first_name, $row->last_name);

                if ($request['action_type'] == 0) {
                    $transform = array("{name}" => $full_name, "{document}" => $request['doc_name'],
                                 "{user}" => $auth_full_name, "{folder}" => $request['folder_name']);
                } else {
                    $transform = array("{name}" => $full_name, "{document}" => $request['doc_name'],
                                 "{user}" => $auth_full_name, "{version}" => $request['version']);
                }

                $email_msg = strtr($template, $transform);

                $email_param['recipient']     = $row->email_address;
                $email_param['email_message'] = $email_msg;
                $email_param['submit_date']   = new Time('now');
                $email_param['subject']       = $request['action_type'] == 0 ? 'Document Uploaded' : 'Document Updated';

                $logging_model->logOutgoingEmail($email_param);
            }

            return;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            return;
        }
    }

    /**
     * Method uploads a document
     * @param array $request
     * @param array $keywords
     * @param bool $is_update
     * @return array
     */
    public function uploadDocument(array $request, array $keywords, bool $is_update = false): array
    {

        $db = null;
        $current_id = 0;

        try {
            if ($is_update && (!$this->doesDocumentExist($request['file_name'], $request['version'], $request['folder']))) {
                $response['status'] = false;
                $response['remark'] = sprintf('Unable to update the document: %s. It does not exist', trim($request['file_name']));
                return $response;
            }

            $param['folder_id'] = $request['folder'];
            $param['user_id']   = $_SESSION['user_id'];

            // does the user have access to the folder?
            $privilege_model = new PrivilegeModel();
            $result = $privilege_model->getPrivilegeForFolder($param);

            if ($result['privilege'] != PrivilegeOptions::WRITE) {
                $response['status'] = false;
                $response['remark'] = 'Unable to upload the document. You do not have write privileges on the folder';
                return $response;
            }
  
            $db = db_connect();
            $db->transStart();

            if ($is_update) {
                $builder = $db->table('document');
                $builder->select('id');
                $builder->where('file_name', $request['file_name']);
                $builder->where('version', $request['version']);
                $builder->where('folder', $request['folder']);
                
                $result = $builder->get()->getRow();

                $current_id = $result->id;

                // check to see if the user has access to modify the document
                $privilege_model = new PrivilegeModel();
                $param['document_id'] = $current_id;
                $param['user_id']     = $_SESSION['user_id'];

                $response = $privilege_model->getPrivilegeForDocument($param);

                if ($response['privilege'] != PrivilegeOptions::WRITE) {
                    $response['status'] = false;
                    $response['remark'] = 'Unable to update the document. Access denied';
                    return $response;
                }

                $data = [
                    'file_name'            => $request['file_name'],
                    'generated_file_name'  => $request['generated_file_name'],
                    'file_size'            => $request['file_size'],
                    'original_file_name'   => $request['original_file_name'],
                    'version'              => $request['version'] + 1,
                    'extension'            => $request['extension'],
                    'mime_type'            => $request['mime_type'],
                    'folder'               => $request['folder'],
                    'abs_file_path'        => $request['abs_file_path'],
                    'comment'              => $request['comment'],
                    'date_uploaded'        => new Time('now'),
                    'uploaded_by'          => $request['uploaded_by'],
                    'state'                => $request['state'],
                    'is_archived'          => 0,
                    'row_version'          => time(),
                ];
            } else {
                $request['version'] = 1;

                $data = [
                    'file_name'            => $request['file_name'],
                    'generated_file_name'  => $request['generated_file_name'],
                    'file_size'            => $request['file_size'],
                    'original_file_name'   => $request['original_file_name'],
                    'version'              => $request['version'],
                    'extension'            => $request['extension'],
                    'mime_type'            => $request['mime_type'],
                    'folder'               => $request['folder'],
                    'abs_file_path'        => $request['abs_file_path'],
                    'comment'              => $request['comment'],
                    'is_archived'          => 0,
                    'date_uploaded'        => new Time('now'),
                    'uploaded_by'          => $request['uploaded_by'],
                    'state'                => 1,
                    'row_version'          => time(),
                ];
            }
        
            $db->table('document')->insert($data);

            // get the id of the newly inserted row
            $builder = $db->table('document');
            $builder->select('id');
            $builder->where('file_name', $request['file_name']);

            if ($is_update) {
                $builder->where('version', $request['version'] + 1);
            } else {
                $builder->where('version', $request['version']);
            }

            $builder->where('folder', $request['folder']);

            $row = $builder->get()->getRow();

            if (!isset($row)) {
                $response['remark'] = 'Something went wrong while processing your request. Invalid request';
                $response['status'] = false;
                return $response;
            }

            // update the previous documents of this version to -1 to show that they are in history now
            if ($is_update) {
                $builder = $db->table('document');
                $builder->set('state', -1);
                $builder->set('row_version', time());
                $builder->where('file_name', $request['file_name']);
                $builder->where('version <', $request['version'] + 1);
                $builder->where('folder', $request['folder']);
                $builder->update();
            }

            $lib = new StringHelper();

            // iterate through all the provided document keywords (if any)
            if (sizeof($keywords) > 0) {
                foreach (array_unique($keywords) as $keyword) {
                    if (strlen(trim($keyword)) > 0) {
                        $keyword_data = [
                            'document_id' => $row->id,
                            'keyword'     => $lib->formatName($keyword),
                        ];
                        $db->table('document_keyword')->insert($keyword_data);
                    }
                }
            }
            
            // grant access to the newly created document for this user
            $data = [
                'row_id'       => $lib->generateGuid(),
                'document_id'  => $row->id,
                'user_id'      => $_SESSION['user_id'],
                'created_date' => new Time('now'),
                'privilege'    => PrivilegeOptions::WRITE
            ];

            $db->table('document_access_level')->insert($data);

            if ($is_update) {
                $query = 'UPDATE `document_access_level` ';
                $query.= 'SET `document_id` = ?,  ';
                $query.= '`updated_date` = NOW()  ';
                $query.= 'WHERE `document_id` = ? ';
                $query.= 'AND `user_id` != ?';

                $db->query($query, [$row->id, $current_id, $_SESSION['user_id']]);
            }

            $db->transCommit();

            // in this case it was an update rather than a new document upload
            if ($is_update) {

                $param['action_type'] = 1;
                $param['doc_name']    = $request['file_name'];
                $param['version']     = $request['version'] + 1;
                $param['users']       = $request['users'];
                $param['groups']      = $request['groups'];
                $param['doc_id']      = $row->id;

                // send a notification to all users and groups
                $this->sendNotification($param);

                $response['remark'] = sprintf('Document: %s successfully updated to version %s', $lib->formatName($request['file_name']), $request['version'] + 1);
            } else {

                $param['action_type'] = 0;
                $param['doc_name']    = $request['file_name'];
                $param['version']     = $request['version'];
                $param['users']       = $request['users'];
                $param['groups']      = $request['groups'];
                $param['doc_id']      = $row->id;

                $this->sendNotification($param);

                $response['remark'] = sprintf('Document: %s successfully uploaded', ucwords($request['file_name']));
            }

            $response['status'] = true;
            return $response;
        } catch (Exception $e) {
            log_message('error', $e->getMessage());

            if ($db != null) {
                $db->transRollback();
            }
            
            $response['exception_msg'] = $e->getMessage();
            $response['remark']        = 'Something went wrong while processing your request';
            $response['status']        = false;

            return $response;
        }
    }
}