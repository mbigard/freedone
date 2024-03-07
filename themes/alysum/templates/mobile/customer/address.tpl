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

{block name='content'}
<section class="addresses">
  <h2 class="page-title">
    {if $editing}
      {l s='Update your address' d='Shop.Theme.Customeraccount'}
    {else}
      {l s='New address' d='Shop.Theme.Customeraccount'}
    {/if}
  </h2>
  <div class="body">
    {$addressForm.address_form nofilter}
  </div>
</section>
{/block}