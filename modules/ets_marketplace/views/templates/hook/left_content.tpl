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
{if $going_to_be_expired && !$isManager}
    <div class="alert alert-info">
        <svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1152 1376v-160q0-14-9-23t-23-9h-96v-512q0-14-9-23t-23-9h-320q-14 0-23 9t-9 23v160q0 14 9 23t23 9h96v320h-96q-14 0-23 9t-9 23v160q0 14 9 23t23 9h448q14 0 23-9t9-23zm-128-896v-160q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v160q0 14 9 23t23 9h192q14 0 23-9t9-23zm640 416q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
        {if $seller_billing &&  $seller_billing->seller_confirm==1 && $seller_billing->active!=1}
            {$ETS_MP_MESSAGE_CONFIRMED_PAYMENT nofilter}
        {else}
            {$ETS_MP_MESSAGE_SELLER_GOING_TOBE_EXPIRED nofilter}
        {/if}
        {if $seller_billing &&  $seller_billing->active==0 && $seller_billing->seller_confirm==0}
            <br />
            <button type="button" class="btn btn-primary i_have_just_sent_the_fee">{l s='I have just sent the fee' mod='ets_marketplace'}</button>
        {/if}
    </div>
{/if}
<ul>
    {foreach from = $tabs item='tab'}
        <li class="ets_mp_item{if $tab.page==$controller} active{/if}">
            <a href="{if isset($tab.link)} {$tab.link|escape:'html':'UTF-8'} {else}{$link->getModuleLink('ets_marketplace',$tab.page)|escape:'html':'UTF-8'}{/if}" {if isset($tab.new_tab) && $tab.new_tab} target="_blank"{/if}>
                <i class="{if isset($tab.icon)}{$tab.icon|escape:'html':'UTF-8'}{else}mp-seller-{$tab.page|escape:'html':'UTF-8'}icons{/if}">
                    {if $tab.page == 'dashboard'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M384 1152q0-53-37.5-90.5t-90.5-37.5-90.5 37.5-37.5 90.5 37.5 90.5 90.5 37.5 90.5-37.5 37.5-90.5zm192-448q0-53-37.5-90.5t-90.5-37.5-90.5 37.5-37.5 90.5 37.5 90.5 90.5 37.5 90.5-37.5 37.5-90.5zm428 481l101-382q6-26-7.5-48.5t-38.5-29.5-48 6.5-30 39.5l-101 382q-60 5-107 43.5t-63 98.5q-20 77 20 146t117 89 146-20 89-117q16-60-6-117t-72-91zm660-33q0-53-37.5-90.5t-90.5-37.5-90.5 37.5-37.5 90.5 37.5 90.5 90.5 37.5 90.5-37.5 37.5-90.5zm-640-640q0-53-37.5-90.5t-90.5-37.5-90.5 37.5-37.5 90.5 37.5 90.5 90.5 37.5 90.5-37.5 37.5-90.5zm448 192q0-53-37.5-90.5t-90.5-37.5-90.5 37.5-37.5 90.5 37.5 90.5 90.5 37.5 90.5-37.5 37.5-90.5zm320 448q0 261-141 483-19 29-54 29h-1402q-35 0-54-29-141-221-141-483 0-182 71-348t191-286 286-191 348-71 348 71 286 191 191 286 71 348z"/></svg>
                    {elseif $tab.page == 'orders'}
                        <svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1920 768q53 0 90.5 37.5t37.5 90.5-37.5 90.5-90.5 37.5h-15l-115 662q-8 46-44 76t-82 30h-1280q-46 0-82-30t-44-76l-115-662h-15q-53 0-90.5-37.5t-37.5-90.5 37.5-90.5 90.5-37.5h1792zm-1435 800q26-2 43.5-22.5t15.5-46.5l-32-416q-2-26-22.5-43.5t-46.5-15.5-43.5 22.5-15.5 46.5l32 416q2 25 20.5 42t43.5 17h5zm411-64v-416q0-26-19-45t-45-19-45 19-19 45v416q0 26 19 45t45 19 45-19 19-45zm384 0v-416q0-26-19-45t-45-19-45 19-19 45v416q0 26 19 45t45 19 45-19 19-45zm352 5l32-416q2-26-15.5-46.5t-43.5-22.5-46.5 15.5-22.5 43.5l-32 416q-2 26 15.5 46.5t43.5 22.5h5q25 0 43.5-17t20.5-42zm-1156-1217l-93 412h-132l101-441q19-88 89-143.5t160-55.5h167q0-26 19-45t45-19h384q26 0 45 19t19 45h167q90 0 160 55.5t89 143.5l101 441h-132l-93-412q-11-44-45.5-72t-79.5-28h-167q0 26-19 45t-45 19h-384q-26 0-45-19t-19-45h-167q-45 0-79.5 28t-45.5 72z"/></svg>
                    {elseif $tab.page == 'products'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1056 1356v-716h-320v716q0 25 18 38.5t46 13.5h192q28 0 46-13.5t18-38.5zm-456-844h195l-126-161q-26-31-69-31-40 0-68 28t-28 68 28 68 68 28zm688-96q0-40-28-68t-68-28q-43 0-69 31l-125 161h194q40 0 68-28t28-68zm376 256v320q0 14-9 23t-23 9h-96v416q0 40-28 68t-68 28h-1088q-40 0-68-28t-28-68v-416h-96q-14 0-23-9t-9-23v-320q0-14 9-23t23-9h440q-93 0-158.5-65.5t-65.5-158.5 65.5-158.5 158.5-65.5q107 0 168 77l128 165 128-165q61-77 168-77 93 0 158.5 65.5t65.5 158.5-65.5 158.5-158.5 65.5h440q14 0 23 9t9 23z"/></svg>
                    {elseif $tab.page == 'stock'}
                        <svg width="14" height="14" viewBox="0 0 2304 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1632l384-192v-314l-384 164v342zm-64-454l404-173-404-173-404 173zm1088 454l384-192v-314l-384 164v342zm-64-454l404-173-404-173-404 173zm-448-293l384-165v-266l-384 164v267zm-64-379l441-189-441-189-441 189zm1088 518v416q0 36-19 67t-52 47l-448 224q-25 14-57 14t-57-14l-448-224q-4-2-7-4-2 2-7 4l-448 224q-25 14-57 14t-57-14l-448-224q-33-16-52-47t-19-67v-416q0-38 21.5-70t56.5-48l434-186v-400q0-38 21.5-70t56.5-48l448-192q23-10 50-10t50 10l448 192q35 16 56.5 48t21.5 70v400l434 186q36 16 57 48t21 70z"/></svg>
                    {elseif $tab.page == 'ratings'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1728 647q0 22-26 48l-363 354 86 500q1 7 1 20 0 21-10.5 35.5t-30.5 14.5q-19 0-40-12l-449-236-449 236q-22 12-40 12-21 0-31.5-14.5t-10.5-35.5q0-6 2-20l86-500-364-354q-25-27-25-48 0-37 56-46l502-73 225-455q19-41 49-41t49 41l225 455 502 73q56 9 56 46z"/></svg>
                    {elseif $tab.page == 'messages'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 896q0 53-37.5 90.5t-90.5 37.5-90.5-37.5-37.5-90.5 37.5-90.5 90.5-37.5 90.5 37.5 37.5 90.5zm384 0q0 53-37.5 90.5t-90.5 37.5-90.5-37.5-37.5-90.5 37.5-90.5 90.5-37.5 90.5 37.5 37.5 90.5zm384 0q0 53-37.5 90.5t-90.5 37.5-90.5-37.5-37.5-90.5 37.5-90.5 90.5-37.5 90.5 37.5 37.5 90.5zm-512-512q-204 0-381.5 69.5t-282 187.5-104.5 255q0 112 71.5 213.5t201.5 175.5l87 50-27 96q-24 91-70 172 152-63 275-171l43-38 57 6q69 8 130 8 204 0 381.5-69.5t282-187.5 104.5-255-104.5-255-282-187.5-381.5-69.5zm896 512q0 174-120 321.5t-326 233-450 85.5q-70 0-145-8-198 175-460 242-49 14-114 22h-5q-15 0-27-10.5t-16-27.5v-1q-3-4-.5-12t2-10 4.5-9.5l6-9 7-8.5 8-9q7-8 31-34.5t34.5-38 31-39.5 32.5-51 27-59 26-76q-157-89-247.5-220t-90.5-281q0-130 71-248.5t191-204.5 286-136.5 348-50.5 348 50.5 286 136.5 191 204.5 71 248.5z"/></svg>
                    {elseif $tab.page == 'commissions'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1362 1185q0 153-99.5 263.5t-258.5 136.5v175q0 14-9 23t-23 9h-135q-13 0-22.5-9.5t-9.5-22.5v-175q-66-9-127.5-31t-101.5-44.5-74-48-46.5-37.5-17.5-18q-17-21-2-41l103-135q7-10 23-12 15-2 24 9l2 2q113 99 243 125 37 8 74 8 81 0 142.5-43t61.5-122q0-28-15-53t-33.5-42-58.5-37.5-66-32-80-32.5q-39-16-61.5-25t-61.5-26.5-62.5-31-56.5-35.5-53.5-42.5-43.5-49-35.5-58-21-66.5-8.5-78q0-138 98-242t255-134v-180q0-13 9.5-22.5t22.5-9.5h135q14 0 23 9t9 23v176q57 6 110.5 23t87 33.5 63.5 37.5 39 29 15 14q17 18 5 38l-81 146q-8 15-23 16-14 3-27-7-3-3-14.5-12t-39-26.5-58.5-32-74.5-26-85.5-11.5q-95 0-155 43t-60 111q0 26 8.5 48t29.5 41.5 39.5 33 56 31 60.5 27 70 27.5q53 20 81 31.5t76 35 75.5 42.5 62 50 53 63.5 31.5 76.5 13 94z"></path></svg>
                    {elseif $tab.page == 'attributes'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 1440v-1088q-148 0-273 73t-198 198-73 273 73 273 198 198 273 73zm768-544q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                    {elseif $tab.page == 'discount'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M576 448q0-53-37.5-90.5t-90.5-37.5-90.5 37.5-37.5 90.5 37.5 90.5 90.5 37.5 90.5-37.5 37.5-90.5zm1067 576q0 53-37 90l-491 492q-39 37-91 37-53 0-90-37l-715-716q-38-37-64.5-101t-26.5-117v-416q0-52 38-90t90-38h416q53 0 117 26.5t102 64.5l715 714q37 39 37 91z"/></svg>
                    {elseif $tab.page == 'carrier'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M640 1408q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm-384-512h384v-256h-158q-13 0-22 9l-195 195q-9 9-9 22v30zm1280 512q0-52-38-90t-90-38-90 38-38 90 38 90 90 38 90-38 38-90zm256-1088v1024q0 15-4 26.5t-13.5 18.5-16.5 11.5-23.5 6-22.5 2-25.5 0-22.5-.5q0 106-75 181t-181 75-181-75-75-181h-384q0 106-75 181t-181 75-181-75-75-181h-64q-3 0-22.5.5t-25.5 0-22.5-2-23.5-6-16.5-11.5-13.5-18.5-4-26.5q0-26 19-45t45-19v-320q0-8-.5-35t0-38 2.5-34.5 6.5-37 14-30.5 22.5-30l198-198q19-19 50.5-32t58.5-13h160v-192q0-26 19-45t45-19h1024q26 0 45 19t19 45z"/></svg>
                    {elseif $tab.page == 'brands'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M522 883q-74-162-74-371h-256v96q0 78 94.5 162t235.5 113zm1078-275v-96h-256q0 209-74 371 141-29 235.5-113t94.5-162zm128-128v128q0 71-41.5 143t-112 130-173 97.5-215.5 44.5q-42 54-95 95-38 34-52.5 72.5t-14.5 89.5q0 54 30.5 91t97.5 37q75 0 133.5 45.5t58.5 114.5v64q0 14-9 23t-23 9h-832q-14 0-23-9t-9-23v-64q0-69 58.5-114.5t133.5-45.5q67 0 97.5-37t30.5-91q0-51-14.5-89.5t-52.5-72.5q-53-41-95-95-113-5-215.5-44.5t-173-97.5-112-130-41.5-143v-128q0-40 28-68t68-28h288v-96q0-66 47-113t113-47h576q66 0 113 47t47 113v96h288q40 0 68 28t28 68z"/></svg>
                    {elseif $tab.page == 'suppliers'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 1629l640-349v-636l-640 233v752zm-64-865l698-254-698-254-698 254zm832-252v768q0 35-18 65t-49 47l-704 384q-28 16-61 16t-61-16l-704-384q-31-17-49-47t-18-65v-768q0-40 23-73t61-47l704-256q22-8 44-8t44 8l704 256q38 14 61 47t23 73z"/></svg>
                    {elseif $tab.page == 'billing'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M384 1184v64q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-64q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h64q13 0 22.5 9.5t9.5 22.5zm1152 512v64q0 13-9.5 22.5t-22.5 9.5h-960q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h960q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-960q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h960q13 0 22.5 9.5t9.5 22.5zm0-256v64q0 13-9.5 22.5t-22.5 9.5h-960q-13 0-22.5-9.5t-9.5-22.5v-64q0-13 9.5-22.5t22.5-9.5h960q13 0 22.5 9.5t9.5 22.5zm128 704v-832q0-13-9.5-22.5t-22.5-9.5h-1472q-13 0-22.5 9.5t-9.5 22.5v832q0 13 9.5 22.5t22.5 9.5h1472q13 0 22.5-9.5t9.5-22.5zm128-1088v1088q0 66-47 113t-113 47h-1472q-66 0-113-47t-47-113v-1088q0-66 47-113t113-47h1472q66 0 113 47t47 113z"/></svg>
                    {elseif $tab.page == 'withdraw'}
                        <svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M832 1152h384v-96h-128v-448h-114l-148 137 77 80q42-37 55-57h2v288h-128v96zm512-256q0 70-21 142t-59.5 134-101.5 101-138 39-138-39-101.5-101-59.5-134-21-142 21-142 59.5-134 101.5-101 138-39 138 39 101.5 101 59.5 134 21 142zm512 256v-512q-106 0-181-75t-75-181h-1152q0 106-75 181t-181 75v512q106 0 181 75t75 181h1152q0-106 75-181t181-75zm128-832v1152q0 26-19 45t-45 19h-1792q-26 0-45-19t-19-45v-1152q0-26 19-45t45-19h1792q26 0 45 19t19 45z"/></svg>
                    {elseif $tab.page == 'voucher'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1792 1184v192q0 13-9.5 22.5t-22.5 9.5h-1376v192q0 13-9.5 22.5t-22.5 9.5q-12 0-24-10l-319-320q-9-9-9-22 0-14 9-23l320-320q9-9 23-9 13 0 22.5 9.5t9.5 22.5v192h1376q13 0 22.5 9.5t9.5 22.5zm0-544q0 14-9 23l-320 320q-9 9-23 9-13 0-22.5-9.5t-9.5-22.5v-192h-1376q-13 0-22.5-9.5t-9.5-22.5v-192q0-13 9.5-22.5t22.5-9.5h1376v-192q0-14 9-23t23-9q12 0 24 10l319 319q9 9 9 23z"/></svg>
                    {elseif $tab.page == 'profile'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M896 0q182 0 348 71t286 191 191 286 71 348q0 181-70.5 347t-190.5 286-286 191.5-349 71.5-349-71-285.5-191.5-190.5-286-71-347.5 71-348 191-286 286-191 348-71zm619 1351q149-205 149-455 0-156-61-298t-164-245-245-164-298-61-298 61-245 164-164 245-61 298q0 250 149 455 66-327 306-327 131 128 313 128t313-128q240 0 306 327zm-235-647q0-159-112.5-271.5t-271.5-112.5-271.5 112.5-112.5 271.5 112.5 271.5 271.5 112.5 271.5-112.5 112.5-271.5z"/></svg>
                    {elseif $tab.page == 'vacation'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1568 160q44 52 12 148t-108 172l-161 161 160 696q5 19-12 33l-128 96q-7 6-19 6-4 0-7-1-15-3-21-16l-279-508-259 259 53 194q5 17-8 31l-96 96q-9 9-23 9h-2q-15-2-24-13l-189-252-252-189q-11-7-13-23-1-13 9-25l96-97q9-9 23-9 6 0 8 1l194 53 259-259-508-279q-14-8-17-24-2-16 9-27l128-128q14-13 30-8l665 159 160-160q76-76 172-108t148 12z"/></svg>
                    {elseif $tab.page == 'manager'}
                        <svg width="14" height="14" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M657 896q-162 5-265 128h-134q-82 0-138-40.5t-56-118.5q0-353 124-353 6 0 43.5 21t97.5 42.5 119 21.5q67 0 133-23-5 37-5 66 0 139 81 256zm1071 637q0 120-73 189.5t-194 69.5h-874q-121 0-194-69.5t-73-189.5q0-53 3.5-103.5t14-109 26.5-108.5 43-97.5 62-81 85.5-53.5 111.5-20q10 0 43 21.5t73 48 107 48 135 21.5 135-21.5 107-48 73-48 43-21.5q61 0 111.5 20t85.5 53.5 62 81 43 97.5 26.5 108.5 14 109 3.5 103.5zm-1024-1277q0 106-75 181t-181 75-181-75-75-181 75-181 181-75 181 75 75 181zm704 384q0 159-112.5 271.5t-271.5 112.5-271.5-112.5-112.5-271.5 112.5-271.5 271.5-112.5 271.5 112.5 112.5 271.5zm576 225q0 78-56 118.5t-138 40.5h-134q-103-123-265-128 81-117 81-256 0-29-5-66 66 23 133 23 59 0 119-21.5t97.5-42.5 43.5-21q124 0 124 353zm-128-609q0 106-75 181t-181 75-181-75-75-181 75-181 181-75 181 75 75 181z"/></svg>
                    {elseif $tab.page == 'shop'}
                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1472 992v480q0 26-19 45t-45 19h-384v-384h-256v384h-384q-26 0-45-19t-19-45v-480q0-1 .5-3t.5-3l575-474 575 474q1 2 1 6zm223-69l-62 74q-8 9-21 11h-3q-13 0-21-7l-692-577-692 577q-12 8-24 7-13-2-21-11l-62-74q-8-10-7-23.5t11-21.5l719-599q32-26 76-26t76 26l244 204v-195q0-14 9-23t23-9h192q14 0 23 9t9 23v408l219 182q10 8 11 21.5t-7 23.5z"/></svg>
                    {/if}
                </i>
                {$tab.name|escape:'html':'UTF-8'}
                {if $tab.page=='messages' && isset($total_message) && $total_message}
                    <b class="number_message">{$total_message|intval}</b>
                {/if}
            </a>
        </li>
    {/foreach}
</ul>