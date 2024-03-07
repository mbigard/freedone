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
<script type="text/javascript" src="{$url_path|escape:'html':'UTF-8'}views/js/tinymce/tinymce.min.js"></script>
<form id="ets_mp_manufacturer_group_form" action="" method="post" enctype="multipart/form-data">
     <div id="fieldset_0" class="panel">
         <div class="panel-heading">
            {l s='Brand' mod='ets_marketplace'}
         </div>
         <div class="form-wrapper">
            {$html_form nofilter}
         </div>
         <div class="panel-footer">
            <input type="hidden" name="submitSaveManufacturer" value="1"/>
            <input type="hidden" name="id_manufacturer" value="{$id_manufacturer|intval}" />
            <a class="btn btn-secondary bd from-control-submit float-xs-left" href="{$link_cancel|escape:'html':'UTF-8'}">{l s='Cancel' mod='ets_marketplace'}</a>
            <button name="submitSaveManufacturer" type="submit" class="btn btn-primary form-control-submit float-xs-right">{l s='Save' mod='ets_marketplace'}</button>
         </div>
     </div>
</form>