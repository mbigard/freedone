{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{if $cart.vouchers.allowed}
<div class="cart-voucher">

  <amp-list src="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" layout="fixed-height" height="{if (isset($vouchers) && ($vouchers|count > 0))}100{else}0{/if}" [src]="cartList.vouchers" items="vouchers" class="appliedVouchers m15" [hidden]="cartList.vouchers.length == 0">
    <template type="amp-mustache">
      <h3 [hidden]="vouchers.length == 0">{l s='Applied Vouchers' d='Shop.Theme.Amp'}</h3>
      <div class="flex-container align-items-center">
        <span class="flex-grow1">{literal}{{name}}{/literal} ({literal}{{reduction_formatted}}{/literal})</span>
        <form action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" method="post"  on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info, vouchers: event.response.vouchers } });{/literal}">
          <input type="hidden" name="id_rule" value="{literal}{{id_cart_rule}}{/literal}">
          <input type="hidden" name="do" value="removeDiscount">
          <button class="clearButton" type="submit">✕</button>
        </form>
      </div>
    </template>
  </amp-list>

  <h2 class="m15">{l s='Have a promo code?' d='Shop.Theme.Checkout'}</h2>

  <div class="promo-code m30" id="promo-code">
    <form action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" method="post" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info, vouchers: event.response.vouchers } });{/literal}">
      <div class="flex-container align-items-center">
        <input type="hidden" name="token" value="{$static_token}">
        <input type="hidden" name="addDiscount" value="1">
        <input type="hidden" name="do" value="addDiscount">
        <input class="flex-grow1 discount_name" type="text" tabindex="0" role="textbox" required name="discount_name" placeholder="{l s='Promo code' d='Shop.Theme.Checkout'}">
        <button type="submit">{l s='Add' d='Shop.Theme.Actions'}</button>
      </div>
      <div submit-success class="vert-templ">
        <template type="amp-mustache">
        {literal}{{errors.voucher}}{/literal}
        </template>
      </div>
      <div submit-error class="vert-templ">
        <template type="amp-mustache">
        {literal}{{errors.voucher}}{/literal}
        </template>
      </div>
    </form>
  </div>

</div>
{/if}