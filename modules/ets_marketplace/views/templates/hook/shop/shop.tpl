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
<script type="text/javascript">
var link_ajax_sort_product_list='{$link_ajax_sort_product_list nofilter}';
var selected_categories = '{l s='Selected categories' mod='ets_marketplace' js=1}';
var is_product_comment = {$is_product_comment|intval};
var product_comment_grade_url  ='{$product_comment_grade_url nofilter}';
</script>
{if $is_captcha && !$reported}
    {if $ETS_MP_ENABLE_CAPTCHA_TYPE=='google_v2'}
        <script type="text/javascript">
            var ETS_MP_ENABLE_CAPTCHA_SITE_KEY = '{$ETS_MP_ENABLE_CAPTCHA_SITE_KEY2|escape:'html':'UTF-8'}';
            var ets_mp_report_g_recaptchaonloadCallback = function() {
                ets_mp_report_g_recaptcha = grecaptcha.render(document.getElementById('ets_mp_report_g_recaptcha'), {
                    'sitekey':ETS_MP_ENABLE_CAPTCHA_SITE_KEY,
                    'theme':'light'
                });
            };
        </script>
    {else}
        <script src="https://www.google.com/recaptcha/api.js?render={$ETS_MP_ENABLE_CAPTCHA_SITE_KEY3|escape:'html':'UTF-8'}"></script>
        <script type="text/javascript">
            var ETS_MP_ENABLE_CAPTCHA_SITE_KEY = '{$ETS_MP_ENABLE_CAPTCHA_SITE_KEY3|escape:'html':'UTF-8'}';
            {literal}
            var ets_mp_report_g_recaptchaonloadCallback = function() {
                grecaptcha.ready(function() {
                    grecaptcha.execute(ETS_MP_ENABLE_CAPTCHA_SITE_KEY, {action: 'homepage'}).then(function(token) {
                        $('#ets_mp_report_g_recaptcha').val(token);
                    });
                });
            };
            {/literal}
        </script>
    {/if}
{/if}
<section id="main" class="ets_mp_shop_main_detail">
    {if $seller->shop_banner}
        <div class="card card-block block-seller-banner">
            <div class="seller-banner">
                {if $seller->banner_url}
                    <a href="{$seller->banner_url|escape:'html':'UTF-8'}">
                {/if}
                <img src="{$link->getMediaLink("`$smarty.const.__PS_BASE_URI__`img/mp_seller/`$seller->shop_banner|escape:'htmlall':'UTF-8'`")}" alt="{$seller->shop_name|escape:'html':'UTF-8'}" />
                {if $seller->banner_url}
                    </a>
                {/if}
            </div>
        </div>
    {/if}
    <div id="js-product-list-header">
        <div class="block-seller card card-block">
            {if !$reported}
                {if !$customer_logged}
                    <div class="alert alert-danger not_login">
                        {l s='You need to sign in to report this shop' mod='ets_marketplace'}. <a href="{$link->getPageLink('authentication',null,null,['back'=>$seller->getLink()])|escape:'html':'UTF-8'}">{l s='Sign in' mod='ets_marketplace'}</a>
                        <span class="close">x</span>
                    </div>
                {/if}
            {/if}
            <div class="seller-cover">
                {if $seller->shop_logo}
                        <img style="width:120px" src="{$link->getMediaLink("`$smarty.const.__PS_BASE_URI__`img/mp_seller/`$seller->shop_logo|escape:'htmlall':'UTF-8'`")}" alt="{$seller->shop_name|escape:'html':'UTF-8'}" />
                {/if}
                {if isset($ETS_MP_ENABLE_CONTACT_SHOP) && $ETS_MP_ENABLE_CONTACT_SHOP}
                    <a class="btn btn-primary mp_link_contact_form" href="{$link->getModuleLink('ets_marketplace','contactseller',['id_seller'=>$seller->id])|escape:'html':'UTF-8'}">
                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1664 1504v-768q-32 36-69 66-268 206-426 338-51 43-83 67t-86.5 48.5-102.5 24.5h-2q-48 0-102.5-24.5t-86.5-48.5-83-67q-158-132-426-338-37-30-69-66v768q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm0-1051v-24.5l-.5-13-3-12.5-5.5-9-9-7.5-14-2.5h-1472q-13 0-22.5 9.5t-9.5 22.5q0 168 147 284 193 152 401 317 6 5 35 29.5t46 37.5 44.5 31.5 50.5 27.5 43 9h2q20 0 43-9t50.5-27.5 44.5-31.5 46-37.5 35-29.5q208-165 401-317 54-43 100.5-115.5t46.5-131.5zm128-37v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg>
                        {l s='Contact shop' mod='ets_marketplace'}
                    </a>
                {/if}
                {if $seller->link_facebook || $seller->link_google || $seller->link_instagram || $seller->link_twitter}
                    <div class="seller-social">
                        {if $seller->link_facebook}
                            <a class="facebook" title="Facebook" href="{$seller->link_facebook|escape:'html':'UTF-8'}">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1343 12v264h-157q-86 0-116 36t-30 108v189h293l-39 296h-254v759h-306v-759h-255v-296h255v-218q0-186 104-288.5t277-102.5q147 0 228 12z"/></svg>
                            </a>
                        {/if}
                        {if $seller->link_google}
                            <a class="google" title="Google" href="{$seller->link_google|escape:'html':'UTF-8'}">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 786h725q12 67 12 128 0 217-91 387.5t-259.5 266.5-386.5 96q-157 0-299-60.5t-245-163.5-163.5-245-60.5-299 60.5-299 163.5-245 245-163.5 299-60.5q300 0 515 201l-209 201q-123-119-306-119-129 0-238.5 65t-173.5 176.5-64 243.5 64 243.5 173.5 176.5 238.5 65q87 0 160-24t120-60 82-82 51.5-87 22.5-78h-436v-264z"/></svg>
                            </a>
                        {/if}
                        {if $seller->link_instagram}
                            <a class="instagram" title="Instagram" href="{$seller->link_instagram|escape:'html':'UTF-8'}">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 896q0-106-75-181t-181-75-181 75-75 181 75 181 181 75 181-75 75-181zm138 0q0 164-115 279t-279 115-279-115-115-279 115-279 279-115 279 115 115 279zm108-410q0 38-27 65t-65 27-65-27-27-65 27-65 65-27 65 27 27 65zm-502-220q-7 0-76.5-.5t-105.5 0-96.5 3-103 10-71.5 18.5q-50 20-88 58t-58 88q-11 29-18.5 71.5t-10 103-3 96.5 0 105.5.5 76.5-.5 76.5 0 105.5 3 96.5 10 103 18.5 71.5q20 50 58 88t88 58q29 11 71.5 18.5t103 10 96.5 3 105.5 0 76.5-.5 76.5.5 105.5 0 96.5-3 103-10 71.5-18.5q50-20 88-58t58-88q11-29 18.5-71.5t10-103 3-96.5 0-105.5-.5-76.5.5-76.5 0-105.5-3-96.5-10-103-18.5-71.5q-20-50-58-88t-88-58q-29-11-71.5-18.5t-103-10-96.5-3-105.5 0-76.5.5zm768 630q0 229-5 317-10 208-124 322t-322 124q-88 5-317 5t-317-5q-208-10-322-124t-124-322q-5-88-5-317t5-317q10-208 124-322t322-124q88-5 317-5t317 5q208 10 322 124t124 322q5 88 5 317z"/></svg>
                            </a>
                        {/if} 
                        {if $seller->link_twitter}
                            <a class="twitter" title="Twitter" href="{$seller->link_twitter|escape:'html':'UTF-8'}">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1684 408q-67 98-162 167 1 14 1 42 0 130-38 259.5t-115.5 248.5-184.5 210.5-258 146-323 54.5q-271 0-496-145 35 4 78 4 225 0 401-138-105-2-188-64.5t-114-159.5q33 5 61 5 43 0 85-11-112-23-185.5-111.5t-73.5-205.5v-4q68 38 146 41-66-44-105-115t-39-154q0-88 44-163 121 149 294.5 238.5t371.5 99.5q-8-38-8-74 0-134 94.5-228.5t228.5-94.5q140 0 236 102 109-21 205-78-37 115-142 178 93-10 186-50z"/></svg>
                            </a>
                        {/if}
                    </div>
                {/if}
            </div>
            <div class="block-seller-inner{if isset($seller_group) && $seller_group} block-seller_has-group{/if}">
                <h1 class="h1">{$seller->shop_name|escape:'html':'UTF-8'}</h1>
                {if $seller_follow >=0}
                    <div class="wapper-follow">
                        <div class="block-followed"{if !$seller_follow} style="display:none;"{/if}>
                            <button class="btn btn-primary follow" name="submitunfollow">{l s='Unfollow' mod='ets_marketplace'}</button>
                        </div>
                        <div class="block-follow"{if $seller_follow} style="display:none;"{/if}>
                            <button class="btn btn-primary follow" name="submitfollow" >{l s='Follow' mod='ets_marketplace'}</button>
                        </div>
                    </div>
                {/if}
                {if !$reported}
                    <button class="ets_mp_report btn btn-primary" title="{l s='Report as abused' mod='ets_marketplace'}">
                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M320 256q0 72-64 110v1266q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-1266q-64-38-64-110 0-53 37.5-90.5t90.5-37.5 90.5 37.5 37.5 90.5zm1472 64v763q0 25-12.5 38.5t-39.5 27.5q-215 116-369 116-61 0-123.5-22t-108.5-48-115.5-48-142.5-22q-192 0-464 146-17 9-33 9-26 0-45-19t-19-45v-742q0-32 31-55 21-14 79-43 236-120 421-120 107 0 200 29t219 88q38 19 88 19 54 0 117.5-21t110-47 88-47 54.5-21q26 0 45 19t19 45z"/></svg>
                    </button>
                {/if}
                {if isset($seller_group) && $seller_group && $seller_group->level_name}
                    <div class="block-seller-group">
                        {if $seller_group->badge_image}
                            <img class="badge_image" src="{$link->getMediaLink("`$smarty.const.__PS_BASE_URI__`img/mp_group/`$seller_group->badge_image|escape:'htmlall':'UTF-8'`")}" />
                        {/if}
                        <div class="group-name">{$seller_group->level_name|escape:'html':'UTF-8'}</div>
                    </div>
                {/if}
                <div class="product product_review_shop">
                    {if $total_products}
                        <div class="total col">
                            <svg width="16" height="16" viewBox="0 0 2304 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1632l384-192v-314l-384 164v342zm-64-454l404-173-404-173-404 173zm1088 454l384-192v-314l-384 164v342zm-64-454l404-173-404-173-404 173zm-448-293l384-165v-266l-384 164v267zm-64-379l441-189-441-189-441 189zm1088 518v416q0 36-19 67t-52 47l-448 224q-25 14-57 14t-57-14l-448-224q-4-2-7-4-2 2-7 4l-448 224q-25 14-57 14t-57-14l-448-224q-33-16-52-47t-19-67v-416q0-38 21.5-70t56.5-48l434-186v-400q0-38 21.5-70t56.5-48l448-192q23-10 50-10t50 10l448 192q35 16 56.5 48t21.5 70v400l434 186q36 16 57 48t21 70z"/></svg>
                             {if $total_products > 1}{l s='Products: ' mod='ets_marketplace'}{else}{l s='Product:' mod='ets_marketplace'}{/if} <span>{$total_products|intval}</span>
                        </div>  
                        {if $total_follow!=0}
                            <div class="total_follow col">
                                <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M384 1344q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm1152-576q0-51-39-89.5t-89-38.5h-352q0-58 48-159.5t48-160.5q0-98-32-145t-128-47q-26 26-38 85t-30.5 125.5-59.5 109.5q-22 23-77 91-4 5-23 30t-31.5 41-34.5 42.5-40 44-38.5 35.5-40 27-35.5 9h-32v640h32q13 0 31.5 3t33 6.5 38 11 35 11.5 35.5 12.5 29 10.5q211 73 342 73h121q192 0 192-167 0-26-5-56 30-16 47.5-52.5t17.5-73.5-18-69q53-50 53-119 0-25-10-55.5t-25-47.5q32-1 53.5-47t21.5-81zm128-1q0 89-49 163 9 33 9 69 0 77-38 144 3 21 3 43 0 101-60 178 1 139-85 219.5t-227 80.5h-129q-96 0-189.5-22.5t-216.5-65.5q-116-40-138-40h-288q-53 0-90.5-37.5t-37.5-90.5v-640q0-53 37.5-90.5t90.5-37.5h274q36-24 137-155 58-75 107-128 24-25 35.5-85.5t30.5-126.5 62-108q39-37 90-37 84 0 151 32.5t102 101.5 35 186q0 93-48 192h176q104 0 180 76t76 179z"/></svg> 
                                 {if $total_follow > 1}{l s='Followers:' mod='ets_marketplace'}{else}{l s='Follower:' mod='ets_marketplace'}{/if} <span>{$total_follow|intval}</span>
                            </div>
                        {/if}
                        {if $total_reviews}
                            <div class="ets_review col">
                                <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1201 1004l306-297-422-62-189-382-189 382-422 62 306 297-73 421 378-199 377 199zm527-357q0 22-26 48l-363 354 86 500q1 7 1 20 0 50-41 50-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"/></svg>
                                 {l s='Shop rating' mod='ets_marketplace'}:
                                <div class="ets_review_total" data-grade="{$total_reviews_int}" data-rate-full="★★★★★" data-rate-empty="☆☆☆☆☆"></div>
                                <span class="total_review">({$count_reviews|intval})</span>
                            </div>
                        {/if}
                    {else}
                        {if $total_follow!=0}
                            <div class="total_follow col">
                                <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M384 1344q0-26-19-45t-45-19-45 19-19 45 19 45 45 19 45-19 19-45zm1152-576q0-51-39-89.5t-89-38.5h-352q0-58 48-159.5t48-160.5q0-98-32-145t-128-47q-26 26-38 85t-30.5 125.5-59.5 109.5q-22 23-77 91-4 5-23 30t-31.5 41-34.5 42.5-40 44-38.5 35.5-40 27-35.5 9h-32v640h32q13 0 31.5 3t33 6.5 38 11 35 11.5 35.5 12.5 29 10.5q211 73 342 73h121q192 0 192-167 0-26-5-56 30-16 47.5-52.5t17.5-73.5-18-69q53-50 53-119 0-25-10-55.5t-25-47.5q32-1 53.5-47t21.5-81zm128-1q0 89-49 163 9 33 9 69 0 77-38 144 3 21 3 43 0 101-60 178 1 139-85 219.5t-227 80.5h-129q-96 0-189.5-22.5t-216.5-65.5q-116-40-138-40h-288q-53 0-90.5-37.5t-37.5-90.5v-640q0-53 37.5-90.5t90.5-37.5h274q36-24 137-155 58-75 107-128 24-25 35.5-85.5t30.5-126.5 62-108q39-37 90-37 84 0 151 32.5t102 101.5 35 186q0 93-48 192h176q104 0 180 76t76 179z"/></svg> 
                                {if $total_follow > 1}{l s='Followers:' mod='ets_marketplace'}{else}{l s='Follower:' mod='ets_marketplace'}{/if} 
                                <span>{$total_follow|intval}</span>
                            </div>
                        {/if}
                    {/if}
                    {if $response_rate!=0}
                        <div class="response_rate col">
                            <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 896q0 53-37.5 90.5t-90.5 37.5-90.5-37.5-37.5-90.5 37.5-90.5 90.5-37.5 90.5 37.5 37.5 90.5zm384 0q0 53-37.5 90.5t-90.5 37.5-90.5-37.5-37.5-90.5 37.5-90.5 90.5-37.5 90.5 37.5 37.5 90.5zm384 0q0 53-37.5 90.5t-90.5 37.5-90.5-37.5-37.5-90.5 37.5-90.5 90.5-37.5 90.5 37.5 37.5 90.5zm-512-512q-204 0-381.5 69.5t-282 187.5-104.5 255q0 112 71.5 213.5t201.5 175.5l87 50-27 96q-24 91-70 172 152-63 275-171l43-38 57 6q69 8 130 8 204 0 381.5-69.5t282-187.5 104.5-255-104.5-255-282-187.5-381.5-69.5zm896 512q0 174-120 321.5t-326 233-450 85.5q-70 0-145-8-198 175-460 242-49 14-114 22h-5q-15 0-27-10.5t-16-27.5v-1q-3-4-.5-12t2-10 4.5-9.5l6-9 7-8.5 8-9q7-8 31-34.5t34.5-38 31-39.5 32.5-51 27-59 26-76q-157-89-247.5-220t-90.5-281q0-130 71-248.5t191-204.5 286-136.5 348-50.5 348 50.5 286 136.5 191 204.5 71 248.5z"/></svg>
                             {l s='Response rate' mod='ets_marketplace'}: <span>{$response_rate|floatval}%</span>
                        </div>
                    {/if}
                    <div class="shop_date_add col">
                        <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1664h288v-288h-288v288zm352 0h320v-288h-320v288zm-352-352h288v-320h-288v320zm352 0h320v-320h-320v320zm-352-384h288v-288h-288v288zm736 736h320v-288h-320v288zm-384-736h320v-288h-320v288zm768 736h288v-288h-288v288zm-384-352h320v-320h-320v320zm-352-864v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm736 864h288v-320h-288v320zm-384-384h320v-288h-320v288zm384 0h288v-288h-288v288zm32-480v-288q0-13-9.5-22.5t-22.5-9.5h-64q-13 0-22.5 9.5t-9.5 22.5v288q0 13 9.5 22.5t22.5 9.5h64q13 0 22.5-9.5t9.5-22.5zm384-64v1280q0 52-38 90t-90 38h-1408q-52 0-90-38t-38-90v-1280q0-52 38-90t90-38h128v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h384v-96q0-66 47-113t113-47h64q66 0 113 47t47 113v96h128q52 0 90 38t38 90z"/></svg>
                         {l s='Date created' mod='ets_marketplace'}: <span>{dateFormat date=$seller->date_add}</span>
                    </div>
                    {if $total_products && $total_product_sold!=0}
                        <div class="total_product_sold col"> 
                            <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1536q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm896 0q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm128-1088v512q0 24-16.5 42.5t-40.5 21.5l-1044 122q13 60 13 70 0 16-24 64h920q26 0 45 19t19 45-19 45-45 19h-1024q-26 0-45-19t-19-45q0-11 8-31.5t16-36 21.5-40 15.5-29.5l-177-823h-204q-26 0-45-19t-19-45 19-45 45-19h256q16 0 28.5 6.5t19.5 15.5 13 24.5 8 26 5.5 29.5 4.5 26h1201q26 0 45 19t19 45z"/></svg>
                             {if $total_product_sold>1}{l s='Products sold:' mod='ets_marketplace'}{else}{l s='Product sold:' mod='ets_marketplace'}{/if} <span>{$total_product_sold|intval}</span>
                        </div>
                    {/if}
                </div>
                <div id="seller-description" class="text-muted">
                    {$seller->shop_description|nl2br nofilter}
                </div>
                {if isset($ETS_MP_ENABLE_MAP) && $ETS_MP_ENABLE_MAP && $seller->latitude!=0 && $seller->longitude!=0}
                    <div class="ets_mp_map">
                        <a class="view_map" href="#"> 
                            <svg width="16" height="16" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 640q0-106-75-181t-181-75-181 75-75 181 75 181 181 75 181-75 75-181zm256 0q0 109-33 179l-364 774q-16 33-47.5 52t-67.5 19-67.5-19-46.5-52l-365-774q-33-70-33-179 0-212 150-362t362-150 362 150 150 362z"/></svg>
                             {l s='View map' mod='ets_marketplace'}
                        </a>
                    </div>
                {/if}
            </div>
        </div>
        {if $seller->checkVacation() && Tools::strpos($seller->vacation_type,'show_notifications')!==false}
            <div class="alert alert-warning"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {$seller->vacation_notifications|nl2br nofilter}</div>
        {/if}
    </div>
    <section class="wrapper">
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ets_mp_shop_nocategory ets_myshop_right">
                {if $total_all_products}
                    <div class="ets_mp_tabs">
                        <div class="ets_mp_tabs_content">
                            
                            {if $total_new_products || $total_best_seller_products || $total_special_products}
                                <div class="ets_mp_tabs_content_link_all">
                                    <a title="{l s='Sub categories' mod='ets_marketplace'}" href="{$link_all|escape:'html':'UTF-8'}" class="tab_link{if $current_tab=='all' || ($current_tab=='new_product' && !$total_new_products) ||($current_tab=='best_seller' && !$total_best_seller_products) || ($current_tab=='special' && !$total_special_products)} active{/if}" data-tab="all"><span class="all_product_text">{l s='All products' mod='ets_marketplace'} ({$total_all_products|intval})</span><span class="product_categories_selected"></span></a>
                                    {$list_categories nofilter}
                                </div>
                            {/if}
                            {if $total_new_products}
                                <a href="{$link_new_product|escape:'html':'UTF-8'}" class="tab_link{if $current_tab=='new_product'} active{/if}" data-tab="new_product">{l s='New products' mod='ets_marketplace'} ({$total_new_products|intval})</a>
                            {/if}
                            {if $total_best_seller_products}
                                <a href="{$link_best_seller|escape:'html':'UTF-8'}" class="tab_link{if $current_tab=='best_seller'} active{/if}" data-tab="best_seller">{l s='Best sellers' mod='ets_marketplace'} ({$total_best_seller_products|intval})</a>
                            {/if}
                            {if $total_special_products}
                                <a href="{$link_special|escape:'html':'UTF-8'}" class="tab_link{if $current_tab=='special'} active{/if}" data-tab="special">{l s='Discounted' mod='ets_marketplace'} ({$total_special_products|intval})</a>
                            {/if}
                        </div>
                        <div class="ets_mp_tabs_content_search"></div>
                    </div>
                {/if}
                <div id="products">
                    <div class="product_tab ets_mp_shop_tab tab_all{if $current_tab=='all' || ($current_tab=='new_product' && !$total_new_products) ||($current_tab=='best_seller' && !$total_best_seller_products) || ($current_tab=='special' && !$total_special_products)} active{/if}">
                        {if $current_tab=='all'}
                            {$product_list nofilter}
                        {/if}
                    </div>
                    {if $total_new_products}
                        <div class="product_tab ets_mp_shop_tab tab_new_product{if $current_tab=='new_product'} active{/if}">
                            {if $current_tab=='new_product'}
                                {$product_list nofilter}
                            {/if}
                        </div>
                    {/if}
                    {if $total_best_seller_products}
                        <div class="product_tab ets_mp_shop_tab tab_best_seller{if $current_tab=='best_seller'} active{/if}">
                            {if $current_tab=='best_seller'}
                                {$product_list nofilter}
                            {/if}
                        </div>
                    {/if}
                    {if $total_special_products}
                        <div class="product_tab ets_mp_shop_tab tab_special{if $current_tab=='special'} active{/if}">
                            {if $current_tab=='special'}
                                {$product_list nofilter}
                            {/if}
                        </div>
                    {/if}
                </div>
            </div>
        </div>
    </section>
</section>
{if !$reported && $customer_logged}
    <div class="ets_mp_popup ets_mp_shop_report_popup" style="display:none;">
        <div class="mp_pop_table">
            <div class="mp_pop_table_cell">
                <form id="ets_mp_report_shop_form" action="" method="post" enctype="multipart/form-data">
                    <div class="ets_mp_close_popup" title="{l s='Close' mod='ets_marketplace'}">{l s='Close' mod='ets_marketplace'}</div>
                    <div id="fieldset_0" class="panel">
                        
                            <div class="panel-heading">
                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                {l s='Report shop' mod='ets_marketplace'}
                            </div>
                            <div class="form-wrapper">
                                <div class="row form-group">
                                    <label class="col-lg-3 form-control-label" for="email">{l s='Email' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9">
                                        <input disabled="disabled" class="form-control" name="email" value="{$report_customer->email|escape:'html':'UTF-8'}" type="text" id="email" readonly="true" />
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label class="col-lg-3 form-control-label" for="name">{l s='Name' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9">
                                        <input disabled="disabled" class="form-control" name="name" value="{$report_customer->firstname|escape:'html':'UTF-8'} {$report_customer->lastname|escape:'html':'UTF-8'}" type="text" id="name" readonly="true" />
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label class="col-lg-3 form-control-label required" for="report_title">{l s='Title' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9">
                                        <input class="form-control" name="report_title" value="" type="text" id="report_title" />
                                    </div>
                                </div>
                                <div class="row form-group">
                                    <label class="col-lg-3 form-control-label required" for="report_content">{l s='Content' mod='ets_marketplace'}</label>
                                    <div class="col-lg-9"><textarea class="form-control" name="report_content" id="report_content"></textarea></div>
                                </div>
                                {if $is_captcha}
                                    <div class="form-group row">
                                        <label class="col-md-3 form-control-label"></label>
                                        <div class="col-md-6">
                                            {if $ETS_MP_ENABLE_CAPTCHA_TYPE=='google_v2'}
                                                <script src="https://www.google.com/recaptcha/api.js?onload=ets_mp_report_g_recaptchaonloadCallback&render=explicit" async defer></script>
                                                <div id="ets_mp_report_g_recaptcha" class="ets_mp_report_g_recaptcha" ></div>
                                            {/if}
                                            {if $ETS_MP_ENABLE_CAPTCHA_TYPE=='google_v3'}
                                                <input type="hidden" id="ets_mp_report_g_recaptcha" name="g-recaptcha-response" />
                                                <script type="text/javascript">
                                                    ets_mp_report_g_recaptchaonloadCallback();
                                                </script>
                                            {/if}
                                        </div>
                                    </div>
                                {/if}
                            </div>
                            <div class="panel-footer">
                                <input name="submitReportShop" value="1" type="hidden" />
                                <input name="id_product_report" value="0" type="hidden"/>
                                <input name="id_seller_report" value="{$seller->id|intval}" type="hidden"/>
                                <button class="btn btn-primary form-control-submit float-xs-left" name="cancelReportShop">{l s='Cancel' mod='ets_marketplace'}</button>
                                <button class="btn btn-primary form-control-submit float-xs-right" name="submitReportShop" type="submit">{l s='Report' mod='ets_marketplace'}</button>
                            </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
{/if}
{if isset($ETS_MP_ENABLE_MAP) && $ETS_MP_ENABLE_MAP && $seller->latitude!=0 && $seller->longitude!=0}
    <div class="ets_mp_popup ets_mp_shop_maps_popup" style="display:none;">
        <div class="mp_pop_table">
            <div class="mp_pop_table_cell">
                <div>
                    <div class="ets_mp_close_popup" title="Close">Close</div>
                    <div id="map"></div>
                    <div class="store-content-select selector3" style="display:none;">
                    	<select id="locationSelect" class="form-control">
                    		<option>-</option>
                    	</select>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        var markers=[];
        var infoWindow = '';
        var locationSelect = '';
        var defaultLat = {$seller->latitude|floatval};
        var defaultLong = {$seller->longitude|floatval};
        var hasStoreIcon = true;
        var distance_unit = 'km';
        var img_ps_dir = '{$base_link|escape:'html':'UTF-8'}/modules/ets_marketplace/views/img/';
        var searchUrl = '{$link->getModuleLink('ets_marketplace','shop',['id_seller'=>$seller->id,'getmaps'=>1]) nofilter}';
        var logo_map = {if Configuration::get('ETS_MP_GOOGLE_MAP_LOGO')}'{Configuration::get('ETS_MP_GOOGLE_MAP_LOGO')|escape:'html':'UTF-8'}'{else}'logo_map.png'{/if};
        var translation_1 = '{l s='No stores were found. Please try selecting a wider radius.' mod='ets_marketplace' js=1}';
        var translation_2 = '{l s='store found -- see details:' mod='ets_marketplace' js=1}';
        var translation_3 = '{l s='stores found -- view all results:' mod='ets_marketplace' js=1}';
        var translation_4 = '{l s='Phone:' mod='ets_marketplace' js=1}' ;
        var translation_5 = '{l s='Get directions' mod='ets_marketplace' js=1}';
        var translation_6 = '{l s='Not found' mod='ets_marketplace' js=1}';
    </script>
{/if}
