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
{function name="svgic" id='done'}
<svg class="svgic svg-done">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

<div class="product-add-to-cart">
    {if !Configuration::get('PS_CATALOG_MODE')}
        <span class="control-label">{l s='Quantity' d='Shop.Theme.Catalog'}</span>

        {block name='product_quantity'}
            <div class="product-quantity flex-container">
                <div class="qty">
                    <input type="text" name="qty" id="quantity_wanted"
                        value="{if $product.quantity_wanted > 0}{$product.quantity_wanted}{else}1{/if}" class="input-group"
                        aria-label="{l s='Quantity' d='Shop.Theme.Catalog'}">
                </div>
                <div class="add flex-container align-items-center">
                    <button class="btn btn-primary add-to-cart smooth05" data-button-action="add-to-cart" type="submit"
                        {if !$product.add_to_cart_url} disabled{/if}>
                        {l s='Add to cart' d='Shop.Theme.Actions'}
                    </button>
                </div>
            </div>
        {/block}

        {block name='product_availability'}
            <span id="product-availability" class="js-product-availability">
                {if $product.show_availability}
                    {if $product.availability == 'available'}
                        <span class="flex-container align-items-center text-success1">
                            {svgic}&nbsp;
                            {if !$product.availability_message}{l s='Available' d='Shop.Theme.Catalog'}{/if}
                        {elseif $product.availability == 'last_remaining_items'}
                            <span class="flex-container align-items-center text-warning1">
                                {svgic}&nbsp;
                                {if !$product.availability_message}{l s='The last item remains' d='Shop.Theme.Catalog'}{/if}
                            {else}
                                <span class="flex-container align-items-center text-danger1">
                                    {svgic id='cross'}&nbsp;
                                    {if !$product.availability_message}{l s='Unavailable' d='Shop.Theme.Catalog'}{/if}
                                {/if}
                                {$product.availability_message}
                            </span>
                        {/if}
                    </span>
                {/block}

                {block name='product_minimal_quantity'}
                    <p class="product-minimal-quantity">
                        {if $product.minimal_quantity > 1}
                            {l s='The minimum purchase order quantity for the product is %quantity%.' d='Shop.Theme.Checkout' sprintf=['%quantity%' => $product.minimal_quantity]}
                        {/if}
                    </p>
                {/block}
            {/if}
</div>