<?php

ini_set('max_execution_time', '300'); // run the script for 5 minutes
date_default_timezone_set("Africa/Blantyre");

$database_config = [];
$email_config    = [];

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\SMTP;

require_once 'src/PHPMailer.php'; 
require_once 'src/Exception.php';
require_once 'src/POP3.php';
require_once 'src/SMTP.php';
require_once 'config.php';

// connect to the database and get pending emails
$con = new mysqli($database_config['host'], $database_config['username'], $database_config['password'], $database_config['database']);

if ($con->connect_errno) {
    printf("Connection failed: %s\n", $con->connect_error);
    exit();
}

$query = 'SELECT `row_id`, `recipient`, `email_message`, `subject`, `attachment`, `friendly_name` ';
$query.= 'FROM `outgoing_email` ';
$query.= 'WHERE `is_sent` IS NULL OR `is_sent` <= 0 ';
$query.= 'ORDER BY `submit_date` ASC ';
$query.= 'LIMIT 500';

$processed_emails = [];

if ($res = $con->query($query)) {
    while ($row = $res->fetch_object()) {

        if (in_array($row->row_id, $processed_emails)) {
            continue;
        }

        $mail = new PHPMailer();

        $mail->isSMTP();                                     
        $mail->Host       = $email_config['hostname'];  
        $mail->SMTPAuth   = true;                               
        $mail->Username   = $email_config['username'];                
        $mail->Password   = $email_config['password'];                           
        $mail->SMTPSecure = $email_config['protocol'];                            
        $mail->Port       = $email_config['port'];
        $mail->From       = $email_config['sender'];
        $mail->FromName   = $email_config['name'];
        $mail->CharSet    = 'UTF-8';
        $mail->Encoding   = 'base64';
        $mail->Timeout    = $email_config['timeout'];
        $mail->addReplyTo($email_config['reply_to'], $email_config['name']);

        if ($email_config['debug']) {
            $mail->SMTPDebug = SMTP::DEBUG_SERVER;
        }

        $mail->addAddress($row->recipient);                                    
        $mail->isHTML(true);                       
        
        // is an attachment present?
        if (strlen($row->attachment) > 0) {
            $mail->addAttachment($row->attachment, $row->friendly_name);
        }

        $mail->Subject = $row->subject;
        $mail->Body    = $row->email_message;

        if(!$mail->send()) {
            echo sprintf('Message could not be sent to: %s. Reason: %s', $row->recipient, $mail->ErrorInfo);
        } else {
            $update_query = 'UPDATE `outgoing_email` ';
            $update_query.= 'SET `is_sent`  = 1, ';
            $update_query.= '`sent_date`    = ?  ';
            $update_query.= 'WHERE `row_id` = ?  ';
            
            if ($stmt = mysqli_prepare($con, $update_query)){
                mysqli_stmt_bind_param($stmt, "si", date('Y-m-d H:i:s'), $row->row_id);
                mysqli_stmt_execute($stmt);
                echo sprintf("Email sent to: %s\n", $row->recipient) . '<br />';
                $mail = null;
                array_push($processed_emails, $row->row_id);
            } else {
                echo mysqli_error($con);
            }
        }
    }
    $res->close();
} else {
      echo "Failed to fetch data\n";
}

// close the connection to the database
$con->close();
$processed_emails = array();