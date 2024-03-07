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
{assign var='blockClasses' value=['images-container', 'flex-container']}
{assign var='isHorizontal' value=false}
{assign var='showThumbnails' value=true}

{if (isset(Configuration::get('pp_builder_thumbs')) && (Configuration::get('pp_builder_thumbs') != 1))}
    {assign var='showThumbnails' value=false}
{/if}

{if isset($show_thumbnails)}
    {if $show_thumbnails == 'yes'}
        {assign var='showThumbnails' value=true}
    {else}
        {assign var='showThumbnails' value=false}
    {/if}

    {if isset($thumbnails_axis)}
        {append var='blockClasses' value="thumb-{$thumbnails_axis}"}
        {if $thumbnails_axis == 'horizontal'}
            {assign var='isHorizontal' value=true}
        {/if}
    {/if}
{/if}

{if !$isHorizontal}
    {append var='blockClasses' value="thumb-vertical"}
{/if}

{function name="defaultImageBlock"}
    <div class="pkimg">
        <img src="{$urls.no_picture_image.bySize.home_default.url}" class="pkimg" width="300" height="300" />
    </div>
{/function}

{function name="sliderBlock"}
    <div class="glide relative pp-img-carousel" data-desktopnum="1" data-tabletnum="1" data-phonenum="1" data-loop="1"
        data-autoplay="0" data-navwrap="0">
        <div class="glide__track" data-glide-el="track">
            <div class="glide__slides slider-mode">
                {foreach from=$product.images item=image}
                    {assign var='imgUrl' value=$image.bySize.large_default.url}
                    <div class="thumb-container">
                        <img data-image-medium-src="{$imgUrl}" data-image-large-src="{$imgUrl}" src="{$imgUrl}"
                            alt="{$image.legend}" title="{$image.legend}">
                    </div>
                    {if isset($is_editor)}{break}{/if}
                {/foreach}
            </div>
        </div>
    </div>
{/function}

{function name="svgic" id='' class=''}
<svg class="svgic {$class}">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

{function name="verticalThumbsBlock"}
    {block name='product_images'}
        <div class="js-qv-mask js-vCarousel mask relative thumb-carousel scroll-box-arrows">
            <ul class="product-images js-qv-product-images js-vCarousel-list flex-container">
                {foreach from=$product.images item=image}
                    <li class="thumb-container">
                        <img class="thumb js-thumb smooth02{if $image.id_image == $product.default_image.id_image} selected{/if}"
                            data-image-medium-src="{$image.bySize.large_default.url}"
                            data-image-large-src="{$image.bySize.large_default.url}" src="{$image.bySize.home_default.url}"
                            alt="{$image.legend}" title="{$image.legend}" width="100">
                    </li>
                {/foreach}
            </ul>
            <i class="up">{svgic id='top-arrow-thin'}</i>
            <i class="down">{svgic id='bottom-arrow-thin'}</i>
        </div>
    {/block}
{/function}

{function name="horizontalThumbsBlock"}
    {assign var="wrapperClasses" value=''}
    {assign var="widgetClasses" value=''}
    {assign var="slider_options" value=''}
    {if isset($params.is_carousel) && $params.is_carousel}
        {assign var="wrapperClasses" value=' elementor-image-carousel-wrapper elementor-slick-slider'}
        {assign var="widgetClasses" value='pk-ce-carousel elementor-image-carousel'}
        {assign var="slider_options" value=" data-slider_options={$params.slick_options_string nofilter}"}
    {/if}
    <div class="pk-ce-widget-wrapper{$wrapperClasses}">
        <div class="pk-ce-widget view_grid {$widgetClasses}{if isset($params.mode_class)} {$params.mode_class}{/if}"
            {$slider_options} data-widget_type="pkproductthumbs.default">
            {foreach from=$product.images item=image}
                <div class="thumb-container">
                <img
                    class="thumb js-thumb db smooth02{if $image.id_image == $product.default_image.id_image} selected{/if}"
                    data-image-medium-src="{$image.bySize.large_default.url}"
                    data-image-large-src="{$image.bySize.large_default.url}"
                    src="{$image.bySize.home_default.url}"
                    alt="{$image.legend}"
                    title="{$image.legend}"
                    width="{if isset($image.bySize.large_default.width)}{$image.bySize.large_default.width}{else}500{/if}"
                    height="{if isset($image.bySize.large_default.height)}{$image.bySize.large_default.height}{else}500{/if}">
                </div>
            {/foreach}
        </div>
    </div>
{/function}

{function name="mainImageBlock"}
    {block name='product_cover'}
        {if $product.default_image}
            <div class="product-cover{if (count($product.images)) <= 1} thumbs-exist{/if}">
                <div class="prod-image-zoom smooth500" data-width="{$product.default_image.bySize.large_default.width/2}"
                    data-height="{$product.default_image.bySize.large_default.height/2}">
                    <img class="js-qv-product-cover db" src="{$product.default_image.bySize.large_default.url}"
                        alt="{$product.default_image.legend}" title="{$product.default_image.legend}">
                </div>
                {if (isset($pkconf.pp_innnerzoom) && $pkconf.pp_innnerzoom == false) || !isset($pkconf.pp_innnerzoom)}
                    <div class="layer smooth05 hidden-sm-down" data-toggle="modal" data-target="#product-modal">
                        {svgic id='search' class='svgic-search'}
                    </div>
                {/if}
                {if (isset($pkconf.pp_countdown) && $pkconf.pp_countdown == true) || !isset($pkconf.pp_countdown)}
                    {include file='catalog/_partials/product-countdown.tpl'}
                {/if}
            </div>
        {else}
            {defaultImageBlock}
        {/if}
    {/block}
{/function}

<div class="{' '|implode:$blockClasses}" id="product-images-cont">
    {if !$showThumbnails && !isset($isQuickView)}

        {if (count($product.images)) >= 1}
            {sliderBlock}
        {else}
            {defaultImageBlock}
        {/if}

    {else}

        {if (count($product.images)) > 1}
            {if $isHorizontal}
                {horizontalThumbsBlock}
            {else}
                {verticalThumbsBlock}
            {/if}
        {/if}

        {mainImageBlock}

    {/if}
</div>
{hook h='displayAfterProductThumbs'}