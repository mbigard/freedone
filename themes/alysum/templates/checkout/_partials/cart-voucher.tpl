{**
 * 2007-2016 PrestaShop
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
 * @copyright 2007-2016 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{if $cart.vouchers.allowed}
    {block name='cart_voucher'}
        <div class="block-promo">
            <div class="cart-voucher">
                {if $cart.vouchers.added}
                    <ul class="promo-name card-block">
                        {foreach from=$cart.vouchers.added item=voucher}
                            <li class="cart-summary-line">
                                <span class="label">{$voucher.name}</span>
                                <a class="dib" href="{$voucher.delete_url}" data-link-action="remove-voucher">
                                <svg class="svgic">
                                    <use href="{_THEME_IMG_DIR_}lib.svg#cross"></use>
                                </svg>
                                </a>
                                <div class="pull-xs-right">
                                    {$voucher.reduction_formatted}
                                </div>
                            </li>
                        {/foreach}
                    </ul>
                {/if}

                <div class="promo-code{if $cart.discounts|count > 0} in{/if}" id="promo-code" data-ert="Asd">
                    {block name='cart_voucher_form'}
                        <form action="{$urls.pages.cart}" data-link-action="add-voucher" method="post" class="flex-container">
                            <input type="hidden" name="token" value="{$static_token}">
                            <input type="hidden" name="addDiscount" value="1">
                            <input class="promo-input flex-grow1" type="text" name="discount_name"
                                placeholder="{l s='Promo code' d='Shop.Theme.Checkout'}">
                            <button type="submit" class="btn btn-primary">{l s='Add' d='Shop.Theme.Actions'}</button>
                        </form>
                    {/block}
                    {block name='cart_voucher_notifications'}
                        <div class="alert alert-danger js-error flex-container align-items-center hidden" role="alert">
                        <svg class="svgic">
                            <use href="{_THEME_IMG_DIR_}lib.svg#cross"></use>
                        </svg><span class="m-l-1 js-error-text"></span>
                        </div>
                    {/block}
                </div>
                {if $cart.discounts|count > 0}
                    <p class="block-promo promo-highlighted">
                        {l s='Take advantage of our exclusive offers:' d='Shop.Theme.Actions'}
                    </p>
                    <ul class="js-discount card-block promo-discounts">
                        {foreach from=$cart.discounts item=discount}
                            <li class="cart-summary-line">
                                <span class="label"><span class="code">{$discount.code}</span> - {$discount.name}</span>
                            </li>
                        {/foreach}
                    </ul>
                {/if}
            </div>
        </div>
    {/block}
{/if}