{**
 * 2007-2020 PrestaShop and Contributors
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
 * @copyright 2007-2020 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{function name="svgic" id=''}
<svg class="svgic">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

<div class="product-comment-list-item flex-container" data-product-comment-id="@COMMENT_ID@"
    data-product-id="@PRODUCT_ID@">
    <div class="comment-infos flex-container flex-grow1">
        <div class="pk-avatar flex-container">
            {svgic id='avatar'}
        </div>
        <div class="flex-grow1">
            <div class="grade-stars pk-loader"></div>
            <h4>@COMMENT_TITLE@</h4>
            <p class="comment-text">@COMMENT_COMMENT@</p>
            <div class="addition-info flex-container">
                <div class="comment-date">
                    @COMMENT_DATE@
                </div>
                <div class="comment-author">
                    {l s='By %1$s' sprintf=['@CUSTOMER_NAME@'] d='Modules.Productcomments.Shop'}
                </div>
            </div>
        </div>
    </div>
    <div class="comment-buttons flex-container align-items-center">
        {if $usefulness_enabled}
            <a class="pkc-btn useful-review flex-container align-items-center">
                {svgic id='like2'}
                <span class="useful-review-value">@COMMENT_USEFUL_ADVICES@</span>
            </a>
            <a class="pkc-btn not-useful-review flex-container align-items-center">
                {svgic id='like2'}
                <span class="not-useful-review-value">@COMMENT_NOT_USEFUL_ADVICES@</span>
            </a>
        {/if}
        <a class="pkc-btn report-abuse flex-container align-items-center" title="{l s='Report abuse' d='Modules.Productcomments.Shop'}">
            {svgic id='pk-flag2'}
        </a>
    </div>
</div>