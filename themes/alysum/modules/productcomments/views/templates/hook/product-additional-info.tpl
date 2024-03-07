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

{function name="svgic" id=''}
<svg class="svgic">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

{if $nb_comments != 0 || $post_allowed}
    <div class="product-comments-additional-info flex-container align-items-center">
        {if $nb_comments == 0}
            {if $post_allowed}
                <button class="btn btn-comment post-product-comment">
                    {svgic id='pencil'}
                    {l s='Write your review' d='Modules.Productcomments.Shop'}
                </button>
            {/if}
        {else}
            {include file='module:productcomments/views/templates/hook/average-grade-stars.tpl' grade=$average_grade}
            <div class="additional-links flex-container align-items-center">
                <a class="link-comment flex-container align-items-center text-with-icon" href="#product-comments-list-header">
                    {svgic id='email'}
                    <span>{l s='Read user reviews' d='Modules.Productcomments.Shop'} ({$nb_comments})</span>
                </a>
                {if $post_allowed}
                    <a class="link-comment flex-container align-items-center text-with-icon post-product-comment"
                        href="#product-comments-list-header">
                        {svgic id='pencil'}
                        <span>{l s='Write your review' d='Modules.Productcomments.Shop'}</span>
                    </a>
                {/if}
            </div>
        {/if}
    </div>
{/if}