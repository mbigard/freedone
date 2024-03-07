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
<section class="my-account flex-container flex-column">
  <h2 class="page-title">{l s='My Account' d='Shop.Theme.Amp'}</h2>
  <div class="my-account flex-container flex-column">
  {include file='mobile/customer/myaccount-links.tpl'}
  </div>
</section>
{/block}