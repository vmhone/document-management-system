<?php

class Extension {
    public static function getRenderSupportedExtensions() {
        $allowed_extensions = array('jpg', 'jpeg', 'gif', 'pdf', 'bmp', 'tif', 'tiff', 'txt', 'csv', 'dat', 'png', 'avif', 'svg', 'webp');
        return $allowed_extensions;
    }
}