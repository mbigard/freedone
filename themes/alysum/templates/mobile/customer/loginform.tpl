{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxLogin' relative_protocol=false params=['who' => 'sidebars-login']}" class="m15" on="{literal}submit-success: AMP.setState({ loginHandler: { items: event.response.items } });{/literal}">

  <div [hidden]="loginHandler.items.data != null || loginHandler.items.messages.add == true">

    <input value="login" type="hidden" name="action" [value]="userState.register == 1 ? 'register' : 'login'">

    <input class="wide-input m15" value="" required type="email" name="email" placeholder="{l s='Email' d='Shop.Theme.Amp'}">
    <input class="wide-input m15" value="" required type="hidden" name="firstname" placeholder="{l s='First Name' d='Shop.Theme.Amp'}" [type]="userState.register == 0 ? 'hidden' : 'text'">
    <input class="wide-input m15" value="" required type="hidden" name="lastname" placeholder="{l s='Last Name' d='Shop.Theme.Amp'}" [type]="userState.register == 0 ? 'hidden' : 'text'">
    <input class="wide-input m15" value="" autocomplete="off" required type="password" name="password" placeholder="{l s='Password' d='Shop.Forms.Labels'}">

    {if Configuration::get('PS_CONDITIONS') == 1}
    <div class="relative flex-container tos_link m15" role="button" tabindex="0">
      <input name="tos" id="tos" type="hidden" value="1" required style="width:20px" [type]="userState.register == 0 ? 'hidden': 'checkbox'" on="change:selector-tos.toggle">
      <label for="tos">{l s='I agree to the' d='Shop.Theme.Amp'}&nbsp;<span>{l s='terms of service' d='Shop.Theme.Amp'}</span></label>
    </div>
    {/if}

    <div class="relative flex-container tos_link m15">
      <input class="form-control p0" name="want_register" id="want_register" type="checkbox" value="1" on="{literal}change:AMP.setState({ userState: {register: event.checked} }){/literal}">
      <label for="want_register">{l s='I want to register' d='Shop.Theme.Amp'}</label>
    </div>

  </div>

  <div class="flex-container align-items-center m15 user-actions">

    <button class="btn btn-primary" type="submit" [hidden]="((userState.register) == 1 || (loginHandler.items.data != null))">{l s='Login' d='Shop.Theme.Amp'}</button>

    <button class="btn btn-primary" type="submit" hidden [hidden]="((userState.register) != 1 || (loginHandler.items.data != null))"
    >{l s='Register' d='Shop.Theme.Amp'}</button>

    <div submitting>
      {l s='Waiting' d='Shop.Theme.Amp'}...
    </div>

    <div class="w100 text-center" submit-error>
      <div [hidden]="userState.register == 1">{l s='Unable to Login' d='Shop.Theme.Amp'}</div>
      <div hidden [hidden]="userState.register != 1">{l s='Unable to Register' d='Shop.Theme.Amp'}</div>
    </div>

    <div class="w100 text-center" submit-success>
      <div [hidden]="userState.register == 1">{l s='You are logged in' d='Shop.Theme.Amp'}</div>
      <div hidden [hidden]="userState.register != 1">{l s='Registration Succeed' d='Shop.Theme.Amp'}</div>
    </div>

  </div>

</form>

<a href="{$amp.global.urls.password}" rel="nofollow" [hidden]="loginHandler.items.data != null || userState.register == 1">{l s='Forgot your password?' d='Shop.Theme.Amp'}</a>

<amp-state id="loginHandler" src="{url entity='module' name={$amp.global.name} controller='ajaxLogin' relative_protocol=false params=['who' => 'sidebars-state']}"></amp-state>

<amp-state id="userState">
  <script type="application/json">
    {literal}
    {
      "register": "0"
    }
    {/literal}
   </script>
</amp-state>