{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.3
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{assign var="cdn" value="https://cdn.ampproject.org/v0"}
{assign var="page" value=$page.page_name|replace:'module-pkamp-':''}
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width,minimum-scale=1,initial-scale=1">
	<title>{block name='head_seo_title'}{$amp.global.meta.meta_title}{/block}</title>
	{block name='head_seo'}
		<link rel="canonical" href="{$canonical}">
		{block name='head_icons'}
		<link rel="icon" type="image/vnd.microsoft.icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
		<link rel="shortcut icon" type="image/x-icon" href="{$shop.favicon}?{$shop.favicon_update_time}">
		{/block}
		<link rel="preconnect dns-prefetch" href="https://fonts.gstatic.com/" crossorigin>
		<link rel="preload" as="script" href="{$cdn}.js">
		<link rel="preload" as="script" href="{$cdn}/amp-form-0.1.js">
		<link rel="preload" as="script" href="{$cdn}/amp-list-0.1.js">
		<link rel="preload" as="script" href="{$cdn}/amp-bind-0.1.js">
		<link rel="preload" as="script" href="{$cdn}/amp-sidebar-0.1.js">
		<link rel="preload" as="script" href="{$cdn}/amp-carousel-0.2.js">
		<link rel="preload" as="script" href="{$cdn}/amp-selector-0.1.js">
		<link rel="preload" as="script" href="{$cdn}/amp-lightbox-0.1.js">
		<link rel="preload" as="image" href="{$shop.logo}">
		{if $shop.email == 'marek.mnishek@gmail.com'} {* demo image preload *}
		<link rel="preload" as="image" href="{$urls.base_url}modules/pkamp/views/img/amp_banner_06.webp">
		{/if}
		{block name='head_hreflang'}
		{if (isset($urls.alternative_langs) && ($urls.alternative_langs|count > 1))}
		{foreach from=$urls.alternative_langs item=pageUrl key=code}
		{if $language.language_code != $code}
		<link rel="alternate" href="{$pageUrl}" hreflang="{$code}">
		{/if}
		{/foreach}
		{/if}
		{/block}
		<meta name="description" content="{block name='head_seo_description'}{$amp.global.meta.meta_description}{/block}">
		<meta name="keywords" content="{block name='head_seo_keywords'}{$amp.global.meta.meta_keywords}{/block}">
		<meta name="application-name" content="Prestashop AMP v.{$amp.global.meta.version}" />
		{if (isset($amp.config.general.noindex) && $amp.config.general.noindex == 1)}
		<meta name="robots" content="noindex">
		{/if}
	{/block}
	{block name='head_scripts'}
		<script async src="{$cdn}.js"></script>
		{if ($page != 'checkout') && ($page != 'order')}
		<script async custom-element="amp-form" src="{$cdn}/amp-form-0.1.js"></script>{/if}
		<script async custom-element="amp-list" src="{$cdn}/amp-list-0.1.js"></script>
		<script async custom-element="amp-bind" src="{$cdn}/amp-bind-0.1.js"></script>
		{if ($page != 'home')}
		<script async custom-element="amp-youtube" src="{$cdn}/amp-youtube-0.1.js"></script>
		{/if}
		<script async custom-element="amp-sidebar" src="{$cdn}/amp-sidebar-0.1.js"></script>
		<script async custom-element="amp-carousel" src="{$cdn}/amp-carousel-0.2.js"></script>
		<script async custom-element="amp-selector" src="{$cdn}/amp-selector-0.1.js"></script>
		<script async custom-element="amp-lightbox" src="{$cdn}/amp-lightbox-0.1.js"></script>
		<script async custom-element="amp-accordion" src="{$cdn}/amp-accordion-0.1.js"></script>
		<script async custom-element="amp-bodymovin-animation" src="{$cdn}/amp-bodymovin-animation-0.1.js"></script>
		{if isset($amp.config.general.cookies) && $amp.config.general.cookies == 1}
		<script async custom-element="amp-user-notification" src="{$cdn}/amp-user-notification-0.1.js"></script>
		{/if}
		{if 
			(isset($amp.config.general.googleanalytics.state) && $amp.config.general.googleanalytics.state == 1) ||
			(isset($amp.config.general.googleadwords.state) && $amp.config.general.googleadwords.state == 1) ||
			(isset($amp.config.general.googletagmanager.state) && $amp.config.general.googletagmanager.state == 1) ||
			(isset($amp.config.general.fbpixel.state) && $amp.config.general.fbpixel.state == 1)
		}
		{if (isset($amp.config.general.cookies) && $amp.config.general.cookies == 1)}
		<script async custom-element="amp-analytics" src="{$cdn}/amp-analytics-0.1.js"></script>
		{/if}
		{/if}
		<script async custom-template="amp-mustache" src="{$cdn}/amp-mustache-0.2.js"></script>
	{/block}
	<style amp-custom>{block name='head_styles'}{$css nofilter}{/block}</style>
	<style amp-boilerplate>{literal}body{-webkit-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-moz-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-ms-animation:-amp-start 8s steps(1,end) 0s 1 normal both;animation:-amp-start 8s steps(1,end) 0s 1 normal both}@-webkit-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-moz-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-ms-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-o-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}{/literal}</style>
	<noscript><style amp-boilerplate>{literal}body{-webkit-animation:none;-moz-animation:none;-ms-animation:none;animation:none}{/literal}</style></noscript>
	{block name='stylesheets'}{/block}
</head>