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
{extends file='page.tpl'}

{if (isset($pktheme.cont_layout) && $pktheme.cont_layout != 0)}

    {block name='left_column'}{/block}
    {block name='right_column'}{/block}
    {block name='content_wrapper'}
    <div id="content-wrapper">
      {if ($pktheme.cont_layout == -1)}
        {hook h='displayContactPageBuilder'}
      {else}
        {hook h='CETemplate' id="{$pktheme.cont_layout}"}
      {/if}
    </div>
    {/block}
    
{else}

    {block name='page_header_container'}{/block}
    <div class="oh">
      {block name='displayBeforeContact'}
        {hook h='displayBeforeContact'}
      {/block}
    </div>

    {block name='page_content'}
      {widget name="contactform"}
    {/block}

    <div class="oh">
      {block name='displayAfterContact'}
        {hook h='displayAfterContact'}
      {/block}
    </div>

{/if}