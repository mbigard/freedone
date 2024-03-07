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

      <header>
        <p class="send-renew-password-link">
          {l s='Please enter the email address you used to register. You will receive a temporary link to reset your password.' d='Shop.Theme.Customeraccount'}
        </p>
      </header>

      <section class="form-fields">
        <input type="email" name="email" id="email" value="{if isset($smarty.post.email)}{$smarty.post.email|stripslashes}{/if}" class="form-control m15 password-forgot" required placeholder="{l s='Email address' d='Shop.Forms.Labels'}">
      </section>

      <div submit-success class="p0 m15">
         <template type="amp-mustache">
          {l s='We have sent a link to reset your password to your email' d='Shop.Theme.Amp'}
        </template>
      </div>

      <div submit-error class="p0 m15">
         <template type="amp-mustache">
          {literal}{{errors.0}}{/literal}
        </template>
      </div>

      <footer class="form-footer">
        <button class="form-control-submit btn btn-primary big-btn" name="submit" type="submit" on="{literal}change:AMP.setState({ passwordState: {success: success} }){/literal}">
          {l s='Send reset link' d='Shop.Theme.Actions'}
        </button>
      </footer>

    </form>

    <amp-state id="passwordState">
      <script type="application/json">
        {literal}
        {
          "errors": "",
          "success": ""
        }
        {/literal}
       </script>
    </amp-state>
    
  {/block}

</section>
{/block}