{**
 * Copyright since 2007 PrestaShop SA and Contributors
 * PrestaShop is an International Registered Trademark & Property of PrestaShop SA
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.md.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://devdocs.prestashop.com/ for more information.
 *
 * @author    PrestaShop SA and Contributors <contact@prestashop.com>
 * @copyright Since 2007 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 *}

{block name='customer_form'}
    {block name='customer_form_errors'}
      {include file='_partials/form-errors.tpl' errors=$errors['']}
    {/block}
    <form action="{block name='customer_form_actionurl'}{(isset($custom_action)) ? $custom_action : $action}{/block}" id="customer-form" class="js-customer-form" method="post">
      <section class="{if isset($custom_action)}container{/if}">
        {$formFields.birthday.icon = 'info'}
        {$formFields.firstname.icon = 'account'}
        {$formFields.lastname.icon = 'account'}

        {foreach from=$formFields item="field" key="value"}
            {if !empty($formFields.$value.availableValues)}
                {$formFields.$value.icon = (isset($formFields.$value.icon)) ? $formFields.$value.icon : $field.name}
            {/if}
        {/foreach}

        {block "form_fields"}
          {foreach from=$formFields item="field"}
            {block "form_field"}
              {if $field.type === "password"}
                <div class="field-password-policy">
                  {form_field field=$field}
                </div>
              {else}
                {form_field field=$field}
              {/if}
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
            {l s='Register' d='Shop.Theme.Actions'}
          </button>
        {/block}
      </footer>
      {/block}
    </form>
{/block}