{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/checkout/_partials/order-confirmation-table.tpl'}

{block name='order-items-table-head'}
<div id="order-items" class="col-md-12">
  <h3 class="card-title h3">
    {if $products_count == 1}
       {l s='%product_count% item in your cart' sprintf=['%product_count%' => $products_count] d='Shop.Theme.Checkout'}
    {else}
       {l s='%products_count% items in your cart' sprintf=['%products_count%' => $products_count] d='Shop.Theme.Checkout'}
    {/if}
  	<a href="{url entity=cart params=['action' => 'show']}"><span class="step-edit"><svg class="svgic input-icon"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#pencil"></use></svg> {l s='Edit' d='Shop.Theme.Actions'}</span></a>
  </h3>
</div>
{/block}
