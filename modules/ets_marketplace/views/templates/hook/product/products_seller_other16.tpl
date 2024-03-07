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
{if isset($products) && $products}
    <div class="row">
        <div class="featured-products ets_market_products col-xs-12 col-sm-12 ets_mp_products_other">
            <h4 class="follow-title">{l s='Same products from other sellers' mod='ets_marketplace'}</h4>
            {include file="$tpl_dir./product-list.tpl" class="product_list grid row products ets_marketpllce_product_list_wrapper" id="list_product_seller"}
        </div>
    </div>
{/if}