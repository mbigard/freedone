{*
* 2007-2021 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2021 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{block name="page_title" hide}
    {l s='Customer service - Contact us' d='Modules.Contactform.Shop'}
{/block}

{function name="svgic" id='' class=''}
    <svg class="svgic {$class}">
        <use href="{_THEME_IMG_DIR_}lib.svg#{$id}"></use>
    </svg>
{/function}

<div class="row contact-page">
    {hook h='displayBeforeContactForm'}
    {if isset($pktheme.cont_show_map) && $pktheme.cont_show_map == 1}
        <section class="contact-form-map col-sm-12 col-md-6">
            {if isset($pktheme.cont_map_provider) && $pktheme.cont_map_provider == 'google'}
                <div id="pk-map" class="google-maps w100"
                    data-key="{if isset($pktheme.cont_google_api_key) && $pktheme.cont_google_api_key != ''}{$pktheme.cont_google_api_key}{else}not_defined{/if}"
                    data-latitude="{if isset($pktheme.cont_latitude) && $pktheme.cont_latitude != ''}{$pktheme.cont_latitude}{else}38.052392{/if}"
                    data-longitude="{if isset($pktheme.cont_longitude) && $pktheme.cont_longitude != ''}{$pktheme.cont_longitude}{else}-1.234562{/if}"
                    data-address="{$shop.address.postcode}+{$shop.address.address1}+{$shop.address.address2}+{$shop.address.city}+{$shop.address.state}+{$shop.address.country}">
                    {svgic id='down' class='in_progress'}
                </div>
            {/if}
            {if isset($pktheme.cont_map_provider) && $pktheme.cont_map_provider == 'leaflet'}
                <div id="leaflet-map" class="google-maps w100">
                {svgic id='down' class='in_progress'}
                </div>
            {/if}
        </section>
    {/if}

    <section class="col-sm-12 col-md-6">
        <form class="contactform-captcha" action="{$urls.pages.contact}" method="post"
            {if $contact.allow_file_upload}enctype="multipart/form-data" {/if}>
            <input type="hidden" name="url" value="">
            <input type="hidden" name="token" value="{$token}">
            <header>
                <h3 class="h3">{l s='Send a message' d='Modules.Contactform.Shop'}</h3>
            </header>

            {if $notifications}
                <div class="notification alert {if $notifications.nw_error}alert-danger{else}alert-success{/if}">
                    <ul class="m-0">
                        {foreach $notifications.messages as $notif}
                            <li>{$notif}</li>
                        {/foreach}
                    </ul>
                </div>
            {/if}

            <section class="form-fields">

                <div class="form-group">
                    <select name="id_contact" class="form-control form-control-select">
                        <option value="" disabled>{l s='Subject Heading' d='Modules.Contactform.Shop'}</option>
                        {foreach from=$contact.contacts item=contact_elt name=contc}
                            <option value="{$contact_elt.id_contact}" {if $smarty.foreach.contc.index == 0} selected{/if}>
                                {$contact_elt.name}
                            </option>
                        {/foreach}
                    </select>
                </div>

                {if $contact.orders}
                    <div class="form-group">
                        <select name="id_order" class="form-control form-control-select">
                            <option value="">{l s='Select reference' d='Modules.Contactform.Shop'}</option>
                            {foreach from=$contact.orders item=order}
                                <option value="{$order.id_order}">{$order.reference}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}

                {if $contact.allow_file_upload}
                    <div class="form-group hidden">
                        <input type="file" name="fileUpload"
                            placeholder="{l s='Attach File' d='Modules.Contactform.Shop'}" />
                    </div>
                {/if}

                <div class="form-group">
                    <div class="icon-true relative">
                        <input type="email" name="from" class="form-control" value="{$contact.email}" required
                            placeholder="{l s='Email address' d='Modules.Contactform.Shop'}" />
                        {svgic id='email' class='input-icon'}
                    </div>
                </div>

                <div class="form-group">
                    <div class="icon-true relative">
                        <textarea cols="67" rows="3" name="message"
                            placeholder="{l s='Message' d='Modules.Contactform.Shop'}">{if $contact.message}{$contact.message}{/if}</textarea>
                            {svgic id='pencil' class='input-icon'}
                    </div>
                </div>

                {if isset($id_module)}
                    <div class="form-group">
                        {hook h='displayGDPRConsent' id_module=$id_module}
                    </div>
                {/if}

            </section>

            <footer class="form-footer">
                <button type="submit" class="btn btn-primary" name="submitMessage">
                    {l s='Send Message' d='Modules.Contactform.Shop'}
                </button>
            </footer>

        </form>
    </section>
    {hook h='displayAfterContactForm'}
</div>

<div class="row contact-page-footer">
    {if isset($pktheme.cont_address_block) && $pktheme.cont_address_block}
        <div class="col-lg-3 col-md-6 col-xs-12">
            {svgic id='location'}
            <h6>{l s='Our Location' d='Modules.Contactform.Shop'}</h6>
            <p class="addr">
                {$shop.address.formatted nofilter}
            </p>
        </div>
    {/if}
    {if isset($pktheme.cont_email_block) && $pktheme.cont_email_block}
        <div class="col-lg-3 col-md-6 col-xs-12">
            {svgic id='email'}
            <h6>{l s='Contact details' d='Modules.Contactform.Shop'}</h6>
            <p>
                {l s='Email' d='Modules.Contactform.Shop'}: {$shop.email}<br>
                {$shop.registration_number}
            </p>
        </div>
    {/if}
    {if isset($pktheme.cont_phones_block) && $pktheme.cont_phones_block}
        <div class="col-lg-3 col-md-6 col-xs-12">
            {svgic id='phone'}
            <h6>{l s='Contact us' d='Modules.Contactform.Shop'}</h6>
            <p>
                {l s='Phone' d='Modules.Contactform.Shop'}: {$shop.phone}<br>
                {if ($shop.fax != "")}
                    {l s='Fax' d='Modules.Contactform.Shop'}: {$shop.fax}
                {/if}
            </p>
        </div>
    {/if}
    {if isset($pktheme.cont_service_block) && $pktheme.cont_service_block}
        <div class="col-lg-3 col-md-6 col-xs-12">
            {svgic id='headphones'}
            <h6>{l s='24/h customer service' d='Modules.Contactform.Shop'}</h6>
            <p>
                {l s='We providing really fast and professional support' d='Modules.Contactform.Shop'}
            </p>
        </div>
    {/if}
</div>