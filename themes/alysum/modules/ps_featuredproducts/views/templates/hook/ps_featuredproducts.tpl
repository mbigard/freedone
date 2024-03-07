{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{assign var=unique_id value=1000|mt_rand:9999}
<div class="ps_featuredproducts oh products-carousel block title_left relative" data-num="{$products|count}" data-prefix="pr{$unique_id}">
  <h4 class="module-title">
    <span>{l s='Featured Products' d='Modules.Featuredproducts.Shop'}</span>
  </h4>
  <div class="widget-wrapper widget-inner">
    <div class="products glide" data-desktopnum="1" data-tabletnum="1" data-phonenum="1" data-loop="1" data-autoplay="1" data-navwrap="1" data-name="featured-sidebar">
      <div class="glide__track" data-glide-el="track">
        <div class="glide__slides slider-mode">
          <div class="products-section">
            {foreach from=$products item=product name=ps_featuredproducts}
              {include file="catalog/_partials/miniatures/micro-product.tpl" product=$product}
              {if (($smarty.foreach.ps_featuredproducts.index+1) % 3 == 0) && (!$smarty.foreach.ps_featuredproducts.last)}</div><div class="products-section">{/if}
            {/foreach}
          </div>
        </div>
      </div>
    </div>
  </div>
</div>