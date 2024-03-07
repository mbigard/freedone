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

class AssociationModel extends ObjectModel
{
     /**
     * Nom de l'expert
     * @param int $lastname
     */
    public $name;

    /**
     * Prénom de l'expert
     * @param string $firstname
     */
    public $code;

    /**
     * Prénom de l'expert
     * @param string $firstname
     */
    public $percentage;

    /**
     * Date ajout
     * @param string $date_add
     */
    public $date_add;

    /**
     * @see ObjectModel::$definition
     */
    public static $definition = array(
        'table' => 'mb_associations',
        'primary' => 'id_association',
        'multilang' => false,
        'fields' => array(
            'date_add' => array(
                'type' => self::TYPE_DATE,
                'validate' => 'isDate'
            ),
            'name' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'lang' => false,
                'required' => true,
                'size' => 255
            ),
            'code' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'lang' => false,
                'required' => true,
                'size' => 255
            ),
            'percentage' => array(
                'type' => self::TYPE_STRING,
                'validate' => 'isString',
                'lang' => false,
                'required' => true,
                'size' => 255
            ),
        ),
    );

    public function __construct($id = null, $idLang = null, $idShop = null)
    {
        parent::__construct($id, $idLang, $idShop);
        Shop::addTableAssociation('mb_associations', array('type' => 'shop'));
    }

    public static function getAssoByCode($code) {
        $asso = Db::getInstance()->executeS('SELECT * from '._DB_PREFIX_.self::$definition['table'].' where code = "'.$code.'"');

        if (!empty($asso)) {
            return ['freedone' => false, 'amount' => $asso[0]['percentage'], 'asso' => $asso[0]];
        }


        if (empty(Configuration::get('CODE_ASSOCIATIONS_DEFAULT_PERCENTAGE'))) {
            $default_percetange = 10;
        } else {
            $default_percetange = (float)Configuration::get('CODE_ASSOCIATIONS_DEFAULT_PERCENTAGE');
        }

        return ['freedone' => true, 'amount' => $default_percetange, 'asso' => []];
    }
}