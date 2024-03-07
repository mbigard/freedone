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

{function name="svgic" id='done'}
<svg class="svgic svg-done">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

<div id="search_filters" class="js-search-filters">

    {block name='facets_clearall_button'}
        <div id="_desktop_search_filters_clear_all" class="hidden-sm-down clear-all-wrapper">
            <button data-search-url="{$clear_all_link}" class="btn js-search-filters-clear-all">
                {svgic id='cross'} {l s='Clear all' d='Shop.Theme.Actions'}
            </button>
        </div>
    {/block}

    {foreach from=$facets item="facet"}
        {if $facet.displayed}
            <section class="facet">
                {assign var=_expand_id value=10|mt_rand:100000}
                {assign var=_collapse value=false}
                {if Configuration::get('cp_collapse_filter') == false}
                    {assign var=_collapse value=true}
                {else}

                {/if}
                {foreach from=$facet.filters item="filter"}
                    {if $filter.active}{assign var=_collapse value=false}{/if}
                {/foreach}
                <!--ALYSUM-->
                <h4 class="module-title facet-title">
                    <span class="title-text">{$facet.label}</span>
                    <span class="title{if $_collapse} collapsed{/if}" data-target="#facet_{$_expand_id}" data-toggle="collapse"
                        {if !$_collapse} aria-expanded="true" {/if} role="button">
                        <span class="navbar-toggler collapse-icons">
                            <svg class="svgic svgic-updown">
                                <path
                                    d="M8 2.194c0 .17-.062.34-.183.47L4.44 6.275c-.117.126-.275.197-.44.197-.165 0-.323-.07-.44-.194L.184 2.666c-.242-.26-.243-.68 0-.94.243-.26.637-.26.88 0L4 4.866l2.937-3.14c.243-.26.638-.26.88 0 .12.128.183.298.183.468z" />
                                <path
                                    d="M7.958,5.554c0-0.223-0.084-0.443-0.253-0.612L4.603,1.835 c-0.334-0.334-0.873-0.334-1.206,0L0.295,4.941c-0.335,0.335-0.337,0.882-0.004,1.22C0.624,6.499,1.166,6.501,1.5,6.165L4,3.663 l2.5,2.502c0.336,0.336,0.877,0.334,1.21-0.004C7.876,5.993,7.958,5.772,7.958,5.554z" />
                            </svg>
                        </span>
                    </span>
                </h4>
                <!--/ALYSUM-->
                {if $facet.widgetType !== 'dropdown'}
                    {block name='facet_item_other'}
                        <ul id="facet_{$_expand_id}" class="collapse{if !$_collapse} in{/if}">
                            {foreach from=$facet.filters item="filter"}
                                {if $filter.displayed}
                                    <li>
                                        <label class="facet-label{if $filter.active} active{/if}">
                                            {if $facet.multipleSelectionAllowed}
                                                <span class="custom-checkbox">
                                                    <input data-search-url="{$filter.nextEncodedFacetsURL}" type="checkbox" {if $filter.active}
                                                        checked{/if}>
                                                    {if isset($filter.properties.color)}
                                                        <span class="color" style="background-color:{$filter.properties.color}">
                                                            {svgic}
                                                        </span>
                                                    {elseif isset($filter.properties.texture)}
                                                        <span class="color texture" style="background-image:url({$filter.properties.texture})">
                                                            {svgic}
                                                        </span>
                                                    {else}
                                                        <span{if !$js_enabled} class="ps-shown-by-js" {/if}>
                                                            {svgic}
                                                        </span>
                                                    {/if}
                                                </span>
                                            {else}
                                                <span class="custom-checkbox">
                                                    <input data-search-url="{$filter.nextEncodedFacetsURL}" type="radio"
                                                        name="filter {$facet.label}" {if $filter.active} checked{/if}>
                                                    <span{if !$js_enabled} class="ps-shown-by-js" {/if}>
                                                </span>
                                                </span>
                                            {/if}

                                            <a href="{$filter.nextEncodedFacetsURL}" class="_gray-darker search-link js-search-link"
                                                rel="nofollow">
                                                {$filter.label}
                                                {if $filter.magnitude}
                                                    <span class="magnitude">({$filter.magnitude})</span>
                                                {/if}
                                            </a>
                                            <!--ALYSUM-->
                                            {if $facet.multipleSelectionAllowed}
                                                {if isset($filter.properties.color)}
                                                    <span class="color-tooltip" style="background-color:{$filter.properties.color}"></span>
                                                {elseif isset($filter.properties.texture)}
                                                    <span class="color-tooltip" style="background-image:url({$filter.properties.texture})"></span>
                                                {/if}
                                            {/if}
                                            <!--/ALYSUM-->
                                        </label>
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>
                    {/block}
                {else}
                    {block name='facet_item_dropdown'}
                        <ul id="facet_{$_expand_id}" class="collapse{if !$_collapse} in{/if}">
                            <li>
                                <div class="col-sm-12 col-xs-12 col-md-12 facet-dropdown dropdown">
                                    <a href="#" class="select-title" rel="nofollow" data-toggle="dropdown" aria-haspopup="true"
                                        aria-expanded="false">
                                        {$active_found = false}
                                        <span>
                                            {foreach from=$facet.filters item="filter"}
                                                {if $filter.active}
                                                    {$filter.label}
                                                    {if $filter.magnitude}
                                                        ({$filter.magnitude})
                                                    {/if}
                                                    {$active_found = true}
                                                {/if}
                                            {/foreach}
                                            {if !$active_found}
                                                {l s='(no filter)' d='Shop.Theme.Global'}
                                            {/if}
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        {foreach from=$facet.filters item="filter"}
                                            {if !$filter.active}
                                                <a rel="nofollow" href="{$filter.nextEncodedFacetsURL}" class="select-list">
                                                    {$filter.label}
                                                    {if $filter.magnitude}
                                                        ({$filter.magnitude})
                                                    {/if}
                                                </a>
                                            {/if}
                                        {/foreach}
                                    </div>
                                </div>
                            </li>
                        </ul>
                    {/block}
                {/if}
            </section>
        {/if}
    {/foreach}
</div>