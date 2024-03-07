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
{if !empty($product)}
<article class="mini-product" data-id-product="{$product.id_product}" data-id-product-attribute="{$product.id_product_attribute}" data-location="module-miniproduct.tpl">

  <div class="thumbnail-container relative">

    <div class="thumbnail product-thumbnail relative">

      {block name='product_thumbnail'}
      <a href="{$product.url}" class="relative">
        {include file='catalog/_partials/product-image.tpl' image=$product.default_image type=cart_default}
      </a>
      {/block}

    </div>

    <div class="product-description">

      {if isset($product.id_manufacturer)}
      {block name='product_manufacturer'}
        <h6 class="product-brand ptsans ellipsis">{Manufacturer::getNameById($product.id_manufacturer)}</h6>
      {/block}
      {/if}

      {block name='product_name'}
        <h3 class="product-title"><a href="{$product.url}">{$product.name}</a></h3>
      {/block}

      {if $product.show_price}
      {block name='product_price_and_shipping'}
        <div class="product-price-and-shipping">

          {if $product.has_discount}

            {hook h='displayProductPriceBlock' product=$product type="old_price"}
            <span class="regular-price">{$product.regular_price}</span>
            {if $product.discount_type === 'percentage'}
            <span class="discount-percentage">{$product.discount_percentage}</span>
            {/if}

          {/if}

          <span class="price">
            {$product.price}{if (isset($product.quantity) && $product.quantity > 0)}<span class="product-quantity"> ({$product.quantity}x)</span>{/if}
          </span>

        </div>
      {/block}
      {/if}
      
    </div>

  </div>

</article>
{/if}