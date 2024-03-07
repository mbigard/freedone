{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<amp-img src="{$product.cover.bySize.cart_default.url}" width="{$amp.global.images.cart.size.width}" height="{$amp.global.images.cart.size.height}" style="min-width: {$amp.global.images.cart.size.width}px" alt="{$product.name|escape:'quotes'}" class="cart-image"></amp-img>

<div class="product-line-grid-body flex-grow1 relative">

  <div class="product-line-info">
    <a class="label" href="{$product.url}" data-id_customization="{$product.id_customization|intval}">{$product.name}</a>
  </div>

  <div class="product-line-info product-price h5 m20{if $product.has_discount} has-discount{/if}">
    {if $product.has_discount}
      <div class="product-discount">
        <span class="regular-price">{$product.regular_price}</span>
        {if $product.discount_type === 'percentage'}
          <span class="discount discount-percentage">
            -{$product.discount_percentage_absolute}
          </span>
        {else}
          <span class="discount discount-amount">
            -{$product.discount_to_display}
          </span>
        {/if}
      </div>
    {/if}
    <div class="current-price">
      <span class="price">{$product.price}</span>
      {if $product.unit_price_full}
        <div class="unit-price-cart">{$product.unit_price_full}</div>
      {/if}
    </div>
  </div>

  {foreach from=$product.attributes key="attribute" item="value"}
    <div class="product-line-info">
      <span class="label">{$attribute}:</span>
      <span class="value">{$value}</span>
    </div>
  {/foreach}

  {if $product.customizations|count}
    {block name='cart_detailed_product_line_customization'}
      {foreach from=$product.customizations item="customization"}
        <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
        <div class="modal fade customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
              </div>
              <div class="modal-body">
                {foreach from=$customization.fields item="field"}
                  <div class="product-customization-line row">
                    <div class="label">
                      {$field.label}
                    </div>
                    <div class="value">
                      {if $field.type == 'text'}
                        {if (int)$field.id_module}
                          {$field.text nofilter}
                        {else}
                          {$field.text}
                        {/if}
                      {elseif $field.type == 'image'}
                        <img src="{$field.image.small.url}">
                      {/if}
                    </div>
                  </div>
                {/foreach}
              </div>
            </div>
          </div>
        </div>
      {/foreach}
    {/block}
  {/if}

  <div class="product-line-grid-footer flex-container">
    <div class="qty flex-container">
      {if isset($product.is_gift) && $product.is_gift}
        <span class="gift-quantity">{$product.quantity}</span>
      {else}
      <form method="POST" id="cartItem" class="flex-container" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info} });{/literal}">

        <input type="hidden" name="token" value="{$static_token}">
        <input type="hidden" name="do" value="cartUpdate">
        <input type="hidden" name="id_product" value="{$product.id_product}">
        <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}">
        <input type="hidden" name="price" value="{$product.price}">
        <input type="hidden" name="cartPage" value="1">
        <input type="text" name="qty" class="flex-grow1" value="{$product.quantity}" on="change:cartItem.submit">

        <div class="input-buttons flex-container flex-column">
          <button name="act" value="up" class="up input-button" type="submit"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#up"></use></svg></button>
          <button name="act" value="down" class="down input-button" type="submit"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#down"></use></svg></button>
        </div>
      </form>
      {/if}
    </div>
    <div class="price">
      <span class="product-price">
        <strong>
          {if isset($product.is_gift) && $product.is_gift}
            <span class="gift">{l s='Gift' d='Shop.Theme.Checkout'}</span>
          {else}
            {$product.total}
          {/if}
        </strong>
      </span>
    </div>
  </div>
</div>
<form method="POST" class="flex-container" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info} });{/literal}">
  <input type="hidden" name="token" value="{$static_token}">
  <input type="hidden" name="do" value="deleteProduct">
  <input type="hidden" name="id_product" value="{$product.id_product}">
  <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}">
  <button type="submit" class="clearButton"><svg class="svgic svgic-down"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg></button>
</form>