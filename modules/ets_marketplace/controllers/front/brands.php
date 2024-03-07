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
 *@property \Ets_mp_seller $seller
 * @property \Ets_marketplace $module
 */
class Ets_MarketPlaceBrandsModuleFrontController extends ModuleFrontController
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
        if(!Configuration::get('ETS_MP_SELLER_CREATE_BRAND') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_BRAND'))
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if(!$this->context->customer->isLogged() || !($this->seller = $this->module->_getSeller(true)) )
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if(!$this->module->_checkPermissionPage($this->seller))
            die($this->module->l('You do not have permission to access this page','brands'));
        if(Tools::isSubmit('changeUserBrands'))
        {
            $user_brand = (int)Tools::getValue('user_brand');
            if(!in_array($user_brand,array(1,2,3)))
                $user_brand = 1;
            $this->seller->user_brand = (int)$user_brand;
            if($this->seller->update())
            {
                die(
                    json_encode(
                        array(
                            'success' => $this->module->l('Updated successfully','brands'),
                        )
                    )
                );
            }

        }
        if(($id_manufacturer = (int)Tools::getValue('id_manufacturer')) && Validate::isUnsignedId($id_manufacturer) && !Tools::isSubmit('ets_mp_submit_mp_manufacturer'))
        {
            if(!$this->seller->checkHasManufacturer($id_manufacturer,false))
                die($this->module->l('You do not have permission to config this manufacturer','brands'));
        }
        if(Tools::isSubmit('change_enabled') && ($id_manufacturer = Tools::getValue('id_manufacturer')) && Validate::isUnsignedId($id_manufacturer))
        {
            $errors = '';
            $manufacturer = new Manufacturer($id_manufacturer);
            if(!Validate::isLoadedObject($manufacturer) || !$this->seller->checkHasManufacturer($id_manufacturer,false))
                $errors = $this->module->l('Brand is not valid','brands');
            else
            {
                $change_enabled = (int)Tools::getValue('change_enabled');
                $manufacturer->active = $change_enabled ? 1:0;
                if($manufacturer->update())
                {
                    if($change_enabled)
                    {
                        die(
                            json_encode(
                                array(
                                    'href' =>$this->context->link->getModuleLink($this->module->name,'brands',array('id_manufacturer'=>$id_manufacturer,'change_enabled'=>0,'field'=>'active')),
                                    'title' => $this->module->l('Click to disable','brands'),
                                    'success' => $this->module->l('Updated successfully','brands'),
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
                                    'href' => $this->context->link->getModuleLink($this->module->name,'brands',array('id_manufacturer'=>$id_manufacturer,'change_enabled'=>1,'field'=>'active')),
                                    'title' => $this->module->l('Click to enable','brands'),
                                    'success' => $this->module->l('Updated successfully','brands'),
                                    'enabled' => 0,
                                )
                            )  
                        );
                    }
                }else
                    $errors = $this->module->l('An error occurred while saving the brand','brands');
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
        $id_address = (int)Tools::getValue('id_address');
        $id_manufacturer = (int)Tools::getValue('id_manufacturer');
        if($id_address && !$id_manufacturer)
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1)));
        if(Tools::isSubmit('del') && $id_address && Validate::isUnsignedId($id_address))
        {
            $address = new Address($id_address);
            if(($manufacturer = new Manufacturer($address->id_manufacturer)) && ( !Validate::isLoadedObject($address) || !Validate::isLoadedObject($manufacturer) || !$this->seller->checkHasManufacturer($address->id_manufacturer,false)))
                $this->_errors[] = $this->module->l('Address is not valid','brands');
            if($address->delete())
            {
                $this->context->cookie->success_message = $this->module->l('Deleted successfully','brands');
                Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$address->id_manufacturer)));
            }
            else
                $this->_errors[] = $this->module->l('An error occurred while deleting the address','brands');
        }
        else
        if(Tools::isSubmit('del') && $id_manufacturer && Validate::isUnsignedId($id_manufacturer))
        {
            $manufacturer = new Manufacturer($id_manufacturer);
            if(!Validate::isLoadedObject($manufacturer) || !$this->seller->checkHasManufacturer($id_manufacturer,false))
                $this->_errors[] = $this->module->l('Brands are not valid','brands');
            elseif($manufacturer->delete())
            {
                Ets_mp_seller::deleteManufacture($manufacturer->id);
                $this->context->cookie->success_message = $this->module->l('Deleted successfully','brands');
                Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1)));
            }
            else
                $this->_errors[] = $this->module->l('An error occurred while deleting the brand','brands');
            
        }
        if(Tools::isSubmit('deletelogo') && $id_manufacturer && Validate::isUnsignedId($id_manufacturer))
        {
            $manufacturer = new Manufacturer($id_manufacturer);
            if(!Validate::isLoadedObject($manufacturer) || !$this->seller->checkHasManufacturer($id_manufacturer,false))
                $this->_errors[] = $this->module->l('Brands are not valid','brands');
            else
            {
                if(file_exists(_PS_MANU_IMG_DIR_ . $id_manufacturer . '.jpg')) {
                    @unlink(_PS_MANU_IMG_DIR_ . $id_manufacturer . '.jpg');
                }
                $images_types = ImageType::getImagesTypes('manufacturers');
                foreach ($images_types as $image_type) {
                    if(file_exists( _PS_MANU_IMG_DIR_ . $id_manufacturer . '-' . Tools::stripslashes($image_type['name']) . '.jpg'))
                        @unlink( _PS_MANU_IMG_DIR_ . $id_manufacturer . '-' . Tools::stripslashes($image_type['name']) . '.jpg');
                    if(file_exists(_PS_MANU_IMG_DIR_ . $id_manufacturer . '-' . Tools::stripslashes($image_type['name']) . '2x.jpg'))
                        @unlink(_PS_MANU_IMG_DIR_ . $id_manufacturer . '-' . Tools::stripslashes($image_type['name']) . '2x.jpg');
                }
                $this->context->cookie->success_message = $this->module->l('Deleted logo successfully','brands');
                Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1)));
            }
        }
        if(Tools::isSubmit('editmp_front_products') && ($id_product=Tools::getValue('id_product')) && Validate::isUnsignedId($id_product))
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'products',array('editmp_front_products'=>1,'id_product'=>$id_product)));
        if(Tools::isSubmit('submitSaveManufacturer'))
        {
            $this->_submitSaveManufacturer();
        }
        if(Tools::isSubmit('submitSaveAddressManufacturer'))
        {
            $this->_submitSaveAddressManufacturer();
        }
        if($this->context->cookie->success_message)
        {
            $this->_success = $this->context->cookie->success_message;
            $this->context->cookie->success_message='';
        }
    }
    public function _submitSaveAddressManufacturer(){
        if(($id_address = (int)Tools::getValue('id_address')) && Validate::isUnsignedId($id_address))
        {
            $address = new Address($id_address);
            if(!Validate::isLoadedObject($address) || !$address->id_manufacturer || !Validate::isLoadedObject(new Manufacturer($address->id_manufacturer)) || !$this->seller->checkHasManufacturer($address->id_manufacturer,false))
                $this->_errors[] = $this->module->l('Address is not valid','brands');
        }
        else
        {
            $address = new Address();
            if(!($id_manufacturer = Tools::getValue('id_manufacturer')))
                $this->_errors[] = $this->module->l('Brand is required','brands');
            elseif(!Validate::isLoadedObject(new Manufacturer($id_manufacturer)) || !$this->seller->checkHasManufacturer($id_manufacturer,false))
                $this->_errors[] = $this->module->l('Brand is not valid','brands'); 
            $address->id_manufacturer = $id_manufacturer;
            $address->alias = $this->module->l('Manufacturer','brands');
        }
        if(!($firstname = Tools::getValue('firstname')))
            $this->_errors[] = $this->module->l('First name is required','brands');
        elseif($firstname && !Validate::isName($firstname))
            $this->_errors[] = $this->module->l('First name is not valid','brands');
        else
            $address->firstname = $firstname;
        if(!($lastname = Tools::getValue('lastname')))
            $this->_errors[] = $this->module->l('Last name is required','brands');
        elseif($lastname && !Validate::isName($lastname))
            $this->_errors[] = $this->module->l('Last name is not valid');
        else
            $address->lastname = $lastname;
        if(!($address1= Tools::getValue('address1')))
            $this->_errors[] = $this->module->l('Address is required','brands');
        elseif($address1 && !Validate::isAddress($address1))
            $this->_errors[] = $this->module->l('Address is not valid','brands');
        else
            $address->address1 = $address1;
        if(($address2= Tools::getValue('address2')) && !Validate::isAddress($address2))
            $this->_errors[] = $this->module->l('Address(2) is not valid','brands');
        else
            $address->address2 = $address2;
        if(($postcode = Tools::getValue('postcode')) && !Validate::isPostCode($postcode))
            $this->_errors[] = $this->module->l('Post code is not valid','brands');
        else
            $address->postcode = $postcode;
        if(!($city = Tools::getValue('city')))
            $this->_errors[] = $this->module->l('City is required','brands');
        elseif($city && !Validate::isCityName($city))
            $this->_errors[] = $this->module->l('City is not valid','brands');
        else
            $address->city=  $city;
        if(($phone= Tools::getValue('phone')) && !Validate::isPhoneNumber($phone))
            $this->_errors[] = $this->module->l('Home phone is required','brands');
        else
            $address->phone = $phone;
        if(($phone_mobile = Tools::getValue('phone_mobile')) && !Validate::isPhoneNumber($phone_mobile))
            $this->_errors[] = $this->module->l('Mobile phone is not valid','brands');
        else
            $address->phone_mobile = $phone_mobile;
        if(($other= Tools::getValue('other')) && !Validate::isMessage($other))
            $this->_errors[] = $this->module->l('Other is not valid','brands');
        else
            $address->other = $other;
        $address->id_country = (int)Tools::getValue('id_country');
        $address->id_state = (int)Tools::getValue('id_state');
        if(!$this->_errors)
        {
            if($address->id)
            {
                if($address->update())
                {
                    $this->context->cookie->success_message = $this->module->l('Updated successfully','brands');
                    Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$address->id_manufacturer)));
                }
                else
                    $this->_errors[] = $this->module->l('An error occurred while saving the address','brands');
            }
            else
            {
                if($address->add())
                {
                    $this->context->cookie->success_message = $this->module->l('Added successfully','brands');
                    Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$address->id_manufacturer)));
                }
                else
                    $this->_errors[] = $this->module->l('An error occurred while saving the address','brands');
                
            }
        }
        
    }
    public function _submitSaveManufacturer()
    {
        $languages = Language::getLanguages(false);
        $id_lang_default = (int)Configuration::get('PS_LANG_DEFAULT');
        if(($id_manufacturer = (int)Tools::getValue('id_manufacturer')) && Validate::isUnsignedId($id_manufacturer))
        {
            $manufacturer = new Manufacturer($id_manufacturer);
            if(!Validate::isLoadedObject($manufacturer) || !$this->seller->checkHasManufacturer($id_manufacturer,false))
                $this->_errors[] = $this->module->l('Brand is not valid','brands');
        }
        else
            $manufacturer = new Manufacturer();
        if(!($name= Tools::getValue('name')))
            $this->_errors[] = $this->module->l('Name is required','brands');
        elseif($name && !Validate::isCatalogName($name))
            $this->_errors[] = $this->module->l('Name is not valid','brands');
        else
            $manufacturer->name = $name;
        foreach($languages as $language)
        {
            if(($description = Tools::getValue('description_'.$language['id_lang'])) && !Validate::isCleanHtml($description))
                $this->_errors[] = $this->module->l('Description is not valid in','brands').' '.$language['iso_code'];
            elseif($description)
                $manufacturer->description[$language['id_lang']] = $description;
            else
                $manufacturer->description[$language['id_lang']] = Tools::getValue('description_'.$id_lang_default);
            if(($short_description= Tools::getValue('short_description_'.$language['id_lang'])) && !Validate::isCleanHtml($short_description))
                $this->_errors[] = $this->module->l('Short description is not valid in','brands').' '.$language['iso_code'];
            elseif($short_description)
                $manufacturer->short_description[$language['id_lang']] = $short_description;
            else
                $manufacturer->short_description[$language['id_lang']] = Tools::getValue('short_description_'.$id_lang_default);
            if(($meta_title= Tools::getValue('meta_title_'.$language['id_lang'])) && !Validate::isGenericName($meta_title) )
                $this->_errors[] = $this->module->l('Meta title is not valid in','brands').' '.$language['iso_code'];
            elseif($meta_title)
                $manufacturer->meta_title[$language['id_lang']] = $meta_title;
            else
                $manufacturer->meta_title[$language['id_lang']] = Tools::getValue('meta_title_'.$id_lang_default);
            if(($meta_description= Tools::getValue('meta_description_'.$language['id_lang'])) && !Validate::isGenericName($meta_description))
                $this->_errors[] = $this->module->l('Meta description is not valid in','brands').' '.$language['iso_code'];
            elseif($meta_description)
                $manufacturer->meta_description[$language['id_lang']] = $meta_description;
            else
                $manufacturer->meta_description[$language['id_lang']] = Tools::getValue('meta_description_'.$id_lang_default);
            if(($meta_keywords= Tools::getValue('meta_keywords_'.$language['id_lang'])) && !Validate::isGenericName($meta_keywords))
                $this->_errors[] = $this->module->l('Meta keywords is not valid in','brands').' '.$language['iso_code'];
            elseif($meta_keywords)
                $manufacturer->meta_keywords[$language['id_lang']] = $meta_keywords;
            else
                $manufacturer->meta_keywords[$language['id_lang']] = Tools::getValue('meta_keywords_'.$id_lang_default);
        }
        $manufacturer->active = (int)Tools::getValue('active');
        if(isset($_FILES['logo']) && isset($_FILES['logo']['name']) && $_FILES['logo']['name'] && isset($_FILES['logo']['size']) && $_FILES['logo']['size'])
        {
            $this->module->validateFile($_FILES['logo']['name'],$_FILES['logo']['size'],$this->_errors,array('jpg', 'gif', 'jpeg', 'png'));
        }
        if(!$this->_errors)
        {
            if($manufacturer->id)
            {
                if($manufacturer->update())
                {
                    $this->manufacturerImageUpload($manufacturer->id);
                    if(!$this->_errors)
                    {
                        $this->context->cookie->success_message = $this->module->l('Updated successfully','brands');
                        Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1)));
                    }
                }
                else
                    $this->_errors[] = $this->module->l('An error occurred while saving the brand','brands');
            }
            elseif($manufacturer->add())
            {
                $this->manufacturerImageUpload($manufacturer->id);
                if(!$this->_errors)
                {
                    $this->seller->addManufacturer($manufacturer->id);
                    $this->context->cookie->success_message = $this->module->l('Added successfully','brands');
                    Tools::redirect($this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1)));
                }
            } 
            else
                $this->_errors[] = $this->module->l('An error occurred while saving the brand','brands');   
        }
    }
    public function initContent()
	{
		parent::initContent();
        $this->context->controller->addJqueryPlugin('tagify');
        $id_manufacturer = (int)Tools::getValue('id_manufacturer');
        $id_address = (int)Tools::getValue('id_address');
        if(Tools::isSubmit('view') && $id_manufacturer && Validate::isUnsignedId($id_manufacturer))
        {
            $display_form = true;
        }
        elseif((Tools::isSubmit('editmp_address') && $id_address && Validate::isUnsignedId($id_address)) || Tools::isSubmit('addnewAddress'))
        {
            $display_form =true;
        }
        elseif(Tools::isSubmit('addnew') || Tools::isSubmit('editmp_manufacturer')){
             $display_form =true;
        }
        else
            $display_form = Configuration::get('ETS_MP_SELLER_USER_GLOBAL_BRAND') ? false :true;
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
                'display_form' => $display_form,
                'html_content' => $this->_initContent(),
                'ets_seller' => $this->seller,
                '_errors' => $this->_errors ? Ets_mp_defines::displayText('<svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>'.$output,'div','alert alert-error'):'',
                '_success' => $this->_success ? Ets_mp_defines::displayText('<svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/></svg>'.$this->_success,'p','alert alert-success'):'',
            )
        );
        if($this->module->is17)
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/brands.tpl');      
        else        
            $this->setTemplate('brands_16.tpl'); 
    }
    public function _initContent()
    {
        $id_manufacturer =(int)Tools::getValue('id_manufacturer');
        $id_address = (int)Tools::getValue('id_address');
        if((Tools::isSubmit('editmp_address') && $id_address && Validate::isUnsignedId($id_address)) || Tools::isSubmit('addnewAddress'))
        {
            return $this->renderManufacturerAddressForm();
        }
        elseif(Tools::isSubmit('view') && $id_manufacturer && Validate::isUnsignedId($id_manufacturer) )
        {
            return $this->renderManufacturerInfo($id_manufacturer);
        }
        elseif(Tools::isSubmit('addnew') || Tools::isSubmit('editmp_manufacturer')){
            if(!Configuration::get('ETS_MP_SELLER_CREATE_BRAND'))
                return $this->module->displayWarning($this->module->l('You do not have permission to create new brand','brands'));
            return  $this->renderManufacturerForm();
        }
        else
        {
            $fields_list = array(
                'id_manufacturer' => array(
                    'title' => $this->module->l('ID','brands'),
                    'width' => 40,
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                ),
                'logo'=> array(
                    'title' => $this->module->l('Logo','brands'),
                    'type'=>'text',
                    'strip_tag' => false,
                    'sort'=>false,
                    'filter'=> false,
                ),
                'name' => array(
                    'title' => $this->module->l('Name','brands'),
                    'type' => 'text',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                ),
                'addresss' => array(
                    'title' => $this->module->l('Addresses','brands'),
                    'type' => 'text',
                    'sort' => true,
                ),
                'products' => array(
                    'title' => $this->module->l('Products','brands'),
                    'type' => 'text',
                    'sort' => true,
                ),
                'active' => array(
                    'title' => $this->module->l('Enabled','brands'),
                    'type' => 'active',
                    'sort' => true,
                    'filter' => true,
                    'strip_tag' => false,
                    'filter_list' => array(
                        'id_option' => 'active',
                        'value' => 'title',
                        'list' => array(
                            0 => array(
                                'active' => 1,
                                'title' => $this->module->l('Yes','brands')
                            ),
                            1 => array(
                                'active' => 0,
                                'title' => $this->module->l('No','brands')
                            )
                        )
                    )
                ),
            );
            //Filter
            $show_resset = false;
            $filter = "";
            $having="";
            if($id_manufacturer && !Tools::isSubmit('del'))
            {
                if(Validate::isUnsignedId($id_manufacturer))
                    $filter .= ' AND m.id_manufacturer="'.(int)$id_manufacturer.'"';
                $show_resset = true;
            }
            if(($name = Tools::getValue('name')) || $name!='')
            {
                if(Validate::isCleanHtml($name))
                    $filter .=' AND m.name LIKE "%'.pSQL($name).'%"';
                $show_resset = true;
            }
            if(($active = trim(Tools::getValue('active'))) || $active!='')
            {
                if(Validate::isInt($active))
                    $filter .= ' AND m.active="'.(int)$active.'"';
                $show_resset=true;
            }
            //Sort
            $sort = "";
            $sort_type=Tools::getValue('sort_type','desc');
            $sort_value = Tools::getValue('sort','id_manufacturer');
            if($sort_value)
            {
                switch ($sort_value) {
                    case 'id_manufacturer':
                        $sort .='m.id_manufacturer';
                        break;
                    case 'name':
                        $sort .='m.name';
                        break;
                    case 'active':
                        $sort .='m.active';
                        break;
                }
                if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                    $sort .= ' '.trim($sort_type);  
            }
            //Paggination
            $page = (int)Tools::getValue('page');
            if($page<=0)
                $page = 1;
            $totalRecords = (int) $this->seller->getManufacturers($filter,$having,0,0,'',true);
            $paggination = new Ets_mp_paggination_class();            
            $paggination->total = $totalRecords;
            $paggination->url =$this->context->link->getModuleLink($this->module->name,'brands',array('list'=>true, 'page'=>'_page_')).$this->module->getFilterParams($fields_list,'mp_manufacturer');
            if($limit = (int)Tools::getValue('paginator_brand_select_limit'))
                $this->context->cookie->paginator_brand_select_limit = $limit;
            $paggination->limit =  $this->context->cookie->paginator_brand_select_limit ? :10;
            $paggination->num_links =5;
            $paggination->name ='brand';
            $totalPages = ceil($totalRecords / $paggination->limit);
            if($page > $totalPages)
                $page = $totalPages;
            $paggination->page = $page;
            $start = $paggination->limit * ($page - 1);
            if($start < 0)
                $start = 0;
            $manufacturers = $this->seller->getManufacturers($filter, $having,$start,$paggination->limit,$sort,false);
            if($manufacturers)
            {
                if(version_compare(_PS_VERSION_, '1.7', '>='))
                    $type_image= ImageType::getFormattedName('small');
                else
                    $type_image= ImageType::getFormatedName('small');
                foreach($manufacturers as &$manufacturer)
                {
                    if(file_exists(_PS_MANU_IMG_DIR_.$manufacturer['id_manufacturer'].'.jpg'))
                    {
                        if($this->module->is17)
                            $manufacturer['logo'] = Ets_mp_defines::displayText('','img','','','','',$this->context->link->getManufacturerImageLink($manufacturer['id_manufacturer'],$type_image).'?time='.time());
                        else
                            $manufacturer['logo'] = Ets_mp_defines::displayText('','img','ets_mp_logo_mnf','','','',$this->module->getBaseLink().'/img/m/'.$manufacturer['id_manufacturer'].'.jpg?time='.time());
                    }
                    if($manufacturer['id_seller'])
                    {
                        $manufacturer['action_edit']=true;
                        $manufacturer['child_view_url'] = $this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$manufacturer['id_manufacturer']));
                    }
                    else
                    {
                        $manufacturer['action_edit'] = false;
                        $manufacturer['child_view_url'] = $this->context->link->getManufacturerLink($manufacturer['id_manufacturer']);
                    }
                    $manufacturer['name'] =Ets_mp_defines::displayText($manufacturer['name'],'a','','',$this->context->link->getManufacturerLink($manufacturer['id_manufacturer']));
                }
            }
            $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','brands');
            $paggination->style_links = 'links';
            $paggination->style_results = 'results';
            $listData = array(
                'name' => 'mp_manufacturer',
                'actions' => array('view','edit', 'delete'),
                'currentIndex' => $this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1)).($paggination->limit!=10 ? '&paginator_brand_select_limit='.$paggination->limit:''),
                'postIndex' => $this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1)),
                'identifier' => 'id_manufacturer',
                'show_toolbar' => true,
                'show_action' => true,
                'title' => $this->module->l('Brands','brands'),
                'fields_list' => $fields_list,
                'field_values' => $manufacturers,
                'paggination' => $paggination->render(),
                'filter_params' => $this->module->getFilterParams($fields_list,'mp_manufacturer'),
                'show_reset' =>$show_resset,
                'totalRecords' => $totalRecords,
                'sort'=> $sort_value,
                'show_add_new'=>  Configuration::get('ETS_MP_SELLER_CREATE_BRAND') && $this->seller->user_brand!=1 ? true:false,
                'link_new' => $this->context->link->getModuleLink($this->module->name,'brands',array('addnew'=>1)),
                'sort_type' => $sort_type,
            );           
            return $this->module->renderList($listData);
        }
    }
    public function renderManufacturerForm()
    {
        $languages = Language::getLanguages(false);
        $valueFieldPost= array();
        if(($id_manufacturer = Tools::getValue('id_manufacturer')) && Validate::isUnsignedId($id_manufacturer))
        {
            $manufacturer = new Manufacturer($id_manufacturer);
            if(Validate::isLoadedObject($manufacturer) &&  !$this->seller->checkHasManufacturer($id_manufacturer,false))
                die($this->module->l('You do not have permission to configure this brand','brands'));
        }
        else
            $manufacturer= new Manufacturer();
        if($languages)
        {
            foreach($languages as $language)
            {
                $valueFieldPost['description'][$language['id_lang']] = Tools::getValue('description_'.$language['id_lang'],isset($manufacturer->description[$language['id_lang']]) ? $manufacturer->description[$language['id_lang']]:'');
                $valueFieldPost['short_description'][$language['id_lang']] = Tools::getValue('short_description_'.$language['id_lang'],isset($manufacturer->short_description[$language['id_lang']]) ? $manufacturer->short_description[$language['id_lang']] :'');
                $valueFieldPost['meta_title'][$language['id_lang']] = Tools::getValue('meta_title_'.$language['id_lang'],isset($manufacturer->meta_title[$language['id_lang']]) ? $manufacturer->meta_title[$language['id_lang']]:'');
                $valueFieldPost['meta_description'][$language['id_lang']] = Tools::getValue('meta_description_'.$language['id_lang'],isset($manufacturer->meta_description[$language['id_lang']]) ? $manufacturer->meta_description[$language['id_lang']]:'');
                $valueFieldPost['meta_keywords'][$language['id_lang']] = Tools::getValue('meta_keywords_'.$language['id_lang'],isset($manufacturer->meta_keywords[$language['id_lang']]) ? $manufacturer->meta_keywords[$language['id_lang']]:'');
            }
        }
        $valueFieldPost['name'] = Tools::getValue('name',$manufacturer->name);
        $valueFieldPost['active'] =Tools::getValue('active',$manufacturer->active);
        if(version_compare(_PS_VERSION_, '1.7', '>='))
            $type_image= ImageType::getFormattedName('small');
        else
            $type_image= ImageType::getFormatedName('small');
        if($manufacturer->id && file_exists(_PS_MANU_IMG_DIR_.(int)$manufacturer->id.'.jpg'))
        {
            if($this->module->is17)
                $valueFieldPost['logo'] = $this->context->link->getManufacturerImageLink($manufacturer->id,$type_image);
            else
                $valueFieldPost['logo'] = $this->module->getBaseLink().'/img/m/'.(int)$manufacturer->id.'.jpg';
        }
        $fields=array(
            array(
                'type'=>'text',
                'name'=>'name',
                'label' => $this->module->l('Name','brands'),
                'required' => true,
                'desc' => $this->module->l('Invalid characters: <>;=#{} ','brands'),
            ),
            array(
                'type'=>'textarea',
                'name'=>'short_description',
                'label' => $this->module->l('Short description','brands'),
                'lang' => true,
                'autoload_rte'=>true,
            ),
            array(
                'type'=>'textarea',
                'name'=>'description',
                'label' => $this->module->l('Description','brands'),
                'lang' => true,
                'autoload_rte'=>true,
            ),
            array(
                'type' => 'file',
                'name' =>'logo',
                'link_del' => $this->context->link->getModuleLink($this->module->name,'brands',array('id_manufacturer'=>$manufacturer->id,'deletelogo'=>1)),
                'label' => $this->module->l('Logo','brands'),
                'desc' => sprintf($this->module->l('Accepted formats: jpg, jpeg, gif, png. Limit: %dMB'),Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')),
            ),
            array(
                'type'=>'text',
                'name'=>'meta_title',
                'label' => $this->module->l('Meta title','brands'),
                'lang' => true,
                'desc' => $this->module->l('Invalid characters: <>;=#{} ','brands'),
            ),
            array(
                'type'=>'textarea',
                'name'=>'meta_description',
                'label' => $this->module->l('Meta description','brands'),
                'lang' => true,
                'desc' => $this->module->l('Invalid characters: <>;=#{} ','brands'),
            ),
            array(
                'type'=>'tags',
                'name'=>'meta_keywords',
                'label' => $this->module->l('Meta keywords','brands'),
                'lang' => true,
                'desc' => $this->module->l('To add tags, click in the field, write something, and then press the "Enter" key. Invalid characters: <>;=#{} ','brands'),
            ),
            array(
                'type' =>'switch',
                'name' => 'active',
                'label'=> $this->module->l('Enabled','brands'),
            )
        );  
        $this->context->smarty->assign(
            array(
                'fields' => $fields,
                'languages' => $languages,
                'valueFieldPost' => $valueFieldPost,
                'id_lang_default' => Configuration::get('PS_LANG_DEFAULT'),
            )
        );
        $html_form = $this->module->displayTpl('form.tpl');
        $this->context->smarty->assign(
            array(
                'url_path' => $this->module->getBaseLink().'/modules/'.$this->module->name.'/',
                'html_form' => $html_form,
                'id_manufacturer' => $id_manufacturer,
                'link_cancel' => $this->context->link->getModuleLink($this->module->name,'brands',array('list'=>1))
            )
        );
        return $this->module->displayTpl('brand/manufacturer_form.tpl');
    }
    public function manufacturerImageUpload($id_manufacturer)
    {
        if(isset($_FILES['logo']) && isset($_FILES['logo']['name']) && $_FILES['logo']['name'])
        {
            if(file_exists(_PS_MANU_IMG_DIR_.$id_manufacturer.'.jpg'))
            {
                @unlink(_PS_MANU_IMG_DIR_.$id_manufacturer.'.jpg');
            }
            $temp_name = tempnam(_PS_TMP_IMG_DIR_, 'PS');    				
			if(move_uploaded_file($_FILES['logo']['tmp_name'], $temp_name))
            {
                $type = Tools::strtolower(Tools::substr(strrchr($_FILES['logo']['name'], '.'), 1));
                if(ImageManager::resize($temp_name, _PS_MANU_IMG_DIR_.$id_manufacturer.'.jpg', null, null, $type))
                {
                    $res=true;
                    $generate_hight_dpi_images= (bool) Configuration::get('PS_HIGHT_DPI');
                    if(file_exists(_PS_MANU_IMG_DIR_ . $id_manufacturer . '.jpg')) {
                        $images_types = ImageType::getImagesTypes('manufacturers');
                        foreach ($images_types as $image_type) {
                            $res &= ImageManager::resize(
                                _PS_MANU_IMG_DIR_ . $id_manufacturer . '.jpg',
                                _PS_MANU_IMG_DIR_ . $id_manufacturer . '-' . Tools::stripslashes($image_type['name']) . '.jpg',
                                (int) $image_type['width'],
                                (int) $image_type['height']
                            );
            
                            if ($generate_hight_dpi_images) {
                                $res &= ImageManager::resize(
                                    _PS_MANU_IMG_DIR_ . $id_manufacturer . '.jpg',
                                    _PS_MANU_IMG_DIR_ . $id_manufacturer . '-' . Tools::stripslashes($image_type['name']) . '2x.jpg',
                                    (int) $image_type['width'] * 2,
                                    (int) $image_type['height'] * 2
                                );
                            }
                        }
            
                        $current_logo_file = _PS_TMP_IMG_DIR_ . 'manufacturer_mini_' . $id_manufacturer . '_' . $this->context->shop->id . '.jpg';
            
                        if ($res && file_exists($current_logo_file)) {
                            unlink($current_logo_file);
                        }
                    }
                    return $res;
                }
                else
                  $this->_errors[] = $this->module->l('An error occurred while uploading the brand logo','brands');  
                
            }
            else
                $this->_errors[] = $this->module->l('An error occurred while uploading the brand logo','brands');
        }
    }
    public function renderManufacturerInfo($id_manufacturer)
    {
        if(!$this->seller->checkHasManufacturer($id_manufacturer,false))
            die($this->module->l('You do not have permission to configure this brand','brands'));
        $this->context->smarty->assign(
            array(
                'list_address' => $this->renderListAddress($id_manufacturer),
                'list_products' => $this->renderListProducts($id_manufacturer),
            )
        );
        return $this->module->displayTpl('brand/brand_detail.tpl');        
    }
    public function renderListAddress($id_manufacturer)
    {
        $fields_list = array(
            'id_address' => array(
                'title' => $this->module->l('ID','brands'),
                'width' => 40,
                'type' => 'text',
            ),
            'name'=> array(
                'title' => $this->module->l('Name','brands'),
                'type'=>'text',
            ),
            'address1' => array(
                'title' => $this->module->l('Address','brands'),
                'type' => 'text',
            ),
            'address2' => array(
                'title' => $this->module->l('Address(2)','brands'),
                'type' => 'text',
            ),
            'city' => array(
                'title' => $this->module->l('City','brands'),
                'type' => 'text',
            ),
            'state_name' => array(
                'title'=> $this->module->l('State','brands'),
                'type'=>'text',
            ),
            'phone' => array(
                'title'=> $this->module->l('Home phone','brands'),
                'type'=>'text',
            ),
            'phone_mobile' => array(
                'title'=> $this->module->l('Mobile phone','brands'),
                'type'=>'text',
            ),
            'other' => array(
                'title'=> $this->module->l('Other','brands'),
                'type'=>'text',
            ),
            
        );
        //Filter
        $show_resset = false;
        //Paggination
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $sort_type = Tools::getValue('sort_type','desc');
        $sort_value = Tools::getValue('sort','id_address');
        $totalRecords = (int) Ets_mp_seller::getAddressManufacturer($id_manufacturer,0,0,true);
        $paggination = new Ets_mp_paggination_class();            
        $paggination->total = $totalRecords;
        $paggination->url =$this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$id_manufacturer, 'page'=>'_page_')).$this->module->getFilterParams($fields_list,'mp_address');
        if($limit = (int)Tools::getValue('paginator_address_select_limit'))
            $this->context->cookie->paginator_address_select_limit = $limit;
        $paggination->limit =  $this->context->cookie->paginator_address_select_limit  ? : 10;
        $paggination->name ='address';
        $paggination->num_links =5;
        $totalPages = ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if($start < 0)
            $start = 0;
        $addresss = Ets_mp_seller::getAddressManufacturer($id_manufacturer,$start,$paggination->limit,false);
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','brands');
        $paggination->style_links = 'links';
        $paggination->style_results = 'results';
        $listData = array(
            'name' => 'mp_address',
            'actions' => array('view', 'delete'),
            'currentIndex' => $this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$id_manufacturer)).($paggination->limit!=10 ? '&paginator_address_select_limit='.$paggination->limit:''),
            'postIndex' => $this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$id_manufacturer)),
            'identifier' => 'id_address',
            'show_toolbar' => false,
            'show_action' => true,
            'title' => $this->module->l('Addresses','brands'),
            'fields_list' => $fields_list,
            'field_values' => $addresss,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list,'mp_address'),
            'show_reset' =>$show_resset,
            'totalRecords' => $totalRecords,
            'sort'=> $sort_value,
            'show_add_new'=> true,
            'link_new' => $this->context->link->getModuleLink($this->module->name,'brands',array('addnewAddress'=>1,'id_manufacturer'=>$id_manufacturer)),
            'sort_type' => $sort_type,
        );           
        return $this->module->renderList($listData);
    }
    public function renderListProducts($id_manufacturer)
    {
        $fields_list = array(
            'id_product' => array(
                'title' => $this->module->l('ID','brands'),
                'width' => 40,
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'image' => array(
                'title' => $this->module->l('Image','brands'),
                'type'=>'text',
                'sort' => false,
                'filter' => false,
                'strip_tag'=> false,
            ),
            'name' => array(
                'title' => $this->module->l('Product name','brands'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=>false,
            ),
            'reference' => array(
                'title' => $this->module->l('Reference','brands'),
                'type' => 'text',
                'sort' => true,
                'filter' => true
            ),
            'default_category' => array(
                'title' => $this->module->l('Default category','brands'),
                'type' => 'text',
                'sort' => true,
                'filter' => true
            ),
            'price' => array(
                'title' => $this->module->l('Price','brands'),
                'type' => 'int',
                'sort' => true,
                'filter' => true
            ),
            'active' => array(
                'title' => $this->module->l('Active','brands'),
                'type' => 'active',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
                'filter_list' => array(
                    'id_option' => 'active',
                    'value' => 'title',
                    'list' => array(
                        0 => array(
                            'active' => 1,
                            'title' => $this->module->l('Yes','brands')
                        ),
                        1 => array(
                            'active' => 0,
                            'title' => $this->module->l('No','brands')
                        )
                    )
                )
            ),
        );
        //Filter
        $show_resset = false;
        $filter = "";
        if(($id_manufacturer = Tools::getValue('id_manufacturer')) || $id_manufacturer!='')
        {
            if(Validate::isUnsignedId($id_manufacturer))
                $filter.= ' AND p.id_manufacturer='.(int)$id_manufacturer;
        }
        if(($id_product = Tools::getValue('id_product')) || $id_product!='')
        {
            if(Validate::isUnsignedId($id_product))
                $filter .= ' AND p.id_product="'.(int)$id_product.'"';
            $show_resset = true;
        }
        if(($name = Tools::getValue('name')) || $name !='')
        {
            if(Validate::isCleanHtml($name))
                $filter .=' AND pl.name LIKE "%'.pSQL($name).'%"';
            $show_resset = true;
        }
        if(($reference = trim(Tools::getValue('reference'))) || $reference!='')
        {
            if(Validate::isCleanHtml($reference))
                $filter .=' AND p.reference LIKE "%'.pSQL($reference).'%"';
            $show_resset = true;
        }
        if(($default_category = trim(Tools::getValue('default_category'))) || $default_category!='')
        {
            if(Validate::isCleanHtml($default_category))
                $filter .=' AND cl.name LIKE "%'.pSQL($default_category).'%"';
            $show_resset = true;
        }
        if(($price_min=trim(Tools::getValue('price_min'))) || $price_min!='')
        {
            if(Validate::isFloat($price_min))
                $filter .= ' AND product_shop.price >= "'.(float)Tools::convertPrice($price_min,null,false).'"';
            $show_resset = true;
        }
        if(($price_max =trim(Tools::getValue('price_max'))) || $price_max!='')
        {
            if(Validate::isFloat($price_max))
                $filter .= ' AND product_shop.price <= "'.(float)Tools::convertPrice($price_max,null,false).'"';
            $show_resset = true;
        }
        if(($active = trim(Tools::getValue('active'))) || $active!='')
        {
            if(Validate::isInt($active))
                $filter .= ' AND product_shop.active="'.(int)$active.'"';
            $show_resset=true;
        }
        //Sort
        $sort = "";
        $sort_type=Tools::getValue('sort_type','desc');
        $sort_value = Tools::getValue('sort','id_product');
        if($sort_value)
        {
            switch ($sort_value) {
                case 'id_product':
                    $sort .='p.id_product';
                    break;
                case 'name':
                    $sort .='pl.name';
                    break;
                case 'reference':
                    $sort .= 'p.reference';
                    break;
                case 'default_category':
                    $sort .= 'pl.name';
                    break;
                case 'shop_name':
                    $sort .= 'r.shop_name';
                    break;
                case 'price':
                    $sort .= 'product_shop.price';
                    break;
                case 'active':
                    $sort .='p.active';
                    break;
            }
            if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                $sort .= ' '.trim($sort_type);  
        }
        //Paggination
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $totalRecords = (int) $this->seller->getProducts($filter,0,0,'',true);
        $paggination = new Ets_mp_paggination_class();            
        $paggination->total = $totalRecords;
        $paggination->url =$this->context->link->getModuleLink($this->module->name,'brands',array('view'=>true,'id_manufacturer'=>$id_manufacturer, 'page'=>'_page_')).$this->module->getFilterParams($fields_list,'mp_front_products');
        if($limit = (int)Tools::getValue('paginator_product_select_limit'))
            $this->context->cookie->paginator_product_select_limit = $limit;
        $paggination->limit =  $this->context->cookie->paginator_product_select_limit ? :10;
        $paggination->name ='product';
        $paggination->num_links =5;
        $totalPages = ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $products = $this->seller->getProducts($filter,$page,$paggination->limit,$sort,false);
        if($products)
        {
            if(version_compare(_PS_VERSION_, '1.7', '>='))
                $type_image= ImageType::getFormattedName('home');
            else
                $type_image= ImageType::getFormatedName('home');
            foreach($products as &$product)
            {
                $product['price'] = Tools::displayPrice($product['price']);
                if($product['id_image'])
                {
                    $product['image'] = Ets_mp_defines::displayText(Ets_mp_defines::displayText('','img','width_80','','','',$this->context->link->getImageLink($product['link_rewrite'],$product['id_image'],$type_image)),'a','','',$this->context->link->getProductLink($product['id_product']));
                }
                else
                    $product['image']='';
                $product['name'] = Ets_mp_defines::displayText($product['name'],'a','','',$this->context->link->getProductLink($product['id_product']));
                $product['action_edit']=false;
            }
        }
        
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','brands');
        $paggination->style_links = $this->module->l('links','brands');
        $paggination->style_results = $this->module->l('results','brands');
        $listData = array(
            'name' => 'mp_front_products',
            'actions' =>array('view'),
            'currentIndex' => $this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$id_manufacturer)).($paggination->limit!=10 ? '&paginator_product_select_limit='.$paggination->limit:''),
            'postIndex' => $this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$id_manufacturer)),
            'identifier' => 'id_product',
            'show_toolbar' => true,
            'show_action' => true,
            'title' => $this->module->l('Products','brands'),
            'fields_list' => $fields_list,
            'field_values' => $products,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list,'mp_front_products'),
            'show_reset' =>$show_resset,
            'totalRecords' => $totalRecords,
            'show_add_new'=> false,
            'sort'=> $sort_value,
            'sort_type' => $sort_type,
        );          
        return $this->module->renderList($listData);
    }
    public function renderManufacturerAddressForm()
    {
        $languages = Language::getLanguages(false);
        $valueFieldPost = array();
        $id_manufacturer = (int)Tools::getValue('id_manufacturer');
        if (($id_address = Tools::getValue('id_address')) && Validate::isUnsignedId($id_address))
        {
            $address = new Address($id_address);
            if(Validate::isLoadedObject($address) && (!$address->id_manufacturer || !Validate::isLoadedObject(new Manufacturer($address->id_manufacturer)) || !$this->seller->checkHasManufacturer($address->id_manufacturer,false)))
                die($this->module->l('You do not have permission to configure this address','brands'));
        }
        else
            $address = new Address();
        $countries = Country::getCountries($this->context->language->id, true, false, false);
        if ($countries) {
            foreach ($countries as &$country) {
                $country['id'] = $country['id_country'];
            }
        }
        $states = State::getStates($this->context->language->id, true);
        if ($states)
        {
            foreach($states as &$state)
            {
                $state['id'] = $state['id_state'];
                $state['parent'] = $state['id_country'];
            }
        }
        $fields = array(
            array(
                'type'=>'text',
                'label' => $this->module->l('First name','brands'),
                'name'=> 'firstname',
                'required' => true,
                'desc' => $this->module->l('Invalid characters: 0-9!<>,;?=+()@#"?{}_$%:','brands'),
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('Last name','brands'),
                'name'=>'lastname',
                'required' => true,
                'desc' => $this->module->l('Invalid characters: 0-9!<>,;?=+()@#"?{}_$%:','brands'),
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('Address','brands'),
                'name'=>'address1',
                'required' => true,
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('Address(2)','brands'),
                'name'=>'address2',
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('Zip/postal code ','brands'),
                'name'=>'postcode',
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('City','brands'),
                'name'=>'city',
                'required' => true,
            ),
            array(
                'type'=>'select',
                'label'=>$this->module->l('Country','brands'),
                'name'=>'id_country',
                'required' => true, 
                'form_group_class' => 'js-manufacturer-address-country', 
                'values'=>$countries,
            ),
            array(
                'type'=>'select',
                'label'=>$this->module->l('State','brands'),
                'name'=>'id_state',
                'required' => true, 
                'form_group_class' => 'js-manufacturer-address-state', 
                'values'=>$states,
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('Home phone','brands'),
                'name'=>'phone',
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('Mobile phone','brands'),
                'name'=>'phone_mobile',
            ),
            array(
                'type' =>'text',
                'label'=> $this->module->l('Other','brands'),
                'name'=>'other',
                'desc' => $this->module->l('Invalid characters: <>{}','brands')
            ),
        );
        foreach($fields as $field)
        {
           $valueFieldPost[$field['name']] = Tools::getValue($field['name'],$address->{$field['name']});
        }
        $this->context->smarty->assign(
            array(
                'fields' => $fields,
                'languages' => $languages,
                'valueFieldPost' => $valueFieldPost,
                'id_lang_default' => Configuration::get('PS_LANG_DEFAULT'),
            )
        );
        $html_form = $this->module->displayTpl('form.tpl');
        $this->context->smarty->assign(
            array(
                'url_path' => $this->module->getBaseLink().'/modules/'.$this->module->name.'/',
                'html_form' => $html_form,
                'id_address' => $id_address,
                'id_manufacturer' => $id_manufacturer,
                'manufacturer' => new Manufacturer($id_manufacturer),
                'link_cancel' => $this->context->link->getModuleLink($this->module->name,'brands',array('view'=>1,'id_manufacturer'=>$id_manufacturer))
            )
        );
        return $this->module->displayTpl('brand/address_form.tpl');
    }
 }