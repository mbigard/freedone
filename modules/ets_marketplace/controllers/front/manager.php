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
 * Class Ets_MarketPlaceManagerModuleFrontController
 * @property \Ets_mp_seller $seller
 * * @property \Ets_marketplace $module
 */
class Ets_MarketPlaceManagerModuleFrontController extends ModuleFrontController
{
    public $seller;
    public $_success;
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
            Tools::redirect($this->context->link->getModuleLink($this->module->name,'myseller'));
        if($this->context->cookie->success)
        {
            $this->_success = $this->context->cookie->success;
            $this->context->cookie->success= '';
        }    
        if(Tools::isSubmit('searchCustomerByEmail') && ($email= Tools::getValue('email')) && Validate::isCleanHtml($email))
        {
            $customers = Customer::getCustomersByEmail($email);
            $customer_name ='';
            if($customers)
            {
                foreach($customers as $customer)
                {
                    if($customer && !$customer['is_guest'] && !$customer['deleted'] && $customer['active'])
                    {
                        $customer_name = $customer['firstname'].' '.$customer['lastname'];
                        break;
                    }
                }

            }
            die(
                json_encode(
                    array(
                        'customer_name' => $this->module->l('Customer name:','manager').' '.$customer_name,
                    )
                )
            );
        }
    }
    public function getCustomerByEmail($email)
    {
        $customers = Customer::getCustomersByEmail($email);
        if($customers)
        {
            foreach($customers as $customer)
            {
                if(!$customer['is_guest'] && !$customer['deleted'] && $customer['active'])
                    return $customer;
            }
        }
        return false;
    }
    public function initContent()
	{
		parent::initContent();
        $id_ets_mp_seller_manager = (int)Tools::getValue('id_ets_mp_seller_manager');
        if(Tools::isSubmit('submitSaveManagerShop'))
        {
            if(!($email = Tools::getValue('email')))
                $this->module->_errors[] = $this->module->l('Email is required','manager');
            elseif(!Validate::isEmail($email))
                $this->module->_errors[] = $this->module->l('Email is not valid','manager');
            elseif(!($customer = $this->getCustomerByEmail($email)))
                $this->module->_errors[] = $this->module->l('There is no existing account corresponding to the entered email','manager');
            elseif(Ets_mp_seller::checkSellerByEmail($email))
                $this->module->_errors[] = $this->module->l('There is already an existing seller account with the entered email','manager');
            elseif(Ets_mp_manager::checkExistSellerMangerByEmail($email,$id_ets_mp_seller_manager))
                $this->module->_errors[] = $this->module->l('This user has been assigned with shop manager role','manager');
            $permission = Tools::getValue('permission');
            if(!$permission)
                $this->module->_errors[]= $this->module->l('Permission is required','manager');
            elseif(!Ets_marketplace::validateArray($permission))
                $this->module->_errors[]= $this->module->l('Permission is not valid','manager');
            if($id_ets_mp_seller_manager && !Ets_mp_manager::checkExistSellerMangerByIDCustomer($this->context->customer->id,$id_ets_mp_seller_manager))
                $this->module->_errors[]= $this->module->l('You do not have permission','manager');
            if(!$this->module->_errors)
            {
                if(($id_manager = Tools::getValue('id_ets_mp_seller_manager')) && Validate::isUnsignedId($id_manager))
                    $manager = new Ets_mp_manager($id_manager);
                else
                    $manager = new Ets_mp_manager();
                
                $manager->id_user = $customer['id_customer'];
                $user = new Customer($manager->id_user);
                $manager->permission = implode(',',$permission);
                if(!$manager->id)
                {
                    $manager->active = -1;
                    $manager->id_customer = $this->seller->id_customer;
                    $manager->email = $email;
                }
                $delete_product = (int)Tools::getValue('delete_product');
                $manager->delete_product = $delete_product;
                $template_vars =array(
                        '{customer_name}' => $user->firstname.' '.$user->lastname,
                        '{seller_name}' => $this->seller->seller_name,
                        '{permission}' => $this->displayPermission($manager->permission),
                        '{link_account}' => $this->context->link->getPageLink('my-account'),
                );
                if($manager->id)
                {
                    if($manager->update())
                    {
                        $success = $this->module->l('Updated manager successfully','manager');
                    }
                    else
                    {
                        die(json_encode(
                            array(
                                'errors' => $this->module->l('An error occurred while saving the manager','manager'),
                            )
                        ));
                    }
                    
                }
                else
                {
                    if($manager->add())
                    {
                        $subjects = array(
                            'translation' => $this->module->l('Invitation to become store manager','manager'),
                            'origin'=> 'Invitation to become store manager',
                            'specific'=>'manager'
                        );
                        Ets_marketplace::sendMail('shop_manager',$template_vars,$manager->email,$subjects,$user->firstname.' '.$user->lastname);
                        $success = $this->module->l('Added manager successfully','manager');
                    }
                    else
                    {
                        die(json_encode(
                            array(
                                'errors' =>  $this->module->l('An error occurred while creating the manager','manager'),
                            )
                        ));
                    }
                }
                if(isset($success) && $success)
                {
                    if($manager->active==-1)
                        $active = Ets_mp_defines::displayText($this->module->l('Pending','manager'),'span','ets_mp_status pending');
                    elseif($manager->active==0)
                        $active = Ets_mp_defines::displayText($this->module->l('Declined','manager'),'span','ets_mp_status declined');
                    elseif($manager->active==1)
                        $active = Ets_mp_defines::displayText($this->module->l('Approved','manager'),'span','ets_mp_status approved');
                    die(json_encode(
                        array(
                            'success' => $success,
                            'id_manager' => $manager->id,
                            'name' => $user->firstname.' '.$user->lastname,
                            'email' => $manager->email,
                            'permission' => $this->displayPermission($manager->permission), 
                            'active' => $active,
                            'link_edit' => $this->context->link->getModuleLink($this->module->name,'manager',array('editmp_manager'=>1,'id_ets_mp_seller_manager'=>$manager->id)),
                            'link_delete' => $this->context->link->getModuleLink($this->module->name,'manager',array('del'=>'yes','id_ets_mp_seller_manager'=>$manager->id)),
                        )
                    ));
                }
            }
            else
            {
                $output = '';
                if (is_array($this->module->_errors)) {
                    foreach ($this->module->_errors as $msg) {
                        $output .= $msg . '<br/>';
                    }
                } else {
                    $output .= $this->module->_errors;
                }
                die(
                    json_encode(
                        array(
                            'errors' => Ets_mp_defines::displayText('<svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>'.$output,'div','alert alert-error'),
                        )
                    )  
                );
            }
        }
        if(Tools::isSubmit('del')=='yes' && ($id_manager = $id_ets_mp_seller_manager))
        {
            $manager = new Ets_mp_manager($id_manager);
            if($manager->id_customer == $this->context->customer->id)
            {
                
                if($manager->delete())
                {
                    $this->context->cookie->success = $this->module->l('Deleted successfully');
                    Tools::redirect($this->context->link->getModuleLink($this->module->name,'manager'));
                }
                else
                    $this->module->_errors[] = $this->module->l('An error occurred while deleting the manager','manager');
            }
            else
                die($this->module->l('You do not have permission','manager'));
        }
        $this->context->smarty->assign(
            array(
                'path' => $this->module->getBreadCrumb(),
                'breadcrumb' => $this->module->is17 ? $this->module->getBreadCrumb() : false,
                'html_content' => $this->_initContent(),
            )
        );
        if($this->module->is17)
            $this->setTemplate('module:'.$this->module->name.'/views/templates/front/manager.tpl');      
        else        
            $this->setTemplate('manager_16.tpl');
    }
    public function displayPermission($permission)
    {
        if(Configuration::get('ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT'))
            $product_types = explode(',',Configuration::get('ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT'));
        else
            $product_types = array();
        $permissions = array(
            'dashboard'=>array(
                'name'=> $this->module->l('Dashboard','manager') ,
                'id'=>'dashboard'
            ) ,
            'orders'=>array(
                'name'=> $this->module->l('Orders','manager'),
                'id'=>'orders'
            ),
            'products'=>array(
                'name'=> $this->module->l('Products','manager'),
                'id'=>'products'
            ),
            'stock'=>array(
                'name'=> $this->module->l('Stock','manager'),
                'id'=>'stock'
            ),
            'messages'=>array(
                'name'=> $this->module->l('Messages','manager'),
                'id'=>'messages'
            ),
            'commissions'=>array(
                'name'=> $this->module->l('Commissions','manager'),
                'id'=>'commissions'
            ),
            'billing'=>array(
                'name'=> $this->module->l('Membership','manager') ,
                'id'=>'billing'
            ),
            'attributes'=> array(
                'name'=> in_array('standard_product',$product_types) && $this->module->_use_attribute && $this->module->_use_feature ?  $this->module->l('Attributes and features','manager') : ($this->module->_use_feature ? $this->module->l('Features','manager') : $this->module->l('Attributes','manager')),
                'id'=>'attributes'
            ),
            'brands'=>array(
                'name'=> $this->module->l('Brands','manager') ,
                'id'=>'brands'
            ),
            'suppliers'=>array(
                'name'=> $this->module->l('Suppliers','manager') ,
                'id'=>'suppliers'
            ),
            'ratings'=>array(
                'name'=> $this->module->l('Ratings','manager') ,
                'id'=>'ratings'
            ),
            'profile'=> array(
                'name'=> $this->module->l('Profile','manager') ,
                'id'=>'profile'
            ),
            'carrier' => array(
                'name'=> $this->module->l('Carriers','manager') ,
                'id'=>'carrier'
            ),
            'discount' => array(
                'name'=> $this->module->l('Discounts','manager') ,
                'id'=>'discount'
            ),
            'vacation' => array(
                'name'=> $this->module->l('Vacation mode','manager') ,
                'id'=>'vacation'
            ),
        );
        if(!Configuration::get('ETS_MP_SELLER_CAN_CREATE_VOUCHER'))
            unset($permissions['discount']);
        if(!(in_array('standard_product',$product_types) && $this->module->_use_attribute) && !$this->module->_use_feature)
            unset($permissions['attributes']);
        if(!Configuration::get('ETS_MP_SELLER_CREATE_BRAND') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_BRAND'))
            unset($permissions['brands']);
        if(!Configuration::get('ETS_MP_SELLER_CREATE_SUPPLIER') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_SUPPLIER'))
            unset($permissions['suppliers']);
        if(!Configuration::get('ETS_MP_SELLER_CREATE_SHIPPING') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_SHIPPING'))
            unset($permissions['carrier']);
        if(!Configuration::get('ETS_MP_ALLOW_CONVERT_TO_VOUCHER'))
            unset($permissions['voucher']);
        if(!Configuration::get('ETS_MP_ALLOW_WITHDRAW'))
            unset($permissions['withdraw']);
        if(!Module::isEnabled('productcomments') && !Module::isEnabled('ets_reviews'))
            unset($permissions['ratings']);
        if(!Configuration::get('ETS_MP_ENABLE_CONTACT_SHOP'))
            unset($permissions['messages']); 
        if(!Configuration::get('ETS_MP_VACATION_MODE_FOR_SELLER'))
            unset($permissions['vacation']); 
        $this->context->smarty->assign(
            array(
                'user_permissions' => explode(',',$permission),
                'permissions' => $permissions
            )
        );  
        return $this->module->displayTpl('shop/manager_permission.tpl');
    }
    public function _initContent()
    {
        $id_ets_mp_seller_manager = (int)Tools::getValue('id_ets_mp_seller_manager');
        if(Tools::isSubmit('addnew') || (Tools::isSubmit('editmp_manager') && $id_ets_mp_seller_manager))
        {
            if(!Tools::isSubmit('ajax'))
                return $this->_renderManagerForm();
            else
            {
                die(
                    json_encode(
                        array(
                            'form_html'=> $this->_renderManagerForm(),
                        )
                    )
                );
            }
        }
        $fields_list = array(
            'id_ets_mp_seller_manager' => array(
                'title' => $this->module->l('ID','manager'),
                'width' => 40,
                'type' => 'text',
                'sort' => true,
                'filter' => true,
            ),
            'name'=>array(
                'title' => $this->module->l('Name','manager'),
                'type'=> 'text',
                'sort' => true,
                'filter' => true,
            ),
            'email'=>array(
                'title' => $this->module->l('Email','manager'),
                'type'=> 'text',
                'sort' => true,
                'filter' => true,
            ),
            'permission'=>array(
                'title' => $this->module->l('Permissions','manager'),
                'type'=> 'text',
                'strip_tag' => false,
            ),
            'active' => array(
                'title' => $this->module->l('Status','manager'),
                'type' => 'select',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
                'filter_list' => array(
                    'id_option' => 'active',
                    'value' => 'title',
                    'list' => array(
                        0 => array(
                            'active' => -1,
                            'title' => $this->module->l('Pending','manager')
                        ),
                        1 => array(
                            'active' => 0,
                            'title' => $this->module->l('Declined','manager')
                        ),
                        2 => array(
                            'active' => 1,
                            'title' => $this->module->l('Accepted','manager')
                        )
                    )
                )
            ),
        );
        $show_resset = false;
        $filter = "";
        if($id_ets_mp_seller_manager && !Tools::isSubmit('del'))
        {
            $show_resset = true;
            if(Validate::isInt($id_ets_mp_seller_manager))
                $filter .=' AND m.id_ets_mp_seller_manager="'.(int)$id_ets_mp_seller_manager.'"';            
        }
        if(($name= trim(Tools::getValue('name'))) || $name!='')
        {
            if(Validate::isCustomerName($name))
                $filter .=' AND CONTCAT(c.firtname," ",c.lastname) like "%'.pSQL($name).'%"';
            $show_resset = true;
        }
        if(($email = trim(Tools::getValue('email'))) || $email!='')
        {
            if(Validate::isCleanHtml($email))
                $filter .=' AND m.email like "%'.pSQL($email).'%"';
            $show_resset = true;
        }
        if(($active = trim(Tools::getValue('active'))) || $active!='')
        {
            $show_resset = true;
            if(Validate::isInt($active))
                $filter .=' AND m.active="'.(int)$active.'"';            
        }
        $sort = "";
        $sort_type=Tools::getValue('sort_type');
        $sort_value= Tools::getValue('sort');
        if($sort_value)
        {
            switch ($sort_value) {
                case 'id_ets_mp_seller_manager':
                    $sort .='m.id_ets_mp_seller_manager';
                    break;
                case 'name':
                    $sort .='name';
                    break;
                case 'active':
                    $sort .='m.active';
                    break;
                case 'email':
                    $sort .='m.email';
                    break;
            }
            if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                $sort .= ' '.trim($sort_type);
        }
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $totalRecords = (int)$this->seller->getUserManagers($filter,0,0,'',true);
        $paggination = new Ets_mp_paggination_class();            
        $paggination->total = $totalRecords;
        $paggination->url = $this->context->link->getModuleLink($this->module->name,'manager',array('list'=>1,'page'=>'_page_')).$this->module->getFilterParams($fields_list,'mp_manager');
        if($limit = (int)Tools::getValue('paginator_manager_select_limit'))
            $this->context->cookie->paginator_manager_select_limit = $limit;
        $paggination->limit = $this->context->cookie->paginator_manager_select_limit ? :10;
        $paggination->name ='manager';
        $paggination->num_links =5;
        $totalPages = ceil($totalRecords / $paggination->limit);
        if($page > $totalPages)
            $page = $totalPages;
        $paggination->page = $page;
        $start = $paggination->limit * ($page - 1);
        if($start < 0)
            $start = 0;
        $userManagers = $this->seller->getUserManagers($filter,$start,$paggination->limit,$sort,false);
        if($userManagers)
        {
            foreach($userManagers as &$userManager)
            {
                $userManager['permission'] = $this->displayPermission($userManager['permission']);
                if($userManager['active']==-1)
                {
                    $userManager['active'] = Ets_mp_defines::displayText($this->module->l('Pending','manager'),'span','ets_mp_status pending');
                }
                elseif($userManager['active']==0)
                    $userManager['active'] = Ets_mp_defines::displayText($this->module->l('Declined','manager'),'span','ets_mp_status declined');
                elseif($userManager['active']==1)
                    $userManager['active'] = Ets_mp_defines::displayText($this->module->l('Accepted','manager'),'span','ets_mp_status approved');
            }
        }
        $paggination->text =  $this->module->l('Showing {start} to {end} of {total} ({pages} Pages)','manager');
        $paggination->style_links = 'links';
        $paggination->style_results = 'results';
        $listData = array(
            'name' => 'mp_manager',
            'actions' => array('view','delete'),
            'currentIndex' => $this->context->link->getModuleLink($this->module->name,'manager',array('list'=>1)).($paggination->limit!=10 ? '&paginator_manager_select_limit='.$paggination->limit:''),
            'postIndex' => $this->context->link->getModuleLink($this->module->name,'manager',array('list'=>1)),
            'identifier' => 'id_ets_mp_seller_manager',
            'show_toolbar' => true,
            'show_action' =>true,
            'title' => $this->module->l('Shop managers','manager'),
            'fields_list' => $fields_list,
            'field_values' => $userManagers,
            'paggination' => $paggination->render(),
            'filter_params' => $this->module->getFilterParams($fields_list,'mp_manager'),
            'show_reset' =>$show_resset,
            'totalRecords' => $totalRecords,
            'sort'=> $sort_value,
            'show_add_new'=> true,
            'class'=>'',
            'link_new' => $this->context->link->getModuleLink($this->module->name,'manager',array('addnew'=>1,'ajax'=>1)),
            'sort_type' => $sort_type,
        );
        $output = '';
        if (is_array($this->module->_errors)) {
            foreach ($this->module->_errors as $msg) {
                $output .= $msg . '<br/>';
            }
        } else {
            $output .= $this->module->_errors;
        }
        return ($this->_success ? Ets_mp_defines::displayText('<svg width="20" height="20" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM369 209L241 337c-9.4 9.4-24.6 9.4-33.9 0l-64-64c-9.4-9.4-9.4-24.6 0-33.9s24.6-9.4 33.9 0l47 47L335 175c9.4-9.4 24.6-9.4 33.9 0s9.4 24.6 0 33.9z"/></svg>'.$this->_success,'p','alert alert-success'):'').($this->module->_errors ? Ets_mp_defines::displayText('<svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>'.$output,'div','alert alert-error'):'').$this->module->renderList($listData);
    }
    public function _renderManagerForm()
    {
        if(($id_manager = (int) Tools::getValue('id_ets_mp_seller_manager')) && Validate::isUnsignedId($id_manager))
            $manager = new Ets_mp_manager($id_manager);
        else
            $manager = new Ets_mp_manager();
        $valueFieldPost= array();
        $valueFieldPost['email'] = Tools::getValue('email',$manager->email);
        $valueFieldPost['permission'] = Tools::getValue('permission',$manager->permission ? explode(',',$manager->permission):array());
        $valueFieldPost['delete_product'] = Tools::getValue('delete_product',$manager->delete_product);
        if(Configuration::get('ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT'))
            $product_types = explode(',',Configuration::get('ETS_MP_SELLER_PRODUCT_TYPE_SUBMIT'));
        else
            $product_types = array();
        $permissions = array(
            'dashboard'=> array(
                'name'=> $this->module->l('Dashboard','manager') ,
                'id'=>'dashboard'
            ) ,
            'orders'=> array(
                'name'=> $this->module->l('Orders','manager'),
                'id'=>'orders'
            ),
            'products'=> array(
                'name'=> $this->module->l('Products','manager'),
                'id'=>'products'
            ),
            'stock'=>array(
                'name'=> $this->module->l('Stock','manager'),
                'id'=>'stock'
            ),
            'messages' => array(
                'name'=> $this->module->l('Messages','manager'),
                'id'=>'messages'
            ),
            'commissions'=> array(
                'name'=> $this->module->l('Commissions','manager'),
                'id'=>'commissions'
            ),
            'attributes'=> array(
                'name'=> in_array('standard_product',$product_types) && $this->module->_use_attribute && $this->module->_use_feature ?  $this->module->l('Attributes and features','manager') : ($this->module->_use_feature ? $this->module->l('Features','manager') : $this->module->l('Attributes','manager')),
                'id'=>'attributes'
            ),
            'discount' => array(
                'name'=> $this->module->l('Discounts','manager') ,
                'id'=>'discount'
            ),
            'carrier'=> array(
                'name'=> $this->module->l('Carriers','manager') ,
                'id'=>'carrier'
            ),
            'brands'=> array(
                'name'=> $this->module->l('Brands','manager') ,
                'id'=>'brands'
            ),
            'suppliers'=> array(
                'name'=> $this->module->l('Suppliers','manager') ,
                'id'=>'suppliers'
            ),
            'ratings' => array(
                'name' => $this->module->l('Ratings','manager'),
                'id' => 'ratings',
            ),
            'billing' => array(
                'name'=> $this->module->l('Membership','manager') ,
                'id'=>'billing'
            ),
            'profile'=> array(
                'name'=> $this->module->l('Profile','manager') ,
                'id'=>'profile'
            ),
            'vacation'=> array(
                'name'=> $this->module->l('Vacation mode','manager') ,
                'id'=>'vacation'
            ),
        );
        if(!Configuration::get('ETS_MP_SELLER_CAN_CREATE_VOUCHER'))
            unset($permissions['discount']);
        if(!Configuration::get('ETS_MP_SELLER_CREATE_BRAND') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_BRAND'))
            unset($permissions['brands']);
        if(!Configuration::get('ETS_MP_SELLER_CREATE_SUPPLIER') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_SUPPLIER'))
            unset($permissions['suppliers']);
        if(!Configuration::get('ETS_MP_SELLER_CREATE_SHIPPING') && !Configuration::get('ETS_MP_SELLER_USER_GLOBAL_SHIPPING'))
            unset($permissions['carrier']);
        if(!Configuration::get('ETS_MP_ALLOW_CONVERT_TO_VOUCHER'))
            unset($permissions['voucher']);
        if(!Configuration::get('ETS_MP_ALLOW_WITHDRAW'))
            unset($permissions['withdraw']);
        if(!(in_array('standard_product',$product_types) && $this->module->_use_attribute) && !$this->module->_use_feature)
            unset($permissions['attributes']);
        if(!Module::isEnabled('productcomments') && !Module::isEnabled('ets_reviews'))
            unset($permissions['ratings']);
        if(!Configuration::get('ETS_MP_ENABLE_CONTACT_SHOP'))
            unset($permissions['messages']);
        if(!Configuration::get('ETS_MP_VACATION_MODE_FOR_SELLER'))
            unset($permissions['vacation']);
        $fields = array(
            array(
                'type' => 'text',
                'name' =>'email',
                'label' => $this->module->l('Email','manager'),
                'required' => true,
                'readonly'=> $manager->id ? true : false,
                'autocomplete' => false,
            ),
            array(
                'type' =>'checkbox',
                'name' => 'permission',
                'label' => $this->module->l('Permissions','manager'),
                'values' => $permissions,
                'required' => true,
            ),
            array(
                'type'=>'switch',
                'name' => 'delete_product',
                'label' => $this->module->l('Do you want to allow this account to delete product?','manager'),
                'form_group_class' => 'delete_product'
            )
        );
        $this->context->smarty->assign(
            array(
                'fields' => $fields,
                'languages' => Language::getLanguages(false),
                'valueFieldPost' => $valueFieldPost,
                'id_lang_default' => Configuration::get('PS_LANG_DEFAULT'),
            )
        );
        $html_form = $this->module->displayTpl('form.tpl');
        $this->context->smarty->assign(
            array(
                'html_form' => $html_form,
                'id_ets_mp_seller_manager' => (int)$id_manager,
            )
        );
        return $this->module->displayTpl('manager_form.tpl');
    }
 }