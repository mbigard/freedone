{**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
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
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

<div id="quickview-modal-{$product.id}-{$product.id_product_attribute}" class="modal pk-modal fade quickview"
    tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content clearfix">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        <svg class="svgic">
                            <use href="{_THEME_IMG_DIR_}lib.svg#cross-thin"></use>
                        </svg>
                    </span>
                </button>
                <strong class="modal-title h6 text-xs-center">{$product.name}</strong>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6 col-sm-6 quickview-modal">
                        {block name='product_cover_thumbnails'}
                            {include file='catalog/_partials/product-cover-thumbnails.tpl' isQuickView=true}
                        {/block}
                    </div>
                    <div class="col-md-6 col-sm-6 product-info-section">
                        {block name='product_prices'}
                            {include file='catalog/_partials/product-prices.tpl'}
                        {/block}
                        {block name='product_description_short'}
                            <div class="product-description-short">{$product.description_short nofilter}</div>
                        {/block}
                        {block name='product_buy'}
                            <div class="product-actions">
                                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                                    <input type="hidden" name="token" value="{$static_token}">
                                    <input type="hidden" name="id_product" value="{$product.id}"
                                        id="product_page_product_id">
                                    {if isset($product.id_customization)}
                                        <input type="hidden" name="id_customization" value="{$product.id_customization}"
                                            id="product_customization_id">
                                    {/if}
                                    {block name='product_variants'}
                                        {include file='catalog/_partials/product-variants.tpl'}
                                    {/block}

                                    {block name='product_add_to_cart'}
                                        {include file='catalog/_partials/product-add-to-cart.tpl'}
                                    {/block}

                                    {block name='product_refresh'}{/block}
                                </form>
                            </div>
                        {/block}
                        <div class="productButtons flex-container align-items-center">
                            {hook h='displayMoreButtons' product_id=$product.id}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="{$urls.js_url}libs/jquery.zoom.min.js"></script>
    <script src="{$urls.js_url}libs/imagesLoaded.js"></script>
    <script src="{$urls.js_url}pages/quickview.js"></script>
    <script src="{$urls.js_url}pages/product.js"></script>
</div>