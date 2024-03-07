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
{block name='page_content_container' prepend}
  <section id="content-hook_order_confirmation" class="card">
    <div class="card-block">
      <div class="row">
        <div class="col-md-12">

          {block name='order_confirmation_header'}
          <h3 class="h1 card-title">
            {l s='Your order is confirmed' d='Shop.Theme.Checkout'}
          </h3>
          {/block}

          <p>
            {l s='An email has been sent to your mail address %email%.' d='Shop.Theme.Checkout' sprintf=['%email%' => $customer.email]}
            {if $order.details.invoice_url}
              {* [1][/1] is for a HTML tag. *}
              {l
                s='You can also [1]download your invoice[/1]'
                d='Shop.Theme.Checkout'
                sprintf=[
                  '[1]' => "<a href='{$order.details.invoice_url}'>",
                  '[/1]' => "</a>"
                ]
              }
            {/if}
          </p>
          
          {block name='hook_order_confirmation'}
            {$HOOK_ORDER_CONFIRMATION nofilter}
          {/block}

        </div>
      </div>
    </div>
  </section>
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-order-confirmation card">
    <div class="m30">
    {block name='order_confirmation_table'}
      {include
        file='mobile/checkout/_partials/order-confirmation-table.tpl'
        products=$order.products
        subtotals=$order.subtotals
        totals=$order.totals
        labels=$order.labels
        add_product_link=false
      }
    {/block}
    </div>
    {block name='order_details'}
    <div id="order-details">
      <div class="order-details-wrapper">
        <div class="order-details-space">
          <h3 class="h3 card-title">{l s='Order details' d='Shop.Theme.Checkout'}:</h3>
          <ul>
            <li>{l s='Order reference: %reference%' d='Shop.Theme.Checkout' sprintf=['%reference%' => $order.details.reference]}</li>
            <li>{l s='Payment method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.details.payment]}</li>
            {if !$order.details.is_virtual}
              <li>
                {l s='Shipping method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.carrier.name]}
              </li>
            {/if}
            <li>{l s='Transit time: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.carrier.delay]}
            </li>
          </ul>
        </div>
      </div>
    </div>
    {/block}
  </section>

  {block name='hook_payment_return'}
  {if ! empty($HOOK_PAYMENT_RETURN)}
  <section id="content-hook_payment_return" class="card definition-list">
    {$HOOK_PAYMENT_RETURN nofilter}
  </section>
  {/if}
  {/block}

  {block name='customer_registration_form'}
  {if $customer.is_guest}
    <div id="registration-form" class="card">
      <h4 class="h4">{l s='Save time on your next order, sign up now' d='Shop.Theme.Checkout'}</h4>
      {render file='customer/_partials/customer-form.tpl' ui=$register_form}
    </div>
  {/if}
  {/block}

  {block name='hook_order_confirmation_1'}
    {hook h='displayOrderConfirmation1'}
  {/block}

  {block name='hook_order_confirmation_2'}
  <section id="content-hook-order-confirmation-footer">
    {hook h='displayOrderConfirmation2'}
  </section>
  {/block}
{/block}
{/block}