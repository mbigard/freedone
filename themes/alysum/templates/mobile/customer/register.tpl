{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<form method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxLogin' params=['who' => 'sidebars-register']}" class="m15">

  <input type="hidden" value="1" name="submitCreate">
  <input type="hidden" value="0" name="newsletter">
  <input type="hidden" value="0" name="optin">
  <input type="hidden" value=""  name="id_customer">
  <input type="hidden" value="1" name="id_gender">

  <input class="wide-input m15" value="" required name="email" type="email" placeholder="{l s='Email' d='Shop.Theme.Amp'}">

  <input class="wide-input m15" value="" required name="firstname" type="firstname" placeholder="{l s='First Name' d='Shop.Theme.Amp'}">    

  <input class="wide-input m15" value="" required name="lastname" type="text" placeholder="{l s='Last Name' d='Shop.Theme.Amp'}">
      
  <div class="relative flex-container tos_link m15">
    <input class="form-control" name="tos" id="tos" type="checkbox" value="1" required style="width:20px">
    <label for="tos">{l s='I agree to the' d='Shop.Theme.Amp'}&nbsp;<a href="{$main_links.tos_link}" target="_blank">{l s='terms of service' d='Shop.Theme.Amp'}</a></label>
  </div>

  <button type="submit">{l s='Register' d='Shop.Theme.Amp'}</button>

</form>