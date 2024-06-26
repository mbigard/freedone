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
<table id="seller-tab" cellspacing="0" cellpadding="0">
	<tr>
		<td width="100%" style="text-align:left;font-size:11px;"><h4 class="bold" style="text-align:left;display:block;font-size:11px;">{l s='Shop info' mod='ets_marketplace' pdf='true'}</h4><br/><br/>
            {$order_seller->shop_name|escape:'html':'UTF-8'}<br />
            {$order_seller->seller_email|escape:'html':'UTF-8'}<br />
            {if $order_seller->shop_address}
                {$order_seller->shop_address|escape:'html':'UTF-8'}<br />
            {/if}
            {if $order_seller->shop_phone}
                {$order_seller->shop_phone|escape:'html':'UTF-8'}<br />
            {/if}
            {$order_seller->vat_number|escape:'html':'UTF-8'}
		</td>		
	</tr>
</table>