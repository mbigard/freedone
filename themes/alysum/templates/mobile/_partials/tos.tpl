{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{assign var="togglerId" value="selector-tos"}

<amp-sidebar id="{$togglerId}" class="lang-select user-select relative" layout="nodisplay" side="right">

  {include file='mobile/_partials/button-close.tpl' togglerId=$togglerId togglerTitle={l s='Our Terms' d='Shop.Theme.Amp'}}

  <div>
    {$amp.cms.tos_page.content nofilter}
  </div>
  <div class="flex-container align-items-center m20">
    <button on="tap:{$togglerId}.close" role="button" tabindex="0">{l s='I Agree' d='Shop.Theme.Amp'}</button>
  </div>

</amp-sidebar>