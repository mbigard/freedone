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
<label class="form-control-label col-lg-3 required">
    {l s='Product' mod='ets_marketplace'}
</label>
<div class="col-lg-9">
	<div class="input-group col-lg-12">
		<input id="reduction_product" name="reduction_product" value="{if isset($valueFieldPost.product)}{$valueFieldPost.product->id|intval}{/if}" type="hidden"  />
		{if isset($valueFieldPost.product) && $valueFieldPost.product}
            <div class="product_selected">{$valueFieldPost.product->name|escape:'html':'UTF-8'} <span class="delete_product_search"></span><div></div></div>
        {/if}
        <input id="productFilter" class="input-xlarge ac_input" name="productFilter" value="" autocomplete="off" type="text" placeholder="{l s='Type product name here' mod='ets_marketplace'}" />
        <div class="input-group-append">
            <span class="input-group-text">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 832q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 52-38 90t-90 38q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg>
            </span>    
        </div>
	</div>
    <p class="help-block"> {l s='Each discount code is only able to apply for one product' mod='ets_marketplace'} </p>
</div>