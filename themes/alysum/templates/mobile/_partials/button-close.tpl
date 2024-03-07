{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<div class="close-section flex-container align-items-center m20">
  {if isset($togglerTitle) && !empty($togglerTitle)}
    <h4 class="flex-grow1 text-uppercase">{$togglerTitle}</h4>
  {/if}
  <amp-img class="amp-close-image" src="{$urls.theme_assets}../templates/mobile/assets/svg/close.svg" width="20" height="20" alt="close {$togglerId}" on="tap:{$togglerId}.close" role="button" tabindex="0"></amp-img>
</div>