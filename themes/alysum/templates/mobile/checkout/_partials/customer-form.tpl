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

<form action="{$action}" id="customer-form" class="js-customer-form" method="post">
  <section>

    {foreach from=$formFields item="field" key="value"}
      {if $formFields.$value.availableValues|is_array}
      {*
        {$formFields.$value.availableValues.placeholder = $field.label}
        {$formFields.$value.icon = $field.name}
        {$formFields.$value.show_label = true}
      *}
      {/if}
    {/foreach}

    {block "form_fields"}
      {foreach from=$formFields item="field"}
        {block "form_field"}
          {form_field field=$field}
        {/block}
      {/foreach}
      {$hook_create_account_form nofilter}
    {/block}
  </section>

  {block name='customer_form_footer'}
  <footer class="form-footer clearfix">
    <input type="hidden" name="submitCreate" value="1">
    {block "form_buttons"}
      <button class="btn btn-primary form-control-submit pull-xs-right" data-link-action="save-customer" type="submit">
        {l s='Save' d='Shop.Theme.Actions'}
      </button>
    {/block}
  </footer>
  {/block}

</form>
{/block}