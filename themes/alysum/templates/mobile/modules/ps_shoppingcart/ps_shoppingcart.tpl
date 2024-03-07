<amp-sidebar id="{$togglerId}" class="lang-select user-select relative" layout="nodisplay" side="right" on="sidebarOpen:cartList.refresh">

  {include file='mobile/_partials/button-close.tpl' togglerId=$togglerId togglerTitle={l s='My Cart' d='Shop.Theme.Amp'}}

  <div class="body m15">

    <amp-list id="cartProducts" src="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" layout="fixed-height" height="127" class="m30 mini-products" [src]="cartList.items" [is-layout-container]="cartList.items">

      <template type="amp-mustache">

        <div class="flex-container text-center align-items-center flex-column" [hidden]="cartList.items != null">
          <amp-bodymovin-animation layout="flex-item" width="256" height="256" src="{$amp.global.assets}json/empty.json" loop="true"></amp-bodymovin-animation>
          <div>{l s='Your Cart is Empty' d='Shop.Theme.Amp'}</div>
        </div>
          
        <div class="cart-product flex-container product-list-item" [hidden]="cartList.items == null">

          <a href="{literal}{{amp_link}}{/literal}" title="{literal}{{name}}{/literal}">
            <amp-img src="{literal}{{cover.medium.url}}{/literal}" width="{literal}{{cover.medium.width}}{/literal}" height="{literal}{{cover.medium.height}}{/literal}" layout="responsive" class="product-image-amp" alt="{literal}{{name}}{/literal}"></amp-img>
          </a>

          <div class="cart-product-info pk-cpi product-info">

            <a class="product-title ellipsis" href="{literal}{{amp_link}}{/literal}" title="{literal}{{name}}{/literal}">
              {literal}{{name}}{/literal}
            </a>

            <div class="m15">
              <small>{literal}{{{attributes_small}}}{/literal}</small>
            </div>

            <strong class="db m15 product-price price">
              {literal}
              {{#reduction_type}}<del>{{price}}</del>&nbsp;{{display_price_with_reduction}}&nbsp;{{/reduction_type}}
              {/literal}
              {literal}{{^reduction_type}}{{price}}&nbsp;{{/reduction_type}}{/literal}
              <span>(✕{literal}{{cart_quantity}}{/literal})</span>&nbsp;{literal}{{display_price_with_reduction}}{/literal}
            </strong>

            <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" class="flex-container align-items-center" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info } });{/literal}">
              <input type="hidden" name="do" value="deleteProduct">
              <input type="hidden" name="id_product" value="{literal}{{id_product}}{/literal}">
              <input type="hidden" name="id_product_attribute" value="{literal}{{id_product_attribute}}{/literal}">
              <input type="hidden" name="id_customization" value="{literal}{{id_customization}}{/literal}">
              <button type="submit" class="add-to-cart button" id="remove-from-cart">{l s='Remove' d='Shop.Theme.Amp'}</button>
              <div submitting>&nbsp;{l s='Waiting' d='Shop.Theme.Amp'}...</div>
              <div submit-success>&nbsp;{l s='Done' d='Shop.Theme.Amp'}</div>
              <div submit-error>&nbsp;{l s='Unable to remove' d='Shop.Theme.Amp'}</div>
            </form>
              
          </div>
        </div>

      </template>

      <div fallback>
        <div class="flex-container text-center align-items-center flex-column">
          <amp-bodymovin-animation layout="flex-item" width="256" height="256" src="{$amp.global.assets}json/empty.json" loop="true"></amp-bodymovin-animation>
          <div>{l s='Your Cart is Empty' d='Shop.Theme.Amp'}</div>
        </div>
      </div>

      <div overflow class="list-overflow"></div>

    </amp-list>

    <amp-list id="cartInfo" src="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id, 'who' => 'ps_shoppingcart.cartInfo']}" layout="fixed-height" width="auto" height="150" class="m1 m15 mini-products" [src]="cartList.info" items="info">

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

    <amp-state id="cartList" src="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id, 'who' => 'ps_shoppingcart.cartList', cacheid => $smarty.now]}">
      <script type="application/json">
        {if isset($amp.global.cartState)}
          {$amp.global.cartState|stripslashes nofilter}
        {else}
          {literal}{}{/literal}
        {/if}
      </script>
    </amp-state>

  </div>

  <div class="flex-container align-items-right">
    <a href="{url entity='module' name={$amp.global.name} controller='cart' relative_protocol=false}" class="button" role="button" tabindex="0">{l s='Cart' d='Shop.Theme.Amp'}</a>&nbsp;<a href="{url entity='module' name={$amp.global.name} controller='order' relative_protocol=false}" class="button" role="button" tabindex="0" hidden [hidden]="!cartList.items">{l s='Checkout' d='Shop.Theme.Amp'}</a>
  </div>

</amp-sidebar>