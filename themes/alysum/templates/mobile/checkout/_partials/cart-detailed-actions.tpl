{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='cart_detailed_actions'}
<div class="checkout cart-detailed-actions card-block">
  {if $cart.minimalPurchaseRequired}
    <div class="alert notification" role="alert" [hidden]="cartList.info[0].allow_purchase">
      {$cart.minimalPurchaseRequired}
    </div>
    <a href="{url entity='module' name={$amp.global.name} controller='order' relative_protocol=false}" class="button btn btn-big" role="button" tabindex="0" [hidden]="!cartList.info[0].allow_purchase"{if $cart.minimalPurchaseRequired} hidden{/if}>{l s='Checkout' d='Shop.Theme.Amp'}</a>
  {elseif empty($cart.products) }
    <button type="button" class="btn btn-primary disabled" disabled>{l s='Checkout' d='Shop.Theme.Amp'}</button>
  {else}
    <a href="{url entity='module' name={$amp.global.name} controller='order' relative_protocol=false}" class="button btn btn-big" role="button" tabindex="0">{l s='Checkout' d='Shop.Theme.Amp'}</a>
    {hook h='displayExpressCheckout'}
  {/if}
</div>
{/block}