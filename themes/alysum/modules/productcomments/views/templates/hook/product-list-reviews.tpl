{**
 * 2007-2019 PrestaShop and Contributors
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
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{assign var=stars_num value=5}
{assign var=stars_num2 value=$stars_num}
{assign var=stars_num_act value=$stars_num}
{assign var=rating_width value=(100/$stars_num)*$average_grade}
<div class="flex-container grade-stars-container rating-width-{$rating_width}">
    <div class="grade-stars-list small-stars">
        <div class="star-content star-empty">
            {while $stars_num_act-- > 0}
                <svg class="svgic svgic-star">
                    {if isset($urls)}<use href="{_THEME_IMG_DIR_}lib.svg#star"></use>{/if}
                </svg>
            {/while}
        </div>
        <div class="star-full oh" style="width:{$rating_width}%">
            <div class="star-content cut-stars">
                {while $stars_num-- > 0}
                    <svg class="svgic svgic-star">
                        {if isset($urls)}<use href="{_THEME_IMG_DIR_}lib.svg#star"></use>{/if}
                    </svg>
                {/while}
            </div>
        </div>
    </div>
    <div class="rating-numbers">
        (<span class="r-type-1">{$average_grade}/{$stars_num2}</span><span
            class="r-type-2 hidden">{$average_grade}</span>)
    </div>
</div>