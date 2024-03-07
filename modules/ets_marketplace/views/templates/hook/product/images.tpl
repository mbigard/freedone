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

<div id="product-images-container"{if $product_class->id} style="display:block"{else} style="display:none;"{/if}>
    <div id="product-images-dropzone" class="panel dropzone ui-sortable {if $images}dz-started{/if} col-md-12" style="">
        <div id="product-images-dropzone-error" class="text-danger"></div>
        
        <div id="list-images-product">
            {if $images}
                {foreach from=$images item='image'}
                    <div id="images-{$image.id_image|intval}" class="dz-preview dz-image-preview dz-complete ui-sortable-handle ets_mp_edit_image" data-id="{$image.id_image|intval}">
                        <div class="dz-image bg"><img src="{$image.link|escape:'html':'UTF-8'}" style="width:140px;heigth:140px;"/></div>
                        <div class="dz-progress">
                            <span class="dz-upload" style="width: 100%;"></span>
                        </div>
                        <div class="dz-error-message">
                            <span data-dz-errormessage=""></span>
                        </div>
                        <div class="dz-success-mark"></div>
                        <div class="dz-error-mark"></div>
                        {if $image.cover}
                            <div class="iscover">{l s='Cover' mod='ets_marketplace'}</div>
                        {/if}
                    </div>
                {/foreach}
            {/if} 
            <div id="form-images">
                <input id="ets_mp_multiple_images" name="multiple_imamges[]" multiple="multiple" type="file" />
                <label for="ets_mp_multiple_images">
                    <div class="dz-default dz-message openfilemanager dz-clickable">
                        <svg width="60" height="60" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 672q119 0 203.5 84.5t84.5 203.5-84.5 203.5-203.5 84.5-203.5-84.5-84.5-203.5 84.5-203.5 203.5-84.5zm704-416q106 0 181 75t75 181v896q0 106-75 181t-181 75h-1408q-106 0-181-75t-75-181v-896q0-106 75-181t181-75h224l51-136q19-49 69.5-84.5t103.5-35.5h512q53 0 103.5 35.5t69.5 84.5l51 136h224zm-704 1152q185 0 316.5-131.5t131.5-316.5-131.5-316.5-316.5-131.5-316.5 131.5-131.5 316.5 131.5 316.5 316.5 131.5z"></path></svg> <br />
                        {l s='Select files' mod='ets_marketplace'} <br />
                        <small>
                            {l s='Recommended size 800 x 800px for default theme.' mod='ets_marketplace'}<br />
                            {l s='JPG, GIF or PNG format.' mod='ets_marketplace'}
                        </small>
                        </form>
                    </div> 
                    <div class="dz-preview disabled openfilemanager dz-clickable">
                        <div>
                            <span>+</span>
                        </div>
                    </div>
                </label>    
            </div>
        </div>
    </div>
    <div id="product-images-form-container">
    </div>
</div>