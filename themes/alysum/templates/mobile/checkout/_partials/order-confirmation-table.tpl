{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<div id="order-items">

  <h4 class="card-title heading-section">{l s='Order items2' d='Shop.Theme.Checkout'}</h4>

  <div class="order-confirmation-table">

    {block name='order_confirmation_table'}

      {foreach from=$products item=product}
         {include file='mobile/catalog/_partials/miniatures/product_lite.tpl' product=$product type="micro"}
      {/foreach}

      <table class="w100 m20 heading-section">
        {foreach $subtotals as $subtotal}
          {if $subtotal.type !== 'tax'}
            <tr>
              <td>{$subtotal.label}</td>
              <td class="text-right">{$subtotal.value}</td>
            </tr>
          {/if}
        {/foreach}
        {if $subtotals.tax.label !== null}
          <tr class="sub">
            <td>{$subtotals.tax.label}</td>
            <td class="text-right">{$subtotals.tax.value}</td>
          </tr>
        {/if}
        <tr class="font-weight-bold">
          <td><span class="text-uppercase bold">{$totals.total.label}</span> {$labels.tax_short}</td>
          <td class="text-right bold">{$totals.total.value}</td>
        </tr>
      </table>
    {/block}

  </div>
</div>