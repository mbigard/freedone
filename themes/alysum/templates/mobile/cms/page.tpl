{*
* 2011-2021 Promokit
*
* @package   pkamp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2021 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{if (isset($alt_urls) && ($alt_urls|count > 1))}
{block name='head_hreflang'}
{foreach from=$alt_urls item=pageUrl key=code}
<link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
{/foreach}
{/block}
{/if}

{block name='content'}
<div class="page-cms">
  <h2 class="m15">{$cms_title}</h2>
  <div class="cms-page-content">
    {$cms nofilter}
  </div>
</div>
{/block}