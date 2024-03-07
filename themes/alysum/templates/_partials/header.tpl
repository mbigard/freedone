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

{assign var='showMobile' value={isset($pktheme.header_builder_mobile) && ($pktheme.header_builder_mobile != 0)}}
{assign var='isMobile' value={Context::getContext()->isTablet() || Context::getContext()->isMobile()}}

{function name="headerMain"}
{if ($showMobile && !$isMobile) || !$showMobile}
    {if $pktheme.header_builder == 1}
        {hook h="displayHeaderBuilder"}
    {else}
        {hook h="CETemplate" id="{$pktheme.header_builder}"}
    {/if}
{/if}
{/function}

{function name="headerTop"}
    {if $showMobile}
    <template id="mobile-header-template">
        {if !$isMobile}
            {hook h="CETemplate" id="{$pktheme.header_builder_mobile}"}
        {/if}
    </template>
    <div class="mobile-header-wrapper">
        {if $isMobile}
            {hook h="CETemplate" id="{$pktheme.header_builder_mobile}"}
        {/if}
    </div>
    <div class="desktop-header-wrapper">
    {/if}
{/function}

{function name="headerBottom"}
    {if $showMobile}</div>{/if}
{/function}

<header id="header">
    {headerTop}{headerMain}{headerBottom}
</header>
