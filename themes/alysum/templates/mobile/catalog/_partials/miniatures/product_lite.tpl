{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}
    
<article class="product-miniature pm-lite relative{if isset($type)} {$type}{/if}" data-file="product_lite.tpl">
{assign var="link_rewrite" value=''}
{if isset($product.link_rewrite)}
  {assign var="link_rewrite" value=''}
{/if}
  <a href="{url entity='module' name={$amp.global.name} controller='product' relative_protocol=false params=['id_product' => $product.id_product, 'link_rewrite' => $link_rewrite]}" title="{$product.name|escape:'htmlall'}" class="image-link db">
    <amp-img src="{$product.cover.medium.url}" width="{$amp.global.images.medium.size.width}" height="{$amp.global.images.medium.size.height}" layout="responsive" class="product-image-amp"{if !empty($product.cover.legend)} alt="{$product.cover.legend|escape:'htmlall'}" title="{$product.cover.legend|escape:'htmlall'}"{else} alt="{$product.name|escape:'htmlall'}"{/if}></amp-img>
  </a>
  <div class="product-info-amp flex-grow1">
    {if !$configuration.is_catalog}
    <div class="product-price-amp price m15">
      {$product.price}
    </div>
    {/if}

    <a href="{url entity='module' name={$amp.global.name} controller='product' params=['id_product' => $product.id_product, 'link_rewrite' => $link_rewrite]}" title="{$product.name|escape:'htmlall'}" class="ellipsis product-title m15">
      {$product.name}
    </a>
  </div>

</article>