<?php
/**
 * Module WebP for Product Sheet
 *
 * @author    Yipi.app
 * @copyright 2023 Yipi.app
 * @license   GPLv2
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class KPSWebP extends Module
{
    private $config = array();
    public $context = null;
    private static $module_cache = array();
    private static $max_time = 0;
    private static $init_time = 0;
    public function __construct()
    {
        $this->name = 'kpswebp';
        $this->tab = 'front_office_features';
        $this->version = '1.1.6';
        $this->author = 'Yipi.app';
        $this->module_key = '';
        $this->bootstrap = true;

        parent::__construct();
        $this->context = Context::getContext();
        $this->displayName = $this->l('WebP for Prestashop by Yipi.app');
        $this->description = $this->l('Accept WebP Upload for all Store');

        if ($this->active) {
            include_once _PS_MODULE_DIR_ . 'kpswebp/lib/vendor/autoload.php';
            if (KPSWebP::$init_time == 0) {
                $max_time = (int) (ini_get("max_execution_time") * 0.9);
                if ($max_time < 1) {
                    $max_time = 250;
                }
                KPSWebP::$init_time = time();
                KPSWebP::$max_time = $max_time;
            }
            $id_shop = Shop::getContextShopID();
            $id_shop_group = Shop::getContextShopGroupID();
            $config = Configuration::get(
                $this->name . 'c_config',
                null,
                $id_shop_group,
                $id_shop
            );
            $this->config = (array) json_decode($config, true);
            if (!isset($this->config['threads'])) {
                $this->config['threads'] = 4;
                $this->config['max_convert_by_request'] = 1;
            }
        } else {
            $this->config = array(
                'threads' => 4,
                $this->config['max_convert_by_request'] => 50,
            );
        }
    }
    /**
     * Add the CSS & JavaScript files you want to be loaded in the BO.
     */
    public function hookDisplayBackOfficeHeader()
    {
        //$this->context->controller->addJS($this->_path.'views/js/back.js');
    }

    public function install()
    {
        if (version_compare(PHP_VERSION, '5.4') < 0) {
            $this->_errors[] = $this->l('This module only work on PHP 5.4 or later.');
            return false;
        }
        if (!extension_loaded('gd')) {
            $this->_errors[] = $this->l('This module requires the GD extension to be loaded.');
            return false;
        }
        if (!function_exists('imagecreatefromwebp')) {
            $this->_errors[] = $this->l('This module requires the GD extension with webp support.');
            return false;
        }
        if (!function_exists('mime_content_type')) {
            $this->_errors[] = $this->l('This module requires the PHP fileinfo extension to be loaded.');
            return false;
        }
        if (version_compare(_PS_VERSION_, '1.5.0.15') < 0) {
            $this->_errors[] = $this->l('This module only work on Prestashop 1.5.0.15 or later.');
            return false;
        }
        $r = parent::install();
        if (file_exists(_PS_ROOT_DIR_ . '/var/cache/dev/class_index.php')) {
            unlink(_PS_ROOT_DIR_ . '/var/cache/dev/class_index.php');
        }
        if (file_exists(_PS_ROOT_DIR_ . '/var/cache/prod/class_index.php')) {
            unlink(_PS_ROOT_DIR_ . '/var/cache/prod/class_index.php');
        }
        if (file_exists(_PS_ROOT_DIR_ . '/cache/class_index.php')) {
            unlink(_PS_ROOT_DIR_ . '/cache/class_index.php');
        }
        $dir = dirname(__FILE__) . '/lib/vendor/rosell-dk/webp-convert/src/Convert/Converters/Binaries';
        if (is_dir($dir)) {
            $dirs = scandir($dir);
            foreach ($dirs as $cdir) {
                if ($cdir != '.' && $cdir != '..') {
                    if (is_file($dir . '/' . $cdir)) {
                        @chmod($dir . '/' . $cdir, 0755);
                    }
                }
            }
        }
        if ($r) {
            Db::getInstance()->Execute('CREATE TABLE IF NOT EXISTS `' . bqSQL(_DB_PREFIX_) . 'kpswebp_cache` (
                `id` INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
                `cache_id` varchar(255) NOT NULL,
                `data` LONGTEXT NOT NULL,
                `ttl` BIGINT NOT NULL,
                UNIQUE(cache_id),
                INDEX(ttl)
            )');
        }
        return $r && $this->registerHook('displayBackOfficeHeader');
    }
    public static function getCache($cache_id)
    {
        if (Tools::isSubmit('ignorecache') || Tools::strlen($cache_id) > 255) {
            return false;
        }
        $data = false;
        if (isset(self::$module_cache[$cache_id]) && ($data = self::$module_cache[$cache_id])) {
            return $data;
        }
        try {
            $d = Db::getInstance()->ExecuteS('SELECT `data`, `ttl` FROM `' . bqSQL(_DB_PREFIX_) . 'kpswebp_cache`
                    WHERE `cache_id` = \'' . pSQL($cache_id) . '\'');
            if ($d && isset($d[0]) && isset($d[0]['ttl'])) {
                if ($d[0]['ttl'] < time()) {
                    $d = false;
                    Db::getInstance()->Execute('DELETE FROM `' . bqSQL(_DB_PREFIX_) . 'kpswebp_cache`
                        WHERE `ttl` < ' . (int) time());
                } else {
                    $d = $d[0]['data'];
                }
            } else {
                $d = false;
            }
        } catch (PrestaShopDatabaseException $e) {
            return false;
        }
        if ($d) {
            $data = json_decode($d, true);
            self::$module_cache[$cache_id] = $data;
        }
        return $data;
    }
    public static function setCache($cache_id, $value, $ttl = 172800)
    {
        if (Tools::isSubmit('ignoresavecache') || Tools::strlen($cache_id) > 255) {
            return false;
        }
        self::$module_cache[$cache_id] = $value;
        try {
            Db::getInstance()->Execute('DELETE FROM `' . bqSQL(_DB_PREFIX_) . 'kpswebp_cache`
                    WHERE `ttl` < ' . (int) time() . ' OR `cache_id` = \'' . pSQL($cache_id) . '\'');
            if ($value !== false && $value !== null) {
                return Db::getInstance()->Execute('INSERT IGNORE INTO `' . bqSQL(_DB_PREFIX_) . 'kpswebp_cache`
                        (`cache_id`, `data`, `ttl`) VALUES
                        (\'' . pSQL($cache_id) . '\',
                         \'' . pSQL(json_encode($value)) . '\',
                         ' . ($ttl >= 0 ? (int) (time() + $ttl) : PHP_INT_MAX) . ')');
            } else {

            }
            return true;
        } catch (PrestaShopDatabaseException $e) {
            return false;
        }
    }
    protected function getWarningMultishopHtml()
    {
        if (Shop::getContext() == Shop::CONTEXT_GROUP || Shop::getContext() == Shop::CONTEXT_ALL) {
            return '<ps-alert-warn>' .
            $this->l('You cannot change setting from a "All Shops" or a "Group Shop" context') .
            ', ' . $this->l('select directly the shop you want to edit') .
                '</ps-alert-warn>';
        } else {
            return '';
        }
    }
    protected function getShopContextError()
    {
        return '<ps-alert-error>' .
        sprintf($this->l('You cannot edit setting from a "All Shops" or a "Group Shop" context')) .
            '</ps-alert-error>';
    }
    protected function preProcess()
    {
        if (Tools::isSubmit('config')) {
            $this->config = (array) Tools::getValue('config');
            if (!empty($this->config['other_path'])) {
                $user_dirs = explode(',', $this->config['other_path']);
                foreach ($user_dirs as &$dir) {
                    $dir = trim(trim($dir), '/');
                }
                $this->config['other_path'] = implode(',', $user_dirs);
            }
            $this->config['threads'] = max(1, min((int) $this->config['threads'], 4));
            $id_shop = Shop::getContextShopID();
            $id_shop_group = Shop::getContextShopGroupID();
            Configuration::updateValue(
                $this->name . 'c_config',
                (string) json_encode($this->config),
                false,
                $id_shop_group,
                $id_shop
            );
            $data = json_decode($file, true);
            if (isset($data['lic'])) {
                $id_shop = Shop::getContextShopID();
                $id_shop_group = Shop::getContextShopGroupID();
                Configuration::updateValue(
                    'PS_MODULE_INSTALLED_KWP',
                    $data['expire'],
                    false,
                    $id_shop_group,
                    $id_shop
                );
            }
            return '<ps-alert-success>' . $this->l('Saved with success!') . '</ps-alert-success>';
        }
        return '';
    }
    public function getContent()
    {
        if (Tools::isSubmit('get_max_execution_time')) {
            echo "MAX TIME: '" . ini_get("max_execution_time") . "'";
            exit;
        }
        if (Tools::isSubmit('phpinfo')) {
            phpinfo();
            exit;
        }
        if (Tools::isSubmit('lastlog')) {
            $log = _PS_MODULE_DIR_ . 'kpswebp/logs/' . date('Y-m') . '/log-' . date('Y-m-d') . '.log';
            if (file_exists($log)) {
                $fp = fopen($log, 'r');
                if ($fp) {
                    die(fread($fp, filesize($log)));
                }
            }
        }
        if (Tools::isSubmit('clearlastlog')) {
            $log = _PS_MODULE_DIR_ . 'kpswebp/logs/' . date('Y-m') . '/log-' . date('Y-m-d') . '.log';
            if (file_exists($log)) {
                unlink($log);
                die('OK');
            }
        }
        if (Tools::isSubmit('removecache')) {
            Db::getInstance()->Execute('TRUNCATE TABLE `' . bqSQL(_DB_PREFIX_) . 'kpswebp_cache`');
            die('Cache deleted!...');
        }
        $ps_version = 1.6;
        if (version_compare(_PS_VERSION_, '1.6') < 0) {
            $ps_version = 1.5;
        }
        if (version_compare(_PS_VERSION_, '1.7.0.0') >= 0) {
            $ps_version = 1.7;
        }
        $this->smarty->assign('ps_version', $ps_version);
        $this->smarty->assign('display_name', $this->name);
        $this->smarty->assign('riot_compiler_url', $this->_path . 'views/js/riot.compiler.min.js');
        $ui_alerts = $this->display(__FILE__, 'views/templates/admin/prestui/ps-alert.tpl');
        $ui_riot = $this->display(__FILE__, 'views/templates/admin/libs.tpl');
        $b64_riot = $this->display(__FILE__, 'views/templates/admin/b64_riot.tpl');

        $str = $this->getWarningMultishopHtml();
        if (Shop::getContext() == Shop::CONTEXT_GROUP || Shop::getContext() == Shop::CONTEXT_ALL) {
            return sprintf($b64_riot, htmlentities($str . $this->getShopContextError()) . $ui_alerts) . $ui_riot;
        }
        $str .= $this->preProcess();
        $this->smarty->assign('config', $this->config);
        $process = array();
        if (empty($str) || strstr($str, 'ps-alert-success') !== false) {
            Tools::generateHtaccess();
            if (file_exists(_PS_IMG_DIR_ . '.htaccess')) {
                $fp = fopen(_PS_IMG_DIR_ . '.htaccess', "r");
                $htaccess = fread($fp, filesize(_PS_IMG_DIR_ . '.htaccess'));
                fclose($fp);
                if (strstr($htaccess, '|webp|') === false) {
                    $htaccess = str_replace('|png|', '|png|webp|', $htaccess);
                    $fp = fopen(_PS_IMG_DIR_ . '.htaccess', "w");
                    fwrite($fp, $htaccess);
                    fclose($fp);
                }
            }
            $i = 0;
            if (isset($this->config['other_path']) && !empty($this->config['other_path'])) {
                $user_dirs = explode(',', $this->config['other_path']);
                foreach ($user_dirs as $dir) {
                    $r_path = trim(trim($dir), '/');
                    $new_dir = _PS_ROOT_DIR_ . '/' . $r_path;
                    if (is_dir($new_dir)) {
                        $process[] = array('id' => 'kpswebp_form_' . ($i++), 'name' => $r_path, 'path' => $new_dir, 'count' => $this->countWebPImages($new_dir));
                    } else {
                        $str .= '<ps-alert-error>' .
                        $this->l('Directory not exists') . ': ' . $new_dir .
                            '</ps-alert-error>';
                    }
                }
            }
            $process = array_merge(array(
                array('id' => 'kpswebp_form_' . ($i++), 'name' => $this->l('Categories'), 'path' => _PS_CAT_IMG_DIR_), // 'count' => $this->countWebPImages(_PS_CAT_IMG_DIR_)),
                array('id' => 'kpswebp_form_' . ($i++), 'name' => $this->l('Manufacturers'), 'path' => _PS_MANU_IMG_DIR_), // 'count' => $this->countWebPImages(_PS_MANU_IMG_DIR_)),
                array('id' => 'kpswebp_form_' . ($i++), 'name' => $this->l('Suppliers'), 'path' => _PS_SUPP_IMG_DIR_), // 'count' => $this->countWebPImages(_PS_SUPP_IMG_DIR_)),
                array('id' => 'kpswebp_form_' . ($i++), 'name' => $this->l('Products'), 'path' => _PS_PROD_IMG_DIR_), // 'count' => $this->countWebPImages(_PS_PROD_IMG_DIR_)),
                array('id' => 'kpswebp_form_' . ($i++), 'name' => $this->l('Stores'), 'path' => _PS_STORE_IMG_DIR_), // 'count' => $this->countWebPImages(_PS_STORE_IMG_DIR_)),
            ), $process);
            if (defined('_PS_SCENE_IMG_DIR_')) {
                $process = array_merge(array(
                    array('id' => 'kpswebp_form_' . ($i++), 'name' => $this->l('Scenes'), 'path' => _PS_SCENE_IMG_DIR_), // 'count' => $this->countWebPImages(_PS_SCENE_IMG_DIR_)),
                ), $process);
            }
        }
        $this->smarty->assign('dirs', $process);
        $this->smarty->assign('kpswebp_url_controller', $this->context->link->getModuleLink($this->name, 'redirect', array(
            'path_convert' => '_PATH_',
            'cmd' => '_CMD_',
            'idx' => '_IDX_',
        ), true));
        $html = $this->display(__FILE__, 'views/templates/admin/config.tpl');
        $ui_form = $this->display(__FILE__, 'views/templates/admin/prestui/ps-form.tpl');
        $ui_panel = $this->display(__FILE__, 'views/templates/admin/prestui/ps-panel.tpl');

        return sprintf($b64_riot, htmlentities($str . $html) . $ui_panel . $ui_form . $ui_alerts) . $ui_riot;
    }
    private function removeWebPImages($dir)
    {
        $dir = rtrim($dir, '/');
        if (is_dir($dir)) {
            $this->removeCache($dir);
            $dirs = scandir($dir);
            foreach ($dirs as $cdir) {
                if ($cdir != '.' && $cdir != '..') {
                    if (is_dir($dir . '/' . $cdir) && !is_link($dir . '/' . $cdir)) {
                        $this->removeWebPImages($dir . '/' . $cdir);
                    } else {
                        if (strstr($cdir, '.webp') !== false) {
                            unlink($dir . '/' . $cdir);
                        }
                    }
                }
            }
        }
    }
    private function isImage($filename)
    {
        $mimetype = false;
        if (function_exists('exif_imagetype')) {
            $type = @exif_imagetype($filename);
            if (!$type) {
                return false;
            }
        }
        if (function_exists('finfo_open')) {
            $finfo = @finfo_open(FILEINFO_MIME_TYPE);
            $mimetype = @finfo_file($finfo, $filename);
        }
        if (!$mimetype && function_exists('mime_content_type')) {
            $mimetype = @mime_content_type($filename);
        }
        if (!$mimetype && function_exists('getimagesize')) { //Muy Lento!...
            $s = @getimagesize($filename);
            if (!$s || !$s[0] || !$s[1]) {
                return false;
            }
            if (isset($s['mime'])) {
                $mimetype = $s['mime'];
            }
        }
        return $mimetype && substr($mimetype, 0, 6) == 'image/';
    }

    private function removeCache($dir)
    {
        self::log('Init removeCache: ' . $dir);
        $dir = preg_replace('/\\/+/', '/', $dir);
        $dir = rtrim($dir, '/');
        if (!is_dir($dir) && file_exists($dir)) {
            $dir = dirname($dir);
            self::log('Init2.1 removeCache: ' . $dir);
        }
        self::log('Init2.2 removeCache: ' . $dir);
        if (is_dir($dir)) {
            //self::setCache('cc1_'.trim($dir, '/'), false);
            //self::log('Init3 removeCache: cc1_'.trim($dir, '/'));
            //for ($i = 0; $i < $this->config['threads']; ++$i) {
            //    self::setCache('c6_'.$this->config['threads'].'_'.$i.'_'.trim($dir, '/'), false);
            //    self::log('Init4 removeCache: c6_'.$this->config['threads'].'_'.$i.'_'.trim($dir, '/'));
            //}
            $all = explode('/', $dir);
            self::log('Init3.2 removeCache: ' . print_r($all, true));
            $base = '/';
            foreach ($all as $c) {
                $base .= $c;
                $base = trim(preg_replace('/\\/+/', '/', $base), '/');
                if (!empty($base)) {
                    self::setCache('cc1_' . trim($base, '/'), false);
                    self::log('Init5 removeCache: cc1_' . trim($base, '/'));
                    for ($i = 0; $i < $this->config['threads']; ++$i) {
                        self::setCache('c6_' . $this->config['threads'] . '_' . $i . '_' . trim($base, '/'), false);
                        self::log('Init5 removeCache: c6_' . $this->config['threads'] . '_' . $i . '_' . trim($base, '/'));
                    }
                }
                $base .= '/';
            }
        }
    }

    private function countWebPImages($dir)
    {
        if ((time() - KPSWebP::$init_time) >= KPSWebP::$max_time) {
            //die('<script>location.reload(true);</script>');
        }
        $current = array(
            'total_images' => 0,
            'total_webp' => 0,
            'total_wait' => 0,
        );
        $dir = preg_replace('/\\/+/', '/', $dir);
        if (is_dir($dir)) {
            $cache_id = 'cc1_' . trim($dir, '/');
            $count = self::getCache($cache_id);
            if ($count) {
                return $count;
            }
            $dirs = scandir($dir);
            foreach ($dirs as $cdir) {
                if ($cdir != '.' && $cdir != '..') {
                    if (is_dir($dir . '/' . $cdir) && !is_link($dir . '/' . $cdir)) {
                        $result = $this->countWebPImages($dir . '/' . $cdir);
                        $current['total_images'] += $result['total_images'];
                        $current['total_webp'] += $result['total_webp'];
                        $current['total_wait'] += $result['total_wait'];
                    } else {
                        //$parts = explode('.', $cdir);
                        //$ext = strtolower(end($parts));
                        $ext = strtolower(substr($cdir, -4));
                        if (in_array($ext, array('.jpg', 'jpeg', '.png'))) {
                            if (filesize($dir . '/' . $cdir) > 128/*  && $this->isImage($dir.'/'.$cdir)  */) {
                                ++$current['total_images'];
                                if (file_exists($dir . '/' . $cdir . '.webp')) {
                                    ++$current['total_webp'];
                                } else {
                                    ++$current['total_wait'];
                                }
                            } else {
                                //@rename($dir.'/'.$cdir, $dir.'/'.$cdir.'.bk_yipiapp_invalid_image');
                            }
                        }
                    }
                }
            }
            if ($current['total_wait'] == 0) {
                self::setCache($cache_id, $current, 15 * 24 * 3600);
            }
        }
        return $current;
    }
    private function generateThreadConvert($dir, $idx, $tidx, &$options, &$max_files)
    {
        $dir = rtrim($dir, '/');
        $current = array(
            'total_images' => 0,
            'total_webp' => 0,
            'total_wait' => 0,
            'total_error' => 0,
            'file_with_error' => []
        );
        if (is_dir($dir)) {
            $task = 0;
            return $this->convertWebPImages($dir, $options, $max_files, $task, $idx, $tidx);
        }
        return $current;
    }
    private function convertWebPImages($dir, &$options, &$max_files, &$task, $idx, $tidx)
    {
        $dir = rtrim($dir, '/');
        $dir = preg_replace('/\\/+/', '/', $dir);
        $current = array(
            'total_images' => 0,
            'total_webp' => 0,
            'total_wait' => 0,
            'total_error' => 0,
            'total_task' => 0,
            'file_with_error' => []
        );
        if ($max_files <= 0) {
            ++$current['total_images'];
            ++$current['total_wait'];
            return $current;
        }
        if (is_dir($dir)) {
            $cache_id = 'c6_' . $tidx . '_' . $idx . '_' . trim($dir, '/');
            $count = self::getCache($cache_id);
            if ($count) {
                $task += $count['total_task'];
                return $count;
            }
            $dirs = scandir($dir);
            $c_files = 0;
            foreach ($dirs as $cdir) {
                if ($cdir != '.' && $cdir != '..') {
                    if (is_dir($dir . '/' . $cdir) && !is_link($dir . '/' . $cdir)) {
                        if ($idx == -1) {
                            continue;
                        }
                        $result = $this->convertWebPImages($dir . '/' . $cdir, $options, $max_files, $task, $idx, $tidx);
                        $current['total_images'] += $result['total_images'];
                        $current['total_webp'] += $result['total_webp'];
                        $current['total_wait'] += $result['total_wait'];
                        $current['total_error'] += $result['total_error'];
                        //$current['total_task'] += $result['total_task'];
                        $current['file_with_error'] = array_merge($result['file_with_error'], $current['file_with_error']);
                    } else {
                        //$parts = explode('.', $cdir);
                        $ext = strtolower(substr($cdir, -4)); //strtolower(end($parts));
                        if (in_array($ext, array('.jpg', 'jpeg', '.png')) && ($fsize = filesize($dir . '/' . $cdir)) > 128) {
                            $task++;
                            $c_files++;
                            //$current['total_task']++;
                            if ($idx == -1 || (($fsize % $tidx) == $idx)) {
                                ++$current['total_images'];
                                if (file_exists($dir . '/' . $cdir . '.webp')) {
                                    ++$current['total_webp'];
                                } elseif ($max_files > 0) { //&& ((time() - KPSWebP::$init_time) < KPSWebP::$max_time)) {
                                    try {
                                        $this->removeCache($dir);
                                        \WebPConvert\Convert\Converters\Stack::convert($dir . '/' . $cdir, $dir . '/' . $cdir . '.webp', $options);
                                    } catch (\Exception $e) {
                                    }
                                    if (file_exists($dir . '/' . $cdir . '.webp')) {
                                        ++$current['total_webp'];
                                        --$max_files;
                                    } else {
                                        @copy($dir . '/' . $cdir, $dir . '/' . $cdir . '.webp');
                                        if (file_exists($dir . '/' . $cdir . '.webp')) {
                                            ++$current['total_webp'];
                                            //--$max_files;
                                        } else {
                                            self::log('Error converting: ' . $dir . '/' . $cdir);
                                            $current['file_with_error'][] = $dir . '/' . $cdir;
                                            ++$current['total_wait'];
                                            ++$current['total_error'];
                                        }
                                    }
                                } else {
                                    ++$current['total_wait'];
                                    return $current;
                                }
                            }
                        }
                    }
                    if ($max_files <= 0 && $current['total_wait'] > 0) {
                        return $current;
                    }
                }
            }
            if ($current['total_wait'] == 0 && $current['total_error'] == 0) {
                self::setCache($cache_id, $current);
            }
        }
        return $current;
    }
    public static function log($data)
    {
        //if (!isset(self::$config['debug']) || !self::$config['debug']) {
        return;
        //}
        if (!is_dir(_PS_MODULE_DIR_ . 'kpswebp/logs')) {
            @mkdir(_PS_MODULE_DIR_ . 'kpswebp/logs');
        }

        if (!is_dir(_PS_MODULE_DIR_ . 'kpswebp/logs/' . date('Y-m'))) {
            @mkdir(_PS_MODULE_DIR_ . 'kpswebp/logs/' . date('Y-m'));
        }

        $fp = fopen(_PS_MODULE_DIR_ . 'kpswebp/logs/' . date('Y-m') . '/log-' . date('Y-m-d') . '.log', 'a');

        fwrite($fp, "\n----- " . date('Y-m-d H:i:s') . " -----\n");
        fwrite($fp, $data);
        fclose($fp);
    }
    public function runControllerRedirect()
    {
        static $checked_exec = null;
        $cmd = Tools::getValue('cmd');
        $path = Tools::getValue('path_convert');
        if ($cmd == 'countTotal') {
            echo json_encode($this->countWebPImages($path));
            exit;
        }
        $idx = (int) Tools::getValue('idx');
        $force_threads = (int) Tools::getValue('force_threads');
        if ($force_threads > 0) {
            $tidx = max(1, min(4, (int) $force_threads));
        } else {
            $tidx = max(1, min(4, (int) $this->config['threads']));
        }
        $id_shop = Shop::getContextShopID();
        $id_shop_group = Shop::getContextShopGroupID();
        $lic = Configuration::get(
            'PS_MODULE_INSTALLED_KWP',
            null,
            $id_shop_group,
            $id_shop
        );
        if (strtotime($lic) < 1000) {
            echo json_encode(array(
                'total_images' => 1,
                'total_webp' => 0,
                'total_wait' => 0,
                'total_error' => 1,
            ));
            exit;
        }
        if ($cmd == 'delete') {
            $this->removeWebPImages($path);
            echo json_encode(array('error' => false));
        } else {
            $options = [
                'converters' => [
                    'cwebp', 'vips', 'imagick', 'gmagick', 'imagemagick', 'graphicsmagick', 'gd',
                ],
                'png' => [
                    'encoding' => 'auto', /* Try both lossy and lossless and pick smallest */
                    'near-lossless' => 60, /* The level of near-lossless image preprocessing (when trying lossless) */
                    'quality' => (int) max(10, min(95, $this->config['quality'] + 10)), /* Quality when trying lossy. It is set high because pngs is often selected to ensure high quality */
                    'sharp-yuv' => true,
                ],
                'jpeg' => [
                    'encoding' => 'auto', /* If you are worried about the longer conversion time, you could set it to "lossy" instead (lossy will often be smaller than lossless for jpegs) */
                    'quality' => (int) max(10, min(95, $this->config['quality'])), /* Quality when trying lossy. It is set a bit lower for jpeg than png */
                    'auto-limit' => true, /* Prevents using a higher quality than that of the source (requires imagick or gmagick extension, not necessarily compiled with webp) */
                    'sharp-yuv' => true,
                ],
            ];
            if ($checked_exec === true || $checked_exec === null && (!function_exists('exec') || @exec('echo EXEC') != 'EXEC')) {
                $checked_exec = true;
                $options['converters'] = [
                    'vips', 'imagick', 'gmagick', 'imagemagick', 'graphicsmagick', 'gd',
                ];
            } else {
                $checked_exec = false;
            }
            if (!empty($this->config['ewww'])) {
                $options['converters'] = [
                    'ewww',
                ];
                $options['ewww-api-key'] = $this->config['ewww'];
            }
            echo json_encode($this->generateThreadConvert($path, $idx, $tidx, $options, $this->config['max_convert_by_request']));
        }
        exit;
    }
    public function uninstall()
    {
        $r = parent::uninstall();
        if ($r) {
            Db::getInstance()->Execute('DROP TABLE IF EXISTS `' . bqSQL(_DB_PREFIX_) . 'kpswebp_cache`');
            if (file_exists(_PS_ROOT_DIR_ . '/var/cache/dev/class_index.php')) {
                unlink(_PS_ROOT_DIR_ . '/var/cache/dev/class_index.php');
            }
            if (file_exists(_PS_ROOT_DIR_ . '/var/cache/prod/class_index.php')) {
                unlink(_PS_ROOT_DIR_ . '/var/cache/prod/class_index.php');
            }
            if (file_exists(_PS_ROOT_DIR_ . '/cache/class_index.php')) {
                unlink(_PS_ROOT_DIR_ . '/cache/class_index.php');
            }
            Tools::generateHtaccess();
            Configuration::deleteByName($this->name . 'c_config');
            $process = array(
                array('type' => 'categories', 'dir' => _PS_CAT_IMG_DIR_),
                array('type' => 'manufacturers', 'dir' => _PS_MANU_IMG_DIR_),
                array('type' => 'suppliers', 'dir' => _PS_SUPP_IMG_DIR_),
                array('type' => 'products', 'dir' => _PS_PROD_IMG_DIR_),
                array('type' => 'stores', 'dir' => _PS_STORE_IMG_DIR_),
            );
            if (defined('_PS_SCENE_IMG_DIR_')) {
                $process[] = array('type' => 'scenes', 'dir' => _PS_SCENE_IMG_DIR_);
            }
            foreach ($process as $proc) {
                $this->removeWebPImages($proc['dir']);
            }
        }
        return $r;
    }
    public function generateHtaccess($path = null, $rewrite_settings = null, $cache_control = null, $specific = '', $disable_multiviews = null, $medias = false, $disable_modsec = null)
    {
        if (defined('_PS_IN_TEST_')
            || (defined('PS_INSTALLATION_IN_PROGRESS') && $rewrite_settings === null)
        ) {
            return true;
        }
        if (!isset($this->config['htaccess']) || !(bool) $this->config['htaccess']) {
            return false;
        }
        if (null === $path) {
            $path = _PS_ROOT_DIR_ . '/.htaccess';
        }
        if (null === $cache_control) {
            $cache_control = (int) Configuration::get('PS_HTACCESS_CACHE_CONTROL');
        }
        if (null === $disable_multiviews) {
            $disable_multiviews = (bool) Configuration::get('PS_HTACCESS_DISABLE_MULTIVIEWS');
        }
        if ($disable_modsec === null) {
            $disable_modsec = (int) Configuration::get('PS_HTACCESS_DISABLE_MODSEC');
        }
        $specific_before = $specific_after = '';
        if (file_exists($path)) {
            $fp = fopen($path, "r");
            $content = fread($fp, filesize($path));
            fclose($fp);
            if (preg_match('#^(.*)\# ~~start~~.*\# ~~end~~[^\n]*(.*)$#s', $content, $m)) {
                $specific_before = $m[1];
                $specific_after = $m[2];
            } else {
                if (preg_match('#\# http://www\.prestashop\.com - http://www\.prestashop\.com/forums\s*(.*)<IfModule mod_rewrite\.c>#si', $content, $m)) {
                    $specific_before = $m[1];
                } else {
                    $specific_before = $content;
                }
            }
        }
        if (!$write_fd = @fopen($path, 'wb')) {
            return false;
        }
        if ($specific_before) {
            fwrite($write_fd, trim($specific_before) . "\n\n");
        }
        $domains = Tools::getDomains();
        fwrite($write_fd, "# ~~start~~ Do not remove this comment, Prestashop will keep automatically the code outside this comment when .htaccess will be generated again\n");
        fwrite($write_fd, "# .htaccess automaticaly generated by PrestaShop e-commerce open-source solution\n");
        fwrite($write_fd, "# http://www.prestashop.com - http://www.prestashop.com/forums\n\n");
        if ($disable_modsec) {
            fwrite($write_fd, "<IfModule mod_security.c>\nSecFilterEngine Off\nSecFilterScanPOST Off\n</IfModule>\n\n");
        }
        fwrite($write_fd, "<IfModule mod_rewrite.c>\n");
        fwrite($write_fd, "<IfModule mod_env.c>\n");
        fwrite($write_fd, "SetEnv HTTP_MOD_REWRITE On\n");
        fwrite($write_fd, "</IfModule>\n\n");
        if ($disable_multiviews) {
            fwrite($write_fd, "\n# Disable Multiviews\nOptions -Multiviews\n\n");
        }
        fwrite($write_fd, "RewriteEngine on\n");
        if (!$medias && Configuration::getMultiShopValues('PS_MEDIA_SERVER_1')
            && Configuration::getMultiShopValues('PS_MEDIA_SERVER_2')
            && Configuration::getMultiShopValues('PS_MEDIA_SERVER_3')
        ) {
            $medias = array(
                Configuration::getMultiShopValues('PS_MEDIA_SERVER_1'),
                Configuration::getMultiShopValues('PS_MEDIA_SERVER_2'),
                Configuration::getMultiShopValues('PS_MEDIA_SERVER_3'),
            );
        }
        $media_domains = '';
        foreach ($medias as $media) {
            foreach ($media as $media_url) {
                if ($media_url) {
                    $media_domains .= 'RewriteCond %{HTTP_HOST} ^' . $media_url . '$ [OR]' . PHP_EOL;
                }
            }
        }
        if (Configuration::get('PS_WEBSERVICE_CGI_HOST')) {
            fwrite($write_fd, "RewriteCond %{HTTP:Authorization} ^(.*)\nRewriteRule . - [E=HTTP_AUTHORIZATION:%1]\n\n");
        }
        foreach ($domains as $domain => $list_uri) {
            $domain = str_replace(['[', ']'], ['\[', '\]'], $domain);
            foreach ($list_uri as $uri) {
                fwrite($write_fd, PHP_EOL . PHP_EOL . '#Domain: ' . $domain . PHP_EOL);
                if (Shop::isFeatureActive()) {
                    fwrite($write_fd, 'RewriteCond %{HTTP_HOST} ^' . $domain . '$' . PHP_EOL);
                }
                fwrite($write_fd, 'RewriteRule . - [E=REWRITEBASE:' . $uri['physical'] . ']' . PHP_EOL);
                fwrite($write_fd, 'RewriteRule ^api(?:/(.*))?$ %{ENV:REWRITEBASE}webservice/dispatcher.php?url=$1 [QSA,L]' . "\n\n");
                if (!$rewrite_settings) {
                    $rewrite_settings = (int) Configuration::get('PS_REWRITING_SETTINGS', null, null, (int) $uri['id_shop']);
                }
                $domain_rewrite_cond = 'RewriteCond %{HTTP_HOST} ^' . $domain . '$' . PHP_EOL;
                if ($uri['virtual']) {
                    if (!$rewrite_settings) {
                        fwrite($write_fd, $media_domains);
                        fwrite($write_fd, $domain_rewrite_cond);
                        fwrite($write_fd, 'RewriteRule ^' . trim($uri['virtual'], '/') . '/?$ ' . $uri['physical'] . $uri['virtual'] . "index.php [L,R]\n");
                    } else {
                        fwrite($write_fd, $media_domains);
                        fwrite($write_fd, $domain_rewrite_cond);
                        fwrite($write_fd, 'RewriteRule ^' . trim($uri['virtual'], '/') . '$ ' . $uri['physical'] . $uri['virtual'] . " [L,R]\n");
                    }
                    fwrite($write_fd, $media_domains);
                    fwrite($write_fd, $domain_rewrite_cond);
                    fwrite($write_fd, 'RewriteRule ^' . ltrim($uri['virtual'], '/') . '(.*) ' . $uri['physical'] . "$1 [L]\n\n");
                }
                fwrite($write_fd, PHP_EOL . PHP_EOL . "# Images WebP by Yipi.app.com" . PHP_EOL);

                /*
                fwrite($write_fd, $media_domains);
                fwrite($write_fd, $domain_rewrite_cond);
                fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp'.PHP_EOL);
                fwrite($write_fd, 'RewriteCond %{REQUEST_FILENAME}.webp -f'.PHP_EOL);
                fwrite($write_fd, 'RewriteRule ^(.+)(\.jpg|\.jpeg|\.png|\.JPG|\.JPEG|\.PNG)$ $1$2.webp [L]'.PHP_EOL);*/

                fwrite($write_fd, $media_domains);
                fwrite($write_fd, $domain_rewrite_cond);
                fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp' . PHP_EOL);
                fwrite($write_fd, 'RewriteCond %{REQUEST_FILENAME}.webp -f' . PHP_EOL);
                fwrite($write_fd, 'RewriteCond %{HTTPS} on' . PHP_EOL);
                fwrite($write_fd, 'RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}.webp [R=301,L]' . PHP_EOL);

                fwrite($write_fd, $media_domains);
                fwrite($write_fd, $domain_rewrite_cond);
                fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp' . PHP_EOL);
                fwrite($write_fd, 'RewriteCond %{REQUEST_FILENAME}.webp -f' . PHP_EOL);
                fwrite($write_fd, 'RewriteCond %{HTTPS} off' . PHP_EOL);
                fwrite($write_fd, 'RewriteRule (.*) http://%{HTTP_HOST}%{REQUEST_URI}.webp [R=301,L]' . PHP_EOL);

                if (Configuration::get('PS_LEGACY_IMAGES')) {
                    fwrite($write_fd, $media_domains);
                    fwrite($write_fd, $domain_rewrite_cond);
                    fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp' . PHP_EOL);
                    fwrite($write_fd, 'RewriteRule ^([a-z0-9]+)\-([a-z0-9]+)(\-[_a-zA-Z0-9-]*)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/p/$1-$2$3$4.jpg.webp [L]' . PHP_EOL);

                    fwrite($write_fd, $media_domains);
                    fwrite($write_fd, $domain_rewrite_cond);
                    fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp' . PHP_EOL);
                    fwrite($write_fd, 'RewriteRule ^([0-9]+)\-([0-9]+)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/p/$1-$2$3.jpg.webp [L]' . PHP_EOL);
                }
                for ($i = 1; $i <= 8; ++$i) {
                    $img_path = $img_name = '';
                    for ($j = 1; $j <= $i; ++$j) {
                        $img_path .= '$' . $j . '/';
                        $img_name .= '$' . $j;
                    }
                    $img_name .= '$' . $j;
                    fwrite($write_fd, $media_domains);
                    fwrite($write_fd, $domain_rewrite_cond);
                    fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp' . PHP_EOL);
                    fwrite($write_fd, 'RewriteRule ^' . str_repeat('([0-9])', $i) . '(\-[_a-zA-Z0-9-]*)?(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/p/' . $img_path . $img_name . '$' . ($j + 1) . ".jpg.webp [L]\n");
                }

                fwrite($write_fd, $media_domains);
                fwrite($write_fd, $domain_rewrite_cond);
                fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp' . PHP_EOL);
                fwrite($write_fd, 'RewriteRule ^c/([0-9]+)(\-[\.*_a-zA-Z0-9-]*)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/c/$1$2$3.jpg.webp [L]' . PHP_EOL);

                fwrite($write_fd, $media_domains);
                fwrite($write_fd, $domain_rewrite_cond);
                fwrite($write_fd, 'RewriteCond %{HTTP_ACCEPT} image/webp' . PHP_EOL);
                fwrite($write_fd, 'RewriteRule ^c/([a-zA-Z_-]+)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/c/$1$2.jpg.webp [L]' . PHP_EOL);

                if ($rewrite_settings) {
                    fwrite($write_fd, PHP_EOL . PHP_EOL . "# Original Images Rules\n");
                    if (Configuration::get('PS_LEGACY_IMAGES')) {
                        fwrite($write_fd, $media_domains);
                        fwrite($write_fd, $domain_rewrite_cond);
                        fwrite($write_fd, 'RewriteRule ^([a-z0-9]+)\-([a-z0-9]+)(\-[_a-zA-Z0-9-]*)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/p/$1-$2$3$4.jpg [L]' . PHP_EOL);
                        fwrite($write_fd, $media_domains);
                        fwrite($write_fd, $domain_rewrite_cond);
                        fwrite($write_fd, 'RewriteRule ^([0-9]+)\-([0-9]+)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/p/$1-$2$3.jpg [L]' . PHP_EOL);
                    }
                    for ($i = 1; $i <= 8; ++$i) {
                        $img_path = $img_name = '';
                        for ($j = 1; $j <= $i; ++$j) {
                            $img_path .= '$' . $j . '/';
                            $img_name .= '$' . $j;
                        }
                        $img_name .= '$' . $j;
                        fwrite($write_fd, $media_domains);
                        fwrite($write_fd, $domain_rewrite_cond);
                        fwrite($write_fd, 'RewriteRule ^' . str_repeat('([0-9])', $i) . '(\-[_a-zA-Z0-9-]*)?(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/p/' . $img_path . $img_name . '$' . ($j + 1) . ".jpg [L]\n");
                    }
                    fwrite($write_fd, $media_domains);
                    fwrite($write_fd, $domain_rewrite_cond);
                    fwrite($write_fd, 'RewriteRule ^c/([0-9]+)(\-[\.*_a-zA-Z0-9-]*)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/c/$1$2$3.jpg [L]' . PHP_EOL);
                    fwrite($write_fd, $media_domains);
                    fwrite($write_fd, $domain_rewrite_cond);
                    fwrite($write_fd, 'RewriteRule ^c/([a-zA-Z_-]+)(-[0-9]+)?/.+\.jpg$ %{ENV:REWRITEBASE}img/c/$1$2.jpg [L]' . PHP_EOL);
                }
                fwrite($write_fd, "# AlphaImageLoader for IE and fancybox\n");
                if (Shop::isFeatureActive()) {
                    fwrite($write_fd, $domain_rewrite_cond);
                }
                fwrite($write_fd, 'RewriteRule ^images_ie/?([^/]+)\.(jpe?g|png|gif)$ js/jquery/plugins/fancybox/images/$1.$2 [L]' . PHP_EOL);
            }
            if ($rewrite_settings) {
                fwrite($write_fd, "\n# Dispatcher\n");
                fwrite($write_fd, "RewriteCond %{REQUEST_FILENAME} -s [OR]\n");
                fwrite($write_fd, "RewriteCond %{REQUEST_FILENAME} -l [OR]\n");
                fwrite($write_fd, "RewriteCond %{REQUEST_FILENAME} -d\n");
                if (Shop::isFeatureActive()) {
                    fwrite($write_fd, $domain_rewrite_cond);
                }
                fwrite($write_fd, "RewriteRule ^.*$ - [NC,L]\n");
                if (Shop::isFeatureActive()) {
                    fwrite($write_fd, $domain_rewrite_cond);
                }
                fwrite($write_fd, "RewriteRule ^.*\$ %{ENV:REWRITEBASE}index.php [NC,L]\n");
            }
        }
        fwrite($write_fd, "</IfModule>\n\n");
        fwrite($write_fd, "AddType application/vnd.ms-fontobject .eot\n");
        fwrite($write_fd, "AddType font/ttf .ttf\n");
        fwrite($write_fd, "AddType image/webp .webp\n");
        fwrite($write_fd, "AddType font/otf .otf\n");
        fwrite($write_fd, "AddType application/font-woff .woff\n");
        fwrite($write_fd, "AddType font/woff2 .woff2\n");
        fwrite($write_fd, "<IfModule mod_headers.c>
    <FilesMatch \"\.(ttf|ttc|otf|eot|woff|woff2|svg)$\">
        Header set Access-Control-Allow-Origin \"*\"
    </FilesMatch>
</IfModule>\n\n");
        if ($cache_control) {
            $cache_control = "<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType image/gif \"access plus 1 month\"
    ExpiresByType image/jpeg \"access plus 1 month\"
    ExpiresByType image/png \"access plus 1 month\"
    ExpiresByType image/webp \"access plus 1 month\"
    ExpiresByType text/css \"access plus 1 week\"
    ExpiresByType text/javascript \"access plus 1 week\"
    ExpiresByType application/javascript \"access plus 1 week\"
    ExpiresByType application/x-javascript \"access plus 1 week\"
    ExpiresByType image/x-icon \"access plus 1 year\"
    ExpiresByType image/svg+xml \"access plus 1 year\"
    ExpiresByType image/vnd.microsoft.icon \"access plus 1 year\"
    ExpiresByType application/font-woff \"access plus 1 year\"
    ExpiresByType application/x-font-woff \"access plus 1 year\"
    ExpiresByType font/woff2 \"access plus 1 year\"
    ExpiresByType application/vnd.ms-fontobject \"access plus 1 year\"
    ExpiresByType font/opentype \"access plus 1 year\"
    ExpiresByType font/ttf \"access plus 1 year\"
    ExpiresByType font/otf \"access plus 1 year\"
    ExpiresByType application/x-font-ttf \"access plus 1 year\"
    ExpiresByType application/x-font-otf \"access plus 1 year\"
</IfModule>
<IfModule mod_headers.c>
    Header unset Etag
</IfModule>
FileETag none
<IfModule mod_deflate.c>
    <IfModule mod_filter.c>
        AddOutputFilterByType DEFLATE text/html text/css text/javascript application/javascript application/x-javascript font/ttf application/x-font-ttf font/otf application/x-font-otf font/opentype image/svg+xml
    </IfModule>
</IfModule>\n\n";
            fwrite($write_fd, $cache_control);
        }
        fwrite($write_fd, "#If rewrite mod isn't enabled\n");
        reset($domains);
        $domain = current($domains);
        fwrite($write_fd, 'ErrorDocument 404 ' . $domain[0]['physical'] . "index.php?controller=404\n\n");
        fwrite($write_fd, '# ~~end~~ Do not remove this comment, Prestashop will keep automatically the code outside this comment when .htaccess will be generated again');
        if ($specific_after) {
            fwrite($write_fd, "\n\n" . trim($specific_after));
        }
        fclose($write_fd);
        if (!defined('PS_INSTALLATION_IN_PROGRESS')) {
            Hook::exec('actionHtaccessCreate');
        }
        return true;
    }
    public function resize(
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
        static $checked_exec = null;
        $id_shop = Shop::getContextShopID();
        $id_shop_group = Shop::getContextShopGroupID();
        $lic = Configuration::get(
            'PS_MODULE_INSTALLED_KWP',
            null,
            $id_shop_group,
            $id_shop
        );
        $this->removeCache(realpath($dst_file));
        if (strtotime($lic) < 1000) {
            return ImageManager::coreResize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type, $error, $tgt_width, $tgt_height, $quality, $src_width, $src_height);
        }
        if (!file_exists($src_file)) {
            return ImageManager::coreResize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type, $error, $tgt_width, $tgt_height, $quality, $src_width, $src_height);
        }
        if (mime_content_type($src_file) == 'image/webp') {
            $im = imagecreatefromwebp($src_file);
            imagepng($im, $src_file, 9);
            imagedestroy($im);
        }
        $r = ImageManager::coreResize($src_file, $dst_file, $dst_width, $dst_height, $file_type, $force_type, $error, $tgt_width, $tgt_height, $quality, $src_width, $src_height);
        if ($r) {
            $options = [
                'converters' => [
                    'cwebp', 'vips', 'imagick', 'gmagick', 'imagemagick', 'graphicsmagick', 'gd',
                ],
                'png' => [
                    'encoding' => 'auto', /* Try both lossy and lossless and pick smallest */
                    'near-lossless' => 60, /* The level of near-lossless image preprocessing (when trying lossless) */
                    'quality' => (int) max(10, min(95, $this->config['quality'] + 10)), /* Quality when trying lossy. It is set high because pngs is often selected to ensure high quality */
                    'sharp-yuv' => true,
                ],
                'jpeg' => [
                    'encoding' => 'auto', /* If you are worried about the longer conversion time, you could set it to "lossy" instead (lossy will often be smaller than lossless for jpegs) */
                    'quality' => (int) max(10, min(95, $this->config['quality'])), /* Quality when trying lossy. It is set a bit lower for jpeg than png */
                    'auto-limit' => true, /* Prevents using a higher quality than that of the source (requires imagick or gmagick extension, not necessarily compiled with webp) */
                    'sharp-yuv' => true,
                ],
            ];
            if ($checked_exec === true || $checked_exec === null && (!function_exists('exec') || @exec('echo EXEC') != 'EXEC')) {
                $checked_exec = true;
                $options['converters'] = [
                    'vips', 'imagick', 'gmagick', 'imagemagick', 'graphicsmagick', 'gd',
                ];
            } else {
                $checked_exec = false;
            }
            if (!empty($this->config['ewww'])) {
                $options['converters'] = [
                    'ewww',
                ];
                $options['ewww-api-key'] = $this->config['ewww'];
            }
            try {
                \WebPConvert\Convert\Converters\Stack::convert($dst_file, $dst_file . '.webp', $options);
            } catch (\Exception $e) {
            }
            if (!file_exists($dst_file . '.webp')) {
                return !($error = 1);
            }
        }
        return $r;
    }
}
