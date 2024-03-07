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
<section class="history">
  {block name='page_content'}
    <section class="register-form">
      <p>{l s='Already have an account?' d='Shop.Theme.Customeraccount'} <a href="{$amp.global.urls.login}">{l s='Log in instead!' d='Shop.Theme.Customeraccount'}</a></p>
      {render file='mobile/customer/_partials/customer-form.tpl' ui=$register_form}
    </section>
  {/block}
</section>
{/block}