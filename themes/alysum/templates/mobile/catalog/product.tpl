{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{if (isset($alt_urls) && ($alt_urls|count > 1))}
    {block name='head_hreflang'}
        {foreach from=$alt_urls item=pageUrl key=code}
            <link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
        {/foreach}
    {/block}
{/if}

{block name='head_seo' append}
    {if isset($product.name)}<meta property="og:title" content="{$product.name|escape:'htmlall':'UTF-8'}">{/if}
    {if isset($product.description_short)}<meta property="og:description" content="{$product.description_short|strip_tags:false|escape:'htmlall':'UTF-8'}">{/if}
    {if isset($product.link)}<meta property="og:url" content="{$product.link nofilter}">{/if}
    {if isset($product.images.0.bySize.medium_default.url)}<meta property="og:image" content="{$product.images.0.bySize.medium_default.url}">{/if}
    {if isset($product_manufacturer->name)}<meta property="product:brand" content="{$product_manufacturer->name}">{/if}
    {if isset($product.available_for_order)}<meta property="product:availability" content="{if $product.available_for_order == 1}In stock{else}Out of stock{/if}">{/if}
    {if isset($product.embedded_attributes.condition)}<meta property="product:condition" content="{$product.embedded_attributes.condition}">{/if}
    {if isset($product.price_amount)}<meta property="product:price:amount" content="{$product.price_amount}">{/if}
    {if isset($currency.iso_code)}<meta property="product:price:currency" content="{$currency.iso_code}">{/if}
    {if isset($product.id)}<meta property="product:retailer_item_id" content="{$product.id}">{/if}
{/block}

{block name='head_scripts' append}
    <script async custom-element="amp-social-share" src="https://cdn.ampproject.org/v0/amp-social-share-0.1.js"></script>
    <script type="application/ld+json">
    {literal}
    {
        "@context": "https://schema.org/",
        "@type": "Product",
        "name": "{/literal}{$product.name}{literal}",
        "image": "{/literal}{$product.cover.large.url}{literal}",
        "description": "{/literal}{$product.description_short|strip_tags:false}{literal}",
        "mpn": "{/literal}{$product.reference}{literal}",
        "sku": "{/literal}{$product.reference_to_display}{literal}",
        "brand": {
            "@type": "Brand",
            "name": "{/literal}{$product.manufacturer_name}{literal}"
        },
            "aggregateRating": {
                "@type": "AggregateRating",
                "ratingValue": "{/literal}{if (isset($rating.grade))}{$rating.grade}{else}5{/if}{literal}",
                "reviewCount": "{/literal}{if (isset($rating.reviewCount) && ($rating.reviewCount != 0))}{$rating.reviewCount}{else}1{/if}{literal}",
                "worstRating": "1",
                "bestRating": "5"
            },
            "review": {
                "@type": "Review",
                "reviewRating": {
                "@type": "Rating",
                "ratingValue": "{/literal}{if (isset($rating.grade))}{$rating.grade}{else}5{/if}{literal}",
                "bestRating": "5",
                "worstRating": "1"
                },
                "author": {
                "@type": "Person",
                "name": "Dayra.eu"
                }
            },
        "offers": {
            "@type": "Offer",
            "url": "{/literal}{$product.link}{literal}",
            "priceCurrency": "{/literal}{$currency.iso_code}{literal}",
            "price": "{/literal}{$product.price_amount}{literal}",
            {/literal}{if isset($product.available_for_order)}{literal}
            "availability": "https://schema.org/InStock",
            {/literal}{else}{literal}
            "availability": "https://schema.org/OutOfStock",
            {/literal}{/if}{literal}
            {/literal}{if isset($product.embedded_attributes.condition) && ($product.embedded_attributes.condition == 'new')}{literal}
            "itemCondition": "https://schema.org/NewCondition",
            {/literal}{/if}{literal}
            {/literal}{if isset($product.embedded_attributes.condition) && ($product.embedded_attributes.condition == 'used')}{literal}
            "itemCondition": "https://schema.org/UsedCondition",
            {/literal}{/if}{literal}
            "priceValidUntil": "{/literal}{$smarty.now|date_format:"%Y"+1}-{$smarty.now|date_format:"%m-%d"}{literal}"
        }
    }
    {/literal}
    </script>
{/block}

{block name='content'}
<div class="page-content-amp">
    <div id="product-image-amp" class="m20 relative"> 

    <amp-list binding="no" id="product-images" width="{$amp.global.images.medium.size.width}" height="{$amp.global.images.medium.size.height}" layout="responsive" single-item src="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false}?{foreach from=$groups key=id_attribute_group item=group}group[{$id_attribute_group}]={$group.default}&amp;{/foreach}id_product_attribute={$product.id_product_attribute}&id_product={$product.id_product}" items="items" [src]="attributes.items">
      <template type="amp-mustache">
        <amp-carousel type="slides" layout="fill" {if (isset($amp.config.product.carousel.autoplay) && ($amp.config.product.carousel.autoplay == 1))} autoplay{/if}{if (isset($amp.config.product.carousel.controls) && ($amp.config.product.carousel.controls == 1))} controls{/if} delay="{if (isset($amp.config.product.carousel.delay))}{$amp.config.product.carousel.delay}{else}3000{/if}">
          {literal}{{#images}}{/literal}
          <amp-img src="{literal}{{url}}{/literal}" layout="fill" alt="{$product.name}"></amp-img>
          {literal}{{/images}}{/literal}
        </amp-carousel>
      </template>
    </amp-list>

    <ul class="product-labels">
      {foreach from=$product.flags item=flag}
        <li class="product-flag {$flag.type}">{$flag.label}</li>
      {/foreach}
      {if $product.has_discount && false} <!-- DISABLED -->
        {if $product.discount_type === 'percentage'}
          <li class="product-flag discount">{l s='Save %percentage%' d='Shop.Theme.Catalog' sprintf=['%percentage%' => $product.discount_percentage_absolute]}</li>
        {else}
          <li class="product-flag discount">
            {l s='Save %amount%' d='Shop.Theme.Catalog' sprintf=['%amount%' => $product.discount_to_display]}
          </li>
        {/if}
      {/if}
    </ul>

  </div>

  {if ( isset($amp.config.product.brand) && ($amp.config.product.brand == 1) && ($product.manufacturer_name != '') )}
  <div class="product-brand-amp m15 text-uppercase">
    <a href="{$product.manufacturer_link}">{$product.manufacturer_name}</a>
  </div>
  {/if}

  <h1 class="product-name-amp m15 roboto">
    {$product.name}
  </h1>

  {if !$configuration.is_catalog && $product.show_price}
  <div class="product-price-amp m15 flex-container" style="align-items: baseline;">
    <span class="discount-price" [hidden]="!attributes.isDiscounted"{if (!$product.has_discount)} hidden{/if}>
      <span class="regular-price" [text]="attributes.regular_price">{$product.regular_price}</span>
    </span>
    <span itemprop="price" content="{$product.price_amount}" [text]="attributes.price" class="price">{$product.price}</span>
    {block name='product_unit_price'}
      {if isset($displayUnitPrice) && $displayUnitPrice}
        <div class="product-unit-price sub">&nbsp;{l s='(%unit_price%)' d='Shop.Theme.Catalog' sprintf=['%unit_price%' => $product.unit_price_full]}</div>
      {/if}
    {/block}
  </div>
  <div class="tax-shipping-delivery-label">
    {if $configuration.display_taxes_label}
      {$product.labels.tax_long}
    {/if}
    {hook h='displayProductPriceBlock' product=$product type="price"}
    {hook h='displayProductPriceBlock' product=$product type="after_price"}
    {if isset($product.additional_delivery_times)}
      {if $product.additional_delivery_times == 1}
        {if $product.delivery_information}
          <span class="delivery-information">{$product.delivery_information}</span>
        {/if}
      {elseif $product.additional_delivery_times == 2}
        {if $product.quantity > 0}
          <span class="delivery-information">{$product.delivery_in_stock}</span>
        {else}
          <span class="delivery-information">{$product.delivery_out_stock}</span>
        {/if}
      {/if}
    {/if}
  </div>

  {hook h='displayProductPriceBlock' product=$product type="weight" hook_origin='product_sheet'}
  {/if}

  {if !empty($product.reference_to_display)}
  <div class="m15">
    {l s='Reference' d='Shop.Theme.Amp'}: <span [text]="attributes.reference.reference">{$product.reference_to_display}</span>
  </div>
  {/if}

  {if !empty($product.quantity) && !$configuration.is_catalog && Configuration::get('display_quantities')}
  <div class="m15">
    {l s='Quantity' d='Shop.Theme.Amp'}: <span [text]="attributes.quantity">{$product.quantity}</span>
  </div>
  {/if}

  {if (isset($rating))}
  <div class="product-rating flex-container align-items-center m15">
    {assign var=stars_num value=5}
    {assign var=stars_num_act value=$stars_num}
    {l s='Rating' d='Shop.Theme.Amp'}:&nbsp;
    <div class="star_content">
      <div class="max-rating star-container">
        {while $stars_num_act-- > 0}
          <svg class="svgic svgic-pk-star"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#pk-star"></use></svg>
        {/while}
      </div>
      <div class="star-rating" style="width:{(100/$stars_num)*$rating.grade}%">
        <div class="cut-stars star-container">
        {while $stars_num-- > 0}
          <svg class="svgic svgic-pk-star"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#pk-star"></use></svg>
        {/while}
        </div>
      </div>
    </div>
    <a id="open-reviews" href="#review-section" class="add-action"><span>|</span>{l s='Add review' d='Shop.Theme.Amp'}</a>
  </div>
  {/if}

  {if (isset($amp.config.product.shortdescription) && ($amp.config.product.shortdescription == 1))}
  <div class="product-desc-amp m30">
    {$product.description_short nofilter}
  </div>
  {/if}

  {if $product.is_customizable && count($product.customizations.fields)}
  {block name='product_customization'}
    {include file="mobile/catalog/_partials/product-customization.tpl" customizations=$product.customizations}
  {/block}
  {/if}
  
  <div class="product-actions m80">
    {if (isset($amp.config.product.sizeguide) && ($amp.config.product.sizeguide == 1))}
    {if !empty($sizeGuide)}
    <amp-lightbox id="sizeguide-popup" layout="nodisplay" scrollable>
      <div class="lightbox" on="tap:sizeguide-popup.close" role="button" tabindex="0">
        <div class="space flex-container">
        {if isset($sizeGuide.guide)}
          {if $sizeGuide.guide->title}
            <h2 class="m20">{$sizeGuide.guide->title nofilter}</h2>
          {/if}
          {if (!empty($sizeGuide.guide->description) && $sizeGuide.guide->active == 1)}
          <div class="product-guide-desc m40">
            {$sizeGuide.guide->description nofilter}
          </div>
          {/if}
        {/if}
        {if $sizeGuide.show_measure}
          {$sizeGuide.howto nofilter}
        {/if}
        {if $sizeGuide.show_global}
          {$sizeGuide.global nofilter}
        {/if}
        {if !empty($sizeGuide.brand_guides)}
          {foreach from=$sizeGuide.brand_guides item=guide key=key name=guides}
          <div class="guide-pane">
            {$guide->description nofilter}
          </div>
          {/foreach}
        {/if}
        </div>
        <button on="tap:sizeguide-popup.close" tabindex="0" class="w100 absolute flex-container justify-center align-items-center">
          <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg>{l s='Close' d='Shop.Theme.Amp'}
        </button>
      </div>
    </amp-lightbox>
    <button on="tap:sizeguide-popup">
      {l s='Size Guide' d='Shop.Theme.Amp'}
    </button>
    <br><br>
    {/if}
    {/if}

    {assign var=groups_count value=0} 
    {foreach from=$groups key=id_attribute_group item=group}
      {if ($group.attributes|count > 0)}
        {assign var=groups_count value=1} 
      {/if}          
    {/foreach}

    {assign var=pQty value=$product.minimal_quantity}
    {if ($pQty == 0 || empty({$pQty}))}
      {assign var=pQty value=1}
    {/if}

    <form id="product-attributes" method="GET" action="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false}" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false}" target="_top" class="product-attributes flex-container align-items-center m15" on="{literal}submit-success: AMP.setState({ attributes: { price: event.response.price, regular_price: event.response.regular_price, id_product_attribute: event.response.id_product_attribute, quantity: event.response.quantity, display_quantity: event.response.display_quantity, allow_oosp: event.response.allow_oosp, available_later: event.response.available_later, available_message: event.response.available_message, isDiscounted: event.response.isDiscounted, reference: event.response.reference, is_available: event.response.is_available, items: event.response.items } }){/literal}"{if ($groups_count == 0)} hidden{/if}>
      <input type="hidden" name="id_product" value="{$product.id_product}">
      <input type="hidden" name="qty" value="{$pQty}" [value]="attributes.display_quantity">
      <div class="product-variants m40 w100">
        {foreach from=$groups key=id_attribute_group item=group}
          <div class="clearfix product-variants-item m40">
            <strong class="control-label db m10">{$group.name}</strong>
            {if $group.group_type == 'select'}
              <select id="group_{$id_attribute_group}" class="form-control form-control-select" name="group[{$id_attribute_group}]"{if ($group.attributes|count > 1)} on="change:product-attributes.submit"{/if}>
                {foreach from=$group.attributes key=id_attribute item=group_attribute}
                  <option value="{$id_attribute}" title="{$group_attribute.name}"{if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name}</option>
                {/foreach}
              </select>
            {elseif $group.group_type == 'color'}
              <ul id="group_{$id_attribute_group}" class="flex-container attr-list">
                {foreach from=$group.attributes key=id_attribute item=group_attribute}
                  <li>
                    <input hidden class="input-color" id="attr{$id_attribute}" type="radio" role="radio" tabindex="0" name="group[{$id_attribute_group}]" value="{$id_attribute}"{if $group_attribute.selected} checked aria-checked="true"{/if}{if ($group.attributes|count > 1)} on="tap:product-attributes.submit"{/if}>
                    <label role="button" tabindex="0" for="attr{$id_attribute}"{if $group_attribute.html_color_code} class="color" style="background-color: {$group_attribute.html_color_code}"{/if}{if $group_attribute.texture} class="color texture" style="background-image: url({$group_attribute.texture})"{/if}><span class="sr-only">{$group_attribute.name}</span></label>
                  </li>
                {/foreach}
              </ul>
            {elseif $group.group_type == 'radio'}
              <ul id="group_{$id_attribute_group}" class="flex-container attr-list-radio">
                {foreach from=$group.attributes key=id_attribute item=group_attribute}
                  <li class="input-container relative">
                    <input id="attr{$id_attribute}" class="input-radio" type="radio" role="radio" tabindex="0" name="group[{$id_attribute_group}]" value="{$id_attribute}"{if $group_attribute.selected} checked aria-checked="true"{/if}{if ($group.attributes|count > 1)} on="tap:product-attributes.submit"{/if}>
                    <label role="button" tabindex="0" for="attr{$id_attribute}" class="radio-label">{$group_attribute.name}</label>
                  </li>
                {/foreach}
              </ul>
            {/if}
          </div>
        {/foreach}

        <div id="apply-alert" hidden class="notification alert apply-alert">{l s='Click "Apply Attributes" button' d='Shop.Theme.Amp'}</div>

        {if ($groups_count == 1)}
        <div class="flex-container align-items-center" hidden>
          <button on="tap:product-attributes.submit;tap:product-images.refresh;tap:apply-alert.hide">
            {l s='Apply Attributes' d='Shop.Theme.Amp'}
          </button>
          <div submitting>&nbsp;{l s='Waiting' d='Shop.Theme.Amp'}...</div>
        </div>
        {/if}

      </div>

      <amp-state id="attributes">
        <script type="application/json">
          {literal}
          {
            "reference": {
              "reference": "{/literal}{$product.reference_to_display}{literal}"
            },
            "is_available": "{/literal}{if $product.quantity > 0}1{else}0{/if}{literal}",
            "allow_oosp": "{/literal}{$product.show_addtocart}{literal}",
            "price": "{/literal}{$product.price_amount|round:2|number_format:2:",":"."} {$currency.sign}{literal}",
            "regular_price": "{/literal}{$product.regular_price_amount|round:2|number_format:2:",":"."} {$currency.sign}{literal}",
            "isDiscounted": "{/literal}{$product.has_discount}{literal}",
            "id_product_attribute": "{/literal}{$product.id_product_attribute}{literal}",
            "product_quantity": "{/literal}{$product.quantity}{literal}",
            "display_quantity": "1",
            "quantity": "{/literal}{$product.quantity}{literal}",
            "items": {/literal}{
                "images": [{foreach from=$product.images item=image name=pimgs}{
                      "url": "{$image.large.url}"
                }{if !$smarty.foreach.pimgs.last},{/if}
                {/foreach}]
            }{literal}
          }
          {/literal}
         </script>
      </amp-state>

    </form>

    {if !$configuration.is_catalog}
    <div class="notification alert text-center"{if (isset($product.show_addtocart) && $product.show_addtocart)} hidden{/if} [hidden]="attributes.allow_oosp">
      {l s='No products in stock with such attributes' d='Shop.Theme.Amp'}
    </div>
    <br>

    {block name='product_discounts'}
      {include file='mobile/catalog/_partials/product-discounts.tpl'}
    {/block}

    <div class="updpwncontainer flex-container m20">
      <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false}" target="_top" on="{literal}submit-success: AMP.setState({ attributes: { display_quantity: event.response.display_quantity, is_available: event.response.is_available } });{/literal}">
        <div class="flex-container align-items-center atc-sect">
          <input type="hidden" name="id_product" value="{$product.id_product}">
          <input type="hidden" name="qty" value="{$pQty}" [value]="attributes.display_quantity">
          <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}" [value]="attributes.id_product_attribute">
          {if (isset($product.id_customization) && !empty($product.id_customization) && $product.id_customization != 0)}
          <input type="hidden" name="id_customization" value="{$product.id_customization}">
          {/if}
          <input type="hidden" name="validate_availability" value="1">
          <button class="btn" tabindex="0" name="act" value="down">-</button>
        </div>
      </form>
      <input type="text" name="qty" value="{$pQty}" class="qty qty2" [value]="attributes.display_quantity" style="min-width:50px">
      <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false}" target="_top" on="{literal}submit-success: AMP.setState({ attributes: { display_quantity: event.response.display_quantity, is_available: event.response.is_available } });{/literal}">
        <div class="flex-container align-items-center atc-sect">
          <input type="hidden" name="id_product" value="{$product.id_product}">
          <input type="hidden" name="qty" value="{$pQty}" [value]="attributes.display_quantity">
          <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}" [value]="attributes.id_product_attribute">
          {if (isset($product.id_customization) && !empty($product.id_customization) && $product.id_customization != 0)}
          <input type="hidden" name="id_customization" value="{$product.id_customization}">
          {/if}
          <input type="hidden" name="validate_availability" value="1">
          <button class="btn" tabindex="0" name="act" value="up">+</button>
        </div>
      </form>

      {if (isset($favorite))}
      <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false params=['favorite' => true, 'id_product' => {$product.id_product}]}" target="_top" class="product-favorite flex-container{if ($favorite.isFavorite)} favorite{/if}" on="{literal}submit-success:AMP.setState({ addToFavorites: { isFavorite: event.response.isFavorite } }){/literal}" [class]="addToFavorites.isFavorite ? 'product-favorite flex-container favorite' : 'product-favorite flex-container'" [hidden]="!attributes.allow_oosp"{if (isset($product.show_addtocart) && !$product.show_addtocart)} hidden{/if}>
        <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}" [value]="attributes.id_product_attribute">
        <button type="submit" class="product-like relative" aria-label="{l s='Add to Favorites' d='Shop.Theme.Amp'}">
          <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#like"></use></svg>
          <span><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#loading"></use></svg></span>
        </button>
        <div submit-error>{l s='Unable to add to favorites' d='Shop.Theme.Amp'}</div>
      </form>

      <amp-state id="addToFavorites">
        <script type="application/json">
        {
          "isFavorite": {if $favorite.isFavorite}{$favorite.isFavorite}{else}0{/if}
        }
        </script>
      </amp-state>
      {/if}

    </div>

    <div class="add-to-buttons m15 flex-container relative">
      <form class="flex-grow1" id="add-to-cart" method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false}" target="_top" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info}, attributes: {price: event.response.price, id_product_attribute: event.response.id_product_attribute, quantity: event.response.quantity } });{/literal}" [hidden]="!attributes.allow_oosp"{if (isset($product.show_addtocart) && !$product.show_addtocart)} hidden{/if}>
        <input type="hidden" name="cart_id" value="{$amp.cart.cart_id}">
        <input type="hidden" name="token" value="{$static_token}">
        <input type="hidden" name="act" value="up">
        <input type="hidden" name="do" value="cartUpdate">
        <input type="hidden" name="id_product" value="{$product.id_product}">
        <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}" [value]="attributes.id_product_attribute">
        <input type="hidden" name="price" value="{$product.price}" [value]="attributes.price">
        <input type="hidden" name="qty" value="{$pQty}" [value]="attributes.display_quantity">
        <button on="tap:add-to-cart.submit" class="add-to-cart big-btn">{l s='Add to cart' d='Shop.Theme.Amp'}</button>
        {if $pQty > 1}
        <br>
        <div class="minimum-quantity notification alert">
          {l s='The minimum quantity required to buy' d='Shop.Theme.Amp'}: <strong>{$pQty}</strong>
        </div>
        {/if}
        <div submit-success class="flex-container align-items-center act-response">
          <amp-bodymovin-animation layout="flex-item" width="34" height="34" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation><span>&nbsp;{l s='The product is in your cart now' d='Shop.Theme.Amp'}</span>
        </div>
        <div class="act-response" submitting>{l s='Waiting' d='Shop.Theme.Amp'}...</div>
        <div class="act-response" submit-error>{l s='Unable to Add to cart' d='Shop.Theme.Amp'}</div>

      </form>

    </div>

    {block name='product_availability'}
      <div id="product-availability" class="m40" [hidden]="!attributes.allow_oosp"{if (isset($product.show_addtocart) && !$product.show_addtocart)} hidden{/if}>
          <div [hidden]="!attributes.is_available"{if $product.quantity <= 0} hidden{/if} class="in-stock">
            <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#done"></use></svg>&nbsp;
            {if $product.available_now != ''}{$product.available_now}{else}{l s='In stock' d='Shop.Theme.Amp'}{/if}
          </div>
          <div [hidden]="attributes.is_available"{if $product.quantity > 0} hidden{/if} class="out-stock">
            <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#done"></use></svg>&nbsp;
            {if $product.available_later != ''}{$product.available_later}{else}{l s='No items in stock' d='Shop.Theme.Amp'}{/if}
          </div>
        </div>
        <div [hidden]="!attributes.available_for_order"{if $product.available_for_order} hidden{/if}>
          <div><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg>&nbsp;{l s='No items in stock' d='Shop.Theme.Amp'}</div>
        </div>
      </div>
    {/block}

    {if (isset($mailalert.email) && ($mailalert.email == 1))}
    <form class="m40 mailalert-form" method="GET" target="_top" action="{url entity='module' name={$amp.global.name} controller='ajaxMailAlert' relative_protocol=false params=['process' => 'add']}" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxMailAlert' relative_protocol=false params=['process' => 'add']}" custom-validation-reporting="show-all-on-submit">
      <div class="flex-container m10">
        <input type="email" class="form-control m0" id="mailAlerEmail" placeholder="{l s='your@email.com' d='Shop.Theme.Amp'}" required aria-label="{l s='Your Email' d='Shop.Theme.Amp'}" name="customer_email" />
        <input type="hidden" name="id_product" value="{$product.id_product}"/>
        <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}"/>
        <button class="btn btn-primary mailalert-submit" type="submit" rel="nofollow">
          {l s='Notify me when available' d='Shop.Theme.Amp'}
        </button>
      </div>
      {if isset($mailalert.gdpr.id_module)}
        {include file='mobile/_partials/gdpr.tpl' gdpr=$mailalert.gdpr}
      {/if}
      <span class="db" visible-when-invalid="valueMissing" validation-for="mailAlerEmail">{l s='Email address is missing' d='Shop.Theme.Amp'}</span>
      <span class="db" visible-when-invalid="typeMismatch" validation-for="mailAlerEmail">{l s='Wrong email address' d='Shop.Theme.Amp'}</span>
      <div submit-success class="text-left">
        <template type="amp-mustache">
          <span class="error-{literal}{{error}}{/literal}">{literal}{{message}}{/literal}</span>
        </template>
      </div>

      <div submit-error class="text-left">
        <template type="amp-mustache">
         <span class="error-{literal}{{error}}{/literal}">{literal}{{message}}{/literal}</span>
        </template>
      </div>
    </form>
    {/if}

    <amp-state id="product_quantity">
      <script type="application/json">[{$pQty}]</script>
    </amp-state>
    {/if}

    <div class="social-sharing flex-container m40">
      {if isset($amp.config.social)}
        {foreach from=$amp.config.social item=state key=name}
          {if $state == 1}
            <amp-social-share type="{$name}"{if $name == 'facebook' && isset($amp.config.general.facebookappid)} data-param-app_id="{$amp.config.general.facebookappid}"{/if}></amp-social-share>
          {/if}
        {/foreach}
      {/if}
    </div>

    {if (isset($reassurance))}
    <div id="block-reassurance" class="w-100">
      <ul>
        {foreach from=$reassurance item=element}
        <li>
          {if !empty($element.link)}<a href="{$element.link}">{/if}
            <div class="flex-container">
              <amp-img class="brimg" src="{if !empty($element.icon)}{$element.icon}{else}{$element.custom_icon}{/if}" alt="reassurance" layout="fixed" width="30" height="30"></amp-img>
              <div>
              <span>{$element.title|unescape:"html" nofilter}</span>
              <span>{$element.description|unescape:"html" nofilter}</span>
              </div>
            </div>
          {if !empty($element.link)}</a>{/if}
        </li>
        {/foreach}
      </ul>
    </div>
    {/if}

  </div>

  <amp-accordion id="additional-info" disable-session-states animate class="flex-container flex-column ampstart-headerbar-nav product-details m80">
    {if $product.description}
    <section {if $product.description} expanded{/if}>
      <h4 role="tab" class="tabButton h4 ampstart-nav-item">
        <div class="flex-container align-items-center">
          <div class="flex-grow1">{l s='Description' d='Shop.Theme.Catalog'}</div>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
        </div>
      </h4>
      <div role="tabpanel" class="tabContent p1 p">
        {$product.description nofilter}
      </div>
    </section>
    {/if}
    <section {if !$product.description} expanded{/if}>
      <h4 role="tab" class="tabButton h4 ampstart-nav-item">
        <div class="flex-container align-items-center">
          <div class="flex-grow1">{l s='Product Details' d='Shop.Theme.Catalog'}</div>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
        </div>
      </h4>
      <div role="tabpanel" class="tabContent p1 p">
        {if isset($product_manufacturer->id)}
          <div class="product-manufacturer">
            {if isset($manufacturer_image_url)}
              <a href="{$product_brand_url}">
                <img src="{$manufacturer_image_url}" class="img img-thumbnail manufacturer-logo" />
              </a>
            {else}
              <label class="label">{l s='Brand' d='Shop.Theme.Catalog'}</label>
              <span>
                <a href="{$product_brand_url}">{$product_manufacturer->name}</a>
              </span>
            {/if}
          </div>
        {/if}

        {if isset($product.reference_to_display)}
        <div class="product-reference m10">
          <label class="label">{l s='Reference' d='Shop.Theme.Catalog'} </label>
          <span itemprop="sku">{$product.reference_to_display}</span>
        </div>
        {/if}

        {if isset($product.quantity) && isset($product.quantity_label)}
        <div class="product-quantities">
          <label class="label">{l s='In stock' d='Shop.Theme.Catalog'}</label>
          <span>{$product.quantity} {$product.quantity_label}</span>
        </div>
        {/if}

        {if $product.availability_date}
        <div class="product-availability-date">
          <label>{l s='Availability date:' d='Shop.Theme.Catalog'} </label>
          <span>{$product.availability_date}</span>
        </div>
        {/if}

        {if !empty($product.features)}
        <div class="product-features m15">
          <strong class="h6">{l s='Data sheet' d='Shop.Theme.Catalog'}</strong>
          <table>
          {foreach from=$product.features item=feature}
          <tr class="feat{$feature.id_feature}">
            <td class="name">{$feature.name}</td>
            <td class="value">{$feature.value|escape:'htmlall'|nl2br nofilter}</td>
          </tr>
          {/foreach}
          </table>
        </div>
        {/if}

        {if isset($product.specific_references) && !empty($product.specific_references)}
        <div class="product-features">
          <strong class="h6">{l s='Specific References' d='Shop.Theme.Catalog'}</strong>
            <dl class="data-sheet">
              {foreach from=$product.specific_references item=reference key=key}
                <dt class="name">{$key}</dt>
                <dd class="value">{$reference}</dd>
              {/foreach}
            </dl>
        </div>
        {/if}

        {if $product.condition}
        <div class="product-condition">
          <label class="label">{l s='Condition' d='Shop.Theme.Catalog'}</label>
          <span>{$product.condition.label}</span>
        </div>
        {/if}
      </div>
    </section>
    {if $product.attachments}
    <section>
      <h4 role="tab" class="tabButton h4 ampstart-nav-item">
        <div class="flex-container align-items-center">
          <div class="flex-grow1">{l s='Attachments' d='Shop.Theme.Catalog'}</div>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
        </div>
      </h4>
      <div role="tabpanel" class="tabContent p1 p">
        {if $product.attachments}
        <div class="tab-pane fade in" id="attachments">
           <div class="product-attachments">
             <strong class="h5 text-uppercase">{l s='Download' d='Shop.Theme.Actions'}</strong>
             {foreach from=$product.attachments item=attachment}
               <div class="attachment">
                 <h4><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a></h4>
                 <p>{$attachment.description}</p>
                 <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                   {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                 </a>
               </div>
             {/foreach}
           </div>
         </div>
        {/if}
      </div>
    </section>
    {/if}

    {if isset($rating.reviews)}
    <section id="review-section">
      <h4 role="tab" class="tabButton h4 ampstart-nav-item">
        <div class="flex-container align-items-center">
          <div class="flex-grow1">{l s='Reviews' d='Shop.Theme.Amp'}</div>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
        </div>
      </h4>
      <div role="tabpanel" class="tabContent p1 p" id="review-section-content">
        <div class="tab-pane fade in">
          <div class="review-form">
          {if (isset($rating.allow_comment) && $rating.allow_comment)} 
            <form id="product-review" method="GET" action="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false params=['addReview' => true]}" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxProduct' relative_protocol=false params=['addReview' => true]}" target="_top" class="flex-container flex-column m30">
              <input required type="text" name="comment_title" class="m10 form-control" placeholder="{l s='Title' d='Shop.Theme.Amp'}">
              {if !$customer.is_logged}
              <input required type="text" name="author_name" class="m10 form-control" placeholder="{l s='Your Name' d='Shop.Theme.Amp'}">
              {/if}
              <textarea required name="comment_content" class="m10 form-control" placeholder="{l s='Comment' d='Shop.Theme.Amp'}"></textarea>
              
              <div class="rating-stars flex-container">
                <input name="criterion[1]" type="radio" id="rating5" value="5" on="tap:product-review.submit" role="radio" tabindex="0">
                <label for="rating5" title="5 stars">☆</label>
                <input name="criterion[1]" type="radio" id="rating4" value="4" on="tap:product-review.submit" role="radio" tabindex="0">
                <label for="rating4" title="4 stars">☆</label>
                <input name="criterion[1]" type="radio" id="rating3" value="3" on="tap:product-review.submit" role="radio" tabindex="0">
                <label for="rating3" title="3 stars">☆</label>
                <input name="criterion[1]" type="radio" id="rating2" value="2" on="tap:product-review.submit" role="radio" tabindex="0">
                <label for="rating2" title="2 stars">☆</label>
                <input name="criterion[1]" type="radio" id="rating1" value="1" on="tap:product-review.submit" role="radio" tabindex="0">
                <label for="rating1" title="1 stars">☆</label>
              </div>
              <div class="text-right">
                <i class="text-right">*{l s='Click on stars to submit your review' d='Shop.Theme.Amp'}</i>
              </div>
              <input type="hidden" name="pid" value="{$product.id_product}"/>

              <div submit-success>{l s='Thanks for review' d='Shop.Theme.Amp'}</div>
              <div submit-error>{l s='Unable to post review' d='Shop.Theme.Amp'}</div>
              <div submitting>{l s='Waiting' d='Shop.Theme.Amp'}...</div>
            </form>
            {else}
            <div class="notification alert apply-alert">{l s='Login to leave a review' d='Shop.Theme.Amp'}</div>
            {/if}
          </div>
          
          {foreach from=$rating.reviews item=review}
          <div class="review">
            <div class="review-header m15">
              <h3>{$review.title}</h3>
              <div class="flex-container flex-column">
                <small><strong>{$review.customer_name}</strong> {l s='at' d='Shop.Theme.Amp'} {$review.date_add|date_format:"%H:%M, %D"}</small>
                {assign var=stars_num value=5}
                {assign var=stars_num_act value=$stars_num}
                <div class="star_content m10">
                  <div class="max-rating star-container">
                    {while $stars_num_act-- > 0}
                      <svg class="svgic svgic-pk-star"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#pk-star"></use></svg>
                    {/while}
                  </div>
                  <div class="star-rating" style="width:{(100/$stars_num)*$review.grade}%">
                    <div class="cut-stars star-container">
                    {while $stars_num-- > 0}
                      <svg class="svgic svgic-pk-star"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#pk-star"></use></svg>
                    {/while}
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <p class="review-comment m10">
              "<i>{$review.content}</i>"
            </p>
          </div>
          {/foreach}
         </div>
      </div>
    </section>
    {/if}

    {foreach from=$customTabs item=tab}
      <section>
      <h4 role="tab" class="tabButton h4 ampstart-nav-item">
        <div class="flex-container align-items-center">
          <div class="flex-grow1">{$tab.name}</div>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
        </div>
      </h4>
      <div role="tabpanel" class="tabContent p1 p">
        {$tab.default_content nofilter}
      </div>
    </section>
    {/foreach}
  
  </amp-accordion>

  {if (isset($amp.config.product.accessories) && ($amp.config.product.accessories == 1) && !empty($accessories))}
  <section class="product-accessories pp-plist grid2 relative m40">
    <h4 class="module-title">
      <span>{l s='You might also like' d='Shop.Theme.Catalog'}</span>
    </h4>
    <amp-carousel {if (isset($amp.config.product.carousel.autoplay) && ($amp.config.product.carousel.autoplay == 1))}autoplay{/if} height="{$amp.global.images.home.size.height*0.4}" width="{$amp.global.images.home.size.width}" layout="responsive" type="slides" controls>
      {foreach from=$accessories item="accessory"}
        {include file="mobile/catalog/_partials/miniatures/product.tpl" product=$accessory image_size='home_default'}
      {/foreach}
    </amp-carousel>
  </section>
  {/if}

  {if (isset($amp.config.product.samecategory) && ($amp.config.product.samecategory == 1) && !empty($categoryproducts))}
  <section class="categoryproducts pp-plist grid2">
    <h4 class="module-title">
      <span>{l s='In the same category' d='Shop.Theme.Catalog'}</span>
    </h4>
    <amp-carousel {if (isset($amp.config.product.carousel.autoplay) && ($amp.config.product.carousel.autoplay == 1))}autoplay{/if}  height="{$amp.global.images.home.size.height*0.4}" width="{$amp.global.images.home.size.width}" layout="responsive" type="slides" controls>
      {foreach from=$categoryproducts item="product"}
        {include file="mobile/catalog/_partials/miniatures/product.tpl" product=$product image_size='home_default'}
      {/foreach}
    </amp-carousel>
  </section>
  {/if}

</div>
{/block}