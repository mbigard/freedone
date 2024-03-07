{*
* 2011-2022 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2022 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{assign var="page" value=$page.page_name|replace:'module-pkamp-':''}
{assign var="tglIdSidebar" value="sidebar"}
{assign var="tglIdCart" value="selector-cart"}
{assign var="tglIdMenu" value="selector-menu"}
{assign var="tglIdSearch" value="selector-search"}
{assign var="tglIdTOS" value="selector-tos"}

<amp-sidebar id="{$tglIdSidebar}" layout="nodisplay" side="right" class="flex-container flex-column">

  {include file='mobile/_partials/button-close.tpl' togglerId=$tglIdSidebar togglerTitle={l s='User Area' d='Shop.Theme.Amp'}}

  <div class="user-preview flex-container flex-column align-items-center m30">
    <amp-bodymovin-animation layout="flex-item" width="100" height="100" src="{$amp.global.assets}json/avatar.json" loop="true"></amp-bodymovin-animation>
    <div>
      <strong [hidden]="loginHandler.items.data != null">
      {if $customer.is_logged}
        {$customer.firstname}&nbsp;{$customer.lastname}
      {else}
        {l s='Guest' d='Shop.Theme.Amp'}
      {/if}
      </strong>
      <strong [text]="loginHandler.items.data != null ? '{l s='Hi' d='Shop.Theme.Amp'}, '+loginHandler.items.data.firstname+' '+loginHandler.items.data.lastname : ''"></strong>
    </div>
  </div>
  
  <amp-accordion animate expand-single-section class="m20 sidebar-accordion">

    {if $customer.is_logged != 1}
    <section class="m15" expanded [hidden]="loginHandler.items.is_logged == true">
      {include file='mobile/_partials/accordion-title.tpl' togglerTitle='login'}
      <div>
        {include file='mobile/customer/loginform.tpl'}
      </div>
    </section>
    {/if}

    {if (isset($amp.config.sidebars.lng) && $amp.config.sidebars.lng == 1)}
    <section class="m15">
      {include file='mobile/_partials/accordion-title.tpl' togglerTitle={l s='Languages' d='Shop.Theme.Amp'}}
      <div>
        {include file='mobile/modules/ps_languageselector/ps_languageselector.tpl'}
      </div>
    </section>
    {/if}

    {if (isset($amp.config.sidebars.currencies) && $amp.config.sidebars.currencies == 1)}
    <section class="m15">
      {include file='mobile/_partials/accordion-title.tpl' togglerTitle={l s='Currencies' d='Shop.Theme.Amp'}}
      <div>
        {include file='mobile/modules/ps_currencyselector/ps_currencyselector.tpl'}
      </div>
    </section>
    {/if}

    <section class="m15"{if $customer.is_logged != 1} hidden{/if} [hidden]="loginHandler.items.is_logged == false">
      {include file='mobile/_partials/accordion-title.tpl' togglerTitle={l s='My Account' d='Shop.Theme.Amp'}}
      <div class="my-account flex-container flex-column">
      {include file='mobile/customer/myaccount-links.tpl'}
      </div>
    </section>

  </amp-accordion>

  <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxLogin' relative_protocol=false params=['reload' => true]}" class="m15 w100" on="{literal}submit-success: AMP.setState({ loginHandler: { items: event.response.items } });{/literal}"{if $customer.is_logged != 1} hidden{/if} [hidden]="loginHandler.items.is_logged == false">
    <input type="hidden" name="action" value="logout">
    <input type="hidden" name="redirect" value="{$urls.current_url}">
    <input type="hidden" name="who" value="sidebars-logout">
    <button class="button inv-btn text-center w100" type="submit">
      {l s='Logout' d='Shop.Theme.Amp'}
    </button>

    <div submit-success>
      <div class="flex-container align-items-center flex-column text-center">
        <amp-bodymovin-animation layout="flex-item" width="40" height="40" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation>
        <div>{l s='Logged Out Success' d='Shop.Theme.Amp'}</div>
      </div>
    </div>
  </form>

</amp-sidebar>

<amp-sidebar id="language" layout="nodisplay" side="right" class="flex-container flex-column">
  {include file='mobile/_partials/button-close.tpl' togglerId='language' togglerTitle={l s='Languages' d='Shop.Theme.Amp'}}
  {include file='mobile/modules/ps_languageselector/ps_languageselector.tpl'}
</amp-sidebar>

<amp-sidebar id="currency" layout="nodisplay" side="right" class="flex-container flex-column">
  {include file='mobile/_partials/button-close.tpl' togglerId='currency' togglerTitle={l s='Currencies' d='Shop.Theme.Amp'}}
  {include file='mobile/modules/ps_currencyselector/ps_currencyselector.tpl'}
</amp-sidebar>

{include file='mobile/modules/ps_shoppingcart/ps_shoppingcart.tpl' togglerId=$tglIdCart}

{include file='mobile/modules/ps_mainmenu/ps_mainmenu.tpl' togglerId=$tglIdMenu}

{include file='mobile/modules/ps_searchbar/ps_searchbar.tpl' togglerId=$tglIdSearch}

{if ($page == 'checkout') || ($page == 'order')}
{include file='mobile/_partials/tos.tpl' togglerId=$tglIdTOS}
{/if}