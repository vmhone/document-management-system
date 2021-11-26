<?php
    
    $database_config['host']     = 'localhost';
    $database_config['username'] = 'root';
    $database_config['password'] = '';
    $database_config['database'] = 'dms-ictech';

    // connect to the database the get the necessary configs
    $con = new mysqli($database_config['host'], $database_config['username'], $database_config['password'], $database_config['database']);
    if ($con->connect_errno) {
        printf("Connection failed: %s\n", $con->connect_error);
        exit();
    }

    $email_config['debug'] = false;

    $query = 'SELECT `parameter_name`, `parameter_value` FROM `config`';
 
    if ($res = $con->query($query)) {
        while ($row = $res->fetch_object()) {
            if (strtolower($row->parameter_name) == 'smtp_host') {
                $email_config['hostname'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'sender_address') {
                $email_config['sender'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'smtp_password') {
                $email_config['password'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'smtp_crypto') {
                $email_config['protocol'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'smtp_port') {
                $email_config['port'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'system_id') {
                $email_config['name'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'smtp_timeout') {
                $email_config['timeout'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'smtp_username') {
                $email_config['username'] = $row->parameter_value;
            } else if (strtolower($row->parameter_name) == 'no_reply_address') {
                $email_config['reply_to'] = $row->parameter_value;
            }
        }
        $res->close();
    }
    $con->close();  
?>