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
class Ets_mp_email extends MailCore
{
    public static $moduleName = 'ets_marketplace';
    public static function send(
        $idLang,
        $template,
        $subject = array(),
        $templateVars = array(),
        $to = null,
        $toName = null,
        $from = null,
        $fromName = null,
        $fileAttachment = null,
        $mode_smtp = null,
        $templatePath = _PS_MAIL_DIR_,
        $die = false,
        $idShop = null,
        $bcc = null,
        $replyTo = null,
        $replyToName = null,
        $createQueue = false
    )
    {
        if(Ets_marketplace::validateArray($to))
        {
            if(isset($to['customer']))
            {
                $toMail = $to['customer'];
                if(!$idLang)
                {
                    if(($customers = Customer::getCustomersByEmail($toMail)) && ($customer = $customers[0]) && ($lang = new Language($customer['id_lang'])) && $lang->id)
                    {
                        $id_customer = (int)$customer['id_customer'];
                        $idLang = $lang->id;
                    }
                }
            }
            elseif(isset($to['employee']))
            {
                $toMail = $to['employee'];
                if(!$idLang)
                {
                    if(($employee = self::getEmployeeByEmail($toMail)) && ($lang = new Language($employee->id_lang)) && $lang->id)
                    {
                        $id_employee = $employee->id;
                        $idLang = $employee->id_lang;
                    }
                }
            }
            else
                return false;
        }
        else
            $toMail = $to;
        if(!$idLang)
            $idLang = Context::getContext()->language->id;
        if(!$idLang)
            $idLang = Configuration::get('PS_LANG_DEFAULT');
        if(Ets_marketplace::validateArray($subject) && isset($subject['origin']) && isset($subject['translation']))
        {
            if(version_compare(_PS_VERSION_, '1.7', '>='))
            {
                $locale = isset($lang) ? $lang->locale : Language::getLocaleByIso(Language::getIsoById($idLang));
                $subject = Translate::getModuleTranslation(self::$moduleName, $subject['origin'], isset($subject['specific']) && $subject['specific'] ? $subject['specific']: self::$moduleName, isset($subject['params']) ? $subject['params'] : null, false, $locale);
            }
            else{
                $subject = Module::getInstanceByName('ets_marketplace')->getTextLang($subject['origin'],isset($lang) ? $lang:$idLang,isset($subject['specific']) && $subject['specific'] ? $subject['specific']: self::$moduleName);
            }
            if(!$subject)
                $subject = $subject['translation'];
        }
        elseif(Ets_marketplace::validateArray($subject))
            return false;
        if($createQueue)
        {
            return Ets_mp_mailqueue::addMailQueue($idLang,isset($id_customer) ? $id_customer:0,isset($id_employee) ? $id_employee:0,$toName,$from,$fromName,$template,$subject,$toMail,$templateVars,$fileAttachment);
        }
        elseif(parent::send(
            $idLang,
            $template,
            $subject,
            $templateVars,
            $toMail,
            $toName,
            $from,
            $fromName,
            $fileAttachment,
            $mode_smtp,
            $templatePath,
            $die,
            $idShop ,
            $bcc,
            $replyTo,
            $replyToName
        ))
        {
            return true;
        }
    }
    public static function getEmployeeByEmail($email)
    {
        if(!Validate::isEmail($email))
            return false;
        $sql = new DbQuery();
        $sql->select('e.id_employee');
        $sql->from('employee', 'e');
        $sql->where('e.`email` = \'' . pSQL($email) . '\'');
        $id_employee = Db::getInstance(_PS_USE_SQL_SLAVE_)->getValue($sql);
        if($id_employee)
            return new Employee($id_employee);
        else
            return false;
    }
}