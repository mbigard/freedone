{**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
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
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<div class="product-line-grid flex-container">
    <!--  product left content: image-->
    <div class="product-line-grid-left">
        <span class="product-image media-middle">
            <img src="{$product.default_image.bySize.home_default.url}" alt="{$product.name|escape:'quotes'}"
                width="{$product.default_image.bySize.home_default.width}"
                height="{$product.default_image.bySize.home_default.height}" loading="lazy" class="db">
        </span>
    </div>

    <!--  product left body: description -->
    <div class="product-line-grid-body flex-grow1">
        <div class="product-line-info">
            <a class="label" href="{$product.url}"
                data-id_customization="{$product.id_customization|intval}">{$product.name}</a>
        </div>
        <div class="product-line-info product-price h5 flex-container {if $product.has_discount}has-discount{/if}">
            {if $product.has_discount}
                <div class="product-discount">
                    <span class="regular-price">{$product.regular_price}</span>
                    {if $product.discount_type === 'percentage'}
                        <span class="discount discount-percentage">
                            -{$product.discount_percentage_absolute}
                        </span>
                    {else}
                        <span class="discount discount-amount">
                            -{$product.discount_to_display}
                        </span>
                    {/if}
                </div>
            {/if}
            <div class="current-price">
                <span class="price">{$product.price}</span>
                {if $product.unit_price_full}
                    <div class="unit-price-cart">{$product.unit_price_full}</div>
                {/if}
            </div>
        </div>

        {if count($product.attributes) > 0}
            <h5>{l s='Product features' d='Shop.Theme.Catalog'}:</h5>
        {/if}
        {foreach from=$product.attributes key="attribute" item="value"}
            <div class="product-line-info prod-features">
                <span class="label">{$attribute}:</span>
                <span class="value">{$value}</span>
            </div>
        {/foreach}

        {if $product.customizations|count}
            <br>
            {block name='cart_detailed_product_line_customization'}
                {foreach from=$product.customizations item="customization"}
                    <div id="product-customizations-modal-{$customization.id_customization}" class="product-customizations-modal">
                        <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                        {foreach from=$customization.fields item="field"}
                            <div class="flex-container">
                                <div class="label">
                                    <strong>{$field.label}:</strong>
                                </div>
                                <div class="value">
                                    {if $field.type == 'text'}
                                        {if (int)$field.id_module}
                                            {$field.text nofilter}
                                        {else}
                                            {$field.text}
                                        {/if}
                                    {elseif $field.type == 'image'}
                                        <img src="{$field.image.small.url}" class="pkimg" style="max-width: 100px" loading="lazy">
                                    {/if}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                {/foreach}
            {/block}
        {/if}
    </div>

    <!--  product left body: description -->
    <div class="product-line-grid-right product-line-actions flex-container">
        <div class="qty">
            {if !empty($product.is_gift)}
                <span class="gift-quantity">{$product.quantity}</span>
            {else}
                <input class="js-cart-line-product-quantity" data-down-url="{$product.down_quantity_url}"
                    data-up-url="{$product.up_quantity_url}" data-update-url="{$product.update_quantity_url}"
                    data-product-id="{$product.id_product}" type="text" value="{$product.quantity}"
                    name="product-quantity-spin" min="{$product.minimal_quantity}" />
            {/if}
        </div>
        <div class="price">
            <span class="product-price">
                <strong>
                    {if !empty($product.is_gift)}
                        <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
                    {else}
                        {$product.total}
                    {/if}
                </strong>
            </span>
        </div>
        <div class="cart-line-product-actions">
            <a class="remove-from-cart" rel="nofollow" href="{$product.remove_from_cart_url}"
                data-link-action="delete-from-cart" data-id-product="{$product.id_product|escape:'javascript'}"
                data-id-product-attribute="{$product.id_product_attribute|escape:'javascript'}"
                data-id-customization="{$product.id_customization|escape:'javascript'}">
                {if empty($product.is_gift)}
                    <svg class="svgic">
                        <use href="{_THEME_IMG_DIR_}lib.svg#cross"></use>
                    </svg>
                {/if}
            </a>

            {block name='hook_cart_extra_product_actions'}
                {hook h='displayCartExtraProductActions' product=$product}
            {/block}
        </div>
    </div>

</div>