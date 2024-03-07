{assign var='widget_name' value='el-myaccount'}
{assign var='rootClasses' value=['myaccount-select', 'user-select', 'relative', 'dib']}
{if isset($dropdown_position)}
    {append var='rootClasses' value="pk-position-{$dropdown_position}"}
{/if}
{if isset($skin) && $skin == 'inline'}
    {append var='rootClasses' value="pk-inline"}
{/if}
{assign var='a_start' value="<a href='{$urls.pages.my_account}'>"}
{assign var='a_end' value='</a>'}

{function name="printlink" link='#' title=''}
<li class="smooth02 relative">
    <a href="{$link}" title="{$title}">{$title}</a>
</li>
{/function}

{function name="linksblock" skin=false}
<ul class="opt-list{if $skin == 'dropdown'} dd_container dd_view{/if}{if $skin == 'sidebar'} sidebar-ul{/if}">
    {printlink link="/mon-compte" title="{l s='Mon compte' d='Shop.Theme.Customeraccount'}"}
    {if isset($show_information) && ($show_information == 'yes')}
        {printlink link="{$urls.pages.identity}" title="{l s='Information' d='Shop.Theme.Customeraccount'}"}
    {/if}
    {if isset($show_addresses) && ($show_addresses == 'yes')}
        {if $customer.addresses|count}

        {else}
            {printlink link="{$urls.pages.address}" title="{l s='Add first address' d='Shop.Theme.Customeraccount'}"}
        {/if}
    {/if}
    {if !$configuration.is_catalog}
        {if isset($show_history) && ($show_history == 'yes')}
            {printlink link="{$urls.pages.history}" title="{l s='Commandes' d='Shop.Theme.Customeraccount'}"}
        {/if}
        {if isset($show_order_slip) && ($show_order_slip == 'yes')}
            {printlink link="{$urls.pages.order_slip}" title="{l s='Credit slips' d='Shop.Theme.Customeraccount'}"}
        {/if}
        {if isset($show_vouchers) && ($show_vouchers == 'yes') && $configuration.voucher_enabled}
            {printlink link="{$urls.pages.discount}" title="{l s='Vouchers' d='Shop.Theme.Customeraccount'}"}
        {/if}
        {if isset($show_returns) && ($show_returns == 'yes') && $configuration.return_enabled}
            {printlink link="{$urls.pages.order_follow}" title="{l s='Merchandise returns' d='Shop.Theme.Customeraccount'}"}
        {/if}
        {if isset($show_signout) && ($show_signout == 'yes') && ($customer.is_logged == 1)}
            {printlink link="{$urls.actions.logout}" title="{l s='Sign out' d='Shop.Theme.Actions'}"}
        {/if}
    {/if}
</ul>
{if $skin == 'sidebar'}
<br>
<a class="btn btn-primary" href="{$urls.pages.my_account}">{l s='My Account' d='Modules.Pkelements.Shop'}</a>
{/if}
{/function}

<div class="{' '|implode:$rootClasses}">
    <div class="pk-myaccount{if $skin == 'dropdown'} dd_el{/if}">
        {if isset($button_layout) && isset($button_view)}
        {assign var=params value=[
            "title" => "{l s='My Account' d='Modules.Pkelements.Shop'}",
            "layout" => $button_layout,
            "view" => $button_view,
            "icon" => 'account',
            "sidebar" => (isset($skin) && $skin == 'sidebar') ? true : false,
            "name" => $widget_name
        ]}
        {include file='module:pkelements/views/templates/_partials/headeritems/headeritem.tpl' params=$params}
        {* {sprintf("%s $a_content %s", "$a_start", "$a_end") nofilter} *}
        {/if}
        {if (isset($skin) && $skin != 'sidebar')}
            {linksblock skin=$skin}
        {/if}
    </div>
</div>
