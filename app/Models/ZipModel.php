<?php namespace App\Models;

use ZipArchive;
use CodeIgniter\Model;
use Exception;

class ZipModel extends Model {

     /**
     * Method to zip a collection of files
     * @param  array
     * @return array
     */

    public function zipDocuments($files): array
    {
        $response = [];
        $filename = 'dms-download-' . time() . rand(1000, 9999) . '.zip';

        try {       
            // if the download directory does not exist, then go ahead and create it
            $path = WRITEPATH . 'downloads/';

            // adjust the folder separators depending on the OS being used
            if (stristr(PHP_OS, 'WIN')) {
                $path = str_replace("/", "\\", $path);
            } else {
                // probably a Linux/Unix/Mac environment
                $path = str_replace("\\", "/", $path);
            }
            
            if (!file_exists($path)) {
                mkdir($path);
            }

            $zip_path = sprintf('%s%s', $path, $filename);
            $zip = new ZipArchive;

            if (file_exists($zip_path)) {
                unlink($zip_path);
            }

            // overwrite if the file already exists
            if ($zip->open($zip_path, ZipArchive::CREATE)) {
                foreach ($files as $row) {
                    if ($row['extension'] != null) {
                        $abs_file_path = sprintf('%s%s.%s', $row['abs_file_path'], $row['generated_file_name'], $row['extension']);
                    } else {
                        $abs_file_path = sprintf('%s%s', $row['abs_file_path'], $row['generated_file_name']);
                    }
                    if (file_exists($abs_file_path)) {
                        if ($row['extension'] != null) {
                            $zip->addFile($abs_file_path, sprintf('%s.%s', $row['file_name'], $row['extension']));
                        } else {
                            $zip->addFile($abs_file_path, $row['file_name']);
                        }
                    }
                }
                $zip->close();
                $response['status']   = true;
            } else {
                $response['status']   = false;
            }
            $response['filename'] = $filename;
            $response['zip_path'] = $zip_path;
            return $response;
        } catch (Exception $ex) {
            log_message('error', $ex->getMessage());
            $response['status']   = false;
            $response['filename'] = $filename;
            $response['zip_path'] = $zip_path;
            return $response;
        }
    }
}