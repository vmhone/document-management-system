<?php

class Extension {
    public static function getRenderSupportedExtensions(): array
    {
        return array('jpg', 'jpeg', 'gif', 'pdf', 'bmp', 'tif', 'tiff', 'txt', 'csv', 'dat', 'png', 'avif', 'svg', 'webp');
    }
}