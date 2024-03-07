{**
  * 2007-2019 PrestaShop.
  *
  * NOTICE OF LICENSE
  *
  * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
  * that is bundled with this package in the file LICENSE.txt.
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
  * needs please refer to http://www.prestashop.com for more information.
  *
  * @author    PrestaShop SA <contact@prestashop.com>
  * @copyright 2007-2019 PrestaShop SA
  * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
  * International Registered Trademark & Property of PrestaShop SA
  *}

{function name="svgic" id='cross'}
<svg class="svgic">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

<section id="js-active-search-filters" class="{if $activeFilters|count}active_filters{else}hide{/if}">
    {block name='active_filters_title'}
        <h2 class="h6 active-filter-title">{l s='Active filters' d='Shop.Theme.Global'}</h2>
    {/block}

    {if $activeFilters|count}
        <ul>
            {foreach from=$activeFilters item="filter"}
                {block name='active_filters_item'}
                    <li class="filter-block">
                        {l s='%1$s:' d='Shop.Theme.Catalog' sprintf=[$filter.facetLabel]}
                        {$filter.label}
                        <a class="js-search-link" href="{$filter.nextEncodedFacetsURL}">
                            {svgic}
                        </a>
                    </li>
                {/block}
            {/foreach}
            <li class="filter-block">
                {block name='facets_clearall_button'}
                    <div id="_desktop_search_filters_clear_all" class="hidden-sm-down clear-all-wrapper">
                        <button data-search-url="{$clear_all_link}" class="btn btn-tertiary js-search-filters-clear-all">
                            {svgic} {l s='Clear all' d='Shop.Theme.Actions'}
                        </button>
                    </div>
                {/block}
            </li>
        </ul>
    {/if}
</section>