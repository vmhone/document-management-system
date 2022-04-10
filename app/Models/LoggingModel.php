<?php namespace App\Models;
use CodeIgniter\Model;
use Exception;

class LoggingModel extends Model {
    /**
     * Method logs outgoing emails to the database
     * @param array
     * @return bool
     */
    public function logOutgoingEmail($param): bool
    {
        try {
            $db = db_connect();
            $builder = $db->table('outgoing_email');

            if (isset($param['sent_date'])) {
                $data = [
                    'recipient'     => $param['recipient'],
                    'email_message' => $param['email_message'],
                    'subject'       => $param['subject'],
                    'submit_date'   => $param['submit_date'],
                    'sent_date'     => $param['sent_date'],
                    'is_sent'       => $param['is_sent'],
                ];
            } else {
                // we are sending an email with an attachment here
                if (isset($param['attachment'])) {
                    $data = [
                        'recipient'     => $param['recipient'],
                        'email_message' => $param['email_message'],
                        'subject'       => $param['subject'],
                        'attachment'    => $param['attachment'],
                        'friendly_name' => !isset($param['friendly_name']) ? basename($param['attachment']) : $param['friendly_name'],
                        'submit_date'   => $param['submit_date'],
                    ];
                } else {                   
                    $data = [
                        'recipient'     => $param['recipient'],
                        'email_message' => $param['email_message'],
                        'subject'       => $param['subject'],
                        'submit_date'   => $param['submit_date'],
                    ];
                }
            }

            $builder->insert($data);
            return true;
        } catch(Exception $ex) {
            log_message('error', $ex->getMessage());
            return false;
        }
    }
}