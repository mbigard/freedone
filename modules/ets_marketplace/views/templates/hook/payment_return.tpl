{*
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
*}
<p>{l s='Your order on %s is complete.' sprintf=$shop_name mod='ets_marketplace'}
	<br /><br />
	{l s='You have chosen the pay by commission method.' mod='ets_marketplace'}
	<br /><br /><span class="bold">{l s='Your order will be sent very soon.' mod='ets_marketplace'}</span>
	<br /><br />{l s='For any questions or for further information, please contact our ' mod='ets_marketplace'} <a href="{$link->getPageLink('contact-form', true)|escape:'html':'UTF-8'}">{l s='customer support' mod='ets_marketplace'}</a>.
</p>