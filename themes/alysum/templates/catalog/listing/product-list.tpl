{**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file=$layout}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-list-jsonld.tpl' listing=$listing}
{/block}

{block name='content'}
  <section id="main" class="container">

    {block name='product_list_header'}
      <h2 id="js-product-list-header" class="h2">{$listing.label}</h2>
    {/block}

    {hook h="displayHeaderCategory"}

    <div id="products" class="{if isset($pktheme.cp_listing_view) && $pktheme.cp_listing_view == 0}view_list{else}view_grid view_grid{$pktheme.cp_listing_view}{/if}">
      {if $listing.products|count}

        <div class="product_list_top">
          {block name='product_list_top'}
            {include file='catalog/_partials/products-top.tpl' listing=$listing}
          {/block}
        </div>

        <div class="product_list">
          {block name='product_list'}
            {include file='catalog/_partials/products.tpl' listing=$listing}
          {/block}
        </div>

        <div id="js-product-list-bottom">
          {block name='product_list_bottom'}
            {include file='catalog/_partials/products-bottom.tpl' listing=$listing}
          {/block}
        </div>

      {else}

        <div id="js-product-list-top"></div>

        <div id="js-product-list">
          {capture assign="errorContent"}
            <h4>{l s='No products available yet' d='Shop.Theme.Catalog'}</h4>
            <p>{l s='Stay tuned! More products will be shown here as they are added.' d='Shop.Theme.Catalog'}</p>
          {/capture}

          {include file='errors/no-products.tpl'}
        </div>

        <div id="js-product-list-bottom"></div>

      {/if}
    </div>

    {hook h="displayFooterCategory"}

  </section>
{/block}