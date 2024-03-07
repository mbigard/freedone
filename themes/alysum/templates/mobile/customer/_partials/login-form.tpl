{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='login_form'}
{if (!empty($error))}
<div class="notification error">{$error}</div><br>
{/if}
<form  method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='login' relative_protocol=false}" target="_top" class="m15">
  {block name='form_fields'}
    {foreach from=$formFields item="field"}
      {block name='form_field'}
        {form_field field=$field}
      {/block}
    {/foreach}
  {/block}
  <div class="flex-container align-items-center">
    <input type="hidden" name="submitLogin" value="1">
    <a href="{$amp.global.urls.password}" rel="nofollow" class="flex-grow1">
      {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
    </a>
    <div submitting class="p0 m0">{l s='Waiting' d='Shop.Theme.Amp'}...&nbsp;</div>
    <button class="btn" type="submit">{l s='Sign in' d='Shop.Theme.Actions'}</button>
  </div>
</form>

<div class="align-items-center flex-container">
  <span class="flex-grow1">
    {l s='Do not have an account yet, please register.' d='Shop.Theme.Customeraccount'}
  </span>
  <a class="btn" href="{$amp.global.urls.login}?create_account=1">
    {l s='Register' d='Shop.Theme.Actions'}
  </a>
</div>
{/block}