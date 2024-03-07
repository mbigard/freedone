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

{block name='content'}

{assign var="productListSource" value="{url entity='module' name={$amp.global.name} controller='ajaxFilter' params=['id_supplier' => $supplier->id]}"}
{assign var="cartURL" value="{url entity='module' name={$amp.global.name} relative_protocol=false controller='ajaxCart' params=['who' => 'supplier']}"}

<div class="brand-preview">
  <amp-img hidden class="m15" alt="{$supplier->logo}" src="{$supplier->logo}" width="{$amp.global.images.medium.size.width}" height="{$amp.global.images.medium.size.height}" layout="responsive"></amp-img>
  <h2 class="brand-name m15">{$supplier->name}</h2>
  <div class="brand-description">{$supplier->description nofilter}</div>
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