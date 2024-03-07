{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}
    
<article class="product-miniature relative" data-file="product.tpl">

  <div class="pm-product-img relative">
    <a href="{url entity='module' name={$amp.global.name} controller='product' relative_protocol=false params=['id_product' => $product.id_product, 'link_rewrite' => $product.link_rewrite]}" title="{$product.name|htmlspecialchars}">
      {if $product.cover}
      <amp-img src="{$product.cover.medium.url}" width="{$amp.global.images.home.size.width}" height="{$amp.global.images.home.size.height}" layout="responsive" class="product-image-amp"{if !empty($product.cover.legend)} alt="{$product.cover.legend|htmlspecialchars}" title="{$product.cover.legend|htmlspecialchars}"{else} alt="{$product.name|htmlspecialchars}"{/if}></amp-img>
      {else}
      <amp-img src="{$urls.no_picture_image.bySize.home_default.url}" width="{$amp.global.images.home.size.width}" height="{$amp.global.images.home.size.height}" layout="responsive" class="product-image-amp"{if !empty($product.cover.legend)} alt="{$product.cover.legend|htmlspecialchars}" title="{$product.cover.legend|htmlspecialchars}"{else} alt="{$product.name|htmlspecialchars}"{/if}></amp-img>
      {/if}
    </a>
    <ul class="product-labels">
      {if (isset($product.has_discount)) && ($product.has_discount == 1)}
        {if $product.discount_type === 'percentage'}
          {if (isset($product.discount_percentage))}
          <li>{$product.discount_percentage}</li>
          {/if}
        {elseif $product.discount_type === 'amount'}
          {if (isset($product.discount_amount_to_display))}
          <li>{$product.discount_amount_to_display}</li>
          {/if}
        {/if}
      {/if}
    </ul>
  </div>
  
  {if !$configuration.is_catalog && (isset($product.price_amount) && $product.price_amount != 0)}
  <div class="product-price-amp price m15">
    {if $product.has_discount}<span class="discount-price">{$product.regular_price}</span>{/if} {$product.price}
  </div>
  {/if}

  <a href="{url entity='module' name={$amp.global.name} controller='product' relative_protocol=false params=['id_product' => $product.id_product, 'link_rewrite' => $product.link_rewrite]}" title="{$product.name|htmlspecialchars}" class="ellipsis product-title m15">
    {$product.name}
  </a>

  {if !$configuration.is_catalog && $product.customizable == 0}
  {if empty($product.main_variants)}{* ALT--> if ($product.product_type != 'combinations')*}
  <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}" target="_top" class="flex-container align-items-center" on="{literal}submit-success: AMP.setState({ cartList: { items: event.response.items, info: event.response.info } });{/literal}">

    <input type="hidden" name="act" value="up">
    <input type="hidden" name="do" value="cartUpdate">
    <input type="hidden" name="id_product" value="{$product.id_product}">
    <input type="hidden" name="id_product_attribute" value="{$product.id_product_attribute}">
    <button type="submit" class="add-to-cart big-btn">{l s='Add to cart' d='Shop.Theme.Amp'}</button>

    <div submit-success><div class="flex-container align-items-center"><span>{l s='Success' d='Shop.Theme.Amp'}&nbsp;</span><amp-bodymovin-animation layout="flex-item" width="34" height="34" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation></div></div>
    <div submit-error>{l s='Unable to Add to cart' d='Shop.Theme.Amp'}</div>
    <div submitting>{l s='Waiting' d='Shop.Theme.Amp'}...</div>

  </form>
  {else}
    <a href="{url entity='module' name={$amp.global.name} controller='product' relative_protocol=false params=['id_product' => $product.id_product, 'link_rewrite' => $product.link_rewrite]}" class="btn big-btn">{l s='View Product' d='Shop.Theme.Amp'}</a>
  {/if}
  {/if}

</article>