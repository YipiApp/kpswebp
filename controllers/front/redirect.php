<?php
/**
* Modulo MercadoPago Pro
*
* @author    Yipi.app
* @copyright 2014 Yipi.app
* @license   Commercial use allowed (Non-assignable & non-transferable),
*            can modify source-code but cannot distribute modifications
*            (derivative works).
*/

/**
 * the name of the class should be [ModuleName][ControllerName]ModuleFrontController
 */
class KPSWebPRedirectModuleFrontController extends ModuleFrontController
{
    public function __construct()
    {
        parent::__construct();
        $this->context = Context::getContext();
    }
    /**
     * @see FrontController::initContent()
     */
    public function initContent()
    {
        parent::initContent();
        if (!isset($this->module->active) || !$this->module->active) {
            Tools::redirect('index');
            exit;
        }
        $this->module->runControllerRedirect();
    }
}
