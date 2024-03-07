{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<section id="order-summary-content" class="page-content page-order-confirmation">

  <h3 class="heading-section text-uppercase">{l s='Please check your order before payment' d='Shop.Theme.Checkout'}</h3>

  <h4 class="heading-section">{l s='Addresses' d='Shop.Theme.Checkout'}</h4>

  <div class="card">
    <div class="card-block m20">
      <h5 class="m10">{l s='Your Delivery Address' d='Shop.Theme.Checkout'}</h5>
      {$customer.addresses[$cart.id_address_delivery]['formatted'] nofilter}
    </div>
  </div>
  <div class="card">
    <div class="card-block m20">
      <h5 class="m10">{l s='Your Invoice Address' d='Shop.Theme.Checkout'}</h5>
      {$customer.addresses[$cart.id_address_invoice]['formatted'] nofilter}
    </div>
  </div>
    
  <h4 class="heading-section">{l s='Shipping Method' d='Shop.Theme.Checkout'}</h4>

  <div class="col-md-12 summary-selected-carrier ssc flex-container">
    <div class="logo-container">
      {if $selected_delivery_option.logo}
        <amp-img src="{$selected_delivery_option.logo}" alt="{$selected_delivery_option.name}" width="40" height="40" layout="fixed" />
      {else}
        <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#delivery"></use></svg>
      {/if}
    </div>
    <span class="carrier-name">{$selected_delivery_option.name}</span>
    <span class="carrier-delay">{$selected_delivery_option.delay}</span>
    <span class="carrier-price">{$selected_delivery_option.price}</span>
  </div>

  <div class="row">

    {block name='order_confirmation_table'}
      {include file='mobile/checkout/_partials/order-final-summary-table.tpl'
         products=$cart.products
         products_count=$cart.products_count
         subtotals=$cart.subtotals
         totals=$cart.totals
         labels=$cart.labels
         add_product_link=true
       }
    {/block}
  </div>
</section>
