{**
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='head_styles' append}
{/block}

{block name='head_scripts' append}
<script type="application/ld+json">
{literal}
{
  "@context": "https://schema.org",
  "@type": "Brand",
  "@name": "{/literal}{$manufacturer->name}{literal}",
  "@description": "{/literal}{$manufacturer->description|strip_tags}{literal}"
}
{/literal}
</script>
{/block}

{block name='content'}

{assign var="productListSource" value="{url entity='module' name={$amp.global.name} controller='ajaxFilter' relative_protocol=false params=['id_manufacturer' => $manufacturer->id]}"}
{assign var="cartURL" value="{url entity='module' name={$amp.global.name} relative_protocol=false controller='ajaxCart' params=['who' => 'manufacturer']}"}

<div class="brand-preview">
  <amp-img class="m15" alt="{$manufacturer->logo}" src="{$manufacturer->logo}" width="{if isset($amp.global.images.brand.size.width)}{$amp.global.images.brand.size.width}{else}300{/if}" height="{if isset($amp.global.images.brand.size.height)}{$amp.global.images.brand.size.height}{else}200{/if}" layout="responsive"></amp-img>
  <h2 class="brand-name m15">{$manufacturer->name}</h2>
  <div class="brand-description">{$manufacturer->description nofilter}</div>
</div>
{if (isset($amp.config.category.product.filter) && ($amp.config.category.product.filter == 1))}
{include file='mobile/catalog/_partials/sort-orders.tpl'}
{/if}
<!-- PRODUCT LIST -->
<amp-list binding="no" src="{$productListSource}" layout="fixed-height" height="580" id="productShownList" [src]="productState.isFilter ? productsList.items : ''" class="product-listing {if (isset($amp.config.category.product.columns))}{$amp.config.category.product.columns}{/if}" load-more="{if (isset($amp.config.category.product.infinite) && ($amp.config.category.product.infinite == 1))}auto{else}manual{/if}" load-more-bookmark="nextPageUrl">
  {include file='mobile/catalog/_partials/miniatures/product-miniature.tpl'}
  {include file='mobile/catalog/_partials/load-more.tpl'}
</amp-list>
<!-- /PRODUCT LIST -->
<amp-state id="addToCart" src="{$cartURL}">
  <script type="application/json">
    {
      "productId": ""
    }
  </script>
</amp-state>

<amp-state id="productsList" src="{$productListSource}">
</amp-state>

<amp-state id="productState">
  <script type="application/json">
    {literal}{
      "moreItemsPageIndex": {/literal}{$amp.global.vars.nextPageToLoad}{literal},
      "sortOrder": "position.asc",
      "hasMorePages": 1,
      "static_token": "{/literal}{$static_token}{literal}"
    }{/literal}
  </script>
</amp-state>

{/block}