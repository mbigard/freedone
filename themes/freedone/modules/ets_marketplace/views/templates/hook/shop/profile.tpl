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
{if isset($ETS_MP_GOOGLE_MAP_API) && $ETS_MP_GOOGLE_MAP_API && isset($ETS_MP_SEARCH_ADDRESS_BY_GOOGLE) && $ETS_MP_SEARCH_ADDRESS_BY_GOOGLE}
    <script>
        {literal}
        var address_autocomplete;
        function ets_mp_initAutocomplete() {
          address_autocomplete = new google.maps.places.Autocomplete(
              document.getElementById('search_shop_address'), {types: ['geocode']});
          address_autocomplete.setFields(['address_component']);
          address_autocomplete.addListener('place_changed', ets_mp_fillInAddress);
        }
        function ets_mp_fillInAddress() {
            var address = document.getElementById('search_shop_address').value;
        	var geocoder = new google.maps.Geocoder();
        	geocoder.geocode({address: address}, function(results, status) {
                if (status === google.maps.GeocoderStatus.OK)
      			{
      			   var center = results[0].geometry.location;
                    document.getElementById('latitude').value = Math.round(center.lat()*1000000)/1000000;
                   document.getElementById('longitude').value = Math.round(center.lng()*1000000)/1000000;
      			}
        	});
        }
        {/literal}
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?key={$ETS_MP_GOOGLE_MAP_API|escape:'html':'UTF-8'}&libraries=places&callback=ets_mp_initAutocomplete" async defer></script>
{/if}
{if $_errors}
    <div class="ets_alert">{$_errors nofilter}</div>
{/if}
{if $_success}
    <div class="ets_alert">{$_success nofilter}</div>
{/if}
<div class="row">
    <div class="ets_mp_content_left col-lg-3" >
        {Module::getInstanceByName('ets_marketplace')->hookDisplayMPLeftContent() nofilter}
    </div>
    <div class="ets_mp_content_left col-lg-9" >
        <div class="panel">
            <section>
                <form id="seller-form" action="{$link->getModuleLink('ets_marketplace','profile')|escape:'html':'UTF-8'}" method="post" enctype="multipart/form-data">
                    <section>
                        <div class="ets_mp_step_content">
                            <div class="step step_1 active">
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label required"> {l s='Seller name' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="seller_name" value="{$profile_customer->firstname|escape:'html':'UTF-8'} {$profile_customer->lastname|escape:'html':'UTF-8'}" type="text" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label required"> {l s='Seller email' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="seller_email" value="{$profile_customer->email|escape:'html':'UTF-8'}" type="text" disabled="disabled" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label required"> {l s='Shop name' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        {if $languages && count($languages)>1}
                                            <div class="form-group row">
                                                {foreach from=$languages item='language'}
                                                    <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                                        <div class="col-lg-10">
                                                            {if isset($valueFieldPost)}
                                                                {assign var='value_text' value=$valueFieldPost['shop_name'][$language.id_lang]}
                                                            {/if}
                                                            <input class="form-control" name="shop_name_{$language.id_lang|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="toggle_form">
                                                            <button class="btn btn-default dropdown-toggle" type="button" tabindex="-1" data-toggle="dropdown">
                                                            {$language.iso_code|escape:'html':'UTF-8'}
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                {foreach from=$languages item='lang'}
                                                                    <li>
                                                                        <a class="hideOtherLanguage" href="#" tabindex="-1" data-id-lang="{$lang.id_lang|intval}">{$lang.name|escape:'html':'UTF-8'}</a>
                                                                    </li>
                                                                {/foreach}
                                                            </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {else}
                                            {if isset($valueFieldPost)}
                                                {assign var='value_text' value=$valueFieldPost['shop_name'][$id_lang_default]}
                                            {/if}
                                            <input class="form-control" name="shop_name_{$id_lang_default|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
                                        {/if}
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label required"> {l s='Shop description' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        {if $languages && count($languages)>1}
                                            <div class="form-group row">
                                                {foreach from=$languages item='language'}
                                                    <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                                        <div class="col-lg-10">
                                                            {if isset($valueFieldPost)}
                                                                {assign var='value_text' value=$valueFieldPost['shop_description'][$language.id_lang]}
                                                            {/if}
                                                            <textarea class="form-control" name="shop_description_{$language.id_lang|intval}">{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}</textarea>
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="toggle_form">
                                                            <button class="btn btn-default dropdown-toggle" type="button" tabindex="-1" data-toggle="dropdown">
                                                            {$language.iso_code|escape:'html':'UTF-8'}
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                {foreach from=$languages item='lang'}
                                                                    <li>
                                                                        <a class="hideOtherLanguage" href="#" tabindex="-1" data-id-lang="{$lang.id_lang|intval}">{$lang.name|escape:'html':'UTF-8'}</a>
                                                                    </li>
                                                                {/foreach}
                                                            </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {else}
                                            {if isset($valueFieldPost)}
                                                {assign var='value_text' value=$valueFieldPost['shop_description'][$id_lang_default]}
                                            {/if}
                                            <textarea class="form-control" name="shop_description_{$id_lang_default|intval}">{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}</textarea>
                                        {/if}
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label required"> {l s='Shop address' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        {if $languages && count($languages)>1}
                                            <div class="form-group row">
                                                {foreach from=$languages item='language'}
                                                    <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                                        <div class="col-lg-10">
                                                            {if isset($valueFieldPost)}
                                                                {assign var='value_text' value=$valueFieldPost['shop_address'][$language.id_lang]}
                                                            {/if}
                                                            <input{if $language.id_lang==$id_lang_default} id="search_shop_address"{/if} type="text" class="form-control" name="shop_address_{$language.id_lang|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}" />
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="toggle_form">
                                                            <button class="btn btn-default dropdown-toggle" type="button" tabindex="-1" data-toggle="dropdown">
                                                            {$language.iso_code|escape:'html':'UTF-8'}
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                {foreach from=$languages item='lang'}
                                                                    <li>
                                                                        <a class="hideOtherLanguage" href="#" tabindex="-1" data-id-lang="{$lang.id_lang|intval}">{$lang.name|escape:'html':'UTF-8'}</a>
                                                                    </li>
                                                                {/foreach}
                                                            </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {else}
                                            {if isset($valueFieldPost)}
                                                {assign var='value_text' value=$valueFieldPost['shop_address'][$id_lang_default]}
                                            {/if}
                                            <input id="search_shop_address" type="text" class="form-control shop_address" name="shop_address_{$id_lang_default|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}" />
                                        {/if}

                                    </div>
                                </div>
                                {if isset($ETS_MP_ENABLE_MAP) && $ETS_MP_ENABLE_MAP}
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label"> {l s='Latitude' mod='ets_marketplace'} </label>
                                        <div class="col-md-9">
                                            <input class="form-control" id="latitude" name="latitude" value="{if isset($smarty.post.latitude)}{$smarty.post.latitude|escape:'html':'UTF-8'}{else}{if $seller && $seller->latitude!=0}{$seller->latitude|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label"> {l s='Longitude' mod='ets_marketplace'} </label>
                                        <div class="col-md-9">
                                            <input class="form-control" id="longitude" name="longitude" value="{if isset($smarty.post.longitude)}{$smarty.post.longitude|escape:'html':'UTF-8'}{else}{if $seller && $seller->longitude!=0}{$seller->longitude|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                        </div>
                                    </div>
                                {/if}
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label required"> {l s='Shop phone number' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="shop_phone" value="{if isset($smarty.post.shop_phone)}{$smarty.post.shop_phone|escape:'html':'UTF-8'}{else}{if $seller}{$seller->shop_phone|escape:'html':'UTF-8'}{else}{$number_phone|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label"> {l s='VAT number' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number|escape:'html':'UTF-8'}{else}{if $seller}{$seller->vat_number|escape:'html':'UTF-8'}{else}{$vat_number|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                    </div>
                                </div>
                                <div class="form-group row shop-logo">
                                    <label class="col-md-3 form-control-label required"> {l s='Shop logo' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        {if $seller && $seller->shop_logo}
                                            <div class="shop_logo">
                                            <img class="ets_mp_shop_logo" src="{$link_base|escape:'html':'UTF-8'}/img/mp_seller/{$seller->shop_logo|escape:'html':'UTF-8'}" width="80px" />
                                            </div>
                                        {/if}
                                        <div class="ets_upload_file_custom">
                                            <input class="form-control custom-file-input" name="shop_logo" type="file" id="shop_logo" />
                                            <label class="custom-file-label" for="shop_logo" data-browser="{l s='Browse' mod='ets_marketplace'}">
                                               {l s='Choose a file' mod='ets_marketplace'}
                                            </label>
                                        </div>
                                        <div class="desc">{l s='Recommended size: 250x250 px. Accepted formats: jpg, png, gif' mod='ets_marketplace'}. {l s='Limit:' mod='ets_marketplace'}&nbsp;{Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')|escape:'html':'UTF-8'}Mb</div>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label class="col-md-3 form-control-label"> {l s='Shop banner' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        {if $languages && count($languages)>1}
                                            <div class="form-group row">
                                                {foreach from=$languages item='language'}
                                                    <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                                        <div class="col-lg-10">
                                                            {assign var='shop_banners' value=$seller->shop_banner}
                                                            {if $seller && isset($shop_banners[$language.id_lang]) &&  $shop_banners[$language.id_lang]}
                                                                <div class="shop_logo logo_banner_shop">
                                                                    <img class="ets_mp_shop_logo" src="{$link_base|escape:'html':'UTF-8'}/img/mp_seller/{$shop_banners[$language.id_lang]|escape:'html':'UTF-8'}" width="150px" />
                                                                    <a class="btn btn-default" href="{$link->getModuleLink('ets_marketplace','profile',['deletebanner'=>1,'banner_lang'=>$language.id_lang])|escape:'html':'UTF-8'}" onclick="return confirm('{l s='Do you want to delete this banner?' mod='ets_marketplace' js='1'}');"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg></a>
                                                                </div>
                                                            {/if}
                                                            <div class="ets_upload_file_custom">
                                                                <input class="form-control shop_banner custom-file-input" name="shop_banner_{$language.id_lang|intval}" type="file" id="shop_banner_{$language.id_lang|intval}" />
                                                                <label class="custom-file-label" for="shop_banner_{$language.id_lang|intval}" data-browser="{l s='Browse' mod='ets_marketplace'}">
                                                                    {l s='Choose a file' mod='ets_marketplace'}
                                                                </label>
                                                            </div>
                                                            <div class="desc">{l s='Recommended size: 1170x170 px. Accepted formats: jpg, png, gif' mod='ets_marketplace'}. {l s='Limit:' mod='ets_marketplace'}&nbsp;{Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')|escape:'html':'UTF-8'}Mb</div>
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="toggle_form">
                                                            <button class="btn btn-default dropdown-toggle" type="button" tabindex="-1" data-toggle="dropdown">
                                                            {$language.iso_code|escape:'html':'UTF-8'}
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                {foreach from=$languages item='lang'}
                                                                    <li>
                                                                        <a class="hideOtherLanguage" href="#" tabindex="-1" data-id-lang="{$lang.id_lang|intval}">{$lang.name|escape:'html':'UTF-8'}</a>
                                                                    </li>
                                                                {/foreach}
                                                            </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {else}
                                            {assign var='shop_banners' value=$seller->shop_banner}
                                            {if $seller && isset($shop_banners[$id_lang_default]) && $shop_banners[$id_lang_default] }
                                                <div class="shop_logo logo_banner_shop">
                                                    <img class="ets_mp_shop_logo" src="{$link_base|escape:'html':'UTF-8'}/img/mp_seller/{$shop_banners[$id_lang_default]|escape:'html':'UTF-8'}" width="150px" />
                                                    <a class="btn btn-default" href="{$link->getModuleLink('ets_marketplace','profile',['deletebanner'=>1,'banner_lang'=>$id_lang_default])|escape:'html':'UTF-8'}" onclick="return confirm('{l s='Do you want to delete this banner?' mod='ets_marketplace' js='1'}');"><svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg></a>
                                                </div>
                                            {/if}
                                            <div class="ets_upload_file_custom">
                                                <input class="form-control shop_banner custom-file-input" name="shop_banner_{$id_lang_default|intval}" type="file" id="shop_banner_{$id_lang_default|intval}" />
                                                <label class="custom-file-label" for="shop_banner_{$id_lang_default|intval}" data-browser="{l s='Browse' mod='ets_marketplace'}">
                                                   {l s='Choose a file' mod='ets_marketplace'}
                                                </label>
                                            </div>
                                            <div class="desc">{l s='Taille préconisée :1920x300px. Mais la hauteur est libre (toutefois, merci de ne pas dépasser 500px de haut). Formats acceptés:jpg uniquement en 72dpi. Votre image doit être en RVB.' mod='ets_marketplace'}. {l s='Limit:' mod='ets_marketplace'}&nbsp;{Configuration::get('PS_ATTACHMENT_MAXIMUM_SIZE')|escape:'html':'UTF-8'}Mb</div>
                                        {/if}
                                    </div>
                                </div>
                                <div class="form-group row hide">
                                    <label class="col-md-3 form-control-label"> {l s='Banner URL' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        {if $languages && count($languages)>1}
                                            <div class="form-group row">
                                                {foreach from=$languages item='language'}
                                                    <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                                        <div class="col-lg-10">
                                                            {if isset($valueFieldPost)}
                                                                {assign var='value_text' value=$valueFieldPost['banner_url'][$language.id_lang]}
                                                            {/if}
                                                            <input class="form-control" name="banner_url_{$language.id_lang|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
                                                        </div>
                                                        <div class="col-lg-2">
                                                            <div class="toggle_form">
                                                            <button class="btn btn-default dropdown-toggle" type="button" tabindex="-1" data-toggle="dropdown">
                                                            {$language.iso_code|escape:'html':'UTF-8'}
                                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1408 704q0 26-19 45l-448 448q-19 19-45 19t-45-19l-448-448q-19-19-19-45t19-45 45-19h896q26 0 45 19t19 45z"/></svg>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                {foreach from=$languages item='lang'}
                                                                    <li>
                                                                        <a class="hideOtherLanguage" href="#" tabindex="-1" data-id-lang="{$lang.id_lang|intval}">{$lang.name|escape:'html':'UTF-8'}</a>
                                                                    </li>
                                                                {/foreach}
                                                            </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {else}
                                            {if isset($valueFieldPost)}
                                                {assign var='value_text' value=$valueFieldPost['banner_url'][$id_lang_default]}
                                            {/if}
                                            <input class="form-control" name="banner_url_{$id_lang_default|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
                                        {/if}
                                    </div>
                                </div>
                                <div class="form-group row hide">
                                    <label class="col-md-3 form-control-label"> {l s='Facebook link' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="link_facebook" value="{if isset($smarty.post.link_facebook)}{$smarty.post.link_facebook|escape:'html':'UTF-8'}{else}{if $seller}{$seller->link_facebook|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                    </div>
                                </div>
                                <div class="form-group row hide">
                                    <label class="col-md-3 form-control-label"> {l s='Instagram link' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="link_instagram" value="{if isset($smarty.post.link_instagram)}{$smarty.post.link_instagram|escape:'html':'UTF-8'}{else}{if $seller}{$seller->link_instagram|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                    </div>
                                </div>
                                <div class="form-group row hide">
                                    <label class="col-md-3 form-control-label"> {l s='Google link' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="link_google" value="{if isset($smarty.post.link_google)}{$smarty.post.link_google|escape:'html':'UTF-8'}{else}{if $seller}{$seller->link_google|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                    </div>
                                </div>
                                <div class="form-group row hide">
                                    <label class="col-md-3 form-control-label"> {l s='Twitter link' mod='ets_marketplace'} </label>
                                    <div class="col-md-9">
                                        <input class="form-control" name="link_twitter" value="{if isset($smarty.post.link_twitter)}{$smarty.post.link_twitter|escape:'html':'UTF-8'}{else}{if $seller}{$seller->link_twitter|escape:'html':'UTF-8'}{/if}{/if}"  type="text" />
                                    </div>
                                </div>
                                {if $shop_categories}
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label"> {l s='Shop category' mod='ets_marketplace'} </label>
                                        <div class="col-md-9">
                                            <select class="form-control" name="id_shop_category">
                                                <option value="">--{l s='Choose shop category' mod='ets_marketplace'}--</option>
                                                {foreach from=$shop_categories item='shop_category'}
                                                    <option value="{$shop_category.id_ets_mp_shop_category|intval}" {if isset($smarty.post.id_shop_category)}{if $smarty.post.id_shop_category==$shop_category.id_ets_mp_shop_category} selected="selected"{/if}{else}{if $seller && $seller->id_shop_category==$shop_category.id_ets_mp_shop_category} selected="selected"{/if}{/if}>{$shop_category.name|escape:'html':'UTF-8'}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                {/if}
                                <div class="form-group row">
                                    <div class="col-md-3"> </div>
                                    <div class="col-md-9">
                                        <input name="submitSaveSeller" value="1" type="hidden" />
                                        <button class="btn btn-primary form-control-submit float-xs-right" type="submit">
                                            <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M512 1536h768v-384h-768v384zm896 0h128v-896q0-14-10-38.5t-20-34.5l-281-281q-10-10-34-20t-39-10v416q0 40-28 68t-68 28h-576q-40 0-68-28t-28-68v-416h-128v1280h128v-416q0-40 28-68t68-28h832q40 0 68 28t28 68v416zm-384-928v-320q0-13-9.5-22.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 22.5v320q0 13 9.5 22.5t22.5 9.5h192q13 0 22.5-9.5t9.5-22.5zm640 32v928q0 40-28 68t-68 28h-1344q-40 0-68-28t-28-68v-1344q0-40 28-68t68-28h928q40 0 88 20t76 48l280 280q28 28 48 76t20 88z"/></svg> {l s='Save' mod='ets_marketplace'}
                                        </button>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </section>
               </form>
            </section>
        </div>
    </div>
</div>
