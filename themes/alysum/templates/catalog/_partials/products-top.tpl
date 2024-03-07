{**
 * 2007-2022 PrestaShop
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
 * @copyright 2007-2022 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

<div id="js-product-list-top" class="products-selection flex-container flex-wrap">

    <button class="btn pk-filter-button hidden" data-trigger-name="filter-wrapper">
        {l s='Filter' d='Shop.Theme.Catalog'} <svg class="svgic">
            <use href="{_THEME_IMG_DIR_}lib.svg#filter"></use>
        </svg>
    </button>

    <div class="sort-by-row flex-container">
        {block name='sort_by'}
            {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
        {/block}
    </div>

    {hook h='displayProductListTop'}

</div>