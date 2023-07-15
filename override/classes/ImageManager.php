<?php
/**
* Modulo WebP for Product Sheet
*
* @author    Yipi.app
* @copyright 2016 Yipi.app
* @license   Commercial use allowed (Non-assignable & non-transferable), can modify source-code but cannot distribute modifications (derivative works).
*/

class ImageManager extends ImageManagerCore
{
    public static function resize(
        $src_file,
        $dst_file,
        $dst_width = null,
        $dst_height = null,
        $file_type = 'jpg',
        $force_type = false,
        &$error = 0,
        &$tgt_width = null,
        &$tgt_height = null,
        $quality = 5,
        &$src_width = null,
        &$src_height = null
    ) {
        $instance = Module::getInstanceByName('kpswebp');
        if ($instance && $instance->active) {
            return $instance->resize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type, $error, $tgt_width, $tgt_height, $quality, $src_width, $src_height);
        }
        return self::coreResize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type, $error, $tgt_width, $tgt_height, $quality, $src_width, $src_height);
    }
    public static function coreResize(
        $src_file,
        $dst_file,
        $dst_width = null,
        $dst_height = null,
        $file_type = 'jpg',
        $force_type = false,
        &$error = 0,
        &$tgt_width = null,
        &$tgt_height = null,
        $quality = 5,
        &$src_width = null,
        &$src_height = null
    ) {
        $is_16 = version_compare(_PS_VERSION_, '1.6.0.3') >= 0;
        if (!$is_16) {
            return ImageManagerCore::resize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type);
        } elseif (version_compare(_PS_VERSION_, '1.6.1.0') < 0) {
            return ImageManagerCore::resize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type, $error);
        } else {
            return ImageManagerCore::resize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type, $error, $tgt_width, $tgt_height, $quality, $src_width, $src_height);
        }
    }
    public static function isCorrectImageFileExt($filename, $authorizedExtensions = null)
    {
        // Filter on file extension
        if ($authorizedExtensions === null) {
            $authorizedExtensions = array('gif', 'webp', 'jpg', 'jpeg', 'jpe', 'png');
        } else {
            $authorizedExtensions[] = 'webp';
        }
        $nameExplode = explode('.', $filename);
        if (count($nameExplode) >= 2) {
            $currentExtension = strtolower($nameExplode[count($nameExplode) - 1]);
            if (!in_array($currentExtension, $authorizedExtensions)) {
                return false;
            }
        } else {
            return false;
        }
        return true;
    }
    public static function isRealImage($filename, $fileMimeType = null, $mimeTypeList = null)
    {
        if (!$mimeTypeList) {
            $mimeTypeList = array(
                'image/gif',
                'image/jpg',
                'image/jpeg',
                'image/pjpeg',
                'image/png',
                'image/x-png',
                'image/webp',
            );
        }
        $mimeType = false;
        $mimeTypeList[] = 'image/webp';// Try 4 different methods to determine the mime type
        if (function_exists('finfo_open'))
        {
            $const = defined('FILEINFO_MIME_TYPE') ? FILEINFO_MIME_TYPE : FILEINFO_MIME;
            $finfo = finfo_open($const);
            $mimeType = finfo_file($finfo, $filename);
            finfo_close($finfo);
        }
        elseif (function_exists('mime_content_type'))
            $mimeType = mime_content_type($filename);
        elseif (function_exists('exec'))
        {
            $mimeType = trim(exec('file -b --mime-type '.escapeshellarg($filename)));
            if (!$mimeType)
                $mimeType = trim(exec('file --mime '.escapeshellarg($filename)));
            if (!$mimeType)
                $mimeType = trim(exec('file -bi '.escapeshellarg($filename)));
        }
        if ($fileMimeType && (empty($mimeType) || $mimeType == 'regular file' || $mimeType == 'text/plain')) {
            $mimeType = $fileMimeType;
        }
        // For each allowed MIME type, we are looking for it inside the current MIME type
        foreach ($mimeTypeList as $type) {
            if (strstr($mimeType, $type)) {
                return true;
            }
        }
        return false;
    }
}
