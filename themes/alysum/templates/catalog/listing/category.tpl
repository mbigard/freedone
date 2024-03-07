{**
 * 2007-2019 PrestaShop
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
 
{extends file='catalog/listing/product-list.tpl'}

{block name='product_list_header'}
<div class="block-category relative">
    {if (isset($pktheme.cp_category_preview) && $pktheme.cp_category_preview == 1)}
    {if file_exists("{$pktheme.cat_img_path}{$category.id}.jpg")}
    <img src="{$category.image.large.url}" width="1110" height="500" alt="{$category.name}" loading="lazy" class="db w-100">
    {/if}
    {/if}
    {if (isset($pktheme.cp_category_description) && $pktheme.cp_category_description)}
    <div class='category-desc-wrap{if file_exists("{$pktheme.cat_img_path}{$category.id}.jpg")} img_exist{else} no_img{/if}'>
    <h1 class="h1">{$category.name}</h1>
        {if $category.description}
            <div id="category-description">{$category.description nofilter}</div>
        {/if}
    </div>
    {else}
    <h1 class="hidden">{$category.name}</h1>
    {/if}
    <div class="show-in-elementor-editor hidden">{$category.description nofilter}</div>
</div>

{if (isset($pktheme.cp_subcategories) && $pktheme.cp_subcategories)}
    {if isset($subcategories) && !empty($subcategories)}
        <div id="subcategories">
            <h3 class="subcategory-heading">{l s='Subcategories' d='Shop.Theme.Catalog'}</h3>
            <ul class="flex-container">
                {foreach from=$subcategories item=subcategory}
                    <li>
                        <div class="subcategory-image">
                            <a href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)}" title="{$subcategory.name}" class="img">
                                {if $subcategory.id_image}
                                    {*<img class="replace-2x" src="{$link->getCatImageLink($subcategory.link_rewrite, $subcategory.id_image, 'category_default')}" alt="{$subcategory.name}"/>*}
                                    <img class="replace-2x" src="{$urls.img_cat_url}{$subcategory.id_category}_thumb.jpg" alt="{$subcategory.name}" width="320" height="190" loading="lazy">
                                {else}
                                    <img class="replace-2x" src="{$urls.img_cat_url}{$lang_iso}-default-category_default.jpg" alt="{$subcategory.name}" loading="lazy">
                                {/if}
                            </a>
                        </div>
                        <h5>
                            <a class="subcategory-name ellipsis" href="{$link->getCategoryLink($subcategory.id_category, $subcategory.link_rewrite)}">{$subcategory.name}</a>
                        </h5>
                    </li>
                {/foreach}
            </ul>
        </div>
    {/if}
{/if}
{/block}