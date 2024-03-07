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
{extends file="helpers/form/form.tpl"}
{block name="input"}
{if $input.type == 'checkbox'}
    {if isset($input.values.query) && $input.values.query}
        {if $input.name=='ETS_MP_REGISTRATION_FIELDS'}
            {assign var=checkall value=true}
    		{foreach $input.values.query as $value}
    			{if !(isset($fields_value[$input.name]) && is_array($fields_value[$input.name]) && $fields_value[$input.name] && in_array($value[$input.values.id],$fields_value[$input.name]))} 
                    {assign var=checkall value=false}
                {/if}
    		{/foreach}
            {assign var=checkall_validate value=true}
    		{foreach $input.values.query as $value}
    			{if $value[$input.values.id]!='seller_name' && $value[$input.values.id]!='seller_email' && !(isset($fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE']) && is_array($fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE']) && $fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE'] && in_array($value[$input.values.id],$fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE']))} 
                    {assign var=checkall_validate value=false}
                {/if}
    		{/foreach}
            <table class="table table_ets_mp_registration_fields">
                <tr>
                    <td>{l s='Fields' mod='ets_marketplace'}</td>
                    <td>{l s='Enable' mod='ets_marketplace'}</td>
                    <td>{l s='Require' mod='ets_marketplace'}</td>
                </tr>
                <tr>
                    <td><b>{l s='All' mod='ets_marketplace'}</b></td>
                    <td>
                        <input value="0" type="checkbox" name="{$input.name|escape:'html':'UTF-8'}[]" id="{$input.name|escape:'html':'UTF-8'}_all" {if $checkall} checked="checked"{/if} />
                    </td>
                    <td>
                        <input value="0" type="checkbox" name="{$input.name|escape:'html':'UTF-8'}_VALIDATE[]" id="{$input.name|escape:'html':'UTF-8'}_VALIDATE_all" {if $checkall_validate} checked="checked"{/if} />
                    </td>
                </tr>
                {foreach $input.values.query as $value}
        			{assign var=id_checkbox value=$input.name|cat:'_'|cat:$value[$input.values.id]|escape:'html':'UTF-8'}
                    <tr>
                        <td>{$value[$input.values.name]|escape:'html':'UTF-8'}</td>
                        <td>
                            <input class="registration_field" type="checkbox" name="{$input.name|escape:'html':'UTF-8'}[]" id="{$id_checkbox|escape:'html':'UTF-8'}" {if isset($value[$input.values.id])} value="{$value[$input.values.id]|escape:'html':'UTF-8'}"{/if}{if isset($fields_value[$input.name]) && is_array($fields_value[$input.name]) && $fields_value[$input.name] && in_array($value[$input.values.id],$fields_value[$input.name])} checked="checked"{/if} />
                        </td>
                        <td>
                            {if $value[$input.values.id]!='seller_name' && $value[$input.values.id]!='seller_email'}
                                <input class="registration_field_validate"  type="checkbox" name="{$input.name|escape:'html':'UTF-8'}_VALIDATE[]" id="{$id_checkbox|escape:'html':'UTF-8'}_validate" {if isset($value[$input.values.id])} value="{$value[$input.values.id]|escape:'html':'UTF-8'}"{/if}{if isset($fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE']) && is_array($fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE']) && $fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE'] && in_array($value[$input.values.id],$fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE'])} checked="checked"{/if} />
                            {/if}
                        </td>
                    </tr>
        		{/foreach}
            </table>
        {elseif $input.name=='ETS_MP_CONTACT_FIELDS'}
            {assign var=checkall value=true}
    		{foreach $input.values.query as $value}
    			{if !(isset($fields_value[$input.name]) && is_array($fields_value[$input.name]) && $fields_value[$input.name] && in_array($value[$input.values.id],$fields_value[$input.name]))} 
                    {assign var=checkall value=false}
                {/if}
    		{/foreach}
            {assign var=checkall_validate value=true}
    		{foreach $input.values.query as $value}
    			{if $value[$input.values.id]!='seller_name' && $value[$input.values.id]!='seller_email' && !(isset($fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE']) && is_array($fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE']) && $fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE'] && in_array($value[$input.values.id],$fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE']))} 
                    {assign var=checkall_validate value=false}
                {/if}
    		{/foreach}
            <table class="table table_ets_mp_contact_fields">
                <tr>
                    <td>{l s='Fields' mod='ets_marketplace'}</td>
                    <td>{l s='Enable' mod='ets_marketplace'}</td>
                    <td>{l s='Require' mod='ets_marketplace'}</td>
                </tr>
                <tr>
                    <td><b>{l s='All' mod='ets_marketplace'}</b></td>
                    <td>
                        <input value="0" type="checkbox" name="{$input.name|escape:'html':'UTF-8'}[]" id="{$input.name|escape:'html':'UTF-8'}_all" {if $checkall} checked="checked"{/if} />
                    </td>
                    <td>
                        <input value="0" type="checkbox" name="{$input.name|escape:'html':'UTF-8'}_VALIDATE[]" id="{$input.name|escape:'html':'UTF-8'}_VALIDATE_all" {if $checkall_validate} checked="checked"{/if} />
                    </td>
                </tr>
                {foreach $input.values.query as $value}
        			{assign var=id_checkbox value=$input.name|cat:'_'|cat:$value[$input.values.id]|escape:'html':'UTF-8'}
                    <tr>
                        <td>{$value[$input.values.name]|escape:'html':'UTF-8'}</td>
                        <td>
                            <input type="checkbox" name="{$input.name|escape:'html':'UTF-8'}[]" id="{$id_checkbox|escape:'html':'UTF-8'}" {if isset($value[$input.values.id])} value="{$value[$input.values.id]|escape:'html':'UTF-8'}"{/if}{if isset($fields_value[$input.name]) && is_array($fields_value[$input.name]) && $fields_value[$input.name] && in_array($value[$input.values.id],$fields_value[$input.name])} checked="checked"{/if} {if $value[$input.values.id]=='email' || $value[$input.values.id]=='message' || $value[$input.values.id]=='title'} checked="checked" disabled="disabled"{else} class="contact_field"{/if} />
                        </td>
                        <td>
                            {if $value[$input.values.id]!='product_link'}
                                <input type="checkbox" name="{$input.name|escape:'html':'UTF-8'}_VALIDATE[]" id="{$id_checkbox|escape:'html':'UTF-8'}_validate" {if isset($value[$input.values.id])} value="{$value[$input.values.id]|escape:'html':'UTF-8'}"{/if}{if isset($fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE']) && is_array($fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE']) && $fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE'] && in_array($value[$input.values.id],$fields_value['ETS_MP_CONTACT_FIELDS_VALIDATE'])} checked="checked"{/if} {if $value[$input.values.id]=='email' || $value[$input.values.id]=='message' || $value[$input.values.id]=='title'} checked="checked" disabled="disabled"{else} class="contact_field_validate"{/if} />
                            {/if}
                        </td>
                    </tr>
        		{/foreach}
            </table>
        {else}
            {assign var=id_checkbox value=$input.name|cat:'_'|cat:'all'}
            {assign var=checkall value=true}
    		{foreach $input.values.query as $value}
    			{if !(isset($fields_value[$input.name]) && is_array($fields_value[$input.name]) && $fields_value[$input.name] && in_array($value[$input.values.id],$fields_value[$input.name]))} 
                    {assign var=checkall value=false}
                {/if}
    		{/foreach}
            {if count($input.values.query) >1 && !in_array($input.name,array('ETS_MP_COMMISSION_PENDING_WHEN','ETS_MP_COMMISSION_APPROVED_WHEN','ETS_MP_COMMISSION_CANCELED_WHEN'))}
                <div class="checkbox_all checkbox">
    				{strip}
    					<label for="{$id_checkbox|escape:'html':'UTF-8'}">                                
    						<input value="0" type="checkbox" name="{$input.name|escape:'html':'UTF-8'}[]" id="{$id_checkbox|escape:'html':'UTF-8'}" {if $checkall} checked="checked"{/if} />
    						<i class="md-checkbox-control"></i>
                            {l s='All' mod='ets_marketplace'}
    					</label>
    				{/strip}
    			</div>
            {/if}
            {foreach $input.values.query as $value}
    			{assign var=id_checkbox value=$input.name|cat:'_'|cat:$value[$input.values.id]|escape:'html':'UTF-8'}
    			<div class="checkbox{if isset($input.expand) && strtolower($input.expand.default) == 'show'} hidden{/if}">
    				 {strip}
    					<label for="{$id_checkbox|escape:'html':'UTF-8'}" >                                
    						<input {if $input.name=='ETS_MP_REGISTRATION_FIELDS'} class="ets_mp_extrainput" {/if} type="checkbox" name="{$input.name|escape:'html':'UTF-8'}[]" id="{$id_checkbox|escape:'html':'UTF-8'}" {if isset($value[$input.values.id])} value="{$value[$input.values.id]|escape:'html':'UTF-8'}"{/if}{if isset($fields_value[$input.name]) && is_array($fields_value[$input.name]) && $fields_value[$input.name] && in_array($value[$input.values.id],$fields_value[$input.name])} checked="checked"{/if} />
                            <i class="md-checkbox-control"></i>
                            {$value[$input.values.name]|escape:'html':'UTF-8'}
                            <br />
                            {if $input.name=='ETS_MP_REGISTRATION_FIELDS'}
                                <label {if isset($fields_value[$input.name]) && is_array($fields_value[$input.name]) && $fields_value[$input.name] && in_array($value[$input.values.id],$fields_value[$input.name])} style="display:block"{else} style="display:none" {/if}  for="{$id_checkbox|escape:'html':'UTF-8'}_validate" >                                
            						<input  type="checkbox" name="{$input.name|escape:'html':'UTF-8'}_VALIDATE[]" id="{$id_checkbox|escape:'html':'UTF-8'}_validate" {if isset($value[$input.values.id])} value="{$value[$input.values.id]|escape:'html':'UTF-8'}"{/if}{if isset($fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE']) && is_array($fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE']) && $fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE'] && in_array($value[$input.values.id],$fields_value['ETS_MP_REGISTRATION_FIELDS_VALIDATE'])} checked="checked"{/if} />
                                    <i class="md-checkbox-control"></i>
                                    {l s='Option require' mod='ets_marketplace'}
            					</label>
                            {/if}
    					</label> 
    				{/strip}
    			</div>
    		{/foreach}
        {/if}
    {/if}
{elseif $input.type == 'tre_categories'}
    {$input.tree nofilter}
{elseif $input.type == 'file_lang'}
    {if $languages|count > 1}
      <div class="form-group row">
    {/if}
    	{foreach from=$languages item=language}
    		{if $languages|count > 1}
    			<div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang != $defaultFormLanguage}style="display:none"{/if}>
    		{/if}
    			<div class="col-lg-9">
                    {if isset($fields_value[$input.name]) && $fields_value[$input.name] && $fields_value[$input.name][$language.id_lang]}
                        <div class="col-lg-12 uploaded_img_wrapper">
                    		<a  class="ybc_fancy" href="{$image_baseurl|escape:'html':'UTF-8'}{$fields_value[$input.name][$language.id_lang]|escape:'html':'UTF-8'}"><img title="{l s='Click to see full size image' mod='ets_marketplace'}" style="display: inline-block; max-width: 200px;" src="{$image_baseurl|escape:'html':'UTF-8'}{$fields_value[$input.name][$language.id_lang]|escape:'html':'UTF-8'}" /></a>
                            <a onclick="return confirm('{l s='Do you want to delete this banner?' mod='ets_marketplace' js=1}');" class="btn btn-default del_banner" href="{$banner_del_link|escape:'html':'UTF-8'}&id_lang={$language.id_lang|intval}">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                            </a>
                        </div>
    				{/if}
                    <input id="{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}" type="file" name="{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}" class="hide {$input.name|escape:'html':'UTF-8'}" />
    				<div class="dummyfile input-group">
    					<span class="input-group-addon"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1596 380q28 28 48 76t20 88v1152q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1600q0-40 28-68t68-28h896q40 0 88 20t76 48zm-444-244v376h376q-10-29-22-41l-313-313q-12-12-41-22zm384 1528v-1024h-416q-40 0-68-28t-28-68v-416h-768v1536h1280z"/></svg></span>
    					<input id="{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}-name" type="text" name="{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}" readonly="true" class="{$input.name|escape:'html':'UTF-8'}" />
    					<span class="input-group-btn">
    						<button id="{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}-selectbutton" type="button" name="submitAddAttachments" class="btn btn-default">
    							<svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1845 931q0-35-53-35h-1088q-40 0-85.5 21.5t-71.5 52.5l-294 363q-18 24-18 40 0 35 53 35h1088q40 0 86-22t71-53l294-363q18-22 18-39zm-1141-163h768v-160q0-40-28-68t-68-28h-576q-40 0-68-28t-28-68v-64q0-40-28-68t-68-28h-320q-40 0-68 28t-28 68v853l256-315q44-53 116-87.5t140-34.5zm1269 163q0 62-46 120l-295 363q-43 53-116 87.5t-140 34.5h-1088q-92 0-158-66t-66-158v-960q0-92 66-158t158-66h320q92 0 158 66t66 158v32h544q92 0 158 66t66 158v160h192q54 0 99 24.5t67 70.5q15 32 15 68z"/></svg> {l s='Add file' mod='ets_marketplace'}
    						</button>
    					</span>
    				</div>
    			</div>
    		{if $languages|count > 1}
    			<div class="col-lg-2">
    				<button type="button" class="btn btn-default dropdown-toggle" tabindex="-1" data-toggle="dropdown">
    					{$language.iso_code|escape:'html':'UTF-8'}
    					<span class="caret"></span>
    				</button>
    				<ul class="dropdown-menu">
    					{foreach from=$languages item=lang}
    					<li><a href="javascript:hideOtherLanguage({$lang.id_lang|intval});" tabindex="-1">{$lang.name|escape:'html':'UTF-8'}</a></li>
    					{/foreach}
    				</ul>
    			</div>
    		{/if}
    		{if $languages|count > 1}
    			</div>
    		{/if}
    		<script>
    		$(document).ready(function(){
    			$("#{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}-selectbutton").click(function(e){
    				$("#{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}").trigger('click');
    			});
                $("#{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}-name").click(function(e){
    				$("#{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}").trigger('click');
    			});
    			$("#{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}").change(function(e){
    				var val = $(this).val();
    				var file = val.split(/[\\/]/);
    				$("#{$input.name|escape:'html':'UTF-8'}_{$language.id_lang|intval}-name").val(file[file.length-1]);
    			});
    		});
    	</script>
    	{/foreach}
    {if $languages|count > 1}
      </div>
    {/if}
{else}
    {if $input.name=='seller_name' && isset($input.search) && $input.search && isset($fields_value[$input.name]) && $fields_value[$input.name]}
        <div class="seller_selected">
            {$fields_value[$input.name]|escape:'html':'UTF-8'}
            <span class="delete_seller_search">{l s='delete' mod='ets_marketpalce'}</span>
            <div></div>
        </div>
    {/if}
    {$smarty.block.parent}
{/if}
{/block}
{block name="legend"}
    {$smarty.block.parent}
    {if isset($configTabs) && $configTabs}
        <ul class="mkt_config_tab_header">
            {foreach from=$configTabs item='tab' key='tabId'}
                <li class="confi_tab config_tab_{$tabId|escape:'html':'UTF-8'} {if isset($current_tab) && $current_tab==$tabId}active{/if}" data-tab-id="{$tabId|escape:'html':'UTF-8'}">{$tab|escape:'html':'UTF-8'}</li>
            {/foreach}
        </ul>
    {/if}
{/block}
{block name="input_row"}
    {if $input.name=='ETS_MP_EMAIL_ADMIN_APPLICATION_REQUEST'}
        <div class="ets_mp_form email_settings">
            <p>{l s='Send email to Administrator'  mod='ets_marketplace'}</p>
        </div>
    {/if}
    {if $input.name=='ETS_MP_EMAIL_SELLER_APPLICATION_APPROVED_OR_DECLINED'}
        <div class="ets_mp_form email_settings">
            <p>{l s='Send email to Seller'  mod='ets_marketplace'}</p>
        </div>
    {/if}
    {if isset($input.tab) && $input.tab}
        <div class="ets_mp_form {$input.tab|escape:'html':'UTF-8'}">
    {/if}
    {if $input.name=='ETS_MP_SELLER_GROUP_DEFAULT'}
        <div class="alert alert-warning"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='You can separately customize each seller group.' mod='ets_marketplace'} {l s='Click' mod='ets_marketplace'} <a href="{$link->getAdminLink('AdminMarketPlaceShopGroups')|escape:'html':'UTF-8'}">{l s='here' mod='ets_marketplace'}</a> {l s='to config' mod='ets_marketplace'}</div>
    {/if}
    
    {$smarty.block.parent}
    {if $input.type == 'file' && isset($input.imageType) && $input.imageType && isset($input.display_img) && $input.display_img}
        <div class="form-group ets_uploaded_img_wrapper {$input.imageType|escape:'html':'UTF-8'}">
            <label class="control-label col-lg-3 uploaded_image_label" style="font-style: italic;">&nbsp;</label>
            <div class="col-lg-9 uploaded_img_wrapper">
        		<a  class="ybc_fancy" href="{$input.display_img|escape:'html':'UTF-8'}"><img title="{l s='Click to see full size image' mod='ets_marketplace'}" style="display: inline-block; max-width: 150px;" src="{$input.display_img|escape:'html':'UTF-8'}" /></a>
                {if isset($input.img_del_link) && $input.img_del_link && !(isset($input.required) && $input.required)}
                    <a class="delete_url" style="display: inline-block; text-decoration: none!important;" href="{$input.img_del_link|escape:'html':'UTF-8'}" onclick="return confirm('{l s='Do you want to delete this image?' mod='ets_marketplace' js=1}');"><span style="color: #666"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 736v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm128 724v-948h-896v948q0 22 7 40.5t14.5 27 10.5 8.5h832q3 0 10.5-8.5t14.5-27 7-40.5zm-672-1076h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg></span></a>
                {/if}
            </div>
        </div>
      {/if}
    {if isset($input.tab) && $input.tab}
        </div>
    {/if}
{/block}
{block name="label"}
	{if isset($input.label)}
		<label class="control-label col-lg-3{if ((isset($input.required) && $input.required) || (isset($input.required2) && $input.required2))} required{/if}">
			{if isset($input.hint)}
			<span class="label-tooltip" data-toggle="tooltip" data-html="true" title="{if is_array($input.hint)}
						{foreach $input.hint as $hint}
							{if is_array($hint)}
								{$hint.text|escape:'html':'UTF-8'}
							{else}
								{$hint|escape:'html':'UTF-8'}
							{/if}
						{/foreach}
					{else}
						{$input.hint|escape:'html':'UTF-8'}
					{/if}">
			{/if}
			{$input.label nofilter}
			{if isset($input.hint)}
			</span>
			{/if}
		</label>
	{/if}
{/block}
{block name='description'}
    {if isset($input.desc) && !is_array($input.desc)}
        <p class="help-block">{$input.desc|replace:'[highlight]':'<code>'|replace:'[end_highlight]':'</code>' nofilter}</p>
    {else}
        {$smarty.block.parent}
    {/if}
{/block}