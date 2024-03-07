{*
* 2011-2021 Promokit
*
* @package   pkamp
* @version   2.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2021 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='head_styles' append}{literal}
.sitemap ul {margin-left:10px}
.sitemap ul li a {display:block;margin-bottom:7px}
.sitemap ul > ul {margin-top:7px}{/literal}
{/block}

{block name='content'}
<section>
  <h2 class="page-title">{l s='Sitemap' d='Shop.Theme.Global'}</h2>
  <div class="sitemap">
      <div class="m30">
        <h3 class="m15">{$our_offers}</h3>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.offers}
      </div>
      <div class="m30">
        <h3 class="m15">{$categories}</h3>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.categories}
      </div>
      <div class="m30">
        <h3 class="m15">{$pages}</h3>
        {include file='cms/_partials/sitemap-nested-list.tpl' links=$links.pages}
      </div>
  </div>
</section>
{/block}