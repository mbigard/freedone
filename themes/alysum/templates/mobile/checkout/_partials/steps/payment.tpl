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

  {hook h='displayPaymentTop'}

  {if isset($is_free)}
    <p>{l s='No payment needed for this order' d='Shop.Theme.Checkout'}</p>
  {/if}
  <div class="payment-options{if isset($is_free)} hidden{/if}">
    {foreach from=$payment_options item="module_options"}
      {foreach from=$module_options item="option"}
        <div id="{$option.id}-container" class="payment-option">
          <input
            class="ps-shown-by-js {if $option.binary} binary {/if}"
            id="{$option.id}"
            data-module-name="{$option.module_name}"
            name="payment-option"
            type="radio"
            required
            {if $selected_payment_option == $option.id || isset($is_free)} checked {/if}
          >

          <label for="{$option.id}">
            <span>{$option.call_to_action_text}</span>
            {if $option.logo}
              <img src="{$option.logo}">
            {/if}
          </label>

        </div>

        {if $option.additionalInformation}
          <div id="{$option.id}-additional-information"
            class="definition-list additional-information{if $option.id != $selected_payment_option} ps-hidden {/if}">
            {$option.additionalInformation nofilter}
          </div>
        {/if}

        <div id="pay-with-{$option.id}-form" class="{if $option.id != $selected_payment_option} ps-hidden {/if}">
          {if $option.form}
            {$option.form nofilter}
          {else}
            <form id="payment-form" method="POST" action="{$option.action nofilter}">
              {foreach from=$option.inputs item=input}
                <input type="{$input.type}" name="{$input.name}" value="{$input.value}">
              {/foreach}
              <button style="display:none" id="pay-with-{$option.id}" type="submit"></button>
            </form>
          {/if}
        </div>
      {/foreach}
    {foreachelse}
      <p class="alert alert-danger">{l s='Unfortunately, there are no payment method available.' d='Shop.Theme.Checkout'}</p>
    {/foreach}
  </div>

  {if $conditions_to_approve|count}
    <p class="ps-hidden-by-js">
      {* At the moment, we're not showing the checkboxes when JS is disabled
         because it makes ensuring they were checked very tricky and overcomplicates
         the template. Might change later.
      *}
      {l s='By confirming the order, you certify that you have read and agree with all of the conditions below:' d='Shop.Theme.Checkout'}
    </p>

    <form id="conditions-to-approve" method="GET">
      <ul>
        {foreach from=$conditions_to_approve item="condition" key="condition_name"}
          <li class="flex-container">
            <input  id    = "conditions_to_approve[{$condition_name}]"
                    name  = "conditions_to_approve[{$condition_name}]"
                    type  = "checkbox"
                    value = "1"
                    class = "ps-shown-by-js"
                    on="change:selector-tos.toggle"
                    required>
            <label class="js-terms" for="conditions_to_approve[{$condition_name}]" on="click:selector-tos.toggle">
              {$condition nofilter}
            </label>
          </li>
        {/foreach}
      </ul>
    </form>
  {/if}

  {if $show_final_summary}
    {include file='mobile/checkout/_partials/order-final-summary.tpl'}
  {/if}

  <div id="payment-confirmation">
    <div class="ps-shown-by-js">
      <button type="submit" id="payment-confirm" {if !$selected_payment_option} disabled title="{l s='You have to accept our terms and conditions' d='Shop.Theme.Checkout'}"{/if} class="btn btn-primary center-block">
        {l s='Order with an obligation to pay' d='Shop.Theme.Checkout'}
      </button>
      {if $show_final_summary}
        <br><br><article class="notification alert alert-danger mt-2 js-alert-payment-conditions" role="alert" data-alert="danger">
          {l
            s='Please make sure you\'ve chosen a [1]payment method[/1] and accepted the [2]terms and conditions[/2].'
            sprintf=[
              '[1]' => '<a href="#checkout-payment-step">',
              '[/1]' => '</a>',
              '[2]' => '<a href="#conditions-to-approve">',
              '[/2]' => '</a>'
            ]
            d='Shop.Theme.Checkout'
          }
        </article>
      {/if}
    </div>
    <div class="ps-hidden-by-js">
      {if $selected_payment_option and $all_conditions_approved}
        <label for="pay-with-{$selected_payment_option}">{l s='Order with an obligation to pay' d='Shop.Theme.Checkout'}</label>
      {/if}
    </div>
  </div>

  {hook h='displayPaymentByBinaries'}


{/block}