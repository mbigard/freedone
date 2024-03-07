{**
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='head_styles' append}
{literal}
.brands-list ul {
  flex-wrap:wrap
}
.brands-list li {
  width:50%;
  margin:0 0 30px 0
}
.brands-list li > div {
  text-align:center
}
.brand-img {
max-width:100%;
height:auto;
}
{/literal}
{/block}

{block name='head_scripts' append}
<script type="application/ld+json">
{literal}
{
  "@context": "https://schema.org",
  "@type": "Brand",
  "@name": "{/literal}name{literal}",
  "@description": "{/literal}desc{literal}"
}
{/literal}
</script>
{/block}

{block name='content'}
<section id="main" class="brands-list">

  <h2 class="roboto m20">{l s='Brands' d='Shop.Theme.Catalog'}</h2>

  <ul class="flex-container">
    {foreach from=$brands item=brand}
      <li class="brand">
        <div class="brand-img">
          <a href="{$brand.url}">
            <amp-img class="brand-img" src="{$brand.image}" width="{if isset($amp.global.images.brand.size.width)}{$amp.global.images.brand.size.width}{else}300{/if}" height="{if isset($amp.global.images.brand.size.height)}{$amp.global.images.brand.size.height}{else}200{/if}" alt="{$brand.name}" layout="responsive"></amp-img>
          </a>
        </div>
        <div class="brand-infos">
          <h3><a href="{$brand.url}">{$brand.name}</a></h3>
        </div>
        <div class="brand-products">
          <a href="{$brand.url}">{$brand.nb_products}</a>
        </div>
      </li>
    {/foreach}
  </ul>

</section>
{/block}