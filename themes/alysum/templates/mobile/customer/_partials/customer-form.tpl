{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{block name='customer_form'}
  {block name='customer_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

{if (!empty($error))}
<div class="notification error">{$error}</div><br>
{/if}
<form  method="POST" action-xhr="{url entity='module' name={$amp.global.name} controller='login' relative_protocol=false}" target="_top">
  <section>

    {block "form_fields"}
      {foreach from=$formFields item="field"}
        {block "form_field"}
          {form_field field=$field}
        {/block}
      {/foreach}
      {$hook_create_account_form nofilter}
    {/block}
    <div class="form-item m15">
      {if isset($amp.gdpr.psgdpr_creation_form.id_module)}
      {include file='mobile/_partials/gdpr.tpl' gdpr=$amp.gdpr.psgdpr_creation_form}
      {/if}
    </div>
  </section>

  <footer class="form-footer">
    <input type="hidden" name="submitCreate" value="1">
    <button type="submit">{l s='Save' d='Shop.Theme.Actions'}</button>
  </footer>

</form>
{/block}