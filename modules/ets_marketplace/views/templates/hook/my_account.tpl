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
{if !$require_registration || ($registration && $registration->active==1)||$seller} 
    <li class="ets_ws_accountlink col-lg-4 col-md-6 col-sm-6 col-xs-12">
    	<a href="{$link->getModuleLink('ets_marketplace','myseller')|escape:'html':'UTF-8'}">
            <span class="link-item">
                {if $seller}{l s='My seller account' mod='ets_marketplace'}{else}{l s='My seller account' mod='ets_marketplace'}{/if}
            </span>
    	</a>
    </li>
{else}
    <li class="ets_ws_accountlink col-lg-4 col-md-6 col-sm-6 col-xs-12">
    	<a href="{$link->getModuleLink('ets_marketplace','registration')|escape:'html':'UTF-8'}" >
            <span class="link-item">
                {l s='Become a Seller' mod='ets_marketplace'}
            </span>
    	</a>
    </li>
{/if}