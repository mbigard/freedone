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

{block name='head_scripts' append}
  {block name='javascript_head'}
    {include file="_partials/javascript.tpl" javascript=$javascript.head vars=$js_custom_vars}
  {/block}
  {block name='javascript_bottom'}
    {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
  {/block}
  {if isset($modulesAssets)}
    {foreach $modulesAssets as $asset}
    {if !empty($asset) && !is_array($asset)}{$asset nofilter}{/if}
    {/foreach}
  {/if}
{/block}
{block name='stylesheets'}
{foreach $stylesheets.external as $stylesheet}
<link rel="stylesheet" href="{$stylesheet.uri}" type="text/css" media="{$stylesheet.media}">
{/foreach}
{/block}
{block name='head_styles' append}
{literal}
#img-unknown,.cookie-message {
  display:none
}
.alert-danger {
  position: relative;
  margin-top: 1.25rem;
  color: #222;
  background-color: #ff7d7d;
  padding: 10px 20px
}
.cart-summary-line {
  display:flex;
}
.cart-summary-line .label {
  flex-grow:1
}
#stripe-ajax-loader {
  display:none
}
#stripe-payment-form img {
max-width:100%
}
{/literal}
{/block}

{block name='content'}
  <section id="content" class="checkout-steps">
    <div class="row checkout-step-items">
      {*
      <div hidden>
        <h4>
        Do you have Discount Code?<span class="step-edit text-muted hidden"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg></span>
        </h4>
        <div class="cart-total">
          <section id="js-checkout-summary" class="card js-cart cart-detailed-totals" data-refresh-url="{$urls.pages.cart}?ajax=1&action=refresh">
          {block name='cart_voucher'}
            {include file='checkout/_partials/cart-voucher.tpl'}
          {/block}
          </section>
        </div>
      </div>
      *}
      {block name='cart_summary'}
        {render file='mobile/checkout/checkout-process.tpl' ui=$checkout_process payment_options=$payment_options}
      {/block}
    </div>
    <div>{hook h='displayReassurance'}</div>
  </section>
  {block name='hook_before_body_closing_tag'}
    {hook h='displayBeforeBodyClosingTag'}
  {/block}
{/block}