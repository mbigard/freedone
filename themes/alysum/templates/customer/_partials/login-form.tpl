{**
 * 2007-2017 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2017 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
{block name='login_form'}

  {block name='login_form_errors'}
    {include file='_partials/form-errors.tpl' errors=$errors['']}
  {/block}

<form id="login-form" action="{block name='login_form_actionurl'}{$action}{/block}" method="post">

  <section>
    {if ($page.page_name == 'authentication')}
      {assign var=emailText value={l s='Sign in' d='Shop.Theme.Actions'}}
      {$formFields.email.icon = 'email'}
      {$formFields.password.icon = 'password'}
      {$formFields.email.availableValues.placeholder=$emailText}

      {foreach from=$formFields item="field" key="value"}
        {if $formFields.$value.availableValues|is_array}
          {$formFields.$value.availableValues.placeholder = $field.label}
          {$formFields.$value.icon = $field.name}
          {$formFields.$value.show_label = false}
        {/if}
      {/foreach}
    {/if}

    {block name='form_fields'}
      {foreach from=$formFields item="field"}
        {block name='form_field'}
          {form_field field=$field}
        {/block}
      {/foreach}
    {/block}

    <div class="forgot-password flex-container">

      <input type="hidden" name="submitLogin" value="1">
      <a href="{$urls.pages.password}" rel="nofollow" style="flex-grow:1">
        {l s='Forgot your password?' d='Shop.Theme.Customeraccount'}
      </a>

      {hook h='displayFacebookConnect'}&nbsp;
      {block name='form_buttons'}
        <button class="btn btn-primary form-control-submit" data-link-action="sign-in" type="submit">
          {l s='Sign in' d='Shop.Theme.Actions'}
        </button>
      {/block}

    </div>
  </section>

</form>
{/block}
