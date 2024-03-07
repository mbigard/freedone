{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{if isset($amp.config.general.cookies) && $amp.config.general.cookies == 1}
<amp-user-notification id="cookie-notification" layout="nodisplay">
  <div class="flex-container align-items-center justify-center">
    <span>{l s="This website uses cookies to ensure you get the best experience on our website" d="Shop.Theme.Amp"}.<a rel="noreferrer" href="https://cookiesandyou.com" target="_blank">{l s="Learn more about cookies" d="Shop.Theme.Amp"}</a></span>
    <button on="tap:cookie-notification.dismiss" class="ampstart-btn caps ml1">{l s="I accept" d="Shop.Theme.Amp"}</button>
  </div>
</amp-user-notification>
{/if}