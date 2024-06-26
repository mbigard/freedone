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
    <div class="ets_mp_content_left col-lg-3" >
        {Module::getInstanceByName('ets_marketplace')->hookDisplayMPLeftContent() nofilter}
    </div>
    <div class="ets_mp_content_left col-lg-9" >
        <div class="panel">
            <div class="row">
                <div class="col-md-12">
                    <p class="mb-25">{l s='Select one of available payment methods below to submit your money withdrawal request' mod='ets_marketplace'}</p>
                </div>
            </div>
            <div class="row mb-40">
                <div class="col-md-8">
                    <div class="table-responsive">
                        <table class="ets_mp-table-data table table-striped mb-50">
                            <thead>
                                <tr>
                                    <th>{l s='Logo' mod='ets_marketplace'}</th>
                                    <th>{l s='Method' mod='ets_marketplace'}</th>
                                    <th>{l s='Description' mod='ets_marketplace'}</th>
                                    <th>{l s='Estimate processing time' mod='ets_marketplace'}</th>
                                    <th>{l s='Fee' mod='ets_marketplace'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {if $payments}
                                    {foreach from=$payments item='payment'}
                                        <tr>
                                            <td>
                                                {if $payment.logo}
                                                    <a href="{$payment.link|escape:'html':'UTF-8'}"><img src="{$link->getMediaLink("`$smarty.const.__PS_BASE_URI__`img/mp_payment/`$payment.logo|escape:'htmlall':'UTF-8'`")}" width="40px" /></a>
                                                {/if}
                                            </td>
                                            <td>
                                                <a href="{$payment.link|escape:'html':'UTF-8'}">{$payment.title|escape:'html':'UTF-8'} </a>
                                            </td>
                                            <td>
                                                {$payment.description|strip_tags:'UTF-8'|truncate:80:'...' nofilter}
                                            </td>
                                            <td>
                                                {if $payment.estimated_processing_time}
                                                    {$payment.estimated_processing_time|intval} {l s='day(s)' mod='ets_marketplace'}
                                                {else}
                                                    --
                                                {/if}
                                            </td>
                                            <td>
                                                {if $payment.fee_type!='NO_FEE'}
                                                    {if $payment.fee_type=='FIXED'}
                                                        {$payment.fee_fixed|escape:'html':'UTF-8'}
                                                    {else}
                                                        {$payment.fee_percent|floatval}%
                                                    {/if}
                                                {else}
                                                    {l s='Free' mod='ets_marketplace'}
                                                {/if}
                                            </td>
                                        </tr>
                                    {/foreach}
                                {/if}
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="table-responsive">
                        <table class="table ets_mp-table-data table-striped">
                            <thead>
                                <tr>
                                    <th>{l s='Available balance for withdrawal' mod='ets_marketplace'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="fs-18 fw-b">
                                        {$total_commission|escape:'html':'UTF-8'}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h4 class="ets_mp-withdraw text-uppercase fs-14 mb-20">{l s='Your last withdrawal requests' mod='ets_marketplace'}</h4>
                    {if $ets_mp_success_message}
                        <div class="alert alert-success">
                            <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1412 734q0-28-18-46l-91-90q-19-19-45-19t-45 19l-408 407-226-226q-19-19-45-19t-45 19l-91 90q-18 18-18 46 0 27 18 45l362 362q19 19 45 19 27 0 46-19l543-543q18-18 18-45zm252 162q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                            {$ets_mp_success_message|escape:'html':'UTF-8'}
                        </div>
                    {/if}
                    <div class="table-response table-responsive">
                        <table class="table eam-table-flat table-label-custom">
                            <thead>
                                <tr>
                                    <th class="text-center">{l s='Withdrawal ID' mod='ets_marketplace'}</th>
                                    <th class="text-center">{l s='Amount' mod='ets_marketplace'}</th>
                                    <th class="text-center">{l s='Payment method' mod='ets_marketplace'}</th>
                                    <th class="text-center">{l s='Status' mod='ets_marketplace'}</th>
                                    <th class="text-center">{l s='Processed date' mod='ets_marketplace'}</th>
                                    <th class="text-center">{l s='Description' mod='ets_marketplace'}</th>
                                </tr>
                            </thead>
                            <tbody>
                                {if $withdraws}
                                    {foreach from=$withdraws item='withdraw'}
                                        <tr>
                                            <td class="text-center">{$withdraw.id_ets_mp_withdrawal|intval}</td>
                                            <td class="text-center">{Tools::displayPrice($withdraw.amount,$currency_default)|escape:'html':'UTF-8'}</td>
                                            <td class="text-center">{$withdraw.method_name|escape:'html':'UTF-8'}</td>
                                            <td class="text-center status">
                                                {if $withdraw.status==0}
                                                    <span class="ets_mp_status pending">{l s='Pending' mod='ets_marketplace'}</span>
                                                {/if}
                                                {if $withdraw.status==1}
                                                    <span class="ets_mp_status approved">{l s='Approved' mod='ets_marketplace'}</span>
                                                {/if}
                                                {if $withdraw.status==-1}
                                                    <span class="ets_mp_status declined">{l s='Declined' mod='ets_marketplace'}</span>
                                                {/if}
                                            </td>
                                            <td class="text-center">
                                                {dateFormat date=$withdraw.processing_date full=1}{if $withdraw.status==0}{l s='(estimated)' mod='ets_marketplace'}{/if}
                                            </td>
                                            <td class="text-center">
                                                {$withdraw.note|escape:'html':'UTF-8'}
                                            </td>
                                        </tr>
                                    {/foreach}
                                {else}
                                    <tr class="text-center">
                                        <td colspan="100%">
                                            {l s='No data' mod='ets_marketplace'}
                                        </td>
                                    </tr>
                                {/if}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>