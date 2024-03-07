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
  <h2 class="page-title">{l s='Login' d='Shop.Theme.Amp'}</h2>
  {block name='page_content'}
  <section class="login-form">
    {render file='mobile/customer/_partials/login-form.tpl' ui=$login_form}
  </section>
  {/block}
</section>
{/block}