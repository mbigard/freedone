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

{include file='_partials/helpers.tpl' scope=parent}

<!doctype html>
<html lang="{$language.locale}">

<head>
    {block name='head'}
        {include file='_partials/head.tpl'}
    {/block}
</head>

<body id="{$page.page_name}" class="{$page.body_classes|classnames}">

    {block name='hook_after_body_opening_tag'}
        {hook h='displayAfterBodyOpeningTag'}
    {/block}

    {block name='header'}
        {call HeaderBlock}
    {/block}

    {block name='main'}
        {call MainContentBlock}
    {/block}

    {block name='footer'}
        {call FooterBlock}
    {/block}

    {block name='hook_before_body_closing_tag'}
        {if !$preview_id}
            {hook h='displayBeforeBodyClosingTag'}
        {/if}
    {/block}

    {block name='javascript_bottom'}
        {include file="_partials/password-policy-template.tpl"}
        {include file='_partials/javascript.tpl' javascript=$javascript.bottom}
    {/block}
    
    {* {include file='_partials/svg.tpl'} theme's SVG library. LEGACY *}
</body>

</html>