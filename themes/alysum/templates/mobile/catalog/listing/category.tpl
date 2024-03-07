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

{if (isset($alt_urls) && ($alt_urls|count > 1))}
    {block name='head_hreflang'}
    {foreach from=$alt_urls item=pageUrl key=code}
    <link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
    {/foreach}
    {/block}
{/if}
{block name='head_styles' append}{/block}
{block name='head_scripts' append}{/block}
{block name='head_seo' append}
    <meta property="og:type" content="category">
    <meta property="og:site_name" content="{$shop.name}" />
    <meta property="og:title" content="{block name='head_seo_title'}{$amp.global.meta.meta_title}{/block}">
    <meta property="og:description" content="{block name='head_seo_description'}{$amp.global.meta.meta_description}{/block}">
    {if isset($categoryAmpLink)}<meta property="og:url" content="{$categoryAmpLink}">{/if}
    {if isset($category->image.medium.url)}<meta property="og:image" content="{$category->image.medium.url}">{/if}
    {assign var="numberOfItems" value="0"}
    {if isset($catProductsFull)}
    {assign var="numberOfItems" value="{$catProductsFull|count}"}
    {/if}
    <script type="application/ld+json">
    {
        "@context": "http://schema.org",
        "@type": "ItemList",
        "name": "{$category->name}",
        {if isset($category->image.medium.url)}"image": "{$category->image.medium.url}",{/if}
        "description": "{$category->description|strip_tags:false|escape:'htmlall':'UTF-8'}",
        {if isset($categoryAmpLink)}"url": "{$categoryAmpLink}",{/if}
        "itemListOrder": "http://schema.org/{if ($sortOrder.way == 'asc')}ItemListOrderAscending{else}ItemListOrderDescending{/if}",
        "numberOfItems": "{$numberOfItems}",
        {if isset($catProductsFull)}"itemListElement":
        [{foreach from=$catProductsFull key=position item=product name=productsList}
        {
        "@type": "ListItem",
        "position": {if ($sortOrder.way == 'asc')}{$position+1}{else}{$numberOfItems-($position)}{/if},
        "url": "{$product.amp_link}"
        }{if not $smarty.foreach.productsList.last},{/if}{/foreach}
    ]{/if}
    }
    </script>
{/block}
{block name='content'}
    {assign var="productListSource" value="{url entity='module' name={$amp.global.name} relative_protocol=false controller='ajaxFilter' params=['id_category' => $category->id, 'who' => 'category.tpl', cache => {$amp.global.cache.age}]}"}
    {assign var="cartURL" value="{url entity='module' name={$amp.global.name} controller='ajaxCart' relative_protocol=false params=['cart_id' => $amp.cart.cart_id]}"}
    {if (isset($amp.config.category.image) && ($amp.config.category.image == 1))}
    {if $category->id_image}
    <div id="category-image-amp" class="m20">
        <amp-img src="{url entity='categoryImage' id=$category->id_category name='category_default'}"
        width="{$amp.global.images.category.size.width}" height="{$amp.global.images.category.size.height}" layout="responsive" alt="{$category->name}"></amp-img>
        </amp-carousel>
    </div>
    {/if}
{/if}

{if ($category->name !== '')}
<h1 id="category-name-amp" class="roboto m20">
    {$category->name}
</h1>
{/if}

{if (isset($amp.config.category.description) && ($amp.config.category.description == 1) && ($category->description !== ''))}
<div class="category-description">
  <div class="category-description">
    <amp-accordion animate>
      <section>
        <h4 class="subcategory-heading m15">
          <div class="flex-container align-items-center">
          <span class="roboto flex-grow1">{l s='Description' d='Shop.Theme.Amp'}</span>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
          </div>
        </h4>
        <div class="subcategory-body">
          {$category->description nofilter}
        </div>
      </section>
    </amp-accordion>
  </div>
</div>
{/if}

{if (isset($amp.config.category.subcategories) && ($amp.config.category.subcategories == 1))}
{if isset($subcategories) && !empty($subcategories)}
  <div id="subcategories" class="m30">
    <amp-accordion animate>
      <section expanded>
        <h4 class="subcategory-heading m15">
          <div class="flex-container align-items-center">
          <span class="roboto flex-grow1">{l s='Subcategories' d='Shop.Theme.Amp'}</span>
          <svg class="svgic smooth"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#top-arrow-thin"></use></svg>
          </div>
        </h4>
        <div class="subcategory-body">
        <ul class="flex-container">
        {foreach from=$subcategories item=subcategory}
          <li>
            <div class="subcategory-image">
              <a href="{$subcategory.amp_url}" title="{$subcategory.name}" class="db">
                {if $subcategory.id_image}
                  <amp-img src="{$link->getCatImageLink($subcategory.link_rewrite, $subcategory.id_image, 'category_default')}" alt="{$subcategory.name}" layout="responsive" width="{$amp.global.images.category.size.width}" height="{$amp.global.images.category.size.height}"></amp-img>
                {else}
                  <amp-img src="{$img_cat_dir}{$lang_iso}-default-category_default.jpg" alt="{$subcategory.name}" layout="responsive" width="{$amp.global.images.category.size.width}" height="{$amp.global.images.category.size.height}"></amp-img>
                {/if}
              </a>
            </div>
            <h5><a class="subcategory-name" href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)}">{$subcategory.name|truncate:25:'...'}</a></h5>
            {if $subcategory.description}
              <div class="cat_desc">{$subcategory.description nofilter}</div>
            {/if}
          </li>
        {/foreach}
      </ul>
      </div>
    </section>
    </amp-accordion>
  </div>
{/if}
{/if}

{if (isset($amp.config.category.product.filter) && ($amp.config.category.product.filter == 1))}
    {include file='mobile/catalog/_partials/sort-orders.tpl'}
{/if}
{assign var="columns" value=""}
{if (isset($amp.config.category.product.columns))}
{assign var="columns" value=$amp.config.category.product.columns}
{/if}
<amp-list 
  id="productShownList" 
  class="product-listing {$columns}"
  src="{$amp.global.urls.productListSource}"  
  layout="fixed-height" 
  height="580" 
  binding="no" 
  load-more="{if (isset($amp.config.category.product.infinite) && ($amp.config.category.product.infinite == 1))}auto{else}manual{/if}"
  load-more-bookmark="nextPageUrl"
  [is-layout-container]="productsList.items" 
  [src]="productState.isFilter ? productsList.items : productState.nextPageUrl"
  [class]="(productState.hasMorePages == 1) ? 'product-listing {$columns} loadmore' : 'product-listing {$columns} notloadmore'"
  >
  {include file='mobile/catalog/_partials/miniatures/product-miniature.tpl'}
  {include file='mobile/catalog/_partials/load-more.tpl'}
</amp-list>

{include file='mobile/catalog/_partials/product-bottom.tpl'}
{/block}