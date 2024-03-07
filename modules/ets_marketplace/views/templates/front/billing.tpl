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
{extends file="page.tpl"}
{block name="content"}
    <div class="row">
        <div class="ets_mp_content_left col-lg-3" >
            {Module::getInstanceByName('ets_marketplace')->hookDisplayMPLeftContent() nofilter}
        </div>
        <div class="ets_mp_content_left col-lg-9" >
            <div class="ets_mp_popup ets_mp_billing_popup" style="display:none;">
                <div class="mp_pop_table">
                    <div class="mp_pop_table_cell">
                        
                        <form id="ets_mp_billing_form" action="" method="post" enctype="multipart/form-data">
                        <div class="ets_mp_close_popup" title="{l s='Close' mod='ets_marketplace'}">{l s='Close' mod='ets_marketplace'}</div>
                            <div id="fieldset_0" class="panel">
                                <div class="panel-heading">
                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg>
                                    {l s='Contact marketplace' mod='ets_marketplace'}
                                </div>
                                <div class="form-wrapper">
                                    <div class="row form-group">
                                        <label class="col-lg-3 form-control-label required" for="biling_contact_subject">{l s='Subject' mod='ets_marketplace'}</label>
                                        <div class="col-lg-9">
                                            <input id="biling_contact_subject" class="form-control" name="biling_contact_subject" value="" type="text" />
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-lg-3 form-control-label required" for="biling_contact_message">{l s='Message' mod='ets_marketplace'}</label>
                                        <div class="col-lg-9">
                                            <textarea id="biling_contact_message" class="form-control" name="biling_contact_message"></textarea>
                                        </div>
                                    </div>
                                    <div class="row form-group">
                                        <label class="col-lg-3 form-control-label" for="biling_contact_paid_invoice">{l s='Have you paid this invoice?' mod='ets_marketplace'}</label>
                                         <div class="col-lg-9">
                                            <span class="switch prestashop-switch fixed-width-lg">
                                    			<input name="biling_contact_paid_invoice" id="biling_contact_paid_invoice_on" value="1" type="radio" />
                                    			<label for="biling_contact_paid_invoice_on" class="radioCheck">
                                    				<i class="color_success"></i> {l s='Yes' mod='ets_marketplace'}
                                    			</label>
                                    			<input name="biling_contact_paid_invoice" id="biling_contact_paid_invoice_off" value="0" checked="checked" type="radio" />
                                    			<label for="biling_contact_paid_invoice_off" class="radioCheck">
                                    				<i class="color_danger"></i> {l s='No' mod='ets_marketplace'}
                                    			</label>
                                    			<a class="slide-button btn"></a>
                                    		</span>
                                         </div>
                                    </div>
                                </div>
                                <div class="panel-footer">
                                    
                                    <input name="submitContactMarketplace" value="1" type="hidden" />
                                    <input name="id_billing_contact" value="0" type="hidden" id="id_billing_contact" />
                                    <button class="btn btn-primary form-control-submit float-xs-left" name="cancelContactMarketplace">{l s='Cancel' mod='ets_marketplace'}</button>
                                    <button class="btn btn-primary form-control-submit float-xs-right" name="submitContactMarketplace" type="submit">{l s='Send' mod='ets_marketplace'}</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            {$html_content nofilter}
        </div>
    </div>
    {Module::getInstanceByName('ets_marketplace')->hookDisplayETSMPFooterYourAccount() nofilter}
{/block}