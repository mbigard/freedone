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
.store-item th {width:60px}
.store-picture {margin-right:20px}{/literal}
{/block}

{block name='content'}
<section id="content" class="page-content page-stores">
  <h2 class="page-title">{l s='Our stores' d='Shop.Theme.Global'}</h2>

  {foreach $stores as $store}
    <article id="store-{$store.id}" class="store-item card m30">
      <div class="store-item-container flex-container flex-column">
        <div class="flex-container">
          <div class="store-picture" style="width:{$amp.global.images.stores.size.width}px">
            <amp-img src="{$store.image.bySize.stores_default.url}" layout="responsive" alt="{$store.image.legend}" title="{$store.image.legend}" width="{$amp.global.images.stores.size.width}" height="{$amp.global.images.stores.size.height}"></amp-img>
          </div>
          <div class="store-description m15">
            <h3 class="h3 card-title">{$store.name}</h3>
            <address>{$store.address.formatted nofilter}</address>
            {if $store.note || $store.phone || $store.fax || $store.email}
              <a data-toggle="collapse" href="#about-{$store.id}" aria-expanded="false" aria-controls="about-{$store.id}"><strong>{l s='About and Contact' d='Shop.Theme.Global'}</strong></a>
            {/if}
          </div>
        </div>
        <table>
          {foreach $store.business_hours as $day}
          {if !empty($day.hours.0)}
          <tr>
            <th class="text-left">{$day.day|truncate:4:'.'}</th>
            <td>
              <ul>
              {foreach $day.hours as $h}
                <li>{$h}</li>
              {/foreach}
              </ul>
            </td>
          </tr>
          {/if}
          {/foreach}
        </table>
      </div>
      <footer id="about-{$store.id}" class="collapse">
        <div class="store-item-footer divide-top">
          <div class="card-block">
            {if $store.note}
              <p class="text-justify">{$store.note}<p>
            {/if}
          </div>
          <ul class="card-block">
            {if $store.phone}
              <li><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#phone"></use></svg>&nbsp;{$store.phone}</li>
            {/if}
            {if $store.fax}
              <li><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#fax"></use></svg>&nbsp;{$store.fax}</li>
            {/if}
            {if $store.email}
              <li><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#email"></use></svg>&nbsp;{$store.email}</li>
            {/if}
          </ul>
        </div>
      </footer>
    </article>
  {/foreach}

</section>
{/block}