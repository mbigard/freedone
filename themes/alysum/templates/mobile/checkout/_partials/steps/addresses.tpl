{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  <div class="js-address-form">
    <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='order' relative_protocol=false params=['who' => 'addresses', 'updateAddress' => '1']}" target="_top">

      {if !$use_same_address}
        <h2 class="h4">{l s='Shipping Address' d='Shop.Theme.Checkout'}</h2>
      {/if}

      {if $use_same_address && !$cart.is_virtual}
        <p>
          {l s='The selected address will be used both as your personal address (for invoice) and as your delivery address.' d='Shop.Theme.Checkout'}
        </p>
      {elseif $use_same_address && $cart.is_virtual}
        <p>
          {l s='The selected address will be used as your personal address (for invoice).' d='Shop.Theme.Checkout'}
        </p>
      {/if}

      {if $show_delivery_address_form}
        <div id="delivery-address">
          {render file                      = 'mobile/checkout/_partials/address-form.tpl'
                  ui                        = $address_form
                  use_same_address          = $use_same_address
                  type                      = "delivery"
                  form_has_continue_button  = $form_has_continue_button
          }
        </div>
      {elseif $customer.addresses|count > 0}
        <div id="delivery-addresses" class="address-selector js-address-selector">
          {include  file        = 'mobile/checkout/_partials/address-selector-block.tpl'
                    addresses   = $customer.addresses
                    name        = "id_address_delivery"
                    selected    = $id_address_delivery
                    type        = "delivery"
                    interactive = !$show_delivery_address_form and !$show_invoice_address_form
          }
        </div>
        
        {if isset($delivery_address_error)}
          <p class="alert alert-danger js-address-error" id="id-failure-address-{$delivery_address_error.id_address}">{$delivery_address_error.exception}</p>
        {else}
          <p class="alert alert-danger js-address-error" style="display: none">{l s="Your address is incomplete, please update it." d="Shop.Notifications.Error"}</p>
        {/if}

        <p class="add-address">
          <a href="{$amp.global.urls.addresses}" class="button">
            {l s='Edit addresses' d='Shop.Theme.Amp'}
          </a>
        </p>

      {/if}

      {if !$use_same_address}

        <h2 class="h4">{l s='Your Invoice Address' d='Shop.Theme.Checkout'}</h2>

        {if $show_invoice_address_form}
          <div id="invoice-address">
            {render file                      = 'mobile/checkout/_partials/address-form.tpl'
                    ui                        = $address_form
                    use_same_address          = $use_same_address
                    type                      = "invoice"
                    form_has_continue_button  = $form_has_continue_button
            }
          </div>
        {else}
          <div id="invoice-addresses" class="address-selector js-address-selector">
            {include  file        = 'mobile/checkout/_partials/address-selector-block.tpl'
                      addresses   = $customer.addresses
                      name        = "id_address_invoice"
                      selected    = $id_address_invoice
                      type        = "invoice"
                      interactive = !$show_delivery_address_form and !$show_invoice_address_form
            }
          </div>

          {if isset($invoice_address_error)}
            <p class="alert alert-danger js-address-error" id="id-failure-address-{$invoice_address_error.id_address}">{$invoice_address_error.exception}</p>
          {else}
            <p class="alert alert-danger js-address-error" style="display: none">{l s="Your address is incomplete, please update it." d="Shop.Notifications.Error"}</p>
          {/if}

          <p class="add-address">
            <a href="{$amp.global.urls.addresses}" class="button">
              {l s='Edit addresses' d='Shop.Theme.Amp'}
            </a>
          </p>
        {/if}

      {/if}

      {if !$form_has_continue_button}
        <button type="submit" class="btn">{l s='Continue' d='Shop.Theme.Actions'}</button>
        <input type="hidden" id="not-valid-addresses" value="{if (isset($not_valid_addresses))}{$not_valid_addresses}{/if}">
      {/if}
      <input type="hidden" name="action" value="updateAddress">
      <input type="hidden" name="confirm-addresses" value="1">
    </form>
  </div>
{/block}
