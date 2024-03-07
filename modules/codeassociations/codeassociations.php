<?php
/**
 * 2007-2022 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 *  @author    PrestaShop SA <contact@prestashop.com>
 *  @copyright 2007-2022 PrestaShop SA
 *  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

if (file_exists(_PS_MODULE_DIR_ . 'codeassociations/vendor/autoload.php')) {
    require_once _PS_MODULE_DIR_ . 'codeassociations/vendor/autoload.php';
}
use Mbigard\Codeassociations\Classes\Association;
use Mbigard\Codeassociations\Repository;

include_once dirname(__FILE__) . '/classes/AssociationModel.php';
class Codeassociations extends Module
{
    /**
     * @param array $tabs
     */
    public $tabs = [];

    /**
     * @param Weplus\Lgcfgestionexpert\Repository $repository
     */
    protected $repository;

    protected $config_form = "config-global";

    public function __construct()
    {
        $this->name = 'codeassociations';
        $this->tab = 'administration';
        $this->version = '1.0.0';
        $this->author = 'Maxime BIGARD';
        $this->need_instance = 0;

        /**
         * Set $this->bootstrap to true if your module is compliant with bootstrap (PrestaShop 1.6)
         */
        $this->bootstrap = true;

        $this->tabs = array(
            array(
                'name' => $this->l('Gestion codes associations'),
                'class_name' => 'AdminCodesAssociation',
                'parent' => 'AdminCatalog',
            ),
        );

        $this->repository = new Repository($this);

        parent::__construct();

        $this->displayName = $this->l('Gestion des codes associations');
        $this->description = $this->l('Gestion des codes association');

        $this->ps_versions_compliancy = array('min' => '1.6', 'max' => _PS_VERSION_);

    }

    public function hookActionFrontControllerSetMedia()
    {
        /*$this->context->controller->registerStylesheet(
            'front-css',
            'modules/' . $this->name . '/views/css/front.css'
        );*/
        $this->context->controller->registerJavascript(
            'front-js',
            'modules/' . $this->name . '/views/js/codeassociations.js'
        );
    }

    /**
     * Don't forget to create update methods if needed:
     * http://doc.prestashop.com/display/PS16/Enabling+the+Auto-Update
     */
    public function install()
    {
        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        return parent::install() && $this->repository->install();
    }

    public function uninstall()
    {
        return parent::uninstall() && $this->repository->uninstall();
    }

    public function hookDisplayFrontCodeAssociations()
    {
        $idCode = 0;
        $code = '';
        if ((int)$this->context->cart->id) {
            $idCode = Db::getInstance()->getValue('SELECT `id_code_association` from '._DB_PREFIX_.'cart where id_cart='.pSQL((int)$this->context->cart->id));

            if (!empty($idCode)) {
                $code = Db::getInstance()->getValue('SELECT `code` from `'._DB_PREFIX_ . 'mb_associations` where id_association='.pSQL($idCode));
            }
        }

        $this->context->smarty->assign(array(
            'urlAjax' => Context::getContext()->link->getModuleLink('codeassociations', 'validation', array('ajax'=>true)),
            'code' => $code
        ));

        return $this->display(__FILE__, 'views/templates/hook/displayCodeAssociations.tpl');
    }

    public function getContent()
    {
        if (Tools::isSubmit('submitModule')) {
            Configuration::updateValue('CODE_ASSOCIATIONS_DEFAULT_PERCENTAGE', Tools::getValue('default_percentage', ''));

            Tools::redirectAdmin($this->context->link->getAdminLink('AdminModules') . '&configure=' . $this->name . '&tab_module=' . $this->tab . '&conf=4&module_name=' . $this->name);
        }

        return $this->renderForm();
    }

    
    public function renderForm()
    {
        $fields_form = [];
        $fields_form[]['form'] = array(
            'tinymce' => true,
            'legend' => array(
                'title' => $this->trans('Configuration Freedone', array(), 'Admin.Global'),
                'icon' => 'icon-cogs'
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->trans('Pourcentage à l\association freedone', array(), 'Modules.Socialfollow.Admin'),
                    'name' => 'default_percentage',
                    'desc' => 'Exemple : écrire 5 pour 5% ne pas mettre le % juste le nombre'
                ),
            ),
            'submit' => array(
                'title' => $this->trans('Save', array(), 'Admin.Global'),
            )
        );



        $helper = new HelperForm();
        $helper->show_toolbar = false;
        $helper->table =  $this->table;
        $helper->submit_action = 'submitModule';
        $helper->tpl_vars = array(
            'fields_value' => $this->getConfigFieldsValues(),
        );

        return $helper->generateForm(($fields_form));
    }

    public function getConfigFieldsValues()
    {
        return array(
            'default_percentage' => Tools::getValue('default_percentage', Configuration::get('CODE_ASSOCIATIONS_DEFAULT_PERCENTAGE')),
        );
    }
}
