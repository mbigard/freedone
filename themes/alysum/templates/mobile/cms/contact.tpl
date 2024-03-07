{*
* 2011-2021 Promokit
*
* @package   pkamp
* @version   2.0
* @author    https://promokit.eu
* @copyright Copyright Ⓒ 2021 promokit.eu <@email:support@promokit.eu>
* @license   GNU General Public License version 2
*}

{extends file='mobile/layouts/layout-main.tpl'}

{block name='head_styles' append}
{literal}
.contact-page input[type="text"],
.contact-page input[type="email"],
.contact-page input[type="file"], .contact-page textarea {
  width:100%;
  padding:10px 20px;
  line-height:20px;
  border:1px solid #e1e1e1;
  font-family:Arial;
  font-size:14px;
  color:#aaa;
  box-sizing: border-box
}
.contact-page select {
  width:100%;
  padding:10px 20px;
}
.contact-form .success-icon {max-width:34px}
.cpf svg {width:20px;height:20px;margin-right:8px}{/literal}
{/block}

{block name='content'}
<section class="contact-form">
  <h2 class="page-title">{l s='Contact us' d='Shop.Theme.Amp'}</h2>
  <div class="contact-page">

    <div class="row contact-page-footer cpf">
      <div class="sect">
          <div class="flex-container align-items-center">
          <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#location"></use></svg>
          <h3>{l s='Our Location' d='Shop.Theme.Amp'}</h3>
          </div>
          <p class='addr'>
          {$shop.address.formatted nofilter}
          </p>
      </div>
      <div class="sect">
        <div class="flex-container align-items-center">
          <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#email"></use></svg>
          <h3>{l s='Contact details' d='Shop.Theme.Amp'}</h3>
        </div>
          <p>
          {l s='Email' d='Shop.Theme.Amp'}: {$shop.email}<br>
          {$shop.registration_number}
          {l s='Phone' d='Shop.Theme.Amp'}: {$shop.phone}<br>
          {if ($shop.fax != "")}
          {l s='Fax' d='Shop.Theme.Amp'}: {$shop.fax}
          {/if}
          </p>
      </div>
      <div class="sect">
        <div class="flex-container align-items-center">
          <svg class="svgic"><use href="{_THEME_DIR_}templates/mobile/assets/svg/lib.svg#headphones"></use></svg>
          <h3>{l s='24/h customer service' d='Shop.Theme.Amp'}</h3>
        </div>
          <p>
          {l s='We providing really fast and professional support' d='Shop.Theme.Amp'}
          </p>
      </div>
    </div>

  {if (isset($page_error) && ($page_error == 1))}
    <div class="notification alert alert-error">
      {l s='Please make sure the module "Contact form" is installed and enabled' d='Shop.Theme.Amp'}
    </div>
  {else}

  <form method="post" action-xhr="{url entity='module' name={$amp.global.name} controller='ajaxContact' relative_protocol=false params=['who' => 'contact']}" target="_top" class="m30" custom-validation-reporting="show-all-on-submit">

    <input type="hidden" name="url" value=""/>
    <input type="hidden" name="token" value="{$token}" />

    <div class="m15">
    <select name="id_contact">
      <option value="" disabled>{l s='Subject Heading' d='Shop.Theme.Amp'}</option>
      {foreach from=$contact.contacts item=contact_elt name=contc}
        <option value="{$contact_elt.id_contact}"{if $smarty.foreach.contc.index == 0} selected{/if}>{$contact_elt.name}</option>
      {/foreach}
    </select>
    </div>

    {if $contact.orders}
    <div class="m15">
    <select name="id_order">
      <option value="">{l s='Select reference' d='Shop.Theme.Amp'}</option>
      {foreach from=$contact.orders item=order}
        <option value="{$order.id_order}">{$order.reference}</option>
      {/foreach}
    </select>
    </div>
    {/if}

    {if Configuration::get('PS_CUSTOMER_SERVICE_FILE_UPLOAD')}
      <div class="m15">
        <input type="file" name="fileUpload" placeholder="{l s='Attach File' d='Shop.Theme.Amp'}" />
      </div>
    {/if}

    <div class="m15">
    <input type="email" id="contact-email" name="from" class="form-control" value="{$contact.email}" required placeholder="{l s='Email address' d='Shop.Theme.Amp'}" />
    <span class="db" visible-when-invalid="valueMissing" validation-for="contact-email">{l s='Email address is empty' d='Shop.Theme.Amp'}</span>
    </div>

    <div class="m15">
    <textarea cols="67" rows="3" id="contact-message" name="message" placeholder="{l s='Message' d='Shop.Theme.Amp'}" required>{if $contact.message}{$contact.message}{/if}</textarea>
    <span class="db" visible-when-invalid="valueMissing" validation-for="contact-message">{l s='A message is empty' d='Shop.Theme.Amp'}</span>
    </div>

    <div class="m15">
      {if isset($contact.gdpr.id_module)}
      {include file='mobile/_partials/gdpr.tpl' gdpr=$contact.gdpr}
      {/if}
    </div>

    <button type="submit" class="btn btn-primary m15" name="submitMessage">
      {l s='Send Message' d='Shop.Theme.Amp'}
    </button>

    <div submit-success class="p0">
      <template type="amp-mustache">
        <div class="flex-container align-items-center success-templ">
        <amp-bodymovin-animation class="success-icon" layout="flex-item" width="34" height="34" src="{$amp.global.assets}json/success.json" loop="false"></amp-bodymovin-animation><div>&nbsp;{literal}{{success}}{/literal}</div>
        </div>
      </template>
    </div>

    <div submit-error class="p0">
        {l s='Something goes wrong. Please try again later' d='Shop.Theme.Amp'}
    </div>
    <div submitting>{l s='Waiting' d='Shop.Theme.Amp'}...</div>
  </form>
  </div>
{/if}
</section>
{/block}