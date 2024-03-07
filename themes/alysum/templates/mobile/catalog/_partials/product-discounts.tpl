{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{if $product.q_discounts.discounts}
<section class="product-discounts m30">
  <h3 class="h6 product-discounts-title">{l s='Volume discounts' d='Shop.Theme.Catalog'}</h3>
  {block name='product_discount_table'}
    <table class="table-product-discounts">
      <thead>
      <tr>
        <th>{l s='Quantity' d='Shop.Theme.Catalog'}</th>
        <th>{$configuration.quantity_discount.label}</th>
        <th>{l s='You Save' d='Shop.Theme.Catalog'}</th>
      </tr>
      </thead>
      <tbody>
      {foreach from=$product.q_discounts.discounts item='quantity_discount' name='quantity_discounts'}
        <tr data-discount-type="{$quantity_discount.reduction_type}" data-discount="{$quantity_discount.real_value}" data-discount-quantity="{$quantity_discount.quantity}">
          <td>{$quantity_discount.quantity}</td>
          <td>{$quantity_discount.discount}</td>
          <td>{l s='Up to %discount%' d='Shop.Theme.Catalog' sprintf=['%discount%' => $quantity_discount.save]}</td>
        </tr>
      {/foreach}
      </tbody>
    </table>
  {/block}
</section>
{/if}