{*
 * Copyright ETS Software Technology Co., Ltd
 *
 * NOTICE OF LICENSE
 *
 * This file is not open source! Each license that you purchased is only available for 1 website only.
 * If you want to use this file on more websites (or projects), you need to purchase additional licenses.
 * You are not allowed to redistribute, resell, lease, license, sub-license or offer our resources to any third party.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future.
 *
 * @author ETS Software Technology Co., Ltd
 * @copyright  ETS Software Technology Co., Ltd
 * @license    Valid for 1 website (or project) for each purchase of license
*}
<div class="row">
    <div class="col-md-12">
        <h2>{l s='Suppliers' mod='ets_marketplace'}</h2>
        <p class="alert alert-info"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='This interface allows you to specify the suppliers of the current product and its combinations, if any.' mod='ets_marketplace'}<br />
        {l s='You can specify supplier references according to previously associated suppliers.' mod='ets_marketplace'}</p>
    </div>
</div>
<div class="row">
    <div class="col-md-12 form-group panel-default">
        <div class="panel-body">
            <div>
                <table id="form_step6_suppliers" class="table">
                    <thead class="thead-default">
                        <tr>
                            <th width="70%">{l s='Choose the suppliers associated with this product' mod='ets_marketplace'}</th>
                            <th width="30%">{l s='Default supplier' mod='ets_marketplace'}</th>
                        </tr>
                    </thead>
                    <tbody> 
                        {foreach from=$suppliers item='supplier'}
                            <tr>
                                <td>
                                    <div class="checkbox">
                                        <label for="form_step6_suppliers_{$supplier.id_supplier|intval}">
                                            <input id="form_step6_suppliers_{$supplier.id_supplier|intval}" name="id_suppliers[]" value="{$supplier.id_supplier|intval}"{if $supplier.checked} checked="checked"{/if} type="checkbox" class="change_supplier" />
                                            {$supplier.name|escape:'html':'UTF-8'}
                                        </label>
                                    </div>
                                </td>
                                <td>
                                    <div class="radio">
                                        <label for="form_step6_default_supplier_{$supplier.id_supplier|intval}">
                                            <input id="form_step6_default_supplier_{$supplier.id_supplier|intval}" name="id_supplier_default" value="{$supplier.id_supplier|intval}" type="radio" {if $id_supplier_default==$supplier.id_supplier} checked="checked"{/if} {if !$supplier.checked} style="display:none"{/if}/>
                                            {$supplier.name|escape:'html':'UTF-8'}
                                        </label>
                                    </div>
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="row">
     <div class="col-md-12">
        <div id="supplier_combination_collection" class="">
            <h2>{l s='Supplier reference(s)' mod='ets_marketplace'}</h2>
            <p class="alert alert-info"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg> {l s='You can specify product reference(s) for each associated supplier. Click "Save" after changing selected suppliers to display the associated product references.' mod='ets_marketplace'}</p>
            <div class="row">
                {if $suppliers}
                    {foreach from=$suppliers item='supplier'}
{*
                        {if $supplier.product_suppliers}
                            <div class="col-sm-12 form-group panel-default">
                                <div class="panel-heading">
                                    <strong>{$supplier.name|escape:'html':'UTF-8'}</strong>
                                </div>
                                <div id="supplier_combination_{$supplier.id_supplier|intval}" class="panel-body">
                                    <div>
                                        <table class="table">
                                            <thead class="thead-default">
                                                <tr>
                                                    <th width="30%">{l s='Product name' mod='ets_marketplace'}</th>
                                                    <th width="30%">{l s='Supplier reference' mod='ets_marketplace'}</th>
                                                    <th width="20%">{l s='Price (tax excl.)' mod='ets_marketplace'}</th>
                                                    <th width="20%">{l s='Currency' mod='ets_marketplace'}</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {foreach from=$supplier.product_suppliers item='product_supplier'}
                                                    <tr>
                                                        <td>{$product_supplier.product_name|escape:'html':'UTF-8'}</td>
                                                        <td>
                                                            <input id="form_step6_supplier_combination_{$product_supplier.id_product_attribute|intval}_{$product_supplier.id_supplier|intval}_supplier_reference" class="form-control" name="supplier_reference[{$product_supplier.id_supplier|intval}][{$product_supplier.id_product_attribute|intval}]" type="text" value="{$product_supplier.product_supplier_reference|escape:'html':'UTF-8'}" />
                                                        </td>
                                                        <td>
                                                            <div class="input-group money-type">
                                                                <div class="input-group-prepend">
                                                                    <span class="input-group-text">{$product_supplier.symbol|escape:'html':'UTF-8'} </span>
                                                                </div>
                                                                <input id="form_step6_supplier_combination_{$product_supplier.id_product_attribute|intval}_{$product_supplier.id_supplier|intval}_product_price" class="form-control" name="product_price[{$product_supplier.id_supplier|intval}][{$product_supplier.id_product_attribute|intval}]" value="{$product_supplier.product_supplier_price_te|floatval}" type="text" />
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <select id="form_step6_supplier_combination_{$product_supplier.id_product_attribute|intval}_{$product_supplier.id_supplier|intval}_product_price_currency" class="custom-select custom-select" name="product_price_currency[{$product_supplier.id_supplier|intval}][{$product_supplier.id_product_attribute|intval}]">
                                                                {if $currencies}
                                                                    {foreach from=$currencies item='currency'}
                                                                        <option value="{$currency.id_currency|intval}"{if $product_supplier.id_currency==$currency.id_currency} selected="selected"{/if} data-symbol="{$currency.symbol|escape:'html':'UTF-8'}">{$currency.name|escape:'html':'UTF-8'}</option>
                                                                    {/foreach}
                                                                {/if}
                                                            </select>
                                                        </td>    
                                                    </tr>
                                                {/foreach}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        {/if}
*}
                        {$supplier.product_suppliers nofilter}

                    {/foreach}
                {/if}
            </div>
        </div>
     </div>
</div>