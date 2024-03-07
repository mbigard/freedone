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

<div id="ets-mp-features-content">
    {if $product_features}
        {foreach $product_features item='product_feature'}
            <div class="form-group etm-mp-product-feature">
                <div class="row">
                <div class="col-lg-4 form-group">
                    <label>{l s='Feature' mod='ets_marketplace'}</label>
                    <div>
                        <select name="id_features[]" class="id_features">
                            <option value="0">{l s='Choose a feature' mod='ets_marketplace'}</option>
                            {if $features}
                                {foreach from=$features item='feature'}
                                    <option class="id_feature" {if $product_feature.id_feature==$feature.id_feature} selected="selected"{/if} value="{$feature.id_feature|intval}">{$feature.name|escape:'html':'UTF-8'}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </div>
                <div class="col-lg-4 form-group">
                    <label>{l s='Pre-defined value' mod='ets_marketplace'}</label>
                    <div>
                        <select class="id_feature_values{if !$product_feature.feature_values} ets_disabled{/if}" name="id_feature_values[]">
                            <option value="0">{l s='Choose a value' mod='ets_marketplace'}</option>
                            {if $features_values}
                                {foreach from=$features_values item='feature_value'}
                                    <option class="id_feature_value" data-id-feature="{$feature_value.id_feature|intval}" value="{$feature_value.id_feature_value|intval}"{if $product_feature.id_feature_value==$feature_value.id_feature_value} selected="selected"{/if}{if $feature_value.id_feature!=$product_feature.id_feature} style="display:none;"{/if} >{$feature_value.value|escape:'html':'UTF-8'}</option>
                                {/foreach}
                            {/if}
                        </select>
                    </div>
                </div>
                <div class="col-lg-4 form-group">
                    <label>{l s='OR Customized value' mod='ets_marketplace'}</label>
                    <div>
                        <input type="text" name="feature_value_custom[]" value="{if $product_feature.feature_value.custom==1}{$product_feature.feature_value.value|escape:'html':'UTF-8'}{/if}"/>
                    </div>
                </div>
                    <a class="btn tooltip-link ets-mp-delete" title="{l s='Delete' mod='ets_marketplace'}">
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                    </a>
                </div>
            </div>
        {/foreach}
    {/if}
</div>
{if $features}
    <div class="row">
        <div class="col-md-4">
            <button id="ets_mp_add_feature_button" class="btn btn-outline-primary sensitive add" type="button">
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
            {l s='Add a feature' mod='ets_marketplace'}
            </button>
        </div>
        <div id="ets-mp-feature-add-content" style="display:none;">
            <div class="form-group etm-mp-product-feature">
                <div class="row">
                    <div class="col-lg-4 form-group">
                        <label>{l s='Feature' mod='ets_marketplace'}</label>
                        <div>
                            <select name="id_features[]" class="id_features">
                                <option value="0">{l s='Choose a feature' mod='ets_marketplace'}</option>
                                {if $features}
                                    {foreach from=$features item='feature'}
                                        <option class="id_feature" value="{$feature.id_feature|intval}">{$feature.name|escape:'html':'UTF-8'}</option>
                                    {/foreach}
                                {/if}
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-4 form-group">
                        <label>{l s='Pre-defined value' mod='ets_marketplace'}</label>
                        <div>
                            <select class="id_feature_values" name="id_feature_values[]">
                                <option value="0">{l s='Choose a value' mod='ets_marketplace'}</option>
                                {if $features_values}
                                    {foreach from=$features_values item='feature_value'}
                                        <option class="id_feature_value" data-id-feature="{$feature_value.id_feature|intval}" value="{$feature_value.id_feature_value|intval}" style="display:none;">{$feature_value.value|escape:'html':'UTF-8'}</option>
                                    {/foreach}
                                {/if}
                            </select>
                        </div>
                    </div>
                    <div class="col-lg-4 form-group">
                        <label class="">{l s='OR Customized value' mod='ets_marketplace'}</label>
                        <div>
                            <input type="text" name="feature_value_custom[]" value=""/>
                        </div>
                    </div>
                    <a class="btn tooltip-link ets-mp-delete" title="{l s='Delete' mod='ets_marketplace'}">
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
{/if}
