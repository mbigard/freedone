{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/checkout/_partials/steps/checkout-step.tpl'}

{block name='step_content'}
  {if $customer.is_logged && !$customer.is_guest}

    <p class="identity">
      {* [1][/1] is for a HTML tag. *}
      {l s='Connected as [1]%firstname% %lastname%[/1].'
        d='Shop.Theme.Customeraccount'
        sprintf=[
          '[1]' => "<a href='{$amp.global.urls.identity}'>",
          '[/1]' => "</a>",
          '%firstname%' => $customer.firstname,
          '%lastname%' => $customer.lastname
        ]
      }
    </p>
    <form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxLogin' relative_protocol=false params=['reload' => true]}" class="m15 w100" on="{literal}submit-success: AMP.setState({ loginHandler: { items: event.response.items } });{/literal}"{if $customer.is_logged != 1} hidden{/if} [hidden]="loginHandler.items.is_logged == false">
      <input type="hidden" name="action" value="logout">
      <input type="hidden" name="redirect" value="{$urls.current_url}">
      <input type="hidden" name="who" value="sidebars-logout">
      <button class="button inv-btn text-center w100" type="submit">
        {l s='Logout' d='Shop.Theme.Amp'}
      </button>
    </form>
    {if !isset($empty_cart_on_logout) || $empty_cart_on_logout}
      <p class="notification alert">{l s='If you log out now, your cart will be emptied.' d='Shop.Theme.Checkout'}</p>
    {/if}

  {else}

    <div class="flex-container align-items-center m30">
      <div class="flex-grow1">
        <h3>
        <a
          class="nav-link {if !$show_login_form}active{/if}"
          data-toggle="tab"
          href="#checkout-guest-form"
          role="tab"
          aria-controls="checkout-guest-form"
          {if !$show_login_form} aria-selected="true"{/if}
          >
          {if $guest_allowed}
            {l s='Order as a guest' d='Shop.Theme.Checkout'}
          {else}
            {l s='Create an account' d='Shop.Theme.Customeraccount'}
          {/if}
        </a>
        </h3>
      </div>
      <div>
        <a href="#" on="tap:sidebar.toggle" class="button" role="tab" aria-controls="checkout-guest-form" {if !$show_login_form} aria-selected="true"{/if}>
          {l s='Sign in' d='Shop.Theme.Actions'}
        </a>
      </div>
    </div>

    <div class="tab-content">
      <div class="tab-pane {if !$show_login_form}active{/if}" id="checkout-guest-form" role="tabpanel">
        {render file='mobile/checkout/_partials/customer-form.tpl' ui=$register_form guest_allowed=$guest_allowed}
      </div>
      <div class="tab-pane {if $show_login_form}active{/if}" id="checkout-login-form" role="tabpanel">
        
      </div>
    </div>


  {/if}
{/block}