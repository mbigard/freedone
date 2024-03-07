<?php
/**
 * 2007-2021 ETS-Soft
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
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please contact us for extra customization service at an affordable price
 *
 *  @author ETS-Soft <etssoft.jsc@gmail.com>
 *  @copyright  2007-2021 ETS-Soft
 *  @license    EUPL
 *  International Registered Trademark & Property of ETS-Soft
 */

if (!defined('_PS_VERSION_')) { exit; }
class Ets_mp_mailtraciking extends ObjectModel
{
    public $id_ets_mp_mailqueue;
    public $id_customer;
    public $id_employee;
    public $customer_name;
    public $email;
    public $status;
    public $queue_date;
    public $subject;
    public $content;
    public $date_add;
    public static $definition = array(
		'table' => 'ets_mp_mailtraciking',
		'primary' => 'id_ets_mp_mailtraciking',
		'multilang' => false,
		'fields' => array(
            'id_ets_mp_mailqueue' => array('type' => self::TYPE_INT),
            'id_customer' => array('type' => self::TYPE_INT),
            'id_employee' => array('type' => self::TYPE_INT),
            'customer_name' => array('type' => self::TYPE_STRING),
            'email' => array('type' => self::TYPE_STRING),
            'status' => array('type' => self::TYPE_STRING),
            'subject' => array('type' => self::TYPE_STRING),
            'content' => array('type' => self::TYPE_HTML),
            'queue_date' => array('type' => self::TYPE_DATE),
            'date_add' => array('type' => self::TYPE_DATE),
        )
	);
    public	function __construct($id_item = null, $id_lang = null, $id_shop = null)
	{
		parent::__construct($id_item, $id_lang, $id_shop);
	}
    public static function getMailtrackingByQueue($id_ets_mp_mailqueue)
    {
        if(($id_ets_mp_mailtraciking = (int)Db::getInstance()->getValue('SELECT id_ets_mp_mailtraciking FROM `'._DB_PREFIX_.'ets_mp_mailtraciking` WHERE id_ets_mp_mailqueue='.(int)$id_ets_mp_mailqueue)))
        {
            return new Ets_mp_mailtraciking($id_ets_mp_mailtraciking);
        }
        else
        {
            $mailTracking = new Ets_mp_mailtraciking();
            $mailTracking->id_ets_mp_mailqueue = (int)$id_ets_mp_mailqueue;
            return $mailTracking;
        }
    }
    public static function getMailTrackings($filter='',$sort='',$start=0,$limit=10,$total=false)
    {
        if($total)
            return Db::getInstance()->getValue('SELECT COUNT(DISTINCT id_ets_mp_mailtraciking) FROM `'._DB_PREFIX_.'ets_mp_mailtraciking` m WHERE 1 '.($filter ? (string)$filter:''));
        else
        {
           return Db::getInstance()->executeS('SELECT * FROM `'._DB_PREFIX_.'ets_mp_mailtraciking` m WHERE 1 '.($filter ? (string)$filter:'').($sort ? ' ORDER BY '.pSQL($sort): ' ORDER BY m.id_ets_mp_mailtraciking DESC').($limit ? ' LIMIT '.(int)$start.','.(int)$limit.'':''));
        }
    }
    public static function deleteSelected($ids)
    {
        if($ids && is_array($ids))
        {
            return Db::getInstance()->execute('DELETE FROM `'._DB_PREFIX_.'ets_mp_mailtraciking` WHERE id_ets_mp_mailtraciking IN ('.implode(',',array_map('intval',$ids)).')');
        }
    }
}