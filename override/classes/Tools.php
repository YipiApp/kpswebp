<?php
/**
* Modulo WebP for Product Sheet
*
* @author    Yipi.app
* @copyright 2016 Yipi.app
* @license   Commercial use allowed (Non-assignable & non-transferable), can modify source-code but cannot distribute modifications (derivative works).
*/
class Tools extends ToolsCore
{
    public static function getDomains()
    {
        $domains = array();
        foreach (ShopUrl::getShopUrls() as $shop_url) {
            /** @var ShopUrl $shop_url */
            if (!isset($domains[$shop_url->domain])) {
                $domains[$shop_url->domain] = array();
            }
            $domains[$shop_url->domain][] = array(
                'physical' => $shop_url->physical_uri,
                'virtual' => $shop_url->virtual_uri,
                'id_shop' => $shop_url->id_shop,
            );
            if ($shop_url->domain == $shop_url->domain_ssl) {
                continue;
            }
            if (!isset($domains[$shop_url->domain_ssl])) {
                $domains[$shop_url->domain_ssl] = array();
            }
            $domains[$shop_url->domain_ssl][] = array(
                'physical' => $shop_url->physical_uri,
                'virtual' => $shop_url->virtual_uri,
                'id_shop' => $shop_url->id_shop,
            );
        }
        return $domains;
    }
    public static function coreGenerateHtaccess($path = null, $rewrite_settings = null, $cache_control = null, $specific = '', $disable_multiviews = null, $medias = false, $disable_modsec = null)
    {
        return ToolsCore::generateHtaccess($path, $rewrite_settings, $cache_control, $specific, $disable_multiviews, $medias, $disable_modsec);
    }
    public static function generateHtaccess($path = null, $rewrite_settings = null, $cache_control = null, $specific = '', $disable_multiviews = null, $medias = false, $disable_modsec = null)
    {
        $instance = Module::getInstanceByName('kpswebp');
        if (!$instance || !$instance->active) {
            return self::coreGenerateHtaccess($path, $rewrite_settings, $cache_control, $specific, $disable_multiviews, $medias, $disable_modsec);
        } else {
            if (!$instance->generateHtaccess($path, $rewrite_settings, $cache_control, $specific, $disable_multiviews, $medias, $disable_modsec)) {
                return self::coreGenerateHtaccess($path, $rewrite_settings, $cache_control, $specific, $disable_multiviews, $medias, $disable_modsec);
            }
            return true;
        }
    }
}
