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

{block name='content'}
<h2 class="roboto m20">
    {l s='Prices Drop' d='Shop.Theme.Amp'}
</h2>
{if (isset($amp.config.category.product.filter) && ($amp.config.category.product.filter == 1))}
{include file='mobile/catalog/_partials/sort-orders.tpl'}
{/if}
<amp-list binding="no" src="{$amp.global.urls.productListSource}" layout="fixed-height" height="580" id="productShownList" [src]="productState.isFilter ? productsList.items : ''" class="product-listing {if (isset($amp.config.category.product.columns))}{$amp.config.category.product.columns}{/if}" load-more="{if (isset($amp.config.category.product.infinite) && ($amp.config.category.product.infinite == 1))}auto{else}manual{/if}" load-more-bookmark="nextPageUrl">

  {include file='mobile/catalog/_partials/miniatures/product-miniature.tpl'}  
  {include file='mobile/catalog/_partials/load-more.tpl'}

</amp-list>

{include file='mobile/catalog/_partials/product-bottom.tpl'}
{/block}