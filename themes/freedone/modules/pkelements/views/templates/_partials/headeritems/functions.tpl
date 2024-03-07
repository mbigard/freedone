{*
* Promokit Header Items Module
*
* @package   alysum
* @version   1.1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   You only can use module, nothing more!
*}

{function name="printlink" link='#' title=''}
    <li class="smooth02">
        <a href="{$link}" title="{$title}">{$title}</a>
    </li>
{/function}

{function name="myaccount"}
    <ul class="sidebar-ul">
        {printlink link="/mon-compte" title="{l s='Compte client' d='Shop.Theme.Customeraccount'}"}
        {printlink link="/seller-dashboard" title="{l s='Compte vendeur' d='Shop.Theme.Customeraccount'}"}
        {if $customer.addresses|count}
            {printlink link="{$urls.pages.addresses}" title="{l s='Addresses' d='Shop.Theme.Customeraccount'}"}
        {else}
            {printlink link="{$urls.pages.address}" title="{l s='Add first address' d='Shop.Theme.Customeraccount'}"}
        {/if}
        {if !$configuration.is_catalog}
            {printlink link="{$urls.pages.history}" title="{l s='Order history and details' d='Shop.Theme.Customeraccount'}"}
            {printlink link="{$urls.pages.order_slip}" title="{l s='Credit slips' d='Shop.Theme.Customeraccount'}"}
            {if $configuration.voucher_enabled}
                {printlink link="{$urls.pages.discount}" title="{l s='Vouchers' d='Shop.Theme.Customeraccount'}"}
            {/if}
            {if $configuration.return_enabled}
                {printlink link="{$urls.pages.order_follow}" title="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}"}
            {/if}
            {if ($customer.is_logged == 1)}
                {printlink link="{$urls.actions.logout}" title="{l s='Sign out' d='Shop.Theme.Actions'}"}
            {/if}
        {/if}
    </ul>
    <br>
    <a class="btn btn-primary" href="{$urls.pages.my_account}">{l s='Your account' d='Shop.Theme.Customeraccount'}</a>
{/function}

{function name="printformitem" itemdata=[]}
    <div class="relative">
        <div class="icon-true">
            <input autocomplete="off" class="form-control" name="{$itemdata.name}" type="{$itemdata.type}" value=""
                placeholder="{$itemdata.ph}" required="">
            <span class="focus-border"><i></i></span>
            <svg class="svgic input-icon maincolor">
                <use href="{_THEME_IMG_DIR_}lib.svg#{$itemdata.icon}"></use>
            </svg>
        </div>
    </div>
{/function}

{function name="languages"}
    <ul class="sidebar-ul">
        {foreach from=$pklanguage.languages item=language}
            <li class="flex-container">
                <a class="flex-container align-items-center" href="{url entity='language' id=$language.id_lang}"
                    title="{$language.name}">
                    <img class="db" src="{$urls.img_lang_url}{$language.id_lang}.jpg" width="16" height="11"
                        alt="{$language.name_simple}">&nbsp;{$language.name_simple}
                </a>
            </li>
        {/foreach}
    </ul>
{/function}

{function name="currencies"}
    <ul class="sidebar-ul">
        {foreach from=$pkcurrencies.currencies item=currency}
            {if $pkcurrencies.current_currency.iso_code != $currency.iso_code}
                <li class="flex-container">
                    <a class="db" href="{$currency.url}" title="{$currency.name}" rel="nofollow">
                        {$currency.iso_code} {$currency.sign}
                    </a>
                </li>
            {/if}
        {/foreach}
    </ul>
{/function}

{if isset($show_myaccount)}
    {myaccount}
{/if}

{if isset($printformitem)}
    {printformitem itemdata=$itemdata}
{/if}

{if isset($show_languages)}
    {languages}
{/if}

{if isset($show_currencies)}
    {currencies}
{/if}
