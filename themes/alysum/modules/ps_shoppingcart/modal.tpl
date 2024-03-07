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

<div id="blockcart-modal" class="modal pk-modal fade" tabindex="-1" role="dialog" aria-labelledby="cartModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">
                        <svg class="svgic">
                            <use href="{_THEME_IMG_DIR_}lib.svg#cross-thin"></use>
                        </svg>
                        &nbsp;
                    </span>
                </button>
                <strong class="modal-title h6 text-xs-center" id="cartModalLabel">
                    {l s='Product successfully added to your shopping cart' d='Shop.Theme.Checkout'}
                </strong>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-7 divide-right">
                        <div class="flex-container">
                            <div class="col-md">
                                <img class="product-image" src="{$product.default_image.medium.url}"
                                    alt="{$product.default_image.legend}" title="{$product.default_image.legend}">
                            </div>
                            <div class="col-md">
                                <span class="h6 product-name">{$product.name}</span>
                                <p class="price">{$product.price}</p>
                                {hook h='displayProductPriceBlock' product=$product type="unit_price"}
                                <div class="product-properties">
                                    {foreach from=$product.attributes item="property_value" key="property"}
                                        <span>{$property}: <i>{$property_value}</i></span><br>
                                    {/foreach}
                                    <span>{l s='Quantity:' d='Shop.Theme.Checkout'}&nbsp;<i>{$product.cart_quantity}</i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="cart-content">

                            <p class="font-weight-bold">
                                {if $cart.products_count > 1}
                                    {l s='There are %products_count% items in your cart.' sprintf=['%products_count%' => $cart.products_count] d='Shop.Theme.Checkout'}
                                {else}
                                    {l s='There is %product_count% item in your cart.' sprintf=['%product_count%' =>$cart.products_count] d='Shop.Theme.Checkout'}
                                {/if}
                            </p>

                            <ul class="media-list">
                                <li class="flex-container">
                                    <span class="label flex-grow1">{l s='Subtotal' d='Shop.Theme.Checkout'}</span>
                                    <span class="value font-weight-bold">{$cart.subtotals.products.value}</span>
                                </li>
                                {if $cart.subtotals.shipping.value}
                                    <li class="flex-container">
                                        <span class="label flex-grow1">{l s='Shipping' d='Shop.Theme.Checkout'}</span>
                                        <span class="value font-weight-bold">{$cart.subtotals.shipping.value}
                                            {hook h='displayCheckoutSubtotalDetails' subtotal=$cart.subtotals.shipping}</span>
                                    </li>
                                {/if}
                                {if !$configuration.display_prices_tax_incl && $configuration.taxes_enabled}
                                    <li class="flex-container">
                                        <span
                                            class="label flex-grow1">{$cart.totals.total.label}&nbsp;{$cart.labels.tax_short}</span>
                                        <span class="value font-weight-bold">{$cart.totals.total.value}</span>
                                    </li>
                                    <li class="flex-container product-total">
                                        <span class="label flex-grow1">{$cart.totals.total_including_tax.label}</span>
                                        <span class="value font-weight-bold">{$cart.totals.total_including_tax.value}</span>
                                    </li>
                                {else}
                                    <li class="flex-container product-total">
                                        <span
                                            class="label flex-grow1">{$cart.totals.total.label}&nbsp;{if $configuration.taxes_enabled}{$cart.labels.tax_short}{/if}</span>
                                        <span class="value font-weight-bold">{$cart.totals.total.value}</span>
                                    </li>
                                {/if}
                                {if $cart.subtotals.tax}
                                    <li class="flex-container product-tax">
                                        <span
                                            class="label flex-grow1">{l s='%label%:' sprintf=['%label%' => $cart.subtotals.tax.label] d='Shop.Theme.Global'}</span>
                                        <span class="value font-weight-bold">{$cart.subtotals.tax.value}</span>
                                    </li>
                                {/if}
                            </ul><br>

                            <button type="button" class="btn btn-secondary" data-dismiss="modal">
                                {l s='Continue shopping' d='Shop.Theme.Actions'}
                            </button>
                            <a href="{$cart_url}" class="btn btn-primary">{l s='Checkout' d='Shop.Theme.Actions'}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>