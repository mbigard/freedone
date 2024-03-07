{**
 * 2007-2017 PrestaShop
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
 * @copyright 2007-2019 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<section id="order-summary-content" class="page-content page-order-confirmation">

    <div class="row">
        <div class="col-md-12">
            <h4 class="h4 black">{l s='Please check your order before payment' d='Shop.Theme.Checkout'}</h4>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <h4 class="h4">
                {l s='Addresses' d='Shop.Theme.Checkout'}
                <span class="step-edit step-to-addresses js-edit-addresses">
                <svg class="svgic">
                    <use href="{_THEME_IMG_DIR_}lib.svg#pencil"></use>
                </svg> {l s='Edit' d='Shop.Theme.Actions'}
                </span>
            </h4>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="card noshadow">
                <div class="card-block">
                    <h4 class="h5 black addresshead">{l s='Your Delivery Address' d='Shop.Theme.Checkout'}</h4>
                    {$customer.addresses[$cart.id_address_delivery]['formatted'] nofilter}
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card noshadow">
                <div class="card-block">
                    <h4 class="h5 black addresshead">{l s='Your Invoice Address' d='Shop.Theme.Checkout'}</h4>
                    {$customer.addresses[$cart.id_address_invoice]['formatted'] nofilter}
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <h4 class="h4">
                {l s='Shipping Method' d='Shop.Theme.Checkout'}
                <span class="step-edit step-to-delivery js-edit-delivery">
                <svg class="svgic">
                <use href="{_THEME_IMG_DIR_}lib.svg#pencil"></use>
            </svg> {l s='Edit' d='Shop.Theme.Actions'}
                </span>
            </h4>

            <div class="col-md-12 summary-selected-carrier ssc flex-container">
                <div class="logo-container">
                    {if $selected_delivery_option.logo}
                        <img src="{$selected_delivery_option.logo}" alt="{$selected_delivery_option.name}" class="db">
                    {else}
                        <svg class="svgic">
                            <use href="{_THEME_IMG_DIR_}lib.svg#delivery"></use>
                        </svg>
                    {/if}
                </div>
                <span class="carrier-name">{$selected_delivery_option.name}</span>
                <span class="carrier-delay">{$selected_delivery_option.delay}</span>
                <span class="carrier-price">{$selected_delivery_option.price}</span>
            </div>
        </div>
    </div>

    <div class="row">
        {block name='order_confirmation_table'}
            {include file='checkout/_partials/order-final-summary-table.tpl' products=$cart.products products_count=$cart.products_count subtotals=$cart.subtotals totals=$cart.totals labels=$cart.labels add_product_link=true}
        {/block}
    </div>
</section>