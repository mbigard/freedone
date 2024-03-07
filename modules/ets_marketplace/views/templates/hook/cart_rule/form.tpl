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
<script type="text/javascript">
var ets_mp_url_search_customer = '{$ets_mp_url_search_customer nofilter}';
var ets_mp_url_search_product = '{$ets_mp_url_search_product nofilter}';
</script>
<div class="row">
    <div class="col-lg-12">
        <div class="panel">
            <h3>
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M576 448q0-53-37.5-90.5t-90.5-37.5-90.5 37.5-37.5 90.5 37.5 90.5 90.5 37.5 90.5-37.5 37.5-90.5zm1067 576q0 53-37 90l-491 492q-39 37-91 37-53 0-90-37l-715-716q-38-37-64.5-101t-26.5-117v-416q0-52 38-90t90-38h416q53 0 117 26.5t102 64.5l715 714q37 39 37 91z"/></svg>
                {if $id_cart_rule}{l s='Edit discount' mod='ets_marketplace'}{else}{l s='Add new discount' mod='ets_marketplace'}{/if}
            </h3>
            <div class="productTabs">
        		<ul class="tab nav nav-tabs">
        			<li class="tab-row{if $currentFormTab=='informations'} active{/if}">
        				<a class="tab-page" id="cart_rule_link_informations" href="javascript:ets_displayCartRuleTab('informations');"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1216 1344v128q0 26-19 45t-45 19h-512q-26 0-45-19t-19-45v-128q0-26 19-45t45-19h64v-384h-64q-26 0-45-19t-19-45v-128q0-26 19-45t45-19h384q26 0 45 19t19 45v576h64q26 0 45 19t19 45zm-128-1152v192q0 26-19 45t-45 19h-256q-26 0-45-19t-19-45v-192q0-26 19-45t45-19h256q26 0 45 19t19 45z"/></svg> {l s='Information' mod='ets_marketplace'}</a>
        			</li>
        			<li class="tab-row{if $currentFormTab=='conditions'} active{/if}">
        				<a class="tab-page" id="cart_rule_link_conditions" href="javascript:ets_displayCartRuleTab('conditions');"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M666 481q-60 92-137 273-22-45-37-72.5t-40.5-63.5-51-56.5-63-35-81.5-14.5h-224q-14 0-23-9t-9-23v-192q0-14 9-23t23-9h224q250 0 410 225zm1126 799q0 14-9 23l-320 320q-9 9-23 9-13 0-22.5-9.5t-9.5-22.5v-192q-32 0-85 .5t-81 1-73-1-71-5-64-10.5-63-18.5-58-28.5-59-40-55-53.5-56-69.5q59-93 136-273 22 45 37 72.5t40.5 63.5 51 56.5 63 35 81.5 14.5h256v-192q0-14 9-23t23-9q12 0 24 10l319 319q9 9 9 23zm0-896q0 14-9 23l-320 320q-9 9-23 9-13 0-22.5-9.5t-9.5-22.5v-192h-256q-48 0-87 15t-69 45-51 61.5-45 77.5q-32 62-78 171-29 66-49.5 111t-54 105-64 100-74 83-90 68.5-106.5 42-128 16.5h-224q-14 0-23-9t-9-23v-192q0-14 9-23t23-9h224q48 0 87-15t69-45 51-61.5 45-77.5q32-62 78-171 29-66 49.5-111t54-105 64-100 74-83 90-68.5 106.5-42 128-16.5h256v-192q0-14 9-23t23-9q12 0 24 10l319 319q9 9 9 23z"/></svg> {l s='Conditions' mod='ets_marketplace'}</a>
        			</li>
        			<li class="tab-row{if $currentFormTab=='actions'} active{/if}">
        				<a class="tab-page" id="cart_rule_link_actions" href="javascript:ets_displayCartRuleTab('actions');"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M448 1472q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm644-420l-682 682q-37 37-90 37-52 0-91-37l-106-108q-38-36-38-90 0-53 38-91l681-681q39 98 114.5 173.5t173.5 114.5zm634-435q0 39-23 106-47 134-164.5 217.5t-258.5 83.5q-185 0-316.5-131.5t-131.5-316.5 131.5-316.5 316.5-131.5q58 0 121.5 16.5t107.5 46.5q16 11 16 28t-16 28l-293 169v224l193 107q5-3 79-48.5t135.5-81 70.5-35.5q15 0 23.5 10t8.5 25z"/></svg> {l s='Actions' mod='ets_marketplace'}</a>
        			</li>
        		</ul>
        	</div>
            <form id="cart_rule_form" class="form-horizontal" action="" method="post">
                <input id="currentFormTab" name="currentFormTab" value="{$currentFormTab|escape:'html':'UTF-8'}" type="hidden" />
                <input type="hidden" name="id_cart_rule" value="{$id_cart_rule|intval}"/>
                <div class="ets_mp-form-content">
                    <div id="cart_rule_informations" class="panel cart_rule_tab"{if $currentFormTab=='informations'} style="display: block;"{else} style="display: none;"{/if}>
                        {$html_informations nofilter}
                    </div>
                    <div id="cart_rule_conditions" class="panel cart_rule_tab"{if $currentFormTab=='conditions'} style="display: block;"{else} style="display: none;"{/if}>
                        {$html_conditions nofilter}
                    </div>
                    <div id="cart_rule_actions" class="panel cart_rule_tab"{if $currentFormTab=='actions'} style="display: block;"{else} style="display: none;"{/if}>
                        {$html_actions nofilter}
                    </div>
                </div>
                <div class="ets_mp-form-footer">
                    <input type="hidden" name="submitSaveCartRule" value="1"/>
                    <a class="btn btn-secondary bd text-uppercase float-xs-left" href="{$link->getModuleLink('ets_marketplace','discount',['list'=>1])|escape:'html':'UTF-8'}" title="">
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1203 544q0 13-10 23l-393 393 393 393q10 10 10 23t-10 23l-50 50q-10 10-23 10t-23-10l-466-466q-10-10-10-23t10-23l466-466q10-10 23-10t23 10l50 50q10 10 10 23z"/></svg> {l s='Back' mod='ets_marketplace'}
                    </a>
                    <button name="submitSaveCartRule" type="submit" class="btn btn-primary form-control-submit float-xs-right">{l s='Save' mod='ets_marketplace'}</button>
                </div>
            </form>
        </div>
    </div>
</div>
