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

<!-- Information relative au transport -->
<div class="row">
    <div class="col-md-12">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 pb-1 warning-top">
                  <p>Après une commande validée, vous recevrez <b>sous 24h</b> un email de confirmation contenant <b>l'étiquette de transport</b>. Il vous suffit ensuite d'emballer soigneusement vos articles à envoyer et de coller le bordereaux sur l'emballage. Pour réaliser l'envoi de votre colis, il ne vous reste plus qu'à <b>trouver le Point Relais®| Locker</b> le plus proche de chez vous où déposer votre colis. <a href="https://www.mondialrelay.fr/trouver-le-point-relais-le-plus-proche-de-chez-moi/" class="btn shipper-link" target="_blank">en cliquant ici.</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- Information relative au transport -->

<div class="row">
    <div class="col-md-12">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12 pb-1">
                    <h2>{l s='Package dimension' mod='ets_marketplace'}</h2>
                    <p class="subtitle" style="margin-bottom: 5px;">{l s='Charge additional shipping costs based on packet dimensions covered here.' mod='ets_marketplace'}</p>
                    <div class="row">
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label class="form-control-label no_bold">{l s='Width' mod='ets_marketplace'}</label>
                                <div class="input-group">
                                    <div class="input-group-append">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                    <input id="width" class="form-control" name="width" value="{if isset($valueFieldPost['width']) && $valueFieldPost['width']!=0}{$valueFieldPost['width']|floatval}{/if}" type="text" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label class="form-control-label no_bold">{l s='Height' mod='ets_marketplace'}</label>
                                <div class="input-group">
                                    <div class="input-group-append">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                    <input id="height" class="form-control" name="height" value="{if isset($valueFieldPost['height']) && $valueFieldPost['height']!=0}{$valueFieldPost['height']|floatval}{/if}" type="text" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label class="form-control-label no_bold">{l s='Depth' mod='ets_marketplace'}</label>
                                <div class="input-group">
                                    <div class="input-group-append">
                                        <span class="input-group-text">cm</span>
                                    </div>
                                    <input id="depth" class="form-control" name="depth" value="{if isset($valueFieldPost['depth']) && $valueFieldPost['depth']!=0}{$valueFieldPost['depth']|floatval}{/if}" type="text" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3">
                            <div class="form-group">
                                <label class="form-control-label no_bold">{l s='Weight' mod='ets_marketplace'}</label>
                                <div class="input-group">
                                    <div class="input-group-append">
                                        <span class="input-group-text">kg</span>
                                    </div>
                                    <input id="weight" class="form-control" name="weight" value="{if isset($valueFieldPost['weight']) && $valueFieldPost['weight']!=0}{$valueFieldPost['weight']|floatval}{/if}" type="text" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                {if $is17}
                    <div class="col-md-12">
                        <div class="form-group" style="margin-bottom: 5px;">
                            <h2>
                                {l s='Delivery Time' mod='ets_marketplace'}
                                <span class="help-box">
                                    <span>
                                        {l s='Display delivery time for a product is advised for merchants selling in Europe to comply with the local laws.' mod='ets_marketplace'}
                                    </span>
                                </span>
                            </h2>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="radio">
                                        <label for="additional_delivery_times_0">
                                            <input id="additional_delivery_times_0" name="additional_delivery_times" value="0" type="radio"{if $product_class->additional_delivery_times==0 && $product_class->id} checked="checked"{/if} />
                                            {l s='None' mod='ets_marketplace'}
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label for="additional_delivery_times_1">
                                            <input id="additional_delivery_times_1" name="additional_delivery_times" value="1" type="radio"{if $product_class->additional_delivery_times==1} checked="checked"{/if} />
                                            {l s='Default delivery time' mod='ets_marketplace'}
                                        </label>
                                    </div>
                                    <div class="radio">
                                        <label for="additional_delivery_times_2">
                                            <input id="additional_delivery_times_2" name="additional_delivery_times" value="2" type="radio"{if $product_class->additional_delivery_times==2 || !$product_class->id} checked="checked"{/if} />
                                            {l s='Specify delivery time to this product' mod='ets_marketplace'}
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12 pb-1">
                        <div class="row">
                            <div class="col-lg-5">
                                <div class="form-group">
                                    <label class="px-0 control-label">
                                        {l s='Delivery time of in-stock products:' mod='ets_marketplace'}
                                    </label>
                                    {if $languages && count($languages)>1}
                                        <div class="form-group row">
                                            {foreach from=$languages item='language'}
                                                <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                                    <div class="col-lg-10">
                                                        {if isset($valueFieldPost)}
                                                            {assign var='value_text' value=$valueFieldPost['delivery_in_stock'][$language.id_lang]}
                                                        {/if}
                                                        <input placeholder="{l s='Delivered within 3-4 days' mod='ets_marketplace'}" class="form-control" name="delivery_in_stock_{$language.id_lang|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
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
                                            {assign var='value_text' value=$valueFieldPost['delivery_in_stock'][$id_lang_default]}
                                        {/if}
                                        <input placeholder="{l s='Delivered within 3-4 days' mod='ets_marketplace'}" class="form-control" name="delivery_in_stock_{$id_lang_default|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
                                    {/if}
                                    <span class="help-block">{l s='Leave empty to disable.' mod='ets_marketplace'}
                                </div>
                            </div>
                            <div class="col-lg-7">
                                <div class="form-group">
                                    <label class="px-0 control-label">
                                        {l s='Delivery time of out-of-stock products with allowed orders:' mod='ets_marketplace'}
                                    </label>
                                    {if $languages && count($languages)>1}
                                        <div class="form-group row">
                                            {foreach from=$languages item='language'}
                                                <div class="translatable-field lang-{$language.id_lang|intval}" {if $language.id_lang!=$id_lang_default} style="display:none;"{/if}>
                                                    <div class="col-lg-10">
                                                        {if isset($valueFieldPost)}
                                                            {assign var='value_text' value=$valueFieldPost['delivery_out_stock'][$language.id_lang]}
                                                        {/if}
                                                        <input placeholder="{l s='Delivered within 5-6 days' mod='ets_marketplace'}" class="form-control" name="delivery_out_stock_{$language.id_lang|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
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
                                            {assign var='value_text' value=$valueFieldPost['delivery_out_stock'][$id_lang_default]}
                                        {/if}
                                        <input placeholder="{l s='Delivered within 5-6 days' mod='ets_marketplace'}" class="form-control" name="delivery_out_stock_{$id_lang_default|intval}" value="{if isset($value_text)}{$value_text|escape:'html':'UTF-8'}{/if}"  type="text" />
                                    {/if}
                                    <span class="help-block">{l s='Leave empty to disable.' mod='ets_marketplace'}
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}
                <div class="col-md-12 pb-1">
                    <div class="form-group">
                        <h2>
                            {l s='Shipping fees' mod='ets_marketplace'}
                            <span class="help-box">
                                <span>{l s='If a carrier has a tax, it will be added to the shipping fees. Does not apply to free shipping.' mod='ets_marketplace'}</span>
                            </span>
                        </h2>
                        <p style="margin: 0 0 5px;">{l s='Does this product incur additional shipping costs?' mod='ets_marketplace'}</p>
                        <div class="row">
                            <div class="col-md-2">
                                <div class="input-group money-type">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text">{$default_currency->sign|escape:'html':'UTF-8'} </span>
                                    </div>
                                    <input id="additional_shipping_cost" class="form-control" name="additional_shipping_cost" value="{if $product_class->additional_shipping_cost!=0}{$product_class->additional_shipping_cost|floatval}{/if}" type="text" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="form-group">
                        <h2 class="">{l s='Available carriers' mod='ets_marketplace'}</h2>
                        <div id="selectedCarriers">
                            {if $carriers}
                                {foreach $carriers item='carrier'}
                                    <div class="checkbox">
                                        <label class="">
                                            <div class="ets_input_group">
                                                <input id="selectedCarriers_{$carrier.id_reference|intval}" name="selectedCarriers[]" value="{$carrier.id_reference|intval}" type="checkbox" {if in_array($carrier.id_reference,$selected_carriers)} checked="checked"{/if}/>
                                                <div class="ets_input_check"></div>
                                            </div>
                                            {$carrier.name|escape:'html':'UTF-8'}{if $carrier.delay} ({$carrier.delay|escape:'html':'UTF-8'}){/if}
                                        </label>
                                    </div>
                                {/foreach}
                            {/if}

                        </div>
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="alert alert-warning" role="alert">
                        <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg>
                        <p class="alert-text"> {l s='If no carrier is selected then all the carriers will be available for customers orders.' mod='ets_marketplace'} </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
