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
class Ets_mp_mailqueue extends ObjectModel
{
    public $id_lang;
    public $id_employee;
    public $id_customer;
    public $customer_name;
    public $from_email;
    public $from_name;
    public $fileAttachment;
    public $email;
    public $subject;
    public $content;
    public $send_count;
    public $sending_time;
    public $date_add;
    public static $definition = array(
		'table' => 'ets_mp_mailqueue',
		'primary' => 'id_ets_mp_mailqueue',
		'multilang' => false,
		'fields' => array(
            'id_lang' => array('type'=> self::TYPE_INT),
            'id_employee' => array('type'=> self::TYPE_INT),
            'id_customer' => array('type'=> self::TYPE_INT),
            'customer_name' => array('type' => self::TYPE_HTML),
            'from_email' => array('type'=>self::TYPE_STRING),
            'from_name'=> array('type'=>self::TYPE_STRING),
            'fileAttachment' => array('type'=> self::TYPE_HTML),
            'email' => array('type' => self::TYPE_STRING),
            'subject' => array('type' => self::TYPE_STRING),
            'content' => array('type' => self::TYPE_HTML),
            'send_count' => array('type' => self::TYPE_INT),
            'sending_time' => array('type' => self::TYPE_DATE),
            'date_add' => array('type' => self::TYPE_DATE),
        )
	);
    public	function __construct($id_item = null, $id_lang = null, $id_shop = null)
	{
		parent::__construct($id_item, $id_lang, $id_shop);
	}
    public static function addMailQueue($id_lang,$id_customer,$id_employee,$customer_name,$from_email,$from_name,$template,$subject,$email,$templateVar,$fileAttachment=null){
        $langauge = new Language($id_lang);
        if(Validate::isLoadedObject($langauge) &&  $langauge->iso_code && ($content = self::getMailContent($langauge,$template)))
        {
            if($fileAttachment && isset($fileAttachment['tmp_name']) && $fileAttachment['tmp_name'])
            {
                $file_name = HDTools::getNewFilename(HDDefines::$default_upload);
                file_put_contents(HDDefines::$default_upload . $file_name,$fileAttachment['content']);
                $fileAttachment['content'] = $file_name;
            }
            $templateVar['{shop_name}'] = Configuration::get('PS_SHOP_NAME');
            $emaiQueue = new Ets_mp_mailqueue();
            $emaiQueue->id_lang = $id_lang;
            $emaiQueue->id_customer = $id_customer;
            $emaiQueue->id_employee = $id_employee;
            $emaiQueue->customer_name = $customer_name;
            $emaiQueue->from_email = $from_email;
            $emaiQueue->from_name = $from_name;
            $emaiQueue->subject = $subject;
            $emaiQueue->content = str_replace(array_keys($templateVar),$templateVar,$content);
            $emaiQueue->email = $email;
            $emaiQueue->template = $template;
            $emaiQueue->fileAttachment = json_encode($fileAttachment);
            $emaiQueue->add();
        }
    }
    public static function getMailContent($language,$template)
    {
        $theme = (version_compare(_PS_VERSION_, '1.7', '>=') ? Context::getContext()->shop->theme->getName() : Context::getContext()->shop->getTheme());
        $module = Module::getInstanceByName('ets_marketplace');
        $basePathList = array(
            _PS_ROOT_DIR_ . '/themes/' . $theme . '/modules/ets_marketplace/mails/',
            $module->getLocalPath() . 'mails/',
        );
        foreach ($basePathList as $path) {
            $iso_path = $path . $language->iso_code . '/' . $template;
            if (@file_exists($iso_path . '.html')) {
                return  Tools::file_get_contents($iso_path . '.html');
            }
        }
    }
    public static function getMailQueuesByFilter($filter='',$sort='',$start=0,$limit=10,$total=false)
    {
        if($total)
            return Db::getInstance()->getValue('SELECT COUNT(DISTINCT id_ets_mp_mailqueue) FROM `'._DB_PREFIX_.'ets_mp_mailqueue` q WHERE 1 '.($filter ? (string)$filter:''));
        else
        {
           $mail_queues = Db::getInstance()->executeS('SELECT * FROM `'._DB_PREFIX_.'ets_mp_mailqueue` q WHERE 1 '.($filter ? (string)$filter:'').($sort ? ' ORDER BY '.(string)$sort: ' ORDER BY q.id_ets_mp_mailqueue ASC').($limit ? ' LIMIT '.(int)$start.','.(int)$limit.'':''));
           if($mail_queues)
           {
                foreach($mail_queues as &$mail_queue)
                {
                    $mail_queue['sending_time'] = $mail_queue['sending_time']=='0000-00-00 00:00:00' ? '' :$mail_queue['sending_time'];
                }
           }
           return $mail_queues;
            
        }
    }
    public static function getMailQueues()
    {
        $max_mail = (int)Configuration::get('ETS_MP_CRONJOB_EMAILS') ?:5;
        $sql = 'SELECT * FROM `'._DB_PREFIX_.'ets_mp_mailqueue` WHERE IF(sending_time !="0000-00-00 00:00:00", TIMESTAMPDIFF(SECOND, sending_time, \'' . pSQL(date('Y-m-d H:i:s')) . '\') >= 180, 1)
        ORDER BY date_add ASC LIMIT 0,'.(int)$max_mail;
        $mailQueues = Db::getInstance()->executeS($sql);
        $ids = array();
        if($mailQueues)
        {
            foreach($mailQueues as $mailQueue)
            {
                $ids[] = $mailQueue['id_ets_mp_mailqueue'];
            }
        }
        if($ids)
            Db::getInstance()->execute('UPDATE `'._DB_PREFIX_.'ets_mp_mailqueue` set sending_time="'.pSQL(date('Y-m-d H:i:s')).'",send_count=send_count+1 WHERE id_ets_mp_mailqueue IN ('.implode(',',array_map('intval',$ids)).')');
        return $mailQueues;
    }
    public function sendMail($checkcount = true,$id_ets_mp_mailtraciking=0)
    {
        if(!$this->id)
            return false;
        $max_try = (int)Configuration::get('ETS_MP_CRONJOB_MAX_TRY') ?:5;
        if($checkcount && $this->send_count >$max_try)
            return false;
        else
        {
            if($this->id_lang && ($lang = new Language($this->id_lang)) && Validate::isLoadedObject($lang))
                $id_lang = $this->id_lang;
            else
                $id_lang = (int)Configuration::get('PS_LANG_DEFAULT');
            $save_log_mail = Configuration::get('ETS_MP_ENABLED_LOG_MAIL');
            if($save_log_mail)
            {
                $mailLog = new Ets_mp_maillog();
                $mailLog->id_ets_mp_mailqueue = $this->id;
                $mailLog->id_customer = $this->id_customer;
                $mailLog->id_employee = $this->id_employee;
                $mailLog->customer_name = $this->customer_name;
                $mailLog->email = $this->email;
                $mailLog->from_email = $this->from_email;
                $mailLog->from_name = $this->from_name;
                $mailLog->subject = $this->subject;
                $mailLog->content = $this->content;
                $mailLog->fileAttachment = $this->fileAttachment;
                $mailLog->queue_date = $this->date_add;
                $mailLog->status ='time_out';
                $mailLog->id_lang = $id_lang;
                $mailLog->add();
            }
            $attachment = array();
            preg_match("/<body[^>]*>(.*?)<\/body>/is", $this->content, $matches);
            $content_txt = trim(strip_tags($matches[1]));
            if(Ets_mp_email::Send(
                    $id_lang, 
                    'queue_mail',
                    $this->subject,
                    array(
                        '{content_txt}' => $content_txt,
                        '{content_html}' => $this->content,
                        '{link_check_view}' => Context::getContext()->link->getModuleLink('ets_marketplace','image',array('id_ets_mp_mailtraciking'=>$id_ets_mp_mailtraciking)),
                    ),  
                    $this->email,
                    $this->customer_name ? : null,
                    $this->from_email ? : null,
                    $this->from_name ? : null,
                    $attachment ? : null,
                    null, 
                    dirname(__FILE__).'/../mails/',
                    false
                )
            )
            {
                if($save_log_mail)
                {
                    $mailLog->status ='success';
                    $mailLog->update();
                }
                return true;
            } 
            else
            {
                if($save_log_mail)
                {
                    $mailLog->status ='failed';
                    $mailLog->update();
                }
                return ;
            }
        }
    }
    public function delete()
    {
        if(parent::delete())
        {
            if($this->fileAttachment && ($attachment = json_encode($this->fileAttachment,true)) && isset($attachment['content']) && $attachment['content'])
            {
                @unlink(HDDefines::$default_upload . $attachment['content']);
            }
            return true;
        }
    }
    public static function deleteSelected($ids)
    {
        if($ids && is_array($ids))
        {
            foreach($ids as $id)
            {
                $emailQueue = new Ets_mp_mailqueue($id);
                $emailQueue->delete();
            }
            return true;
        }
    }
}