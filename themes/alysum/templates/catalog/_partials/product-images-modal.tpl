{**
 * 2007-2017 PrestaShop
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
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{function name="svgic" id=''}
<svg class="svgic svg-done">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

<div class="modal fade js-product-images-modal" id="product-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                {assign var=imagesCount value=$product.images|count}
                <figure>
                    {if isset($product.default_image.bySize.large_default)}
                    <img class="js-modal-product-cover product-cover-modal"
                        width="{$product.default_image.bySize.large_default.width}"
                        src="{$product.default_image.bySize.large_default.url}" alt="{$product.default_image.legend}"
                        title="{$product.default_image.legend}">
                    {/if}
                    <figcaption class="image-caption">
                        {block name='product_description_short'}
                            <div id="product-description-short">{$product.description_short nofilter}</div>
                        {/block}
                    </figcaption>
                </figure>
                <aside id="thumbnails" class="thumbnails js-thumbnails relative text-xs-center">
                    {block name='product_images'}
                        <div class="js-modal-mask js-vCarousel-popup mask{if $imagesCount <= 5} nomargin {/if}">
                            <ul class="product-images js-modal-product-images js-vCarousel-list">
                                {foreach from=$product.images item=image}
                                    <li class="thumb-container">
                                        <img data-image-large-src="{$image.large.url}" class="thumb js-modal-thumb smooth02"
                                            src="{$image.medium.url}" alt="{$image.legend}" title="{$image.legend}"
                                            width="{$image.medium.width}">
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                    {/block}
                    {if $imagesCount > 4}
                        <div class="scroll-box-arrows hidden">
                            <i class="up arrow-up js-modal-arrow-up">{svgic id='top-arrow-thin'}</i>
                            <i class="down">{svgic id='bottom-arrow-thin'}</i>
                        </div>
                    {/if}
                </aside>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->