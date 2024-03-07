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
<script>
var commissions_line_datasets ={$commissions_line_datasets|json_encode};
var turn_over_bar_datasets ={$turn_over_bar_datasets|json_encode};
var chart_labels=[{foreach from=$chart_labels item='data'}'{$data|escape:'html':'UTF-8'}',{/foreach}];
var charxlabelString = '{l s='Month' mod='ets_marketplace' js=1}';
var charylabelString = '{$default_currency->iso_code|escape:'html':'UTF-8'}';
</script>
<script type="text/javascript" src="{$ets_mp_module_dir|escape:'html':'UTF-8'}views/js/moment.min.js"></script>
<script type="text/javascript" src="{$ets_mp_module_dir|escape:'html':'UTF-8'}views/js/daterangepicker.js"></script>
<script type="text/javascript" src="{$ets_mp_module_dir|escape:'html':'UTF-8'}views/js/dashboard.js"></script>
<div class="ets-sn-admin__content ets_mp-dashboard-page">
    <div class="ets-sn-admin__body">
        <div class="stats-box-info">
            <div class="row margin-15 ">
                <div class="col-lg-2 box-padding-col box-static box-static-turnover">
                    <div class="box-info js-type-info-stats" style="background: #f06295;">
                        <div class="box-inner turnover">
                            <svg width="35" height="35" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M704 1536q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm896 0q0 52-38 90t-90 38-90-38-38-90 38-90 90-38 90 38 38 90zm128-1088v512q0 24-16.5 42.5t-40.5 21.5l-1044 122q13 60 13 70 0 16-24 64h920q26 0 45 19t19 45-19 45-45 19h-1024q-26 0-45-19t-19-45q0-11 8-31.5t16-36 21.5-40 15.5-29.5l-177-823h-204q-26 0-45-19t-19-45 19-45 45-19h256q16 0 28.5 6.5t19.5 15.5 13 24.5 8 26 5.5 29.5 4.5 26h1201q26 0 45 19t19 45z"/></svg>

                            <div class="box-inner-top">
                                <h5 class="box-info-title">{l s='Turnover' mod='ets_marketplace'}</h5>
                                <div class="box-info-content"> {displayPrice price=$totalTurnOver} </div>
                            </div>
                            <span>{l s='Total money earned from selling seller products' mod='ets_marketplace'} </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 box-padding-col box-static box-static-commissions">
                    <div class="box-info js-type-info-stats" style="background: #f87f6f;">
                        <div class="box-inner commissions">
                            <svg width="35" height="35" viewBox="0 0 2304 1792" xmlns="http://www.w3.org/2000/svg"><path d="M192 1152q40 0 56-32t0-64-56-32-56 32 0 64 56 32zm1473-58q-10-13-38.5-50t-41.5-54-38-49-42.5-53-40.5-47-45-49l-125 140q-83 94-208.5 92t-205.5-98q-57-69-56.5-158t58.5-157l177-206q-22-11-51-16.5t-47.5-6-56.5.5-49 1q-92 0-158 66l-158 158h-155v544q5 0 21-.5t22 0 19.5 2 20.5 4.5 17.5 8.5 18.5 13.5l297 292q115 111 227 111 78 0 125-47 57 20 112.5-8t72.5-85q74 6 127-44 20-18 36-45.5t14-50.5q10 10 43 10 43 0 77-21t49.5-53 12-71.5-30.5-73.5zm159 58h96v-512h-93l-157-180q-66-76-169-76h-167q-89 0-146 67l-209 243q-28 33-28 75t27 75q43 51 110 52t111-49l193-218q25-23 53.5-21.5t47 27 8.5 56.5q16 19 56 63t60 68q29 36 82.5 105.5t64.5 84.5q52 66 60 140zm288 0q40 0 56-32t0-64-56-32-56 32 0 64 56 32zm192-576v640q0 26-19 45t-45 19h-434q-27 65-82 106.5t-125 51.5q-33 48-80.5 81.5t-102.5 45.5q-42 53-104.5 81.5t-128.5 24.5q-60 34-126 39.5t-127.5-14-117-53.5-103.5-81l-287-282h-358q-26 0-45-19t-19-45v-672q0-26 19-45t45-19h421q14-14 47-48t47.5-48 44-40 50.5-37.5 51-25.5 62-19.5 68-5.5h117q99 0 181 56 82-56 181-56h167q35 0 67 6t56.5 14.5 51.5 26.5 44.5 31 43 39.5 39 42 41 48 41.5 48.5h355q26 0 45 19t19 45z"/></svg>

                            <div class="box-inner-top">
                                <h5 class="box-info-title">{l s='Seller commissions' mod='ets_marketplace'}</h5>
                                <div class="box-info-content"> {displayPrice price=$totalSellerCommission|floatval} </div>
                            </div>
                            <span>{l s='Total commission that all sellers have earned' mod='ets_marketplace'} </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 box-padding-col box-static box-static-earning">
                    <div class="box-info js-type-info-stats" style="background: #45bbe2;">
                        <div class="box-inner earning">
                            <svg width="35" height="35" viewBox="0 0 2304 1792" xmlns="http://www.w3.org/2000/svg"><path d="M0 1504v-608h2304v608q0 66-47 113t-113 47h-1984q-66 0-113-47t-47-113zm640-224v128h384v-128h-384zm-384 0v128h256v-128h-256zm1888-1152q66 0 113 47t47 113v224h-2304v-224q0-66 47-113t113-47h1984z"/></svg>

                            <div class="box-inner-top">
                                <h5 class="box-info-title">{l s='Admin earning' mod='ets_marketplace'}</h5>
                                {assign var=totalAdminEarning value=$totalSellerRevenve+$totalSellerFee}
                                <div class="box-info-content"> {displayPrice price=$totalAdminEarning|floatval} </div>
                            </div>
                            <span>{l s='Total money admin earned from seller products and membership fee' mod='ets_marketplace'} </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 box-padding-col box-static box-static-revenve">
                    <div class="box-info js-type-info-stats" style="background: #ff546b;">
                        <div class="box-inner revenve">
                            <svg width="35" height="35" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1362 1185q0 153-99.5 263.5t-258.5 136.5v175q0 14-9 23t-23 9h-135q-13 0-22.5-9.5t-9.5-22.5v-175q-66-9-127.5-31t-101.5-44.5-74-48-46.5-37.5-17.5-18q-17-21-2-41l103-135q7-10 23-12 15-2 24 9l2 2q113 99 243 125 37 8 74 8 81 0 142.5-43t61.5-122q0-28-15-53t-33.5-42-58.5-37.5-66-32-80-32.5q-39-16-61.5-25t-61.5-26.5-62.5-31-56.5-35.5-53.5-42.5-43.5-49-35.5-58-21-66.5-8.5-78q0-138 98-242t255-134v-180q0-13 9.5-22.5t22.5-9.5h135q14 0 23 9t9 23v176q57 6 110.5 23t87 33.5 63.5 37.5 39 29 15 14q17 18 5 38l-81 146q-8 15-23 16-14 3-27-7-3-3-14.5-12t-39-26.5-58.5-32-74.5-26-85.5-11.5q-95 0-155 43t-60 111q0 26 8.5 48t29.5 41.5 39.5 33 56 31 60.5 27 70 27.5q53 20 81 31.5t76 35 75.5 42.5 62 50 53 63.5 31.5 76.5 13 94z"/></svg>
                            <div class="box-inner-top">
                                <h5 class="box-info-title">{l s='Revenue' mod='ets_marketplace'}</h5>
                                <div class="box-info-content"> {displayPrice price=$totalSellerRevenve|floatval} </div>
                            </div>
                            <span>{l s='Total money admin earned from seller products' mod='ets_marketplace'} </span>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2 box-padding-col box-static box-static-fee">
                    <div class="box-info js-type-info-fee" style="background: #fbbb21;">
                        <div class="box-inner revenve">
                            <svg width="35" height="35" viewBox="0 0 2048 1792" xmlns="http://www.w3.org/2000/svg"><path d="M657 896q-162 5-265 128h-134q-82 0-138-40.5t-56-118.5q0-353 124-353 6 0 43.5 21t97.5 42.5 119 21.5q67 0 133-23-5 37-5 66 0 139 81 256zm1071 637q0 120-73 189.5t-194 69.5h-874q-121 0-194-69.5t-73-189.5q0-53 3.5-103.5t14-109 26.5-108.5 43-97.5 62-81 85.5-53.5 111.5-20q10 0 43 21.5t73 48 107 48 135 21.5 135-21.5 107-48 73-48 43-21.5q61 0 111.5 20t85.5 53.5 62 81 43 97.5 26.5 108.5 14 109 3.5 103.5zm-1024-1277q0 106-75 181t-181 75-181-75-75-181 75-181 181-75 181 75 75 181zm704 384q0 159-112.5 271.5t-271.5 112.5-271.5-112.5-112.5-271.5 112.5-271.5 271.5-112.5 271.5 112.5 112.5 271.5zm576 225q0 78-56 118.5t-138 40.5h-134q-103-123-265-128 81-117 81-256 0-29-5-66 66 23 133 23 59 0 119-21.5t97.5-42.5 43.5-21q124 0 124 353zm-128-609q0 106-75 181t-181 75-181-75-75-181 75-181 181-75 181 75 75 181z"/></svg>
                            <div class="box-inner-top">
                                <h5 class="box-info-title">{l s='Membership fee' mod='ets_marketplace'}</h5>
                                <div class="box-info-content"> {displayPrice price=$totalSellerFee|floatval} </div>
                            </div>
                            <span>{l s='Total money admin earned from membership fee' mod='ets_marketplace'} </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="section-item ets_mp-section-commissions">
            <div class="row margin-15 row-991">
                <div class="col-lg-4 col-xs-4 col-sm-4 plr-15">
                    <div class="stats-data-commissions">
                        <div class="stats-container">
                            <div class="stats-body">
                                <div class="box-dashboard line-chart-commissions">
                                    <div class="box-header">
                                        <h4 class="box-title">
                                            {l s='Admin earning' mod='ets_marketplace'}
                                            <i class="ets_tooltip_question">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                <span class="ets_tooltip" data-tooltip="top">{l s='Total money admin earned from successfully sold products of sellers and the fee which sellers paid to maintain seller accounts' mod='ets_marketplace'}</span>
                                            </i>
                                        </h4>

                                        <div class="box-tool-dropdown">
                                            <select name="filter-time-stats-commissions">
                                                <option value="all_time">{l s='All time' mod='ets_marketplace'}</option>
                                                <option value="this_month">{l s='This month' mod='ets_marketplace'}</option>
                                                <option value="_month">{l s='Month -1' mod='ets_marketplace'}</option>
                                                <option value="this_year" selected="selected">{l s='This year' mod='ets_marketplace'}</option>
                                                <option value="_year">{l s='Year -1' mod='ets_marketplace'}</option>
                                                <option value="time_range">{l s='Time range' mod='ets_marketplace'}</option>
                                            </select>
                                        </div>
                                        <div class="box-tool">
                                            <div class="box-tool-timerange box-date-ranger" style="display: none;">
                                                <input class="ajax-date-range ets_mp_date_ranger_filter" type="text" autocomplete="off" />
                                                <input class="date_from_commissions" value="" type="hidden" />
                                                <input class="date_to_commissions" value="" type="hidden" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div class="no_data" {if !$no_data_char_commission}style="display:none;"{/if}>{l s='No data' mod='ets_marketplace'}</div>
                                        <canvas id="ets_mp_stats_commision_line" {if $no_data_char_commission}style="display:none;"{/if}>
                                            
                                        </canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-xs-4 col-sm-4 plr-15">
                    <div class="stats-data-commissions">
                        <div class="stats-container">
                            <div class="stats-body">
                                <div class="box-dashboard bar-chart-turn-over">
                                    <div class="box-header">
                                        <h4 class="box-title">
                                            {l s='Turnover & Seller commissions' mod='ets_marketplace'}
                                            <i class="ets_tooltip_question">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                <span class="ets_tooltip" data-tooltip="top">{l s='Total money earned from selling seller products and total commission that all sellers of your website have earned' mod='ets_marketplace'}</span>
                                            </i>
                                        </h4>

                                        <div class="box-tool-dropdown">
                                            <select name="filter-time-stats-turnover">
                                                <option value="all_time">{l s='All time' mod='ets_marketplace'}</option>
                                                <option value="this_month">{l s='This month' mod='ets_marketplace'}</option>
                                                <option value="_month">{l s='Month -1' mod='ets_marketplace'}</option>
                                                <option value="this_year" selected="selected">{l s='This year' mod='ets_marketplace'}</option>
                                                <option value="_year">{l s='Year -1' mod='ets_marketplace'}</option>
                                                <option value="time_range">{l s='Time range' mod='ets_marketplace'}</option>
                                            </select>
                                        </div>
                                        <div class="box-tool">
                                            <div class="box-tool-timerange box-date-ranger" style="display: none;">
                                                <input class="ajax-date-range ets_mp_date_ranger_filter" type="text" autocomplete="off" />
                                                <input class="date_from_order" value="" type="hidden" />
                                                <input class="date_to_order" value="" type="hidden" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="box-body">
                                        <div class="no_data" {if !$no_data_char_turn_over}style="display:none;"{/if}>{l s='No data' mod='ets_marketplace'}</div>
                                        <canvas id="ets_mp_stats_turn-over_bar" {if $no_data_char_turn_over}style="display:none;"{/if}>
                                        </canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-xs-4 col-sm-4 plr-15">
                    <div class="stats-data-commissions">
                        <div class="stats-container">
                            <div class="stats-body">
                                <div class="box-dashboard latest-withdrawals">
                                    <div class="box-header">
                                        <h4 class="box-title">
                                            {l s='Latest withdrawals request' mod='ets_marketplace'}
                                            <i class="ets_tooltip_question">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                <span class="ets_tooltip" data-tooltip="top">{l s='Latest withdrawal requests from sellers' mod='ets_marketplace'}</span>
                                            </i>
                                        </h4>
                                    </div>
                                    <div class="box-body">
                                        <div id="ets_mp_list_withdrawals">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th class="text-center">{l s='ID' mod='ets_marketplace'}</th>
                                                        <th>{l s='Seller name' mod='ets_marketplace'}</th>
                                                        <th class="text-center">{l s='Amount' mod='ets_marketplace'}</th>
                                                        <th>{l s='Status' mod='ets_marketplace'}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    {if $last_withdraws}
                                                        {foreach from=$last_withdraws item='withdraw'}
                                                            <tr>
                                                                <td class="text-center">
                                                                    {$withdraw.id_ets_mp_withdrawal|intval}
                                                                </td>
                                                                <td class="seller_name">
                                                                    {if $withdraw.id_customer_seller}
                                                                        <a href="{$module->getLinkCustomerAdmin($withdraw.id_customer_seller)|escape:'html':'UTF-8'}&viewseller=1&id_seller={$withdraw.id_seller|intval}">{$withdraw.seller_name|escape:'html':'UTF-8'}</a>
                                                                    {else}
                                                                        <span class="row_deleted">{l s='Seller deleted' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                </td>
                                                                <td class="text-center">
                                                                    {displayPrice price =$withdraw.amount}
                                                                </td>
                                                                <td >
                                                                    {if $withdraw.status==0}
                                                                        <span class="ets_mp_status pending">{l s='Pending' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                    {if $withdraw.status==-1}
                                                                        <span class="ets_mp_status declined">{l s='Declined' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                    {if $withdraw.status==1}
                                                                        <span class="ets_mp_status approved">{l s='Approved' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                </td>
                                                            </tr>
                                                        {/foreach}
                                                    {else}
                                                        <tr>
                                                            <td colspan="100%" class="text-center no_data">{l s='No data' mod='ets_marketplace'}</td>
                                                        </tr>
                                                    {/if}
                                                    
                                                </tbody>
                                            </table>
                                            {if $last_withdraws}
                                                <span class="text-center view_detail">
                                                    <a href="{$link->getAdminLink('AdminMarketPlaceWithdrawals')|escape:'html':'UTF-8'}">{l s='View all' mod='ets_marketplace'}</a>
                                                </span>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-xs-6 col-sm-6 plr-15">
                    <div class="stats-data-commissions">
                        <div class="stats-container">
                            <div class="stats-body">
                                <div class="box-dashboard latest-payment-billings">
                                    <div class="box-header">
                                        <h4 class="box-title">
                                            {l s='Latest membership' mod='ets_marketplace'}
                                            <i class="ets_tooltip_question">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                <span class="ets_tooltip" data-tooltip="top">{l s='Latest payment billings generated when sellers pay for membership fee' mod='ets_marketplace'}</span>
                                            </i>
                                        </h4>
                                    </div>
                                    <div class="box-body">
                                        <div id="ets_mp_list_billings">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th class="text-center">{l s='ID' mod='ets_marketplace'}</th>
                                                        <th>{l s='Seller name' mod='ets_marketplace'}</th>
                                                        <th>{l s='Shop name' mod='ets_marketplace'}</th>
                                                        <th class="text-center">{l s='Amount' mod='ets_marketplace'}</th>
                                                        <th>{l s='Status' mod='ets_marketplace'}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    {if $last_payment_billings}
                                                        {foreach from=$last_payment_billings item='billing'}
                                                            <tr>
                                                                <td class="text-center">{$billing.id_ets_mp_seller_billing|intval}</td>
                                                                <td class="seller_name">
                                                                    {if $billing.id_customer_seller}
                                                                        <a href="{$module->getLinkCustomerAdmin($billing.id_customer_seller)|escape:'html':'UTF-8'}&viewseller=1&id_seller={$billing.id_seller|intval}">{$billing.seller_name|escape:'html':'UTF-8'}</a>
                                                                    {else}
                                                                        <span class="row_deleted">{l s='Seller deleted' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                </td>
                                                                <td>
                                                                    {if $billing.id_seller}
                                                                        <a href="{$module->getShopLink(['id_seller'=>$billing.id_seller])|escape:'html':'UTF-8'}" target="_blank">{$billing.shop_name|escape:'html':'UTF-8'}</a>
                                                                    {else}
                                                                        <span class="deleted_shop row_deleted">{l s='Shop deleted' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                </td>
                                                                <td class="text-center">{displayPrice price=$billing.amount}</td>
                                                                <td>
                                                                    {if $billing.active==-1}
                                                                        <span class="ets_mp_status deducted">{l s='Canceled' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                    {if $billing.active==0}
                                                                        <span class="ets_mp_status pending">{l s='Pending' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                    {if $billing.active==1}
                                                                        <span class="ets_mp_status purchased">{l s='Paid' mod='ets_marketplace'}</span>
                                                                    {/if}
                                                                </td>
                                                            </tr>
                                                        {/foreach}
                                                    {else}
                                                        <tr>
                                                            <td colspan="100%" class="text-center no_data">{l s='No data' mod='ets_marketplace'}</td>
                                                        </tr>
                                                    {/if}
                                                    
                                                </tbody>
                                            </table>
                                            {if $last_payment_billings}
                                                <span class="text-center view_detail">
                                                    <a href="{$link->getAdminLink('AdminMarketPlaceBillings')|escape:'html':'UTF-8'}">{l s='View all' mod='ets_marketplace'}</a>
                                                </span>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-xs-6 col-sm-6 plr-15">
                    <div class="stats-data-commissions">
                        <div class="stats-container">
                            <div class="stats-body">
                                <div class="box-dashboard going-to-expired">
                                    <div class="box-header">
                                        <h4 class="box-title">
                                            {l s='Seller accounts are going to be expired' mod='ets_marketplace'}
                                            <i class="ets_tooltip_question">
                                                <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                                <span class="ets_tooltip" data-tooltip="top">{l s='Seller accounts need to be renewed soon' mod='ets_marketplace'}</span>
                                            </i>
                                        </h4>
                                    </div>
                                    <div class="box-body">
                                        <div id="ets_mp_list_billings">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th class="text-center">{l s='ID' mod='ets_marketplace'}</th>
                                                        <th>{l s='Seller name' mod='ets_marketplace'}</th>
                                                        <th>{l s='Seller email' mod='ets_marketplace'}</th>
                                                        <th>{l s='Expiration date' mod='ets_marketplace'}</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                {if $going_tobe_expired_sellers}
                                                    {foreach from=$going_tobe_expired_sellers item='seller'}
                                                        <tr>
                                                            <td class="text-center">{$seller.id_seller|intval}</td>
                                                            <td><a href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}&viewseller=1&id_seller={$seller.id_seller|intval}">{$seller.seller_name|escape:'html':'UTF-8'}</a></td>
                                                            <td>{$seller.seller_email|escape:'html':'UTF-8'}</td>
                                                            <td>{dateFormat date=$seller.date_to full=0}</td>
                                                        </tr>
                                                    {/foreach}
                                                {else}
                                                    <tr>
                                                        <td colspan="100%" class="text-center no_data">{l s='No data' mod='ets_marketplace'}</td>
                                                    </tr>
                                                {/if}
                                                </tbody>
                                            </table>
                                            {if $going_tobe_expired_sellers}
                                                <span class="text-center view_detail">
                                                    <a href="{$link->getAdminLink('AdminMarketPlaceSellers')|escape:'html':'UTF-8'}">{l s='View all' mod='ets_marketplace'}</a>
                                                </span>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12 px-10 sale_products_form" id="ets_mp_dashboards">
                <div class="panel ets_mp-position-relative js-ets_mp-dashboard">
                    <div class="panel-header">
                        <div class="box-header">
                            <h4 class="box-title">
                                {l s='Sales, products & sellers' mod='ets_marketplace'}
                                <i class="ets_tooltip_question">
                                    <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                    <span class="ets_tooltip" data-tooltip="top">{l s='Statistics about sales, seller products and sellers' mod='ets_marketplace'}</span>
                                </i>
                            </h4>
                        </div>
                    </div>
                    <div class="panel-bodys pt-0">
                        <ul id="nav-tab-rank" class="nav nav-pills nav-tabs" role="tablist">
                            <li class="active" role="presentation">
                                <a href="#statis_latest_orders" aria-controls="tab_statis_lates_orders" role="tab" data-toggle="tab">
                                    <i class="fa fa-latest-order"></i>
                                    {l s='Latest orders' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Latest orders from the shops of sellers' mod='ets_marketplace'}</span>
                                    </i>
                                </a>
                            </li>
                            <li class="" role="presentation">
                                <a href="#statis_latest_seller_commissions" aria-controls="tab_latest_seller_commissions" role="tab" data-toggle="tab">
                                    <i class="fa fa-latest-seller-commissions"></i>
                                    {l s='Latest seller commissions' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Latest commissions which sellers earned by selling seller products' mod='ets_marketplace'}</span>
                                    </i>
                                </a>
                            </li>
                            <li class="" role="presentation">
                                <a href="#statis_latest_products" aria-controls="tab_statis_latest_products" role="tab" data-toggle="tab">
                                    <i class="fa fa-lastest-products"></i>
                                    {l s='Latest products' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Latest products added by sellers' mod='ets_marketplace'}</span>
                                    </i>
                                </a>
                            </li>
                            <li class="" role="presentation">
                                <a href="#statis_best_selling_products" aria-controls="tab_statis_best_selling_products" role="tab" data-toggle="tab">
                                    <i class="fa fa-best-selling-products"></i>
                                    {l s='Best selling products' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Best selling products from shops of sellers' mod='ets_marketplace'}</span>
                                    </i>
                                </a>
                            </li>
                            <li class="" role="presentation">
                                <a href="#statis_top_seller" aria-controls="tab_statis_top_seller" role="tab" data-toggle="tab">
                                    <i class="fa fa-top-seller"></i>
                                    {l s='Top sellers' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Sellers who have the largest number of sold products' mod='ets_marketplace'}</span>
                                    </i>
                                </a>
                            </li>
                            <li class="" role="presentation">
                                <a href="#statis_top_seller_commission" aria-controls="tab_statis_top_seller_commission" role="tab" data-toggle="tab">
                                    <i class="fa fa-top-seller-commission"></i>
                                    {l s='Top seller commissions' mod='ets_marketplace'}
                                    <i class="ets_tooltip_question">
                                        <svg width="14" height="14" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1376v-192q0-14-9-23t-23-9h-192q-14 0-23 9t-9 23v192q0 14 9 23t23 9h192q14 0 23-9t9-23zm256-672q0-88-55.5-163t-138.5-116-170-41q-243 0-371 213-15 24 8 42l132 100q7 6 19 6 16 0 25-12 53-68 86-92 34-24 86-24 48 0 85.5 26t37.5 59q0 38-20 61t-68 45q-63 28-115.5 86.5t-52.5 125.5v36q0 14 9 23t23 9h192q14 0 23-9t9-23q0-19 21.5-49.5t54.5-49.5q32-18 49-28.5t46-35 44.5-48 28-60.5 12.5-81zm384 192q0 209-103 385.5t-279.5 279.5-385.5 103-385.5-103-279.5-279.5-103-385.5 103-385.5 279.5-279.5 385.5-103 385.5 103 279.5 279.5 103 385.5z"/></svg>
                                        <span class="ets_tooltip" data-tooltip="top">{l s='Sellers who earned the largest amount of commission' mod='ets_marketplace'}</span>
                                    </i>
                                </a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div id="statis_latest_orders" class="tab-pane active ets_mp-content-tab" role="tabpanel">
                                <div class="sub-panel">
                                    <div class="panel-body">
                                        {$latest_orders nofilter}
                                    </div>
                                </div>
                            </div>
                            <div id="statis_latest_seller_commissions" class="tab-pane ets_mp-content-tab" role="tabpanel">
                                <div class="sub-panel">
                                    <div class="panel-body">
                                        {$latest_seller_commissions nofilter}
                                    </div>
                                </div>
                            </div>
                            <div id="statis_latest_products" class="tab-pane ets_mp-content-tab" role="tabpanel">
                                <div class="sub-panel">
                                    <div class="panel-body">
                                        {$latest_products nofilter}
                                    </div>
                                </div>
                            </div>
                            <div id="statis_best_selling_products" class="tab-pane ets_mp-content-tab" role="tabpanel">
                                <div class="sub-panel">
                                    <div class="panel-body">
                                        {$best_selling_products nofilter}
                                    </div>
                                </div>
                            </div>
                            <div id="statis_top_seller" class="tab-pane ets_mp-content-tab" role="tabpanel">
                                <div class="sub-panel">
                                    <div class="panel-body">
                                        {$top_sellers nofilter}
                                    </div>
                                </div>
                            </div>
                            <div id="statis_top_seller_commission" class="tab-pane ets_mp-content-tab" role="tabpanel">
                                <div class="sub-panel">
                                    <div class="panel-body">
                                        {$top_seller_commissions nofilter}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>