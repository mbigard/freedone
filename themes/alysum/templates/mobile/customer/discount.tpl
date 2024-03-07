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
<section class="discount">

  <h2 class="page-title">{l s='Your vouchers' d='Shop.Theme.Customeraccount'}</h2>

  {if $cart_rules}
    <table class="table table-striped table-bordered hidden-sm-down">
      <thead class="thead-default">
        <tr>
          <th>{l s='Code' d='Shop.Theme.Checkout'}</th>
          <th>{l s='Description' d='Shop.Theme.Checkout'}</th>
          <th>{l s='Quantity' d='Shop.Theme.Checkout'}</th>
          <th>{l s='Value' d='Shop.Theme.Checkout'}</th>
          <th>{l s='Minimum' d='Shop.Theme.Checkout'}</th>
          <th>{l s='Cumulative' d='Shop.Theme.Checkout'}</th>
          <th>{l s='Expiration date' d='Shop.Theme.Checkout'}</th>
        </tr>
      </thead>
      <tbody>
        {foreach from=$cart_rules item=cart_rule}
          <tr>
            <th scope="row">{$cart_rule.code}</th>
            <td>{$cart_rule.name}</td>
            <td class="text-xs-right">{$cart_rule.quantity_for_user}</td>
            <td>{$cart_rule.value}</td>
            <td>{$cart_rule.voucher_minimal}</td>
            <td>{$cart_rule.voucher_cumulable}</td>
            <td>{$cart_rule.voucher_date}</td>
          </tr>
        {/foreach}
      </tbody>
    </table>
    <div class="cart-rules hidden-md-up">
      {foreach from=$cart_rules item=slip}
        <div class="cart-rule">
          <ul>
            <li>
              <strong>{l s='Code' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.code}
            </li>
            <li>
              <strong>{l s='Description' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.name}
            </li>
            <li>
              <strong>{l s='Quantity' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.quantity_for_user}
            </li>
            <li>
              <strong>{l s='Value' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.value}
            </li>
            <li>
              <strong>{l s='Minimum' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.voucher_minimal}
            </li>
            <li>
              <strong>{l s='Cumulative' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.voucher_cumulable}
            </li>
            <li>
              <strong>{l s='Expiration date' d='Shop.Theme.Checkout'}</strong>
              {$cart_rule.voucher_date}
            </li>
          </ul>
        </div>
      {/foreach}
    </div>

  {else}
    {l s='There are no discounts yet' d='Shop.Theme.Amp'}
  {/if}
  

</section>
{/block}