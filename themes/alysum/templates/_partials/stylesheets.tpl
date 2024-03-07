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

{if isset($pktheme) && ($pktheme.used_fonts != false)}
<link rel="preconnect" href="https://fonts.gstatic.com"> 
<link rel="preload" href="https://fonts.googleapis.com/css?family={$pktheme.used_fonts}" as="style">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family={$pktheme.used_fonts}">
{/if}
{* <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"> *}
{foreach $stylesheets.external as $stylesheet}
<link rel="stylesheet" href="{$stylesheet.uri}" type="text/css" media="{$stylesheet.media}">
{/foreach}
{foreach $stylesheets.inline as $stylesheet}
<style>{$stylesheet.content}</style>
{/foreach}