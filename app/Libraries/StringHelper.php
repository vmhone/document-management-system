<?php namespace CustomHelper\Common;

class StringHelper {

    /**
     * Method dumps contents of a variable
     * @param $var
     */
    public function dumpVariable($var) {
        echo '<pre>';
        var_dump($var);
        echo '</pre>';
        exit;
    }

    /**
     * Method gets the current URL
     * @return string
     */
    public function getCurrentUrl() {
        return (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] === 'on' ? "https" : "http") . "://$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
    }

    /**
     * Method gets the current URI
     * @return string|string[]
     */
    public function getCurrentUri() {
        $uri = strtolower(trim($_SERVER['REQUEST_URI']));
        if (strpos($uri, 'index.php')) {
            return str_replace('/index.php', '', $uri);
        } else {
            return $uri;
        }
    }

    /**
     * Method gets an IP Address of a client
     * @return string
     */
    public function getIpAddress() {
        return $_SERVER['HTTP_CLIENT_IP'] ? $_SERVER['HTTP_CLIENT_IP'] : ($_SERVER['HTTP_X_FORWARDED_FOR'] ? $_SERVER['HTTP_X_FORWARDED_FOR'] : $_SERVER['REMOTE_ADDR']);
    }

    /**
     * Method gets the user agent
     * @return mixed
     */
    public function getUserAgent() {
        return $_SERVER['HTTP_USER_AGENT'];
    }

    /**
    * Method hashes a plain text password
    * @param string
    * @return string
    */
    public function hashPassword($plain_text_password) {
        return base64_encode(hash('sha512', $plain_text_password, true));
    }

    /**
     * Method encrypts a plain text string
     * @param $plain_text
     * @param $encryption_key
     * @return false|string
     */
    public function encryptString($plain_text, $encryption_key) {
        $ciphering = "AES-256-CTR";
        $options = 0;
        $encryption_iv = '1234567891011121';
        return  openssl_encrypt($plain_text, $ciphering, $encryption_key, $options, $encryption_iv);
    }

    /**
     * Method decrypts a string
     * @param $cipher_text
     * @param $decryption_key
     * @return false|string
     */
    public function decryptString($cipher_text, $decryption_key) {
        $decryption_iv = '1234567891011121';
        $ciphering = "AES-256-CTR";
        $options = 0;
        return openssl_decrypt($cipher_text, $ciphering, $decryption_key, $options, $decryption_iv);
    }

    /**
    * Method flattens an array
    * @param array
    * @return array
    *
    */
    public function flattenArray(array $array) {
        $result = array();
        if (is_array($array)) {
            foreach ($array as $k => $v) {
                if (is_array($v)) {
                    $result = array_merge($result, $this->flattenArray($v));
                } else {
                    $result[$k] = $v;
                }
            }
        }
        return $result;
    }
    
    /**
     * Method generates a unique GUID
     * @param bool
     * @return string
     */
    public function generateGuid($include_dashes = false) {
        if (function_exists('com_create_guid') === true) {
            return trim(com_create_guid(), '{}');
        }

        if ($include_dashes) {
            return sprintf('%04X%04X-%04X-%04X-%04X-%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535),
                mt_rand(16384, 20479), mt_rand(32768, 49151), mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));
        }

        return sprintf('%04X%04X%04X%04X%04X%04X%04X%04X', mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535),
                                                           mt_rand(16384, 20479), mt_rand(32768, 49151),
                                                           mt_rand(0, 65535), mt_rand(0, 65535), mt_rand(0, 65535));
    }

    /**
    *
    * Method generates a random password
    * @param int $length Specifies the length of the random password 
    * @return string
    *
    */
    
   public function generateRandomPassword($length = 8) {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%^&*()?[]{}';
        $charactersLength = strlen($characters);
        $randomString = '';
    
        for ($i = 0; $i < $length; $i++) {
          $randomString .= $characters[rand(0, $charactersLength - 1)];
        }
        return $randomString;
    }

    /**
     * Method converts a number to a human readable format
     * @param float $value
     * @return string
     */
    public function convertToThousandsFormat($value) {
       return number_format($value, 0, '.', ',');
    }

    /**
    * Method formats a name by removing spaces and trimming unnecessary characters
    * @param string
    * @param bool
    * @return string
    */

    public function formatName($name, $convert_to_upper = false) {
        $formatted_name = $convert_to_upper ? strtoupper(trim($name)) : ucwords(strtolower(trim($name)));
        return preg_replace('/\s+/', ' ', $formatted_name);
    }
}