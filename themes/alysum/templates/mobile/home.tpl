{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}
 
{extends file='mobile/layouts/layout-main.tpl'}
{block name='head_scripts' append}
<script type="application/ld+json">
{literal}
{
    "@context": "https://schema.org/",
    "@type": "Attorney",
    "name": "{/literal}{$shop.name}{literal}",
    "logo": "{/literal}{$urls.base_url}{$shop.logo}{literal}",
    "image": {
      "@type": "ImageObject",
      "url": "{/literal}{$urls.base_url}{$shop.logo}{literal}",
      "height": {/literal}{$amp.header.logo.height}{literal},
      "width": {/literal}{$amp.header.logo.width}{literal}
    },
    "url": "{/literal}{$urls.base_url}{literal}",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "{/literal}{$shop.address.city}{literal}",
      "addressRegion": "{/literal}{$shop.address.state}{literal}",
      "postalCode": "{/literal}{$shop.address.postcode}{literal}",
      "streetAddress": "{/literal}{$shop.address.address1}&nbsp;{$shop.address.address2}{literal}"
    },
    "priceRange": "{/literal}1-999{literal}",
    "telephone": "{/literal}{$shop.phone}{literal}",
    "email": "{/literal}{$shop.email}{literal}"
}
{/literal}
</script>
{/block}
{block name='content'}

  {hook h='displayAmpContent'}

  {include file='mobile/_partials/popup.tpl'}

{/block}