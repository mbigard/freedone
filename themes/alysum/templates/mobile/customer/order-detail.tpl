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

  <h2 class="page-title">{l s='Order details' d='Shop.Theme.Amp'}</h2>

  {block name='order_infos'}
    <div id="order-infos">
      <div class="box">
        <strong>
          {l
            s='Order Reference %reference% - placed on %date%'
            d='Shop.Theme.Customeraccount'
            sprintf=['%reference%' => $order.details.reference, '%date%' => $order.details.order_date]
          }
        </strong>
        {if $order.details.reorder_url}
        <div>
          <a href="{url entity='module' name={$amp.global.name} controller='ajaxOrder' relative_protocol=false params=['who' => 'order-detail', 'submitReorder' => 1]}" class="button">{l s='Reorder' d='Shop.Theme.Actions'}</a>
        </div>
        {/if}
      </div>

      <div class="box">
        <ul>
          <li><strong>{l s='Carrier' d='Shop.Theme.Checkout'}:</strong> {$order.carrier.name}</li>
          <li><strong>{l s='Payment method' d='Shop.Theme.Checkout'}:</strong> {$order.details.payment}</li>
          {if $order.details.invoice_url}
          <li>
            <a href="{$order.details.invoice_url}">
              <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#file2"></use></svg>&nbsp;{l s='Download your invoice as a PDF file.' d='Shop.Theme.Customeraccount'}
            </a>
          </li>
          {/if}
          {if $order.details.recyclable}
          <li>
            {l s='You have given permission to receive your order in recycled packaging.' d='Shop.Theme.Customeraccount'}
          </li>
          {/if}
          {if $order.details.gift_message}
          <li>{l s='You have requested gift wrapping for this order.' d='Shop.Theme.Customeraccount'}</li>
          <li>{l s='Message' d='Shop.Theme.Customeraccount'}: {$order.details.gift_message nofilter}</li>
          {/if}
        </ul>
      </div>
    </div>
  {/block}

  {block name='order_history'}
  <section id="order-history" class="box">
    <h3 class="m10">{l s='Follow your order\'s status step-by-step' d='Shop.Theme.Customeraccount'}</h3>
    {foreach from=$order.history item=state}
    <div class="flex-container">
      <div class="flex-grow1">{$state.history_date}</div>
      <div>
        <span class="order-status {$state.contrast}" style="background-color:{$state.color}">
          {$state.ostate_name}
        </span>
      </div>
    </div>
    {/foreach}
  </section>
  {/block}

  {if $order.follow_up}
  <div class="box">
    <p>{l s='Click the following link to track the delivery of your order' d='Shop.Theme.Customeraccount'}</p>
    <a href="{$order.follow_up}">{$order.follow_up}</a>
  </div>
  {/if}

  {block name='addresses'}
  <div class="addresses">
    {if $order.addresses.delivery}
    <article id="delivery-address" class="box">
      <h3 class="m10">{l s='Delivery address "%alias%"' d='Shop.Theme.Checkout' sprintf=['%alias%' => $order.addresses.delivery.alias]}</h3>
      <address>{$order.addresses.delivery.formatted nofilter}</address>
    </article>
    {/if}

    <article id="invoice-address" class="box">
      <h3 class="m10">{l s='Invoice address "%alias%"' d='Shop.Theme.Checkout' sprintf=['%alias%' => $order.addresses.invoice.alias]}</h3>
      <address>{$order.addresses.invoice.formatted nofilter}</address>
    </article>
  </div>
  {/block}

  {block name='order_detail'}
    {if $order.details.is_returnable}
      {include file='mobile/customer/_partials/order-detail-return.tpl'}
    {else}
      {include file='mobile/customer/_partials/order-detail-no-return.tpl'}
    {/if}
  {/block}

  {block name='order_carriers'}
    {if $order.shipping}
    <section class="box">
    <h3 class="m10">{l s='Order Shipping' d='Shop.Theme.Customeraccount'}</h3>
      <div class="shipping-list">
        {foreach from=$order.shipping item=line}
        <div class="flex-container list-item-dashed">
          <div class="flex-grow1">{l s='Date' d='Shop.Theme.Global'}</div>
          <div>{$line.shipping_date}</div>
        </div>
        <div class="flex-container list-item-dashed">
          <div class="flex-grow1">{l s='Carrier' d='Shop.Theme.Global'}</div>
          <div>{$line.carrier_name}</div>
        </div>
        <div class="flex-container list-item-dashed">
          <div class="flex-grow1">{l s='Weight' d='Shop.Theme.Global'}</div>
          <div>{$line.shipping_weight}</div>
        </div>
        <div class="flex-container list-item-dashed">
          <div class="flex-grow1">{l s='Shipping cost' d='Shop.Theme.Global'}</div>
          <div>{$line.shipping_cost}</div>
        </div>
        <div class="flex-container list-item-dashed">
          <div class="flex-grow1">{l s='Tracking number' d='Shop.Theme.Global'}</div>
          <div>{$line.tracking nofilter}</div>
        </div>
        {/foreach}
      </div>
    </section>
    {/if}
  {/block}

  {block name='order_messages'}
    {include file='mobile/customer/_partials/order-messages.tpl'}
  {/block}

{/block}