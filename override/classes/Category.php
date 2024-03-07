<?php
/**
 * Creative Elements - live PageBuilder [in-stock]
 *
 * @author    WebshopWorks
 * @copyright 2019-2022 WebshopWorks.com
 * @license   In-stock license
 */
defined('_PS_VERSION_') or die;
class Category extends CategoryCore
{
    /*
    * module: creativeelements
    * date: 2023-12-05 15:12:08
    * version: 2.5.0
    */
    const CE_OVERRIDE = true;
    /*
    * module: creativeelements
    * date: 2023-12-05 15:12:08
    * version: 2.5.0
    */
    public function __construct($idCategory = null, $idLang = null, $idShop = null)
    {
        parent::__construct($idCategory, $idLang, $idShop);
        $ctrl = Context::getContext()->controller;
        if ($ctrl instanceof CategoryController && !CategoryController::$initialized && !$this->active && Tools::getIsset('id_employee') && Tools::getIsset('adtoken')) {
            $tab = 'AdminCategories';
            if (Tools::getAdminToken($tab . (int) Tab::getIdFromClassName($tab) . (int) Tools::getValue('id_employee')) == Tools::getValue('adtoken')) {
                $this->active = 1;
            }
        }
    }
}
