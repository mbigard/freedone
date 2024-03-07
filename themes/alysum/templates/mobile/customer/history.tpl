{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='content'}
<section class="history">

  <h2 class="page-title">{l s='Order History' d='Shop.Theme.Amp'}</h2>

  {if $orders}
  <div class="m40">
    {foreach from=$orders item=order}
      <div class="flex-container list-item-dashed">
        <span class="flex-grow1">{l s='Order reference' d='Shop.Theme.Checkout'}:</span>
        <span>{$order.details.reference}</span>
      </div>
      <div class="flex-container list-item-dashed">
        <span class="flex-grow1">{l s='Date' d='Shop.Theme.Global'}:</span>
        <span>{$order.details.order_date}</span>
      </div>
      <div class="flex-container list-item-dashed">
        <span class="flex-grow1">{l s='Total price' d='Shop.Theme.Checkout'}:</span>
        <span>{$order.totals.total.value}</span>
      </div>
      <div class="flex-container list-item-dashed">
        <span class="flex-grow1">{l s='Payment' d='Shop.Theme.Checkout'}:</span>
        <span>{$order.details.payment}</span>
      </div>
      <div class="flex-container list-item-dashed">
        <span class="flex-grow1">{l s='Status' d='Shop.Theme.Global'}:</span>
        <span class="{$order.history.current.contrast} order-status" style="background-color:{$order.history.current.color}">
          {$order.history.current.ostate_name}
        </span>
      </div>
      <div class="flex-container list-item-dashed">
        <span class="flex-grow1">{l s='Invoice' d='Shop.Theme.Checkout'}:</span>
        <span>
        {if $order.details.invoice_url}
          <a class="db" href="{$order.details.invoice_url}"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#file2"></use></svg></a>
        {else}
          -
        {/if}
        </span>
      </div>
      <div class="flex-container m40">
        <a class="button" href="{url entity='module' name={$amp.global.name} controller='order-detail' params=['id_order' => {$order.details.id}] relative_protocol=false}" data-link-action="view-order-details">
          {l s='Details' d='Shop.Theme.Customeraccount'}
        </a>
        {if $order.details.reorder_url}
          &nbsp;<a class="button" href="{$order.details.reorder_url}">{l s='Reorder' d='Shop.Theme.Actions'}</a>
        {/if}
      </div>
    {/foreach}
    </div>
  {else}
    {l s='No orders yet' d='Shop.Theme.Customeraccount'}
  {/if}
</section>
{/block}