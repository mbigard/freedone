{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{extends file='page.tpl'}

{block name='page_title'}
    <span class="stores-title db container">{l s='Our stores' d='Shop.Theme.Global'}</span>
{/block}

{function name="svgic" id='' class=''}
<svg class="svgic {$class}">
    <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
</svg>
{/function}

{block name='page_content_container'}
    <section id="content" class="page-content page-stores">

        {foreach $stores as $store}
            <article id="store-{$store.id}" class="store-item card">
                <div class="store-item-container flex-container align-items-center clearfix">
                    <div class="col-md-3 store-picture hidden-sm-down">
                        <img src="{$store.image.bySize.stores_default.url}" alt="{$store.image.legend}"
                            title="{$store.image.legend}">
                    </div>
                    <div class="col-md-5 col-sm-7 col-xs-12 store-description">
                        <h3 class="h3 card-title">{$store.name}</h3>
                        <address>{$store.address.formatted nofilter}</address>
                        {if $store.note || $store.phone || $store.fax || $store.email}
                            <a data-toggle="collapse" href="#about-{$store.id}" aria-expanded="false"
                                aria-controls="about-{$store.id}">
                                <strong>{l s='About and Contact' d='Shop.Theme.Global'}</strong>
                            </a>
                        {/if}
                    </div>
                    <div class="col-md-4 col-sm-5 col-xs-12 divide-left">
                        <table>
                            {foreach $store.business_hours as $day}
                                <tr>
                                    <th>{$day.day|truncate:4:'.'}</th>
                                    <td>
                                        <ul>
                                            {foreach $day.hours as $h}
                                                <li>{$h}</li>
                                            {/foreach}
                                        </ul>
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                </div>
                <footer id="about-{$store.id}" class="collapse">
                    <div class="store-item-footer divide-top">
                        <div class="card-block">
                            {if $store.note}
                                <p class="text-justify">
                                    {$store.note}
                                <p>
                            {/if}
                        </div>
                        <ul class="card-block">
                            {if $store.phone}
                                <li>{svgic id='phone'}&nbsp;{$store.phone}</li>
                            {/if}
                            {if $store.fax}
                                <li><{svgic id='fax'}&nbsp;{$store.fax}</li>
                            {/if}
                            {if $store.email}
                                <li><{svgic id='email'}&nbsp;{$store.email}</li>
                            {/if}
                        </ul>
                    </div>
                </footer>
            </article>
        {/foreach}

    </section>
{/block}