{*
* 2011-2020 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2020 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{if isset($amp.config.general.popup) && $amp.config.general.popup == 1}
<amp-user-notification id="popup-notification" layout="nodisplay" data-persist-dismissal="true">
  <div class="flex-container align-items-center justify-center flex-column"{if (isset($amp.popup.pkpopup_bg))} style="background-image: url('{$amp.popup.pkpopup_bg}')"{/if}>
    {if isset($amp.popup.newsletter) && $amp.popup.newsletter == 1}
    <h4>{l s='Be the first to know' d='Shop.Theme.Amp'}</h4>
    <div>{l s='Subscribe for the latest news and get 15 euro off your first order' d='Shop.Theme.Amp'}</div><br>
    <form class="p2 flex-container flex-column w100" method="POST" target="_top" action-xhr="{if isset($amp.popup.newsletter_url)}{$amp.popup.newsletter_url}{/if}" custom-validation-reporting="show-all-on-submit">

        <div class="ampstart-input inline-block relative m0 p0 mb3 w100 flex-column flex-container align-items-center">
          <label for="as-you-go-email" hidden>{l s='Your Email' d='Shop.Theme.Amp'}</label>
          <input type="email" class="block border-none p0 m20 w100 popup-email" id="as-you-go-email" name="email"
            placeholder="{l s='Your Email' d='Shop.Theme.Amp'}" required aria-label="{l s='Your Email' d='Shop.Theme.Amp'}">
          <span visible-when-invalid="valueMissing" validation-for="as-you-go-email">{l s='Email address is missing' d='Shop.Theme.Amp'}</span>
          <span visible-when-invalid="typeMismatch" validation-for="as-you-go-email">{l s='Wrong email address' d='Shop.Theme.Amp'}</span>
        </div>
        
        <input type="submit" value="{l s='Subscribe' d='Shop.Theme.Amp'}" class="ampstart-btn caps popup-sumbit">

        <div submit-success class="text-center">
          <template type="amp-mustache">
            <span class="{literal}{{state}}{/literal}">{literal}{{text}}{/literal}</span>
          </template>
        </div>

        <div submit-error class="text-center">
          <template type="amp-mustache">
           <span class="{literal}{{state}}{/literal}">{literal}{{text}}{/literal}</span>
          </template>
        </div>

      </form>
    {/if}
    <button on="tap:popup-notification.dismiss" class="ampstart-btn caps ml1 popup-close"><svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#cross"></use></svg></button>
  </div>
</amp-user-notification>
<div class="popup-overlay"></div>
{/if}