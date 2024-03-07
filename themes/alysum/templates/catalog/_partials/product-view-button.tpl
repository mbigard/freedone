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

<a href="{$product.url}" class="btn smooth05" title="{l s='View Product' d='Shop.Theme.Actions'}"
    aria-label="{l s='View Product' d='Shop.Theme.Actions'}" role="button">
    {if (isset($addtocart_icon) && $addtocart_icon == 'yes') || !isset($addtocart_icon)}
        <svg class="svgic svgic-button-cart">
            <use href="{_THEME_IMG_DIR_}lib.svg#eye2"></use>
        </svg>
    {/if}
    {if (isset($addtocart_text) && $addtocart_text == 'yes')}
        <span>{l s='View Product' d='Shop.Theme.Actions'}</span>
    {/if}
</a>