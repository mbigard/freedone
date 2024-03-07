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

  {if $ordersReturn && count($ordersReturn)}
    <h3 class="m30">{l s='Here is a list of pending merchandise returns' d='Shop.Theme.Amp'}</h3>
    <div class="m30">
    {foreach from=$ordersReturn item=return}
    <div class="m20">
      <div class="flex-container list-item-dashed">
        <strong class="flex-grow1">{l s='Order' d='Shop.Theme.Amp'}:</strong>
        <a href="{$return.details_url}">{$return.reference}</a>
      </div>
      <div class="flex-container list-item-dashed">
        <strong class="flex-grow1">{l s='Return' d='Shop.Theme.Amp'}:</strong>
        <a href="{$return.return_url}">{$return.return_number}</a>
      </div>
      <div class="flex-container list-item-dashed">
        <strong class="flex-grow1">{l s='Package status' d='Shop.Theme.Amp'}:</strong>
        <span>{$return.state_name}</span>
      </div>
      <div class="flex-container list-item-dashed">
        <strong class="flex-grow1">{l s='Date issued' d='Shop.Theme.Amp'}:</strong>
        <a href="{$return.details_url}">{$return.return_date}</a>
      </div>
      <div class="flex-container list-item-dashed">
        <strong class="flex-grow1">{l s='Returns form' d='Shop.Theme.Amp'}:</strong>
        {if $return.print_url}
          <a href="{$return.print_url}">{l s='Print out' d='Shop.Theme.Amp'}</a>
        {else}
          <span>-</span>
        {/if}
      </div>
    </div><hr>
    {/foreach}
    </div>

  {else}
    <p class="alert notification" role="alert" data-alert="warning">
      {l s='You have no merchandise return authorizations' d='Shop.Theme.Amp'}
    </p>
  {/if}

{/block}