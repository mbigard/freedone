{*
* 2011-2023 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2023 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='content'}
<section class="addresses">
  <h2 class="page-title">{l s='Addresses' d='Shop.Theme.Amp'}</h2>
  <div class="body">
    {foreach $customer.addresses as $address}
    <div class="m30">
        {block name='customer_address'}
            {include file='mobile/customer/_partials/block-address.tpl' address=$address}
        {/block}
    </div>
    {foreachelse}
        <div class="m30">
            <div class="notification alert">{l s='There is no addresses yet' d='Shop.Theme.Actions'}</div>
        </div>
    {/foreach}
    <div class="addresses-footer">
        <a href="{url entity='module' name={$amp.global.name} controller='address' relative_protocol=false}" data-link-action="add-address" class="button big-btn">
            <span>{l s='Create new address' d='Shop.Theme.Actions'}</span>
        </a>
    </div>
  </div>
</section>
{/block}