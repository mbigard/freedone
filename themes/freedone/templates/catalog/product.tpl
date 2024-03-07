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
{extends file=$layout}

{assign var="pkconf" value=unserialize(Configuration::get('PKTHEME_CONFIG')|html_entity_decode)}
{if !empty($product.description_short)}
  {assign var="ogdesc" value=$product.description_short|strip_tags:'UTF-8'|escape:'htmlall':'UTF-8'}
{elseif !empty($product.description)}
  {assign var="ogdesc" value=$product.description|strip_tags:'UTF-8'|escape:'htmlall':'UTF-8'}
{else}
  {assign var="ogdesc" value=$page.meta.description|escape:'htmlall':'UTF-8'}
{/if}

{block name='head_seo' append}
  {block name='head_open_graph'}
    <meta property="og:type" content="product">
    <meta property="og:description" content="{$ogdesc}">
    <meta property="og:image:alt" content="{$shop.name} - {$product.name}">
    <meta property="product:retailer_item_id" content="{$product.id}" />
    {if isset($product_manufacturer->name)}
      <meta property="product:brand" content="{$product_manufacturer->name}">
    {/if}
    {if isset($product.availability)}
      <meta property="product:availability" content="{if $product.availability == 'unavailable'}out of stock{else}{$product.availability}{/if}">
    {/if}
    {if $product.cover}
      <meta property="og:image" content="{$product.cover.large.url}">
    {/if}
    {if isset($post_image) && !empty($post_image)}
      <meta property="og:image" content="{$post_image|escape:'html':'UTF-8'}" />
    {/if}
    {if $product.show_price}
      <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
      <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
      <meta property="product:price:amount" content="{$product.price_amount}">
      <meta property="product:price:currency" content="{$currency.iso_code}">
    {/if}
    {if isset($product.weight) && ($product.weight != 0)}
      <meta property="product:weight:value" content="{$product.weight}">
      <meta property="product:weight:units" content="{$product.weight_unit}">
    {/if}
    {block name='head_canonical'}
      <link rel="canonical" href="{$product.canonical_url}">
    {/block}
  {/block}
{/block}

{block name='head_microdata_special'}
  {include file='_partials/microdata/product-jsonld.tpl'}
{/block}

{block name='content'}

<section id="main" data-id_product_attribute="{$product.id_product_attribute}" data-id_product="{$product.id_product}">

  {if (isset($pktheme.pp_builder_layout) && $pktheme.pp_builder_layout != 0)}

    {if ($pktheme.pp_builder_layout == -1)}
      {hook h='displayProductBuilder'}
    {else}
      {hook h='CETemplate' id="{$pktheme.pp_builder_layout}"}
    {/if}

  {else}

    <div class="row product-container product-page-col page-width{if (isset($pkconf.pp_updownbuttons) && ($pkconf.pp_updownbuttons == 0))} hide-updownbuttons{/if}">
      <div class="col-md-6">
        {block name='page_content_container'}
          <section class="page-content" id="content">
            {block name='page_content'}
              {include file='catalog/_partials/product-flags.tpl'}

              {block name='product_cover_tumbnails'}
                {include file='catalog/_partials/product-cover-thumbnails.tpl'}
              {/block}
            {/block}
          </section>
        {/block}
        </div>
        <div class="col-md-6 product-info-section">

          {block name='page_header_container'}
            {block name='page_header'}
              <h1 class="h1">{block name='page_title'}{$product.name}{/block}</h1>
            {/block}
          {/block}

          {if !empty($product_manufacturer->name)}
            <a class="product-brand" href="{$product_brand_url}">{$product_manufacturer->name}</a>
          {/if}

          {block name='system_info'}
          <div class="sys-info-section">
            {if !Configuration::get('PS_CATALOG_MODE') && Configuration::get('display_quantities')}
              <div class="sys-info flex-container">{l s='Quantity' d='Shop.Theme.Catalog'}: {$product.quantity}</div>
            {/if}
            {if isset($product.reference_to_display)}
                <div class="sys-info flex-container product-reference">{l s='RÉF' d='Shop.Theme.Catalog'} : <b>{$product.reference_to_display}</b>  </div>
            {/if}
            <span class="pipe">|</span>
            <div class="stock-infos">
            {block name='product_add_to_cart'}
              {include file='catalog/_partials/product-add-to-cart.tpl'}
            {/block}
          </div>
          </div>
          {/block}

          <div class="seller">
          {block name='product_additional_info'}
            {include file='catalog/_partials/product-additional-info.tpl'}
          {/block}
          </div>

          {block name='product_prices'}
            {include file='catalog/_partials/product-prices.tpl'}
          {/block}

            <div class="product-actions">
              {block name='product_buy'}
                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                  <input type="hidden" name="token" value="{if (isset($static_token))}{$static_token}{/if}">
                  <input type="hidden" name="id_product" value="{$product.id}" id="product_page_product_id">
                  <input type="hidden" name="id_customization" value="{$product.id_customization}" id="product_customization_id">

                  {block name='product_variants'}
                    {include file='catalog/_partials/product-variants.tpl'}
                  {/block}

                  {block name='product_pack'}
                    {if $packItems}
                      <section class="product-pack">
                        <h3 class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</h3>
                        {foreach from=$packItems item="product_pack"}
                          {block name='product_miniature'}
                            {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack}
                          {/block}
                        {/foreach}
                      </section>
                    {/if}
                  {/block}

                  {block name='product_discounts'}
                    {include file='catalog/_partials/product-discounts.tpl'}
                  {/block}

                  <div class="buyit">
                  {block name='product_add_to_cart'}
                    {include file='catalog/_partials/product-add-to-cart.tpl'}
                  {/block}
                  </div>

                  {block name='product_refresh'}{/block}
                </form>
              {/block}
            </div>

            <div class="product-information">
              {block name='product_description_short'}
                <div id="product-description-short-{$product.id}" class="short-desc">
                  {$product.description_short nofilter}
                </div>
              {/block}

              {if $product.is_customizable && count($product.customizations.fields)}
                {block name='product_customization'}
                  {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
                {/block}
              {/if}
            </div>

            <div class="productButtons flex-container align-items-center">
              {hook h='displayMoreButtons' product_id=$product.id}
              {hook h='displayProductActions' product=$product}
            </div>

            <div class="social">
              {block name='product_additional_info'}
              {include file='catalog/_partials/product-additional-info.tpl'}
            {/block}
            </div>

            {block name='hook_display_reassurance'}
              {hook h='displayReassurance'}
            {/block}


      </div>
    </div>

    {if (isset($pkconf.pp_product_tabs) && ($pkconf.pp_product_tabs == 1))}
    {block name='product_tabs'}
    <div class="tabs-container">
      <div class="tabs page-width">
        <ul class="nav nav-tabs flex-container" role="tablist">
          {if $product.description}
          <li class="nav-item">
            <a class="nav-link{if $product.description} active{/if}" data-toggle="tab" role="tab" aria-controls="description" href="#description"><h5>{l s='Description' d='Shop.Theme.Catalog'}</h5></a>
          </li>
          {/if}
          <li class="separateur">|</li>
          {if (isset($pkconf.pp_details_tab) && ($pkconf.pp_details_tab == 1))}
          <li class="nav-item">
            <a class="nav-link{if !$product.description} active{/if}" data-toggle="tab" role="tab" aria-controls="product-details" href="#product-details"><h5>{l s='Product Details' d='Shop.Theme.Catalog'}</h5></a>
          </li>
          {/if}
          {if $product.attachments}
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab" role="tab" aria-controls="attachments" href="#attachments"><h5>{l s='Attachments' d='Shop.Theme.Catalog'}</h5></a>
          </li>
          {/if}
          {foreach from=$product.extraContent item=extra key=extraKey}
          <li class="nav-item">
            <a class="nav-link" data-toggle="tab" role="tab" aria-controls="extra-{$extraKey}" href="#extra-{$extraKey}"><h5>{$extra.title}</h5></a>
          </li>
          {/foreach}
        </ul>

        <div class="tab-content" id="tab-content">

            <div class="tab-pane fade in{if $product.description || (isset($pkconf.pp_details_tab) && ($pkconf.pp_details_tab == 0))} active{/if}" id="description" role="tabpanel">
                {block name='product_description'}
                    <div class="product-description">{$product.description nofilter}</div>
                {/block}
            </div>

            {block name='product_details'}
                {include file='catalog/_partials/product-details.tpl'}
            {/block}

            {block name='product_attachments'}
                {if $product.attachments}
                <div class="tab-pane fade in" id="attachments">
                    <section class="product-attachments">
                        <h3 class="h5 text-uppercase">{l s='Download' d='Shop.Theme.Actions'}</h3>
                        {foreach from=$product.attachments item=attachment}
                        <div class="attachment">
                            <h4><a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">{$attachment.name}</a></h4>
                            <p>{$attachment.description}</p
                            <a href="{url entity='attachment' params=['id_attachment' => $attachment.id_attachment]}">
                            {l s='Download' d='Shop.Theme.Actions'} ({$attachment.file_size_formatted})
                            </a>
                        </div>
                        {/foreach}
                    </section>
                </div>
                {/if}
            {/block}

            {foreach from=$product.extraContent item=extra key=extraKey}
                <div class="tab-pane fade in {$extra.attr.class}" id="extra-{$extraKey}"{foreach $extra.attr as $key => $val}{if ($key != 'id') && ($key != 'class')} {$key}="{$val}"{/if}{/foreach}>
                    {$extra.content nofilter}
                </div>
            {/foreach}

        </div>
      </div>
    </div>
    {/block}
    {/if}

    {include file='catalog/_partials/product-footer.tpl'}

    {block name='page_footer_container'}
      <footer class="page-footer page-width">
        {block name='page_footer'}
          <!-- Footer content -->
        {/block}
      </footer>
    {/block}

  {/if}

  {block name='product_images_modal'}
    {include file='catalog/_partials/product-images-modal.tpl'}
  {/block}

</section>
{/block}
