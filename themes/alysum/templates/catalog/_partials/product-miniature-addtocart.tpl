{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

{if $pkconf.pm_atc_button && (isset($page.page_name) && $page.page_name != 'product')}
    {if (($product.quantity > 0) && ($product.available_for_order == 1) && ($product.customizable == 0) && !Configuration::get('PS_CATALOG_MODE')) || $product.add_to_cart_url}
        {if ( ((Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY') == 1) && (!empty($product.main_variants))) || (Configuration::get('PS_ATTRIBUTE_CATEGORY_DISPLAY') == 1 || empty($product.main_variants)) )}
            <form action="{if (isset($urls.pages.cart))}{$urls.pages.cart}{/if}" method="post" class="add-to-cart-or-refresh">
                <input type="hidden" name="token" value="{if (isset($static_token))}{$static_token}{/if}">
                <input type="hidden" name="id_product" value="{$product.id}" class="product_page_product_id">
                <input type="hidden" name="id_product_attribute" class="product_page_product_attribute_id" value="{$product.id_product_attribute}">
                <input type="hidden" name="qty" value="{if (isset($product.minimal_quantity) && $product.minimal_quantity > 0)}{$product.minimal_quantity}{else}1{/if}">
                {* <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id"> *}
                {block name='product_add_to_cart'}
                    {include file='catalog/_partials/product-add-to-cart-mini.tpl'}
                {/block}
            </form>
        {/if}
    {else}
        {include file='catalog/_partials/product-view-button.tpl'}
    {/if}
{else}
    {include file='catalog/_partials/product-view-button.tpl'}
{/if}