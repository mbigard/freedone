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
<form id="ets_mp_manufacturer_group_form" action="" method="post" enctype="multipart/form-data">
     <div id="fieldset_0" class="panel">
         <div class="panel-heading">
             <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"/></svg>
            {$manufacturer->name|escape:'html':'UTF-8'} > {l s='Address' mod='ets_marketplace'}
         </div>
         <div class="form-wrapper">
            {$html_form nofilter}
         </div>
         <div class="panel-footer">
            <input type="hidden" name="submitSaveAddressManufacturer" value="1"/>
            <input type="hidden" name="id_manufacturer" value="{$id_manufacturer|intval}" />
            <input type="hidden" name="id_address" value="{$id_address|intval}" />
            <a class="btn btn-secondary bd from-control-submit float-xs-left" href="{$link_cancel|escape:'html':'UTF-8'}">{l s='Cancel' mod='ets_marketplace'}</a>
            <button name="submitSaveAddressManufacturer" type="submit" class="btn btn-primary form-control-submit float-xs-right">{l s='Save' mod='ets_marketplace'}</button>
         </div>
     </div>
</form>