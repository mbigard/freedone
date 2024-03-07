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
<section class="order-slip">
  <h2 class="page-title">
    <h6>{l s='Credit slips you have received after canceled orders.' d='Shop.Theme.Customeraccount'}</h6>
  </h2>
  <div class="body">
    {if $credit_slips}
    <table class="table table-striped table-bordered hidden-sm-down">
      <thead class="thead-default">
        <tr>
          <th>{l s='Order' d='Shop.Theme.Customeraccount'}</th>
          <th>{l s='Credit slip' d='Shop.Theme.Customeraccount'}</th>
          <th>{l s='Date issued' d='Shop.Theme.Customeraccount'}</th>
          <th>{l s='View credit slip' d='Shop.Theme.Customeraccount'}</th>
        </tr>
      </thead>
      <tbody>
        {foreach from=$credit_slips item=slip}
          <tr>
            <td><a href="{$slip.order_url_details}" data-link-action="view-order-details">{$slip.order_reference}</a></td>
            <td scope="row">{$slip.credit_slip_number}</td>
            <td>{$slip.credit_slip_date}</td>
            <td class="text-xs-center">
              <a href="{$slip.url}"><i class="material-icons">&#xE415;</i></a>
            </td>
          </tr>
        {/foreach}
      </tbody>
    </table>
    <div class="credit-slips hidden-md-up">
      {foreach from=$credit_slips item=slip}
        <div class="credit-slip">
          <ul>
            <li>
              <strong>{l s='Order' d='Shop.Theme.Customeraccount'}</strong>
              <a href="{$slip.order_url_details}" data-link-action="view-order-details">{$slip.order_reference}</a>
            </li>
            <li>
              <strong>{l s='Credit slip' d='Shop.Theme.Customeraccount'}</strong>
              {$slip.credit_slip_number}
            </li>
            <li>
              <strong>{l s='Date issued' d='Shop.Theme.Customeraccount'}</strong>
              {$slip.credit_slip_date}
            </li>
            <li>
              <a href="{$slip.url}">{l s='View credit slip' d='Shop.Theme.Customeraccount'}</a>
            </li>
          </ul>
        </div>
      {/foreach}
    </div>
  {/if}
  </div>
</section>
{/block}