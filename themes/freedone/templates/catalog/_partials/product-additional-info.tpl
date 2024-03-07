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

{function name="shareitem" item=''}
    {if $item != ''}
        {assign var="itemVar" value="sharing_$item"}
        {if (isset($pktheme.$itemVar) && $pktheme.$itemVar)}
            <li class="dib sc-{$item}">
                <div class="sharer-button flex-container align-items-center justify-content-center" data-sharer="{$item}"
                    data-title="{if isset($product)}{$product.name}{/if}{if isset($post->title)}{$post->title}{/if}"
                    data-url="{$urls.current_url}" role="button" title="{l s='Share via' d='Shop.Theme.Global'} {$item}">
                    <svg class="svgic svg-done">
                        <use href="{_THEME_IMG_DIR_}lib.svg#{$item}"></use>
                    </svg>
                </div>
            </li>
        {/if}
    {/if}
{/function}

{function name="displayitems" item=''}
    <div class="social-sharing flex-container align-items-center">
        <ul>
            {shareitem item='facebook'}
            {shareitem item='twitter'}
            {shareitem item='pinterest'}
            {shareitem item='email'}
            {shareitem item='whatsapp'}
            {shareitem item='telegram'}
            {shareitem item='tumblr'}
            {shareitem item='linkedin'}
            {shareitem item='reddit'}
        </ul>
    </div>
{/function}

{if isset($justlist)}
    {displayitems}
{else}
    <div class="productButtons product-additional-info flex-container align-items-center flex-column">

        {if isset($product)}
            {hook h='displayProductAdditionalInfo' product=$product}
        {/if}

        {if (isset($pktheme.pp_share) && $pktheme.pp_share)}
            {displayitems}
        {/if}

    </div>
{/if}
