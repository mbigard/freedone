{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='content'}
<section class="identity">
  
  <h2 class="page-title">{l s='Password Recovery' d='Shop.Theme.Amp'}</h2>

  {block name='page_content'}
    
    <form action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxPassword' relative_protocol=false}" class="forgotten-password" method="POST" target="_top">
   
      <section class="form-fields flex-container flex-column password-recovery-form">

        <label>
          <span>{l s='Email address: %email%' d='Shop.Theme.Customeraccount' sprintf=['%email%' => $customer_email|stripslashes]}</span>
        </label>

        <label>
          <input type="password" class="form-control m15" data-validate="isPasswd" name="passwd" value="" placeholder="{l s='New password' d='Shop.Forms.Labels'}">
        </label>

        <label>
          <input type="password" class="form-control m15" data-validate="isPasswd" name="confirmation" value="" placeholder="{l s='Confirmation' d='Shop.Forms.Labels'}">
        </label>

      </section>

      <div submit-success class="p0 m15">
         <template type="amp-mustache">
          {l s='Your password has been changed successfully' d='Shop.Theme.Amp'}
        </template>
      </div>

      <div submit-error class="p0 m15">
         <template type="amp-mustache">
          {l s='Some error occured' d='Shop.Theme.Amp'}
        </template>
      </div>

      <footer class="form-footer">
        <input type="hidden" name="token" id="token" value="{$customer_token}">
        <input type="hidden" name="id_customer" id="id_customer" value="{$id_customer}">
        <input type="hidden" name="reset_token" id="reset_token" value="{$reset_token}">
        <button type="submit" name="submit" class="btn">
          {l s='Change Password' d='Shop.Theme.Actions'}
        </button>
      </footer>

    </form>
    
  {/block}

</section>
{/block}