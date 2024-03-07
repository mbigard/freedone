{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<section id="js-checkout-summary">
  <h4>{l s='Checkout Summary' d='Shop.Theme.Amp'}</h4>
  <div class="card-block card-separator m30">
    {block name='hook_checkout_summary_top'}
      {hook h='displayCheckoutSummaryTop'}
    {/block}

    {block name='cart_summary_products'}
    <div class="cart-summary-products">
      {block name='cart_summary_product_list'}
        <div class="collapse" id="cart-summary-product-list">
          <div class="media-list">
            <div class="indent">
            {foreach from=$cart.products item=product name=cartProduct}
              {include file='mobile/catalog/_partials/miniatures/product_lite.tpl' product=$product}
            {/foreach}
            </div>
          </div>
        </div>
      {/block}
    </div>
    {/block}

    {block name='cart_summary_subtotals'}
    {foreach from=$cart.subtotals item="subtotal"}
      {if $subtotal && $subtotal.type !== 'tax'}
        <div class="flex-container" id="cart-subtotal-{$subtotal.type}">
          <span class="label flex-grow1">{$subtotal.label}</span>
          <span class="value">{$subtotal.value}</span>
        </div>
      {/if}
    {/foreach}
    {/block}

    {block name='cart_summary_tax'}
      <div class="flex-container">
        <span class="label sub flex-grow1">{$cart.subtotals.tax.label}</span>
        <span class="value sub">{$cart.subtotals.tax.value}</span>
      </div>
    {/block}

    {block name='cart_summary_total'}
      <div class="flex-container">
        <span class="label flex-grow1 bold">{$cart.totals.total.label} {$cart.labels.tax_short}</span>
        <span class="value bold">{$cart.totals.total.value}</span>
      </div>
    {/block}

  </div>

</section>
