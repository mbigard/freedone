{extends file='page.tpl'}

{block name='page_content_container' prepend}
  <section id="content-hook_order_confirmation" class="card">
    <div class="elementor-alert elementor-alert-success order_confirmation_message">
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
  </section>
{/block}

{block name='page_content_container'}
  <section id="content" class="page-content page-order-confirmation card">
    <div class="row">
      {block name='order_confirmation_table'}
        {include
          file='checkout/_partials/order-confirmation-table.tpl'
          products=$order.products
          subtotals=$order.subtotals
          totals=$order.totals
          labels=$order.labels
          add_product_link=false
        }
      {/block}

      {block name='order_details'}
      <div id="order-details" class="col-md-4">
        <div class="order-details-wrapper">
          <div class="order-details-space">
        <h3 class="h3 card-title">{l s='Order details' d='Shop.Theme.Checkout'}:</h3>
        <ul>
          <li>{l s='Order reference: %reference%' d='Shop.Theme.Checkout' sprintf=['%reference%' => $order.details.reference]}</li>
          <li>{l s='Payment method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.details.payment]}</li>
          {if !$order.details.is_virtual}
          <li>{l s='Shipping method: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.carrier.name]}</li>
          {/if}
          <li>{l s='Transit time: %method%' d='Shop.Theme.Checkout' sprintf=['%method%' => $order.carrier.delay]}</li>
        </ul>
        </div>
        </div>
      </div>
      {/block}
    </div>
  </section>

  {block name='hook_payment_return'}
  {if !empty($HOOK_PAYMENT_RETURN)}
  <section id="content-hook_payment_return" class="card definition-list">
    {$HOOK_PAYMENT_RETURN nofilter}
  </section>
  {/if}
  {/block}

  {block name='customer_registration_form'}
  {if !$registered_customer_exists}
    {block name='account_transformation_form'}
    <div id="registration-form" class="card">
        <div class="card-block">
          {include file='customer/_partials/account-transformation-form.tpl'}
        </div>
      </div>
    {/block}
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
