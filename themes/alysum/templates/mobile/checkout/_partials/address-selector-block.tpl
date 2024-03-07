{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='address_selector_blocks'}
{foreach $addresses as $address}
  <article class="address-item m20{if $address.id == $selected} selected{/if}" id="{$name|classname}-address-{$address.id}">
    <div class="flex-container align-items-center">
      <input type="radio" name="{$name}" class="m0" id="addr-{$address.id}" value="{$address.id}" {if $address.id == $selected}checked{/if}>&nbsp;<label class="address-alias bold">{$address.alias}</span>
    </div>
    <div class="address">{$address.formatted nofilter}</div>
  </article>
{/foreach}
{/block}