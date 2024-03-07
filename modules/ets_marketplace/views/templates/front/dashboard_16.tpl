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
    {if $going_to_be_expired}
        <div class="ets_alert col-xs-12 col-sm-12 col-md-12">
            <div class="alert alert-info">
                <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                {if $seller->payment_verify==1}
                    {$ETS_MP_MESSAGE_CONFIRMED_PAYMENT nofilter}
                {else}
                    {$ETS_MP_MESSAGE_SELLER_GOING_TOBE_EXPIRED nofilter}
                {/if}
                {if $seller->payment_verify==-1}
                    <br/>
                    <button type="button" class="btn btn-primary i_have_just_sent_the_fee">{l s='I have just sent the fee' mod='ets_marketplace'}</button>
                {/if}
            </div>
        </div>
    {/if}
    <div class="ets_mp_content_left col-lg-3" >
        {Module::getInstanceByName('ets_marketplace')->hookDisplayMPLeftContent() nofilter}
    </div>
    <div class="ets_mp_content_left col-lg-9" >
        {$html_content nofilter}
    </div>
</div>
{Module::getInstanceByName('ets_marketplace')->hookDisplayETSMPFooterYourAccount() nofilter}