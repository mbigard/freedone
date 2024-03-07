{*
 * This file allows you to customize your search page.
 * You can safely remove it if you want it to appear exactly like all other product listing pages
 *}

{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
  <h1 id="js-product-list-header" class="h2">{$listing.label}{if isset($smarty.get.s)}: {$smarty.get.s}{/if}</h1>
{/block}
