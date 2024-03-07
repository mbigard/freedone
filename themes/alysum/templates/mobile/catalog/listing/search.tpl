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
<h3 class="m15 font-normal">
{if ($searchStr != '')}
  {l s='You are searching for' d='Shop.Theme.Amp'}&nbsp;<strong>"{$searchStr}"</strong>
{else}
  {l s='Your search request is empty' d='Shop.Theme.Amp'}
{/if}
</h3>

{if (isset($items_num) && ($items_num > 0))}
  {if ($searchStr != '')}
  {if (isset($amp.config.category.product.filter) && ($amp.config.category.product.filter == 1))}
  {include file='mobile/catalog/_partials/sort-orders.tpl'}
  {/if}
  <!-- PRODUCT LIST -->
  <amp-list binding="no" src="{$searchUrl}" layout="fixed-height" height="580" id="productShownList" [src]="productState.isFilter ? productsList.items : ''" class="product-listing {if (isset($amp.config.category.product.columns))}{$amp.config.category.product.columns}{/if}" [hidden]="productsList.items.length == 0" load-more="{if (isset($amp.config.category.product.infinite) && ($amp.config.category.product.infinite == 1))}auto{else}manual{/if}" load-more-bookmark="nextPageUrl">

    {include file='mobile/catalog/_partials/miniatures/product-miniature.tpl'}  
    {include file='mobile/catalog/_partials/load-more.tpl'}
  </amp-list>
  {/if}
  <!-- /PRODUCT LIST -->
{else}
  <p class="notification alert" [hidden]="productsList.items.length == 0">{l s='No products found' d='Shop.Theme.Amp'}</p>
{/if}

{include file='mobile/catalog/_partials/product-bottom.tpl'}
{/block}