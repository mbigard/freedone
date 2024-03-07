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
.suppliers-list ul {
  flex-wrap:wrap
}
.suppliers-list li {
  width:50%;
  margin:0 0 30px 0
}
.suppliers-list li > div {
  text-align:center
}
.supplier-img {
  max-width:100%;
  height:auto;
  filter:brightness(.96)
}
{/literal}
{/block}

{block name='content'}
<section id="main" class="suppliers-list">

  <h2 class="roboto m20">{l s='Suppliers' d='Shop.Theme.Catalog'}</h2>

  <ul class="flex-container">
    {foreach from=$suppliers item=supplier}
      <li class="supplier">
        <div class="supplier-img">
          <a href="{$supplier.url}">
            <amp-img class="supplier-img" src="{$supplier.image}" width="{$amp.global.images.medium.size.width}" height="{$amp.global.images.medium.size.height}" alt="{$supplier.name}" layout="responsive"></amp-img>
          </a>
        </div>
        <div class="supplier-infos">
          <h3><a href="{$supplier.url}">{$supplier.name}</a></h3>
        </div>
        <div class="supplier-products">
          <a href="{$supplier.url}">{$supplier.nb_products}</a>
        </div>
      </li>
    {/foreach}
  </ul>

</section>
{/block}