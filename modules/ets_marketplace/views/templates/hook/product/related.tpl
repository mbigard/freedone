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
<label class="col-lg-3 form-control-label" for="">{l s='Related product' mod='ets_marketplace'}</label>
<div class="col-lg-9">
    <div id="related-content" class="row{if !$related_products} hide{/if}">
        <div class="col-xl-8 col-lg-10">
            <fieldset class="form-group">
                <div class="autocomplete-search">
                    <div class="search search-with-icon">
                        <span class="twitter-typeahead" style="position: relative; display: block;">
                            <input id="form_step1_related_products" class="form-control search typeahead form_step1_related_products tt-input" placeholder="{l s='Search and add a related product' mod='ets_marketplace'}" autocomplete="off" spellcheck="false" dir="auto" style="position: relative; vertical-align: top;" type="text" />
                        </span>
                    </div>
                </div>
            </fieldset>
            <small class="form-text text-muted text-right typeahead-hint"> </small>
            <ul id="form_step1_related_products-data" class="typeahead-list nostyle col-sm-12 product-list">
                {if $related_products}
                    {foreach from=$related_products item='related_product'}
                        <li class="media">
                            <div class="media-left">
                                {if isset($related_product.img) && $related_product.img}
                                    <img class="media-object image" src="{$related_product.img|escape:'html':'UTF-8'}" />
                                {/if}
                            </div>
                            <div class="media-body media-middle">
                                <span class="label">{$related_product.name|escape:'html':'UTF-8'}{if $related_product.reference} (ref:{$related_product.reference|escape:'html':'UTF-8'}){/if}</span>
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1490 1322q0 40-28 68l-136 136q-28 28-68 28t-68-28l-294-294-294 294q-28 28-68 28t-68-28l-136-136q-28-28-28-68t28-68l294-294-294-294q-28-28-28-68t28-68l136-136q28-28 68-28t68 28l294 294 294-294q28-28 68-28t68 28l136 136q28 28 28 68t-28 68l-294 294 294 294q28 28 28 68z"/></svg>
                            </div>
                            <input name="related_products[]" value="{$related_product.id_product|intval}" type="hidden" />
                        </li>
                    {/foreach}
                {/if}
            </ul>
            <div id="tplcollection-form_step1_related_products" class="invisible">
                <span class="label">%s</span>
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 736v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm256 0v576q0 14-9 23t-23 9h-64q-14 0-23-9t-9-23v-576q0-14 9-23t23-9h64q14 0 23 9t9 23zm128 724v-948h-896v948q0 22 7 40.5t14.5 27 10.5 8.5h832q3 0 10.5-8.5t14.5-27 7-40.5zm-672-1076h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
            </div>
        </div>
        <div class="col-md-2">
            <fieldset class="form-group">
                <a id="reset_related_product" class="btn tooltip-link delete pl-0 pr-0">
                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1376v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm256 0v-704q0-14-9-23t-23-9h-64q-14 0-23 9t-9 23v704q0 14 9 23t23 9h64q14 0 23-9t9-23zm-544-992h448l-48-117q-7-9-17-11h-317q-10 2-17 11zm928 32v64q0 14-9 23t-23 9h-96v948q0 83-47 143.5t-113 60.5h-832q-66 0-113-58.5t-47-141.5v-952h-96q-14 0-23-9t-9-23v-64q0-14 9-23t23-9h309l70-167q15-37 54-63t79-26h320q40 0 79 26t54 63l70 167h309q14 0 23 9t9 23z"/></svg>
                </a>
            </fieldset>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4">
            <button id="add-related-product-button" class="btn btn-outline-primary" type="button"{if $related_products} style="display:none;"{/if} >
                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1344 960v-128q0-26-19-45t-45-19h-256v-256q0-26-19-45t-45-19h-128q-26 0-45 19t-19 45v256h-256q-26 0-45 19t-19 45v128q0 26 19 45t45 19h256v256q0 26 19 45t45 19h128q26 0 45-19t19-45v-256h256q26 0 45-19t19-45zm320-64q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                {l s='Add a related product' mod='ets_marketplace'}
            </button>
        </div>
    </div>
</div>