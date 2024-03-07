<?php
/**
 * Copyright ETS Software Technology Co., Ltd
 *
 * NOTICE OF LICENSE
 *
 * This file is not open source! Each license that you purchased is only available for 1 website only.
 * If you want to use this file on more websites (or projects), you need to purchase additional licenses.
 * You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future.
 *
 * @author ETS Software Technology Co., Ltd
 * @copyright  ETS Software Technology Co., Ltd
 * @license    Valid for 1 website (or project) for each purchase of license
 */

if (!defined('_PS_VERSION_')) { exit; }
/**
 * Class Ets_MarketPlaceCarrierModuleFrontController
 * @property \Ets_mp_seller $seller
 * @property \Ets_marketplace $module
 */
class Ets_MarketPlaceCarrierModuleFrontController extends ModuleFrontController
{
    public $_errors= array();
    public $_success ='';
    public $seller;
    public function __construct()
	{
		parent::__construct();
        $this->display_column_right=false;
        $this->display_column_left =false;
	}
    public function postProcess()
    {
        parent::postProcess();
        if(!$this->context->customer->isLogged() || !($this->seller = $this->module->_getSeller(true)) )
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if(!$this->module->_checkPermissionPage($this->seller))
            die($this->module->l('You do not have permission to access this page','carrier'));
        if(!Configuration::get('ETS_MP_SELLER_CREATE_SHIPPING') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_SHIPPING'))
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if((Tools::isSubmit('editmp_carrier') || Tools::isSubmit('del') ) && ($id_carrier = (int)Tools::getValue('id_carrier')) && !$this->seller->checkUserCarrier($id_carrier) )
            die($this->module->l('You do not have permission to edit this carrier','carrier'));
        $action = Tools::getValue('action');
        if($action=='validate_step')
            $this->ajaxProcessValidateStep();
        if($action=='changeRanges')
            $this->ajaxProcessChangeRanges();
        if($action=='finish_step')
            $this->ajaxProcessFinishStep();
        if(Tools::isSubmit('changeUserShipping'))
        {
            $user_shipping = (int)Tools::getValue('user_shipping');
            if(!in_array($user_shipping,array(1,2,3)))
                $user_shipping = 1;
            $this->seller->user_shipping = (int)$user_shipping;
            if($this->seller->update())
            {
                die(
                    json_encode(
                        array(
                            'success' => $this->module->l('Updated successfully','carrier'),
                        )
                    )
                );
            }
        }
        if(Tools::isSubmit('change_enabled') && ($id_carrier = (int)Tools::getValue('id_carrier')) && Validate::isUnsignedId($id_carrier))
        {
            $change_enabled = (int)Tools::getValue('change_enabled');
            $carrier = new Carrier($id_carrier);
            $errors = '';
            if(!Validate::isLoadedObject($carrier) || !$this->seller->checkUserCarrier($id_carrier))
            {
                $errors = $this->module->l('Carrier is not valid','carrier');
            }
            elseif(!($field = Tools::getValue('field')))
                $errors = $this->module->l('Field is required','carrier');
            elseif(!isset($carrier->{$field}))
                $errors = $this->module->l('Field is not valid','carrier');
            else
                $carrier->{$field} = $change_enabled;
            if(!$errors)
            {
                if($carrier->update())
                {
                    if($change_enabled)
                    {
                        die(
                            json_encode(
                                array(
                                    'href' =>$this->context->link->getModuleLink($this->module->name,'carrier',array('id_carrier'=>$id_carrier,'change_enabled'=>0,'field'=>$field)),
                                    'title' => $this->module->l('Click to disable','carrier'),
                                    'success' => $this->module->l('Updated successfully','carrier'),
                                    'enabled' => 1,
                                )
                            )  
                        );
                    }
                    else
                    {
                        die(
                            json_encode(
                                array(
                                    'href' => $this->context->link->getModuleLink($this->module->name,'carrier',array('id_carrier'=>$id_carrier,'change_enabled'=>1,'field'=>$field)),
                                    'title' => $this->module->l('Click to enable','carrier'),
                                    'success' => $this->module->l('Updated successfully','carrier'),
                                    'enabled' => 0,
                                )
                            )  
                        );
                    }
                }
                else
                    $errors = $this->module->l('An error occurred while saving the carrier','carrier');
            }
            if($errors)
            {
                die(
                    json_encode(
                        array(
                            'errors' => $errors
                        )
                    )
                );
            }
        }
        if(Tools::isSubmit('del') && ($id_carrier= (int)Tools::getValue('id_carrier')) && Validate::isUnsignedId($id_carrier))
        {
            $carrier = new Carrier($id_carrier);
            if(!Validate::isLoadedObject($carrier) || !$this->seller->checkUserCarrier($id_carrier))
                $this->_errors[] = $this->module->l('Carrier is not valid');
            else
            {
                $carrier->deleted=1;
                if($carrier->update())
                {
                    $this->context->cookie->_success = $this->module->l('Deleted carrier successfully','carrier');
                }
                else
                    $this->_errors = $this->module->l('An error occurred while deleting the carrier','carrier');
            }
            
        }
    }
    public function initContent()
	{
		parent::initContent();
        if(isset($this->context->cookie->_success) && $this->context->cookie->_success )
        {
            $this->_success = $this->context->cookie->_success;
            $this->context->cookie->_success='';
        }
        $output = '';
        if (is_array($this->_errors)) {
            foreach ($this->_errors as $msg) {
                $output .= $msg . '<br/>';
            }
        } else {
            $output .= $this->_errors;
        }
        $this->context->smarty->assign(
            array(
                'path' => $this->module->getBreadCrumb(),
                'breadcrumb' => $this->module->is17 ? $this->module->getBreadCrumb() : false, 
                'html_content' => $this->_initContent(),
                '_errors' => $this->_errors ? Ets_mp_defines::displayText('<svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>'.$output,'div','alert alert-error'):'',
                '_success' => $this->_success ? Ets_mp_defines::displayText('<svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/></svg>'.$this->_success,'p','alert alert-success'):'',
            )
        );
        if($this->module->is17)
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/carrier.tpl');      
        else        
            $this->setTemplate('carrier_16.tpl'); 
    }
    public function _initContent()
    {
        $carrier_content = '';
        $id_carrier = (int)Tools::getValue('id_carrier');
        if(Tools::isSubmit('addnew') || (Tools::isSubmit('editmp_carrier') && $id_carrier))
        {
            $display_form = true;
            if(!Configuration::get('ETS_MP_SELLER_CREATE_SHIPPING') && Tools::isSubmit('addnew'))
                $carrier_content = $this->module->displayWarning($this->module->l('You do not have permission to create new carrier','carrier'));
            else
                $carrier_content =  $this->_renderCarrierForm();
        }
        else
        {
            $display_form = false;
            $carrier_content = $this->_renderCarriersList();
        }
        $this->context->smarty->assign(
            array(
                'carrier_content' => $carrier_content,
                'ets_seller' => $this->seller,
                'display_form' => $display_form
            )
        );
        return $this->module->displayTpl('carrier.tpl');
    }
    public function _renderCarriersList()
    {
        $fields_list = array(
            'id_carrier' => array(
                'title' => $this->module->l('ID','carrier'),
                'width' => 40,
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'name'=>array(
                'title' => $this->module->l('Name','carrier'),
                'type'=> 'text',
                'sort' => true,
                'filter' => true,
            ),
            'logo'=>array(
                'title' => $this->module->l('Logo','carrier'),
                'type'=> 'text',
                'strip_tag' => false,
            ),
            'delay'=>array(
                'title' => $this->module->l('Delay','carrier'),
                'type' => 'text',
                'sort'=>true,
                'filter' => true,
            ),
            'active' => array(
                    'title' => $this->module->l('Enabled','carrier'),
                    'type' => 'active',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                    'filter_list' => array(
                        'id_option' => 'active',
                        'value' => 'title',
                        'list' => array(
                            0 => array(
                                'active' => 0,
                                'title' => $this->module->l('No','carrier')
                            ),
                            1 => array(
                                'active' => 1,
                                'title' => $this->module->l('Yes','carrier')
                            ),
                        )
                    )
                ),
                'is_free' => array(
                    'title' => $this->module->l('Free shipping','carrier'),
                    'type' => 'active',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                    'filter_list' => array(
                        'id_option' => 'active',
                        'value' => 'title',
                        'list' => array(
                            0 => array(
                                'active' => 0,
                                'title' => $this->module->l('No','carrier')
                            ),
                            1 => array(
                                'active' => 1,
                                'title' => $this->module->l('Yes','carrier')
                            ),
                        )
                    )
                )
        );
        $show_resset = false;
        $filter = "";
        if(($id_carrier = trim(Tools::getValue('id_carrier'))) && !Tools::isSubmit('del'))
        {
            $show_resset = true;
            if(Validate::isUnsignedId($id_carrier))
                $filter .=' AND c.id_carrier="'.(int)$id_carrier.'"';            
        }
        if(($name = trim(Tools::getValue('name'))) || $name!='')
        {
            if(Validate::isCleanHtml($name))
                $filter .=' AND c.name like "%'.pSQL($name).'%"';
            $show_resset = true;
        }
        if(($delay = trim(Tools::getValue('delay'))) || $delay!='')
        {
            if(Validate::isCleanHtml($delay))
                $filter .=' AND cl.delay="%'.pSQL($delay).'%"';
            $show_resset = true;
        }
        if(($active= trim(Tools::getValue('active'))) || $active!='')
        {
            $show_resset = true;
            if(Validate::isInt($active))
                $filter .=' AND c.active="'.(int)$active.'"';            
        }
        if(($is_free = trim(Tools::getValue('is_free'))) || $is_free!='')
        {
            $show_resset = true;
            if(Validate::isInt($is_free))
                $filter .=' AND c.is_free="'.(int)$is_free.'"';            
        }
        $sort = "";
        $sort_type=Tools::getValue('sort_type');
        $sort_value = Tools::getValue('sort');
        if($sort_value)
        {
            switch ($sort_value) {
                case 'id_carrier':
                    $sort .='c.id_carrier';
                    break;
                case 'name':
                    $sort .='c.name';
                    break;
                case 'active':
                    $sort .='c.active';
                    break;
                case 'delay':
                    $sort .='cl.delay';
                    break;
                case 'is_free':
                    $sort .='c.is_free';
                    break;
                case 'position':
                    $sort .='c.position';
                    break;
            }
            if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                $sort .= ' '.trim($sort_type);
        }
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page =1;
        $totalRecords = (int)$this->seller->getCarriers($filter,0,0,'',true);
        $paggination = new Ets_mp_paggination_class();            
        $paggination->total = $totalRecords;
        $paggination->url = $this->context->link->getModuleLink($this->module->name,'attributes',array('list_group'=>1,'page'=>'_page_')).$this->module->getFilterParams($fields_list,'mp_carrier');
        if($limit = (int)Tools::getValue('paginator_carrier_select_limit'))
            $this->context->cookie->paginator_carrier_select_limit = $limit;
        $paggination->limit =  $this->context->cookie->paginator_carrier_select_limit ? : 10;
        $paggination->name ='carrier';
        $paggination->num_links =5;
        $totalPages = ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if($start < 0)
            $start = 0;
        $carriers = $this->seller->getCarriers($filter,$start,$paggination->limit,$sort,false);
        if($carriers)
        {
            foreach($carriers as &$carrier)
            {
                if(!$carrier['name'])
                    $carrier['name'] = $this->context->shop->name;
                if(file_exists(_PS_SHIP_IMG_DIR_.$carrier['id_carrier'].'.jpg'))
                    $carrier['logo'] = Ets_mp_defines::displayText('','img','width_50','','','',$this->context->link->getMediaLink(_PS_IMG_.'s/'.$carrier['id_carrier'].'').'.jpg');
                    
                if(!$carrier['id_customer'])
                    $carrier['action_edit'] = false;
            }
            unset($carrier);
        }
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','carrier');
        $paggination->style_links = 'links';
        $paggination->style_results = 'results';
        $listData = array(
            'name' => 'mp_carrier',
            'actions' => array('view','delete'),
            'currentIndex' => $this->context->link->getModuleLink($this->module->name,'carrier',array('list'=>1)).($paggination->limit!=10 ? '&paginator_carrier_select_limit='.$paggination->limit:''),
            'postIndex' => $this->context->link->getModuleLink($this->module->name,'carrier',array('list'=>1)),
            'identifier' => 'id_carrier',
            'show_toolbar' => true,
            'show_action' =>true,
            'title' => $this->module->l('Carriers','carrier'),
            'fields_list' => $fields_list,
            'field_values' => $carriers,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list,'mp_carrier'),
            'show_reset' =>$show_resset,
            'totalRecords' => $totalRecords,
            'sort'=> $sort_value,
            'show_add_new'=> Configuration::get('ETS_MP_SELLER_CREATE_SHIPPING') && $this->seller->user_shipping!=1 ? true:false,
            'link_new' => $this->context->link->getModuleLink($this->module->name,'carrier',array('addnew'=>1)),
            'sort_type' => $sort_type,
        );            
        return $this->module->renderList($listData);
    }
    public function _renderCarrierForm()
    {
        if(($id_carrier= Tools::getValue('id_carrier')) && Validate::isUnsignedId($id_carrier))
        {
            $carrier = new Carrier($id_carrier);
            if(Validate::isLoadedObject($carrier) && !$this->seller->checkUserCarrier($id_carrier))
                die($this->module->l('You do not have permission to configure this carrier','carrier'));
        }
        else
            $carrier = new Carrier();
        $currency = new Currency(Configuration::get('PS_CURRENCY_DEFAULT'));
        $customer_groups = Group::getGroups($this->context->language->id,$this->context->shop->id);
        if($customer_groups)
        {
            foreach($customer_groups as &$group)
            {
                $group['checked'] = false;
                $carrier_groups = $carrier->getGroups();
                if($carrier_groups)
                {
                    foreach($carrier_groups as $carrier_group)
                        if($carrier_group['id_group']==$group['id_group'])
                        {
                            $group['checked'] = true;
                            break;
                        }
                }
            }
            unset($group);
        }
        $this->context->smarty->assign(
            array(
                'languages'=>Language::getLanguages(true),
                'carrier' =>$carrier,
                'delay' => $carrier->delay,
                'currency' => $currency,
                'carrier_ranges_html' => $this->dispayListRangeCarrier(),
                'customer_groups' => $customer_groups,
                'tax_rule_groups' =>TaxRulesGroup::getTaxRulesGroups(true),
                'id_lang_default' => Configuration::get('PS_LANG_DEFAULT'),
                'ETS_MP_SELLER_LIMIT_USER_CODE' =>Configuration::get('ETS_MP_SELLER_LIMIT_USER_CODE'),
            )
        );
        return $this->module->displayTpl('form_carrier.tpl');
    }
    public function ajaxProcessValidateStep()
    {
        $this->validateForm(true);
    }
    protected function copyFromPost(&$object, $table)
    {
        /* Classical fields */
        foreach (Tools::getAllValues() as $key => $value) {
            if (in_array($key, array_keys((array)$object)) && $key != 'id_' . $table) {
                $object->{$key} = $value;
            }
        }
        /* Multilingual fields */
        $class_vars = get_class_vars(get_class($object));
        $fields = array();
        if (isset($class_vars['definition']['fields'])) {
            $fields = $class_vars['definition']['fields'];
        }

        foreach ($fields as $field => $params) {
            if (array_key_exists('lang', $params) && $params['lang']) {
                foreach (Language::getIDs(false) as $id_lang) {
                    if (Tools::isSubmit($field . '_' . (int) $id_lang)) {
                        $object->{$field}[(int) $id_lang] = Tools::getValue($field . '_' . (int) $id_lang);
                    }
                }
            }
        }
    }
    public function duplicateLogo($new_id, $old_id)
    {
        $old_logo = _PS_SHIP_IMG_DIR_ . '/' . (int) $old_id . '.jpg';
        if (file_exists($old_logo)) {
            copy($old_logo, _PS_SHIP_IMG_DIR_ . '/' . (int) $new_id . '.jpg');
        }

        $old_tmp_logo = _PS_TMP_IMG_DIR_ . '/carrier_mini_' . (int) $old_id . '.jpg';
        if (file_exists($old_tmp_logo)) {
            if (!isset($_FILES['logo'])) {
                copy($old_tmp_logo, _PS_TMP_IMG_DIR_ . '/carrier_mini_' . $new_id . '.jpg');
            }
            unlink($old_tmp_logo);
        }
    }
    protected function changeGroups($id_carrier)
    {
        $carrier = new Carrier((int) $id_carrier);
        if (!Validate::isLoadedObject($carrier)) {
            return false;
        }
        $groupBox = Tools::getValue('groupBox');
        if(!Ets_marketplace::validateArray($groupBox))
            $groupBox = array();
        return $carrier->setGroups($groupBox);
    }
    public function processRanges($id_carrier)
    {
        $carrier = new Carrier((int) $id_carrier);
        if (!Validate::isLoadedObject($carrier)) {
            return false;
        }
        $range_inf = Tools::getValue('range_inf');
        $range_sup = Tools::getValue('range_sup');
        $range_type = Tools::getValue('shipping_method');
        $fees = Tools::getValue('fees');
        $carrier->deleteDeliveryPrice($carrier->getRangeTable());
        if (Ets_marketplace::validateArray($range_inf) && Ets_marketplace::validateArray($range_sup) && Ets_marketplace::validateArray($fees) && $range_type != Carrier::SHIPPING_METHOD_FREE) {
            foreach ($range_inf as $key => $delimiter1) {
                if (!isset($range_sup[$key])) {
                    continue;
                }
                $range = $carrier->getRangeObject((int) $range_type);
                $range->id_carrier = (int) $carrier->id;
                $range->delimiter1 = (float) $delimiter1;
                $range->delimiter2 = (float) $range_sup[$key];
                $range->save();
                if (!Validate::isLoadedObject($range)) {
                    return false;
                }
                $price_list = array();
                if (Ets_marketplace::validateArray($fees) && count($fees)) {
                    foreach ($fees as $id_zone => $fee) {
                        $price_list[] = array(
                            'id_range_price' => ($range_type == Carrier::SHIPPING_METHOD_PRICE ? (int) $range->id : null),
                            'id_range_weight' => ($range_type == Carrier::SHIPPING_METHOD_WEIGHT ? (int) $range->id : null),
                            'id_carrier' => (int) $carrier->id,
                            'id_zone' => (int) $id_zone,
                            'price' => isset($fee[$key]) ? (float) str_replace(',', '.', $fee[$key]) : 0,
                        );
                    }
                }

                if (count($price_list) && !$carrier->addDeliveryPrice($price_list, true)) {
                    return false;
                }
            }
        }
        return true;
    }
    public function postImage($id_carrier,&$errors)
    {
        $name = 'logo';
        if(isset($_FILES[$name]['tmp_name']) && isset($_FILES[$name]['name']) && $_FILES[$name]['name'])
        {
            if(Validate::isFileName(str_replace(array(' ','(',')','!','@','#','+'),'_',$_FILES[$name]['name'])))
            {
                $type = Tools::strtolower(Tools::substr(strrchr($_FILES[$name]['name'], '.'), 1));
    			$imagesize = @getimagesize($_FILES[$name]['tmp_name']);
    			if (isset($_FILES[$name]) &&				
    				!empty($_FILES[$name]['tmp_name']) &&
    				!empty($imagesize) &&
    				in_array($type, array('jpg', 'gif', 'jpeg', 'png'))
    			)
    			{
    				$temp_name = tempnam(_PS_TMP_IMG_DIR_, 'PS');
                    $max_file_size = Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')*1024*1024;    				
    				if ($_FILES[$name]['size'] > $max_file_size)
    					$errors[] = sprintf($this->module->l('Image is too large (%s Mb). Maximum allowed: %s Mb','carrier'),Tools::ps_round((float)$_FILES[$name]['size']/1048576,2), Tools::ps_round(Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE'),2));
    				elseif (!$temp_name || !move_uploaded_file($_FILES[$name]['tmp_name'], $temp_name))
    					$errors[] = $this->module->l('Cannot upload the logo','carrier');
    				elseif (!ImageManager::resize($temp_name, _PS_SHIP_IMG_DIR_.$id_carrier.'.jpg', 250, 250, $type))
    					$errors[] = $this->module->l('An error occurred during the logo upload process.','carrier');
    				if (isset($temp_name) && file_exists($temp_name))
    					@unlink($temp_name);
                    if(!$errors)
                        return true;		
    			}
                else
                    $errors[] = $this->module->l('Logo is not valid','carrier');
            }
            else
                $errors[] = '"'.$_FILES[$name]['name'].'" '. $this->module->l('file name is not valid','carrier');
        }
        return true;
    }
    public function changeZones($id)
    {
        $return = true;
        $carrier = new Carrier($id);
        if (!Validate::isLoadedObject($carrier)) {
            die($this->module->l('The object cannot be loaded.','carrier'));
        }
        $zones = Zone::getZones(false);
        foreach ($zones as $zone) {
            $value = Tools::getValue('zone_' . $zone['id_zone']);
            if (count($carrier->getZone($zone['id_zone']))) {
                if (!Tools::isSubmit('zone_' . $zone['id_zone']) || !$value) {
                    $return &= $carrier->deleteZone((int) $zone['id_zone']);
                }
            } elseif ($value && Validate::isCleanHtml($value)) {
                $return &= $carrier->addZone((int) $zone['id_zone']);
            }
        }

        return $return;
    }
    public function dispayListRangeCarrier()
    {
        if(($id_carrier = (int)Tools::getValue('id_carrier')) && Validate::isUnsignedId($id_carrier) && $this->seller->checkUserCarrier($id_carrier))
            $carrier = new Carrier($id_carrier);
        else
            $carrier = new Carrier();
        if ((!(int) $shipping_method = Tools::getValue('shipping_method',$carrier->shipping_method? :2)) || !in_array($shipping_method, array(Carrier::SHIPPING_METHOD_PRICE, Carrier::SHIPPING_METHOD_WEIGHT))) {
            return;
        }
        $this->context->smarty->assign(
            Ets_mp_product::getRangeCarrier($carrier->id,$shipping_method)
        );
        return $this->module->displayTpl('carrier_range.tpl');
    }
    public function ajaxProcessChangeRanges()
    {
        die($this->dispayListRangeCarrier());
    }
    public function ajaxProcessFinishStep()
    {
        $return = array('has_error' => false);
        $this->validateForm(false);
        $id_tax_rules_group = (int)Tools::getValue('id_tax_rules_group');
        if(!Validate::isUnsignedId($id_tax_rules_group) || !Validate::isLoadedObject(new TaxRulesGroup($id_tax_rules_group)))
            $id_tax_rules_group = 0;
        if (($id_carrier = (int)Tools::getValue('id_carrier')) && Validate::isUnsignedId($id_carrier)) {
            $current_carrier = new Carrier((int) $id_carrier);
            // if update we duplicate current Carrier
            /** @var Carrier $new_carrier */
            $new_carrier = $current_carrier->duplicateObject();

            if (Validate::isLoadedObject($new_carrier)) {
                // Set flag deteled to true for historization
                $current_carrier->deleted = true;
                $current_carrier->update();

                // Fill the new carrier object
                $this->copyFromPost($new_carrier, 'carrier');
                $new_carrier->position = $current_carrier->position;
                $new_carrier->update();
                Ets_mp_product::updateCarrierAssoShop($new_carrier->id);
                $this->duplicateLogo((int) $new_carrier->id, (int) $current_carrier->id);
                $this->changeGroups((int) $new_carrier->id);

                //Copy default carrier
                if (Configuration::get('PS_CARRIER_DEFAULT') == $current_carrier->id) {
                    Configuration::updateValue('PS_CARRIER_DEFAULT', (int) $new_carrier->id);
                }
                Hook::exec('actionCarrierUpdate', array(
                    'id_carrier' => (int) $current_carrier->id,
                    'carrier' => $new_carrier,
                ));
                $this->changeZones($new_carrier->id);
                $new_carrier->setTaxRulesGroup((int) $id_tax_rules_group);
                $carrier = $new_carrier;
                $this->context->cookie->_success = $this->module->l('Updated carrier successfully','carrier');
            }
        } else {
            $carrier = new Carrier();
            $this->copyFromPost($carrier, 'carrier');
            if (!$carrier->add()) {
                $return['has_error'] = true;
                $return['errors'][] = $this->module->l('An error occurred while saving this carrier.','carrier');
            }
            else
            {
                $this->context->cookie->_success = $this->module->l('Add carrier successfully','carrier');
            }
        }
        if($carrier->id)
        {
            $carrier= new Carrier($carrier->id);
            Ets_mp_seller::addCarrierToSeller($this->seller->id_customer,$carrier->id_reference);
        }
        
        if ($carrier->is_free) {
            //if carrier is free delete shipping cost
            $carrier->deleteDeliveryPrice('range_weight');
            $carrier->deleteDeliveryPrice('range_price');
        }

        if (Validate::isLoadedObject($carrier)) {
            if (!$this->changeGroups((int) $carrier->id)) {
                $return['has_error'] = true;
                $return['errors'][] = $this->module->l('An error occurred while saving carrier groups.','carrier');
            }

            if (!$this->changeZones((int) $carrier->id)) {
                $return['has_error'] = true;
                $return['errors'][] = $this->module->l('An error occurred while saving carrier zones.','carrier');
            }

            if (!$carrier->is_free) {
                if (!$this->processRanges((int) $carrier->id)) {
                    $return['has_error'] = true;
                    $return['errors'][] = $this->module->l('An error occurred while saving carrier ranges.','carrier');
                }
            }

            if (Shop::isFeatureActive() && !Ets_mp_product::updateCarrierAssoShop((int) $carrier->id)) {
                $return['has_error'] = true;
                $return['errors'][] = $this->module->l('An error occurred while saving associations of shops.','carrier');
            }

            if (!$carrier->setTaxRulesGroup((int) $id_tax_rules_group)) {
                $return['has_error'] = true;
                $return['errors'][] = $this->module->l('An error occurred while saving the tax rules group.','carrier');
            }
            if(!$this->postImage($carrier->id,$return['errors']))
                $return['has_error'] = true;
            Ets_mp_product::addDeliveryCarrierToAllShop($carrier->id);
            $return['id_carrier'] = $carrier->id;
        }
        die(json_encode($return));
    }
    protected function validateForm($die = true)
    {
        $return = array('has_error' => false);
        if(($id_carrier = (int)Tools::getValue('id_carrier')) && Validate::isUnsignedId($id_carrier))
        {
            if(($carrier = new Carrier($id_carrier)) && (!Validate::isLoadedObject($carrier) || !$this->seller->checkUserCarrier($id_carrier)))
                $this->_errors[] = $this->module->l('Carrier is not valid','carrier');
        }
        if(isset($_FILES['logo']['name']) && $_FILES['logo']['name'] && isset($_FILES['logo']['size']) && $_FILES['logo']['size'])
            $this->module->validateFile($_FILES['logo']['name'],$_FILES['logo']['size'],$this->_errors,array('jpg','gif','png'));
        $this->validateRules();
        if (count($this->_errors)) {
            $return['has_error'] = true;
            $return['errors'] = $this->_errors;
        }
        
        if (count($this->_errors) || $die) {
            die(json_encode($return));
        }
    }
    public function validateRules()
    {
        $class_name='Carrier';
        $object = new Carrier();
        $definition = $this->getValidationRules();
        $default_language = new Language((int) Configuration::get('PS_LANG_DEFAULT'));
        $languages = Language::getLanguages(true);
        foreach ($definition['fields'] as $field => $def) {
            $skip = array();
            if (in_array($field, array('passwd', 'no-picture'))) {
                $skip = array('required');
            }
            $field_value = Tools::getValue($field);
            if (isset($def['lang']) && $def['lang']) {
                if (isset($def['required']) && $def['required']) {
                    $value = Tools::getValue($field . '_' . $default_language->id);
                    if (!isset($value) || '' == $value) {
                        $this->_errors[$field . '_' . $default_language->id] = $this->module->l('The field','carrier').' '.$object->displayFieldName($field, $class_name).' '.$this->module->l('is required at least in','carrier').' '.$default_language->name;
                    }
                }
                foreach ($languages as $language) {
                    $value = Tools::getValue($field . '_' . $language['id_lang']);
                    if (!empty($value)) {
                        if (($error = $object->validateField($field, $value, $language['id_lang'], $skip, true)) !== true) {
                            $this->_errors[$field . '_' . $language['id_lang']] = $error;
                        }
                    }
                }
            } elseif (($error = $object->validateField($field, $field_value, null, $skip, true)) !== true) {
                if($field=='url')
                    $this->_errors[$field] = $this->module->l('Tracking URL is invalid','carrier');
                else
                    $this->_errors[$field] = $error;
            }
        }
        
    }
    public function getValidationRules()
    {
        $step_number = (int) Tools::getValue('step_number');
        if (!$step_number) {
            return;
        }

        if ($step_number == 4 && !Shop::isFeatureActive() || $step_number == 5 && Shop::isFeatureActive()) {
            return array('fields' => array());
        }

        $step_fields = array(
            1 => array('name', 'delay', 'grade', 'url'),
            2 => array('is_free', 'id_tax_rules_group', 'shipping_handling', 'shipping_method', 'range_behavior'),
            3 => array('range_behavior', 'max_height', 'max_width', 'max_depth', 'max_weight'),
            4 => array(),
        );
        if (Shop::isFeatureActive()) {
            $tmp = $step_fields;
            $step_fields = array_slice($tmp, 0, 1, true) + array(2 => array('shop'));
            $step_fields[3] = $tmp[2];
            $step_fields[4] = $tmp[3];
        }

        $definition = ObjectModel::getDefinition('Carrier');
        foreach ($definition['fields'] as $field => $def) {
            if (Ets_marketplace::validateArray($step_fields[$step_number]) && !in_array($field, $step_fields[$step_number])) {
                unset($definition['fields'][$field]);
            }
            unset($def);
        }

        return $definition;
    }
}