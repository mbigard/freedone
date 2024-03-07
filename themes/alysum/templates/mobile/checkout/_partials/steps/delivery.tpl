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
  <div id="hook-display-before-carrier">
    {$hookDisplayBeforeCarrier nofilter}
  </div>
  <div class="delivery-options-list">
    {if $delivery_options|count}
      <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='order' relative_protocol=false params=['who' => 'delivery']}" target="_top">
        <div class="form-fields m20">
          {block name='delivery_options'}
            <div class="delivery-options">
              {foreach from=$delivery_options item=carrier key=carrier_id}
              <div class="delivery-option m10 flex-container flex-column">
                <div class="flex-container align-items-center">
                  <input type="radio" name="delivery_option[{$id_address}]" id="delivery_option_{$carrier.id}" value="{$carrier_id}"{if $delivery_option == $carrier_id} checked{/if}>
                  <label for="delivery_option_{$carrier.id}" class="delivery-option-2 flex-container align-items-center">
                    {if $carrier.logo}
                      <amp-img src="{$carrier.logo}" alt="{$carrier.name}" width="40" height="40" layout="fixed" />
                    {else}
                      <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#delivery"></use></svg>
                    {/if}
                    <span class="h6 carrier-name">{$carrier.name}</span>
                  </label>
                </div>
                <div class="flex-container align-items-center">
                  <span class="carrier-delay">{$carrier.delay}</span>&nbsp;<span class="carrier-price">{$carrier.price}</span>
                </div>
              </div>
              <div class="carrier-extra-content"{if $delivery_option != $carrier_id} style="display:none;"{/if}>
                {$carrier.extraContent nofilter}
              </div>
              {/foreach}
            </div>
          {/block}
          <div class="order-options">
            <div id="delivery">
              <label for="delivery_message">{l s='If you would like to add a comment about your order, please write it in the field below.' d='Shop.Theme.Checkout'}</label>
              <textarea rows="2" cols="120" id="delivery_message" name="delivery_message" class="w100 ,20">{if isset($delivery_message)}{$delivery_message}{/if}</textarea>
            </div>
            {if $recyclablePackAllowed}
              <label>
                <input type="checkbox" name="recyclable" value="1" {if $recyclable} checked {/if}>
                <span>{l s='I would like to receive my order in recycled packaging.' d='Shop.Theme.Checkout'}</span>
              </label>
            {/if}
            {if $gift.allowed}
              <span class="custom-checkbox">
                <input
                  class="js-gift-checkbox"
                  name="gift"
                  type="checkbox"
                  value="1"
                  {if $gift.isGift}checked="checked"{/if}
                >
                <span><svg class="svgic svgic-done"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#done"></use></svg></span>
                <label>{$gift.label}</label >
              </span>

              <div id="gift" class="collapse{if $gift.isGift} in{/if}">
                <label for="gift_message">{l s='If you\'d like, you can add a note to the gift:' d='Shop.Theme.Checkout'}</label>
                <textarea rows="2" cols="120" id="gift_message" name="gift_message">{$gift.message}</textarea>
              </div>

            {/if}
          </div>
        </div>
        <button type="submit" class="btn">{l s='Continue' d='Shop.Theme.Actions'}</button>
        <input type="hidden" name="confirmDeliveryOption" value="1">
        <input type="hidden" name="action" value="selectDeliveryOption">
      </form>
    {else}
      <p class="alert alert-danger">{l s='Unfortunately, there are no carriers available for your delivery address.' d='Shop.Theme.Checkout'}</p>
    {/if}
  </div>

  <div id="hook-display-after-carrier">
    {$hookDisplayAfterCarrier nofilter}
  </div>

  <div id="extra_carrier"></div>
{/block}