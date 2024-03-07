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

if(!class_exists('AssociationModel'));
    require_once _PS_MODULE_DIR_.'codeassociations/classes/AssociationModel.php';


class AdminCodesAssociationController extends ModuleAdminController {

    public function __construct()
    {
        $this->table = 'mb_associations';
        $this->className = 'AssociationModel';
        $this->lang = false;
        $this->bootstrap = true;

        $this->deleted = false;
        $this->allow_export = true;
        $this->list_id = 'associations';
        $this->identifier = 'id_association';
        $this->_defaultOrderBy = 'id_association';
        $this->_defaultOrderWay = 'ASC';
        $this->context = Context::getContext();

        $this->addRowAction('edit');
        $this->addRowAction('delete');

        if (Shop::isFeatureActive()) {
            Shop::setContext(Shop::CONTEXT_ALL);
        }

        parent::__construct();

        $this->bulk_actions = array(
            'delete' => array(
                'text' => $this->module->getTranslator()->trans('Delete selected', [], 'Modules.codeassociations.Codeassociation'),
                'icon' => 'icon-trash',
                'confirm' => $this->module->getTranslator()->trans('Delete selected items?', [], 'Modules.codeassociations.Codeassociation')
            )
        );

        $this->fields_list = array(
            'id_association'=>array(
                'title' => $this->module->getTranslator()->trans('ID', [], 'Modules.codeassociations.Codeassociation'),
                'align'=>'center',
                'class'=>'fixed-width-xs'
            ),
            'name' => array(
                'title' => $this->module->getTranslator()->trans('Nom de l\'association', [], 'Modules.codeassociations.Codeassociation'),
                'orderby' => false,
                'search' => false,
                'align' => 'center',
            ),
            'code' => array(
                'title' => $this->module->getTranslator()->trans('Code à utiliser', [], 'Modules.codeassociations.Codeassociation'),
                'width' => 'auto'
            ),
            'percentage' => array(
                'title' => $this->module->getTranslator()->trans('Pourcentage', [], 'Modules.codeassociations.Codeassociation'),
                'width' => 'auto'
            ),
        );
    }

    public function renderForm()
    {
        if (!($association = $this->loadObject(true))) {
            return;
        }
        
        $this->fields_form = array(
            'tinymce' => true,
            'legend' => array(
                'title' => $this->module->getTranslator()->trans('Lgcf Expert', [], 'Modules.codeassociations.Codeassociation'),
                'icon' => 'icon-certificate'
            ),
            'input' => array(
                array(
                    'type' => 'text',
                    'label' => $this->module->getTranslator()->trans('Nom de l\association', [], 'Modules.codeassociations.Codeassociation'),
                    'name' => 'name',
                    'lang'=>false,
                    'col' => 4,
                    'required' => true,
                    'hint' => $this->module->getTranslator()->trans('Invalid characters:', [], 'Modules.codeassociations.Codeassociation').' &lt;&gt;;=#{}'
                ),
                array(
                    'type' => 'text',
                    'label' => $this->module->getTranslator()->trans('Code à utiliser', [], 'Modules.codeassociations.Codeassociation'),
                    'name' => 'code',
                    'lang'=>false,
                    'col' => 4,
                    'required' => true,
                    'hint' => $this->module->getTranslator()->trans('Invalid characters:', [], 'Modules.codeassociations.Codeassociation').' &lt;&gt;;=#{}'
                ),
                array(
                    'type' => 'text',
                    'label' => $this->module->getTranslator()->trans('Pourcentage', [], 'Modules.codeassociations.Codeassociation'),
                    'name' => 'percentage',
                    'lang'=>false,
                    'col' => 4,
                    'required' => true,
                    'hint' => $this->module->getTranslator()->trans('Invalid characters:', [], 'Modules.codeassociations.Codeassociation').' &lt;&gt;;=#{}'
                ),
            )
        );

        if (Shop::isFeatureActive()) {
            $this->fields_form['input'][] = array(
                'type' => 'shop',
                'label' => $this->trans('Shop association', array(), 'Admin.Global'),
                'name' => 'checkBoxShopAsso',
            );
        }

        if (!($association = $this->loadObject(true))) {
            return;
        }

        $this->fields_form['submit'] = array(
            'title' => $this->module->getTranslator()->trans('Save', [], 'Modules.codeassociations.Codeassociation')
        );
        
        return parent::renderForm();
    }
}