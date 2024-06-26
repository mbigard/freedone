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
{if Ets_mp_seller::getMaps(false,true)}
{if $is_17}
    {if $ETS_MP_GOOGLE_MAP_API}
    <script>
        {literal}
        var address_autocomplete;
        
        var componentForm = {
          locality: 'long_name',
          country: 'short_name',
          postal_code: 'short_name'
        };
        
        function ets_mp_initAutocomplete() {
          address_autocomplete = new google.maps.places.Autocomplete(
              document.getElementById('addressInput'), {types: ['geocode']});
          address_autocomplete.setFields(['address_component']);
          address_autocomplete.addListener('place_changed', ets_mp_fillInAddress);
        }
        function ets_mp_fillInAddress() {
            return true;
        }
        {/literal}
    </script>
        <script src="https://maps.googleapis.com/maps/api/js?key={$ETS_MP_GOOGLE_MAP_API|escape:'html':'UTF-8'}&libraries=places&callback=ets_mp_initAutocomplete" async defer></script>
    {else}
        <script src="{$link_map_google nofilter}"></script>
    {/if}
{/if}
<header class="page-header">
    <h1> {l s='Store locations' mod='ets_marketplace'} </h1>
</header>
<div id="stores">
    <div id="map"></div>
    {if isset($ETS_MP_GOOGLE_MAP_API) && $ETS_MP_GOOGLE_MAP_API && isset($ETS_MP_SEARCH_ADDRESS_BY_GOOGLE) && $ETS_MP_SEARCH_ADDRESS_BY_GOOGLE}
        <div class="ets_stores_map">
            <p class="store-title">
            	<strong class="dark">
            		{l s='Enter a location (e.g. zip/postal code, address, city or country) in order to find the nearest stores.' mod='ets_marketplace'}
            	</strong>
            </p>
            <div class="store-content">
                <div class="address-input">
                    <label for="addressInput">{l s='Your location:' mod='ets_marketplace'}</label>
                    <input class="form-control grey" type="text" name="location" id="addressInput" value="" placeholder="{l s='Address, zip / postal code, city, state or country' mod='ets_marketplace'}" />
                </div>
                <div class="radius-input">
                    <label for="radiusSelect">{l s='Radius (km):' mod='ets_marketplace'}</label>
                    <select name="radius" id="radiusSelect" class="form-control">
                        <option value="15">15</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                        <option value="100">100</option>
                    </select>
                    <img src="{$base_link|escape:'html':'UTF-8'}/modules/ets_marketplace/views/img/loader.gif" class="middle" alt="" id="stores_loader" />
                </div>
                <div class="mp_map_button_group">
                    <button name="search_locations" class="button btn btn-default button-small btn-primary">
                    	<span>
                    		{l s='Search' mod='ets_marketplace'}
                    	</span>
                    </button>
                    <button name="reset_locations" class="button btn btn-default button-small btn-primary">
                    	<span>
                    		{l s='Refresh' mod='ets_marketplace'}
                    	</span>
                    </button>
                </div>
            </div>
            <div class="alert alert-warning" style="display:none"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='No stores were found. Please try selecting a wider radius.' mod='ets_marketplace'}</div>
            <div class="store-content-select selector3" style="">
            	<select id="locationSelect" class="form-control">
            		<option>-</option>
            	</select>
            </div>
            <div class="table-responsive">
                <table id="stores-table" class="table table-bordered">
                	<thead>
            			<tr>
                            <th class="num">{l s='Numerical order' mod='ets_marketplace'}</th>
                            <th>{l s='Store' mod='ets_marketplace'}</th>
                            <th>{l s='Address' mod='ets_marketplace'}</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
            	</table>
            </div>
         </div>
     {/if}
</div>
<script type="text/javascript">
var markers=[];
var infoWindow = '';
var locationSelect = '';
var defaultLat = '{$coordinates.defaultLat|escape:'html':'UTF-8'}';
var defaultLong = '{$coordinates.defaultLong|escape:'html':'UTF-8'}';;
var hasStoreIcon = true;
var distance_unit = 'km';
var img_ps_dir = '{$base_link|escape:'html':'UTF-8'}/modules/ets_marketplace/views/img/';
var searchUrl = '{$link->getModuleLink('ets_marketplace','map',['getmaps'=>1]) nofilter}';
var logo_map = {if Configuration::get('ETS_MP_GOOGLE_MAP_LOGO')}'{Configuration::get('ETS_MP_GOOGLE_MAP_LOGO')|escape:'html':'UTF-8'}'{else}'logo_map.png'{/if};
var translation_1 = '{l s='No stores were found. Please try selecting a wider radius.' mod='ets_marketplace' js=1}';
var translation_2 = '{l s='store found -- see details:' mod='ets_marketplace' js=1}';
var translation_3 = '{l s='stores found -- view all results:' mod='ets_marketplace' js=1}';
var translation_4 = '{l s='Phone:' mod='ets_marketplace' js=1}' ;
var translation_5 = '{l s='Get directions' mod='ets_marketplace' js=1}';
var translation_6 = '{l s='Not found' mod='ets_marketplace' js=1}';
</script>
{else}
    <div class="alert alert-warning"><svg width="20" height="20" viewBox="0 0 1792 1792" xmlns="http://www.w3.org/2000/svg"><path d="M1024 1375v-190q0-14-9.5-23.5t-22.5-9.5h-192q-13 0-22.5 9.5t-9.5 23.5v190q0 14 9.5 23.5t22.5 9.5h192q13 0 22.5-9.5t9.5-23.5zm-2-374l18-459q0-12-10-19-13-11-24-11h-220q-11 0-24 11-10 7-10 21l17 457q0 10 10 16.5t24 6.5h185q14 0 23.5-6.5t10.5-16.5zm-14-934l768 1408q35 63-2 126-17 29-46.5 46t-63.5 17h-1536q-34 0-63.5-17t-46.5-46q-37-63-2-126l768-1408q17-31 47-49t65-18 65 18 47 49z"/></svg> {l s='Shop not found' mod='ets_marketplace'}</div>
{/if}