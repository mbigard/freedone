{*
* 2007-2020 PrestaShop
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
*  @copyright  2007-2020 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{if !isset($suffix)}
    {assign var='suffix' value=''}
{/if}

{if (isset($pktheme.gs_popup_search) && $pktheme.gs_popup_search) && $suffix == ''}
    <a href="#" class="pk-item-content relative flex-container align-items-center searchToggler cp icon-element">
        <svg class="svgic svgic-search" {if isset($pkhiconfig.sett_iconsize) && $pkhiconfig.sett_iconsize != ''}
            style="width:{$pkhiconfig.sett_iconsize}px;height:{$pkhiconfig.sett_iconsize}px" {/if}>
            <use href="{_THEME_IMG_DIR_}lib.svg#search"></use>
        </svg>
        <span class="pkhi-item-title">{l s='Search' d='Modules.Searchbar.Shop'}</span>
    </a>
{/if}
<div id="search_widget{$suffix}" data-search-controller-url="{$search_controller_url}"
    class="{if (isset($pktheme.gs_popup_search) && $pktheme.gs_popup_search) && $suffix == ''}hidden popup_search{/if}"
    data-null="{l s='No products found' d='Modules.Searchbar.Shop'}"
    data-less="{l s='Type at least 3 characters' d='Modules.Searchbar.Shop'}">
    <form method="get" action="{$search_controller_url}" class="flex-container relative">
        <input type="hidden" name="controller" value="search">
        <input type="text" name="s" id="sisearch{$suffix}" value="{$search_string}"
            placeholder="{l s='Search' d='Modules.Searchbar.Shop'}...">
        <label for="sisearch" aria-label="{l s='Search' d='Modules.Searchbar.Shop'}">
            <svg class="svgic svgic-search">
                <use href="{_THEME_IMG_DIR_}lib.svg#search"></use>
            </svg>
        </label>
        <button type="submit">
            {l s='Search' d='Modules.Searchbar.Shop'}
        </button>
    </form>
</div>