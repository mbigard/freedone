{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{include file='_partials/form-errors.tpl' errors=$errors['']}

<form 
  method="POST"
  action-xhr="{url entity='module' name='pkamp' controller='address' relative_protocol=false params=['id_address' => $id_address]}"
  target="_top"
  data-id-address="{$id_address}"
  data-refresh-url="{url entity='address' params=['ajax' => 1, 'action' => 'addressForm']}"
  >
  {block name="address_form_fields"}
    <section class="form-fields">
      {block name='form_fields'}
        {foreach from=$formFields item="field"}
          {block name='form_field'}
            {form_field field=$field}
          {/block}
        {/foreach}
      {/block}
    </section>
  {/block}

  {block name="address_form_footer"}
  <footer class="form-footer flex-container align-items-center">
    <input type="hidden" name="submitAddress" value="1">
    <button class="btn btn-primary float-xs-right" type="submit">
    {l s='Save' d='Shop.Theme.Actions'}
    </button>
    <div submit-success class="p0 m0">&nbsp;{l s='Success' d='Shop.Theme.Amp'}</div>
    <div submit-error class="p0 m0">&nbsp;{l s='Unable to update address' d='Shop.Theme.Amp'}</div>
    <div submitting class="p0 m0">&nbsp;{l s='Waiting' d='Shop.Theme.Amp'}...</div>
  </footer>
  {/block}

</form>