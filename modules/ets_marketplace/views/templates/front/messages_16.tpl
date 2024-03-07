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
        {$html_content nofilter}
    </div>
</div>
{Module::getInstanceByName('ets_marketplace')->hookDisplayETSMPFooterYourAccount() nofilter}