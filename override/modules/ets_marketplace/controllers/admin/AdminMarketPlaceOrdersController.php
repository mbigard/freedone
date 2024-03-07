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

if (!defined('_PS_VERSION_'))
    	exit;

class AdminMarketPlaceOrdersControllerOverride extends AdminMarketPlaceOrdersController
{
    public $fieldsList;

    public function init()
    {
        parent::init();

        $orderStates = OrderState::getOrderStates($this->context->language->id);
        $this->fieldsList =  array(
            'id_order' => array(
                'title' => $this->l('ID'),
                'width' => 40,
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'class'=>'text-center'
            ),
            'reference'=>array(
                'title' => $this->l('Order reference'),
                'type'=> 'text',
                'sort' => true,
                'filter' => true,
            ),
            'customer_name' => array(
                'title' => $this->l('Customer'),
                'type'=> 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=>false,
            ),
            'asso_freedone' => array(
                'title' => $this->l('Association freedone'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=>false,
            ),
            'other_asso' => array(
                'title' => $this->l('Autre association'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=>false,
            ),
            'code_asso' => array(
                'title' => $this->l('Code asso'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=>false,
            ),
            'total_paid_tax_incl' => array(
                'title' => $this->l('Total price (tax incl)'),
                'type' => 'int',
                'sort' => true,
                'filter' => true,
                'class'=>'text-center'
            ),
            'percentage_asso' => array(
                'title' => $this->l('% reversé'),
                'type' => 'string',
                'sort' => true,
                'filter' => true,
                'class'=>'text-center'
            ),
            'amount_asso' => array(
                'title' => $this->l('Montant reversé'),
                'type' => 'int',
                'sort' => true,
                'filter' => true,
                'class'=>'text-center'
            ),
            'seller_name' => array(
                'title' => $this->l('Seller name'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=>false,
            ),
            'shop_name' => array(
                'title' => $this->l('Shop name'),
                'type' => 'text',
                'sort' => true,
                'filter' => true,
                'strip_tag'=>false
            ),
            'total_commission' => array(
                'title' => $this->l('Seller commissions'),
                'type' => 'text',
                'sort' => true,
            ),
            'admin_earned' => array(
                'title' => $this->l('Admin earned'),
                'type' => 'text',
                'sort' => true,
            ),
            'current_state' => array(
                'title' => $this->l('Status'),
                'type' => 'select',
                'sort' => true,
                'filter' => true,
                'strip_tag' => false,
                'filter_list' => array(
                    'list' => $orderStates,
                    'id_option' => 'id_order_state',
                    'value' => 'name',
                ),
            ),
            'date_add' => array(
                'title' => $this->l('Date'),
                'type' => 'date',
                'sort' => true,
                'filter' => true
            ),
        );
        $this->table = "marketplace_orders";
    }

    public function _renderOrders()
    {
        $page = (int)Tools::getValue('page');
        if($page<=0)
            $page = 1;
        $limit = (int)Tools::getValue('paginator_order_select_limit',20);
        $sort_type = Tools::strtolower(Tools::getValue('sort_type','desc'));
        $sort_value = Tools::strtolower(Tools::getValue('sort','id_order'));

         // Export
        if (Tools::isSubmit('customExport')) {
            $orders = Ets_mp_commission::getOrders(
                $this->context->cookie->__get('marketplace_orders_filter', ''),
                $this->context->cookie->__get('marketplace_orders_having', ''), 
                $this->context->cookie->__get('marketplace_orders_start', 0), 
                $this->context->cookie->__get('marketplace_orders_pagination', ''), 
                $this->context->cookie->__get('marketplace_orders_sort', ''), 
                false
            );
            $totalFreedone = $totalOther = 0;
            self::formatOrders($orders, $totalFreedone, $totalOther);
            $this->customExport($orders);
        }

        if(!Tools::isSubmit('ets_mp_submit_ms_orders') && $page==1 && $sort_type=='desc' && $sort_value=='id_order')
        {
            $cacheID = $this->module->_getCacheId(array('orders',$limit));
        }
        else
            $cacheID = null;
        if(!$cacheID || !$this->module->isCached('admin/base_list.tpl',$cacheID))
        {
            //Filter
            $show_resset = false;
            $filter = "";
            $having = "";
            if(Tools::isSubmit('ets_mp_submit_ms_orders'))
            {
                if(($id_order = Tools::getValue('id_order')) && !Tools::isSubmit('del'))
                {
                    if(Validate::isUnsignedId($id_order))
                        $filter .= ' AND o.id_order="'.(int)$id_order.'"';
                    $show_resset = true;
                }
                if(($seller_name = Tools::getValue('seller_name')) || $seller_name!='')
                {
                    if(Validate::isCleanHtml($seller_name))
                        $filter .= ' AND CONCAT(customer.firstname," ",customer.lastname) like "%'.pSQL($seller_name).'%"';
                    $show_resset =true;
                }
                if(($customer_name = Tools::getValue('customer_name')) || $customer_name!='' )
                {
                    if(Validate::isCleanHtml($customer_name))
                        $filter .= ' AND CONCAT(c.firstname," ",c.lastname) like "%'.pSQL($customer_name).'%"';
                    $show_resset = true;
                }
                if(($shop_name = Tools::getValue('shop_name')) || $shop_name)
                {
                    if(Validate::isCleanHtml($shop_name))
                        $filter .= ' AND sl.shop_name like "%'.pSQL($shop_name).'%"';
                    $show_resset = true;
                }
                if(($total_commission=  Tools::getValue('total_commission')) || $total_commission!='')
                {
                    if(Validate::isFloat($total_commission))
                        $having .=' AND total_commission ="'.(float)$total_commission.'"';
                    $show_resset = true;
                }
                if(($admin_earned = Tools::getValue('admin_earned')) || $admin_earned!='')
                {
                    if(Validate::isFloat($admin_earned))
                        $having .= ' AND admin_earned ="'.(float)$admin_earned.'"';
                    $show_resset = true;
                }
                if(($reference = Tools::getValue('reference')) || $reference!='')
                {
                    if(Validate::isCleanHtml($reference))
                        $filter .=' AND o.reference LIKE "%'.pSQL($reference).'%"';
                    $show_resset = true;
                }
                if(($payment = Tools::getValue('payment')) || $payment!='')
                {
                    if(Validate::isCleanHtml($payment))
                        $filter .=' AND o.payment LIKE "%'.pSQL($payment).'%"';
                    $show_resset = true;
                }
                if(($date_add_min = trim(Tools::getValue('date_add_min'))) || $date_add_min!='')
                {
                    if(Validate::isDate($date_add_min))
                        $filter .=' AND o.date_add >= "'.pSQL($date_add_min).' 00:00:00"';
                    $show_resset = true;
                }
                if(($date_add_max = trim(Tools::getValue('date_add_max'))) || $date_add_max!='')
                {
                    if(Validate::isDate($date_add_max))
                        $filter .= ' AND o.date_add <="'.pSQL($date_add_max).' 23:59:59"';
                    $show_resset=true;
                }
                if(($total_paid_tax_incl_min = trim(Tools::getValue('total_paid_tax_incl_min'))) || $total_paid_tax_incl_min!='')
                {
                    if(Validate::isFloat($total_paid_tax_incl_min))
                        $filter .=' AND o.total_paid_tax_incl >= "'.(float)$total_paid_tax_incl_min.'"';
                    $show_resset = true;
                }
                if(($total_paid_tax_incl_max = trim(Tools::getValue('total_paid_tax_incl_max'))) || $total_paid_tax_incl_max!='')
                {
                    if(Validate::isFloat($total_paid_tax_incl_max))
                        $filter .=' AND o.total_paid_tax_incl <= "'.(float)$total_paid_tax_incl_max.'"';
                    $show_resset = true;
                }
                if(($current_state = trim(Tools::getValue('current_state'))) || $current_state!='')
                {
                    if(Validate::isUnsignedId($current_state))
                        $filter .=' AND o.current_state = "'.(int)$current_state.'"';
                    $show_resset = true;
                }
            }
            //Sort
            $sort = "";
            if($sort_value)
            {
                switch ($sort_value) {
                    case 'id_order':
                        $sort .='o.id_order';
                        break;
                    case 'seller_name':
                        $sort .='seller_name';
                        break;
                    case 'reference':
                        $sort .='o.reference';
                        break;
                    case 'customer_name':
                        $sort .='customer_name';
                        break;
                    case 'shop_name':
                        $sort .='shop_name';
                        break;
                    case 'date_add':
                        $sort .= 'o.date_add';
                        break;
                    case 'total_paid_tax_incl':
                        $sort .= 'o.total_paid_tax_incl';
                        break;
                    case 'total_commission':
                        $sort .='total_commission';
                        break;
                    case 'admin_earned':
                        $sort .='admin_earned';
                        break;
                    case 'payment':
                        $sort .= 'o.payment';
                        break;
                    case 'current_state':
                        $sort .= 'o.current_state';
                        break;
                }
                if($sort && $sort_type && in_array($sort_type,array('asc','desc')))
                    $sort .= ' '.trim($sort_type);
            }
            //Paggination
            $totalRecords = (int)Ets_mp_commission::getOrders($filter,$having,0,0,'',true);
            $paggination = new Ets_mp_paggination_class();
            $paggination->total = $totalRecords;
            $paggination->url = $this->context->link->getAdminLink('AdminMarketPlaceOrders').'&page=_page_'.$this->module->getFilterParams($this->fieldsList,'ms_orders');
            $paggination->limit =  $limit;
            $paggination->name ='order';
            $totalPages = ceil($totalRecords / $paggination->limit);
            if($page > $totalPages)
                $page = $totalPages;
            $paggination->page = $page;
            $start = $paggination->limit * ($page - 1);
            if($start < 0)
                $start = 0;
            $orders = Ets_mp_commission::getOrders($filter,$having, $start,$paggination->limit,$sort,false);

            $this->context->cookie->__set('marketplace_orders_filter', $filter);
            $this->context->cookie->__set('marketplace_orders_having', $having);
            $this->context->cookie->__set('marketplace_orders_start', $start);
            $this->context->cookie->__set('marketplace_orders_pagination', $paggination->limit);
            $this->context->cookie->__set('marketplace_orders_sort', $sort);

            if($orders)
            {
                $totalFreedone = $totalOther = 0;
                self::formatOrders($orders, $totalFreedone, $totalOther);
            }

            $paggination->text =  $this->l('Showing {start} to {end} of {total} ({pages} Pages)');
            $paggination->style_links = $this->l('links');
            $paggination->style_results = $this->l('results');
            $listData = array(
                'name' => 'ms_orders',
                'actions' => array('view'),
                'icon' => 'icon-orders',
                'currentIndex' => $this->context->link->getAdminLink('AdminMarketPlaceOrders').($paggination->limit!=20 ? '&paginator_order_select_limit='.$paggination->limit:''),
                'postIndex' => $this->context->link->getAdminLink('AdminMarketPlaceOrders'),
                'identifier' => 'id_order',
                'show_toolbar' => true,
                'show_action' => true,
                'title' => $this->l('Orders'),
                'fields_list' => $this->fieldsList,
                'field_values' => $orders,
                'paggination' => $paggination->render(),
                'filter_params' => $this->module->getFilterParams($this->fieldsList,'ms_orders'),
                'show_reset' =>$show_resset,
                'totalRecords' => $totalRecords,
                'sort'=> $sort_value,
                'show_add_new'=> false,
                'sort_type' => $sort_type,
                'total_other' => Tools::displayPrice($totalOther, new Currency(Configuration::get('PS_CURRENCY_DEFAULT'))),
                'total_freedone' => Tools::displayPrice($totalFreedone, new Currency(Configuration::get('PS_CURRENCY_DEFAULT'))),
                'link_export' => Context::getContext()->link->getAdminLink('AdminMarketPlaceOrders', true, [], ['customExport' => true])
            );
            $this->context->smarty->assign(
                array(
                    'list_content' => $this->module->renderList($listData),
                )
            );
        }

        return $this->module->fetch(__DIR__.'/../../views/templates/hook/admin/base_list.tpl');
    }

    protected function formatOrders(&$orders, &$totalFreedone, &$totalOther)
    {
        foreach($orders as &$order)
        {
            $order['total_paid_tax_incl'] = Tools::displayPrice(Tools::convertPrice($order['total_paid_tax_incl'],$order['id_currency'],false), new Currency(Configuration::get('PS_CURRENCY_DEFAULT')));
            $order['total_commission'] = Tools::displayPrice($order['total_commission'], new Currency(Configuration::get('PS_CURRENCY_DEFAULT')));
            $order['admin_earned'] = Tools::displayPrice($order['admin_earned'] - ($order['total_products_wt'] * (float)$this->getPercentageAssoByIdOrder($order['id_order']) / 100), new Currency(Configuration::get('PS_CURRENCY_DEFAULT')));
            $order['current_state'] = $this->module->displayOrderState($order['current_state']);
            $order['child_view_url'] = $this->module->getLinkOrderAdmin($order['id_order']);
            if($order['id_order_seller'])
            {
                if(!$order['id_seller'])
                {
                    $order['shop_name']= Ets_mp_defines::displayText($this->l('Shop deleted'),'span','deleted_shop row_deleted');
                }
                else
                {
                    $order['shop_name'] = Ets_mp_defines::displayText($order['shop_name'],'a','ets_mp_shopname','',$this->module->getShopLink(array('id_seller'=>$order['id_seller'])),'_blank');

                }
                if($order['id_customer_seller'])
                {
                    $order['seller_name'] = Ets_mp_defines::displayText($order['seller_name'],'a','','',$this->module->getLinkCustomerAdmin($order['id_customer_seller']));
                }
                else
                    $order['seller_name'] = Ets_mp_defines::displayText($this->l('Seller deleted'),'span','row_deleted');
            }
            else
            {
                $order['seller_name'] ='--';
                $order['shop_name'] ='--';
            }
            $order['customer_name'] = Ets_mp_defines::displayText($order['customer_name'],'a','','',$this->module->getLinkCustomerAdmin($order['id_customer']));
            // Added by mbigard
            $id_code_asso = $this->getIdAssoByIdOrder($order['id_order']);

            $order['asso_freedone'] = (empty($id_code_asso)) ? 'Freedone' : '';
            $order['other_asso'] = (!empty($id_code_asso)) ? $this->getAssoNameById($id_code_asso) : '';
            $order['code_asso'] = (!empty($id_code_asso)) ? $this->getCodeAssoById($id_code_asso) : '';
            $order['percentage_asso'] = $this->getPercentageAssoByIdOrder($order['id_order']);
            $order['amount_asso'] = Tools::displayPrice($order['total_products_wt'] * (float)$this->getPercentageAssoByIdOrder($order['id_order']) / 100, new Currency(Configuration::get('PS_CURRENCY_DEFAULT')));

            if ($order['asso_freedone'] == 'Freedone') {
                $totalFreedone += $order['total_products_wt'] * (float)$order['percentage_asso'] / 100;
            } else {
                $totalOther += $order['total_products_wt'] * (float)$order['percentage_asso'] / 100;
            }
        }
    }

    public function getAssoNameById($id) {
        return Db::getInstance()->getValue('SELECT `name` FROM '._DB_PREFIX_.'mb_associations WHERE id_association = '.pSQL($id));
    }

    public function getIdAssoByIdOrder($idOrder) {
        $id_code_association = Db::getInstance()->executeS('SELECT `id_code_association` FROM '._DB_PREFIX_.'cart c LEFT JOIN '._DB_PREFIX_.'orders o ON o.id_cart = c.id_cart WHERE id_order = '.pSQL($idOrder));

        if (isset($id_code_association[0])) {
            return $id_code_association[0]['id_code_association'];
        }

        return 0;
    }

    public function getPercentageAssoByIdOrder($idOrder) {
        $id_code_association = Db::getInstance()->executeS('SELECT `code_association_percentage` FROM '._DB_PREFIX_.'cart c LEFT JOIN '._DB_PREFIX_.'orders o ON o.id_cart = c.id_cart WHERE id_order = '.pSQL($idOrder));

        if (isset($id_code_association[0])) {
            return $id_code_association[0]['code_association_percentage'];
        }

        return 0;
    }

    public function getCodeAssoById($id) {
        return Db::getInstance()->getValue('SELECT `code` FROM '._DB_PREFIX_.'mb_associations WHERE id_association = '.pSQL($id));
    }

    public function customExport($orders, $text_delimiter = '"') {
        // clean buffer
        if (ob_get_level() && ob_get_length() > 0) {
            ob_clean();
        }

        if (!count($orders)) {
            return;
        }

        header('Content-type: text/csv');
        header('Content-Type: application/force-download; charset=UTF-8');
        header('Cache-Control: no-store, no-cache');
        header('Content-disposition: attachment; filename="' . $this->table . '_' . date('Y-m-d_His') . '.csv"');

        $fd = fopen('php://output', 'wb');
        $headers = [];
        $fields_list = $this->fieldsList;
        foreach ($fields_list as $key => $datas) {
            if ('PDF' === $datas['title']) {
                unset($fields_list[$key]);
            } else {
                if ('ID' === $datas['title']) {
                    $headers[] = strtolower(Tools::htmlentitiesDecodeUTF8($datas['title']));
                } else {
                    $headers[] = Tools::htmlentitiesDecodeUTF8($datas['title']);
                }
            }
        }
        fputcsv($fd, $headers, ';', $text_delimiter);
        foreach ($orders as $i => $row) {
            $content = [];
            foreach ($fields_list as $key => $params) {
                $field_value = isset($row[$key]) ? Tools::htmlentitiesDecodeUTF8(Tools::nl2br($row[$key])) : '';
                if ($key == 'image') {
                    if ($params['image'] != 'p' || Configuration::get('PS_LEGACY_IMAGES')) {
                        $path_to_image = Tools::getShopDomain(true) . _PS_IMG_ . $params['image'] . '/' . $row['id_' . $this->table] . (isset($row['id_image']) ? '-' . (int) $row['id_image'] : '') . '.' . $this->imageType;
                    } else {
                        $path_to_image = Tools::getShopDomain(true) . _PS_IMG_ . $params['image'] . '/' . Image::getImgFolderStatic($row['id_image']) . (int) $row['id_image'] . '.' . $this->imageType;
                    }
                    $field_value = $path_to_image;
                }
                if (in_array($key, [
                    'customer_name',
                    'current_state',
                    'seller_name',
                    'shop_name'
                ])) {
                    preg_match('/>(.*)<\//', $row[$key], $matches);
                    if (!empty($matches[1])) {
                        $content[] = $matches[1];
                    } else {
                        $content[] = '';
                    }
                    continue;
                }
                if (isset($params['callback'])) {
                    $callback_obj = (isset($params['callback_object'])) ? $params['callback_object'] : $this->context->controller;
                    if (!preg_match('/<([a-z]+)([^<]+)*(?:>(.*)<\/\1>|\s+\/>)/ism', call_user_func_array([$callback_obj, $params['callback']], [$field_value, $row]))) {
                        $field_value = call_user_func_array([$callback_obj, $params['callback']], [$field_value, $row]);
                    }
                }
                $content[] = $field_value;
            }

            fputcsv($fd, $content, ';', $text_delimiter);
        }
        @fclose($fd);
        die;
    }
}