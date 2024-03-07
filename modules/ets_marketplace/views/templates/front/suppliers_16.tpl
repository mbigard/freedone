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
    {if $_errors}
        <div class="ets_alert col-xs-12 col-sm-12 col-md-12">{$_errors nofilter}</div>
    {/if}
    {if $_success}
        <div class="ets_alert col-xs-12 col-sm-12 col-md-12">{$_success nofilter}</div>
    {/if}
    <div class="ets_mp_content_left col-lg-3" >
        {Module::getInstanceByName('ets_marketplace')->hookDisplayMPLeftContent() nofilter}
    </div>
    <div class="ets_mp_content_left col-lg-9" >
            {if (isset($display_form) && $display_form) || !($ETS_MP_SELLER_CREATE_SUPPLIER && $ETS_MP_SELLER_USER_GLOBAL_SUPPLIER)}
                {$html_content nofilter}
            {else}
                <div class="panel ets_mp-panel">
                    <div class="ets_mp_brand_type">
                        <div class="panel-heading">{l s='Suppliers' mod='ets_marketplace'}</div>
                        <div class="form-group row">
                            <label class="control-label col-md-3">{l s='Using suppliers' mod='ets_marketplace'}</label>
                            <div class="col-md-9">
                                <ul class="radio-inputs">
                                    <li><label for="user_supplier_1"><input type="radio" name="user_supplier" value="1" id="user_supplier_1"{if $ets_seller->user_supplier==1} checked="checked"{/if} /> {l s='Use the store\'s global suppliers' mod='ets_marketplace'}</label></li>
                                    <li><label for="user_supplier_2"><input type="radio" name="user_supplier" value="2" id="user_supplier_2"{if $ets_seller->user_supplier==2} checked="checked"{/if}/> {l s='Create your own suppliers' mod='ets_marketplace'}</label></li>
                                    <li><label for="user_supplier_3"><input type="radio" name="user_supplier" value="3" id="user_supplier_3"{if $ets_seller->user_supplier==3} checked="checked"{/if}/> {l s='Use both store\'s global suppliers and your own suppliers' mod='ets_marketplace'}</label></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="ets_mp_brand_content">
                        {$html_content nofilter}
                    </div>
                </div>
            {/if}
        </div>
</div>
{Module::getInstanceByName('ets_marketplace')->hookDisplayETSMPFooterYourAccount() nofilter}