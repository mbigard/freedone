<?php
/**
 * Creative Elements - live PageBuilder [in-stock]
 *
 * @author    WebshopWorks
 * @copyright 2019-2022 WebshopWorks.com
 * @license   In-stock license
 */
defined('_PS_VERSION_') or die;
class Supplier extends SupplierCore
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
    public function __construct($id = null, $idLang = null)
    {
        parent::__construct($id, $idLang);
        $ctrl = Context::getContext()->controller;
        if ($ctrl instanceof SupplierController && !SupplierController::$initialized && !$this->active && Tools::getIsset('id_employee') && Tools::getIsset('adtoken')) {
            $tab = 'AdminSuppliers';
            if (Tools::getAdminToken($tab . (int) Tab::getIdFromClassName($tab) . (int) Tools::getValue('id_employee')) == Tools::getValue('adtoken')) {
                $this->active = 1;
            }
        }
    }
}
