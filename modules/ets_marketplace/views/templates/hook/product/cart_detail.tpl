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
<div class="shop_seller_link"{if isset($controller) && $controller!='orderconfirmation'} style="display:none;"{/if}>
    <div class="shop_seller_infor" style="color:#999999;">
        {l s='By' mod='ets_marketplace'}
        <a href="{$link_shop_seller|escape:'html':'UTF-8'}">{$shop_name|escape:'html':'UTF-8'}</a>
    </div>
</div>
