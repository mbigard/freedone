{*
* 2011-2019 Promokit
*
* @package   pk_amp
* @version   1.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2019 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

<div class="gdpr_module">
  <label class="psgdpr_consent_message flex-container">
    <input id="psgdpr_consent_checkbox_{$gdpr.id_module}" name="psgdpr_consent_checkbox" class="gdpr_checkbox" type="checkbox" value="1" required="required">
    <span class="flex-grow1">{$gdpr.consent_message nofilter}</span>
  </label>
  <span class="db" visible-when-invalid="valueMissing" validation-for="psgdpr_consent_checkbox_{$gdpr.id_module}">{l s='You have to agree with out GDPR policy' d='Shop.Theme.Amp'}</span>
</div>