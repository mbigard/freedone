{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

{assign var="pkconf" value=unserialize(Configuration::get('PKTHEME_CONFIG')|html_entity_decode)}

{assign var='miniatureClasses' value=['product-miniature', 'js-product-miniature']}
{if $product.quantity == 0}
    {append var='miniatureClasses' value='out-of-stock'}
{/if}
{if (isset($product.new) && $product.new == 1)}
    {append var='miniatureClasses' value='new'}
{/if}
{if (isset($product.bestseller) && ($product.bestseller == 1))}
    {append var='miniatureClasses' value='bestsellers'}
{/if}
{if (isset($product.featured) && $product.featured == 1)}
    {append var='miniatureClasses' value='featured'}
{/if}
{if (isset($product.reduction) && $product.reduction > 0)}
    {append var='miniatureClasses' value='discount'}
{/if}
{if isset($product.all_cats)}
    {append var='miniatureClasses' value={$product.all_cats}}
{else}
    {if isset($product.category)}
    {append var='miniatureClasses' value={$product.category}}
    {/if}
{/if}

{assign var="isHorizontal" value=0}
{if isset($pkproducts[$product.id_product])}
  {if isset($pkproducts[$product.id_product]['sizeh']) && !empty($pkproducts[$product.id_product]['sizeh'])}
      {append var='miniatureClasses' value="miniature-size-x-{$pkproducts[$product.id_product]['sizeh']}"}
      {assign var="isHorizontal" value=$pkproducts[$product.id_product]['sizeh']}
  {/if}
  {if isset($pkproducts[$product.id_product]['sizev']) && !empty($pkproducts[$product.id_product]['sizev'])}
      {append var='miniatureClasses' value="miniature-size-y-{$pkproducts[$product.id_product]['sizev']}"}
      {if ($isHorizontal == 2) && ($pkproducts[$product.id_product]['sizev'] == 1)}
      {assign var="isHorizontal" value=10}
      {/if}
  {/if}
{/if}

{assign var="isCustomImage" value=false}
{if (isset($pkproducts[$product.id_product]) && !empty($pkproducts[$product.id_product]['img']))}
  {assign var="isCustomImage" value=true}
  {append var='miniatureClasses' value="custom-image-active"}
{/if}

{assign var="isNativeLayout" value=true}
{if (isset($pkconf.pm_details_layout_type) && $pkconf.pm_details_layout_type != '0')}
  {assign var="isNativeLayout" value=false}
{/if}

{function name="countdownBlock"}
  {include file='catalog/_partials/product-countdown.tpl'}
{/function}

{function name="imagesBlock"}
  {include file='catalog/_partials/product-miniature-cover.tpl'}
{/function}

{function name="titleBlock"}
  {include file='catalog/_partials/product-miniature-title.tpl'}
{/function}

{function name="brandBlock"}
  {include file='catalog/_partials/product-miniature-brand.tpl'}
{/function}

{function name="priceBlock"}
  {include file='catalog/_partials/product-miniature-price.tpl' isHorizontal=$isHorizontal}
{/function}

{function name="descriptionBlock"}
  {include file='catalog/_partials/product-miniature-description.tpl'}
{/function}

{function name="flagsBlock"}
  {include file='catalog/_partials/product-flags.tpl'}
{/function}

{function name="reviewsBlock"}
  {include file='catalog/_partials/product-miniature-reviews.tpl'}
{/function}

{function name="variationsBlock"}
  {include file='catalog/_partials/product-miniature-variations.tpl'}
{/function}

{function name="quickViewButton"}
  {include file='catalog/_partials/product-miniature-quickview.tpl'}
{/function}

{function name="addToCartButton"}
  {include file='catalog/_partials/product-miniature-addtocart.tpl'}
{/function}

{function name="nativeLayout"}
  <div class="thumbnail product-thumbnail relative flex-container">
    {imagesBlock}

    {block name='product_buy'}
      <div class="product-actions show-on-hover scale-on-hover">
        {quickViewButton}
        {addToCartButton}
        {hook h='displayProductButton' product_id=$product.id}
      </div>
    {/block}

    {if $pkconf.pm_countdown && $isHorizontal != 10}
      {countdownBlock}
    {/if}
  </div>

  <div class="product-desc-wrap">
    <div class="product-description relative clearfix">
      {brandBlock}
      {titleBlock}
      {priceBlock}
      {descriptionBlock}
      {reviewsBlock}
      {variationsBlock}
    </div>
    {if $pkconf.pm_labels}
      {flagsBlock}
    {/if}
  </div>

  <div class="displayProductButtonFixed hide-empty">{strip}
    {hook h='displayProductButtonFixed' product_id=$product.id}
  {/strip}</div>
{/function}

{block name='product_miniature_item'}
<article class="{' '|implode:$miniatureClasses}" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}">
  <div class="thumbnail-container relative">
    {if $isCustomImage}
      {widget name='pkextproduct' id_product=$product.id_product url=$product.url}
    {else}
      {if $isNativeLayout}
        {nativeLayout}
      {else}
        <div class="thumbnail product-thumbnail relative flex-container">
          {hook h='displayMiniature' pkproduct=$product}
        </div>
      {/if}
    {/if}
  </div>
</article>
{/block}