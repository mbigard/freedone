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

<label class="control-label col-lg-3">
	<span  title="{l s='Optional: The cart rule will be available to everyone if you leave this field blank.' mod='ets_marketplace'}">
		{l s='Limit to a single customer' mod='ets_marketplace'}
	</span>
</label>
<div class="col-lg-9">
	<div class="input-group col-lg-12">
		<div class="input-group-prepend">
            <span class="input-group-text">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1536 1399q0 109-62.5 187t-150.5 78h-854q-88 0-150.5-78t-62.5-187q0-85 8.5-160.5t31.5-152 58.5-131 94-89 134.5-34.5q131 128 313 128t313-128q76 0 134.5 34.5t94 89 58.5 131 31.5 152 8.5 160.5zm-256-887q0 159-112.5 271.5t-271.5 112.5-271.5-112.5-112.5-271.5 112.5-271.5 271.5-112.5 271.5 112.5 112.5 271.5z"/></svg>
            </span>
        </div>
		<input id="id_customer" name="id_customer" value="{if isset($valueFieldPost.customer)}{$valueFieldPost.customer->id|intval}{/if}" type="hidden" />
		<input id="customerFilter" class="input-xlarge ac_input" name="customerFilter" value="" autocomplete="off" type="text" />
		{if isset($valueFieldPost.customer) && $valueFieldPost.customer}
            <div class="customer_selected">{$valueFieldPost.customer->firstname|escape:'html':'UTF-8'}&nbsp;{$valueFieldPost.customer->lastname|escape:'html':'UTF-8'} ({$valueFieldPost.customer->email|escape:'html':'UTF-8'}) <span class="delete_customer_search">{l s='Delete' mod='ets_marketplace'}</span><div></div></div>
        {/if}
        <div class="input-group-append">
            <span class="input-group-text">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 832q0-185-131.5-316.5t-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5 316.5-131.5 131.5-316.5zm512 832q0 52-38 90t-90 38q-54 0-90-38l-343-342q-179 124-399 124-143 0-273.5-55.5t-225-150-150-225-55.5-273.5 55.5-273.5 150-225 225-150 273.5-55.5 273.5 55.5 225 150 150 225 55.5 273.5q0 220-124 399l343 343q37 37 37 90z"/></svg>
            </span>
        </div>
	</div>
</div>