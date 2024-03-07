{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{if ($categories.children|count > 0)}
    <section class="ps_categorytree relative">
        <h4 class="module-title">
            <span>{l s='Categories' d='Modules.Categorytree.Shop'}</span>
            <svg class="svgic">
                <use href="{_THEME_IMG_DIR_}lib.svg#burger"></use>
            </svg>
        </h4>
        <div class="module-body">
            {function name="categories" nodes=[] depth=0}
                {strip}
                    {if $nodes|count}
                        <ul>
                            {foreach from=$nodes item=node}
                                <li class="smooth02{if $node.children} children-true{/if}">
                                    <span class="ps-li-container flex-container">
                                        <a href="{$node.link}">{$node.name}</a>
                                        {if $node.children}
                                            <span class="catmenu-trigger flex-container cat_menu_thumb">
                                                <span>
                                                    <svg class="svgic">
                                                        <use href="{_THEME_IMG_DIR_}lib.svg#add"></use>
                                                    </svg>
                                                </span>
                                            </span>
                                        {else}
                                            {if isset($pktheme)}
                                                {if file_exists("{$pktheme.cat_img_path}{$node.id}-0_thumb.jpg")}
                                                    <img class="cat_menu_thumb" src="{$urls.img_cat_url}{$node.id}-0_thumb.jpg" width="15" height="15"
                                                        loading="lazy" alt="{$node.name}" />
                                                {/if}
                                            {/if}
                                        {/if}
                                    </span>
                                    {if $node.children}
                                        <div>{categories nodes=$node.children depth=$depth+1}</div>
                                    {/if}
                                </li>
                            {/foreach}
                        </ul>
                    {/if}
                {/strip}
            {/function}
            <div class="category-tree">
                <ul>
                    <li class="hidden"><a href="{$categories.link nofilter}">{$categories.name}</a></li>
                    <li class="root_li relative">{categories nodes=$categories.children}</li>
                </ul>
            </div>
        </div>
    </section>
{/if}