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
{assign var='cartItemHeight' value=203}

{block name='content'}
<section id="main">
  <h2 class="page-title">{l s='Shopping Cart' d='Shop.Theme.Amp'}</h2>
  <div class="cart-grid">
    <!-- Left Block: cart product informations & shpping -->
    <div class="cart-grid-body m30">
      <!-- cart products detailed -->
      <div class="card cart-container relative">

        <amp-list class="cart-items mini-products" src="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id, 'who' => 'cart', 'refresh' => $smarty.now]}" layout="fixed-height" height="{if !empty($ampcart.products)}{$ampcart.products|count*$cartItemHeight}{else}406{/if}" [src]="cartList.items" [height]="cartList.items.length > 0 ? cartList.items.length * {$cartItemHeight} : {$cartItemHeight}">

          <template type="amp-mustache">

            <div class="flex-container text-center align-items-center flex-column" [hidden]="cartList.items != null">
              <amp-bodymovin-animation layout="flex-item" width="256" height="256" src="{$amp.global.assets}json/empty.json" loop="true"></amp-bodymovin-animation>
              <div>{l s='Your Cart is Empty' d='Shop.Theme.Amp'}</div>
            </div>

            <div class="cart-item product-line-grid flex-container relative" [hidden]="cartList.items == null">

              <a href="{literal}{{amp_link}}{/literal}" title="{literal}{{name}}{/literal}">
                <amp-img src="{literal}{{cover.medium.url}}{/literal}" width="{$amp.global.images.cart.size.width}" height="{$amp.global.images.cart.size.height}" layout="responsive" style="min-width: {$amp.global.images.cart.size.width}px" alt="{literal}{{name}}{/literal}" class="cart-image"></amp-img>
              </a>

              <div class="cart-product-info pk-cpi product-info">

                <a class="product-title ellipsis" href="{literal}{{amp_link}}{/literal}" title="{literal}{{name}}{/literal}">
                  {literal}{{name}}{/literal}
                </a>

                {literal}{{#attributes_small}}{/literal}
                <div class="m15">
                  <small>{literal}{{{attributes_small}}}{/literal}</small>
                </div>
                {literal}{{/attributes_small}}{/literal}

                {literal}{{#customizations_number}}{/literal}
                <div class="customizations">
                <h3>{l s='Customizations' d='Shop.Theme.Amp'}</h3>
                <hr>
                {literal}
                {{#customizations_fields}}
                  <div><strong>{{label}}:</strong> {{text}}</div>
                {{/customizations_fields}}
                {/literal}
                </div>
                {literal}{{/customizations_number}}{/literal}

                {if !$configuration.is_catalog}
                <strong class="db m15 product-price price">
                  {literal}{{#reduction}}{/literal}
                  <del>{literal}{{price}}{/literal}</del>&nbsp;
                  {literal}{{display_price_with_reduction}}{/literal}
                  {literal}{{/reduction}}{/literal}
                  {literal}{{^reduction}}{/literal}
                  {literal}{{price}}{/literal}
                  {literal}{{/reduction}}{/literal}
                  <span>&nbsp;(✕{literal}{{cart_quantity}}{/literal})</span>
                </strong>

                <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" class="flex-container align-items-center remove-button" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info } });{/literal}">
                  <input type="hidden" name="do" value="deleteProduct">
                  <input type="hidden" name="id_product" value="{literal}{{id_product}}{/literal}">
                  <input type="hidden" name="id_product_attribute" value="{literal}{{id_product_attribute}}{/literal}">
                  {literal}{{#id_customization}}{/literal}
                  <input type="hidden" name="id_customization" value="{literal}{{id_customization}}{/literal}">
                  {literal}{{/id_customization}}{/literal}
                  <button type="submit" class="clearButton" id="remove-from-cart">✕</button>
                  <div hidden submitting>&nbsp;{l s='Waiting' d='Shop.Theme.Amp'}...</div>
                  <div hidden submit-success>&nbsp;{l s='Done' d='Shop.Theme.Amp'}</div>
                  <div hidden submit-error>&nbsp;{l s='Unable to remove' d='Shop.Theme.Amp'}</div>
                </form>

                <div class="product-line-grid-footer flex-container">
                  <div class="qty flex-container">
                    
                    <form method="POST" class="cartItem" id="cartItem{literal}{{id_product}}{{id_customization}}{/literal}" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info} });{/literal}">
                      <div class="flex-container align-items-center">
                        <input type="hidden" name="do" value="cartUpdate">
                        <input type="hidden" name="id_product" value="{literal}{{id_product}}{/literal}">
                        <input type="hidden" name="id_product_attribute" value="{literal}{{id_product_attribute}}{/literal}">
                        {literal}{{#id_customization}}{/literal}
                        <input type="hidden" name="id_customization" value="{literal}{{id_customization}}{/literal}">
                        {literal}{{/id_customization}}{/literal}
                        <input type="hidden" name="cartPage" value="1">
                        <input type="number" pattern="[0-9]*" name="qty" role="textbox" tabindex="0" class="flex-grow1 qty" value="{literal}{{quantity}}{/literal}" on="change:cartItem{literal}{{id_product}}{{id_customization}}{/literal}.submit" max="{literal}{{quantity_available}}{/literal}" min="{literal}{{minimal_quantity}}{/literal}" title="{l s='Available products quantity' d='Shop.Theme.Amp'}: {literal}{{quantity_available}}{/literal}">
                        <div class="input-buttons flex-container flex-column up-down-btns" hidden>
                          <input on="tap:AMP.setState({ldelim}product_quantity: product_quantity != null ? product_quantity+1 : 2{rdelim})" value="+" type="text" role="button" tabindex="0">
                          <input on="tap:AMP.setState({ldelim}product_quantity: product_quantity > 1 ? product_quantity-1 : 1{rdelim})" value="-" type="text" role="button" tabindex="0">
                        </div>
                        <strong class="price">{literal}{{display_price_with_reduction}}{/literal}</strong>
                      </div>
                      <div submitting class="p0">{l s='Waiting' d='Shop.Theme.Amp'}...</div>
                      <div submit-error class="p0">{l s='Available products quantity' d='Shop.Theme.Amp'}: {literal}{{quantity_available}}{/literal}</div>
                    </form>

                  </div>
                </div>
                {/if}

              </div>
            </div>

          </template>

          <div fallback>
            <div class="flex-container text-center align-items-center flex-column">
              <amp-bodymovin-animation layout="flex-item" width="256" height="256" src="{$amp.global.assets}json/empty.json" loop="true"></amp-bodymovin-animation>
              <div>{l s='Your Cart is Empty' d='Shop.Theme.Amp'}</div>
            </div>
          </div>

          <div class="list-overflow" overflow></div>

        </amp-list>

        <amp-state id="product_quantity">
          <script type="application/json">[1]</script>
        </amp-state>
        
      </div>

      <!-- shipping informations -->
      {block name='hook_shopping_cart_footer'}
        {hook h='displayShoppingCartFooter'}
      {/block}
    </div>

    {if !$configuration.is_catalog}
    <div class="cart-grid-right">

      {block name='cart_summary'}
        <div class="card cart-summary m30">

          {block name='hook_shopping_cart'}
            {hook h='displayShoppingCart'}
          {/block}

          {block name='cart_voucher'}
            {include file='mobile/checkout/_partials/cart-voucher.tpl'}
          {/block}

          <div class="cart-detailed-totals">

            <amp-list binding="always" id="cartInfo" src="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" layout="fixed-height" width="auto" height="120" class="m1 m15 mini-products" [src]="cartList.info" items="info">
              <template type="amp-mustache">

                <div class="cart-subtotals">
                  <div class="flex-container">
                    <span class="label flex-grow1">{l s='Products' d='Shop.Theme.Amp'}</span>
                    <span class="value price">{literal}{{products}}{/literal}</span>
                  </div>
                  <div class="flex-container">
                    <span class="label flex-grow1">{l s='Discounts' d='Shop.Theme.Amp'}</span>
                    <span class="value price">{literal}{{discount}}{/literal}</span>
                  </div>
                  <div class="flex-container">
                    <span class="label flex-grow1">{l s='Shipping' d='Shop.Theme.Amp'}</span>
                    <span class="value price">{literal}{{shipping}}{/literal}</span>
                  </div>
                  <div class="flex-container">
                    <span class="label flex-grow1">{l s='Tax' d='Shop.Theme.Amp'}</span>
                    <span class="value price">{literal}{{tax}}{/literal}</span>
                  </div>
                  {literal}{{#total_diff}}{/literal}
                  <div class="flex-container">
                    <span class="label flex-grow1"><strong>{l s='Total excl. tax' d='Shop.Theme.Amp'}</strong></span>
                    <span class="value price"><strong>{literal}{{total_tax_excl}}{/literal}</strong></span>
                  </div>
                  <div class="flex-container">
                    <span class="label flex-grow1"><strong>{l s='Total incl. tax' d='Shop.Theme.Amp'}</strong></span>
                    <span class="value price"><strong>{literal}{{total_tax_inl}}{/literal}</strong></span>
                  </div>
                  {literal}
                  {{/total_diff}}
                  {{^total_diff}}
                  {/literal}
                  <div class="flex-container">
                    <span class="label flex-grow1"><strong>{l s='Total' d='Shop.Theme.Amp'}</strong></span>
                    <span class="value price"><strong>{literal}{{total}}{/literal}</strong></span>
                  </div>
                  {literal}{{/total_diff}}{/literal}
                </div>

                <div class="cart-total flex-container">
                  <span class="label flex-grow1">{literal}{{totals.total.label}}{/literal}</span>
                  <span class="value">{literal}{{totals.total.value}}{/literal}</span>
                </div>

              </template>
            </amp-list>

          </div>

          {block name='cart_actions'}
            {include file='mobile/checkout/_partials/cart-detailed-actions.tpl' cart=$cart}
          {/block}

        </div>
      {/block}

    </div>
    {/if}

  </div>
</section>
{/block}