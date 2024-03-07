{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<template type="amp-mustache">
    
  <article class="product-miniature relative m40 {literal}{{has_discount}}{/literal}" data-id="{literal}{{id_product}}{/literal}" data-file="product-miniature.tpl">

    <div class="pm-product-img relative">
      <a href="{literal}{{amp_link}}{/literal}" title="{literal}{{name}}{/literal}">
        <amp-img src="{literal}{{cover.large.url}}{/literal}" width="{literal}{{cover.large.width}}{/literal}" height="{literal}{{cover.large.height}}{/literal}" layout="responsive" class="product-image-amp" alt="{literal}{{name}}{/literal}"></amp-img>
        {if (isset($amp.config.category.product.labels) && ($amp.config.category.product.labels == 1))}
        <ul class="product-labels">
          {if !$configuration.is_catalog && (isset($amp.config.category.product.label.discount) && ($amp.config.category.product.label.discount == 1))}
            {if (isset($amp.config.category.product.amount.discount) && ($amp.config.category.product.amount.discount == 1))}
            {literal}{{#discount_amount_to_display}}{/literal}
            <li class="discount-amount discount-product">{literal}{{discount_amount_to_display}}{/literal}
            </li>
            {literal}{{/discount_amount_to_display}}{/literal}
            {/if}
            {if (isset($amp.config.category.product.percent.discount) && ($amp.config.category.product.percent.discount == 1))}
            {literal}{{#discount_percentage}}{/literal}
            <li class="discount-perc discount-product">{literal}{{discount_percentage}}{/literal}
            </li>
            {literal}{{/discount_percentage}}{/literal}
            {/if}
          {/if}
          {if (isset($amp.config.category.product.label.new) && ($amp.config.category.product.label.new == 1))}
          {literal}{{#is_new}}{/literal}
          <li class="new">{l s='New' d='Shop.Theme.Catalog'}</li>
          {literal}{{/is_new}}{/literal}
          {/if}
          <li class="sale">{literal}{{flags.on-sale.label}}{/literal}</li>
          {if !$configuration.is_catalog && (isset($amp.config.category.product.label.oos) && ($amp.config.category.product.label.oos == 1))}
          {literal}{{^is_available_for_order}}{/literal}
          {* {literal}{{^quantity_null}}{/literal} *}
            <li class="label-outofstock">{l s='Out of stock' d='Shop.Theme.Actions'}</li>
          {* {literal}{{/quantity_null}}{/literal} *}
          {literal}{{/is_available_for_order}}{/literal}
          {/if}
          {literal}{{#pack}}{/literal}
            <li class="label-pack">{l s='Pack' d='Shop.Theme.Actions'}</li>
          {literal}{{/pack}}{/literal}
        </ul>
        {/if}
      </a>
      {if (isset($amp.config.category.product.colors) && ($amp.config.category.product.colors == 1))}
      <ul class="flex-container pm-product-colors">
        {literal}{{#main_variants}}
        {{#html_color_code}}
          <li style="background-color:{{html_color_code}};" title="{{name}}"></li>
        {{/html_color_code}}
        {{#texture}}
          <li style="background-image:url({{texture}});" title="{{name}}"></li>
        {{/texture}}
        {{/main_variants}}{/literal}
      </ul>
      {/if}

      <div hidden class="product-favorite product-like {literal}{{#isFavorite}}favorite{{/isFavorite}}{/literal}">
          <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#like"></use></svg>
      </div>

    </div>

    {if !$configuration.is_catalog}
    {literal}{{#show_price}}{/literal}
    <div class="product-price-amp price m15 flex-container">
      {literal}{{#has_discount}}{/literal}
      <span class="discount-price">
        <span class="regular-price">{literal}{{regular_price}}{/literal}</span>
      </span>
      {literal}{{/has_discount}}{/literal}
      {literal}{{#show_price}}{/literal}
      <span>{literal}{{price}}{/literal}</span>
      {literal}{{/show_price}}{/literal}
    </div>
    {literal}{{/show_price}}{/literal}
    {/if}

    <div class="width-float ellipsis product-title m15">
      <a href="{literal}{{amp_link}}{/literal}" title="{literal}{{name}}{/literal}">{literal}{{name}}{/literal}</a>
    </div>

    <div class="width-float ellipsis product-brand m15" hidden>
      {literal}{{manufacturer_name}}{/literal}
    </div>

    {if !$configuration.is_catalog}
    {literal}{{#main_variants_qty}}{/literal}
    <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" class="flex-container align-items-center" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info } });{/literal}">

      <input type="hidden" name="act" value="up">
      <input type="hidden" name="do" value="cartUpdate">
      <input type="hidden" name="id_product" value="{literal}{{id_product}}{/literal}">
      <input type="hidden" name="id_product_attribute" value="{literal}{{id_product_attribute}}{/literal}">
      {literal}{{#available_for_order}}{/literal}
      {literal}{{^is_customizable}}{/literal}
      <button type="submit" class="add-to-cart big-btn" role="button" tabindex="0">{l s='Add to cart' d='Shop.Theme.Amp'}</button>
      {literal}{{/is_customizable}}{/literal}
      {literal}{{/available_for_order}}{/literal}
      {literal}{{^available_for_order}}{/literal}
      <div class="flex-container align-items-center atc-dis">
      <button type="submit" class="add-to-cart big-btn" disabled="">{l s='Unavailable' d='Shop.Theme.Amp'}</button>
      </div>
      {literal}{{/available_for_order}}{/literal}

      <div submit-success><div class="flex-container align-items-center"><span>{l s='Success' d='Shop.Theme.Amp'}&nbsp;</span><amp-bodymovin-animation layout="flex-item" width="34" height="34" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation></div></div>
      <div submit-error>{l s='Unable to Add to cart' d='Shop.Theme.Amp'}</div>
      <div submitting>{l s='Waiting' d='Shop.Theme.Amp'}...</div>

    </form>
    {literal}{{/main_variants_qty}}{/literal}
    {literal}{{^main_variants_qty}}{/literal}
    <a href="{literal}{{amp_link}}{/literal}" class="add-to-cart big-btn btn">{l s='View Product' d='Shop.Theme.Amp'}</a>
    {literal}{{/main_variants_qty}}{/literal}
    {/if}

  </article>

</template>