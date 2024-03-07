{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='order_products_table'}
<form action-xhr="{url entity='module' name={$amp.global.name} controller='orderfollow' relative_protocol=false params=['who' => 'order-detail-return']}" method="post" target="_top">

<div class="box">
  <h3 class="m10">{l s='Order returns' d='Shop.Theme.Amp'}</h3>
  {foreach from=$order.products item=product name=products}
    <div class="m40">
      <div class="or-product m15">{$product.name}</div>
      <div class="customized-products">
        {if !$product.customizations}
          <span id="_desktop_product_line_{$product.id_order_detail}" class="flex-container list-item-dashed">
            <label class="flex-grow1" for="cb_{$product.id_order_detail}"><strong>{l s='Select for Return' d='Shop.Theme.Amp'}</strong></label>
            <input type="checkbox" id="cb_{$product.id_order_detail}" name="ids_order_detail[{$product.id_order_detail}]" value="{$product.id_order_detail}">
          </span>
        {else}
          {foreach $product.customizations  as $customization}
            <span id="_desktop_product_customization_line_{$product.id_order_detail}_{$customization.id_customization}">
              <label for="cb_{$product.id_order_detail}"><strong>{l s='Select' d='Shop.Theme.Amp'}</strong></label>
              <input type="checkbox" id="cb_{$product.id_order_detail}" name="customization_ids[{$product.id_order_detail}][]" value="{$customization.id_customization}">
            </span>
          {/foreach}
        {/if}
      </div>
      {if $product.reference}
      <div class="flex-container list-item-dashed">
        <strong class="flex-grow1">{l s='Reference' d='Shop.Theme.Amp'}:</strong><span>{$product.reference}</span>
      </div>
      {/if}
      {if $product.customizations}
        {foreach from=$product.customizations item="customization"}
          <div class="customization">
            <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
          </div>
          <div id="_desktop_product_customization_modal_wrapper_{$customization.id_customization}">
            <div class="modal fade customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                  </div>
                  <div class="modal-body">
                    {foreach from=$customization.fields item="field"}
                      <div class="product-customization-line row">
                        <div class="col-sm-3 col-xs-4 label">
                          {$field.label}
                        </div>
                        <div class="col-sm-9 col-xs-8 value">
                          {if $field.type == 'text'}
                            {if (int)$field.id_module}
                              {$field.text nofilter}
                            {else}
                              {$field.text}
                            {/if}
                          {elseif $field.type == 'image'}
                            <img src="{$field.image.small.url}">
                          {/if}
                        </div>
                      </div>
                    {/foreach}
                  </div>
                </div>
              </div>
            </div>
          </div>
        {/foreach}
      {/if}
      {if !$product.customizations}
        <div class="flex-container list-item-dashed">
          <strong class="flex-grow1">{l s='Ordered Quantity' d='Shop.Theme.Amp'}:</strong><span>{$product.quantity}</span>
        </div>
        {if $product.quantity > $product.qty_returned}
        <div class="flex-container list-item-dashed">
          <strong class="flex-grow1">{l s='Return Quantity' d='Shop.Theme.Amp'}:</strong>
          <div class="select" id="_desktop_return_qty_{$product.id_order_detail}">
            <select name="order_qte_input[{$product.id_order_detail}]" class="form-control form-control-select">
              {section name=quantity start=1 loop=$product.quantity+1-$product.qty_returned}
                <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
              {/section}
            </select>
          </div>
        </div>
        {/if}
      {else}
      {foreach $product.customizations as $customization}
        <div class="flex-container list-item-dashed">
          <strong class="flex-grow1">{l s='Quantity' d='Shop.Theme.Amp'}:</strong><span>{$customization.quantity}</span>
        </div>
        <div class="select" id="_desktop_return_qty_{$product.id_order_detail}_{$customization.id_customization}">
          <select name="customization_qty_input[{$customization.id_customization}]" class="form-control form-control-select">
            {section name=quantity start=1 loop=$customization.quantity+1}
              <option value="{$smarty.section.quantity.index}">{$smarty.section.quantity.index}</option>
            {/section}
          </select>
        </div>
      {/foreach}
      {/if}
      <div class="flex-container list-item-dashed"><strong class="flex-grow1">{l s='Returned' d='Shop.Theme.Amp'}:</strong><span>{$product.qty_returned}</span></div>
      <div class="flex-container list-item-dashed"><strong class="flex-grow1">{l s='Unit price' d='Shop.Theme.Amp'}:</strong><span>{$product.price}</span></div>
      <div class="flex-container list-item-dashed"><strong class="flex-grow1">{l s='Total price' d='Shop.Theme.Amp'}:</strong><span>{$product.total}</span></div>
    </div>
    {/foreach}
    <div class="m20">
      {foreach $order.subtotals as $line}
        {if $line.value}
        <div class="flex-container list-item-dashed">
          <div class="flex-grow1">{$line.label}</div>
          <div>{$line.value}</div>
        </div>
        {/if}
      {/foreach}
      <div class="flex-container list-item-dashed line-{$order.totals.total.type}">
        <div class="flex-grow1">{$order.totals.total.label}</div>
        <div>{$order.totals.total.value}</div>
      </div>
    </div>
    <section class="return-footer">
      <p>
        <i>{l s='If you wish to return one or more products, please mark the corresponding boxes and provide an explanation for the return. When complete, click the button below.' d='Shop.Theme.Customeraccount'}</i>
      </p>
      <textarea cols="67" rows="3" name="returnText" class="form-control"></textarea>
      <input type="hidden" name="id_order" value="{$order.details.id}">
      <input type="hidden" name="submitReturnMerchandise" value="1">
      <button class="form-control-submit btn btn-primary" type="submit">
        {l s='Request a return' d='Shop.Theme.Customeraccount'}
      </button>
    </section>

    <div submit-success class="p0 m15">
       <template type="amp-mustache">
        {l s='Request has been sent' d='Shop.Theme.Amp'}
      </template>
    </div>

    <div submit-error class="p0 m15">
       <template type="amp-mustache">
        {l s='Unable to send request' d='Shop.Theme.Amp'}
      </template>
    </div>

  </div>
</form>
{/block}