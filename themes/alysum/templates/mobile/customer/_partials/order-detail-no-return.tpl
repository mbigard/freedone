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
<div class="box">
  {foreach from=$order.products item=product}
    <div class="flex-container f1">
      <div class="text-left m10">
        <strong>
          <a {if isset($product.download_link)}href="{$product.download_link}"{/if}>
            {$product.name}
          </a>
        </strong><br>
        {if $product.reference}
          {l s='Reference' d='Shop.Theme.Catalog'}: {$product.reference}<br>
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
      </div>
    </div>
    <div class="flex-container f2">
      <div class="flex-grow1">{l s='Quantity' d='Shop.Theme.Catalog'}</div>
      <div>
        {if $product.customizations}
          {foreach $product.customizations as $customization}
            {$customization.quantity}
          {/foreach}
        {else}
          {$product.quantity}
        {/if}
      </div>
    </div>
    <div class="flex-container f3">
      <div class="flex-grow1">{l s='Unit price' d='Shop.Theme.Catalog'}</div>
      <div>
        {$product.price}
      </div>
    </div>
    <div class="flex-container f4 border-bottom m15 pb15">
      <div class="flex-grow1">{l s='Total price' d='Shop.Theme.Catalog'}</div>
      <div>{$product.total}</div>
    </div>
  {/foreach}
  {foreach $order.subtotals as $line}
    {if $line.value}  
    <div class="flex-container f5">
      <div class="flex-grow1"><strong>{$line.label}</strong></div>
      <div>{$line.value}</div>
    </div>
    {/if}
  {/foreach}
  <div class="flex-container f6">
    <div class="flex-grow1"><strong>{$order.totals.total.label}</strong></div>
    <div>{$order.totals.total.value}</div>
  </div>
</div>

{/block}